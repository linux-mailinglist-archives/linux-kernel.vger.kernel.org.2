Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A28B53DF7FD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 00:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbhHCWhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 18:37:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:54410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232300AbhHCWhD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 18:37:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 39B7661029;
        Tue,  3 Aug 2021 22:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628030211;
        bh=4hECRyJ4G6FNQH8N0SCFhjMCz9BnYV9cHIYw9rsHWEs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I5sdIuGY2toAYxGgFqlAfX2giduQczpBge2cja9xZfjxfg2oZOfX6JyUNd+CSX1WT
         7GZrODTnWyoC3lo1FQn9YihPoQc2wBtatNg6jeFF9bt+mbgoOztjtmAPmRoRlOaREg
         /7XyfFxX4KwH6zIEdT+MSBT7urs4CVq58DCOYQYnE3Ltgzf2wHl2LW1wR8jolVlJS1
         0Bf2V2TgMveZ5x+x5S+Ca8hCbkL0DCpxIkdZugOGQWJToLrfr4QvR46QPpV7aZisPv
         GYO+XuNGlYR9qSFUzQkehICv22XH9hdhO8YB36CmtGI0KtOGsD88ekcFqCkTvwjba5
         qyXnOriLobHZA==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Phillip Potter <phil@philpotter.co.uk>,
        Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 2/4] staging: r8188eu: Remove unnecessary parentheses
Date:   Tue,  3 Aug 2021 15:36:07 -0700
Message-Id: <20210803223609.1627280-3-nathan@kernel.org>
X-Mailer: git-send-email 2.33.0.rc0
In-Reply-To: <20210803223609.1627280-1-nathan@kernel.org>
References: <20210803223609.1627280-1-nathan@kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns several times across the driver along the lines of:

drivers/staging/r8188eu/core/rtw_pwrctrl.c:222:21: warning: equality
comparison with extraneous parentheses [-Wparentheses-equality]
        if ((pwrpriv->rpwm == pslv)) {
             ~~~~~~~~~~~~~~^~~~~~~
drivers/staging/r8188eu/core/rtw_pwrctrl.c:222:21: note: remove
extraneous parentheses around the comparison to silence this warning
        if ((pwrpriv->rpwm == pslv)) {
            ~              ^      ~
drivers/staging/r8188eu/core/rtw_pwrctrl.c:222:21: note: use '=' to turn
this equality comparison into an assignment
        if ((pwrpriv->rpwm == pslv)) {
                           ^~
                           =
1 warning generated.

The compilers have agreed that single parentheses are used for equality
and double parentheses are used for assignment within control flow
statements such as if and while so remove them in these places to fix
the warning.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/staging/r8188eu/core/rtw_pwrctrl.c   | 2 +-
 drivers/staging/r8188eu/core/rtw_security.c  | 4 ++--
 drivers/staging/r8188eu/core/rtw_wlan_util.c | 2 +-
 drivers/staging/r8188eu/hal/odm.c            | 2 +-
 drivers/staging/r8188eu/hal/usb_halinit.c    | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_pwrctrl.c b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
index d67eeb045002..598c32d7eaa5 100644
--- a/drivers/staging/r8188eu/core/rtw_pwrctrl.c
+++ b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
@@ -219,7 +219,7 @@ void rtw_set_rpwm(struct adapter *padapter, u8 pslv)
 			pslv = PS_STATE_S3;
 	}
 
-	if ((pwrpriv->rpwm == pslv)) {
+	if (pwrpriv->rpwm == pslv) {
 		RT_TRACE(_module_rtl871x_pwrctrl_c_, _drv_err_,
 			 ("%s: Already set rpwm[0x%02X], new=0x%02X!\n", __func__, pwrpriv->rpwm, pslv));
 		return;
diff --git a/drivers/staging/r8188eu/core/rtw_security.c b/drivers/staging/r8188eu/core/rtw_security.c
index 2c1b9a6dcdf2..45fd8b1aeb59 100644
--- a/drivers/staging/r8188eu/core/rtw_security.c
+++ b/drivers/staging/r8188eu/core/rtw_security.c
@@ -1211,7 +1211,7 @@ u32	rtw_aes_encrypt(struct adapter *padapter, u8 *pxmitframe)
 	pframe = ((struct xmit_frame *)pxmitframe)->buf_addr + hw_hdr_offset;
 
 	/* 4 start to encrypt each fragment */
-	if ((pattrib->encrypt == _AES_)) {
+	if (pattrib->encrypt == _AES_) {
 		if (pattrib->psta)
 			stainfo = pattrib->psta;
 		else
@@ -1454,7 +1454,7 @@ u32	rtw_aes_decrypt(struct adapter *padapter, u8 *precvframe)
 
 	pframe = (unsigned char *)((struct recv_frame *)precvframe)->rx_data;
 	/* 4 start to encrypt each fragment */
-	if ((prxattrib->encrypt == _AES_)) {
+	if (prxattrib->encrypt == _AES_) {
 		stainfo = rtw_get_stainfo(&padapter->stapriv, &prxattrib->ta[0]);
 		if (stainfo != NULL) {
 			RT_TRACE(_module_rtl871x_security_c_, _drv_err_, ("rtw_aes_decrypt: stainfo!= NULL!!!\n"));
diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
index 15edccef9f1d..4a8e52484cfd 100644
--- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
@@ -1306,7 +1306,7 @@ int support_short_GI(struct adapter *padapter, struct HT_caps_element *pHT_caps)
 	if (!(pmlmeinfo->HT_enable))
 		return _FAIL;
 
-	if ((pmlmeinfo->assoc_AP_vendor == HT_IOT_PEER_RALINK))
+	if (pmlmeinfo->assoc_AP_vendor == HT_IOT_PEER_RALINK)
 		return _FAIL;
 
 	bit_offset = (pmlmeext->cur_bwmode & HT_CHANNEL_WIDTH_40) ? 6 : 5;
diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index 0bc836311036..65a117408d50 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -1631,7 +1631,7 @@ void odm_EdcaTurboCheckCE(struct odm_dm_struct *pDM_Odm)
 	struct mlme_ext_priv	*pmlmeext = &(Adapter->mlmeextpriv);
 	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
 
-	if ((pregpriv->wifi_spec == 1))/*  (pmlmeinfo->HT_enable == 0)) */
+	if (pregpriv->wifi_spec == 1)
 		goto dm_CheckEdcaTurbo_EXIT;
 
 	if (pmlmeinfo->assoc_AP_vendor >=  HT_IOT_PEER_MAX)
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index d985894c0f30..ec7badfd72aa 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1300,7 +1300,7 @@ static void hw_var_set_opmode(struct adapter *Adapter, u8 variable, u8 *val)
 		StopTxBeacon(Adapter);
 
 		rtw_write8(Adapter, REG_BCN_CTRL, 0x19);/* disable atim wnd */
-	} else if ((mode == _HW_STATE_ADHOC_)) {
+	} else if (mode == _HW_STATE_ADHOC_) {
 		ResumeTxBeacon(Adapter);
 		rtw_write8(Adapter, REG_BCN_CTRL, 0x1a);
 	} else if (mode == _HW_STATE_AP_) {
-- 
2.33.0.rc0

