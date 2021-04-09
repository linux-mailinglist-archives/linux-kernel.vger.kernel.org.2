Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7042135A36A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 18:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbhDIQcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 12:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhDIQcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 12:32:50 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D45C061760
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 09:32:36 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id r9so9624613ejj.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 09:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FdDiJbRkBDDcebgiOC7XdxzSZvzxwChwrR8HR8/ut0E=;
        b=pyoZCr8AQhYz5g/H5L3Ug1EJlJKlSXMlyhSIPnlIzDXuXej8V5IAPi6uLTe5cbvx7D
         jRcjEGPy4gifznkb+M/d/5X/yRFJgJhUub4V35pNjRBVmGqIlGCsdfGFq2GLNI+V6800
         aod3GSBS7k9Ud4uIgqs0mqdQlOHXvUPpiD33ZznTHPyJMzHTXR4+NPhjaoa7AtlgtkxY
         CIDfJqaylISAwW5vN1Q1SIoGv4pZfvKd8XcyLj2/5PopTEHUrMfZyeighytPdFfWGfTC
         EQkGQGIPAqoUTI/IDRPoaZmmVsrL49RUc47xfOGVZK8k/T3h3iaFtDHYrN9+4P1RK1VV
         IqvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FdDiJbRkBDDcebgiOC7XdxzSZvzxwChwrR8HR8/ut0E=;
        b=e485NF5gvXaw6MuYlB715XzQ6JJr2nrk06cGv/uEDnwsoEK4aWqrVTYduCroKXyTTH
         vowX5m6EW+Nrou9PtAh3os3gMT2ReNmcOI5svUDTLjSdwCDbJZXdIS051NRHOpRNO3N4
         wWZW5CT7s3q6vsJHF7PcbyU9r25Wv0Fcc5ZXjSal9U5VwD1eN/tXtBWjLki7/7cqE8a/
         UTRrYVgYWJcbKwrWohhUJ1A/BNizB++od2PCuAC4jwn21KYsb7kSgCmgocPi+2QLBHXN
         MlzDG3uUT0Hfe2zP7TOQiK3JQUbWjlPvk858LNRG/QFn9PJj3FYAeCXmyooTYpSl/t4P
         mM1Q==
X-Gm-Message-State: AOAM532CIYQcV0okaDN+6+ELDTDEtKr3SUNvdktqT8ZeXyRCZXsndl2z
        v6lN/9iUSAl79D0KaC9v2Dg=
X-Google-Smtp-Source: ABdhPJySjOA/zLhi05o2Eva85VNo7an7ue9uw5DKk1yblzwqxaLOpTASltfp5Jmc3GYVe7D1OMvZzA==
X-Received: by 2002:a17:906:b1d9:: with SMTP id bv25mr16446961ejb.230.1617985955624;
        Fri, 09 Apr 2021 09:32:35 -0700 (PDT)
Received: from localhost.localdomain (host-95-237-55-30.retail.telecomitalia.it. [95.237.55.30])
        by smtp.gmail.com with ESMTPSA id c19sm1718316edu.20.2021.04.09.09.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 09:32:34 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [Outreachy kernel] [PATCH v7 1/3] staging: rtl8723bs: Remove camelcase in several files
Date:   Fri,  9 Apr 2021 18:32:26 +0200
Message-Id: <20210409163226.25997-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove camelcase in bFwCurrentInPSMode, a variable used by code
of several subdirectories/files of the driver. Issue detected by
checkpatch.pl. Delete the unnecessary "b" (that stands for "byte") from
the beginning of the name.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

