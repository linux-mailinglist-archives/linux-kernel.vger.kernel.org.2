Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB9134FD00
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 11:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234797AbhCaJe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 05:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234833AbhCaJeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 05:34:21 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B73EC061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:34:21 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id dm8so21523519edb.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z0YLmu3Lbju6Wgix3IY/SiIi4DM91syLmnRJ1rA3xcc=;
        b=VSmg0aDxM2yBAkbWHbJtQLxv9dO+ppbvmoAz+dQKnpxpk40a6xtwrOMa8fzWSO5/Yx
         YmHNUpusc56S/XvN1XAxO6VF3rrUIuar3ylHtAjWRbpdqys0zJAyj+bLJFAamES6FRCa
         rdL3VTLsVX2uBnn5CyuR+6OMWQvAhm0cv5tkc7iP+4IApo2b7Wy2r+wpZtcXXG2G1pDM
         x3sM4pXGGYkAsGSEiJgEzCPL+SA2WCjYBxiU83Z4JW58/1V7RYdWvs+84yO67l8e35PR
         GmAuFbzhGMM1wUSRtz7hgA9yqVdgKwXl1jcMPwpx8eGXP8z4ImIpQkLVQzydjOByDLHG
         +KQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z0YLmu3Lbju6Wgix3IY/SiIi4DM91syLmnRJ1rA3xcc=;
        b=rfqekTISlW20Mn6SCGzkzBSI9Av/SRwsBBNpO7a85bkwXIjorWlzyzSJ2Yu/MHMbED
         AdUwZ54QC14hUDFyT3vwYGEuvcA0rRU2nGxIoe8msJf9YUAvxHaUT5RgVBCQqXBCwTGZ
         YgUo0qI3hMA/5iRHtwm9sv+Cx5ZmqofWDWWdbIjEjob+S+70cYtJabzVYxqjVasjHzyc
         TPT2CBClZRJt/O8iODqv9ATvFlXpT46D8D0DhaxWkkYKvpAgm5qYEfyP4MBbcF9+7DjY
         jq6ekE42uoCdtNmnoiEi4poBanbreSL+Gse7Zan7iaTul+NCq4RIuBCs6RX0f7BH4Uk9
         JWuQ==
X-Gm-Message-State: AOAM533tUYX9IlxqdjvoptCp7XM9LwsMolMqYlEYa/FX5vFIJVPG05cS
        FVQjzNvpLLJ+KsWy6qiFryo=
X-Google-Smtp-Source: ABdhPJwEbSfQHcI3W5wUWxpjBjPq09Fy+Dw4mucrBRyGelKnYBP2VOtTiuxjB2ReiZZsGVjEeT3CIA==
X-Received: by 2002:aa7:da48:: with SMTP id w8mr2474287eds.81.1617183260243;
        Wed, 31 Mar 2021 02:34:20 -0700 (PDT)
Received: from agape ([5.171.73.44])
        by smtp.gmail.com with ESMTPSA id n16sm1134561edr.42.2021.03.31.02.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 02:34:19 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 1/2] staging: rtl8723bs: use print_hex_dump_debug instead of private RT_PRINT_DATA
Date:   Wed, 31 Mar 2021 11:34:06 +0200
Message-Id: <2ef2c25c928b15f1c4357146efe193afab606d33.1617183040.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617183040.git.fabioaiuto83@gmail.com>
References: <cover.1617183040.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

replace private macro RT_PRINT_DATA with in-kernel helper
print_hex_dump_debug

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_com.c       | 13 ++++-------
 drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c  | 22 ++++++++++++++-----
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c |  3 ++-
 3 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_com.c b/drivers/staging/rtl8723bs/hal/hal_com.c
index 98a363698843..e74d7e21372d 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com.c
@@ -924,13 +924,8 @@ s32 c2h_evt_read_88xx(struct adapter *adapter, u8 *buf)
 	c2h_evt->seq = rtw_read8(adapter, REG_C2HEVT_CMD_SEQ_88XX);
 	c2h_evt->plen = rtw_read8(adapter, REG_C2HEVT_CMD_LEN_88XX);
 
