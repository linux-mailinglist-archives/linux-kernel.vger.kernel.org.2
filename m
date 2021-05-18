Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A60D1387E07
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 18:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350996AbhERQ6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 12:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350969AbhERQ63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 12:58:29 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CECC061573;
        Tue, 18 May 2021 09:57:10 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id z12so14215656ejw.0;
        Tue, 18 May 2021 09:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DvNLypjfM9sD8GKMWXOboYCU4E+Qp3/OvFniS6apdzw=;
        b=CS2WEw9XafuQfNap4nHYlnZ7RfKYQbgqhXxUJfjnVJt4KcRqlFEOPE6XZ/Equ33tPz
         PGNKCPLJwlTc8Z+U92IYORstjt4xATQdAbbzIiYdeoJ63NBDlvu5Av1+NRFfC3zfGwuC
         fINEbFPFsnRnlk+rEApSsukd7DtQ5RYLKSxZx34KjbqRXccGhFjVgHlwktJGLhrsnmSA
         setMiXnrEPXylTOPd1vOpuXCJ07SAWe3oeVWgKdDh+9I+UTdeih/RajaXTP+jHfiYR9+
         qmTUMIGWMi3TvEGZq+FI84IrbemrGmP+nGX5JARBSnezDH19c2yHnOJi2ZoQfhumocHS
         Y6Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DvNLypjfM9sD8GKMWXOboYCU4E+Qp3/OvFniS6apdzw=;
        b=TLOLhOktP7UOrFL+TLGlErON/d6aT9To/L7jKz69HhbjXtAUIUEFwNvBbvt3g+RRf+
         H+14okWOE1X6BeWvVa2xxSmRNtqUVwFgcbd497lKWoAdVsCVuUl/vbzZAc3AWcAlnpZH
         PmFNOpBmA9YxrMy5oOFhD5xGf51HIYYj4X56e0XE6AZv8nzCPAUvSIpSvqQH7wIVNMTS
         PPyvBcUyiOcfJtyf0Z/TRZWSGxw6xcBy5l8/wj6cyz3uU+gf2inonVUSflsO/R4VXySQ
         nxAiVjuBkmwSyislsvVS6bJ1XBWMHWjP8QcSLAfAXTJ0YWGXH/sbEkFluP1s93Jsuews
         2ZRw==
X-Gm-Message-State: AOAM530SanR3UFKR4r1WTHqKJr26eWxyIZJt9VpFF5wCoCa8Yu1/sbcI
        39X/E0ghiWceQq9dLkc/Pdo=
X-Google-Smtp-Source: ABdhPJxtLBuRUVWJbVozy8aPZxKBVlLapGT+U169YFlwxZTcKYp1Fo37AV4yJ2yK4dRmarDP8rTT+g==
X-Received: by 2002:a17:906:17cc:: with SMTP id u12mr6912213eje.170.1621357029653;
        Tue, 18 May 2021 09:57:09 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id n2sm13525676edi.32.2021.05.18.09.57.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 May 2021 09:57:09 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, kishon@ti.com, vkoul@kernel.org,
        linux-phy@lists.infradead.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/4] dt-bindings: phy: rename phy nodename in phy-rockchip-inno-usb2.yaml
Date:   Tue, 18 May 2021 18:56:56 +0200
Message-Id: <20210518165658.12764-3-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210518165658.12764-1-jbx6244@gmail.com>
References: <20210518165658.12764-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pattern: "^(|usb-|usb2-|usb3-|pci-|pcie-|sata-)phy(@[0-9a-f,]+)*$"
in phy-provider.yaml has required "#phy-cells" for phy nodes.
The "phy-cells" in rockchip-inno-usb2 nodes are located in subnodes.
Rename the nodename to pattern "usb2phy@[0-9a-f]+$" to prevent
notifications. Remove unneeded "#phy-cells" from parent node.
Also sort example.

make ARCH=arm dtbs_check
DT_SCHEMA_FILES=~/.local/lib/python3.5/site-packages/dtschema/schemas/
phy/phy-provider.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 .../devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml       | 11 +++--------
 Documentation/devicetree/bindings/soc/rockchip/grf.yaml       |  4 ++--
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml
index fb29ad807..fbe860fff 100644
--- a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml
@@ -29,9 +29,6 @@ properties:
   "#clock-cells":
     const: 0
 
-  "#phy-cells":
-    const: 0
-
   clocks:
     maxItems: 1
 
@@ -119,7 +116,6 @@ required:
   - reg
   - clock-output-names
   - "#clock-cells"
-  - "#phy-cells"
   - host-port
   - otg-port
 
@@ -130,26 +126,25 @@ examples:
     #include <dt-bindings/clock/rk3399-cru.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     #include <dt-bindings/interrupt-controller/irq.h>
-    u2phy0: usb2-phy@e450 {
+    u2phy0: usb2phy@e450 {
       compatible = "rockchip,rk3399-usb2phy";
       reg = <0xe450 0x10>;
       clocks = <&cru SCLK_USB2PHY0_REF>;
       clock-names = "phyclk";
       clock-output-names = "clk_usbphy0_480m";
       #clock-cells = <0>;
-      #phy-cells = <0>;
 
       u2phy0_host: host-port {
-        #phy-cells = <0>;
         interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH 0>;
         interrupt-names = "linestate";
+        #phy-cells = <0>;
       };
 
       u2phy0_otg: otg-port {
-        #phy-cells = <0>;
         interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH 0>,
                      <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH 0>,
                      <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH 0>;
         interrupt-names = "otg-bvalid", "otg-id", "linestate";
+        #phy-cells = <0>;
       };
     };
diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
index 84bdaf88d..43c288708 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
@@ -184,7 +184,7 @@ allOf:
         - "#size-cells"
 
       patternProperties:
-        "usb2-phy@[0-9a-f]+$":
+        "usb2phy@[0-9a-f]+$":
           type: object
 
           $ref: "/schemas/phy/phy-rockchip-inno-usb2.yaml#"
@@ -233,7 +233,7 @@ examples:
         #phy-cells = <0>;
       };
 
-      u2phy0: usb2-phy@e450 {
+      u2phy0: usb2phy@e450 {
         compatible = "rockchip,rk3399-usb2phy";
         reg = <0xe450 0x10>;
         clocks = <&cru SCLK_USB2PHY0_REF>;
-- 
2.11.0