Changes from v6: Edit against the wrong patch (again).
Changes from v5: Edit against the wrong patch.
Changes from v4: Mention the removal of the initial "b" in log message.
Changes from v3: Fix errors in the format of the patch.
Changes from v2: Remove unnecessary comment. Shortened a function name.
Changes from v1: No changes to the code but only to the subject for the
purpose to differentiate this patch because other removes of camelcase
have been made in other files of the same directory.

 drivers/staging/rtl8723bs/core/rtw_cmd.c       |  2 +-
 drivers/staging/rtl8723bs/core/rtw_mlme.c      |  2 +-
 drivers/staging/rtl8723bs/core/rtw_pwrctrl.c   | 18 +++++++++---------
 drivers/staging/rtl8723bs/hal/hal_intf.c       |  2 +-
 drivers/staging/rtl8723bs/hal/rtl8723b_dm.c    |  6 +++---
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c  |  2 +-
 drivers/staging/rtl8723bs/hal/sdio_ops.c       | 14 +++++++-------
 .../staging/rtl8723bs/include/rtw_pwrctrl.h    |  2 +-
 8 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index baf8b1e0f43c..feb53b8c0ff2 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -1510,7 +1510,7 @@ static void rtw_lps_change_dtim_hdl(struct adapter *padapter, u8 dtim)
 	if (pwrpriv->dtim != dtim)
 		pwrpriv->dtim = dtim;
 
