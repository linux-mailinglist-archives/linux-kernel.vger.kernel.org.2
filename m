Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3047742B0D4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 02:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237132AbhJMAJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 20:09:02 -0400
Received: from inva021.nxp.com ([92.121.34.21]:33324 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236361AbhJMAI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 20:08:29 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2A34D202E4B;
        Wed, 13 Oct 2021 02:06:26 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E5C85202E43;
        Wed, 13 Oct 2021 02:06:25 +0200 (CEST)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.142])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 6096240A77;
        Tue, 12 Oct 2021 17:06:25 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Li Yang <leoyang.li@nxp.com>, Kuldeep Singh <kuldeep.singh@nxp.com>
Subject: [PATCH v3 17/17] ARM: dts: ls1021a-tsn: use generic "jedec,spi-nor" compatible for flash
Date:   Tue, 12 Oct 2021 18:58:23 -0500
Message-Id: <20211012235824.31096-18-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20211012235824.31096-1-leoyang.li@nxp.com>
References: <20211012235824.31096-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We cannot list all the possible chips used in different board revisions,
just use the generic "jedec,spi-nor" compatible instead.  This also
fixes dtbs_check error:
['jedec,spi-nor', 's25fl256s1', 's25fl512s'] is too long

Signed-off-by: Li Yang <leoyang.li@nxp.com>
Reviewed-by: Kuldeep Singh <kuldeep.singh@nxp.com>
---
 arch/arm/boot/dts/ls1021a-tsn.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ls1021a-tsn.dts b/arch/arm/boot/dts/ls1021a-tsn.dts
index 8005efc5c812..ff0ffb22768b 100644
--- a/arch/arm/boot/dts/ls1021a-tsn.dts
+++ b/arch/arm/boot/dts/ls1021a-tsn.dts
@@ -251,7 +251,7 @@ &qspi {
 
 	flash@0 {
 		/* Rev. A uses 64MB flash, Rev. B & C use 32MB flash */
-		compatible = "jedec,spi-nor", "s25fl256s1", "s25fl512s";
+		compatible = "jedec,spi-nor";
 		spi-max-frequency = <20000000>;
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
2.25.1

