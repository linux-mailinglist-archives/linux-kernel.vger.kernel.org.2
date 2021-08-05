Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EABA3E1CAB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 21:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242985AbhHET1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 15:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242969AbhHET1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 15:27:15 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45863C061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 12:27:00 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id z3-20020a4a98430000b029025f4693434bso1607422ooi.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 12:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gFSpliSaVPYwiY57hji+Jh3DEWnAsAXgq1h9DC5QY4o=;
        b=ZD7cjaG5CpJycz8k5pqVvkDumamTbRU9ZOZuS8KPxx1uGddISemrlbtUNYB4AAGPe4
         CWwp3NKoXn8Wgy3IMNiQKVDisf4+fJJplx2Oyfr0LqatdeFxPQFCA7++TVxOf4+7Dgkz
         YcMD/NzTFgbikDVObhFVRNDBXfB7g+uu+QhoN3qlVS7OJiMRMltebu8E0lmUtyUNtqA4
         GijvSqRK6Q2Ys4cpb3hiQozbqIImSWNXsk+tpGDn/whMw+lwxudOT5tcU5LoiZgM89M7
         UWro8KhpCStrce6wL8RWD2dN45hyDY0QNy9v9nWdBgczKlFUclp2YT46sdJ4Ln2YT1S8
         cbjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=gFSpliSaVPYwiY57hji+Jh3DEWnAsAXgq1h9DC5QY4o=;
        b=aIlSPZyg9GNT3ZKcjEXaPBQMVbq/KAVsYm5iWGsHrxnA4cJMRuEvWdHA2q9JAeVRGn
         cG3ffnaDlAvXGPWg8MPwHsknDqfmJeslkuKE9eKHt58JPdLnubI/Q7H1XLy3+Y3H2Csh
         gFZ5FB5Wn0/I7H7x1WjxtvB8nf+g1rvgy7MAz5CCMNYMztGvCUmGIiu/h2l/uFpANTqc
         8vwY4YyqfSBB/MhMrOCqjUd0J2923FssnI7c1+tu2IWE4XVMDfC9ZuPQjiCba4OaMz4I
         oOYo2uo0g1GsTu/xc4WxNc0NifpssZwqc4b4EgYZ96j3KuRBPxJsxnBpXNNu7sBn3jwI
         rDSA==
X-Gm-Message-State: AOAM5336m34fOEK1/jCC1AkfTSXKNwrD3UQSHR89aJoIYbS4Yua2Ipfm
        7ss1XUBB2ug/Yiw6CKW6uP6zJIP1sj4=
X-Google-Smtp-Source: ABdhPJxtJGy16Z9BavyXXT36gcH31YS87K7VFz1zbBCZhpV3kft5YOV36A1scBRpSDv/FtoQ58ieQg==
X-Received: by 2002:a4a:6042:: with SMTP id t2mr4396927oof.31.1628191619659;
        Thu, 05 Aug 2021 12:26:59 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-1016.res6.spectrum.com.com (2603-8090-2005-39b3-0000-0000-0000-1016.res6.spectrum.com. [2603:8090:2005:39b3::1016])
        by smtp.gmail.com with ESMTPSA id n7sm1143479otf.45.2021.08.05.12.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 12:26:59 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 4/6] staging: r8188eu: Remove wrapper rtw_udelay_os()
Date:   Thu,  5 Aug 2021 14:26:42 -0500
Message-Id: <20210805192644.15978-4-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210805192644.15978-1-Larry.Finger@lwfinger.net>
References: <20210805192644.15978-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This wrapper is a simple call to udelay(). Remove it.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 drivers/staging/r8188eu/core/rtw_efuse.c        | 2 +-
 drivers/staging/r8188eu/hal/HalPwrSeqCmd.c      | 6 +++---
 drivers/staging/r8188eu/hal/odm_interface.c     | 4 ++--
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 2 +-
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c   | 6 +++---
 drivers/staging/r8188eu/hal/rtl8188e_rf6052.c   | 8 ++++----
 drivers/staging/r8188eu/include/osdep_service.h | 2 --
 drivers/staging/r8188eu/os_dep/osdep_service.c  | 5 -----
 8 files changed, 14 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_efuse.c b/drivers/staging/r8188eu/core/rtw_efuse.c
