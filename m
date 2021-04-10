Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 033FF35AE1B
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 16:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234817AbhDJOVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 10:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234797AbhDJOVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 10:21:00 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0375C06138A
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 07:20:44 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id w23so9782183edx.7
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 07:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=60G+KdzD6JzUCFfWSDIYs1cTd5n4jhzcWYQZON8KsaU=;
        b=Fh0rzWN5Tc6K/c7R93t73AeZnXfzGMqocZyNQ8aJWa8R9KGyln3IYk9fA90fxoNY2n
         Z4nIDIAdpZ6X4olC+STGRNKCMyGv8+VPIQBKUP2At6oE0LV2x9puIf40QE9h7wPGcer7
         xxV5PiWBQHPwevyBwE4O5/Gnifx3phGuoVcL9LxEO6PTYi2WSkGUDtu+4wZ5oiJzJ5jR
         9sndnQ2nRe5JkSmdPF0F3qoqWW1jgrBwOsWB+B2K/sy91BpM+d1obpbsov3djQaTez+S
         aUmYv1GeUubOF6tkeHQW7kt9+1bowYQ7+rXrB9SZm8Q0FE9LNFBnFugDW0Cq7VlilA8y
         ldqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=60G+KdzD6JzUCFfWSDIYs1cTd5n4jhzcWYQZON8KsaU=;
        b=ab7/AJtbXfc/9WEhEzAFEc9fK834Yr/WNpd0OC+EEqDJnJKlZQwJhqYHvI0ivG30xc
         OmBGevIlG4SE9YtPsXThAMWskkFmICx5+Tjz6gWOx3KXk0KqFr5/mA7hRcvm4ssacAC/
         sWR+lL49Jz+pgC5l08lMaMOymW/+T3ZussfmW3HjpkuGvWZl+cG1Q1pd0yvUhIakoIug
         FW4B/O2Ji0ppejnV01mSBzFf49igAwyR+GlvAm3U38DJQKiPdVmF2nlQFWY1V6pidkbe
         6xQ/AyOZOMHPzVRFFoy3rl7khWy2xyvvoku2mf7XdXzbPAwFc7c6neZW+H9A5G1CLSdK
         byyQ==
X-Gm-Message-State: AOAM532BgxPy8XDEpJXEMIPdKDcmjaIFsCC8I7P9xpoNzAfAHZjFETJB
        AdJ2S7yTVBucjSZvJCiKPwGH4D1N6/tCLw==
X-Google-Smtp-Source: ABdhPJwPvXIlIwWnIoNXBoY2IBV36qnHaHT9o6wMOq3Cq8WcCcwARgDTarJPOwmflFiNZoXDdW7PEA==
X-Received: by 2002:a05:6402:6c2:: with SMTP id n2mr22037985edy.110.1618064442467;
        Sat, 10 Apr 2021 07:20:42 -0700 (PDT)
Received: from agape ([5.171.81.28])
        by smtp.gmail.com with ESMTPSA id x24sm3214731edr.36.2021.04.10.07.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 07:20:41 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 01/25] staging: rtl8723bs: remove all DBG_8192C logs
Date:   Sat, 10 Apr 2021 16:20:14 +0200
Message-Id: <9b338b3781e40c04104f26832add075e7f72d890.1618064274.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1618064274.git.fabioaiuto83@gmail.com>
References: <cover.1618064274.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove all DBG_8192C logs.

Macro DBG_8192C belongs to a family of verbose
private tracing macros.

The default behaviour is _do nothing_, to activate
it one should define DEBUG symbol by hand.

So just remove it with the following semantic patch:

@@
expression a, b, c, d, e, f, g, h, i, j, k;
constant B, C, D, E;
@@

