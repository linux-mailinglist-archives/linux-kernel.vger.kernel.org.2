Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 006533BA46E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 21:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhGBTv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 15:51:58 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:53475 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbhGBTv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 15:51:57 -0400
Received: from mwalle01.fritz.box (ip4d17858c.dynamic.kabel-deutschland.de [77.23.133.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 62DE82224D;
        Fri,  2 Jul 2021 21:49:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1625255363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=1G+uDlz+vA24FK9D18rVmhAhg2oNivclrK25BBxeNOs=;
        b=IS/2AQ9bRVMoA0FVTIblp0tJcpHPgEzkt0063hLxtkB+ziEZxtxVAxBYhE4OG0vDG2oCci
        UVTDUGNgnK+dqH+D/GvVnD8IXHWZtRvc8WoyYg7GS0Y5xpDF/34jU1CT9CaU5xWCc1SHNW
        qkkU+FXaOmHrcaw50LGw4nUBAjAtN4c=
From:   Michael Walle <michael@walle.cc>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH] arm64: dts: ls1028: sl28: fix networking for variant 2
Date:   Fri,  2 Jul 2021 21:49:14 +0200
Message-Id: <20210702194914.10921-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PHY configuration for the variant 2 is still missing the flag for
in-band signalling between PHY and MAC. Both sides - MAC and PHY - have
to match the setting. For now, Linux only supports setting the MAC side
and thus it has to match the setting the bootloader is configuring.
Enable in-band signalling to make ethernet work.

Fixes: ab43f0307449 ("arm64: dts: ls1028a: sl28: add support for variant 2")
Signed-off-by: Michael Walle <michael@walle.cc>
---
What make things worse and why this might slipped through is that the
setting in the PHY is persistent even after a soft reset of the PHY.

 arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var2.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var2.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var2.dts
index dd764b720fb0..f6a79c8080d1 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var2.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var2.dts
@@ -54,6 +54,7 @@
 
 &mscc_felix_port0 {
 	label = "swp0";
+	managed = "in-band-status";
 	phy-handle = <&phy0>;
 	phy-mode = "sgmii";
 	status = "okay";
@@ -61,6 +62,7 @@
 
 &mscc_felix_port1 {
 	label = "swp1";
+	managed = "in-band-status";
 	phy-handle = <&phy1>;
 	phy-mode = "sgmii";
 	status = "okay";
-- 
2.20.1

