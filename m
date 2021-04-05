Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89DE3354167
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 13:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233749AbhDELHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 07:07:08 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:63801 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233181AbhDELHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 07:07:05 -0400
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 05 Apr 2021 04:06:57 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 05 Apr 2021 04:06:56 -0700
X-QCInternal: smtphost
Received: from mkrishn-linux.qualcomm.com ([10.204.66.35])
  by ironmsg02-blr.qualcomm.com with ESMTP; 05 Apr 2021 16:36:17 +0530
Received: by mkrishn-linux.qualcomm.com (Postfix, from userid 438394)
        id 80FB821B28; Mon,  5 Apr 2021 16:36:15 +0530 (IST)
From:   Krishna Manikandan <mkrishn@codeaurora.org>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krishna Manikandan <mkrishn@codeaurora.org>,
        kalyan_t@codeaurora.org, tanmay@codeaurora.org,
        abhinavk@codeaurora.org, robdclark@gmail.com, swboyd@chromium.org,
        bjorn.andersson@linaro.org, vinod.koul@linaro.org,
        dianders@chromium.org, khsieh@codeaurora.org, robh+dt@kernel.org,
        sean@poorly.run, Chandan Uddaraju <chandanu@codeaurora.org>,
        Vara Reddy <varar@codeaurora.org>
Subject: [PATCH v15 4/4] dt-bindings: msm/dp: Add bindings of MSM DisplayPort controller
Date:   Mon,  5 Apr 2021 16:36:10 +0530
Message-Id: <1617620770-26202-4-git-send-email-mkrishn@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617620770-26202-1-git-send-email-mkrishn@codeaurora.org>
References: <1617620770-26202-1-git-send-email-mkrishn@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for Snapdragon DisplayPort controller driver.

Signed-off-by: Chandan Uddaraju <chandanu@codeaurora.org>
Signed-off-by: Vara Reddy <varar@codeaurora.org>
Signed-off-by: Tanmay Shah <tanmay@codeaurora.org>
Signed-off-by: Kuogee Hsieh <khsieh@codeaurora.org>
Signed-off-by: Krishna Manikandan <mkrishn@codeaurora.org>

Changes in V2:
-Provide details about sel-gpio

Changes in V4:
-Provide details about max dp lanes
-Change the commit text

Changes in V5:
-moved dp.txt to yaml file

Changes in v6:
- Squash all AUX LUT properties into one pattern Property
- Make aux-cfg[0-9]-settings properties optional
- Remove PLL/PHY bindings from DP controller dts
- Add DP clocks description
- Remove _clk suffix from clock names
- Rename pixel clock to stream_pixel
- Remove redundant bindings (GPIO, PHY, HDCP clock, etc..)
- Fix indentation
- Add Display Port as interface of DPU in DPU bindings
  and add port mapping accordingly.

Chages in v7:
- Add dp-controller.yaml file common between multiple SOC
- Rename dp-sc7180.yaml to dp-controller-sc7180.yaml
- change compatible string and add SOC name to it.
- Remove Root clock generator for pixel clock
- Add assigned-clocks and assigned-clock-parents bindings
- Remove redundant properties, descriptions and blank lines
- Add DP port in DPU bindings
- Update depends-on tag in commit message and rebase change accordingly

Changes in v8:
- Add MDSS AHB clock in bindings

Changes in v9:
- Remove redundant reg-name property
- Change assigned-clocks and assigned-clocks-parents counts to 2
- Use IRQ flags in example dts

Changes in v10:
- Change title of this patch as it does not contain PLL bindings anymore
- Remove redundant properties
- Remove use of IRQ flag
- Fix ports property

Changes in v11:
- add ports required of both #address-cells and  #size-cells
- add required operating-points-v2
- add required #sound-dai-cells
- add required power-domains
- update maintainer list

Changes in v12:
- remove soc node from examples (Stephen Boyd)
- split dpu-sc7180.yaml changes to separate patch (Stephen Boyd)

