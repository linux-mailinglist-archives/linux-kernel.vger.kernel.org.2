Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79DBB397865
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 18:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234557AbhFAQt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 12:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbhFAQtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 12:49:55 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF10C061574;
        Tue,  1 Jun 2021 09:48:12 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id gb17so22727890ejc.8;
        Tue, 01 Jun 2021 09:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WOOpFeGlUeHFuUxXH9E07hzApnK74f31cpwmZjz5Zko=;
        b=TCYsPhZlkTdt56Sc8WOANos3NIJBG6aRMu3P1GjmG3ZProqmOWonYw4stDOm46sZu6
         Wr7tajYEhyCk/rDNuxzMwZZsse/CP8O+aH+IKMU9if9G2oAlyU5NIgaxfqgHTBi6XuxO
         JyMBr/bxmAJUdorqLZOiG6yTLQmzwa0HSzZn5G+zrYcnozftLdL7ViFi0K2RYRn9bAhA
         ixCytL4YEGNwRsYXUkAe+F7y1M9ozTVim8H0O5ahdmThC+bq0sQVAgt3mqmEPX54zdbx
         rfnRMKvs2TpUJ1Hd3S3LO0gR2vts4cmF9ENeBmllKOgIYrE9PJuwa8Zfl7E48iY6cEr9
         bpmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WOOpFeGlUeHFuUxXH9E07hzApnK74f31cpwmZjz5Zko=;
        b=gVxi1a5DmpJlCjAokv63URadkKHTSTh0+RdnqgIlvFqC6T7QjlbYWOpjZh3waUXAuI
         mtxmsWcfOGjhIg3clEFCF6sDmRVLwih6VK3DrMLNC1Skt8dDgiin6q+1BV2JC/GJI9JB
         UjHuIFeGQTdiadgueBDElotLcA8yP+GfgUQWyEkHh8i1jp9CgcFwvRTYVhBZKGWr6Wn4
         OiByhmml580rilEJr64PYNXVdhYJDdxxU3+nNvlsweUCXns+pZZyAFCnGul3a5iJ87aO
         ACPkdICQXTVYbI5wezmeD4xfyALnn+83HsGSGtelhP5B6df3xcoR7qI20rK/P0SjZidz
         Ab8g==
X-Gm-Message-State: AOAM530sHhWSPNdeEVbLwOwrm4JUqMjw+fVLEG6LrwqB7X0xcoxQO/fc
        Pm5KGHxXlQ6syl0dvj25F5Q=
X-Google-Smtp-Source: ABdhPJyzoB1A9RmPJMtKMwSU6+NKgfxr94jq881eNtKLMY8sLgS/qWtnESQyqvyJ7POkRqj8V9mC2Q==
X-Received: by 2002:a17:906:ccde:: with SMTP id ot30mr30987501ejb.353.1622566091026;
        Tue, 01 Jun 2021 09:48:11 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id q18sm8327750edd.3.2021.06.01.09.48.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jun 2021 09:48:10 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, kishon@ti.com, vkoul@kernel.org,
        t.schramm@manjaro.org, linux-phy@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 1/5] dt-bindings: phy: rename phy nodename in phy-rockchip-inno-usb2.yaml
Date:   Tue,  1 Jun 2021 18:47:56 +0200
Message-Id: <20210601164800.7670-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210601164800.7670-1-jbx6244@gmail.com>
References: <20210601164800.7670-1-jbx6244@gmail.com>
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
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml       | 11 +++--------
 Documentation/devicetree/bindings/soc/rockchip/grf.yaml       |  4 ++--
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml
index a5b027a6e..5bebd86bf 100644
--- a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml
@@ -30,9 +30,6 @@ properties:
   "#clock-cells":
     const: 0
 
-  "#phy-cells":
-    const: 0
-
   clocks:
     maxItems: 1
 
@@ -120,7 +117,6 @@ required:
   - reg
   - clock-output-names
   - "#clock-cells"
-  - "#phy-cells"
   - host-port
   - otg-port
 
@@ -131,26 +127,25 @@ examples:
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

