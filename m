Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1530D41F038
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 17:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354734AbhJAPDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 11:03:33 -0400
Received: from mail-m17638.qiye.163.com ([59.111.176.38]:45404 "EHLO
        mail-m17638.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbhJAPDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 11:03:31 -0400
Received: from localhost.localdomain (unknown [112.48.80.210])
        by mail-m17638.qiye.163.com (Hmail) with ESMTPA id 588041C00DC;
        Fri,  1 Oct 2021 22:50:48 +0800 (CST)
From:   Chukun Pan <amadeus@jmu.edu.cn>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH] arm64: dts: allwinner: NanoPi R1S H5: use the correct compatible for the eeprom
Date:   Fri,  1 Oct 2021 22:50:36 +0800
Message-Id: <20211001145036.18129-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWRpJTExWTExPGkxOSUxPGU
        1JVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWVVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MRA6OBw*PD4NNzgiAkkRNipJ
        OQoKCx1VSlVKTUhIS0JCQ09CS0pJVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
        SVVPQ1VDS1VJSktZV1kIAVlBSUtJTTcG
X-HM-Tid: 0a7c3c561b9cd993kuws588041c00dc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'microchip,24c02' compatible does not match the at24 driver, so
replace it with 'atmel,24c02'. In addition, because the mac address
is stored on this eeprom, set it to read-only mode.

Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts
index 55bcdf8d1a07..4f01c17c49e0 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts
@@ -142,9 +142,10 @@
 	status = "okay";
 
 	eeprom@51 {
-		compatible = "microchip,24c02";
-		reg = <0x51>;
+		compatible = "atmel,24c02";
 		pagesize = <16>;
+		reg = <0x51>;
+		read-only; /* This holds our MAC */
 	};
 };
 
-- 
2.17.1

