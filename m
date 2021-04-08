Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECA03584BB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 15:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbhDHNa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 09:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbhDHNax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 09:30:53 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F4BC061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 06:30:41 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id g17so286733ejp.8
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 06:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fKWx0+q7MvIF2MRm1YPI9fNkmUi0TcoIcXeiw/XDF/k=;
        b=B25uSI9CVYuS9bRfHANBOsdviQbM8VNpzKdKtX6rDFh4BkbHQEGGqpAMzGlT+rrfl+
         7bPmRlkQMv7Nw/sSIf1svC+TgDdCMDkBSzi+EyLbeEo0vn7rrf/JLS7tSurEmndeXKth
         3IWSJ4Dyu+0He9Q6ZGb27SjlJt71/koc36D3LoC/frmk9NsEo/Odgnln39rUsQ0nUT/h
         JF5d/ajsC/AsQjQ/n/NAPduYlAaCowSLo6K2/MQbpSaxEuOs/jEzhMX2yynxwJh7tIYS
         OSqP1+5OeWXwByJEQX+OrNFF993ZJG3FniGpj2GyDgkEqRCLzkWLo7ntdl5WoLgXijMv
         TfLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fKWx0+q7MvIF2MRm1YPI9fNkmUi0TcoIcXeiw/XDF/k=;
        b=OedODzmvalbE9NzT9UEfNoKJbIVVoBwWqaEb0gtOxGMN3dvhyWj0o3QHRSdhS3JvxH
         nQeja/K1/leFct7xhD0UKStg6OCiS9UIVKxI4L0IPlTTQQyj0N5VcaepJHSY5gTD3Hjm
         IJfT3ci6smhjsDxqs/emuXGh63+KeqE1WRngTwP0SiJACDJosUQ5WFtHwK04lDUXoFIb
         heQRSAXqASZPG1zQipa+vYEhOY+Z1tNGimxnvp208KUN2q8wfS8j3TOCxtZTZCuzIH+c
         g9vgLi8j/KTL2LbZDCX+RGTKj/t2Pk9h6tyzhX0RwDzXfv5FTb8EIYPC77HiDX1WbbNc
         50cw==
X-Gm-Message-State: AOAM533epvEpvHeG08VhhQ3hlATQ42BP0Z/+U5YTQyCrU0YsYTmLK/XJ
        qm55ylg2C2hyUdzAAz6LJgJA4WENPo3gwJ6n
X-Google-Smtp-Source: ABdhPJytY1frgTL0ysxSZTz5ZjhFXrhaSbf3gGgvDy5IS4Cj9eDYUYWmZWrLpESi9iQiiVL5tFxeuQ==
X-Received: by 2002:a17:906:4017:: with SMTP id v23mr4141823ejj.421.1617888640202;
        Thu, 08 Apr 2021 06:30:40 -0700 (PDT)
Received: from localhost.localdomain (host-79-42-91-147.retail.telecomitalia.it. [79.42.91.147])
        by smtp.gmail.com with ESMTPSA id r17sm17574066edt.70.2021.04.08.06.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 06:30:39 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [Outreachy kernel] [PATCH v4] staging: rtl8723bs: Remove camelcase in several files
Date:   Thu,  8 Apr 2021 15:30:36 +0200
Message-Id: <20210408133036.7324-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove camelcase in bFwCurrentInPSMode, a variable used by code
of several subdirectories/files of the driver. Issue detected by
checkpatch.pl.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

Changes from v3: Discard v3 because "b_" is not yet removed.
Changes from v2: Discard v2 because it is a diff against v1 instead of a
replacement for v1.
Changes from v1: Rewrite comment for the purpose of specifying which
variable changes. Shorten its name by removing two unnecessary
characters (b_).

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
index baf8b1e0f43c..a08f22b53592 100644
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
index a7e40aaae2d9..51cea6cf46e7 100644
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
index f7465cf90c46..21e7a847866f 100644
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
index bc9ae2088754..a73c2f76628d 100644
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
index c2e9e4a0be22..265db187b8d5 100644
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
index e31ad3feed62..7ebc438870fd 100644
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
index af7f846f90fe..c78a6724fc1c 100644
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
index 2e739a17dd95..fcb06a95fdf6 100644
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
2.30.2