(
-	DBG_8192C(a);
|
-	DBG_8192C(a, b);
|
-	DBG_8192C(a, B);
|
-	DBG_8192C(a, b, c);
|
-	DBG_8192C(a, B, c);
|
-	DBG_8192C(a, b, C);
|
-	DBG_8192C(a, B, C);
|
-	DBG_8192C(a, b, c, d);
|
-	DBG_8192C(a, B, c, d);
|
-	DBG_8192C(a, b, C, d);
|
-	DBG_8192C(a, b, c, D);
|
-	DBG_8192C(a, B, C, d);
|
-	DBG_8192C(a, B, c, D);
|
-	DBG_8192C(a, b, C, D);
|
-	DBG_8192C(a, B, C, D);
|
-	DBG_8192C(a, b, c, d, e);
|
-	DBG_8192C(a, B, c, d, e);
|
-	DBG_8192C(a, b, C, d, e);
|
-	DBG_8192C(a, b, c, D, e);
|
-	DBG_8192C(a, b, c, d, E);
|
-	DBG_8192C(a, B, C, d, e);
|
-	DBG_8192C(a, B, c, D, e);
|
-	DBG_8192C(a, B, c, d, E);
|
-	DBG_8192C(a, b, C, D, e);
|
-	DBG_8192C(a, b, C, d, E);
|
-	DBG_8192C(a, b, c, D, E);
|
-	DBG_8192C(a, B, C, D, e);
|
-	DBG_8192C(a, B, C, d, E);
|
-	DBG_8192C(a, B, c, D, E);
|
-	DBG_8192C(a, b, C, D, E);
|
-	DBG_8192C(a, B, C, D, E);
|
-	DBG_8192C(a, b, c, d, e, f);
|
-	DBG_8192C(a, b, c, d, e, f, g);
|
-	DBG_8192C(a, b, c, d, e, f, g, h);
|
-	DBG_8192C(a, b, c, d, e, f, g, h, i);
|
-	DBG_8192C(a, b, c, d, e, f, g, h, i, j);
|
-	DBG_8192C(a, b, c, d, e, f, g, h, i, j, k);
)

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c |   1 -
 drivers/staging/rtl8723bs/core/rtw_pwrctrl.c  |   7 -
 drivers/staging/rtl8723bs/core/rtw_xmit.c     |   4 -
 drivers/staging/rtl8723bs/hal/hal_com.c       |   7 -
 drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c  |  21 ---
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c | 123 -----------------
 .../staging/rtl8723bs/hal/rtl8723b_phycfg.c   |   2 -
 .../staging/rtl8723bs/hal/rtl8723bs_recv.c    |   9 --
 drivers/staging/rtl8723bs/hal/sdio_halinit.c  |   7 -
 drivers/staging/rtl8723bs/hal/sdio_ops.c      |  17 +--
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 124 +-----------------
 .../staging/rtl8723bs/os_dep/ioctl_linux.c    |   6 -
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c  |   6 -
 13 files changed, 9 insertions(+), 325 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index a1e27ba4707e..e2217df30000 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -4405,7 +4405,6 @@ static void process_80211d(struct adapter *padapter, struct wlan_bssid_ex *bssid
 #ifdef DEBUG_RTL871X
 		i = 0;
 		while ((i < chplan_ap.Len) && (chplan_ap.Channel[i] != 0)) {
-			DBG_8192C("%02d,", chplan_ap.Channel[i]);
 			i++;
 		}
 #endif
diff --git a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
index f7465cf90c46..05e537cd4e48 100644
--- a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
+++ b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
@@ -1072,9 +1072,7 @@ int _rtw_pwr_wakeup(struct adapter *padapter, u32 ips_deffer_ms, const char *cal
 
 	if (rf_off == pwrpriv->rf_pwrstate) {
 		{
-			DBG_8192C("%s call ips_leave....\n", __func__);
 			if (ips_leave(padapter) == _FAIL) {
-				DBG_8192C("======> ips_leave fail.............\n");
 				ret = _FAIL;
 				goto exit;
 			}
@@ -1083,11 +1081,6 @@ int _rtw_pwr_wakeup(struct adapter *padapter, u32 ips_deffer_ms, const char *cal
 
 	/* TODO: the following checking need to be merged... */
 	if (padapter->bDriverStopped || !padapter->bup || !padapter->hw_init_completed) {
-		DBG_8192C("%s: bDriverStopped =%d, bup =%d, hw_init_completed =%u\n"
-			, caller
-			, padapter->bDriverStopped
-			, padapter->bup
-			, padapter->hw_init_completed);
 		ret = false;
 		goto exit;
 	}
diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
index 77378f7d6b9e..fcb0f04b245d 100644
--- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
+++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
@@ -1036,7 +1036,6 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
 	s32 res = _SUCCESS;
 
 	if (!pxmitframe->buf_addr) {
-		DBG_8192C("==> %s buf_addr == NULL\n", __func__);
 		return _FAIL;
 	}
 
@@ -1046,7 +1045,6 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
 	mem_start = pbuf_start +	hw_hdr_offset;
 
 	if (rtw_make_wlanhdr(padapter, mem_start, pattrib) == _FAIL) {
-		DBG_8192C("rtw_xmitframe_coalesce: rtw_make_wlanhdr fail; drop pkt\n");
 		res = _FAIL;
 		goto exit;
 	}
@@ -1121,7 +1119,6 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
 	}
 
 	if (xmitframe_addmic(padapter, pxmitframe) == _FAIL) {
-		DBG_8192C("xmitframe_addmic(padapter, pxmitframe) == _FAIL\n");
 		res = _FAIL;
 		goto exit;
 	}
@@ -1808,7 +1805,6 @@ s32 rtw_xmit_classifier(struct adapter *padapter, struct xmit_frame *pxmitframe)
 
 	if (!psta) {
 		res = _FAIL;
-		DBG_8192C("rtw_xmit_classifier: psta == NULL\n");
 		goto exit;
 	}
 
diff --git a/drivers/staging/rtl8723bs/hal/hal_com.c b/drivers/staging/rtl8723bs/hal/hal_com.c
index 6b871f2cb8dd..e526102bc50f 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com.c
@@ -19,7 +19,6 @@ u8 rtw_hal_data_init(struct adapter *padapter)
 		padapter->hal_data_sz = sizeof(struct hal_com_data);
 		padapter->HalData = vzalloc(padapter->hal_data_sz);
 		if (!padapter->HalData) {
-			DBG_8192C("cannot alloc memory for HAL DATA\n");
 			return _FAIL;
 		}
 	}
@@ -1129,15 +1128,12 @@ u8 SetHalDefVar(
 
 		if (dm_func == 0) { /* disable all dynamic func */
 			odm->SupportAbility = DYNAMIC_FUNC_DISABLE;
-			DBG_8192C("==> Disable all dynamic function...\n");
 		} else if (dm_func == 1) {/* disable DIG */
 			odm->SupportAbility  &= (~DYNAMIC_BB_DIG);
-			DBG_8192C("==> Disable DIG...\n");
 		} else if (dm_func == 2) {/* disable High power */
 			odm->SupportAbility  &= (~DYNAMIC_BB_DYNAMIC_TXPWR);
 		} else if (dm_func == 3) {/* disable tx power tracking */
 			odm->SupportAbility  &= (~DYNAMIC_RF_CALIBRATION);
-			DBG_8192C("==> Disable tx power tracking...\n");
 		} else if (dm_func == 4) {/* disable BT coexistence */
 			dm->DMFlag &= (~DYNAMIC_FUNC_BT);
 		} else if (dm_func == 5) {/* disable antenna diversity */
@@ -1149,7 +1145,6 @@ u8 SetHalDefVar(
 			}
 			dm->DMFlag |= DYNAMIC_FUNC_BT;
 			odm->SupportAbility = DYNAMIC_ALL_FUNC_ENABLE;
-			DBG_8192C("==> Turn on all dynamic function...\n");
 		}
 	}
 		break;
@@ -1254,10 +1249,8 @@ void SetHalODMVar(
 		{
 			struct sta_info *psta = pValue1;
 			if (bSet) {
-				DBG_8192C("### Set STA_(%d) info ###\n", psta->mac_id);
 				ODM_CmnInfoPtrArrayHook(podmpriv, ODM_CMNINFO_STA_STATUS, psta->mac_id, psta);
 			} else {
-				DBG_8192C("### Clean STA_(%d) info ###\n", psta->mac_id);
 				/* spin_lock_bh(&pHalData->odm_stainfo_lock); */
 				ODM_CmnInfoPtrArrayHook(podmpriv, ODM_CMNINFO_STA_STATUS, psta->mac_id, NULL);
 
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c b/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
index f8c6028f89f3..de8717f21e28 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
@@ -77,7 +77,6 @@ s32 FillH2CCmd8723B(struct adapter *padapter, u8 ElementID, u32 CmdLen, u8 *pCmd
 		h2c_box_num = pHalData->LastHMEBoxNum;
 
 		if (!_is_fw_read_cmd_down(padapter, h2c_box_num)) {
-			DBG_8192C(" fw read cmd failed...\n");
 			/* DBG_8192C(" 0x1c0: 0x%8x\n", rtw_read32(padapter, 0x1c0)); */
 			/* DBG_8192C(" 0x1c4: 0x%8x\n", rtw_read32(padapter, 0x1c4)); */
 			goto exit;
@@ -667,9 +666,6 @@ void rtl8723b_download_rsvd_page(struct adapter *padapter, u8 mstatus)
 	u32 poll = 0;
 	u8 val8;
 
-	DBG_8192C("+" FUNC_ADPT_FMT ": iface_type =%d mstatus(%x)\n",
-		FUNC_ADPT_ARG(padapter), get_iface_type(padapter), mstatus);
-
 	if (mstatus == RT_MEDIA_CONNECT) {
 		bool bRecover = false;
 		u8 v8;
@@ -869,7 +865,6 @@ static void SetFwRsvdPagePkt_BTCoex(struct adapter *padapter)
 
 	pcmdframe = rtw_alloc_cmdxmitframe(pxmitpriv);
 	if (!pcmdframe) {
-		DBG_8192C("%s: alloc ReservedPagePacket fail!\n", __func__);
 		return;
 	}
 
@@ -913,8 +908,6 @@ static void SetFwRsvdPagePkt_BTCoex(struct adapter *padapter)
 
 	TotalPacketLen = BufIndex + BTQosNullLength;
 	if (TotalPacketLen > MaxRsvdPageBufSize) {
-		DBG_8192C(FUNC_ADPT_FMT ": ERROR: The rsvd page size is not enough!!TotalPacketLen %d, MaxRsvdPageBufSize %d\n",
-			FUNC_ADPT_ARG(padapter), TotalPacketLen, MaxRsvdPageBufSize);
 		goto error;
 	}
 
@@ -947,14 +940,8 @@ void rtl8723b_download_BTCoex_AP_mode_rsvd_page(struct adapter *padapter)
 	u32 poll = 0;
 	u8 val8;
 
-
-	DBG_8192C("+" FUNC_ADPT_FMT ": iface_type =%d fw_state = 0x%08X\n",
-		FUNC_ADPT_ARG(padapter), get_iface_type(padapter), get_fwstate(&padapter->mlmepriv));
-
 #ifdef DEBUG
 	if (check_fwstate(&padapter->mlmepriv, WIFI_AP_STATE) == false) {
-		DBG_8192C(FUNC_ADPT_FMT ": [WARNING] not in AP mode!!\n",
-			FUNC_ADPT_ARG(padapter));
 	}
 #endif /*  DEBUG */
 
@@ -1008,15 +995,7 @@ void rtl8723b_download_BTCoex_AP_mode_rsvd_page(struct adapter *padapter)
 	if (bcn_valid) {
 		struct pwrctrl_priv *pwrctl = adapter_to_pwrctl(padapter);
 		pwrctl->fw_psmode_iface_id = padapter->iface_id;
-		DBG_8192C("%s: DL RSVD page success! DLBcnCount:%d, poll:%d\n",
-			ADPT_ARG(padapter), DLBcnCount, poll);
 	} else {
-		DBG_8192C("%s: DL RSVD page fail! DLBcnCount:%d, poll:%d\n",
-			ADPT_ARG(padapter), DLBcnCount, poll);
-		DBG_8192C("%s: DL RSVD page fail! bSurpriseRemoved =%d\n",
-			ADPT_ARG(padapter), padapter->bSurpriseRemoved);
-		DBG_8192C("%s: DL RSVD page fail! bDriverStopped =%d\n",
-			ADPT_ARG(padapter), padapter->bDriverStopped);
 	}
 
 	/*  2010.05.11. Added by tynli. */
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index dcb7cb131432..ff05f3bf09b2 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -176,8 +176,6 @@ void _8051Reset8723(struct adapter *padapter)
 	cpu_rst = rtw_read8(padapter, REG_SYS_FUNC_EN+1);
 	cpu_rst |= BIT(2);
 	rtw_write8(padapter, REG_SYS_FUNC_EN+1, cpu_rst);
-
-	DBG_8192C("%s: Finish\n", __func__);
 }
 
 u8 g_fwdl_chksum_fail;
@@ -461,7 +459,6 @@ static u8 hal_EfuseSwitchToBank(
 #endif
 
 
-	DBG_8192C("%s: Efuse switch bank to %d\n", __func__, bank);
 	if (bPseudoTest) {
 #ifdef HAL_EFUSE_MEMORY
 		pEfuseHal->fakeEfuseBank = bank;
@@ -683,11 +680,7 @@ static void Hal_EfusePowerSwitch(
 			} while (1);
 
 			if (count >= 100) {
-				DBG_8192C(FUNC_ADPT_FMT ": Leave SDIO local register suspend fail! Local 0x86 =%#X\n",
-					FUNC_ADPT_ARG(padapter), tempval);
 			} else {
-				DBG_8192C(FUNC_ADPT_FMT ": Leave SDIO local register suspend OK! Local 0x86 =%#X\n",
-					FUNC_ADPT_ARG(padapter), tempval);
 			}
 		}
 
@@ -751,13 +744,11 @@ static void hal_ReadEFuse_WiFi(
 	/*  Do NOT excess total size of EFuse table. Added by Roger, 2008.11.10. */
 	/*  */
 	if ((_offset+_size_byte) > EFUSE_MAX_MAP_LEN) {
-		DBG_8192C("%s: Invalid offset(%#x) with read bytes(%#x)!!\n", __func__, _offset, _size_byte);
 		return;
 	}
 
 	efuseTbl = rtw_malloc(EFUSE_MAX_MAP_LEN);
 	if (!efuseTbl) {
-		DBG_8192C("%s: alloc efuseTbl fail!\n", __func__);
 		return;
 	}
 	/*  0xff will be efuse default value instead of 0x00. */
@@ -784,7 +775,6 @@ if (0) {
 	while (AVAILABLE_EFUSE_ADDR(eFuse_Addr)) {
 		efuse_OneByteRead(padapter, eFuse_Addr++, &efuseHeader, bPseudoTest);
 		if (efuseHeader == 0xFF) {
-			DBG_8192C("%s: data end at address =%#x\n", __func__, eFuse_Addr-1);
 			break;
 		}
 		/* DBG_8192C("%s: efuse[0x%X]= 0x%02X\n", __func__, eFuse_Addr-1, efuseHeader); */
@@ -827,7 +817,6 @@ if (0) {
 				addr += 2;
 			}
 		} else {
-			DBG_8192C(KERN_ERR "%s: offset(%d) is illegal!!\n", __func__, offset);
 			eFuse_Addr += Efuse_CalculateWordCnts(wden)*2;
 		}
 	}
@@ -889,13 +878,11 @@ static void hal_ReadEFuse_BT(
 	/*  Do NOT excess total size of EFuse table. Added by Roger, 2008.11.10. */
 	/*  */
 	if ((_offset+_size_byte) > EFUSE_BT_MAP_LEN) {
-		DBG_8192C("%s: Invalid offset(%#x) with read bytes(%#x)!!\n", __func__, _offset, _size_byte);
 		return;
 	}
 
 	efuseTbl = rtw_malloc(EFUSE_BT_MAP_LEN);
 	if (!efuseTbl) {
-		DBG_8192C("%s: efuseTbl malloc fail!\n", __func__);
 		return;
 	}
 	/*  0xff will be efuse default value instead of 0x00. */
@@ -905,7 +892,6 @@ static void hal_ReadEFuse_BT(
 
 	for (bank = 1; bank < 3; bank++) { /*  8723b Max bake 0~2 */
 		if (hal_EfuseSwitchToBank(padapter, bank, bPseudoTest) == false) {
-			DBG_8192C("%s: hal_EfuseSwitchToBank Fail!!\n", __func__);
 			goto exit;
 		}
 
@@ -915,15 +901,12 @@ static void hal_ReadEFuse_BT(
 			efuse_OneByteRead(padapter, eFuse_Addr++, &efuseHeader, bPseudoTest);
 			if (efuseHeader == 0xFF)
 				break;
-			DBG_8192C("%s: efuse[%#X]= 0x%02x (header)\n", __func__, (((bank-1)*EFUSE_REAL_CONTENT_LEN_8723B)+eFuse_Addr-1), efuseHeader);
 
 			/*  Check PG header for section num. */
 			if (EXT_HEADER(efuseHeader)) { /* extended header */
 				offset = GET_HDR_OFFSET_2_0(efuseHeader);
-				DBG_8192C("%s: extended header offset_2_0 = 0x%X\n", __func__, offset);
 
 				efuse_OneByteRead(padapter, eFuse_Addr++, &efuseExtHdr, bPseudoTest);
-				DBG_8192C("%s: efuse[%#X]= 0x%02x (ext header)\n", __func__, (((bank-1)*EFUSE_REAL_CONTENT_LEN_8723B)+eFuse_Addr-1), efuseExtHdr);
 				if (ALL_WORDS_DISABLED(efuseExtHdr))
 					continue;
 
@@ -938,31 +921,24 @@ static void hal_ReadEFuse_BT(
 			if (offset < EFUSE_BT_MAX_SECTION) {
 				u16 addr;
 
-				/*  Get word enable value from PG header */
-				DBG_8192C("%s: Offset =%d Worden =%#X\n", __func__, offset, wden);
-
 				addr = offset * PGPKT_DATA_SIZE;
 				for (i = 0; i < EFUSE_MAX_WORD_UNIT; i++) {
 					/*  Check word enable condition in the section */
 					if (!(wden & (0x01<<i))) {
 						efuse_OneByteRead(padapter, eFuse_Addr++, &efuseData, bPseudoTest);
-						DBG_8192C("%s: efuse[%#X]= 0x%02X\n", __func__, eFuse_Addr-1, efuseData);
 						efuseTbl[addr] = efuseData;
 
 						efuse_OneByteRead(padapter, eFuse_Addr++, &efuseData, bPseudoTest);
-						DBG_8192C("%s: efuse[%#X]= 0x%02X\n", __func__, eFuse_Addr-1, efuseData);
 						efuseTbl[addr+1] = efuseData;
 					}
 					addr += 2;
 				}
 			} else {
-				DBG_8192C("%s: offset(%d) is illegal!!\n", __func__, offset);
 				eFuse_Addr += Efuse_CalculateWordCnts(wden)*2;
 			}
 		}
 
 		if ((eFuse_Addr-1) < total) {
-			DBG_8192C("%s: bank(%d) data end at %#x\n", __func__, bank, eFuse_Addr-1);
 			break;
 		}
 	}
@@ -979,7 +955,6 @@ static void hal_ReadEFuse_BT(
 	/*  */
 	EFUSE_GetEfuseDefinition(padapter, EFUSE_BT, TYPE_AVAILABLE_EFUSE_BYTES_TOTAL, &total, bPseudoTest);
 	used = (EFUSE_BT_REAL_BANK_CONTENT_LEN*(bank-1)) + eFuse_Addr - 1;
-	DBG_8192C("%s: bank(%d) data end at %#x , used =%d\n", __func__, bank, eFuse_Addr-1, used);
 	efuse_usage = (u8)((used*100)/total);
 	if (bPseudoTest) {
 #ifdef HAL_EFUSE_MEMORY
@@ -1036,7 +1011,6 @@ static u16 hal_EfuseGetCurrentSize_WiFi(
 		rtw_hal_get_hwreg(padapter, HW_VAR_EFUSE_BYTES, (u8 *)&efuse_addr);
 
 	start_addr = efuse_addr;
-	DBG_8192C("%s: start_efuse_addr = 0x%X\n", __func__, efuse_addr);
 
 	/*  switch bank back to bank 0 for later BT and wifi use. */
 	hal_EfuseSwitchToBank(padapter, 0, bPseudoTest);
@@ -1044,7 +1018,6 @@ static u16 hal_EfuseGetCurrentSize_WiFi(
 	count = 0;
 	while (AVAILABLE_EFUSE_ADDR(efuse_addr)) {
 		if (efuse_OneByteRead(padapter, efuse_addr, &efuse_data, bPseudoTest) == false) {
-			DBG_8192C(KERN_ERR "%s: efuse_OneByteRead Fail! addr = 0x%X !!\n", __func__, efuse_addr);
 			goto error;
 		}
 
@@ -1053,8 +1026,6 @@ static u16 hal_EfuseGetCurrentSize_WiFi(
 
 		if ((start_addr != 0) && (efuse_addr == start_addr)) {
 			count++;
-			DBG_8192C(FUNC_ADPT_FMT ": [WARNING] efuse raw 0x%X = 0x%02X not 0xFF!!(%d times)\n",
-				FUNC_ADPT_ARG(padapter), efuse_addr, efuse_data, count);
 
 			efuse_data = 0xFF;
 			if (count < 4) {
@@ -1106,7 +1077,6 @@ static u16 hal_EfuseGetCurrentSize_WiFi(
 	EFUSE_GetEfuseDefinition(padapter, EFUSE_WIFI, TYPE_AVAILABLE_EFUSE_BYTES_TOTAL, &efuse_addr, bPseudoTest);
 
 exit:
-	DBG_8192C("%s: CurrentSize =%d\n", __func__, efuse_addr);
 
 	return efuse_addr;
 }
@@ -1136,13 +1106,10 @@ static u16 hal_EfuseGetCurrentSize_BT(struct adapter *padapter, u8 bPseudoTest)
 	efuse_addr = (u16)((btusedbytes%EFUSE_BT_REAL_BANK_CONTENT_LEN));
 	startBank = (u8)(1+(btusedbytes/EFUSE_BT_REAL_BANK_CONTENT_LEN));
 
-	DBG_8192C("%s: start from bank =%d addr = 0x%X\n", __func__, startBank, efuse_addr);
-
 	EFUSE_GetEfuseDefinition(padapter, EFUSE_BT, TYPE_AVAILABLE_EFUSE_BYTES_BANK, &retU2, bPseudoTest);
 
 	for (bank = startBank; bank < 3; bank++) {
 		if (hal_EfuseSwitchToBank(padapter, bank, bPseudoTest) == false) {
-			DBG_8192C(KERN_ERR "%s: switch bank(%d) Fail!!\n", __func__, bank);
 			/* bank = EFUSE_MAX_BANK; */
 			break;
 		}
@@ -1154,11 +1121,9 @@ static u16 hal_EfuseGetCurrentSize_BT(struct adapter *padapter, u8 bPseudoTest)
 
 		while (AVAILABLE_EFUSE_ADDR(efuse_addr)) {
 			if (efuse_OneByteRead(padapter, efuse_addr, &efuse_data, bPseudoTest) == false) {
-				DBG_8192C(KERN_ERR "%s: efuse_OneByteRead Fail! addr = 0x%X !!\n", __func__, efuse_addr);
 				/* bank = EFUSE_MAX_BANK; */
 				break;
 			}
-			DBG_8192C("%s: efuse_OneByteRead ! addr = 0x%X !efuse_data = 0x%X! bank =%d\n", __func__, efuse_addr, efuse_data, bank);
 
 			if (efuse_data == 0xFF)
 				break;
@@ -1167,7 +1132,6 @@ static u16 hal_EfuseGetCurrentSize_BT(struct adapter *padapter, u8 bPseudoTest)
 				hoffset = GET_HDR_OFFSET_2_0(efuse_data);
 				efuse_addr++;
 				efuse_OneByteRead(padapter, efuse_addr, &efuse_data, bPseudoTest);
-				DBG_8192C("%s: efuse_OneByteRead EXT_HEADER ! addr = 0x%X !efuse_data = 0x%X! bank =%d\n", __func__, efuse_addr, efuse_data, bank);
 
 				if (ALL_WORDS_DISABLED(efuse_data)) {
 					efuse_addr++;
@@ -1182,9 +1146,6 @@ static u16 hal_EfuseGetCurrentSize_BT(struct adapter *padapter, u8 bPseudoTest)
 				hworden =  efuse_data & 0x0F;
 			}
 
-			DBG_8192C(FUNC_ADPT_FMT": Offset =%d Worden =%#X\n",
-				FUNC_ADPT_ARG(padapter), hoffset, hworden);
-
 			word_cnts = Efuse_CalculateWordCnts(hworden);
 			/* read next header */
 			efuse_addr += (word_cnts*2)+1;
@@ -1234,7 +1195,6 @@ static u16 hal_EfuseGetCurrentSize_BT(struct adapter *padapter, u8 bPseudoTest)
 		/* RT_DISP(FEEPROM, EFUSE_PG, ("Hal_EfuseGetCurrentSize_BT92C(), already use %u bytes\n", pEfuseHal->BTEfuseUsedBytes)); */
 	}
 
-	DBG_8192C("%s: CurrentSize =%d\n", __func__, retU2);
 	return retU2;
 }
 
@@ -1339,7 +1299,6 @@ static s32 Hal_EfusePgPacketRead(
 
 	EFUSE_GetEfuseDefinition(padapter, EFUSE_WIFI, TYPE_EFUSE_MAX_SECTION, &max_section, bPseudoTest);
 	if (offset > max_section) {
-		DBG_8192C("%s: Packet offset(%d) is illegal(>%d)!\n", __func__, offset, max_section);
 		return false;
 	}
 
@@ -1364,7 +1323,6 @@ static s32 Hal_EfusePgPacketRead(
 			hoffset = GET_HDR_OFFSET_2_0(efuse_data);
 			efuse_OneByteRead(padapter, efuse_addr++, &efuse_data, bPseudoTest);
 			if (ALL_WORDS_DISABLED(efuse_data)) {
-				DBG_8192C("%s: Error!! All words disabled!\n", __func__);
 				continue;
 			}
 
@@ -1410,7 +1368,6 @@ static u8 hal_EfusePgCheckAvailableAddr(
 
 	current_size = Efuse_GetCurrentSize(padapter, efuseType, bPseudoTest);
 	if (current_size >= max_available) {
-		DBG_8192C("%s: Error!! current_size(%d)>max_available(%d)\n", __func__, current_size, max_available);
 		return false;
 	}
 	return true;
@@ -1467,20 +1424,16 @@ static u8 hal_EfusePartialWriteCheck(
 			rtw_hal_get_hwreg(padapter, HW_VAR_EFUSE_BT_BYTES, (u8 *)&startAddr);
 	}
 	startAddr %= efuse_max;
-	DBG_8192C("%s: startAddr =%#X\n", __func__, startAddr);
 
 	while (1) {
 		if (startAddr >= efuse_max_available_len) {
 			bRet = false;
-			DBG_8192C("%s: startAddr(%d) >= efuse_max_available_len(%d)\n", __func__, startAddr, efuse_max_available_len);
 			break;
 		}
 
 		if (efuse_OneByteRead(padapter, startAddr, &efuse_data, bPseudoTest) && (efuse_data != 0xFF)) {
 #if 1
 			bRet = false;
-			DBG_8192C("%s: Something Wrong! last bytes(%#X = 0x%02X) is not 0xFF\n",
-				__func__, startAddr, efuse_data);
 			break;
 #else
 			if (EXT_HEADER(efuse_data)) {
@@ -1568,13 +1521,11 @@ static u8 hal_EfusePgPacketWrite1ByteHeader(
 		if (tmp_header != 0xFF)
 			break;
 		if (repeatcnt++ > EFUSE_REPEAT_THRESHOLD_) {
-			DBG_8192C("%s: Repeat over limit for pg_header!!\n", __func__);
 			return false;
 		}
 	} while (1);
 
 	if (tmp_header != pg_header) {
-		DBG_8192C(KERN_ERR "%s: PG Header Fail!!(pg = 0x%02X read = 0x%02X)\n", __func__, pg_header, tmp_header);
 		return false;
 	}
 
@@ -1599,8 +1550,6 @@ static u8 hal_EfusePgPacketWrite2ByteHeader(
 
 	efuse_addr = *pAddr;
 	if (efuse_addr >= efuse_max_available_len) {
-		DBG_8192C("%s: addr(%d) over available (%d)!!\n", __func__,
-			  efuse_addr, efuse_max_available_len);
 		return false;
 	}
 
@@ -1613,13 +1562,11 @@ static u8 hal_EfusePgPacketWrite2ByteHeader(
 		if (tmp_header != 0xFF)
 			break;
 		if (repeatcnt++ > EFUSE_REPEAT_THRESHOLD_) {
-			DBG_8192C("%s: Repeat over limit for pg_header!!\n", __func__);
 			return false;
 		}
 	} while (1);
 
 	if (tmp_header != pg_header) {
-		DBG_8192C(KERN_ERR "%s: PG Header Fail!!(pg = 0x%02X read = 0x%02X)\n", __func__, pg_header, tmp_header);
 		return false;
 	}
 
@@ -1633,13 +1580,11 @@ static u8 hal_EfusePgPacketWrite2ByteHeader(
 		if (tmp_header != 0xFF)
 			break;
 		if (repeatcnt++ > EFUSE_REPEAT_THRESHOLD_) {
-			DBG_8192C("%s: Repeat over limit for ext_header!!\n", __func__);
 			return false;
 		}
 	} while (1);
 
 	if (tmp_header != pg_header) { /* offset PG fail */
-		DBG_8192C(KERN_ERR "%s: PG EXT Header Fail!!(pg = 0x%02X read = 0x%02X)\n", __func__, pg_header, tmp_header);
 		return false;
 	}
 
@@ -1681,7 +1626,6 @@ static u8 hal_EfusePgPacketWriteData(
 	efuse_addr = *pAddr;
 	badworden = Efuse_WordEnableDataWrite(padapter, efuse_addr+1, pTargetPkt->word_en, pTargetPkt->data, bPseudoTest);
 	if (badworden != 0x0F) {
-		DBG_8192C("%s: Fail!!\n", __func__);
 		return false;
 	}
 
@@ -2169,12 +2113,6 @@ s32 rtl8723b_InitLLTTable(struct adapter *padapter)
 
 		passing_time = jiffies_to_msecs(jiffies - start);
 		if (passing_time > 1000) {
-			DBG_8192C(
-				"%s: FAIL!! REG_AUTO_LLT(0x%X) =%08x\n",
-				__func__,
-				REG_AUTO_LLT,
-				val32
-			);
 			break;
 		}
 
@@ -2263,7 +2201,6 @@ void Hal_EfuseParseIDCode(struct adapter *padapter, u8 *hwinfo)
 	/*  Checl 0x8129 again for making sure autoload status!! */
 	EEPROMId = le16_to_cpu(*((__le16 *)hwinfo));
 	if (EEPROMId != RTL_EEPROM_ID) {
-		DBG_8192C("EEPROM ID(%#x) is invalid!!\n", EEPROMId);
 		pEEPROM->bautoload_fail_flag = true;
 	} else
 		pEEPROM->bautoload_fail_flag = false;
@@ -2463,13 +2400,6 @@ void Hal_EfuseParseBTCoexistInfo_8723B(
 	}
 
 	if (padapter->registrypriv.ant_num > 0) {
-		DBG_8192C(
-			"%s: Apply driver defined antenna number(%d) to replace origin(%d)\n",
-			__func__,
-			padapter->registrypriv.ant_num,
-			pHalData->EEPROMBluetoothAntNum == Ant_x2 ? 2 : 1
-		);
-
 		switch (padapter->registrypriv.ant_num) {
 		case 1:
 			pHalData->EEPROMBluetoothAntNum = Ant_x1;
@@ -2478,11 +2408,6 @@ void Hal_EfuseParseBTCoexistInfo_8723B(
 			pHalData->EEPROMBluetoothAntNum = Ant_x2;
 			break;
 		default:
-			DBG_8192C(
-				"%s: Discard invalid driver defined antenna number(%d)!\n",
-				__func__,
-				padapter->registrypriv.ant_num
-			);
 			break;
 		}
 	}
@@ -2492,13 +2417,6 @@ void Hal_EfuseParseBTCoexistInfo_8723B(
 	hal_btcoex_SetPgAntNum(padapter, pHalData->EEPROMBluetoothAntNum == Ant_x2 ? 2 : 1);
 	if (pHalData->EEPROMBluetoothAntNum == Ant_x1)
 		hal_btcoex_SetSingleAntPath(padapter, pHalData->ant_path);
-
-	DBG_8192C(
-		"%s: %s BT-coex, ant_num =%d\n",
-		__func__,
-		pHalData->EEPROMBluetoothCoexist == true ? "Enable" : "Disable",
-		pHalData->EEPROMBluetoothAntNum == Ant_x2 ? 2 : 1
-	);
 }
 
 void Hal_EfuseParseEEPROMVer_8723B(
@@ -2921,7 +2839,6 @@ static void rtl8723b_fill_default_txdesc(
 		/*  CCX-TXRPT ack for xmit mgmt frames. */
 		if (pxmitframe->ack_report) {
 			#ifdef DBG_CCX
-			DBG_8192C("%s set spe_rpt\n", __func__);
 			#endif
 			ptxdesc->spe_rpt = 1;
 			ptxdesc->sw_define = (u8)(GET_PRIMARY_ADAPTER(padapter)->xmitpriv.seq_no);
@@ -3384,7 +3301,6 @@ s32 c2h_handler_8723b(struct adapter *padapter, u8 *buf)
 	s32 ret = _SUCCESS;
 
 	if (!pC2hEvent) {
-		DBG_8192C("%s(): pC2hEventis NULL\n", __func__);
 		ret = _FAIL;
 		goto exit;
 	}
@@ -3427,7 +3343,6 @@ s32 c2h_handler_8723b(struct adapter *padapter, u8 *buf)
 static void process_c2h_event(struct adapter *padapter, struct c2h_evt_hdr_t *pC2hEvent, u8 *c2hBuf)
 {
 	if (!c2hBuf) {
-		DBG_8192C("%s c2hbuff is NULL\n", __func__);
 		return;
 	}
 
@@ -3531,8 +3446,6 @@ void SetHwReg8723B(struct adapter *padapter, u8 variable, u8 *val)
 
 		pHalData->BasicRateSet = BrateCfg;
 
-		DBG_8192C("HW_VAR_BASIC_RATE: %#x -> %#x -> %#x\n", input_b, masked, ioted);
-
 		/*  Set RRSR rate table. */
 		rtw_write16(padapter, REG_RRSR, BrateCfg);
 		rtw_write8(padapter, REG_RRSR+2, rtw_read8(padapter, REG_RRSR+2)&0xf0);
@@ -3596,14 +3509,12 @@ void SetHwReg8723B(struct adapter *padapter, u8 variable, u8 *val)
 		val32 = rtw_read32(padapter, REG_RCR);
 		val32 |= RCR_AM;
 		rtw_write32(padapter, REG_RCR, val32);
-		DBG_8192C("%s, %d, RCR = %x\n", __func__, __LINE__, rtw_read32(padapter, REG_RCR));
 		break;
 
 	case HW_VAR_OFF_RCR_AM:
 		val32 = rtw_read32(padapter, REG_RCR);
 		val32 &= ~RCR_AM;
 		rtw_write32(padapter, REG_RCR, val32);
-		DBG_8192C("%s, %d, RCR = %x\n", __func__, __LINE__, rtw_read32(padapter, REG_RCR));
 		break;
 
 	case HW_VAR_BEACON_INTERVAL:
@@ -3715,7 +3626,6 @@ void SetHwReg8723B(struct adapter *padapter, u8 variable, u8 *val)
 					hwctrl |= AcmHw_VoqEn;
 			}
 
-			DBG_8192C("[HW_VAR_ACM_CTRL] Write 0x%02X\n", hwctrl);
 			rtw_write8(padapter, REG_ACMHWCTRL, hwctrl);
 		}
 		break;
@@ -3822,7 +3732,6 @@ void SetHwReg8723B(struct adapter *padapter, u8 variable, u8 *val)
 				} while (--trycnt);
 
 				if (trycnt == 0) {
-					DBG_8192C("[HW_VAR_FIFO_CLEARN_UP] Stop RX DMA failed......\n");
 				}
 
 				/*  RQPN Load 0 */
@@ -3835,7 +3744,6 @@ void SetHwReg8723B(struct adapter *padapter, u8 variable, u8 *val)
 
 	case HW_VAR_APFM_ON_MAC:
 		pHalData->bMacPwrCtrlOn = *val;
-		DBG_8192C("%s: bMacPwrCtrlOn =%d\n", __func__, pHalData->bMacPwrCtrlOn);
 		break;
 
 	case HW_VAR_NAV_UPPER:
@@ -3894,15 +3802,11 @@ void SetHwReg8723B(struct adapter *padapter, u8 variable, u8 *val)
 		/*  Input is MACID */
 		val32 = *(u32 *)val;
 		if (val32 > 31) {
-			DBG_8192C(FUNC_ADPT_FMT ": [HW_VAR_MACID_SLEEP] Invalid macid(%d)\n",
-				FUNC_ADPT_ARG(padapter), val32);
 			break;
 		}
 		val8 = (u8)val32; /*  macid is between 0~31 */
 
 		val32 = rtw_read32(padapter, REG_MACID_SLEEP);
-		DBG_8192C(FUNC_ADPT_FMT ": [HW_VAR_MACID_SLEEP] macid =%d, org MACID_SLEEP = 0x%08X\n",
-			FUNC_ADPT_ARG(padapter), val8, val32);
 		if (val32 & BIT(val8))
 			break;
 		val32 |= BIT(val8);
@@ -3913,15 +3817,11 @@ void SetHwReg8723B(struct adapter *padapter, u8 variable, u8 *val)
 		/*  Input is MACID */
 		val32 = *(u32 *)val;
 		if (val32 > 31) {
-			DBG_8192C(FUNC_ADPT_FMT ": [HW_VAR_MACID_WAKEUP] Invalid macid(%d)\n",
-				FUNC_ADPT_ARG(padapter), val32);
 			break;
 		}
 		val8 = (u8)val32; /*  macid is between 0~31 */
 
 		val32 = rtw_read32(padapter, REG_MACID_SLEEP);
-		DBG_8192C(FUNC_ADPT_FMT ": [HW_VAR_MACID_WAKEUP] macid =%d, org MACID_SLEEP = 0x%08X\n",
-			FUNC_ADPT_ARG(padapter), val8, val32);
 		if (!(val32 & BIT(val8)))
 			break;
 		val32 &= ~BIT(val8);
@@ -4076,19 +3976,12 @@ u8 GetHalDefVar8723B(struct adapter *padapter, enum hal_def_variable variable, v
 			u32 rate_mask1, rate_mask2;
 			u8 curr_tx_rate, curr_tx_sgi, hight_rate, lowest_rate;
 
-			DBG_8192C("============ RA status check  Mac_id:%d ===================\n", mac_id);
-
 			cmd = 0x40000100 | mac_id;
 			rtw_write32(padapter, REG_HMEBOX_DBG_2_8723B, cmd);
 			msleep(10);
 			ra_info1 = rtw_read32(padapter, 0x2F0);
 			curr_tx_rate = ra_info1&0x7F;
 			curr_tx_sgi = (ra_info1>>7)&0x01;
-			DBG_8192C("[ ra_info1:0x%08x ] =>cur_tx_rate = %s, cur_sgi:%d, PWRSTS = 0x%02x \n",
-				ra_info1,
-				HDATA_RATE(curr_tx_rate),
-				curr_tx_sgi,
-				(ra_info1>>8)  & 0x07);
 
 			cmd = 0x40000400 | mac_id;
 			rtw_write32(padapter, REG_HMEBOX_DBG_2_8723B, cmd);
@@ -4100,22 +3993,6 @@ u8 GetHalDefVar8723B(struct adapter *padapter, enum hal_def_variable variable, v
 			hight_rate = ra_info2&0xFF;
 			lowest_rate = (ra_info2>>8)  & 0xFF;
 
-			DBG_8192C("[ ra_info1:0x%08x ] =>RSSI =%d, BW_setting = 0x%02x, DISRA = 0x%02x, VHT_EN = 0x%02x\n",
-				ra_info1,
-				ra_info1&0xFF,
-				(ra_info1>>8)  & 0xFF,
-				(ra_info1>>16) & 0xFF,
-				(ra_info1>>24) & 0xFF);
-
-			DBG_8192C("[ ra_info2:0x%08x ] =>hight_rate =%s, lowest_rate =%s, SGI = 0x%02x, RateID =%d\n",
-				ra_info2,
-				HDATA_RATE(hight_rate),
-				HDATA_RATE(lowest_rate),
-				(ra_info2>>16) & 0xFF,
-				(ra_info2>>24) & 0xFF);
-
-			DBG_8192C("rate_mask2 = 0x%08x, rate_mask1 = 0x%08x\n", rate_mask2, rate_mask1);
-
 		}
 		break;
 
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c b/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
index e302c404fec0..f43abf9b0d22 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
@@ -733,8 +733,6 @@ static void phy_SwChnl8723B(struct adapter *padapter)
 	pHalData->RfRegChnlVal[0] = ((pHalData->RfRegChnlVal[0] & 0xfffff00) | channelToSW);
 	PHY_SetRFReg(padapter, ODM_RF_PATH_A, RF_CHNLBW, 0x3FF, pHalData->RfRegChnlVal[0]);
 	PHY_SetRFReg(padapter, ODM_RF_PATH_B, RF_CHNLBW, 0x3FF, pHalData->RfRegChnlVal[0]);
-
-	DBG_8192C("===>phy_SwChnl8723B: Channel = %d\n", channelToSW);
 }
 
 static void phy_SwChnlAndSetBwMode8723B(struct adapter *Adapter)
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
index 38d798cfe413..09d53006595d 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
@@ -183,7 +183,6 @@ static inline union recv_frame *try_alloc_recvframe(struct recv_priv *precvpriv,
 
 	precvframe = rtw_alloc_recvframe(&precvpriv->free_recv_queue);
 	if (!precvframe) {
-		DBG_8192C("%s: no enough recv frame!\n", __func__);
 		rtw_enqueue_recvbuf_to_head(precvbuf,
 					    &precvpriv->recv_buf_pending_queue);
 
@@ -202,8 +201,6 @@ static inline bool rx_crc_err(struct recv_priv *precvpriv,
 {
 	/*  fix Hardware RX data error, drop whole recv_buffer */
 	if ((!(p_hal_data->ReceiveConfig & RCR_ACRC32)) && pattrib->crc_err) {
-		DBG_8192C("%s()-%d: RX Warning! rx CRC ERROR !!\n",
-			  __func__, __LINE__);
 		rtw_free_recvframe(precvframe, &precvpriv->free_recv_queue);
 		return true;
 	}
@@ -216,8 +213,6 @@ static inline bool pkt_exceeds_tail(struct recv_priv *precvpriv,
 				    union recv_frame *precvframe)
 {
 	if (end > tail) {
-		DBG_8192C("%s()-%d: : next pkt len(%p,%d) exceed ptail(%p)!\n",
-			  __func__, __LINE__, ptr, pkt_offset, precvbuf->ptail);
 		rtw_free_recvframe(precvframe, &precvpriv->free_recv_queue);
 		return true;
 	}
@@ -276,9 +271,6 @@ static void rtl8723bs_recv_tasklet(struct tasklet_struct *t)
 				break;
 
 			if ((pattrib->crc_err) || (pattrib->icv_err)) {
-				DBG_8192C("%s: crc_err =%d icv_err =%d, skip!\n",
-					  __func__, pattrib->crc_err,
-					  pattrib->icv_err);
 				rtw_free_recvframe(precvframe,
 						   &precvpriv->free_recv_queue);
 			} else {
@@ -307,7 +299,6 @@ static void rtl8723bs_recv_tasklet(struct tasklet_struct *t)
 
 				pkt_copy = rtw_skb_alloc(alloc_sz);
 				if (!pkt_copy) {
-					DBG_8192C("%s: alloc_skb fail, drop frame\n", __func__);
 					rtw_free_recvframe(precvframe, &precvpriv->free_recv_queue);
 					break;
 				}
diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index 989f6974c817..a5d6ff591064 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -133,7 +133,6 @@ static void _init_available_page_threshold(struct adapter *padapter, u8 numHQ, u
 	rtw_write16(padapter, 0x218, HQ_threshold);
 	rtw_write16(padapter, 0x21A, NQ_threshold);
 	rtw_write16(padapter, 0x21C, LQ_threshold);
-	DBG_8192C("%s(): Enable Tx FIFO Page Threshold H:0x%x, N:0x%x, L:0x%x\n", __func__, HQ_threshold, NQ_threshold, LQ_threshold);
 }
 
 static void _InitQueueReservedPage(struct adapter *padapter)
@@ -579,7 +578,6 @@ static void _InitRFType(struct adapter *padapter)
 	pHalData->rf_chip	= RF_6052;
 
 	pHalData->rf_type = RF_1T1R;
-	DBG_8192C("Set RF Chip ID to RF_6052 and RF type to 1T1R.\n");
 }
 
 static void _RfPowerSave(struct adapter *padapter)
@@ -605,8 +603,6 @@ static bool HalDetectPwrDownMode(struct adapter *Adapter)
 	else
 		pHalData->pwrdown = false;
 
-	DBG_8192C("HalDetectPwrDownMode(): PDN =%d\n", pHalData->pwrdown);
-
 	return pHalData->pwrdown;
 }	/*  HalDetectPwrDownMode */
 
@@ -743,7 +739,6 @@ static u32 rtl8723bs_hal_init(struct adapter *padapter)
 	/*  init LLT after tx buffer boundary is defined */
 	ret = rtl8723b_InitLLTTable(padapter);
 	if (_SUCCESS != ret) {
-		DBG_8192C("%s: Failed to init LLT Table!\n", __func__);
 		return _FAIL;
 	}
 	/*  */
@@ -891,7 +886,6 @@ static void CardDisableRTL8723BSdio(struct adapter *padapter)
 	/*  Run LPS WL RFOFF flow */
 	ret = HalPwrSeqCmdParsing(padapter, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, rtl8723B_enter_lps_flow);
 	if (ret == _FAIL) {
-		DBG_8192C(KERN_ERR "%s: run RF OFF flow fail!\n", __func__);
 	}
 
 	/* 	==== Reset digital sequence   ====== */
@@ -924,7 +918,6 @@ static void CardDisableRTL8723BSdio(struct adapter *padapter)
 	rtw_hal_set_hwreg(padapter, HW_VAR_APFM_ON_MAC, &bMacPwrCtrlOn);
 	ret = HalPwrSeqCmdParsing(padapter, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, rtl8723B_card_disable_flow);
 	if (!ret) {
-		DBG_8192C(KERN_ERR "%s: run CARD DISABLE flow fail!\n", __func__);
 	}
 }
 
diff --git a/drivers/staging/rtl8723bs/hal/sdio_ops.c b/drivers/staging/rtl8723bs/hal/sdio_ops.c
index af7f846f90fe..763dd6062c74 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_ops.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_ops.c
@@ -183,7 +183,6 @@ static u32 sdio_read32(struct intf_hdl *intfhdl, u32 addr)
 #ifdef SDIO_DEBUG_IO
 		}
 
-		DBG_8192C(KERN_ERR "%s: Mac Power off, Read FAIL(%d)! addr = 0x%x\n", __func__, err, addr);
 		return SDIO_ERR_VAL32;
 #endif
 	}
@@ -197,7 +196,6 @@ static u32 sdio_read32(struct intf_hdl *intfhdl, u32 addr)
 
 		tmpbuf = rtw_malloc(8);
 		if (!tmpbuf) {
-			DBG_8192C(KERN_ERR "%s: Allocate memory FAIL!(size =8) addr = 0x%x\n", __func__, addr);
 			return SDIO_ERR_VAL32;
 		}
 
@@ -599,10 +597,10 @@ s32 sdio_local_write(
 	u8 *tmpbuf;
 
 	if (addr & 0x3)
-		DBG_8192C("%s, address must be 4 bytes alignment\n", __func__);
+		{}
 
 	if (cnt  & 0x3)
-		DBG_8192C("%s, size must be the multiple of 4\n", __func__);
+		{}
 
 	intfhdl = &adapter->iopriv.intf;
 
@@ -923,22 +921,19 @@ void sd_int_dpc(struct adapter *adapter)
 			hal_sdio_get_cmd_addr_8723b(adapter, WLAN_IOREG_DEVICE_ID, addr, &addr);
 			_sd_read(intfhdl, addr, 4, status);
 			_sd_write(intfhdl, addr, 4, status);
-			DBG_8192C("%s: SDIO_HISR_TXERR (0x%08x)\n", __func__, le32_to_cpu(*(u32 *)status));
 			kfree(status);
 		} else {
-			DBG_8192C("%s: SDIO_HISR_TXERR, but can't allocate memory to read status!\n", __func__);
 		}
 	}
 
 	if (hal->sdio_hisr & SDIO_HISR_TXBCNOK)
-		DBG_8192C("%s: SDIO_HISR_TXBCNOK\n", __func__);
+		{}
 
 	if (hal->sdio_hisr & SDIO_HISR_TXBCNERR)
-		DBG_8192C("%s: SDIO_HISR_TXBCNERR\n", __func__);
+		{}
 	if (hal->sdio_hisr & SDIO_HISR_C2HCMD) {
 		struct c2h_evt_hdr_88xx *c2h_evt;
 
-		DBG_8192C("%s: C2H Command\n", __func__);
 		c2h_evt = rtw_zmalloc(16);
 		if (c2h_evt) {
 			if (c2h_evt_read_88xx(adapter, (u8 *)c2h_evt) == _SUCCESS) {
@@ -958,10 +953,10 @@ void sd_int_dpc(struct adapter *adapter)
 	}
 
 	if (hal->sdio_hisr & SDIO_HISR_RXFOVW)
-		DBG_8192C("%s: Rx Overflow\n", __func__);
+		{}
 
 	if (hal->sdio_hisr & SDIO_HISR_RXERR)
-		DBG_8192C("%s: Rx Error\n", __func__);
+		{}
 
 	if (hal->sdio_hisr & SDIO_HISR_RX_REQUEST) {
 		struct recv_buf *recvbuf;
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index f96322bdf510..986b3e2cf263 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -269,8 +269,6 @@ struct cfg80211_bss *rtw_cfg80211_inform_bss(struct adapter *padapter, struct wl
 		{
 			if (request->n_ssids == 1 && request->n_channels == 1) /*  it means under processing WPS */
 			{
-				DBG_8192C("ssid =%s, len =%d\n", pssid->Ssid, pssid->SsidLength);
-
 				if (ssids[0].ssid_len != 0 &&
 				    (pssid->SsidLength != ssids[0].ssid_len ||
 				     memcmp(pssid->Ssid, ssids[0].ssid, ssids[0].ssid_len)))
@@ -335,7 +333,6 @@ struct cfg80211_bss *rtw_cfg80211_inform_bss(struct adapter *padapter, struct wl
 		len, notify_signal, GFP_ATOMIC);
 
 	if (unlikely(!bss)) {
-		DBG_8192C(FUNC_ADPT_FMT" bss NULL\n", FUNC_ADPT_ARG(padapter));
 		goto exit;
 	}
 
@@ -553,16 +550,12 @@ static int rtw_cfg80211_ap_set_encryption(struct net_device *dev, struct ieee_pa
 		if (!psta)
 		{
 			/* ret = -EINVAL; */
-			DBG_8192C("rtw_set_encryption(), sta has already been removed or never been added\n");
 			goto exit;
 		}
 	}
 
 	if (strcmp(param->u.crypt.alg, "none") == 0 && (psta == NULL))
 	{
-		/* todo:clear default encryption keys */
-
-		DBG_8192C("clear default encryption keys, keyid =%d\n", param->u.crypt.idx);
 
 		goto exit;
 	}
@@ -570,13 +563,9 @@ static int rtw_cfg80211_ap_set_encryption(struct net_device *dev, struct ieee_pa
 
 	if (strcmp(param->u.crypt.alg, "WEP") == 0 && (psta == NULL))
 	{
-		DBG_8192C("r871x_set_encryption, crypt.alg = WEP\n");
-
 		wep_key_idx = param->u.crypt.idx;
 		wep_key_len = param->u.crypt.key_len;
 
-		DBG_8192C("r871x_set_encryption, wep_key_idx =%d, len =%d\n", wep_key_idx, wep_key_len);
-
 		if ((wep_key_idx >= WEP_KEYS) || (wep_key_len <= 0))
 		{
 			ret = -EINVAL;
@@ -623,8 +612,6 @@ static int rtw_cfg80211_ap_set_encryption(struct net_device *dev, struct ieee_pa
 		{
 			if (strcmp(param->u.crypt.alg, "WEP") == 0)
 			{
-				DBG_8192C("%s, set group_key, WEP\n", __func__);
-
 				memcpy(psecuritypriv->dot118021XGrpKey[param->u.crypt.idx].skey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
 
 				psecuritypriv->dot118021XGrpPrivacy = _WEP40_;
@@ -636,8 +623,6 @@ static int rtw_cfg80211_ap_set_encryption(struct net_device *dev, struct ieee_pa
 			}
 			else if (strcmp(param->u.crypt.alg, "TKIP") == 0)
 			{
-				DBG_8192C("%s, set group_key, TKIP\n", __func__);
-
 				psecuritypriv->dot118021XGrpPrivacy = _TKIP_;
 
 				memcpy(psecuritypriv->dot118021XGrpKey[param->u.crypt.idx].skey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
@@ -652,16 +637,12 @@ static int rtw_cfg80211_ap_set_encryption(struct net_device *dev, struct ieee_pa
 			}
 			else if (strcmp(param->u.crypt.alg, "CCMP") == 0)
 			{
-				DBG_8192C("%s, set group_key, CCMP\n", __func__);
-
 				psecuritypriv->dot118021XGrpPrivacy = _AES_;
 
 				memcpy(psecuritypriv->dot118021XGrpKey[param->u.crypt.idx].skey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
 			}
 			else
 			{
-				DBG_8192C("%s, set group_key, none\n", __func__);
-
 				psecuritypriv->dot118021XGrpPrivacy = _NO_PRIVACY_;
 			}
 
@@ -696,8 +677,6 @@ static int rtw_cfg80211_ap_set_encryption(struct net_device *dev, struct ieee_pa
 
 				if (strcmp(param->u.crypt.alg, "WEP") == 0)
 				{
-					DBG_8192C("%s, set pairwise key, WEP\n", __func__);
-
 					psta->dot118021XPrivacy = _WEP40_;
 					if (param->u.crypt.key_len == 13)
 					{
@@ -706,8 +685,6 @@ static int rtw_cfg80211_ap_set_encryption(struct net_device *dev, struct ieee_pa
 				}
 				else if (strcmp(param->u.crypt.alg, "TKIP") == 0)
 				{
-					DBG_8192C("%s, set pairwise key, TKIP\n", __func__);
-
 					psta->dot118021XPrivacy = _TKIP_;
 
 					/* DEBUG_ERR("set key length :param->u.crypt.key_len =%d\n", param->u.crypt.key_len); */
@@ -721,14 +698,10 @@ static int rtw_cfg80211_ap_set_encryption(struct net_device *dev, struct ieee_pa
 				else if (strcmp(param->u.crypt.alg, "CCMP") == 0)
 				{
 
-					DBG_8192C("%s, set pairwise key, CCMP\n", __func__);
-
 					psta->dot118021XPrivacy = _AES_;
 				}
 				else
 				{
-					DBG_8192C("%s, set pairwise key, none\n", __func__);
-
 					psta->dot118021XPrivacy = _NO_PRIVACY_;
 				}
 
@@ -840,8 +813,6 @@ static int rtw_cfg80211_set_encryption(struct net_device *dev, struct ieee_param
 
 	if (strcmp(param->u.crypt.alg, "WEP") == 0)
 	{
-		DBG_8192C("wpa_set_encryption, crypt.alg = WEP\n");
-
 		wep_key_idx = param->u.crypt.idx;
 		wep_key_len = param->u.crypt.key_len;
 
@@ -890,8 +861,6 @@ static int rtw_cfg80211_set_encryption(struct net_device *dev, struct ieee_param
 		{
 			psta = rtw_get_stainfo(pstapriv, get_bssid(pmlmepriv));
 			if (psta == NULL) {
-				/* DEBUG_ERR(("Set wpa_set_encryption: Obtain Sta_info fail\n")); */
-				DBG_8192C("%s, : Obtain Sta_info fail\n", __func__);
 			}
 			else
 			{
@@ -909,8 +878,6 @@ static int rtw_cfg80211_set_encryption(struct net_device *dev, struct ieee_param
 				if (param->u.crypt.set_tx == 1)/* pairwise key */
 				{
 
-					DBG_8192C("%s, : param->u.crypt.set_tx == 1\n", __func__);
-
 					memcpy(psta->dot118021x_UncstKey.skey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
 
 					if (strcmp(param->u.crypt.alg, "TKIP") == 0)/* set mic key */
@@ -976,8 +943,6 @@ static int rtw_cfg80211_set_encryption(struct net_device *dev, struct ieee_param
 
 exit:
 
-	DBG_8192C("%s, ret =%d\n", __func__, ret);
-
 	return ret;
 }
 
@@ -1068,8 +1033,6 @@ static int cfg80211_rtw_add_key(struct wiphy *wiphy, struct net_device *ndev,
         }
 	else
 	{
-		DBG_8192C("error!\n");
-
 	}
 
 addkey_end:
@@ -1152,7 +1115,6 @@ static int cfg80211_rtw_get_station(struct wiphy *wiphy,
 
 	psta = rtw_get_stainfo(pstapriv, (u8 *)mac);
 	if (psta == NULL) {
-		DBG_8192C("%s, sta_info is null\n", __func__);
 		ret = -ENOENT;
 		goto exit;
 	}
@@ -1278,7 +1240,6 @@ void rtw_cfg80211_indicate_scan_done(struct adapter *adapter, bool aborted)
 		/* avoid WARN_ON(request != wiphy_to_dev(request->wiphy)->scan_req); */
 		if (pwdev_priv->scan_request->wiphy != pwdev_priv->rtw_wdev->wiphy)
 		{
-			DBG_8192C("error wiphy compare\n");
 		}
 		else
 		{
@@ -1305,8 +1266,6 @@ void rtw_cfg80211_unlink_bss(struct adapter *padapter, struct wlan_network *pnet
 
 	if (bss) {
 		cfg80211_unlink_bss(wiphy, bss);
-		DBG_8192C("%s(): cfg80211_unlink %s!! () ", __func__,
-			  select_network->Ssid.Ssid);
 		cfg80211_put_bss(padapter->rtw_wdev->wiphy, bss);
 	}
 }
@@ -1355,7 +1314,6 @@ static int rtw_cfg80211_set_probe_req_wpsp2pie(struct adapter *padapter, char *b
 	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
 
 #ifdef DEBUG_CFG80211
-	DBG_8192C("%s, ielen =%d\n", __func__, len);
 #endif
 
 	if (len > 0)
@@ -1364,7 +1322,6 @@ static int rtw_cfg80211_set_probe_req_wpsp2pie(struct adapter *padapter, char *b
 		if (wps_ie)
 		{
 			#ifdef DEBUG_CFG80211
-			DBG_8192C("probe_req_wps_ielen =%d\n", wps_ielen);
 			#endif
 
 			if (pmlmepriv->wps_probe_req_ie)
@@ -1376,7 +1333,6 @@ static int rtw_cfg80211_set_probe_req_wpsp2pie(struct adapter *padapter, char *b
 
 			pmlmepriv->wps_probe_req_ie = rtw_malloc(wps_ielen);
 			if (pmlmepriv->wps_probe_req_ie == NULL) {
-				DBG_8192C("%s()-%d: rtw_malloc() ERROR!\n", __func__, __LINE__);
 				return -EINVAL;
 
 			}
@@ -1426,11 +1382,8 @@ static int cfg80211_rtw_scan(struct wiphy *wiphy
 	{
 		if (check_fwstate(pmlmepriv, WIFI_UNDER_WPS|_FW_UNDER_SURVEY|_FW_UNDER_LINKING) == true)
 		{
-			DBG_8192C("%s, fwstate = 0x%x\n", __func__, pmlmepriv->fw_state);
-
 			if (check_fwstate(pmlmepriv, WIFI_UNDER_WPS))
 			{
-				DBG_8192C("AP mode process WPS\n");
 			}
 
 			need_indicate_scan_done = true;
@@ -1450,11 +1403,9 @@ static int cfg80211_rtw_scan(struct wiphy *wiphy
 	}
 
 	if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY) == true) {
-		DBG_8192C("%s, fwstate = 0x%x\n", __func__, pmlmepriv->fw_state);
 		need_indicate_scan_done = true;
 		goto check_need_indicate_scan_done;
 	} else if (check_fwstate(pmlmepriv, _FW_UNDER_LINKING) == true) {
-		DBG_8192C("%s, fwstate = 0x%x\n", __func__, pmlmepriv->fw_state);
 		ret = -EBUSY;
 		goto check_need_indicate_scan_done;
 	}
@@ -1488,7 +1439,6 @@ static int cfg80211_rtw_scan(struct wiphy *wiphy
 	/* parsing request ssids, n_ssids */
 	for (i = 0; i < request->n_ssids && i < RTW_SSID_SCAN_AMOUNT; i++) {
 		#ifdef DEBUG_CFG80211
-		DBG_8192C("ssid =%s, len =%d\n", ssids[i].ssid, ssids[i].ssid_len);
 		#endif
 		memcpy(ssid[i].Ssid, ssids[i].ssid, ssids[i].ssid_len);
 		ssid[i].SsidLength = ssids[i].ssid_len;
@@ -1546,8 +1496,6 @@ static int cfg80211_rtw_set_wiphy_params(struct wiphy *wiphy, u32 changed)
 
 static int rtw_cfg80211_set_wpa_version(struct security_priv *psecuritypriv, u32 wpa_version)
 {
-	DBG_8192C("%s, wpa_version =%d\n", __func__, wpa_version);
-
 	if (!wpa_version) {
 		psecuritypriv->ndisauthtype = Ndis802_11AuthModeOpen;
 		return 0;
@@ -1566,9 +1514,6 @@ static int rtw_cfg80211_set_wpa_version(struct security_priv *psecuritypriv, u32
 static int rtw_cfg80211_set_auth_type(struct security_priv *psecuritypriv,
 			     enum nl80211_auth_type sme_auth_type)
 {
-	DBG_8192C("%s, nl80211_auth_type =%d\n", __func__, sme_auth_type);
-
-
 	switch (sme_auth_type) {
 	case NL80211_AUTHTYPE_AUTOMATIC:
 
@@ -1607,8 +1552,6 @@ static int rtw_cfg80211_set_cipher(struct security_priv *psecuritypriv, u32 ciph
 	u32 *profile_cipher = ucast ? &psecuritypriv->dot11PrivacyAlgrthm :
 		&psecuritypriv->dot118021XGrpPrivacy;
 
-	DBG_8192C("%s, ucast =%d, cipher = 0x%x\n", __func__, ucast, cipher);
-
 
 	if (!cipher) {
 		*profile_cipher = _NO_PRIVACY_;
@@ -1638,7 +1581,6 @@ static int rtw_cfg80211_set_cipher(struct security_priv *psecuritypriv, u32 ciph
 		ndisencryptstatus = Ndis802_11Encryption3Enabled;
 		break;
 	default:
-		DBG_8192C("Unsupported cipher: 0x%x\n", cipher);
 		return -ENOTSUPP;
 	}
 
@@ -1654,8 +1596,6 @@ static int rtw_cfg80211_set_cipher(struct security_priv *psecuritypriv, u32 ciph
 
 static int rtw_cfg80211_set_key_mgt(struct security_priv *psecuritypriv, u32 key_mgt)
 {
-	DBG_8192C("%s, key_mgt = 0x%x\n", __func__, key_mgt);
-
 	if (key_mgt == WLAN_AKM_SUITE_8021X)
 		/* auth_type = UMAC_AUTH_TYPE_8021X; */
 		psecuritypriv->dot11AuthAlgrthm = dot11AuthAlgrthm_8021X;
@@ -1663,7 +1603,6 @@ static int rtw_cfg80211_set_key_mgt(struct security_priv *psecuritypriv, u32 key
 		psecuritypriv->dot11AuthAlgrthm = dot11AuthAlgrthm_8021X;
 	}
 	else {
-		DBG_8192C("Invalid key mgt: 0x%x\n", key_mgt);
 		/* return -EINVAL; */
 	}
 
@@ -1702,9 +1641,8 @@ static int rtw_cfg80211_set_wpa_ie(struct adapter *padapter, u8 *pie, size_t iel
 	/* dump */
 	{
 		int i;
-		DBG_8192C("set wpa_ie(length:%zu):\n", ielen);
 		for (i = 0; i < ielen; i = i + 8)
-			DBG_8192C("0x%.2x 0x%.2x 0x%.2x 0x%.2x 0x%.2x 0x%.2x 0x%.2x 0x%.2x\n", buf[i], buf[i+1], buf[i+2], buf[i+3], buf[i+4], buf[i+5], buf[i+6], buf[i+7]);
+			{}
 	}
 
 	if (ielen < RSN_HEADER_LEN) {
@@ -1718,8 +1656,6 @@ static int rtw_cfg80211_set_wpa_ie(struct adapter *padapter, u8 *pie, size_t iel
 			padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_8021X;
 			padapter->securitypriv.ndisauthtype = Ndis802_11AuthModeWPAPSK;
 			memcpy(padapter->securitypriv.supplicant_ie, &pwpa[0], wpa_ielen+2);
-
-			DBG_8192C("got wpa_ie, wpa_ielen:%u\n", wpa_ielen);
 		}
 	}
 
@@ -1729,8 +1665,6 @@ static int rtw_cfg80211_set_wpa_ie(struct adapter *padapter, u8 *pie, size_t iel
 			padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_8021X;
 			padapter->securitypriv.ndisauthtype = Ndis802_11AuthModeWPA2PSK;
 			memcpy(padapter->securitypriv.supplicant_ie, &pwpa2[0], wpa2_ielen+2);
-
-			DBG_8192C("got wpa2_ie, wpa2_ielen:%u\n", wpa2_ielen);
 		}
 	}
 
@@ -1794,7 +1728,6 @@ static int rtw_cfg80211_set_wpa_ie(struct adapter *padapter, u8 *pie, size_t iel
 
 		wps_ie = rtw_get_wps_ie(buf, ielen, NULL, &wps_ielen);
 		if (wps_ie && wps_ielen > 0) {
-			DBG_8192C("got wps_ie, wps_ielen:%u\n", wps_ielen);
 			padapter->securitypriv.wps_ie_len = wps_ielen < MAX_WPS_IE_LEN ? wps_ielen : MAX_WPS_IE_LEN;
 			memcpy(padapter->securitypriv.wps_ie, wps_ie, padapter->securitypriv.wps_ie_len);
 			set_fwstate(&padapter->mlmepriv, WIFI_UNDER_WPS);
@@ -1946,16 +1879,13 @@ static int cfg80211_rtw_connect(struct wiphy *wiphy, struct net_device *ndev,
 	ndis_ssid.SsidLength = sme->ssid_len;
 	memcpy(ndis_ssid.Ssid, (u8 *)sme->ssid, sme->ssid_len);
 
-	DBG_8192C("ssid =%s, len =%zu\n", ndis_ssid.Ssid, sme->ssid_len);
-
 
 	if (sme->bssid)
-		DBG_8192C("bssid =%pM\n", MAC_ARG(sme->bssid));
+		{}
 
 
 	if (check_fwstate(pmlmepriv, _FW_UNDER_LINKING) == true) {
 		ret = -EBUSY;
-		DBG_8192C("%s, fw_state = 0x%x, goto exit\n", __func__, pmlmepriv->fw_state);
 		goto exit;
 	}
 	if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY) == true) {
@@ -1977,8 +1907,6 @@ static int cfg80211_rtw_connect(struct wiphy *wiphy, struct net_device *ndev,
 	if (ret < 0)
 		goto exit;
 
-	DBG_8192C("%s, ie_len =%zu\n", __func__, sme->ie_len);
-
 	ret = rtw_cfg80211_set_wpa_ie(padapter, (u8 *)sme->ie, sme->ie_len);
 	if (ret < 0)
 		goto exit;
@@ -2060,14 +1988,10 @@ static int cfg80211_rtw_connect(struct wiphy *wiphy, struct net_device *ndev,
 		goto exit;
 	}
 
-	DBG_8192C("set ssid:dot11AuthAlgrthm =%d, dot11PrivacyAlgrthm =%d, dot118021XGrpPrivacy =%d\n", psecuritypriv->dot11AuthAlgrthm, psecuritypriv->dot11PrivacyAlgrthm, psecuritypriv->dot118021XGrpPrivacy);
-
 exit:
 
 	rtw_ps_deny_cancel(padapter, PS_DENY_JOIN);
 
-	DBG_8192C("<=%s, ret %d\n", __func__, ret);
-
 	padapter->mlmepriv.not_indic_disco = false;
 
 	return ret;
@@ -2266,7 +2190,6 @@ static netdev_tx_t rtw_cfg80211_monitor_if_xmit_entry(struct sk_buff *skb, struc
 		goto fail;
 
 	if (rtap_len != 14) {
-		DBG_8192C("radiotap len (should be 14): %d\n", rtap_len);
 		goto fail;
 	}
 
@@ -2296,8 +2219,6 @@ static netdev_tx_t rtw_cfg80211_monitor_if_xmit_entry(struct sk_buff *skb, struc
 		memcpy(pdata, dst_mac_addr, sizeof(dst_mac_addr));
 		memcpy(pdata + sizeof(dst_mac_addr), src_mac_addr, sizeof(src_mac_addr));
 
-		DBG_8192C("should be eapol packet\n");
-
 		/* Use the real net device to transmit the packet */
 		return _rtw_xmit_entry(skb, padapter->pnetdev);
 
@@ -2317,14 +2238,9 @@ static netdev_tx_t rtw_cfg80211_monitor_if_xmit_entry(struct sk_buff *skb, struc
 		u8 category, action;
 
 		if (rtw_action_frame_parse(buf, len, &category, &action) == false) {
-			DBG_8192C(FUNC_NDEV_FMT" frame_control:0x%x\n", FUNC_NDEV_ARG(ndev),
-				le16_to_cpu(((struct ieee80211_hdr_3addr *)buf)->frame_control));
 			goto fail;
 		}
 
-		DBG_8192C("RTW_Tx:da =%pM via "FUNC_NDEV_FMT"\n",
-			MAC_ARG(GetAddr1Ptr(buf)), FUNC_NDEV_ARG(ndev));
-
 		/* starting alloc mgmt frame to dump it */
 		pmgntframe = alloc_mgtxmitframe(pxmitpriv);
 		if (!pmgntframe)
@@ -2354,7 +2270,6 @@ static netdev_tx_t rtw_cfg80211_monitor_if_xmit_entry(struct sk_buff *skb, struc
 		dump_mgntframe(padapter, pmgntframe);
 
 	} else {
-		DBG_8192C("frame_control = 0x%x\n", frame_control & (IEEE80211_FCTL_FTYPE|IEEE80211_FCTL_STYPE));
 	}
 
 
@@ -2514,8 +2429,6 @@ static int rtw_add_beacon(struct adapter *adapter, const u8 *head, size_t head_l
 	uint len, wps_ielen = 0;
 	struct mlme_priv *pmlmepriv = &(adapter->mlmepriv);
 
-	DBG_8192C("%s beacon_head_len =%zu, beacon_tail_len =%zu\n", __func__, head_len, tail_len);
-
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) != true)
 		return -EINVAL;
 
@@ -2533,7 +2446,7 @@ static int rtw_add_beacon(struct adapter *adapter, const u8 *head, size_t head_l
 
 	/* check wps ie if inclued */
 	if (rtw_get_wps_ie(pbuf+_FIXED_IE_LENGTH_, len-_FIXED_IE_LENGTH_, NULL, &wps_ielen))
-		DBG_8192C("add bcn, wps_ielen =%d\n", wps_ielen);
+		{}
 
 	/* pbss_network->IEs will not include p2p_ie, wfd ie */
 	rtw_ies_remove_ie(pbuf, &len, _BEACON_IE_OFFSET_, WLAN_EID_VENDOR_SPECIFIC, P2P_OUI, 4);
@@ -2608,14 +2521,11 @@ static int cfg80211_rtw_del_station(struct wiphy *wiphy, struct net_device *ndev
 	const u8 *mac = params->mac;
 
 	if (check_fwstate(pmlmepriv, (_FW_LINKED|WIFI_AP_STATE)) != true) {
-		DBG_8192C("%s, fw_state != FW_LINKED|WIFI_AP_STATE\n", __func__);
 		return -EINVAL;
 	}
 
 
 	if (!mac) {
-		DBG_8192C("flush all sta, and cam_entry\n");
-
 		flush_all_cam_entry(padapter);	/* clear CAM */
 
 		rtw_sta_flush(padapter);
@@ -2623,9 +2533,6 @@ static int cfg80211_rtw_del_station(struct wiphy *wiphy, struct net_device *ndev
 		return 0;
 	}
 
-
-	DBG_8192C("free sta macaddr =%pM\n", MAC_ARG(mac));
-
 	if (mac[0] == 0xff && mac[1] == 0xff &&
 	    mac[2] == 0xff && mac[3] == 0xff &&
 	    mac[4] == 0xff && mac[5] == 0xff) {
@@ -2646,10 +2553,7 @@ static int cfg80211_rtw_del_station(struct wiphy *wiphy, struct net_device *ndev
 
 		if (!memcmp((u8 *)mac, psta->hwaddr, ETH_ALEN)) {
 			if (psta->dot8021xalg == 1 && psta->bpairwise_key_installed == false) {
-				DBG_8192C("%s, sta's dot8021xalg = 1 and key_installed = false\n", __func__);
 			} else {
-				DBG_8192C("free psta =%p, aid =%d\n", psta, psta->aid);
-
 				list_del_init(&psta->asoc_list);
 				pstapriv->asoc_list_cnt--;
 
@@ -2738,8 +2642,6 @@ void rtw_cfg80211_rx_action(struct adapter *adapter, u8 *frame, uint frame_len,
 
 	rtw_action_frame_parse(frame, frame_len, &category, &action);
 
-	DBG_8192C("RTW_Rx:cur_ch =%d\n", channel);
-
 	freq = rtw_ieee80211_channel_to_frequency(channel, NL80211_BAND_2GHZ);
 
 	rtw_cfg80211_rx_mgmt(adapter, freq, 0, frame, frame_len, GFP_ATOMIC);
@@ -2798,13 +2700,11 @@ static int _cfg80211_rtw_mgmt_tx(struct adapter *padapter, u8 tx_ch, const u8 *b
 		ret = _FAIL;
 
 		#ifdef DEBUG_CFG80211
-		DBG_8192C("%s, ack == _FAIL\n", __func__);
 		#endif
 	} else {
 		msleep(50);
 
 		#ifdef DEBUG_CFG80211
-		DBG_8192C("%s, ack =%d, ok!\n", __func__, ack);
 		#endif
 		ret = _SUCCESS;
 	}
@@ -2812,7 +2712,6 @@ static int _cfg80211_rtw_mgmt_tx(struct adapter *padapter, u8 tx_ch, const u8 *b
 exit:
 
 	#ifdef DEBUG_CFG80211
-	DBG_8192C("%s, ret =%d\n", __func__, ret);
 	#endif
 
 	return ret;
@@ -2854,13 +2753,9 @@ static int cfg80211_rtw_mgmt_tx(struct wiphy *wiphy,
 	rtw_cfg80211_mgmt_tx_status(padapter, *cookie, buf, len, ack, GFP_KERNEL);
 
 	if (rtw_action_frame_parse(buf, len, &category, &action) == false) {
-		DBG_8192C(FUNC_ADPT_FMT" frame_control:0x%x\n", FUNC_ADPT_ARG(padapter),
-			le16_to_cpu(((struct ieee80211_hdr_3addr *)buf)->frame_control));
 		goto exit;
 	}
 
-	DBG_8192C("RTW_Tx:tx_ch =%d, da =%pM\n", tx_ch, MAC_ARG(GetAddr1Ptr(buf)));
-
 	rtw_ps_deny(padapter, PS_DENY_MGNT_TX);
 	if (_FAIL == rtw_pwr_wakeup(padapter)) {
 		ret = -EFAULT;
@@ -2937,7 +2832,6 @@ static void rtw_cfg80211_init_ht_capab(struct ieee80211_sta_ht_cap *ht_cap, enum
 
 		ht_cap->mcs.rx_highest = cpu_to_le16(MAX_BIT_RATE_40MHZ_MCS15);
 	} else {
-		DBG_8192C("%s, error rf_type =%d\n", __func__, rf_type);
 	}
 
 }
@@ -2951,8 +2845,6 @@ void rtw_cfg80211_init_wiphy(struct adapter *padapter)
 
 	rtw_hal_get_hwreg(padapter, HW_VAR_RF_TYPE, (u8 *)(&rf_type));
 
-	DBG_8192C("%s:rf_type =%d\n", __func__, rf_type);
-
 	{
 		bands = wiphy->bands[NL80211_BAND_2GHZ];
 		if (bands)
@@ -3052,12 +2944,9 @@ int rtw_wdev_alloc(struct adapter *padapter, struct device *dev)
 	struct rtw_wdev_priv *pwdev_priv;
 	struct net_device *pnetdev = padapter->pnetdev;
 
-	DBG_8192C("%s(padapter =%p)\n", __func__, padapter);
-
 	/* wiphy */
 	wiphy = wiphy_new(&rtw_cfg80211_ops, sizeof(struct adapter *));
 	if (!wiphy) {
-		DBG_8192C("Couldn't allocate wiphy device\n");
 		ret = -ENOMEM;
 		goto exit;
 	}
@@ -3070,14 +2959,12 @@ int rtw_wdev_alloc(struct adapter *padapter, struct device *dev)
 
 	ret = wiphy_register(wiphy);
 	if (ret < 0) {
-		DBG_8192C("Couldn't register wiphy device\n");
 		goto free_wiphy;
 	}
 
 	/*  wdev */
 	wdev = rtw_zmalloc(sizeof(struct wireless_dev));
 	if (!wdev) {
-		DBG_8192C("Couldn't allocate wireless device\n");
 		ret = -ENOMEM;
 		goto unregister_wiphy;
 	}
@@ -3124,8 +3011,6 @@ int rtw_wdev_alloc(struct adapter *padapter, struct device *dev)
 
 void rtw_wdev_free(struct wireless_dev *wdev)
 {
-	DBG_8192C("%s(wdev =%p)\n", __func__, wdev);
-
 	if (!wdev)
 		return;
 
@@ -3142,8 +3027,6 @@ void rtw_wdev_unregister(struct wireless_dev *wdev)
 	struct adapter *adapter;
 	struct rtw_wdev_priv *pwdev_priv;
 
-	DBG_8192C("%s(wdev =%p)\n", __func__, wdev);
-
 	if (!wdev)
 		return;
 	ndev = wdev_to_ndev(wdev);
@@ -3156,7 +3039,6 @@ void rtw_wdev_unregister(struct wireless_dev *wdev)
 	rtw_cfg80211_indicate_scan_done(adapter, true);
 
 	if (pwdev_priv->pmon_ndev) {
-		DBG_8192C("%s, unregister monitor interface\n", __func__);
 		unregister_netdev(pwdev_priv->pmon_ndev);
 	}
 
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index e5f0cdc9711e..332855103b14 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -4248,14 +4248,12 @@ static int rtw_ioctl_wext_private(struct net_device *dev, union iwreq_data *wrq_
 
 	sscanf(ptr, "%16s", cmdname);
 	cmdlen = strlen(cmdname);
-	DBG_8192C("%s: cmd =%s\n", __func__, cmdname);
 
 	/*  skip command string */
 	if (cmdlen > 0)
 		cmdlen += 1; /*  skip one space */
 	ptr += cmdlen;
 	len -= cmdlen;
-	DBG_8192C("%s: parameters =%s\n", __func__, ptr);
 
 	priv = rtw_private_handler;
 	priv_args = rtw_private_args;
@@ -4366,15 +4364,12 @@ static int rtw_ioctl_wext_private(struct net_device *dev, union iwreq_data *wrq_
 			break;
 
 		default:
-			DBG_8192C("%s: Not yet implemented...\n", __func__);
 			err = -1;
 			goto exit;
 		}
 
 		if ((priv_args[k].set_args & IW_PRIV_SIZE_FIXED) &&
 			(wdata.data.length != (priv_args[k].set_args & IW_PRIV_SIZE_MASK))) {
-			DBG_8192C("%s: The command %s needs exactly %d argument(s)...\n",
-					__func__, cmdname, priv_args[k].set_args & IW_PRIV_SIZE_MASK);
 			err = -EINVAL;
 			goto exit;
 		}
@@ -4492,7 +4487,6 @@ static int rtw_ioctl_wext_private(struct net_device *dev, union iwreq_data *wrq_
 			break;
 
 		default:
-			DBG_8192C("%s: Not yet implemented...\n", __func__);
 			err = -1;
 			goto exit;
 		}
diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
index 9fd926e1698f..61b36955efc8 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
@@ -130,14 +130,12 @@ static u32 sdio_init(struct dvobj_priv *dvobj)
 	err = sdio_enable_func(func);
 	if (err) {
 		dvobj->drv_dbg.dbg_sdio_init_error_cnt++;
-		DBG_8192C(KERN_CRIT "%s: sdio_enable_func FAIL(%d)!\n", __func__, err);
 		goto release;
 	}
 
 	err = sdio_set_block_size(func, 512);
 	if (err) {
 		dvobj->drv_dbg.dbg_sdio_init_error_cnt++;
-		DBG_8192C(KERN_CRIT "%s: sdio_set_block_size FAIL(%d)!\n", __func__, err);
 		goto release;
 	}
 	psdio_data->block_transfer_len = 512;
@@ -164,14 +162,12 @@ static void sdio_deinit(struct dvobj_priv *dvobj)
 		err = sdio_disable_func(func);
 		if (err) {
 			dvobj->drv_dbg.dbg_sdio_deinit_error_cnt++;
-			DBG_8192C(KERN_ERR "%s: sdio_disable_func(%d)\n", __func__, err);
 		}
 
 		if (dvobj->irq_alloc) {
 			err = sdio_release_irq(func);
 			if (err) {
 				dvobj->drv_dbg.dbg_sdio_free_irq_error_cnt++;
-				DBG_8192C(KERN_ERR "%s: sdio_release_irq(%d)\n", __func__, err);
 			} else
 				dvobj->drv_dbg.dbg_sdio_free_irq_cnt++;
 		}
@@ -235,7 +231,6 @@ void rtw_set_hal_ops(struct adapter *padapter)
 static void sd_intf_start(struct adapter *padapter)
 {
 	if (padapter == NULL) {
-		DBG_8192C(KERN_ERR "%s: padapter is NULL!\n", __func__);
 		return;
 	}
 
@@ -246,7 +241,6 @@ static void sd_intf_start(struct adapter *padapter)
 static void sd_intf_stop(struct adapter *padapter)
 {
 	if (padapter == NULL) {
-		DBG_8192C(KERN_ERR "%s: padapter is NULL!\n", __func__);
 		return;
 	}
 
-- 
2.20.1

