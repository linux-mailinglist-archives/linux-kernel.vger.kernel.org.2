Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4E244CC8A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 23:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233762AbhKJWZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 17:25:29 -0500
Received: from inva020.nxp.com ([92.121.34.13]:36178 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233524AbhKJWZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 17:25:23 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0CC541A119B;
        Wed, 10 Nov 2021 23:22:35 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C05791A1196;
        Wed, 10 Nov 2021 23:22:34 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.142])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id CFB0340BD3;
        Wed, 10 Nov 2021 15:22:33 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Li Yang <leoyang.li@nxp.com>
Subject: [PATCH 02/11] dt-bindings: fsl,layerscape-dcfg: add missing compatible for lx2160a
Date:   Wed, 10 Nov 2021 16:21:51 -0600
Message-Id: <20211110222200.6780-3-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20211110222200.6780-1-leoyang.li@nxp.com>
References: <20211110222200.6780-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The compatbile string is already in use, fix the chip list in binding to
include it.

Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 .../devicetree/bindings/arm/freescale/fsl,layerscape-dcfg.txt   | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-dcfg.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-dcfg.txt
index b5cb374dc47d..10a91cc8b997 100644
--- a/Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-dcfg.txt
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-dcfg.txt
@@ -8,7 +8,7 @@ Required properties:
   - compatible: Should contain a chip-specific compatible string,
 	Chip-specific strings are of the form "fsl,<chip>-dcfg",
 	The following <chip>s are known to be supported:
-	ls1012a, ls1021a, ls1043a, ls1046a, ls2080a.
+	ls1012a, ls1021a, ls1043a, ls1046a, ls2080a, lx2160a
 
   - reg : should contain base address and length of DCFG memory-mapped registers
 
-- 
2.25.1

