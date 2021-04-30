Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2DD236FFF8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 19:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbhD3Rvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 13:51:38 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52192 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbhD3Rvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 13:51:36 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 1BF6F1F40897
Received: by jupiter.universe (Postfix, from userid 1000)
        id 028F84800C6; Fri, 30 Apr 2021 19:50:45 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Ian Ray <ian.ray@ge.com>, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, kernel@collabora.com
Subject: [PATCHv5 2/2] ARM: dts: imx53-ppd: add dma-info nodes
Date:   Fri, 30 Apr 2021 19:50:38 +0200
Message-Id: <20210430175038.103226-3-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210430175038.103226-1-sebastian.reichel@collabora.com>
References: <20210430175038.103226-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabien Lahoudere <fabien.lahoudere@collabora.com>

GEHC CS ONE (codename is PPD), has multiple microcontrollers connected
via UART controlling. UART2 is connected to an on-board microcontroller
at 19200 baud, which constantly pushes critical data (so aging character
detect interrupt will never trigger). This data must be processed at
50-200 Hz, so UART should return data in less than 5-20ms. With 1024
byte DMA buffer (and a constant data stream) the read operation instead
needs 1024 byte / 19200 baud = 53.333ms, which is way too long (note:
Worst case would be remote processor sending data with short pauses <=
7 characters, which would further increase this number). The current
downstream kernel instead configures 24 bytes resulting in 1.25ms, but
that is obviously not sensible for normal UART use cases and cannot be
used as new default.

The same device also has another microcontroller with a 4M baud connected
to UART5 exchanging lots of data. For this the same mechanism can be used
to increase the buffer size (downstream uses 4K instead of the default 1K)
with potentially slightly reduced buffer count. At this baud rate latency
is not an issue (4096 byte / 4M baud = 0.977 ms). Before increasing the
default buffer count from 4 to 16 in 76c38d30fee7, this was required to
avoid data loss. With the changed default it's a performance optimization.

Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
[replace commit message]
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm/boot/dts/imx53-ppd.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx53-ppd.dts b/arch/arm/boot/dts/imx53-ppd.dts
index be040b6a02fa..5a5fa6190a52 100644
--- a/arch/arm/boot/dts/imx53-ppd.dts
+++ b/arch/arm/boot/dts/imx53-ppd.dts
@@ -651,6 +651,7 @@ &uart1 {
 &uart2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart2>;
+	fsl,dma-info = <24 20>;
 	status = "okay";
 };
 
@@ -670,6 +671,7 @@ &uart4 {
 &uart5 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart5>;
+	fsl,dma-info = <4096 4>;
 	status = "okay";
 };
 
-- 
2.30.2

