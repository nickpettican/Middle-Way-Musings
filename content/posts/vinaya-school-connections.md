---
title: "Vinaya Schools Network Diagram"
subtitle: "A diagram representing the development of monastic institutions"
excerpt: "This diagram represents a simplified view of Buddhist institutional development. The actual historical development was likely more complex and non-linear though..."
date: 2025-07-11T20:44:41+05:30
author: "Bhikshu Tenpa"
feature_image: "/images/vinaya.png"
og_image: "/images/vinaya.png"
tags: [
    "Vinaya"
]
draft: false
---

This interactive visualization maps the historical development of Buddhist monastic lineages from their original unity to the surviving traditions that guide contemporary Buddhist communities worldwide.

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Buddhist Vinaya Schools Network</title>
    <style>
        .container {
            max-width: 1200px;
            color: #222222;
            margin: 0 auto;
            background: white;
            border-radius: 10px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            overflow: hidden;
        }
        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: #ffffff;
            padding: 20px;
            text-align: center;
        }
        .header h1 {
            color: #ffffff;
            margin: 0;
            font-size: 2em;
            font-weight: 300;
        }
        .header p {
            margin: 5px 0 0 0;
            opacity: 0.9;
            font-size: 0.9em;
        }
        #network {
            width: 100%;
            height: 700px;
            background: #fafafa;
            border: none;
        }
        .controls {
            padding: 20px;
            background: #f8f9fa;
            border-top: 1px solid #e9ecef;
            text-align: center;
        }
        .control-group {
            display: inline-block;
            margin: 0 10px;
        }
        .control-group label {
            display: block;
            font-size: 0.9em;
            color: #6c757d;
            margin-bottom: 5px;
        }
        .control-group input, .control-group select {
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 0.9em;
        }
        .legend {
            padding: 20px;
            background: #f8f9fa;
            border-top: 1px solid #e9ecef;
        }
        .legend h3 {
            margin-top: 0;
            color: #495057;
        }
        .legend-item {
            display: inline-block;
            margin: 5px 15px 5px 0;
            font-size: 0.75em;
        }
        .legend-color {
            display: inline-block;
            width: 20px;
            height: 20px;
            border-radius: 50%;
            margin-right: 8px;
            vertical-align: middle;
            border: 2px solid #fff;
            box-shadow: 0 2px 4px rgba(0,0,0,0.2);
        }
        .note strong {
            color: #111111;
        }
        .note {
            background: #fff3cd;
            border: 1px solid #ffeaa7;
            border-radius: 8px;
            padding: 15px;
            margin: 20px;
            font-size: 0.9em;
            color: #856404;
            line-height: 1.5;
        }
    </style>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/d3/7.8.5/d3.min.js"></script>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Buddhist Vinaya Schools Network</h1>
            <p>Visualisation of Early Buddhist School Development</p>
        </div>
        <div id="network"></div>
        <div class="controls">
            <div class="control-group">
                <label for="physics">Physics Simulation</label>
                <input type="checkbox" id="physics" checked>
            </div>
            <div class="control-group">
                <label for="labels">Show Labels</label>
                <input type="checkbox" id="labels" checked>
            </div>
            <div class="control-group">
                <label for="layout">Layout</label>
                <select id="layout">
                    <option value="hierarchical">Hierarchical</option>
                    <option value="force">Force-directed</option>
                </select>
            </div>
        </div>
        <div class="legend">
            <h3>School Classifications</h3>
            <div class="legend-item">
                <span class="legend-color" style="background-color: #e74c3c;"></span>
                Pre-sectarian Buddhism
            </div>
            <div class="legend-item">
                <span class="legend-color" style="background-color: #3498db;"></span>
                Mahāsāṃghika Branch
            </div>
            <div class="legend-item">
                <span class="legend-color" style="background-color: #2ecc71;"></span>
                Sthavira Branch
            </div>
            <div class="legend-item">
                <span class="legend-color" style="background-color: #f39c12;"></span>
                Sarvāstivāda Sub-schools
            </div>
            <div class="legend-item">
                <span class="legend-color" style="background-color: #9b59b6;"></span>
                Vibhajyavāda Sub-schools
            </div>
            <div class="legend-item">
                <span class="legend-color" style="background-color: #f1c40f;"></span>
                Pudgalavāda Sub-schools
            </div>
            <h3 style="margin-top: 1em;">Other markers</h3>
            <div class="legend-item">
                <span class="legend-color" style="background-color: #ffffff; border: 3px solid #8b2635;"></span>
                Surviving Vinaya Lineages (Mūlasarvāstivāda, Dharmaguptaka, Theravāda)
            </div>
            <div class="legend-item">
                <span class="legend-color" style="background-color: #ffffff; border: 2px dashed #c0392b;"></span>
                Cross-lineage Connections (Alternative origins/absorption)
            </div>
        </div>
        <div class="note">
            <strong>Note:</strong> This diagram represents a simplified view of Buddhist school development. The actual historical development was likely more complex and non-linear. The three highlighted schools (Mūlasarvāstivāda, Dharmaguptaka, and Theravāda) represent the surviving Vinaya lineages that continue to guide monastic communities today, preserving different aspects of the Buddha's monastic discipline.
        </div>
    </div>
    <script>
        const width = 700;
        const height = 700;
        // Create the network data
        const nodes = [
            {id: "mulasarvastivada", name: "Mūlasarvāstivāda", group: "sarvastivada", level: 1},
            {id: "theravada2", name: "Theravāda", group: "vibhajyavada", level: 1},
            {id: "dharmaguptaka1", name: "Dharmaguptaka", group: "sarvastivada", level: 1},
            {id: "theravada1", name: "[Theravāda]", group: "vibhajyavada", level: 3},
            {id: "tambapanniya", name: "Tambapaṇṇiya", group: "vibhajyavada", level: 3},
            {id: "kasyapiya2", name: "Kāśyapīya", group: "vibhajyavada", level: 3},
            {id: "vibhajyavada", name: "Vibhajyavāda", group: "vibhajyavada", level: 4},
            {id: "[mahisasaka]", name: "[Mahīśāsaka]", group: "sarvastivada", level: 2},
            {id: "sautrantika", name: "Sautrāntika", group: "sarvastivada", level: 3},
            {id: "vaibhasika", name: "Vaibhāṣika", group: "sarvastivada", level: 3},
            {id: "mahisasaka1", name: "Mahīśāsaka", group: "sarvastivada", level: 3},
            {id: "haimavata2", name: "Haimavata", group: "sarvastivada", level: 3},
            {id: "kasyapiya1", name: "Kāśyapīya", group: "sarvastivada", level: 3},
            {id: "sarvastivada", name: "Sarvāstivāda", group: "sarvastivada", level: 4},
            {id: "vatsiputriya", name: "Vātsīputrīya", group: "pudgalavada", level: 3},
            {id: "sammitiya", name: "Saṃmitīya", group: "pudgalavada", level: 3},
            {id: "pudgalavada", name: "Pudgalavāda", group: "pudgalavada", level: 4},
            {id: "sthavira", name: "Sthaviras", group: "sthavira", level: 5},
            {id: "lokottaravada", name: "Lokottaravāda", group: "mahasanghika", level: 3},
            {id: "bahusrutiya", name: "Bahuśrutīya", group: "mahasanghika", level: 3},
            {id: "prajnaptivada", name: "Prajñaptivāda", group: "mahasanghika", level: 3},
            {id: "ekavyavahara", name: "Ekavyāvahārika", group: "mahasanghika", level: 4},
            {id: "gokulika", name: "Gokulika", group: "mahasanghika", level: 4},
            {id: "caitika", name: "Caitika", group: "mahasanghika", level: 4},
            {id: "haimavata1", name: "Haimavata", group: "mahasanghika", level: 4},
            {id: "mahasanghika", name: "Mahāsāṃghika", group: "mahasanghika", level: 5},
            {id: "pre-sectarian", name: "Pre-sectarian Buddhism", group: "root", level: 6},
        ];
        const links = [
            {source: "pre-sectarian", target: "mahasanghika"},
            {source: "pre-sectarian", target: "sthavira"},
            {source: "mahasanghika", target: "ekavyavahara"},
            {source: "mahasanghika", target: "gokulika"},
            {source: "mahasanghika", target: "caitika"},
            {source: "mahasanghika", target: "haimavata1"},
            {source: "ekavyavahara", target: "lokottaravada"},
            {source: "gokulika", target: "bahusrutiya"},
            {source: "gokulika", target: "prajnaptivada"},
            {source: "sthavira", target: "pudgalavada"},
            {source: "sthavira", target: "sarvastivada"},
            {source: "sthavira", target: "vibhajyavada"},
            {source: "pudgalavada", target: "vatsiputriya"},
            {source: "pudgalavada", target: "sammitiya"},
            {source: "sarvastivada", target: "haimavata2"},
            {source: "sarvastivada", target: "kasyapiya1"},
            {source: "sarvastivada", target: "mahisasaka1"},
            {source: "sarvastivada", target: "sautrantika"},
            {source: "sarvastivada", target: "mulasarvastivada"},
            {source: "sarvastivada", target: "vaibhasika"},
            {source: "mahisasaka1", target: "dharmaguptaka1"},
            {source: "vibhajyavada", target: "theravada1"},
            {source: "vibhajyavada", target: "tambapanniya"},
            {source: "vibhajyavada", target: "kasyapiya2"},
            {source: "tambapanniya", target: "theravada2"},
            {source: "mahisasaka1", target: "[mahisasaka]"},
            {source: "[mahisasaka]", target: "theravada2"},
            {source: "kasyapiya2", target: "sarvastivada"}
        ];
        const colorScale = d3.scaleOrdinal()
            .domain(["root", "mahasanghika", "sthavira", "sarvastivada", "vibhajyavada", "pudgalavada"])
            .range(["#e74c3c", "#3498db", "#2ecc71", "#f39c12", "#9b59b6", "#f1c40f"]);
        const svg = d3.select("#network")
            .append("svg")
            .attr("width", width)
            .attr("height", height);
        const g = svg.append("g");
        // Add zoom behavior
        const zoom = d3.zoom()
            .scaleExtent([0.3, 3])
            .on("zoom", (event) => {
                g.attr("transform", event.transform);
            });
        svg.call(zoom);
        // Create force simulation
        const simulation = d3.forceSimulation(nodes)
            .force("link", d3.forceLink(links).id(d => d.id).distance(d => {
                if (d.source.id === "sarvastivada" && d.target.id === "mulasarvastivada") {
                    return 160; // Longer distance for this specific connection
                }
                return 80; // Default distance for all other connections
            }))
            .force("charge", d3.forceManyBody().strength(-300))
            .force("center", d3.forceCenter(width / 2, height / 2))
            .force("collision", d3.forceCollide().radius(50));
        // Create links with different styles for cross-lineage connections
        const survivingSchools = ["mulasarvastivada", "dharmaguptaka1", "theravada2"];
        const link = g.append("g")
            .selectAll("line")
            .data(links)
            .enter().append("line")
            .attr("stroke", d => {
                // Highlight cross-lineage connections
                return ((d.source.id === "[mahisasaka]" && d.target.id === "theravada2") ||
                        (d.source.id === "kasyapiya2" && d.target.id === "sarvastivada")) ? "#e74c3c" : "#999";
            })
            .attr("stroke-opacity", d => {
                return ((d.source.id === "[mahisasaka]" && d.target.id === "theravada2") ||
                        (d.source.id === "kasyapiya2" && d.target.id === "sarvastivada")) ? 0.8 : 0.6;
            })
            .attr("stroke-width", d => {
                return ((d.source.id === "[mahisasaka]" && d.target.id === "theravada2") ||
                        (d.source.id === "kasyapiya2" && d.target.id === "sarvastivada")) ? 3 : 2;
            })
            .attr("stroke-dasharray", d => {
                return ((d.source.id === "[mahisasaka]" && d.target.id === "theravada2") ||
                        (d.source.id === "kasyapiya2" && d.target.id === "sarvastivada")) ? "5,5" : "none";
            });
        // Create nodes
        const node = g.append("g")
            .selectAll("circle")
            .data(nodes)
            .enter().append("circle")
            .attr("r", d => survivingSchools.includes(d.id) ? 12 : 8)
            .attr("fill", d => colorScale(d.group))
            .attr("stroke", d => survivingSchools.includes(d.id) ? "#c0392b" : "#fff")
            .attr("stroke-width", d => survivingSchools.includes(d.id) ? 4 : 2)
            .call(d3.drag()
                .on("start", dragstarted)
                .on("drag", dragged)
                .on("end", dragended));
        // Add labels
        const label = g.append("g")
            .selectAll("text")
            .data(nodes)
            .enter().append("text")
            .text(d => d.name)
            .attr("font-size", d => (survivingSchools.includes(d.id) || (d.id === "pre-sectarian")) ? "12px" : "10px")
            .attr("font-weight", d => (survivingSchools.includes(d.id) || (d.id === "pre-sectarian")) ? "bold" : "normal")
            .attr("text-anchor", "middle")
            .attr("dy", "0.35em")
            .attr("fill", "#333")
            .style("pointer-events", "none");
        // Add tooltips
        node.append("title")
            .text(d => d.name);
        // Update positions on simulation tick
        simulation.on("tick", () => {
            link
                .attr("x1", d => d.source.x)
                .attr("y1", d => d.source.y)
                .attr("x2", d => d.target.x)
                .attr("y2", d => d.target.y);
            node
                .attr("cx", d => d.x)
                .attr("cy", d => d.y);
            label
                .attr("x", d => d.x)
                .attr("y", d => d.y + 20);
        });
        // Drag functions
        function dragstarted(event, d) {
            if (!event.active) simulation.alphaTarget(0.3).restart();
            d.fx = d.x;
            d.fy = d.y;
        }
        function dragged(event, d) {
            d.fx = event.x;
            d.fy = event.y;
        }
        function dragended(event, d) {
            if (!event.active) simulation.alphaTarget(0);
            d.fx = null;
            d.fy = null;
        }
        // Control handlers
        document.getElementById('physics').addEventListener('change', function(e) {
            if (e.target.checked) {
                simulation.alpha(1).restart();
            } else {
                simulation.stop();
            }
        });
        document.getElementById('labels').addEventListener('change', function(e) {
            label.style('display', e.target.checked ? 'block' : 'none');
        });
        document.getElementById('layout').addEventListener('change', function(e) {
            if (e.target.value === 'hierarchical') {
                // Arrange nodes in levels
                nodes.forEach(d => {
                    d.x = width / 2 + (Math.random() - 0.5) * 200;
                    d.y = 100 + d.level * 120;
                });
                simulation.alpha(1).restart();
            } else {
                // Force-directed layout
                simulation.alpha(1).restart();
            }
        });
        // Initial centering
        setTimeout(() => {
            const bounds = g.node().getBBox();
            const fullWidth = bounds.width;
            const fullHeight = bounds.height;
            const scale = Math.min(width / fullWidth, height / fullHeight) * 0.8;
            const centerX = bounds.x + fullWidth / 2;
            const centerY = bounds.y + fullHeight / 2;
            svg.transition()
                .duration(750)
                .call(zoom.transform, d3.zoomIdentity
                    .translate(width / 2, height / 2)
                    .scale(scale)
                    .translate(-centerX, -centerY));
        }, 1000);
    </script>
