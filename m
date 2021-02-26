Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 192D432621C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 12:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhBZLrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 06:47:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbhBZLqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 06:46:53 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391A2C06174A;
        Fri, 26 Feb 2021 03:46:13 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id u4so13423338lfs.0;
        Fri, 26 Feb 2021 03:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dOOeG6TMspF1gCesWUxh5qP32jy7kimqL06Y3Z/+g/0=;
        b=LMeyElHgXJMq/n3KGHi7CwAb+AT/GeHbpnpavrbzv2V4TfUfC2u2vsQ2J0q08NOgdk
         VWH33UZ4Pja0xSe8iDVWlkmZWHy3LfM0rm4TfNgasdewZKG3adNR9UCgD5GRJee7dBgy
         fUw1bKFfDhXEn9ic0iUmSo6lF2mXz91yV1IyZ2ocKc2Iip/WNeZ9cQaqmQ4k325uGrFQ
         aKtT7MSiaRfKh92OwVIm8udRd/bbWH1A89SX/fVtO7wM90ChZQNAyF25GaoGrQ6s9myU
         IDNyPtXOG5aAtThvo8PoAOFFGBT1GLnK81QJ4K0aKOWwnenAuiY1JQVi7xRQ//dTEFQp
         brdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dOOeG6TMspF1gCesWUxh5qP32jy7kimqL06Y3Z/+g/0=;
        b=jGxc/M7g/t9l29Und/QC/lnKtHvCWJixWLFABsYjs3VP+xDpS/K8sNSTzPASzOYfI7
         VxOXHClxGaXBTVR1tuUEqXn74vxPCjEZSzMcn+uqd75+9k9k8jENsAwqrLjCR5NpHGDy
         ynxCe0s7TFGyUsBkS7nXqi/d6H80WpOjkPasj+yaVK2RmlEDM8C4kzR4u7MbB8yWlLvH
         LU675SrUTYAltRZXsUA3qyPYinK1pvMQkFYZI+iTdItDP0oalJXbD2u7tbTrRrJ0/afI
         qYAtWWLmkFEA2XLb9RYLgPB2F9MMoKcZgP1q9p+pegF/NPlnnHH26tab7/qCP0G14WOe
         PjZw==
X-Gm-Message-State: AOAM530JryyNzwBq6JX6ViB4NrrBVcw0+91D2lbtk8xj5cBLMopt/1Ia
        CJ4v/+snqoTr8FnWA5MNzeGrs0rEnk4=
X-Google-Smtp-Source: ABdhPJygy0iumYKk1D4FSvqGrmd3jVfl569c0HDcnmkhlMws9Tq2028fEcH89BkPhCI1Y6V+u8FsLw==
X-Received: by 2002:a05:6512:12c2:: with SMTP id p2mr1480976lfg.339.1614339971776;
        Fri, 26 Feb 2021 03:46:11 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id f16sm1380475lfk.217.2021.02.26.03.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 03:46:11 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vivek Unune <npcomplete13@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 2/3] dt-bindings: phy: brcm,ns-usb2-phy: bind single CRU reg
Date:   Fri, 26 Feb 2021 12:45:00 +0100
Message-Id: <20210226114501.31086-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210226114501.31086-1-zajec5@gmail.com>
References: <20210226114501.31086-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

The old binding was using whole DMU space. It was an overkill. DMU is a
big block which contains e.g. CRU which contains e.g. PLLs, PHY, pinctrl
and thermal blocks.

Rework the binding to directly use a single CRU register that controls
USB 2.0 PHY. It's still required to reference CRU generic clkset
register so add a syscon for that.

For a full DMU & CRU description see arch/arm/boot/dts/bcm5301x.dtsi .

The old binding is deprecated now.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
This has been verified using dt_binding_check

I'd really like to get Rob's ack to make sure I don't do anything stupid

It's a reworked version of my abonded 2019 patch:
[PATCH V2 1/2] dt-bindings: bcm-ns-usb2-phy: rework binding to use CRU syscon
https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20190108123907.19816-1-zajec5@gmail.com/
---
 .../bindings/phy/brcm,ns-usb2-phy.yaml        | 46 +++++++++++++++----
 1 file changed, 36 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/brcm,ns-usb2-phy.yaml b/Documentation/devicetree/bindings/phy/brcm,ns-usb2-phy.yaml
index b8b683ce8fa9..8e056d4d205a 100644
--- a/Documentation/devicetree/bindings/phy/brcm,ns-usb2-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/brcm,ns-usb2-phy.yaml
@@ -16,11 +16,20 @@ properties:
     const: brcm,ns-usb2-phy
 
   reg:
-    maxItems: 1
-    description: DMU (Device Management Unit) address range
+    anyOf:
+      - maxItems: 1
+        description: PHY control register
+      - maxItems: 1
+        description: DMU (Device Management Unit) address range
+        deprecated: true
 
   reg-names:
     const: dmu
+    deprecated: true
+
+  brcm,syscon-clkset:
+    description: phandle to syscon for clkset register
+    $ref: /schemas/types.yaml#/definitions/phandle
 
   clocks:
     maxItems: 1
@@ -34,22 +43,39 @@ properties:
 
 required:
   - reg
-  - reg-names
   - clocks
   - clock-names
   - "#phy-cells"
 
+oneOf:
+  - required:
+      - brcm,syscon-clkset
+  - required:
+      - reg-names
+
 additionalProperties: false
 
 examples:
   - |
     #include <dt-bindings/clock/bcm-nsp.h>
 
-    usb2-phy@1800c000 {
-        compatible = "brcm,ns-usb2-phy";
-        reg = <0x1800c000 0x1000>;
-        reg-names = "dmu";
-        clocks = <&genpll BCM_NSP_GENPLL_USB_PHY_REF_CLK>;
-        clock-names = "phy-ref-clk";
-        #phy-cells = <0>;
+    cru-bus@1800c100 {
+        compatible = "simple-bus";
+        ranges = <0 0x1800c100 0x1a4>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        usb2-phy@64 {
+            compatible = "brcm,ns-usb2-phy";
+            reg = <0x64 0x4>;
+            brcm,syscon-clkset = <&clkset>;
+            clocks = <&genpll BCM_NSP_GENPLL_USB_PHY_REF_CLK>;
+            clock-names = "phy-ref-clk";
+            #phy-cells = <0>;
+        };
+
+        clkset: syscon@80 {
+            compatible = "brcm,cru-clkset", "syscon";
+            reg = <0x80 0x4>;
+        };
     };
-- 
2.26.2