index 3e53ec522519..6e790f529d61 100644
--- a/drivers/staging/r8188eu/core/rtw_efuse.c
+++ b/drivers/staging/r8188eu/core/rtw_efuse.c
@@ -186,7 +186,7 @@ ReadEFuseByte(
 	/*  This fix the problem that Efuse read error in high temperature condition. */
 	/*  Designer says that there shall be some delay after ready bit is set, or the */
 	/*  result will always stay on last data we read. */
-	rtw_udelay_os(50);
+	udelay(50);
 	value32 = rtw_read32(Adapter, EFUSE_CTRL);
 
 	*pbuf = (u8)(value32 & 0xff);
diff --git a/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c b/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
index e092563a3577..37bca779ee00 100644
--- a/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
+++ b/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
@@ -66,7 +66,7 @@ u8 HalPwrSeqCmdParsing(struct adapter *padapter, u8 cut_vers, u8 fab_vers,
 					if (value == (GET_PWR_CFG_VALUE(pwrcfgcmd) & GET_PWR_CFG_MASK(pwrcfgcmd)))
 						poll_bit = true;
 					else
-						rtw_udelay_os(10);
+						udelay(10);
 
 					if (poll_count++ > max_poll_count) {
 						DBG_88E("Fail to polling Offset[%#x]\n", offset);
@@ -76,9 +76,9 @@ u8 HalPwrSeqCmdParsing(struct adapter *padapter, u8 cut_vers, u8 fab_vers,
 				break;
 			case PWR_CMD_DELAY:
 				if (GET_PWR_CFG_VALUE(pwrcfgcmd) == PWRSEQ_DELAY_US)
-					rtw_udelay_os(GET_PWR_CFG_OFFSET(pwrcfgcmd));
+					udelay(GET_PWR_CFG_OFFSET(pwrcfgcmd));
 				else
-					rtw_udelay_os(GET_PWR_CFG_OFFSET(pwrcfgcmd)*1000);
+					udelay(GET_PWR_CFG_OFFSET(pwrcfgcmd)*1000);
 				break;
 			case PWR_CMD_END:
 				/*  When this command is parsed, end the process */
diff --git a/drivers/staging/r8188eu/hal/odm_interface.c b/drivers/staging/r8188eu/hal/odm_interface.c
index a64eeb5ae2e2..239a9703bb34 100644
--- a/drivers/staging/r8188eu/hal/odm_interface.c
+++ b/drivers/staging/r8188eu/hal/odm_interface.c
@@ -132,7 +132,7 @@ void ODM_IsWorkItemScheduled(void *pRtWorkItem)
 /*  ODM Timer relative API. */
 void ODM_StallExecution(u32 usDelay)
 {
-	rtw_udelay_os(usDelay);
+	udelay(usDelay);
 }
 
 void ODM_delay_ms(u32 ms)
@@ -142,7 +142,7 @@ void ODM_delay_ms(u32 ms)
 
 void ODM_delay_us(u32 us)
 {
-	rtw_udelay_os(us);
+	udelay(us);
 }
 
 void ODM_sleep_ms(u32 ms)
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 9b0d02a759a4..732d42ab3e0d 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -533,7 +533,7 @@ static s32 _FWFreeToGo(struct adapter *padapter)
 			DBG_88E("%s: Polling FW ready success!! REG_MCUFWDL:0x%08x\n", __func__, value32);
 			return _SUCCESS;
 		}
-		rtw_udelay_os(5);
+		udelay(5);
 	} while (counter++ < POLLING_READY_TIMEOUT_COUNT);
 
 	DBG_88E("%s: Polling FW ready fail!! REG_MCUFWDL:0x%08x\n", __func__, value32);
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
index 37f2342ddbaa..58d8e0113490 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
@@ -170,12 +170,12 @@ phy_RFSerialRead(
 	tmplong2 = (tmplong2 & (~bLSSIReadAddress)) | (NewOffset<<23) | bLSSIReadEdge;	/* T65 RF */
 
 	PHY_SetBBReg(Adapter, rFPGA0_XA_HSSIParameter2, bMaskDWord, tmplong&(~bLSSIReadEdge));
-	rtw_udelay_os(10);/*  PlatformStallExecution(10); */
+	udelay(10);/*  PlatformStallExecution(10); */
 
 	PHY_SetBBReg(Adapter, pPhyReg->rfHSSIPara2, bMaskDWord, tmplong2);
-	rtw_udelay_os(100);/* PlatformStallExecution(100); */
+	udelay(100);/* PlatformStallExecution(100); */
 
-	rtw_udelay_os(10);/* PlatformStallExecution(10); */
+	udelay(10);/* PlatformStallExecution(10); */
 
 	if (eRFPath == RF_PATH_A)
 		RfPiEnable = (u8)PHY_QueryBBReg(Adapter, rFPGA0_XA_HSSIParameter1, BIT8);
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c b/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
index 335b120ce603..51ac1426adae 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
@@ -482,18 +482,18 @@ static int phy_RF6052_Config_ParaFile(struct adapter *Adapter)
 		}
 		/*----Set RF_ENV enable----*/
 		PHY_SetBBReg(Adapter, pPhyReg->rfintfe, bRFSI_RFENV<<16, 0x1);
-		rtw_udelay_os(1);/* PlatformStallExecution(1); */
+		udelay(1);/* PlatformStallExecution(1); */
 
 		/*----Set RF_ENV output high----*/
 		PHY_SetBBReg(Adapter, pPhyReg->rfintfo, bRFSI_RFENV, 0x1);
-		rtw_udelay_os(1);/* PlatformStallExecution(1); */
+		udelay(1);/* PlatformStallExecution(1); */
 
 		/* Set bit number of Address and Data for RF register */
 		PHY_SetBBReg(Adapter, pPhyReg->rfHSSIPara2, b3WireAddressLength, 0x0);	/*  Set 1 to 4 bits for 8255 */
-		rtw_udelay_os(1);/* PlatformStallExecution(1); */
+		udelay(1);/* PlatformStallExecution(1); */
 
 		PHY_SetBBReg(Adapter, pPhyReg->rfHSSIPara2, b3WireDataLength, 0x0);	/*  Set 0 to 12  bits for 8255 */
-		rtw_udelay_os(1);/* PlatformStallExecution(1); */
+		udelay(1);/* PlatformStallExecution(1); */
 
 		/*----Initialize RF fom connfiguration file----*/
 		switch (eRFPath) {
diff --git a/drivers/staging/r8188eu/include/osdep_service.h b/drivers/staging/r8188eu/include/osdep_service.h
index 16d6df702788..eb993a030953 100644
--- a/drivers/staging/r8188eu/include/osdep_service.h
+++ b/drivers/staging/r8188eu/include/osdep_service.h
@@ -236,8 +236,6 @@ void rtw_usleep_os(int us);
 
 u32  rtw_atoi(u8 *s);
 
-void rtw_udelay_os(int us);
-
 static inline unsigned char _cancel_timer_ex(struct timer_list *ptimer)
 {
 	return del_timer_sync(ptimer);
diff --git a/drivers/staging/r8188eu/os_dep/osdep_service.c b/drivers/staging/r8188eu/os_dep/osdep_service.c
index 99497bb11e0b..2192250f21d4 100644
--- a/drivers/staging/r8188eu/os_dep/osdep_service.c
+++ b/drivers/staging/r8188eu/os_dep/osdep_service.c
@@ -141,11 +141,6 @@ void rtw_usleep_os(int us)
 		msleep((us/1000) + 1);
 }
 
-void rtw_udelay_os(int us)
-{
-	udelay((unsigned long)us);
-}
-
 #define RTW_SUSPEND_LOCK_NAME "rtw_wifi"
 
 static const struct device_type wlan_type = {
-- 
2.32.0

