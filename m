Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8D74501AC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 10:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237433AbhKOJw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 04:52:59 -0500
Received: from soltyk.jannau.net ([144.76.91.90]:56256 "EHLO soltyk.jannau.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230472AbhKOJwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 04:52:34 -0500
X-Greylist: delayed 362 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Nov 2021 04:52:33 EST
Received: from coburn.home.jannau.net (p579ad520.dip0.t-ipconnect.de [87.154.213.32])
        by soltyk.jannau.net (Postfix) with ESMTPSA id 49995261AC0;
        Mon, 15 Nov 2021 10:43:33 +0100 (CET)
From:   Janne Grunau <j@jannau.net>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] arm64: dts: apple: change ethernet0 device type to ethernet
Date:   Mon, 15 Nov 2021 10:43:32 +0100
Message-Id: <20211115094332.13540-1-j@jannau.net>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes make dtbs_check errors for t8103-j274.dts due to missing pci
properties.

Signed-off-by: Janne Grunau <j@jannau.net>
---8<---

change based on the same pattern as in
arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts

---
 arch/arm64/boot/dts/apple/t8103-j274.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/apple/t8103-j274.dts b/arch/arm64/boot/dts/apple/t8103-j274.dts
index 33a80f9501dc..02c36301e985 100644
--- a/arch/arm64/boot/dts/apple/t8103-j274.dts
+++ b/arch/arm64/boot/dts/apple/t8103-j274.dts
@@ -60,7 +60,7 @@ &port01 {
 
 &port02 {
 	bus-range = <3 3>;
-	ethernet0: pci@0,0 {
+	ethernet0: ethernet@0,0 {
 		reg = <0x30000 0x0 0x0 0x0 0x0>;
 		/* To be filled by the loader */
 		local-mac-address = [00 10 18 00 00 00];
-- 
2.33.1

