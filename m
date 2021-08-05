Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF2D63E1BE4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 20:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241976AbhHES6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 14:58:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:44874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241727AbhHES6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 14:58:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8723960EE9;
        Thu,  5 Aug 2021 18:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628189920;
        bh=qCuN3VA/q23q1eiUgrcjVmU0aIHSITFJq4nsUrauhy0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JN/9R2TglOcCERJK8Sb6jGyVBJrPnoiCPQat1lh26qaZC8PkpHfrBh6g76R8jO9ON
         n1l1fOIaYRjGUJePyNEz4h3ySUxxzQoC4RplYDaNZA3ffCi45jW1ECOZbUQBVXyDqj
         A92WEznSVkeRefusXgURGGi6fjQA/VRRdkpXJm4DNmiXwu+XBlEn4REWteUVeRTJR5
         /ydawm1Xi+zOOGjHcG56wIh1Tb1wKC+vfw798nUGWH7iKFnu0dnuG8onm6gN6bm21I
         Elz8tSaGazQUFrurO2UYQmvOKb8KzmNPIjfmlNcChVMX8e+yNZFtX8I+0+/yCb1jgr
         LnYTU7y7HBvOw==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Phillip Potter <phil@philpotter.co.uk>,
        Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v2 1/3] staging: r8188eu: Remove unnecessary parentheses
Date:   Thu,  5 Aug 2021 11:58:05 -0700
Message-Id: <20210805185807.3296077-2-nathan@kernel.org>
X-Mailer: git-send-email 2.33.0.rc0
In-Reply-To: <20210805185807.3296077-1-nathan@kernel.org>
References: <20210803223609.1627280-1-nathan@kernel.org>
 <20210805185807.3296077-1-nathan@kernel.org>
MIME-Version: 1.0
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
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
---
 drivers/staging/r8188eu/core/rtw_pwrctrl.c   | 2 +-
 drivers/staging/r8188eu/core/rtw_security.c  | 4 ++--
 drivers/staging/r8188eu/core/rtw_wlan_util.c | 2 +-
 drivers/staging/r8188eu/hal/odm.c            | 2 +-
 drivers/staging/r8188eu/hal/usb_halinit.c    | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_pwrctrl.c b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
index 2c029f85d63d..967c9623e7d1 100644
--- a/drivers/staging/r8188eu/core/rtw_pwrctrl.c
+++ b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
@@ -218,7 +218,7 @@ void rtw_set_rpwm(struct adapter *padapter, u8 pslv)
 			pslv = PS_STATE_S3;
 	}
 
-	if ((pwrpriv->rpwm == pslv))
+	if (pwrpriv->rpwm == pslv)
 		return;
 
 	if ((padapter->bSurpriseRemoved) ||
diff --git a/drivers/staging/r8188eu/core/rtw_security.c b/drivers/staging/r8188eu/core/rtw_security.c
index df8107a0f5f2..08a5a1975d11 100644
--- a/drivers/staging/r8188eu/core/rtw_security.c
+++ b/drivers/staging/r8188eu/core/rtw_security.c
@@ -1209,7 +1209,7 @@ u32	rtw_aes_encrypt(struct adapter *padapter, u8 *pxmitframe)
 	pframe = ((struct xmit_frame *)pxmitframe)->buf_addr + hw_hdr_offset;
 
 	/* 4 start to encrypt each fragment */
-	if ((pattrib->encrypt == _AES_)) {
+	if (pattrib->encrypt == _AES_) {
 		if (pattrib->psta)
 			stainfo = pattrib->psta;
 		else
@@ -1452,7 +1452,7 @@ u32	rtw_aes_decrypt(struct adapter *padapter, u8 *precvframe)
 
 	pframe = (unsigned char *)((struct recv_frame *)precvframe)->rx_data;
 	/* 4 start to encrypt each fragment */
-	if ((prxattrib->encrypt == _AES_)) {
+	if (prxattrib->encrypt == _AES_) {
 		stainfo = rtw_get_stainfo(&padapter->stapriv, &prxattrib->ta[0]);
 		if (stainfo) {
 			RT_TRACE(_module_rtl871x_security_c_, _drv_err_, ("rtw_aes_decrypt: stainfo!= NULL!!!\n"));
diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
index 5a9a824dcbfd..21a3d0868214 100644
--- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
@@ -1283,7 +1283,7 @@ int support_short_GI(struct adapter *padapter, struct HT_caps_element *pHT_caps)
 	if (!(pmlmeinfo->HT_enable))
 		return _FAIL;
 
-	if ((pmlmeinfo->assoc_AP_vendor == HT_IOT_PEER_RALINK))
+	if (pmlmeinfo->assoc_AP_vendor == HT_IOT_PEER_RALINK)
 		return _FAIL;
 
 	bit_offset = (pmlmeext->cur_bwmode & HT_CHANNEL_WIDTH_40) ? 6 : 5;
diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index 08ec1e18b3f0..0deeb21c8006 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -1630,7 +1630,7 @@ void odm_EdcaTurboCheckCE(struct odm_dm_struct *pDM_Odm)
 	struct mlme_ext_priv	*pmlmeext = &(Adapter->mlmeextpriv);
 	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
 
-	if ((pregpriv->wifi_spec == 1))/*  (pmlmeinfo->HT_enable == 0)) */
+	if (pregpriv->wifi_spec == 1)
 		goto dm_CheckEdcaTurbo_EXIT;
 
 	if (pmlmeinfo->assoc_AP_vendor >=  HT_IOT_PEER_MAX)
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index b214b7b1e9de..c2d9c0359e64 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1277,7 +1277,7 @@ static void hw_var_set_opmode(struct adapter *Adapter, u8 variable, u8 *val)
 		StopTxBeacon(Adapter);
 
 		rtw_write8(Adapter, REG_BCN_CTRL, 0x19);/* disable atim wnd */
-	} else if ((mode == _HW_STATE_ADHOC_)) {
+	} else if (mode == _HW_STATE_ADHOC_) {
 		ResumeTxBeacon(Adapter);
 		rtw_write8(Adapter, REG_BCN_CTRL, 0x1a);
 	} else if (mode == _HW_STATE_AP_) {
-- 
2.33.0.rc0

