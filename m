Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9A03062AD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 18:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344241AbhA0Rwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 12:52:46 -0500
Received: from foss.arm.com ([217.140.110.172]:56920 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343748AbhA0R1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 12:27:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4D7D1480;
        Wed, 27 Jan 2021 09:26:21 -0800 (PST)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DCFFF3F66E;
        Wed, 27 Jan 2021 09:26:19 -0800 (PST)
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
Subject: [PATCH v5 14/20] dt-bindings: bus: rsb: Add H616 compatible string
Date:   Wed, 27 Jan 2021 17:24:54 +0000
Message-Id: <20210127172500.13356-15-andre.przywara@arm.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20210127172500.13356-1-andre.przywara@arm.com>
References: <20210127172500.13356-1-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the obvious compatible name to the existing RSB binding, and pair
it with the existing A23 fallback compatible string, as the devices are
compatible.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 .../devicetree/bindings/bus/allwinner,sun8i-a23-rsb.yaml      | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/bus/allwinner,sun8i-a23-rsb.yaml b/Documentation/devicetree/bindings/bus/allwinner,sun8i-a23-rsb.yaml
index 32d33b983d66..3d719f468a5b 100644
--- a/Documentation/devicetree/bindings/bus/allwinner,sun8i-a23-rsb.yaml
+++ b/Documentation/devicetree/bindings/bus/allwinner,sun8i-a23-rsb.yaml
@@ -21,7 +21,9 @@ properties:
     oneOf:
       - const: allwinner,sun8i-a23-rsb
       - items:
-          - const: allwinner,sun8i-a83t-rsb
+          - enum:
+              - allwinner,sun8i-a83t-rsb
+              - allwinner,sun50i-h616-rsb
           - const: allwinner,sun8i-a23-rsb
 
   reg:
-- 
2.17.5

