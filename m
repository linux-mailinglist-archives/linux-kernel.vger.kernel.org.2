Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84F7B3311FB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 16:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbhCHPTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 10:19:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbhCHPSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 10:18:36 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E08C061760;
        Mon,  8 Mar 2021 07:18:35 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 9B8A91F4512F
Received: by jupiter.universe (Postfix, from userid 1000)
        id DDB624800D9; Mon,  8 Mar 2021 16:18:30 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Ian Ray <ian.ray@ge.com>
Subject: [PATCHv2 4/4] ARM: dts: imx: bx50v3: Define GPIO line names
Date:   Mon,  8 Mar 2021 16:18:29 +0100
Message-Id: <20210308151829.60056-5-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210308151829.60056-1-sebastian.reichel@collabora.com>
References: <20210308151829.60056-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ian Ray <ian.ray@ge.com>

Define GPIO line names for b450v3, b650v3, and b850v3.

Signed-off-by: Ian Ray <ian.ray@ge.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm/boot/dts/imx6q-b450v3.dts | 5 +++++
 arch/arm/boot/dts/imx6q-b650v3.dts | 5 +++++
 arch/arm/boot/dts/imx6q-b850v3.dts | 5 +++++
 3 files changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q-b450v3.dts b/arch/arm/boot/dts/imx6q-b450v3.dts
index 604f2420370f..d994b32ad825 100644
--- a/arch/arm/boot/dts/imx6q-b450v3.dts
+++ b/arch/arm/boot/dts/imx6q-b450v3.dts
@@ -84,6 +84,11 @@ lvds0_out: endpoint {
 };
 
 &pca9539 {
+	gpio-line-names = "AMB_P_INT1#", "AMB_P_INT2#", "BT_EN", "WLAN_EN",
+			  "", "SM_D_ACT", "DP1_RST#", "",
+			  "WD15S_EN", "WD15S_DIS#", "", "",
+			  "", "", "", "";
+
 	P04-hog {
 		gpio-hog;
 		gpios = <4 0>;
diff --git a/arch/arm/boot/dts/imx6q-b650v3.dts b/arch/arm/boot/dts/imx6q-b650v3.dts
index 56d2aeb1900c..fa1a1df37cde 100644
--- a/arch/arm/boot/dts/imx6q-b650v3.dts
+++ b/arch/arm/boot/dts/imx6q-b650v3.dts
@@ -84,6 +84,11 @@ lvds0_out: endpoint {
 };
 
 &pca9539 {
+	gpio-line-names = "AMB_P_INT1#", "AMB_P_INT2#", "BT_EN", "WLAN_EN",
+			  "", "SM_D_ACT", "DP1_RST#", "",
+			  "WD15S_EN", "WD15S_DIS#", "", "",
+			  "", "", "", "";
+
 	P07-hog {
 		gpio-hog;
 		gpios = <7 0>;
diff --git a/arch/arm/boot/dts/imx6q-b850v3.dts b/arch/arm/boot/dts/imx6q-b850v3.dts
index 3d6b757bf325..db8c332df6a1 100644
--- a/arch/arm/boot/dts/imx6q-b850v3.dts
+++ b/arch/arm/boot/dts/imx6q-b850v3.dts
@@ -199,6 +199,11 @@ stdp4028_out: endpoint {
 };
 
 &pca9539 {
+	gpio-line-names = "AMB_P_INT1#", "AMB_P_INT2#", "BT_EN", "WLAN_EN",
+			  "REMOTE_ON_PML#", "SM_D_ACT", "DP1_RST#", "DP2_RST#",
+			  "", "", "", "",
+			  "", "", "", "";
+
 	P10-hog {
 		gpio-hog;
 		gpios = <8 0>;
-- 
2.30.1

