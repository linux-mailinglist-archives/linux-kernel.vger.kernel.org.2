Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5F2306217
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 18:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343879AbhA0Rc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 12:32:59 -0500
Received: from foss.arm.com ([217.140.110.172]:57026 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235240AbhA0RaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 12:30:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ADA0A1516;
        Wed, 27 Jan 2021 09:26:33 -0800 (PST)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B431C3F66E;
        Wed, 27 Jan 2021 09:26:31 -0800 (PST)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Samuel Holland <samuel@sholland.org>,
        Icenowy Zheng <icenowy@aosc.io>, Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
        Shuosheng Huang <huangshuosheng@allwinnertech.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, devicetree@vger.kernel.org
Subject: [PATCH v5 19/20] dt-bindings: arm: sunxi: Add OrangePi Zero 2 binding
Date:   Wed, 27 Jan 2021 17:24:59 +0000
Message-Id: <20210127172500.13356-20-andre.przywara@arm.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20210127172500.13356-1-andre.przywara@arm.com>
References: <20210127172500.13356-1-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/sunxi.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index 08607c7ec1bf..aeb8771b14c4 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -932,4 +932,9 @@ properties:
           - const: xunlong,orangepi-zero-plus2-h3
           - const: allwinner,sun8i-h3
 
+      - description: Xunlong OrangePi Zero 2
+        items:
+          - const: xunlong,orangepi-zero2
+          - const: allwinner,sun50i-h616
+
 additionalProperties: true
-- 
2.17.5

