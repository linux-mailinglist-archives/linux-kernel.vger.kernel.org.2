Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5753CCA23
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jul 2021 19:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbhGRRlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 13:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbhGRRki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 13:40:38 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAFCC061762;
        Sun, 18 Jul 2021 10:37:40 -0700 (PDT)
Received: from dslb-178-004-206-019.178.004.pools.vodafone-ip.de ([178.4.206.19] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1m5AjP-0006oR-G9; Sun, 18 Jul 2021 19:37:35 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 10/10] staging: rtl8188eu: remove cut_mask field from wl_pwr_cfg
Date:   Sun, 18 Jul 2021 19:36:10 +0200
Message-Id: <20210718173610.894-10-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210718173610.894-1-martin@kaiser.cx>
References: <20210718173610.894-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We're no longer matching power transitions and commands against a
power cut version mask.

The cut_mask field from struct wl_pwr_cfg can be removed. It was set to
PWR_CUT_ALL_MSK for all remaining commands.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/rtl8188eu/include/pwrseq.h    | 56 +++++++++----------
 drivers/staging/rtl8188eu/include/pwrseqcmd.h |  1 -
 2 files changed, 28 insertions(+), 29 deletions(-)

diff --git a/drivers/staging/rtl8188eu/include/pwrseq.h b/drivers/staging/rtl8188eu/include/pwrseq.h
index caa6bf71da77..5a7b4206d240 100644
--- a/drivers/staging/rtl8188eu/include/pwrseq.h
+++ b/drivers/staging/rtl8188eu/include/pwrseq.h
@@ -34,21 +34,21 @@
 	 * },
 	 * comment here
 	 */								\
-	{0x0006, PWR_CUT_ALL_MSK, PWR_CMD_POLLING, BIT(1), BIT(1)}, \
+	{0x0006, PWR_CMD_POLLING, BIT(1), BIT(1)}, \
 	/* wait till 0x04[17] = 1    power ready*/	\
-	{0x0002, PWR_CUT_ALL_MSK, PWR_CMD_WRITE, BIT(0) | BIT(1), 0}, \
+	{0x0002, PWR_CMD_WRITE, BIT(0) | BIT(1), 0}, \
 	/* 0x02[1:0] = 0	reset BB*/				\
-	{0x0026, PWR_CUT_ALL_MSK, PWR_CMD_WRITE, BIT(7), BIT(7)}, \
+	{0x0026, PWR_CMD_WRITE, BIT(7), BIT(7)}, \
 	/*0x24[23] = 2b'01 schmit trigger */				\
-	{0x0005, PWR_CUT_ALL_MSK, PWR_CMD_WRITE, BIT(7), 0}, \
+	{0x0005, PWR_CMD_WRITE, BIT(7), 0}, \
 	/* 0x04[15] = 0 disable HWPDN (control by DRV)*/		\
-	{0x0005, PWR_CUT_ALL_MSK, PWR_CMD_WRITE, BIT(4) | BIT(3), 0}, \
+	{0x0005, PWR_CMD_WRITE, BIT(4) | BIT(3), 0}, \
 	/*0x04[12:11] = 2b'00 disable WL suspend*/			\
-	{0x0005, PWR_CUT_ALL_MSK, PWR_CMD_WRITE, BIT(0), BIT(0)}, \
+	{0x0005, PWR_CMD_WRITE, BIT(0), BIT(0)}, \
 	/*0x04[8] = 1 polling until return 0*/				\
-	{0x0005, PWR_CUT_ALL_MSK, PWR_CMD_POLLING, BIT(0), 0}, \
+	{0x0005, PWR_CMD_POLLING, BIT(0), 0}, \
 	/*wait till 0x04[8] = 0*/					\
-	{0x0023, PWR_CUT_ALL_MSK, PWR_CMD_WRITE, BIT(4), 0}, \
+	{0x0023, PWR_CMD_WRITE, BIT(4), 0}, \
 	/*LDO normal mode*/
 
 #define RTL8188E_TRANS_ACT_TO_CARDEMU					\
@@ -57,13 +57,13 @@
 	 * },
 	 * comments here
 	 */								\
-	{0x001F, PWR_CUT_ALL_MSK, PWR_CMD_WRITE, 0xFF, 0}, \
+	{0x001F, PWR_CMD_WRITE, 0xFF, 0}, \
 	/*0x1F[7:0] = 0 turn off RF*/					\
-	{0x0023, PWR_CUT_ALL_MSK, PWR_CMD_WRITE, BIT(4), BIT(4)}, \
+	{0x0023, PWR_CMD_WRITE, BIT(4), BIT(4)}, \
 	/*LDO Sleep mode*/						\
-	{0x0005, PWR_CUT_ALL_MSK, PWR_CMD_WRITE, BIT(1), BIT(1)}, \
+	{0x0005, PWR_CMD_WRITE, BIT(1), BIT(1)}, \
 	/*0x04[9] = 1 turn off MAC by HW state machine*/		\
-	{0x0005, PWR_CUT_ALL_MSK, PWR_CMD_POLLING, BIT(1), 0}, \
+	{0x0005, PWR_CMD_POLLING, BIT(1), 0}, \
 	/*wait till 0x04[9] = 0 polling until return 0 to disable*/
 
 #define RTL8188E_TRANS_CARDEMU_TO_CARDDIS				\
@@ -72,15 +72,15 @@
 	 * value },
 	 * comments here
 	 */								\
