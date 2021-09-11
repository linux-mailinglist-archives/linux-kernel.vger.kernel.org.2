Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEFB24078B8
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 16:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236367AbhIKOR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 10:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236220AbhIKORU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 10:17:20 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F245C061756
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 07:16:08 -0700 (PDT)
Received: from dslb-084-059-243-091.084.059.pools.vodafone-ip.de ([84.59.243.91] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mP3nW-0006bt-MM; Sat, 11 Sep 2021 16:16:02 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 05/12] staging: r8188eu: remove rtw_set_rpwm
Date:   Sat, 11 Sep 2021 16:15:14 +0200
Message-Id: <20210911141521.24901-6-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210911141521.24901-1-martin@kaiser.cx>
References: <20210911141521.24901-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After we dropped the call to set HW_VAR_SET_RPWM, the rtw_set_rpwm
function doesn't do anything useful.

Remove the function and the rpwm component of struct pwrctrl_priv,
which is not used outside of rtw_set_rpwm.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 .../realtek/rtl8192cu/include/rtw_pwrctrl.h   |  1 -
 drivers/staging/r8188eu/core/rtw_pwrctrl.c    | 34 -------------------
 drivers/staging/r8188eu/include/rtw_pwrctrl.h |  2 --
 3 files changed, 37 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8192cu/include/rtw_pwrctrl.h b/drivers/net/wireless/realtek/rtl8192cu/include/rtw_pwrctrl.h
index a4cb292e1aea..303df55c521a 100644
--- a/drivers/net/wireless/realtek/rtl8192cu/include/rtw_pwrctrl.h
+++ b/drivers/net/wireless/realtek/rtl8192cu/include/rtw_pwrctrl.h
@@ -309,7 +309,6 @@ extern void cpwm_int_hdl(PADAPTER padapter, struct reportpwrstate_parm *preportp
 #endif
 
 extern void rtw_set_ps_mode(_adapter * padapter, u8 ps_mode, u8 smart_ps);
-extern void rtw_set_rpwm(_adapter * padapter, u8 val8);
 extern void LeaveAllPowerSaveMode(PADAPTER Adapter);
 #ifdef CONFIG_IPS
 void _ips_enter(_adapter * padapter);
diff --git a/drivers/staging/r8188eu/core/rtw_pwrctrl.c b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
index 86841093caa8..5b4cd8e738db 100644
--- a/drivers/staging/r8188eu/core/rtw_pwrctrl.c
+++ b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
@@ -186,35 +186,6 @@ static void pwr_state_check_handler(struct timer_list *t)
 	rtw_ps_cmd(padapter);
 }
 
-/*
- *
- * Parameters
- *	padapter
- *	pslv			power state level, only could be PS_STATE_S0 ~ PS_STATE_S4
- *
- */
-void rtw_set_rpwm(struct adapter *padapter, u8 pslv)
-{
-	struct pwrctrl_priv *pwrpriv = &padapter->pwrctrlpriv;
-
-	pslv = PS_STATE(pslv);
-
-	if (pwrpriv->rpwm == pslv)
-		return;
-
-	if ((padapter->bSurpriseRemoved) ||
-	    (!padapter->hw_init_completed)) {
-		return;
-	}
-
-	if (padapter->bDriverStopped) {
-		if (pslv < PS_STATE_S2)
-			return;
-	}
-
-	pwrpriv->rpwm = pslv;
-}
-
 static u8 PS_RDY_CHECK(struct adapter *padapter)
 {
 	u32 curr_time, delta_time;
@@ -264,7 +235,6 @@ void rtw_set_ps_mode(struct adapter *padapter, u8 ps_mode, u8 smart_ps, u8 bcn_a
 		if (pwdinfo->opp_ps == 0) {
 			DBG_88E("rtw_set_ps_mode: Leave 802.11 power save\n");
 			pwrpriv->pwr_mode = ps_mode;
-			rtw_set_rpwm(padapter, PS_STATE_S4);
 			rtw_hal_set_hwreg(padapter, HW_VAR_H2C_FW_PWRMODE, (u8 *)(&ps_mode));
 			pwrpriv->bFwCurrentInPSMode = false;
 		}
@@ -280,8 +250,6 @@ void rtw_set_ps_mode(struct adapter *padapter, u8 ps_mode, u8 smart_ps, u8 bcn_a
 			/*  Set CTWindow after LPS */
 			if (pwdinfo->opp_ps == 1)
 				p2p_ps_wk_cmd(padapter, P2P_PS_ENABLE, 0);
-
-			rtw_set_rpwm(padapter, PS_STATE_S2);
 		}
 	}
 
@@ -416,8 +384,6 @@ void rtw_init_pwrctrl_priv(struct adapter *padapter)
 
 	pwrctrlpriv->bFwCurrentInPSMode = false;
 
-	pwrctrlpriv->rpwm = 0;
-
 	pwrctrlpriv->pwr_mode = PS_MODE_ACTIVE;
 	pwrctrlpriv->smart_ps = padapter->registrypriv.smart_ps;
 	pwrctrlpriv->bcn_ant_mode = 0;
diff --git a/drivers/staging/r8188eu/include/rtw_pwrctrl.h b/drivers/staging/r8188eu/include/rtw_pwrctrl.h
index 5be67644ba5f..08d821575755 100644
--- a/drivers/staging/r8188eu/include/rtw_pwrctrl.h
+++ b/drivers/staging/r8188eu/include/rtw_pwrctrl.h
@@ -151,7 +151,6 @@ enum { /*  for ips_mode */
 
 struct pwrctrl_priv {
 	struct semaphore lock;
-	volatile u8 rpwm; /*  requested power state for fw */
 	volatile u8 cpwm_tog; /*  toggling */
 
 	u8	pwr_mode;
@@ -234,7 +233,6 @@ void rtw_free_pwrctrl_priv(struct adapter *adapter);
 
 void rtw_set_ps_mode(struct adapter *adapter, u8 ps_mode, u8 smart_ps,
 		     u8 bcn_ant_mode);
-void rtw_set_rpwm(struct adapter *adapter, u8 val8);
 void LeaveAllPowerSaveMode(struct adapter *adapter);
 void ips_enter(struct adapter *padapter);
 int ips_leave(struct adapter *padapter);
-- 
2.20.1

