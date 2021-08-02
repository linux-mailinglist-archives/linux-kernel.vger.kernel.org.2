Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46B6F3DCE65
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 02:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbhHBAlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 20:41:19 -0400
Received: from foss.arm.com ([217.140.110.172]:57346 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231923AbhHBAlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 20:41:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A0C5D6E;
        Sun,  1 Aug 2021 17:41:03 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C5AA3F66F;
        Sun,  1 Aug 2021 17:41:01 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, Icenowy Zheng <icenowy@aosc.io>,
        Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ondrej Jirman <megous@megous.com>, devicetree@vger.kernel.org
Subject: [PATCH v9 09/11] dt-bindings: arm: sunxi: Add two H616 board compatible strings
Date:   Mon,  2 Aug 2021 01:39:50 +0100
Message-Id: <20210802003952.19942-10-andre.przywara@arm.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20210802003952.19942-1-andre.przywara@arm.com>
References: <20210802003952.19942-1-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/sunxi.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index 889128acf49a..1c557a736d86 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -848,6 +848,11 @@ properties:
           - const: yones-toptech,bs1078-v2
           - const: allwinner,sun6i-a31s
 
+      - description: X96 Mate TV box
+        items:
+          - const: hechuang,x96-mate
+          - const: allwinner,sun50i-h616
+
       - description: Xunlong OrangePi
         items:
           - const: xunlong,orangepi
@@ -948,4 +953,9 @@ properties:
           - const: xunlong,orangepi-zero-plus2-h3
           - const: allwinner,sun8i-h3
 
+      - description: Xunlong OrangePi Zero 2
+        items:
+          - const: xunlong,orangepi-zero2
+          - const: allwinner,sun50i-h616
+
 additionalProperties: true
-- 
2.17.6

