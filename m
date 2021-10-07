Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B55B4425147
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 12:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241010AbhJGKmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 06:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240907AbhJGKlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 06:41:51 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8985C061760
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 03:39:50 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id u18so17661034wrg.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 03:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GiH9t/SFxpMKdiK3x2qqgNXItsmPKdOUVlby149dByw=;
        b=l4yIhBAmqA9lIuKSJvjB8hiSohkdWKzJrns/FMr1v/xGNIroDPbQPBpMCuWDw0VUtH
         GX+FCw0WE/lX34e8NreCD/XHTQR6SWhFrD1AAKOmhXEVAZQj5yUNyHBDdx12JzTSw9c1
         2NySByYInd+57R//+3qzuTZjVBW/1/EzMYmLywQP3SvtD7cyNaBxx0pe4KbPcNAzUG2S
         5qGuui3VMYrJmlX5rpNk+Jv7PLEQzBqs2RskREeZjL7CPaHRPMmjCEqUI4rKyu0sHFV1
         wpFdOjCsS0DzXESYu4r5LKbPSyN9isBvxuNnbbyKWc31NP5XI8PYiRwl6X8Jcccuq7j2
         k0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GiH9t/SFxpMKdiK3x2qqgNXItsmPKdOUVlby149dByw=;
        b=A10I+ztNzywZZYtvSMd/eb54gwrhzX1TeX+C6LAyaDTwQ9YpFvP3SnaTgGglQg25wr
         Ht+Ji9T3S+LV3q/CRqkSqAYCQT2z147itKVdJ+l8IR9SIvC0gWpE+6HUGsFHv8TYENm2
         zXB+ooPej3pOMpwcYIKU1PC1VrS9AtldQ+NM+2RWWxqQ4T7LR2ijlfc004/QM4YYfyZ5
         ev7Ij9hltSedBJ8Thlgnuy8kq9E6Qw6XhtxfJaMQBBOP11aSgG++5L/kGbEQ4q9+v3t7
         aXO0vOk4KJYfHgOSy7B1Hm1yiW6Tf4GZs8Q2A8IMBpGzQqpeGKQuBZd0RwDvaN6stQV+
         sn0w==
X-Gm-Message-State: AOAM532KvgdIJ+iB12/V3vcv5koD/OclPc9YsH2MQHAa33JxIfxhjFu2
        jnMWftd9R+wQn5g48OCh8YQ=
X-Google-Smtp-Source: ABdhPJxnMUw7lyZkU8Gzag5vhBw5A/iFQKefHfgPoJQHeeq2esq5z+kBWm6Nql9cvwr1H3RgF1IY1A==
X-Received: by 2002:a1c:f405:: with SMTP id z5mr3816479wma.72.1633603189486;
        Thu, 07 Oct 2021 03:39:49 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::5d0b])
        by smtp.gmail.com with ESMTPSA id n14sm10224853wms.0.2021.10.07.03.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 03:39:49 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/5] staging: r8188eu: remove GetHwRegHandler from hal_ops
Date:   Thu,  7 Oct 2021 12:39:40 +0200
Message-Id: <20211007103943.8433-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211007103943.8433-1-straube.linux@gmail.com>
References: <20211007103943.8433-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove GetHwRegHandler from struct hal_ops and remove the wrapper
rtw_hal_get_hwreg(). Call GetHwReg8188EU() directly instead.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ap.c           | 2 +-
 drivers/staging/r8188eu/core/rtw_cmd.c          | 4 ++--
 drivers/staging/r8188eu/core/rtw_ioctl_set.c    | 2 +-
 drivers/staging/r8188eu/core/rtw_mlme.c         | 2 +-
 drivers/staging/r8188eu/core/rtw_mlme_ext.c     | 4 ++--
 drivers/staging/r8188eu/core/rtw_pwrctrl.c      | 2 +-
 drivers/staging/r8188eu/core/rtw_wlan_util.c    | 2 +-
 drivers/staging/r8188eu/hal/hal_intf.c          | 6 ------
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c      | 2 +-
 drivers/staging/r8188eu/hal/rtl8188e_dm.c       | 2 +-
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 4 ++--
 drivers/staging/r8188eu/hal/usb_halinit.c       | 4 +---
 drivers/staging/r8188eu/include/hal_intf.h      | 5 +----
 drivers/staging/r8188eu/os_dep/ioctl_linux.c    | 4 ++--
 14 files changed, 17 insertions(+), 28 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ap.c b/drivers/staging/r8188eu/core/rtw_ap.c
