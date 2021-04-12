Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5B9235BAA4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 09:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236817AbhDLHMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 03:12:35 -0400
Received: from cpanel.siel.si ([46.19.9.99]:57236 "EHLO cpanel.siel.si"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229581AbhDLHM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 03:12:28 -0400
X-Greylist: delayed 2830 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Apr 2021 03:12:27 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
         s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=mO+22My/KZ+sO11KQeqXh3U98CwWZ/+qWW87gDzziJM=; b=YTTpOr8G3Qi/HthoQiQqnX+OCI
        s+sB52V8+fZG9d3ERBIe/P4kXs+hfbgiGBpQoidjbMSQzowPTr5B+Hj7OTs/lgvNfemNlApzw+Vvs
        EfhKkhzEfEbLn+b0KPFMP4u2DU/UeMtKOd81SwOPOrf93gS5h4+8AVtwF8LRmMKNNJv0k+5Zxgmi2
        uO2dLlWaNLL0h4hcvd5su4thyu5J1JAhdtHSODKxA25euzjT3Rt9EF+lutxXN7FUX/vGJZL/P1VDw
        DbE2ndESwl8i1WW9e0fG9ThQIecnrg9LKwX0z5PGDJxTKHZWJ3Usne3dBHgw/CIohN22GdXQjIumy
        mskGrahg==;
Received: from [89.212.21.243] (port=47212 helo=localhost.localdomain)
        by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <primoz.fiser@norik.com>)
        id 1lVq0F-00GDwe-ND; Mon, 12 Apr 2021 08:24:55 +0200
From:   Primoz Fiser <primoz.fiser@norik.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Primoz Fiser <primoz.fiser@norik.com>
Subject: [PATCH] ARM: dts: imx6: phyFLEX: Fix UART hardware flow control
Date:   Mon, 12 Apr 2021 08:24:50 +0200
Message-Id: <20210412062450.1430199-2-primoz.fiser@norik.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210412062450.1430199-1-primoz.fiser@norik.com>
References: <20210412062450.1430199-1-primoz.fiser@norik.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: primoz.fiser@norik.com
X-Authenticated-Sender: cpanel.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Serial interface uart3 on phyFLEX board is capable of 5-wire connection
including signals RTS and CTS for hardware flow control.

Fix signals UART3_CTS_B and UART3_RTS_B padmux assignments and add
missing property "uart-has-rtscts" to allow serial interface to be
configured and used with the hardware flow control.

Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
---
 arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
index f28a96fcf23e..3f262e8ebf7f 100644
--- a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
@@ -316,8 +316,8 @@ pinctrl_uart3: uart3grp {
 			fsl,pins = <
 				MX6QDL_PAD_EIM_D24__UART3_TX_DATA	0x1b0b1
 				MX6QDL_PAD_EIM_D25__UART3_RX_DATA	0x1b0b1
-				MX6QDL_PAD_EIM_D30__UART3_RTS_B		0x1b0b1
-				MX6QDL_PAD_EIM_D31__UART3_CTS_B		0x1b0b1
+				MX6QDL_PAD_EIM_D31__UART3_RTS_B		0x1b0b1
+				MX6QDL_PAD_EIM_D30__UART3_CTS_B		0x1b0b1
 			>;
 		};
 
@@ -404,6 +404,7 @@ &reg_soc {
 &uart3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart3>;
+	uart-has-rtscts;
 	status = "disabled";
 };
 
-- 
2.25.1

