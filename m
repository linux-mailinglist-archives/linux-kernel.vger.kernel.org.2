Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B13B3061F0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 18:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235428AbhA0R04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 12:26:56 -0500
Received: from foss.arm.com ([217.140.110.172]:56392 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234993AbhA0R0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 12:26:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0522911FB;
        Wed, 27 Jan 2021 09:25:50 -0800 (PST)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E0013F66E;
        Wed, 27 Jan 2021 09:25:47 -0800 (PST)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Samuel Holland <samuel@sholland.org>,
        Icenowy Zheng <icenowy@aosc.io>, Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
        Shuosheng Huang <huangshuosheng@allwinnertech.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v5 01/20] dt-bindings: clk: sunxi-ccu: Add compatible string for Allwinner H616
Date:   Wed, 27 Jan 2021 17:24:41 +0000
Message-Id: <20210127172500.13356-2-andre.przywara@arm.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20210127172500.13356-1-andre.przywara@arm.com>
References: <20210127172500.13356-1-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Maxime Ripard <mripard@kernel.org>
---
 .../devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml    | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml b/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml
index 3b45344ed758..a27025cd3909 100644
--- a/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml
+++ b/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml
@@ -41,6 +41,8 @@ properties:
       - allwinner,sun50i-h5-ccu
       - allwinner,sun50i-h6-ccu
       - allwinner,sun50i-h6-r-ccu
+      - allwinner,sun50i-h616-ccu
+      - allwinner,sun50i-h616-r-ccu
       - allwinner,suniv-f1c100s-ccu
       - nextthing,gr8-ccu
 
@@ -82,6 +84,7 @@ if:
         - allwinner,sun50i-a64-r-ccu
         - allwinner,sun50i-a100-r-ccu
         - allwinner,sun50i-h6-r-ccu
+        - allwinner,sun50i-h616-r-ccu
 
 then:
   properties:
@@ -100,6 +103,7 @@ else:
         enum:
           - allwinner,sun50i-a100-ccu
           - allwinner,sun50i-h6-ccu
+          - allwinner,sun50i-h616-ccu
 
   then:
     properties:
-- 
2.17.5

