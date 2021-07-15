Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B12C03C996A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 09:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239262AbhGOHOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 03:14:07 -0400
Received: from smtp1.hiworks.co.kr ([121.254.168.204]:31362 "EHLO
        smtp1.hiworks.co.kr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236815AbhGOHOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 03:14:06 -0400
Received: (qmail 124937 invoked from network); 15 Jul 2021 16:11:10 +0900
Received: from unknown (HELO hiworks.co.kr) (192.168.10.180)
        by 0 (qmail 1.03 + ejcp v14) with SMTP;
        15 Jul 2021 16:11:10 +0900
Received: (qmail 192802 invoked from network); 15 Jul 2021 16:11:11 +0900
Received: from unknown (HELO localhost.localdomain) (tykwon@m2i.co.kr@58.75.176.98)
        by 0 (qmail 1.03 + ejcp v14) with SMTP;
        15 Jul 2021 16:11:11 +0900
X-Authinfo: HIWORKS SMTP authenticated <tykwon@m2i.co.kr|58.75.176.98|tykwon@m2i.co.kr|210715161111_7349191945>
From:   Kwon Tae-young <tykwon@m2i.co.kr>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     Kwon Tae-young <tykwon@m2i.co.kr>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: imx8mq-evk: Remove unnecessary blank lines
Date:   Thu, 15 Jul 2021 16:07:49 +0900
Message-Id: <20210715070749.13552-1-tykwon@m2i.co.kr>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unnecessary blank lines do NOT help readability, so remove them.

Signed-off-by: Kwon Tae-young <tykwon@m2i.co.kr>
---
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
index 4d2035e3dd7c..c6792d797336 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -423,7 +423,6 @@
 		fsl,pins = <
 			MX8MQ_IOMUXC_GPIO1_IO13_GPIO1_IO13		0x19
 		>;
-
 	};
 
 	pinctrl_fec1: fec1grp {
@@ -480,7 +479,6 @@
 			MX8MQ_IOMUXC_NAND_DATA01_QSPI_A_DATA1	0x82
 			MX8MQ_IOMUXC_NAND_DATA02_QSPI_A_DATA2	0x82
 			MX8MQ_IOMUXC_NAND_DATA03_QSPI_A_DATA3	0x82
-
 		>;
 	};
 
-- 
2.17.1

