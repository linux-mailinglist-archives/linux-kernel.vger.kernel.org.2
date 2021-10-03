Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE11E4203C1
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 21:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbhJCT3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 15:29:15 -0400
Received: from ixit.cz ([94.230.151.217]:40574 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231280AbhJCT3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 15:29:13 -0400
Received: from localhost.localdomain (ip-89-176-96-70.net.upcbroadband.cz [89.176.96.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 5883A23B26;
        Sun,  3 Oct 2021 21:27:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1633289240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=hCAUjPHDxeqfRdMgnNt1cmHZgCF0U/aaJ3LZydpKbhA=;
        b=yK9UmMKnlFdWaJGo1TlzDiFOkhIKJzbXQEliEKEmbGEhQFJFvMU8hM1y3u13NsmfPD7gJC
        0immSkFoaUz/GMT8OXSzVL0on/XuCCdSgQEMQ2d66vSjnN7C2ztZENgEoxuNPjuLoVAGiM
        1NWWOZmoVv1mvhO1Iy1cCQj1IXlNFEM=
From:   David Heidelberg <david@ixit.cz>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thierry Reding <treding@nvidia.com>,
        David Heidelberg <david@ixit.cz>
Subject: [PATCH] [v2] dt-bindings: clock: tegra: Fix USB controller nodes in examples
Date:   Sun,  3 Oct 2021 21:25:30 +0200
Message-Id: <20211003192529.29615-1-david@ixit.cz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

A subsequent patch will convert the USB controller device tree bindings
to json-schema, which will cause the DT validation to point out various
issues with the examples in the clock and reset controller bindings.

Fix these issues so that the subsequent patch will not cause validation
warnings.

v2:
 - add missing usb-ehci compatible (David)

Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 .../bindings/clock/nvidia,tegra124-car.yaml           | 11 ++++++++---
 .../devicetree/bindings/clock/nvidia,tegra20-car.yaml |  5 +++++
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/nvidia,tegra124-car.yaml b/Documentation/devicetree/bindings/clock/nvidia,tegra124-car.yaml
index ec7ab1483652..b52f3ef059e2 100644
--- a/Documentation/devicetree/bindings/clock/nvidia,tegra124-car.yaml
+++ b/Documentation/devicetree/bindings/clock/nvidia,tegra124-car.yaml
@@ -99,6 +99,7 @@ additionalProperties: false
 examples:
   - |
     #include <dt-bindings/clock/tegra124-car.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
 
     car: clock-controller@60006000 {
         compatible = "nvidia,tegra124-car";
@@ -107,9 +108,13 @@ examples:
         #reset-cells = <1>;
     };
 
-    usb-controller@c5004000 {
-        compatible = "nvidia,tegra20-ehci";
-        reg = <0xc5004000 0x4000>;
+    usb-controller@7d000000 {
+        compatible = "nvidia,tegra124-ehci", "nvidia,tegra30-ehci", "usb-ehci";
+        reg = <0x7d000000 0x4000>;
+        interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
+        phy_type = "utmi";
         clocks = <&car TEGRA124_CLK_USB2>;
         resets = <&car TEGRA124_CLK_USB2>;
+        reset-names = "usb";
+        nvidia,phy = <&phy1>;
     };
diff --git a/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.yaml b/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.yaml
index f832abb7f11a..6386126b45e8 100644
--- a/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.yaml
+++ b/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.yaml
@@ -83,6 +83,7 @@ additionalProperties: false
 examples:
   - |
     #include <dt-bindings/clock/tegra20-car.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
 
     car: clock-controller@60006000 {
         compatible = "nvidia,tegra20-car";
@@ -101,6 +102,10 @@ examples:
     usb-controller@c5004000 {
         compatible = "nvidia,tegra20-ehci";
         reg = <0xc5004000 0x4000>;
+        interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
+        phy_type = "utmi";
         clocks = <&car TEGRA20_CLK_USB2>;
         resets = <&car TEGRA20_CLK_USB2>;
+        reset-names = "usb";
+        nvidia,phy = <&phy1>;
     };
-- 
2.33.0