</body>
</html>

## Understanding the Network

This network diagram reveals the complex evolutionary tree of Buddhist monastic traditions from their unified origins to the present day. Beginning with Pre-sectarian Buddhism, the sangha experienced its foundational split into the **Mahāsāṃghika** (Great Assembly) and **Sthavira** (Elder) schools, each developing distinctive approaches to Vinaya interpretation and Buddhist doctrine. The Mahāsāṃghika branch proliferated into various sub-schools including the doctrinally innovative Lokottaravāda, while the Sthavira lineage diversified into three major streams: the **Pudgalavāda** (emphasizing personal continuity), **Sarvāstivāda** (asserting universal existence of phenomena), and **Vibhajyavāda** (the analytical discriminators). Remarkably, the diagram illustrates that only three Vinaya lineages survive as living monastic traditions today: **Mūlasarvāstivāda** (preserved in Tibetan Buddhism with the most extensive textual corpus), **Dharmaguptaka** (maintained throughout East Asian Buddhist countries), and **Theravāda** (continuing in Sri Lankan and Southeast Asian communities). The red dashed connections reveal crucial historical cross-pollinations - notably the absorption of migrant **[Mahīśāsaka]** monks into Sri Lankan Theravāda communities[^1], and the disputed origins of **Kāśyapīya**, which different sources trace to either Sarvāstivāda[^2] or Vibhajyavāda roots[^3]. These cross-lineage connections demonstrate that Buddhist institutional development was not isolated but involved dynamic interactions, migrations, and integrations that shaped the living traditions we inherit today, each preserving unique aspects of the Buddha's original monastic discipline across different cultural and geographical contexts.

[^1]: Warder, A. K. (2000). *Indian Buddhism* (3rd rev. ed.). Delhi: Motilal Banarsidass Publishers Private Ltd; Dutt, Nalinaksha (1998). *Buddhist Sects in India*, pp. 122–123.

[^2]: Geiger, Wilhelm (trans.). *Mahāvaṃsa* (Theravadin account placing Kāśyapīya as Sarvāstivāda offshoot).

[^3]: Baruah, Bibhuti. *Buddhist Sects and Sectarianism* (Mahāsāṃghika account tracing Kāśyapīya to Vibhajyavādins); Yijing. Li Rongxi (translator). *Buddhist Monastic Traditions of Southern Asia* (7th century grouping of Kāśyapīya with Sarvāstivāda sub-sects).