-	RT_PRINT_DATA(
-		_module_hal_init_c_,
-		_drv_info_,
-		"c2h_evt_read(): ",
-		&c2h_evt,
-		sizeof(c2h_evt)
-	);
+	print_hex_dump_debug(DRIVER_PREFIX ": c2h_evt_read(): ", DUMP_PREFIX_NONE,
+			     16, 1, &c2h_evt, sizeof(c2h_evt), false);
 
 	DBG_871X(
 		"%s id:%u, len:%u, seq:%u, trigger:0x%02x\n",
@@ -945,8 +940,8 @@ s32 c2h_evt_read_88xx(struct adapter *adapter, u8 *buf)
 	for (i = 0; i < c2h_evt->plen; i++)
 		c2h_evt->payload[i] = rtw_read8(adapter, REG_C2HEVT_MSG_NORMAL + 2 + i);
 
-	RT_PRINT_DATA(_module_hal_init_c_, _drv_info_, "c2h_evt_read(): Command Content:\n",
-		c2h_evt->payload, c2h_evt->plen);
+	print_hex_dump_debug(DRIVER_PREFIX ": c2h_evt_read(): Command Content:\n",
+			     DUMP_PREFIX_NONE, 16, 1, c2h_evt->payload, c2h_evt->plen, false);
 
 	ret = _SUCCESS;
 
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c b/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
index 202974ccb739..88f908fd14e3 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
@@ -336,7 +336,9 @@ static void rtl8723b_set_FwRsvdPage_cmd(struct adapter *padapter, struct rsvdpag
 	SET_8723B_H2CCMD_RSVDPAGE_LOC_QOS_NULL_DATA(u1H2CRsvdPageParm, rsvdpageloc->LocQosNull);
 	SET_8723B_H2CCMD_RSVDPAGE_LOC_BT_QOS_NULL_DATA(u1H2CRsvdPageParm, rsvdpageloc->LocBTQosNull);
 
-	RT_PRINT_DATA(_module_hal_init_c_, _drv_always_, "u1H2CRsvdPageParm:", u1H2CRsvdPageParm, H2C_RSVDPAGE_LOC_LEN);
+	print_hex_dump_debug(DRIVER_PREFIX ": u1H2CRsvdPageParm:", DUMP_PREFIX_NONE,
+			     16, 1, u1H2CRsvdPageParm, H2C_RSVDPAGE_LOC_LEN, false);
+
 	FillH2CCmd8723B(padapter, H2C_8723B_RSVD_PAGE, H2C_RSVDPAGE_LOC_LEN, u1H2CRsvdPageParm);
 }
 
@@ -356,7 +358,9 @@ void rtl8723b_set_FwMediaStatusRpt_cmd(struct adapter *padapter, u8 mstatus, u8
 	SET_8723B_H2CCMD_MSRRPT_PARM_MACID(u1H2CMediaStatusRptParm, macid);
 	SET_8723B_H2CCMD_MSRRPT_PARM_MACID_END(u1H2CMediaStatusRptParm, macid_end);
 
-	RT_PRINT_DATA(_module_hal_init_c_, _drv_always_, "u1H2CMediaStatusRptParm:", u1H2CMediaStatusRptParm, H2C_MEDIA_STATUS_RPT_LEN);
+	print_hex_dump_debug(DRIVER_PREFIX ": u1H2CMediaStatusRptParm:", DUMP_PREFIX_NONE,
+			     16, 1, u1H2CMediaStatusRptParm, H2C_MEDIA_STATUS_RPT_LEN, false);
+
 	FillH2CCmd8723B(padapter, H2C_8723B_MEDIA_STATUS_RPT, H2C_MEDIA_STATUS_RPT_LEN, u1H2CMediaStatusRptParm);
 }
 
@@ -375,7 +379,9 @@ void rtl8723b_set_FwMacIdConfig_cmd(struct adapter *padapter, u8 mac_id, u8 raid
 	SET_8723B_H2CCMD_MACID_CFG_RATE_MASK2(u1H2CMacIdConfigParm, (u8)((mask & 0x00ff0000) >> 16));
 	SET_8723B_H2CCMD_MACID_CFG_RATE_MASK3(u1H2CMacIdConfigParm, (u8)((mask & 0xff000000) >> 24));
 
-	RT_PRINT_DATA(_module_hal_init_c_, _drv_always_, "u1H2CMacIdConfigParm:", u1H2CMacIdConfigParm, H2C_MACID_CFG_LEN);
+	print_hex_dump_debug(DRIVER_PREFIX ": u1H2CMacIdConfigParm:", DUMP_PREFIX_NONE,
+			     16, 1, u1H2CMacIdConfigParm, H2C_MACID_CFG_LEN, false);
+
 	FillH2CCmd8723B(padapter, H2C_8723B_MACID_CFG, H2C_MACID_CFG_LEN, u1H2CMacIdConfigParm);
 }
 
@@ -393,7 +399,9 @@ void rtl8723b_set_rssi_cmd(struct adapter *padapter, u8 *param)
 	SET_8723B_H2CCMD_RSSI_SETTING_RSSI(u1H2CRssiSettingParm, rssi);
 	SET_8723B_H2CCMD_RSSI_SETTING_ULDL_STATE(u1H2CRssiSettingParm, uldl_state);
 
-	RT_PRINT_DATA(_module_hal_init_c_, _drv_notice_, "u1H2CRssiSettingParm:", u1H2CRssiSettingParm, H2C_RSSI_SETTING_LEN);
+	print_hex_dump_debug(DRIVER_PREFIX ": u1H2CRssiSettingParm:", DUMP_PREFIX_NONE,
+			     16, 1, u1H2CRssiSettingParm, H2C_RSSI_SETTING_LEN, false);
+
 	FillH2CCmd8723B(padapter, H2C_8723B_RSSI_SETTING, H2C_RSSI_SETTING_LEN, u1H2CRssiSettingParm);
 }
 