index 94e02aad96b7..eea1307768a0 100644
--- a/drivers/staging/r8188eu/core/rtw_ap.c
+++ b/drivers/staging/r8188eu/core/rtw_ap.c
@@ -342,7 +342,7 @@ void add_RATid(struct adapter *padapter, struct sta_info *psta, u8 rssi_level)
 	}
 	/* n mode ra_bitmap */
 	if (psta_ht->ht_option) {
-		rtw_hal_get_hwreg(padapter, HW_VAR_RF_TYPE, (u8 *)(&rf_type));
+		GetHwReg8188EU(padapter, HW_VAR_RF_TYPE, (u8 *)(&rf_type));
 		if (rf_type == RF_2T2R)
 			limit = 16;/*  2R */
 		else
diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 66349fed31cf..e17332677daa 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -1234,7 +1234,7 @@ static void rtw_chk_hi_queue_hdl(struct adapter *padapter)
 		/* while ((rtw_read32(padapter, 0x414)&0x00ffff00)!= 0) */
 		/* while ((rtw_read32(padapter, 0x414)&0x0000ff00)!= 0) */
 
-		rtw_hal_get_hwreg(padapter, HW_VAR_CHK_HI_QUEUE_EMPTY, &val);
+		GetHwReg8188EU(padapter, HW_VAR_CHK_HI_QUEUE_EMPTY, &val);
 
 		while (!val) {
 			msleep(100);
@@ -1244,7 +1244,7 @@ static void rtw_chk_hi_queue_hdl(struct adapter *padapter)
 			if (cnt > 10)
 				break;
 
-			rtw_hal_get_hwreg(padapter, HW_VAR_CHK_HI_QUEUE_EMPTY, &val);
+			GetHwReg8188EU(padapter, HW_VAR_CHK_HI_QUEUE_EMPTY, &val);
 		}
 
 		if (cnt <= 10) {
diff --git a/drivers/staging/r8188eu/core/rtw_ioctl_set.c b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
index 21ba2873919d..2b54cdfa9d6e 100644
--- a/drivers/staging/r8188eu/core/rtw_ioctl_set.c
+++ b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
@@ -483,7 +483,7 @@ u16 rtw_get_cur_max_rate(struct adapter *adapter)
 			short_GI_20 = (le16_to_cpu(pmlmeinfo->HT_caps.u.HT_cap_element.HT_caps_info) & IEEE80211_HT_CAP_SGI_20) ? 1 : 0;
 			short_GI_40 = (le16_to_cpu(pmlmeinfo->HT_caps.u.HT_cap_element.HT_caps_info) & IEEE80211_HT_CAP_SGI_40) ? 1 : 0;
 
-			rtw_hal_get_hwreg(adapter, HW_VAR_RF_TYPE, (u8 *)(&rf_type));
+			GetHwReg8188EU(adapter, HW_VAR_RF_TYPE, (u8 *)(&rf_type));
 			max_rate = rtw_mcs_rate(
 				rf_type,
 				bw_40MHz & (pregistrypriv->cbw40_enable),
diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index 408c9f8c6f6d..8d14aff32f61 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -2001,7 +2001,7 @@ void rtw_update_ht_cap(struct adapter *padapter, u8 *pie, uint ie_len)
 		int i;
 		u8	rf_type;
 
-		padapter->HalFunc.GetHwRegHandler(padapter, HW_VAR_RF_TYPE, (u8 *)(&rf_type));
+		GetHwReg8188EU(padapter, HW_VAR_RF_TYPE, (u8 *)(&rf_type));
 
 		/* update the MCS rates */
 		for (i = 0; i < 16; i++) {
diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 3aa5d9a0d361..995a0248c26f 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -5188,7 +5188,7 @@ void issue_assocreq(struct adapter *padapter)
 			/* todo: disable SM power save mode */
 			pmlmeinfo->HT_caps.u.HT_cap_element.HT_caps_info |= cpu_to_le16(0x000c);
 
-			rtw_hal_get_hwreg(padapter, HW_VAR_RF_TYPE, (u8 *)(&rf_type));
+			GetHwReg8188EU(padapter, HW_VAR_RF_TYPE, (u8 *)(&rf_type));
 			switch (rf_type) {
 			case RF_1T1R:
 				if (pregpriv->rx_stbc)
@@ -6037,7 +6037,7 @@ unsigned int send_beacon(struct adapter *padapter)
 		issue++;
 		do {
 			yield();
-			rtw_hal_get_hwreg(padapter, HW_VAR_BCN_VALID, (u8 *)(&bxmitok));
+			GetHwReg8188EU(padapter, HW_VAR_BCN_VALID, (u8 *)(&bxmitok));
 			poll++;
 		} while ((poll % 10) != 0 && !bxmitok && !padapter->bSurpriseRemoved && !padapter->bDriverStopped);
 	} while (!bxmitok && issue < 100 && !padapter->bSurpriseRemoved && !padapter->bDriverStopped);
diff --git a/drivers/staging/r8188eu/core/rtw_pwrctrl.c b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
index 20654f2df07a..19cac5814ea4 100644
--- a/drivers/staging/r8188eu/core/rtw_pwrctrl.c
+++ b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
@@ -246,7 +246,7 @@ s32 LPS_RF_ON_check(struct adapter *padapter, u32 delay_ms)
 
 	start_time = jiffies;
 	while (1) {
-		rtw_hal_get_hwreg(padapter, HW_VAR_FWLPS_RF_ON, &bAwake);
+		GetHwReg8188EU(padapter, HW_VAR_FWLPS_RF_ON, &bAwake);
 		if (bAwake)
 			break;
 
diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
index 323f0ee1f8e6..6d4e21a16783 100644
--- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
@@ -730,7 +730,7 @@ void HT_caps_handler(struct adapter *padapter, struct ndis_802_11_var_ie *pIE)
 		}
 	}
 
-	rtw_hal_get_hwreg(padapter, HW_VAR_RF_TYPE, (u8 *)(&rf_type));
+	GetHwReg8188EU(padapter, HW_VAR_RF_TYPE, (u8 *)(&rf_type));
 
 	/* update the MCS rates */
 	for (i = 0; i < 16; i++) {
diff --git a/drivers/staging/r8188eu/hal/hal_intf.c b/drivers/staging/r8188eu/hal/hal_intf.c
index 8caf67b594a7..6f39fc04df9b 100644
--- a/drivers/staging/r8188eu/hal/hal_intf.c
+++ b/drivers/staging/r8188eu/hal/hal_intf.c
@@ -41,12 +41,6 @@ uint rtw_hal_deinit(struct adapter *adapt)
 	return status;
 }
 
-void rtw_hal_get_hwreg(struct adapter *adapt, u8 variable, u8 *val)
-{
-	if (adapt->HalFunc.GetHwRegHandler)
-		adapt->HalFunc.GetHwRegHandler(adapt, variable, val);
-}
-
 void rtw_hal_update_ra_mask(struct adapter *adapt, u32 mac_id, u8 rssi_level)
 {
 	struct mlme_priv *pmlmepriv = &adapt->mlmepriv;
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
index 4dc3fae1a0cd..c5f9353fe3e6 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
@@ -604,7 +604,7 @@ void rtl8188e_set_FwJoinBssReport_cmd(struct adapter *adapt, u8 mstatus)
 				yield();
 				/* mdelay(10); */
 				/*  check rsvd page download OK. */
-				rtw_hal_get_hwreg(adapt, HW_VAR_BCN_VALID, (u8 *)(&bcn_valid));
+				GetHwReg8188EU(adapt, HW_VAR_BCN_VALID, (u8 *)(&bcn_valid));
 				poll++;
 			} while (!bcn_valid && (poll % 10) != 0 && !adapt->bSurpriseRemoved && !adapt->bDriverStopped);
 		} while (!bcn_valid && DLBcnCount <= 100 && !adapt->bSurpriseRemoved && !adapt->bDriverStopped);
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_dm.c b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
index 21494adf2a19..26765144c5ae 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_dm.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
@@ -142,7 +142,7 @@ void rtl8188e_HalDmWatchDog(struct adapter *Adapter)
 		return;
 
 	fw_cur_in_ps = Adapter->pwrctrlpriv.bFwCurrentInPSMode;
-	rtw_hal_get_hwreg(Adapter, HW_VAR_FWLPS_RF_ON, (u8 *)(&fw_ps_awake));
+	GetHwReg8188EU(Adapter, HW_VAR_FWLPS_RF_ON, (u8 *)(&fw_ps_awake));
 
 	/*  Fw is under p2p powersaving mode, driver should stop dynamic mechanism. */
 	/*  modifed by thomas. 2011.06.11. */
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 83744f6896d7..dd8d6b4a9d48 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -1102,7 +1102,7 @@ static u16 hal_EfuseGetCurrentSize_8188e(struct adapter *pAdapter, bool bPseudoT
 	if (bPseudoTest)
 		efuse_addr = (u16)(fakeEfuseUsedBytes);
 	else
-		rtw_hal_get_hwreg(pAdapter, HW_VAR_EFUSE_BYTES, (u8 *)&efuse_addr);
+		GetHwReg8188EU(pAdapter, HW_VAR_EFUSE_BYTES, (u8 *)&efuse_addr);
 
 	while (bContinual &&
 	       efuse_OneByteRead(pAdapter, efuse_addr, &efuse_data, bPseudoTest) &&
@@ -1490,7 +1490,7 @@ static bool hal_EfusePartialWriteCheck(struct adapter *pAdapter, u8 efuseType, u
 		if (bPseudoTest) {
 			startAddr = (u16)(fakeEfuseUsedBytes % EFUSE_REAL_CONTENT_LEN);
 		} else {
-			rtw_hal_get_hwreg(pAdapter, HW_VAR_EFUSE_BYTES, (u8 *)&startAddr);
+			GetHwReg8188EU(pAdapter, HW_VAR_EFUSE_BYTES, (u8 *)&startAddr);
 			startAddr %= EFUSE_REAL_CONTENT_LEN;
 		}
 	} else {
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index dced9b74b9a4..f6b90de1d063 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1798,7 +1798,7 @@ void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 
 }
 
-static void GetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
+void GetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 {
 	struct hal_data_8188e	*haldata = GET_HAL_DATA(Adapter);
 	struct odm_dm_struct *podmpriv = &haldata->odmpriv;
@@ -2142,6 +2142,4 @@ void rtl8188eu_set_hal_ops(struct adapter *adapt)
 
 	halfunc->hal_init = &rtl8188eu_hal_init;
 	halfunc->hal_deinit = &rtl8188eu_hal_deinit;
-
-	halfunc->GetHwRegHandler = &GetHwReg8188EU;
 }
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 4447b81a6af8..7d892bf496cc 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -124,9 +124,6 @@ typedef s32 (*c2h_id_filter)(u8 id);
 struct hal_ops {
 	u32	(*hal_init)(struct adapter *padapter);
 	u32	(*hal_deinit)(struct adapter *padapter);
-
-	void	(*GetHwRegHandler)(struct adapter *padapter, u8	variable,
-				   u8 *val);
 };
 
 #define RF_CHANGE_BY_INIT	0
@@ -172,11 +169,11 @@ u8 GetHalDefVar8188EUsb(struct adapter *Adapter, enum hal_def_variable eVariable
 unsigned int rtl8188eu_inirp_init(struct adapter *Adapter);
 
 void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val);
+void GetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val);
 
 uint rtw_hal_init(struct adapter *padapter);
 uint rtw_hal_deinit(struct adapter *padapter);
 void rtw_hal_stop(struct adapter *padapter);
-void rtw_hal_get_hwreg(struct adapter *padapter, u8 variable, u8 *val);
 
 void rtw_hal_update_ra_mask(struct adapter *padapter, u32 mac_id, u8 level);
 void	rtw_hal_clone_data(struct adapter *dst_adapt,
diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index f5377b92412a..0201f6fbeb25 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -3619,7 +3619,7 @@ static void rf_reg_dump(struct adapter *padapter)
 	int i, j = 1, path;
 	u32 value;
 	u8 rf_type, path_nums = 0;
-	rtw_hal_get_hwreg(padapter, HW_VAR_RF_TYPE, (u8 *)(&rf_type));
+	GetHwReg8188EU(padapter, HW_VAR_RF_TYPE, (u8 *)(&rf_type));
 
 	pr_info("\n ======= RF REG =======\n");
 	if ((RF_1T2R == rf_type) || (RF_1T1R == rf_type))
@@ -3926,7 +3926,7 @@ static int rtw_dbg_port(struct net_device *dev,
 		case 0x06:
 			{
 				u32	ODMFlag;
-				rtw_hal_get_hwreg(padapter, HW_VAR_DM_FLAG, (u8 *)(&ODMFlag));
+				GetHwReg8188EU(padapter, HW_VAR_DM_FLAG, (u8 *)(&ODMFlag));
 				DBG_88E("(B)DMFlag = 0x%x, arg = 0x%x\n", ODMFlag, arg);
 				ODMFlag = (u32)(0x0f & arg);
 				DBG_88E("(A)DMFlag = 0x%x\n", ODMFlag);
-- 
2.33.0