Changes in v13:
- add assigned-clocks
- add assigned-clock-parents
---
 .../bindings/display/msm/dp-controller.yaml        | 162 +++++++++++++++++++++
 1 file changed, 162 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/msm/dp-controller.yaml

diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
new file mode 100644
index 0000000..3a02c6c
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
@@ -0,0 +1,162 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/msm/dp-controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MSM Display Port Controller
+
+maintainers:
+  - Kuogee Hsieh <khsieh@codeaurora.org>
+
+description: |
+  Device tree bindings for DisplayPort host controller for MSM targets
+  that are compatible with VESA DisplayPort interface specification.
+
+properties:
+  compatible:
+    enum:
+      - qcom,sc7180-dp
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: AHB clock to enable register access
+      - description: Display Port AUX clock
+      - description: Display Port Link clock
+      - description: Link interface clock between DP and PHY
+      - description: Display Port Pixel clock
+
+  clock-names:
+    items:
+      - const: core_iface
+      - const: core_aux
+      - const: ctrl_link
+      - const: ctrl_link_iface
+      - const: stream_pixel
+
+  assigned-clocks:
+    items:
+      - description: link clock source
+      - description: pixel clock source
+
+  assigned-clock-parents:
+    items:
+      - description: phy 0 parent
+      - description: phy 1 parent
+
+  phys:
+    maxItems: 1
+
+  phy-names:
+    items:
+      - const: dp
+
+  operating-points-v2:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  "#sound-dai-cells":
+    const: 0
+
+  ports:
+    type: object
+    description: |
+      A ports node with endpoint definitions as defined in
+      Documentation/devicetree/bindings/media/video-interfaces.txt.
+    properties:
+      "#address-cells":
+        const: 1
+
+      "#size-cells":
+        const: 0
+
+      port@0:
+        type: object
+        description: Input endpoint of the controller
+
+      port@1:
+        type: object
+        description: Output endpoint of the controller
+
+    required:
+      - "#address-cells"
+      - "#size-cells"
+
+    additionalProperties: false
+
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - phys
+  - phy-names
+  - "#sound-dai-cells"
+  - power-domains
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/qcom,dispcc-sc7180.h>
+    #include <dt-bindings/power/qcom-aoss-qmp.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
+
+    displayport-controller@ae90000 {
+        compatible = "qcom,sc7180-dp";
+        reg = <0xae90000 0x1400>;
+        interrupt-parent = <&mdss>;
+        interrupts = <12>;
+        clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
+                 <&dispcc DISP_CC_MDSS_DP_AUX_CLK>,
+                 <&dispcc DISP_CC_MDSS_DP_LINK_CLK>,
+                 <&dispcc DISP_CC_MDSS_DP_LINK_INTF_CLK>,
+                 <&dispcc DISP_CC_MDSS_DP_PIXEL_CLK>;
+        clock-names = "core_iface", "core_aux",
+                      "ctrl_link",
+                      "ctrl_link_iface", "stream_pixel";
+
+        assigned-clocks = <&dispcc DISP_CC_MDSS_DP_LINK_CLK_SRC>,
+                          <&dispcc DISP_CC_MDSS_DP_PIXEL_CLK_SRC>;
+
+        assigned-clock-parents = <&dp_phy 0>, <&dp_phy 1>;
+
+        phys = <&dp_phy>;
+        phy-names = "dp";
+
+        #sound-dai-cells = <0>;
+
+        power-domains = <&rpmhpd SC7180_CX>;
+
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+                reg = <0>;
+                endpoint {
+                    remote-endpoint = <&dpu_intf0_out>;
+                };
+            };
+
+            port@1 {
+                reg = <1>;
+                endpoint {
+                    remote-endpoint = <&typec>;
+                };
+            };
+        };
+    };
+...
-- 
2.7.4

