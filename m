Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73BC445854D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 18:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238464AbhKURS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 12:18:56 -0500
Received: from soltyk.jannau.net ([144.76.91.90]:53130 "EHLO soltyk.jannau.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238378AbhKURSy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 12:18:54 -0500
Received: from coburn.home.jannau.net (p579ad520.dip0.t-ipconnect.de [87.154.213.32])
        by soltyk.jannau.net (Postfix) with ESMTPSA id 6D529261B2C;
        Sun, 21 Nov 2021 18:15:47 +0100 (CET)
From:   Janne Grunau <j@jannau.net>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>, Marc Zyngier <maz@kernel.org>
Cc:     Mark Kettenis <kettenis@openbsd.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 1/3] arm64: dts: apple: change ethernet0 device type to ethernet
Date:   Sun, 21 Nov 2021 18:15:43 +0100
Message-Id: <20211121171545.27402-2-j@jannau.net>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211121171545.27402-1-j@jannau.net>
References: <20211121171545.27402-1-j@jannau.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes make dtbs_check errors for t8103-j274.dts due to missing pci
properties.

Fixes: e1bebf978151 ("arm64: dts: apple: j274: Expose PCI node for the Ethernet MAC address")
Reviewed-by: Mark Kettenis <kettenis@openbsd.org>
Signed-off-by: Janne Grunau <j@jannau.net>
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
2.34.0

