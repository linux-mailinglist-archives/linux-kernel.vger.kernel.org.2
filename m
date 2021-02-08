Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1454F313323
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 14:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbhBHNTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 08:19:30 -0500
Received: from comms.puri.sm ([159.203.221.185]:42306 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229822AbhBHNSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 08:18:04 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 527E7DFF60;
        Mon,  8 Feb 2021 05:16:11 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NtpidQDy1Ug0; Mon,  8 Feb 2021 05:16:10 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, shawnguo@kernel.org, kernel@pengutronix.de,
        festevam@gmail.com
Cc:     kernel@puri.sm, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH 5/5] arm64: dts: imx8mq-librem5-r2: set nearlevel to 120
Date:   Mon,  8 Feb 2021 14:15:27 +0100
Message-Id: <20210208131527.24463-6-martin.kepplinger@puri.sm>
In-Reply-To: <20210208131527.24463-1-martin.kepplinger@puri.sm>
References: <20210208131527.24463-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Birch I can never reach 220 and hence the display would never
turn off. Tests suggest 120 to be a good threshold value for all Birch
devices.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dts
index d77fc5df3f06..73bd431cbd6a 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dts
@@ -25,5 +25,5 @@
 };
 
 &proximity {
-	proximity-near-level = <220>;
+	proximity-near-level = <120>;
 };
-- 
2.20.1

