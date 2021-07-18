Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFAD63CCA21
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jul 2021 19:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbhGRRk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 13:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbhGRRkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 13:40:35 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1F6C061762;
        Sun, 18 Jul 2021 10:37:36 -0700 (PDT)
Received: from dslb-178-004-206-019.178.004.pools.vodafone-ip.de ([178.4.206.19] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1m5AjL-0006oR-Uf; Sun, 18 Jul 2021 19:37:32 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 07/10] staging: rtl8188eu: remove unused power flows and transitions
Date:   Sun, 18 Jul 2021 19:36:07 +0200
Message-Id: <20210718173610.894-7-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210718173610.894-1-martin@kaiser.cx>
References: <20210718173610.894-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver defines a couple of "flows" to move the chip into a certain
power state. Each flow is a sequence of "transitions".

This patch removes flows and transitions which are not used.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/rtl8188eu/hal/pwrseq.c        |  52 --------
 drivers/staging/rtl8188eu/include/pwrseq.h    | 112 ------------------
 .../staging/rtl8188eu/include/rtl8188e_hal.h  |   6 -
 3 files changed, 170 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/pwrseq.c b/drivers/staging/rtl8188eu/hal/pwrseq.c
index f7890a8f4673..80bf9692844f 100644
--- a/drivers/staging/rtl8188eu/hal/pwrseq.c
+++ b/drivers/staging/rtl8188eu/hal/pwrseq.c
@@ -17,13 +17,6 @@ struct wl_pwr_cfg rtl8188E_power_on_flow[RTL8188E_TRANS_CARDEMU_TO_ACT_STEPS +
 	RTL8188E_TRANS_END
 };
 
-/* 3Radio off Array */
-struct wl_pwr_cfg rtl8188E_radio_off_flow[RTL8188E_TRANS_ACT_TO_CARDEMU_STEPS +
-					  RTL8188E_TRANS_END_STEPS] = {
-	RTL8188E_TRANS_ACT_TO_CARDEMU
-	RTL8188E_TRANS_END
-};
-
 /* 3Card Disable Array */
 struct wl_pwr_cfg rtl8188E_card_disable_flow
 	[RTL8188E_TRANS_ACT_TO_CARDEMU_STEPS +
@@ -34,43 +27,6 @@ struct wl_pwr_cfg rtl8188E_card_disable_flow
 		RTL8188E_TRANS_END
 };
 
