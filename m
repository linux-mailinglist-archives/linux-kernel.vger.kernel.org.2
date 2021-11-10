Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEA0F44CC95
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 23:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233930AbhKJWZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 17:25:37 -0500
Received: from inva020.nxp.com ([92.121.34.13]:36246 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233603AbhKJWZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 17:25:25 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 477791A11A3;
        Wed, 10 Nov 2021 23:22:36 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 084AA1A1196;
        Wed, 10 Nov 2021 23:22:36 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.142])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 601D540BD3;
        Wed, 10 Nov 2021 15:22:35 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Ma <peng.ma@nxp.com>,
        Li Yang <leoyang.li@nxp.com>
Subject: [PATCH 06/11] arm64: dts: lx2160a-qds: enable sata nodes
Date:   Wed, 10 Nov 2021 16:21:55 -0600
Message-Id: <20211110222200.6780-7-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20211110222200.6780-1-leoyang.li@nxp.com>
References: <20211110222200.6780-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Ma <peng.ma@nxp.com>

Enables sata support on lx2160a-qds.

Signed-off-by: Peng Ma <peng.ma@nxp.com>
Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 .../arm64/boot/dts/freescale/fsl-lx2160a-qds.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
index 8354af0b31e3..480520152e1a 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
@@ -191,3 +191,19 @@ &usb0 {
 &usb1 {
 	status = "okay";
 };
+
+&sata0 {
+	status = "okay";
+};
+
+&sata1 {
+	status = "okay";
+};
+
+&sata2 {
+	status = "okay";
+};
+
+&sata3 {
+	status = "okay";
+};
-- 
2.25.1

