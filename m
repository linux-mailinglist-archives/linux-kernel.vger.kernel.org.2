Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFAD387409
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 10:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347466AbhERIaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 04:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346323AbhERIaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 04:30:17 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DC5C061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 01:28:59 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1liv5x-00074g-4f; Tue, 18 May 2021 10:28:53 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1liv5v-0006o4-MW; Tue, 18 May 2021 10:28:51 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Robin van der Gracht <robin@protonic.nl>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>
Subject: [PATCH v1 6/9] ARM: dts: imx6dl-prtvt7: Enable the VPU
Date:   Tue, 18 May 2021 10:28:47 +0200
Message-Id: <20210518082850.26048-7-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210518082850.26048-1-o.rempel@pengutronix.de>
References: <20210518082850.26048-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robin van der Gracht <robin@protonic.nl>

Enable Video Processing Unit to make accelerated video decoding work.

Signed-off-by: Robin van der Gracht <robin@protonic.nl>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 arch/arm/boot/dts/imx6dl-prtvt7.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl-prtvt7.dts b/arch/arm/boot/dts/imx6dl-prtvt7.dts
index 1626f3704f1b..9b05abe3198f 100644
--- a/arch/arm/boot/dts/imx6dl-prtvt7.dts
+++ b/arch/arm/boot/dts/imx6dl-prtvt7.dts
@@ -299,10 +299,6 @@ &usbh1 {
 	status = "disabled";
 };
 
-&vpu {
-	status = "disabled";
-};
-
 &iomuxc {
 	pinctrl_audmux: audmuxgrp {
 		fsl,pins = <
-- 
2.29.2