@@ -514,7 +522,8 @@ void rtl8723b_set_FwPwrMode_cmd(struct adapter *padapter, u8 psmode)
 
 	hal_btcoex_RecordPwrMode(padapter, u1H2CPwrModeParm, H2C_PWRMODE_LEN);
 
-	RT_PRINT_DATA(_module_hal_init_c_, _drv_always_, "u1H2CPwrModeParm:", u1H2CPwrModeParm, H2C_PWRMODE_LEN);
+	print_hex_dump_debug(DRIVER_PREFIX ": u1H2CPwrModeParm:", DUMP_PREFIX_NONE,
+			     16, 1, u1H2CPwrModeParm, H2C_PWRMODE_LEN, false);
 
 	FillH2CCmd8723B(padapter, H2C_8723B_SET_PWR_MODE, H2C_PWRMODE_LEN, u1H2CPwrModeParm);
 }
@@ -535,7 +544,8 @@ void rtl8723b_set_FwPsTuneParam_cmd(struct adapter *padapter)
 	SET_8723B_H2CCMD_PSTUNE_PARM_ADOPT(u1H2CPsTuneParm, 1);
 	SET_8723B_H2CCMD_PSTUNE_PARM_DTIM_PERIOD(u1H2CPsTuneParm, dtim_period);
 
-	RT_PRINT_DATA(_module_hal_init_c_, _drv_always_, "u1H2CPsTuneParm:", u1H2CPsTuneParm, H2C_PSTUNEPARAM_LEN);
+	print_hex_dump_debug(DRIVER_PREFIX ": u1H2CPsTuneParm:", DUMP_PREFIX_NONE,
+			     16, 1, u1H2CPsTuneParm, H2C_PSTUNEPARAM_LEN, false);
 
 	FillH2CCmd8723B(padapter, H2C_8723B_PS_TUNING_PARA, H2C_PSTUNEPARAM_LEN, u1H2CPsTuneParm);
 }
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 0081fe0a431f..0273118e70af 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -3676,7 +3676,8 @@ void C2HPacketHandler_8723B(struct adapter *padapter, u8 *pbuffer, u16 length)
 
 	/* DBG_871X("%s C2hEvent.CmdID:%x C2hEvent.CmdLen:%x C2hEvent.CmdSeq:%x\n", */
 	/* 		__func__, C2hEvent.CmdID, C2hEvent.CmdLen, C2hEvent.CmdSeq); */
-	RT_PRINT_DATA(_module_hal_init_c_, _drv_notice_, "C2HPacketHandler_8723B(): Command Content:\n", tmpBuf, C2hEvent.CmdLen);
+	print_hex_dump_debug(DRIVER_PREFIX ": C2HPacketHandler_8723B(): Command Content:\n",
+			     DUMP_PREFIX_NONE, 16, 1, tmpBuf, C2hEvent.CmdLen, false);
 
 	process_c2h_event(padapter, &C2hEvent, tmpBuf);
 	/* c2h_handler_8723b(padapter,&C2hEvent); */
-- 
2.20.1