-	if ((pwrpriv->bFwCurrentInPSMode == true) && (pwrpriv->pwr_mode > PS_MODE_ACTIVE)) {
+	if ((pwrpriv->fw_current_in_ps_mode == true) && (pwrpriv->pwr_mode > PS_MODE_ACTIVE)) {
 		u8 ps_mode = pwrpriv->pwr_mode;
 
 		rtw_hal_set_hwreg(padapter, HW_VAR_H2C_FW_PWRMODE, (u8 *)(&ps_mode));
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index a7e40aaae2d9..895997868c81 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -1684,7 +1684,7 @@ void rtw_dynamic_check_timer_handler(struct adapter *adapter)
 	if (adapter->net_closed)
 		return;
 
-	if ((adapter_to_pwrctl(adapter)->bFwCurrentInPSMode)
+	if ((adapter_to_pwrctl(adapter)->fw_current_in_ps_mode)
 		&& !(hal_btcoex_IsBtControlLps(adapter))
 		) {
 		u8 bEnterPS;
diff --git a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
index f7465cf90c46..481e2ad60853 100644
--- a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
+++ b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
@@ -365,7 +365,7 @@ void rtw_set_ps_mode(struct adapter *padapter, u8 ps_mode, u8 smart_ps, u8 bcn_a
 			rtw_set_rpwm(padapter, PS_STATE_S4);
 
 			rtw_hal_set_hwreg(padapter, HW_VAR_H2C_FW_PWRMODE, (u8 *)(&ps_mode));
-			pwrpriv->bFwCurrentInPSMode = false;
+			pwrpriv->fw_current_in_ps_mode = false;
 
 			hal_btcoex_LpsNotify(padapter, ps_mode);
 		}
@@ -377,7 +377,7 @@ void rtw_set_ps_mode(struct adapter *padapter, u8 ps_mode, u8 smart_ps, u8 bcn_a
 
 			hal_btcoex_LpsNotify(padapter, ps_mode);
 
-			pwrpriv->bFwCurrentInPSMode = true;
+			pwrpriv->fw_current_in_ps_mode = true;
 			pwrpriv->pwr_mode = ps_mode;
 			pwrpriv->smart_ps = smart_ps;
 			pwrpriv->bcn_ant_mode = bcn_ant_mode;
@@ -734,7 +734,7 @@ s32 rtw_register_task_alive(struct adapter *padapter, u32 task)
 
 	register_task_alive(pwrctrl, task);
 
-	if (pwrctrl->bFwCurrentInPSMode) {
+	if (pwrctrl->fw_current_in_ps_mode) {
 		if (pwrctrl->cpwm < pslv) {
 			if (pwrctrl->cpwm < PS_STATE_S2)
 				res = _FAIL;
@@ -782,7 +782,7 @@ void rtw_unregister_task_alive(struct adapter *padapter, u32 task)
 
 	unregister_task_alive(pwrctrl, task);
 
-	if ((pwrctrl->pwr_mode != PS_MODE_ACTIVE) && pwrctrl->bFwCurrentInPSMode) {
+	if ((pwrctrl->pwr_mode != PS_MODE_ACTIVE) && pwrctrl->fw_current_in_ps_mode) {
 		if (pwrctrl->cpwm > pslv)
 			if ((pslv >= PS_STATE_S2) || (pwrctrl->alives == 0))
 				rtw_set_rpwm(padapter, pslv);
@@ -819,7 +819,7 @@ s32 rtw_register_tx_alive(struct adapter *padapter)
 
 	register_task_alive(pwrctrl, XMIT_ALIVE);
 
-	if (pwrctrl->bFwCurrentInPSMode) {
+	if (pwrctrl->fw_current_in_ps_mode) {
 		if (pwrctrl->cpwm < pslv) {
 			if (pwrctrl->cpwm < PS_STATE_S2)
 				res = _FAIL;
@@ -864,7 +864,7 @@ s32 rtw_register_cmd_alive(struct adapter *padapter)
 
 	register_task_alive(pwrctrl, CMD_ALIVE);
 
-	if (pwrctrl->bFwCurrentInPSMode) {
+	if (pwrctrl->fw_current_in_ps_mode) {
 		if (pwrctrl->cpwm < pslv) {
 			if (pwrctrl->cpwm < PS_STATE_S2)
 				res = _FAIL;
@@ -909,7 +909,7 @@ void rtw_unregister_tx_alive(struct adapter *padapter)
 
 	unregister_task_alive(pwrctrl, XMIT_ALIVE);
 
-	if ((pwrctrl->pwr_mode != PS_MODE_ACTIVE) && pwrctrl->bFwCurrentInPSMode) {
+	if ((pwrctrl->pwr_mode != PS_MODE_ACTIVE) && pwrctrl->fw_current_in_ps_mode) {
 		if (pwrctrl->cpwm > pslv)
 			if ((pslv >= PS_STATE_S2) || (pwrctrl->alives == 0))
 				rtw_set_rpwm(padapter, pslv);
@@ -945,7 +945,7 @@ void rtw_unregister_cmd_alive(struct adapter *padapter)
 
 	unregister_task_alive(pwrctrl, CMD_ALIVE);
 
-	if ((pwrctrl->pwr_mode != PS_MODE_ACTIVE) && pwrctrl->bFwCurrentInPSMode) {
+	if ((pwrctrl->pwr_mode != PS_MODE_ACTIVE) && pwrctrl->fw_current_in_ps_mode) {
 		if (pwrctrl->cpwm > pslv) {
 			if ((pslv >= PS_STATE_S2) || (pwrctrl->alives == 0))
 				rtw_set_rpwm(padapter, pslv);
@@ -978,7 +978,7 @@ void rtw_init_pwrctrl_priv(struct adapter *padapter)
 	pwrctrlpriv->power_mgnt = padapter->registrypriv.power_mgnt;/*  PS_MODE_MIN; */
 	pwrctrlpriv->bLeisurePs = pwrctrlpriv->power_mgnt != PS_MODE_ACTIVE;
 
-	pwrctrlpriv->bFwCurrentInPSMode = false;
+	pwrctrlpriv->fw_current_in_ps_mode = false;
 
 	pwrctrlpriv->rpwm = 0;
 	pwrctrlpriv->cpwm = PS_STATE_S4;
diff --git a/drivers/staging/rtl8723bs/hal/hal_intf.c b/drivers/staging/rtl8723bs/hal/hal_intf.c
index bc9ae2088754..96fe172ced8d 100644
--- a/drivers/staging/rtl8723bs/hal/hal_intf.c
+++ b/drivers/staging/rtl8723bs/hal/hal_intf.c
@@ -348,7 +348,7 @@ void rtw_hal_dm_watchdog(struct adapter *padapter)
 
 void rtw_hal_dm_watchdog_in_lps(struct adapter *padapter)
 {
-	if (adapter_to_pwrctl(padapter)->bFwCurrentInPSMode == true) {
+	if (adapter_to_pwrctl(padapter)->fw_current_in_ps_mode == true) {
 		if (padapter->HalFunc.hal_dm_watchdog_in_lps)
 			padapter->HalFunc.hal_dm_watchdog_in_lps(padapter); /* this function caller is in interrupt context */
 	}
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_dm.c b/drivers/staging/rtl8723bs/hal/rtl8723b_dm.c
index c2e9e4a0be22..23be025ceb5b 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_dm.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_dm.c
@@ -141,7 +141,7 @@ void rtl8723b_InitHalDm(struct adapter *Adapter)
 
 void rtl8723b_HalDmWatchDog(struct adapter *Adapter)
 {
-	bool bFwCurrentInPSMode = false;
+	bool fw_current_in_ps_mode = false;
 	bool bFwPSAwake = true;
 	u8 hw_init_completed = false;
 	struct hal_com_data *pHalData = GET_HAL_DATA(Adapter);
@@ -151,12 +151,12 @@ void rtl8723b_HalDmWatchDog(struct adapter *Adapter)
 	if (hw_init_completed == false)
 		goto skip_dm;
 
-	bFwCurrentInPSMode = adapter_to_pwrctl(Adapter)->bFwCurrentInPSMode;
+	fw_current_in_ps_mode = adapter_to_pwrctl(Adapter)->fw_current_in_ps_mode;
 	rtw_hal_get_hwreg(Adapter, HW_VAR_FWLPS_RF_ON, (u8 *)(&bFwPSAwake));
 
 	if (
 		(hw_init_completed == true) &&
-		((!bFwCurrentInPSMode) && bFwPSAwake)
+		((!fw_current_in_ps_mode) && bFwPSAwake)
 	) {
 		/*  */
 		/*  Calculate Tx/Rx statistics. */
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index e31ad3feed62..1ab0c9e8760b 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -430,7 +430,7 @@ void rtl8723b_InitializeFirmwareVars(struct adapter *padapter)
 	struct hal_com_data *pHalData = GET_HAL_DATA(padapter);
 
 	/*  Init Fw LPS related. */
-	adapter_to_pwrctl(padapter)->bFwCurrentInPSMode = false;
+	adapter_to_pwrctl(padapter)->fw_current_in_ps_mode = false;
 
 	/* Init H2C cmd. */
 	rtw_write8(padapter, REG_HMETFR, 0x0f);
diff --git a/drivers/staging/rtl8723bs/hal/sdio_ops.c b/drivers/staging/rtl8723bs/hal/sdio_ops.c
index af7f846f90fe..abe8f2f8f452 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_ops.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_ops.c
@@ -173,7 +173,7 @@ static u32 sdio_read32(struct intf_hdl *intfhdl, u32 addr)
 	if (
 		((device_id == WLAN_IOREG_DEVICE_ID) && (offset < 0x100)) ||
 		(!mac_pwr_ctrl_on) ||
-		(adapter_to_pwrctl(adapter)->bFwCurrentInPSMode)
+		(adapter_to_pwrctl(adapter)->fw_current_in_ps_mode)
 	) {
 		err = sd_cmd52_read(intfhdl, ftaddr, 4, (u8 *)&le_tmp);
 #ifdef SDIO_DEBUG_IO
@@ -230,7 +230,7 @@ static s32 sdio_readN(struct intf_hdl *intfhdl, u32 addr, u32 cnt, u8 *buf)
 	if (
 		((device_id == WLAN_IOREG_DEVICE_ID) && (offset < 0x100)) ||
 		(!mac_pwr_ctrl_on) ||
-		(adapter_to_pwrctl(adapter)->bFwCurrentInPSMode)
+		(adapter_to_pwrctl(adapter)->fw_current_in_ps_mode)
 	)
 		return sd_cmd52_read(intfhdl, ftaddr, cnt, buf);
 
@@ -297,7 +297,7 @@ static s32 sdio_write32(struct intf_hdl *intfhdl, u32 addr, u32 val)
 	if (
 		((device_id == WLAN_IOREG_DEVICE_ID) && (offset < 0x100)) ||
 		(!mac_pwr_ctrl_on) ||
-		(adapter_to_pwrctl(adapter)->bFwCurrentInPSMode)
+		(adapter_to_pwrctl(adapter)->fw_current_in_ps_mode)
 	) {
 		le_tmp = cpu_to_le32(val);
 
@@ -334,7 +334,7 @@ static s32 sdio_writeN(struct intf_hdl *intfhdl, u32 addr, u32 cnt, u8 *buf)
 	if (
 		((device_id == WLAN_IOREG_DEVICE_ID) && (offset < 0x100)) ||
 		(!mac_pwr_ctrl_on) ||
-		(adapter_to_pwrctl(adapter)->bFwCurrentInPSMode)
+		(adapter_to_pwrctl(adapter)->fw_current_in_ps_mode)
 	)
 		return sd_cmd52_write(intfhdl, ftaddr, cnt, buf);
 
@@ -565,7 +565,7 @@ s32 sdio_local_read(
 	rtw_hal_get_hwreg(adapter, HW_VAR_APFM_ON_MAC, &mac_pwr_ctrl_on);
 	if (
 		(!mac_pwr_ctrl_on) ||
-		(adapter_to_pwrctl(adapter)->bFwCurrentInPSMode)
+		(adapter_to_pwrctl(adapter)->fw_current_in_ps_mode)
 	)
 		return sd_cmd52_read(intfhdl, addr, cnt, buf);
 
@@ -611,7 +611,7 @@ s32 sdio_local_write(
 	rtw_hal_get_hwreg(adapter, HW_VAR_APFM_ON_MAC, &mac_pwr_ctrl_on);
 	if (
 		(!mac_pwr_ctrl_on) ||
-		(adapter_to_pwrctl(adapter)->bFwCurrentInPSMode)
+		(adapter_to_pwrctl(adapter)->fw_current_in_ps_mode)
 	)
 		return sd_cmd52_write(intfhdl, addr, cnt, buf);
 
@@ -660,7 +660,7 @@ static u32 sdio_local_cmd53_read4byte(struct adapter *adapter, u32 addr)
 
 	hal_sdio_get_cmd_addr_8723b(adapter, SDIO_LOCAL_DEVICE_ID, addr, &addr);
 	rtw_hal_get_hwreg(adapter, HW_VAR_APFM_ON_MAC, &mac_pwr_ctrl_on);
-	if (!mac_pwr_ctrl_on || adapter_to_pwrctl(adapter)->bFwCurrentInPSMode) {
+	if (!mac_pwr_ctrl_on || adapter_to_pwrctl(adapter)->fw_current_in_ps_mode) {
 		sd_cmd52_read(intfhdl, addr, 4, (u8 *)&le_tmp);
 		val = le32_to_cpu(le_tmp);
 	} else {
diff --git a/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h b/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h
index 2e739a17dd95..5450d20b44a6 100644
--- a/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h
+++ b/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h
@@ -203,7 +203,7 @@ struct pwrctrl_priv {
 	u8 LpsIdleCount;
 	u8 power_mgnt;
 	u8 org_power_mgnt;
-	u8 bFwCurrentInPSMode;
+	u8 fw_current_in_ps_mode;
 	unsigned long	DelayLPSLastTimeStamp;
 	s32		pnp_current_pwr_state;
 	u8 pnp_bstop_trx;
-- 
2.31.1