-/* 3 Card Enable Array */
-struct wl_pwr_cfg rtl8188E_card_enable_flow
-	[RTL8188E_TRANS_ACT_TO_CARDEMU_STEPS +
-	 RTL8188E_TRANS_CARDEMU_TO_PDN_STEPS +
-	 RTL8188E_TRANS_END_STEPS] = {
-		RTL8188E_TRANS_CARDDIS_TO_CARDEMU
-		RTL8188E_TRANS_CARDEMU_TO_ACT
-		RTL8188E_TRANS_END
-};
-
-/* 3Suspend Array */
-struct wl_pwr_cfg rtl8188E_suspend_flow[RTL8188E_TRANS_ACT_TO_CARDEMU_STEPS +
-					RTL8188E_TRANS_CARDEMU_TO_SUS_STEPS +
-					RTL8188E_TRANS_END_STEPS] = {
-	RTL8188E_TRANS_ACT_TO_CARDEMU
-	RTL8188E_TRANS_CARDEMU_TO_SUS
-	RTL8188E_TRANS_END
-};
-
-/* 3 Resume Array */
-struct wl_pwr_cfg rtl8188E_resume_flow[RTL8188E_TRANS_ACT_TO_CARDEMU_STEPS +
-				       RTL8188E_TRANS_CARDEMU_TO_SUS_STEPS +
-				       RTL8188E_TRANS_END_STEPS] = {
-	RTL8188E_TRANS_SUS_TO_CARDEMU
-	RTL8188E_TRANS_CARDEMU_TO_ACT
-	RTL8188E_TRANS_END
-};
-
-/* 3HWPDN Array */
-struct wl_pwr_cfg rtl8188E_hwpdn_flow[RTL8188E_TRANS_ACT_TO_CARDEMU_STEPS +
-				      RTL8188E_TRANS_CARDEMU_TO_PDN_STEPS +
-				      RTL8188E_TRANS_END_STEPS] = {
-	RTL8188E_TRANS_ACT_TO_CARDEMU
-	RTL8188E_TRANS_CARDEMU_TO_PDN
-	RTL8188E_TRANS_END
-};
-
 /* 3 Enter LPS */
 struct wl_pwr_cfg rtl8188E_enter_lps_flow[RTL8188E_TRANS_ACT_TO_LPS_STEPS +
 					  RTL8188E_TRANS_END_STEPS] = {
@@ -78,11 +34,3 @@ struct wl_pwr_cfg rtl8188E_enter_lps_flow[RTL8188E_TRANS_ACT_TO_LPS_STEPS +
 	RTL8188E_TRANS_ACT_TO_LPS
 	RTL8188E_TRANS_END
 };
-
-/* 3 Leave LPS */
-struct wl_pwr_cfg rtl8188E_leave_lps_flow[RTL8188E_TRANS_LPS_TO_ACT_STEPS +
-					  RTL8188E_TRANS_END_STEPS] = {
-	/* FW behavior */
-	RTL8188E_TRANS_LPS_TO_ACT
-	RTL8188E_TRANS_END
-};
diff --git a/drivers/staging/rtl8188eu/include/pwrseq.h b/drivers/staging/rtl8188eu/include/pwrseq.h
index c4b76064476f..caa6bf71da77 100644
--- a/drivers/staging/rtl8188eu/include/pwrseq.h
+++ b/drivers/staging/rtl8188eu/include/pwrseq.h
@@ -20,27 +20,12 @@
  *	4: LPS--Low Power State
  *	5: SUS--Suspend
  *
- *	The transition from different states are defined below
- *	TRANS_CARDEMU_TO_ACT
- *	TRANS_ACT_TO_CARDEMU
- *	TRANS_CARDEMU_TO_SUS
- *	TRANS_SUS_TO_CARDEMU
- *	TRANS_CARDEMU_TO_PDN
- *	TRANS_ACT_TO_LPS
- *	TRANS_LPS_TO_ACT
- *
- *	TRANS_END
- *
  *   PWR SEQ Version: rtl8188E_PwrSeq_V09.h
  */
 #define RTL8188E_TRANS_CARDEMU_TO_ACT_STEPS	10
 #define RTL8188E_TRANS_ACT_TO_CARDEMU_STEPS	10
-#define RTL8188E_TRANS_CARDEMU_TO_SUS_STEPS	10
-#define RTL8188E_TRANS_SUS_TO_CARDEMU_STEPS	10
 #define RTL8188E_TRANS_CARDEMU_TO_PDN_STEPS	10
-#define RTL8188E_TRANS_PDN_TO_CARDEMU_STEPS	10
 #define RTL8188E_TRANS_ACT_TO_LPS_STEPS		15
-#define RTL8188E_TRANS_LPS_TO_ACT_STEPS		15
 #define RTL8188E_TRANS_END_STEPS		1
 
 #define RTL8188E_TRANS_CARDEMU_TO_ACT					\
@@ -81,30 +66,6 @@
 	{0x0005, PWR_CUT_ALL_MSK, PWR_CMD_POLLING, BIT(1), 0}, \
 	/*wait till 0x04[9] = 0 polling until return 0 to disable*/
 
-#define RTL8188E_TRANS_CARDEMU_TO_SUS					\
-	/* format
-	 * { offset, cut_msk, cmd, msk,
-	 * value },
-	 * comments here
-	 */								\
-	{0x0005, PWR_CUT_ALL_MSK, PWR_CMD_WRITE, BIT(3) | BIT(4), BIT(3)}, \
-	/* 0x04[12:11] = 2b'01enable WL suspend */			\
-	{0x0007, PWR_CUT_ALL_MSK, PWR_CMD_WRITE, 0xFF, BIT(7)}, \
-	/* 0x04[31:30] = 2b'10 enable enable bandgap mbias in suspend */\
-	{0x0041, PWR_CUT_ALL_MSK, PWR_CMD_WRITE, BIT(4), 0}, \
-	/*Clear SIC_EN register 0x40[12] = 1'b0 */			\
-	{0xfe10, PWR_CUT_ALL_MSK, PWR_CMD_WRITE, BIT(4), BIT(4)}, \
-	/*Set USB suspend enable local register  0xfe10[4]=1 */
-
-#define RTL8188E_TRANS_SUS_TO_CARDEMU					\
-	/* format
-	 * { offset, cut_msk, cmd, msk,
-	 * value },
-	 * comments here
-	 */								\
-	{0x0005, PWR_CUT_ALL_MSK, PWR_CMD_WRITE, BIT(3) | BIT(4), 0}, \
-	/*0x04[12:11] = 2b'01enable WL suspend*/
-
 #define RTL8188E_TRANS_CARDEMU_TO_CARDDIS				\
 	/* format
 	 * { offset, cut_msk, cmd, msk,
@@ -122,35 +83,6 @@
 	{0xfe10, PWR_CUT_ALL_MSK, PWR_CMD_WRITE, BIT(4), BIT(4)}, \
 	/*Set USB suspend enable local register  0xfe10[4]=1 */
 
-#define RTL8188E_TRANS_CARDDIS_TO_CARDEMU				\
-	/* format
-	 * { offset, cut_msk, cmd, msk,
-	 * value },
-	 * comments here
-	 */								\
-	{0x0005, PWR_CUT_ALL_MSK, PWR_CMD_WRITE, BIT(3) | BIT(4), 0}, \
-	/*0x04[12:11] = 2b'01enable WL suspend*/
-
-#define RTL8188E_TRANS_CARDEMU_TO_PDN					\
-	/* format
-	 * { offset, cut_msk, cmd, msk,
-	 * value },
-	 * comments here
-	 */								\
-	{0x0006, PWR_CUT_ALL_MSK, PWR_CMD_WRITE, BIT(0), 0}, \
-	/* 0x04[16] = 0*/						\
-	{0x0005, PWR_CUT_ALL_MSK, PWR_CMD_WRITE, BIT(7), BIT(7)}, \
-	/* 0x04[15] = 1*/
-
-#define RTL8188E_TRANS_PDN_TO_CARDEMU					\
-	/* format
-	 * { offset, cut_msk, cmd, msk,
-	 * value },
-	 * comments here
-	 */								\
-	{0x0005, PWR_CUT_ALL_MSK, PWR_CMD_WRITE, BIT(7), 0}, \
-	/* 0x04[15] = 0*/
-
 /* This is used by driver for LPSRadioOff Procedure, not for FW LPS Step */
 #define RTL8188E_TRANS_ACT_TO_LPS					\
 	/* format
@@ -178,31 +110,6 @@
 	{0x0553, PWR_CUT_ALL_MSK, PWR_CMD_WRITE, BIT(5), BIT(5)}, \
 	/*Respond TxOK to scheduler*/
 
-#define RTL8188E_TRANS_LPS_TO_ACT					\
-	/* format
-	 * { offset, cut_msk, cmd, msk,
-	 * value },
-	 * comments here
-	 */								\
-	{0xFE58, PWR_CUT_ALL_MSK, PWR_CMD_WRITE, 0xFF, 0x84}, \
-	/*USB RPWM*/	\
-	{0x0002, PWR_CUT_ALL_MSK, PWR_CMD_DELAY, 0, PWRSEQ_DELAY_MS}, \
-	/*Delay*/	\
-	{0x0008, PWR_CUT_ALL_MSK, PWR_CMD_WRITE, BIT(4), 0}, \
-	/* 0x08[4] = 0 switch TSF to 40M */				\
-	{0x0109, PWR_CUT_ALL_MSK, PWR_CMD_POLLING, BIT(7), 0}, \
-	/* Polling 0x109[7]=0  TSF in 40M */				\
-	{0x0029, PWR_CUT_ALL_MSK, PWR_CMD_WRITE, BIT(6) | BIT(7), 0}, \
-	/* 0x29[7:6] = 2b'00  enable BB clock */			\
-	{0x0101, PWR_CUT_ALL_MSK, PWR_CMD_WRITE, BIT(1), BIT(1)}, \
-	/* 0x101[1] = 1 */						\
-	{0x0100, PWR_CUT_ALL_MSK, PWR_CMD_WRITE, 0xFF, 0xFF}, \
-	/* 0x100[7:0] = 0xFF enable WMAC TRX */				\
-	{0x0002, PWR_CUT_ALL_MSK, \
-	PWR_CMD_WRITE, BIT(1) | BIT(0), BIT(1) | BIT(0)}, \
-	/* 0x02[1:0] = 2b'11 enable BB macro */				\
-	{0x0522, PWR_CUT_ALL_MSK, PWR_CMD_WRITE, 0xFF, 0}, /*.	0x522 = 0*/
-
 #define RTL8188E_TRANS_END						\
 	/* format
 	 * { offset, cut_msk, cmd, msk,
@@ -213,30 +120,11 @@
 
 extern struct wl_pwr_cfg rtl8188E_power_on_flow
 		[RTL8188E_TRANS_CARDEMU_TO_ACT_STEPS + RTL8188E_TRANS_END_STEPS];
-extern struct wl_pwr_cfg rtl8188E_radio_off_flow
-		[RTL8188E_TRANS_ACT_TO_CARDEMU_STEPS + RTL8188E_TRANS_END_STEPS];
 extern struct wl_pwr_cfg rtl8188E_card_disable_flow
 		[RTL8188E_TRANS_ACT_TO_CARDEMU_STEPS +
 		RTL8188E_TRANS_CARDEMU_TO_PDN_STEPS +
 		RTL8188E_TRANS_END_STEPS];
-extern struct wl_pwr_cfg rtl8188E_card_enable_flow
-		[RTL8188E_TRANS_ACT_TO_CARDEMU_STEPS +
-		RTL8188E_TRANS_CARDEMU_TO_PDN_STEPS +
-		RTL8188E_TRANS_END_STEPS];
-extern struct wl_pwr_cfg rtl8188E_suspend_flow[
-		RTL8188E_TRANS_ACT_TO_CARDEMU_STEPS +
-		RTL8188E_TRANS_CARDEMU_TO_SUS_STEPS +
-		RTL8188E_TRANS_END_STEPS];
-extern struct wl_pwr_cfg rtl8188E_resume_flow
-		[RTL8188E_TRANS_ACT_TO_CARDEMU_STEPS +
-		RTL8188E_TRANS_CARDEMU_TO_SUS_STEPS +
-		RTL8188E_TRANS_END_STEPS];
-extern struct wl_pwr_cfg rtl8188E_hwpdn_flow
-		[RTL8188E_TRANS_ACT_TO_CARDEMU_STEPS +
-		RTL8188E_TRANS_CARDEMU_TO_PDN_STEPS + RTL8188E_TRANS_END_STEPS];
 extern struct wl_pwr_cfg rtl8188E_enter_lps_flow
 		[RTL8188E_TRANS_ACT_TO_LPS_STEPS + RTL8188E_TRANS_END_STEPS];
-extern struct wl_pwr_cfg rtl8188E_leave_lps_flow
-		[RTL8188E_TRANS_LPS_TO_ACT_STEPS + RTL8188E_TRANS_END_STEPS];
 
 #endif /* __HAL8188EPWRSEQ_H__ */
diff --git a/drivers/staging/rtl8188eu/include/rtl8188e_hal.h b/drivers/staging/rtl8188eu/include/rtl8188e_hal.h
index f585cbe21a6f..e508b4b9ef7f 100644
--- a/drivers/staging/rtl8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/rtl8188eu/include/rtl8188e_hal.h
@@ -22,14 +22,8 @@
 
 /* RTL8188E Power Configuration CMDs for USB/SDIO interfaces */
 #define Rtl8188E_NIC_PWR_ON_FLOW		rtl8188E_power_on_flow
-#define Rtl8188E_NIC_RF_OFF_FLOW		rtl8188E_radio_off_flow
 #define Rtl8188E_NIC_DISABLE_FLOW		rtl8188E_card_disable_flow
-#define Rtl8188E_NIC_ENABLE_FLOW		rtl8188E_card_enable_flow
-#define Rtl8188E_NIC_SUSPEND_FLOW		rtl8188E_suspend_flow
-#define Rtl8188E_NIC_RESUME_FLOW		rtl8188E_resume_flow
-#define Rtl8188E_NIC_PDN_FLOW			rtl8188E_hwpdn_flow
 #define Rtl8188E_NIC_LPS_ENTER_FLOW		rtl8188E_enter_lps_flow
-#define Rtl8188E_NIC_LPS_LEAVE_FLOW		rtl8188E_leave_lps_flow
 
 #define DRVINFO_SZ	4 /*  unit is 8bytes */
 #define PageNum_128(_Len)	(u32)(((_Len) >> 7) + ((_Len) & 0x7F ? 1 : 0))
-- 
2.20.1

