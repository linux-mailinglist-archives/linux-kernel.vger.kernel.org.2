Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2873E34B2
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 12:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbhHGKPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 06:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbhHGKMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 06:12:51 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B75C0617A4
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 03:12:18 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id f13so16790742edq.13
        for <linux-kernel@vger.kernel.org>; Sat, 07 Aug 2021 03:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tvbz591DMvF33ax+eSb+xGGBL3Gl9La/xcKDxZqOIrc=;
        b=nNbpH9VI4QXpNIUCbOHAvftGA6YWJyo6vOc4RRQ+U7dAMvgRah+Z4N0RYZ441WpSPF
         3trYmIBAh7ImGeRmTelL+u9ZzEMmtRAd+gfp+NjXx9jfpCmbfVnxgGDfHeNHFvG9HIWe
         rrB4LToHDeDK+DUJh2Y10W2jDd8YPZijdOwhRLK3/OAgFUHtFmrR7AZQL7Mo4ont0aUW
         wF8YP764MWqbcgKfg+qQoqFzPCY2Bi0Oabq7UDE4vWXHBe/0U/Hd6GqX+tz+43nN3x/d
         DYgv48X+gH9FEsUbpQVQxd4yCnQsKqCNwCOEpl3ma2arbkus3w7jYt0JjOdVFqdjTSWg
         zCzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tvbz591DMvF33ax+eSb+xGGBL3Gl9La/xcKDxZqOIrc=;
        b=KgSMZ7XgYtByvgj7dxAcob+nWPq++/pFTyEAZXOBqPbLj/L+FzCjmaTnrM3HMaWcDO
         y3FUdkdANOShbg0C2yPWUNmkPgEtd5XCR7MbRGEnaSdYYLI2ylxk27zwbCuqbj07AjWt
         d86EFHzftXyvyjO08uzMh8aQyp4ypt3oPV1xjDKze1K0HP2qbehTRdCawBJbrOHYOd0a
         i+9sYF1cIhF99qKUQBMlJvxomHl6mEaGHpgn2bbYpDGAQ99ByhbCARQuE1B7cj0j+42r
         i9mMiRfappP8LI4Qvn0YUrdnSqRfrXYlu2/G0kU/klj2qJC6WcGdrTkCos5VI2HA9itq
         A3mQ==
X-Gm-Message-State: AOAM5326JkEulhSFsLxLOi4EOwIaLDBrcfBN87QhNuNG1v11H5TzLzUc
        yHULUVfeiNjWTfVQ166eXPg=
X-Google-Smtp-Source: ABdhPJxX8YFGf1i8meoq5sOifajSNN+g9j8sMc1vK55NN+vFNuD7hAmJq//9xWrqkimELYBwzb4Fxw==
X-Received: by 2002:aa7:d7c1:: with SMTP id e1mr17754674eds.251.1628331137011;
        Sat, 07 Aug 2021 03:12:17 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::a83e])
        by smtp.gmail.com with ESMTPSA id u4sm3662514eje.81.2021.08.07.03.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 03:12:16 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 13/17] staging: r8188eu: remove unnecessary parentheses in core/rtw_pwrctrl.c
Date:   Sat,  7 Aug 2021 12:11:15 +0200
Message-Id: <20210807101119.16085-14-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210807101119.16085-1-straube.linux@gmail.com>
References: <20210807101119.16085-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary parentheses in core/rtw_pwrctrl.c reported by
checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_pwrctrl.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_pwrctrl.c b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
index 57cd10205d6c..9a00a316674b 100644
--- a/drivers/staging/r8188eu/core/rtw_pwrctrl.c
+++ b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
@@ -51,8 +51,8 @@ void ips_enter(struct adapter *padapter)
 int ips_leave(struct adapter *padapter)
 {
 	struct pwrctrl_priv *pwrpriv = &padapter->pwrctrlpriv;
-	struct security_priv *psecuritypriv = &(padapter->securitypriv);
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct security_priv *psecuritypriv = &padapter->securitypriv;
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	int result = _SUCCESS;
 	int keyid;
 
@@ -98,9 +98,9 @@ int ips_leave(struct adapter *padapter)
 static bool rtw_pwr_unassociated_idle(struct adapter *adapter)
 {
 	struct adapter *buddy = adapter->pbuddy_adapter;
-	struct mlme_priv *pmlmepriv = &(adapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &adapter->mlmepriv;
 #ifdef CONFIG_88EU_P2P
-	struct wifidirect_info	*pwdinfo = &(adapter->wdinfo);
+	struct wifidirect_info	*pwdinfo = &adapter->wdinfo;
 #endif
 
 	bool ret = false;
@@ -122,9 +122,9 @@ static bool rtw_pwr_unassociated_idle(struct adapter *adapter)
 
 	/* consider buddy, if exist */
 	if (buddy) {
-		struct mlme_priv *b_pmlmepriv = &(buddy->mlmepriv);
+		struct mlme_priv *b_pmlmepriv = &buddy->mlmepriv;
 		#ifdef CONFIG_88EU_P2P
-		struct wifidirect_info *b_pwdinfo = &(buddy->wdinfo);
+		struct wifidirect_info *b_pwdinfo = &buddy->wdinfo;
 		#endif
 
 		if (check_fwstate(b_pmlmepriv, WIFI_ASOC_STATE|WIFI_SITE_MONITOR) ||
@@ -147,7 +147,7 @@ static bool rtw_pwr_unassociated_idle(struct adapter *adapter)
 void rtw_ps_processor(struct adapter *padapter)
 {
 	struct pwrctrl_priv *pwrpriv = &padapter->pwrctrlpriv;
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	enum rt_rf_power_state rfpwrstate;
 
 	pwrpriv->ps_processing = true;
@@ -248,7 +248,7 @@ static u8 PS_RDY_CHECK(struct adapter *padapter)
 {
 	u32 curr_time, delta_time;
 	struct pwrctrl_priv	*pwrpriv = &padapter->pwrctrlpriv;
-	struct mlme_priv	*pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv	*pmlmepriv = &padapter->mlmepriv;
 
 	curr_time = jiffies;
 	delta_time = curr_time - pwrpriv->DelayLPSLastTimeStamp;
@@ -275,7 +275,7 @@ void rtw_set_ps_mode(struct adapter *padapter, u8 ps_mode, u8 smart_ps, u8 bcn_a
 {
 	struct pwrctrl_priv *pwrpriv = &padapter->pwrctrlpriv;
 #ifdef CONFIG_88EU_P2P
-	struct wifidirect_info	*pwdinfo = &(padapter->wdinfo);
+	struct wifidirect_info	*pwdinfo = &padapter->wdinfo;
 #endif /* CONFIG_88EU_P2P */
 
 	if (ps_mode > PM_Card_Disable)
@@ -412,7 +412,7 @@ void LPS_Leave(struct adapter *padapter)
 /*  */
 void LeaveAllPowerSaveMode(struct adapter *Adapter)
 {
-	struct mlme_priv	*pmlmepriv = &(Adapter->mlmepriv);
+	struct mlme_priv	*pmlmepriv = &Adapter->mlmepriv;
 	u8	enqueue = 0;
 
 	if (check_fwstate(pmlmepriv, _FW_LINKED)) { /* connect */
-- 
2.32.0