-	{0x0026, PWR_CUT_ALL_MSK, PWR_CMD_WRITE, BIT(7), BIT(7)}, \
+	{0x0026, PWR_CMD_WRITE, BIT(7), BIT(7)}, \
 	/*0x24[23] = 2b'01 schmit trigger */				\
-	{0x0005, PWR_CUT_ALL_MSK, PWR_CMD_WRITE, BIT(3) | BIT(4), BIT(3)}, \
+	{0x0005, PWR_CMD_WRITE, BIT(3) | BIT(4), BIT(3)}, \
 	/*0x04[12:11] = 2b'01 enable WL suspend*/			\
-	{0x0007, PWR_CUT_ALL_MSK, PWR_CMD_WRITE, 0xFF, 0}, \
+	{0x0007, PWR_CMD_WRITE, 0xFF, 0}, \
 	/* 0x04[31:30] = 2b'10 enable enable bandgap mbias in suspend */\
-	{0x0041, PWR_CUT_ALL_MSK, PWR_CMD_WRITE, BIT(4), 0}, \
+	{0x0041, PWR_CMD_WRITE, BIT(4), 0}, \
 	/*Clear SIC_EN register 0x40[12] = 1'b0 */			\
-	{0xfe10, PWR_CUT_ALL_MSK, PWR_CMD_WRITE, BIT(4), BIT(4)}, \
+	{0xfe10, PWR_CMD_WRITE, BIT(4), BIT(4)}, \
 	/*Set USB suspend enable local register  0xfe10[4]=1 */
 
 /* This is used by driver for LPSRadioOff Procedure, not for FW LPS Step */
@@ -90,24 +90,24 @@
 	 * value },
 	 * comments here
 	 */								\
-	{0x0522, PWR_CUT_ALL_MSK, PWR_CMD_WRITE, 0xFF, 0x7F},/*Tx Pause*/ \
-	{0x05F8, PWR_CUT_ALL_MSK, PWR_CMD_POLLING, 0xFF, 0}, \
+	{0x0522, PWR_CMD_WRITE, 0xFF, 0x7F},/*Tx Pause*/ \
+	{0x05F8, PWR_CMD_POLLING, 0xFF, 0}, \
 	/*Should be zero if no packet is transmitting*/			\
-	{0x05F9, PWR_CUT_ALL_MSK, PWR_CMD_POLLING, 0xFF, 0}, \
+	{0x05F9, PWR_CMD_POLLING, 0xFF, 0}, \
 	/*Should be zero if no packet is transmitting*/			\
-	{0x05FA, PWR_CUT_ALL_MSK, PWR_CMD_POLLING, 0xFF, 0}, \
+	{0x05FA, PWR_CMD_POLLING, 0xFF, 0}, \
 	/*Should be zero if no packet is transmitting*/			\
-	{0x05FB, PWR_CUT_ALL_MSK, PWR_CMD_POLLING, 0xFF, 0}, \
+	{0x05FB, PWR_CMD_POLLING, 0xFF, 0}, \
 	/*Should be zero if no packet is transmitting*/			\
-	{0x0002, PWR_CUT_ALL_MSK, PWR_CMD_WRITE, BIT(0), 0}, \
+	{0x0002, PWR_CMD_WRITE, BIT(0), 0}, \
 	/*CCK and OFDM are disabled,and clock are gated*/		\
-	{0x0002, PWR_CUT_ALL_MSK, PWR_CMD_DELAY, 0,	PWRSEQ_DELAY_US}, \
+	{0x0002, PWR_CMD_DELAY, 0,	PWRSEQ_DELAY_US}, \
 	/*Delay 1us*/ \
-	{0x0100, PWR_CUT_ALL_MSK, PWR_CMD_WRITE, 0xFF, 0x3F}, \
+	{0x0100, PWR_CMD_WRITE, 0xFF, 0x3F}, \
 	/*Reset MAC TRX*/ \
-	{0x0101, PWR_CUT_ALL_MSK, PWR_CMD_WRITE, BIT(1), 0}, \
+	{0x0101, PWR_CMD_WRITE, BIT(1), 0}, \
 	/*check if removed later*/\
-	{0x0553, PWR_CUT_ALL_MSK, PWR_CMD_WRITE, BIT(5), BIT(5)}, \
+	{0x0553, PWR_CMD_WRITE, BIT(5), BIT(5)}, \
 	/*Respond TxOK to scheduler*/
 
 #define RTL8188E_TRANS_END						\
@@ -116,7 +116,7 @@
 	 * value },
 	 * comments here
 	 */								\
-	{0xFFFF, PWR_CUT_ALL_MSK, PWR_CMD_END, 0, 0},
+	{0xFFFF, PWR_CMD_END, 0, 0},
 
 extern struct wl_pwr_cfg rtl8188E_power_on_flow
 		[RTL8188E_TRANS_CARDEMU_TO_ACT_STEPS + RTL8188E_TRANS_END_STEPS];
diff --git a/drivers/staging/rtl8188eu/include/pwrseqcmd.h b/drivers/staging/rtl8188eu/include/pwrseqcmd.h
index a5eb95fc58b9..bfa0405cccde 100644
--- a/drivers/staging/rtl8188eu/include/pwrseqcmd.h
+++ b/drivers/staging/rtl8188eu/include/pwrseqcmd.h
@@ -33,7 +33,6 @@ enum pwrseq_cmd_delat_unit {
 
 struct wl_pwr_cfg {
 	u16 offset;
-	u8 cut_msk;
 	u8 cmd:4;
 	u8 msk;
 	u8 value;
-- 
2.20.1

