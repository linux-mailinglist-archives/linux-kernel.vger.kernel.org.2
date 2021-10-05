Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEC2E422855
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 15:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235255AbhJENwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 09:52:08 -0400
Received: from comms.puri.sm ([159.203.221.185]:44068 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235085AbhJENwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 09:52:06 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 5E877E12DE;
        Tue,  5 Oct 2021 06:49:46 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id M5ric_5lU6jh; Tue,  5 Oct 2021 06:49:45 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     martin.kepplinger@puri.sm
Cc:     devicetree@vger.kernel.org, festevam@gmail.com,
        kernel@pengutronix.de, kernel@puri.sm,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, robh@kernel.org, shawnguo@kernel.org,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
Subject: [PATCH v2 7/7] arm64: dts: imx8mq-librem5: set debounce interval of volume buttons to 50ms
Date:   Tue,  5 Oct 2021 15:49:02 +0200
Message-Id: <20211005134902.2138731-8-martin.kepplinger@puri.sm>
In-Reply-To: <20211005134902.2138731-1-martin.kepplinger@puri.sm>
References: <20211005134902.2138731-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>

The default of 5ms is too low.

Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
---
 arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
index d86486fd659d..60d47c71499b 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
@@ -40,12 +40,14 @@ vol-down {
 			label = "VOL_DOWN";
 			gpios = <&gpio1 17 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEDOWN>;
+			debounce-interval = <50>;
 		};
 
 		vol-up {
 			label = "VOL_UP";
 			gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEUP>;
+			debounce-interval = <50>;
 		};
 	};
 
-- 
2.30.2

