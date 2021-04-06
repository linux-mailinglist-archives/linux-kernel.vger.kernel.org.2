Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E511E3558E9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 18:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346275AbhDFQLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 12:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346265AbhDFQLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 12:11:45 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFACC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 09:11:36 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id n8so4870953lfh.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 09:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=51wN1flQu9ma9cxU2P2DJyhJeDjbr3t7JdzDteFYztw=;
        b=Hc8ggizkUdQBaPnTaPxXh4ebsmM7GEieinB0UT85L/h6nmPE+RS55wHvcwvxXn81fm
         4+9dEgUYTrvsseAKILtnAYTfUVkQkwUwAztrRNiSn42OnhFFSa7m9X8pswLhAu51C2V8
         c7R8OlIiI1Epab8Ea58g5qrL0o0CJurbjB16yKbRrkRVfWvOE84SXjXR6SoaZLLbB/1c
         Y3kYVJ4OMrNotkBdlgMKEw52nNw255F8MM5vH+HyKPQRMMeHbNGij1A0V8wtPm0QUKu9
         Hlm4wHPdLC1vwqPoUzvPjYCgQkN09RkKk2V9zZQZhV43NkLE69xmj8KI3l7qK9jcnpCE
         me9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=51wN1flQu9ma9cxU2P2DJyhJeDjbr3t7JdzDteFYztw=;
        b=ni5dNSCbiqvzefWIJkbw4rMfBQvOUz9gyPIk2Tz9SFOCxL6TjiWd2UBLNqLKCeN610
         zIzX7BRVexXsrkFwR20RDIutUJ+f49NfGhoYeOyaUqs8gMKtW3oIhGcm/kOwlVCeh5pf
         kmrhnX+pQw3xbs0OxJBbbZmzoIlbjpo5aQJssf7KaunlN4bAELBxjoUj1baUsldz959w
         /1agZNNs5QBfj3wBI83O3Pbtb0U0ShYTGFOjgTKkFOCrJfH4Rweq001bCckRrrAzJh/3
         uGFBLxJ5cMQAgAMmlhP+xBwpK23qvzz+GHuIXR46qq1TphNgFgwZCddMPdkLSOcmvASw
         8zSA==
X-Gm-Message-State: AOAM530thX0RNKul/Su2O+FiU/JWDRZ+I5ZxMcrogemf1/33MtUl3XMe
        7BL9W/KSujUirTeoHKki20/sF/WpOYwcYA==
X-Google-Smtp-Source: ABdhPJyiXoyBhw6whBYmf2aJHfTZJPsOGb+ihfZPa61IlBrvxvzfgwwnCusS3sQb9djMX57cjLMNbw==
X-Received: by 2002:a05:6512:b93:: with SMTP id b19mr21113786lfv.432.1617725494673;
        Tue, 06 Apr 2021 09:11:34 -0700 (PDT)
Received: from zhans ([37.151.32.231])
        by smtp.gmail.com with ESMTPSA id q26sm2302783ljg.90.2021.04.06.09.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 09:11:34 -0700 (PDT)
Date:   Tue, 6 Apr 2021 22:11:31 +0600
From:   Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: core: Move constants to the right of
 comparison
Message-ID: <20210406161131.GA103324@zhans>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move constant variables to the right side of comparisons to increase
consistency with Linux kernel code base.
Reported by checkpatch.

Signed-off-by: Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_pwrctrl.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
index 09bf25940e92..23897a4b663f 100644
--- a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
+++ b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
@@ -89,7 +89,7 @@ int ips_leave(struct adapter *padapter)
 	ret = _ips_leave(padapter);
 	mutex_unlock(&pwrpriv->lock);
 
-	if (_SUCCESS == ret)
+	if (ret == _SUCCESS)
 		hal_btcoex_IpsNotify(padapter, IPS_NONE);
 
 	return ret;
@@ -372,7 +372,7 @@ void rtw_set_ps_mode(struct adapter *padapter, u8 ps_mode, u8 smart_ps, u8 bcn_a
 		return;
 
 	if (pwrpriv->pwr_mode == ps_mode)
-		if (PS_MODE_ACTIVE == ps_mode)
+		if (ps_mode == PS_MODE_ACTIVE)
 			return;
 
 
@@ -805,7 +805,7 @@ s32 rtw_register_task_alive(struct adapter *padapter, u32 task)
 
 	mutex_unlock(&pwrctrl->lock);
 
-	if (_FAIL == res)
+	if (res == _FAIL)
 		if (pwrctrl->cpwm >= PS_STATE_S2)
 			res = _SUCCESS;
 
@@ -890,7 +890,7 @@ s32 rtw_register_tx_alive(struct adapter *padapter)
 
 	mutex_unlock(&pwrctrl->lock);
 
-	if (_FAIL == res)
+	if (res == _FAIL)
 		if (pwrctrl->cpwm >= PS_STATE_S2)
 			res = _SUCCESS;
 
@@ -935,7 +935,7 @@ s32 rtw_register_cmd_alive(struct adapter *padapter)
 
 	mutex_unlock(&pwrctrl->lock);
 
-	if (_FAIL == res)
+	if (res == _FAIL)
 		if (pwrctrl->cpwm >= PS_STATE_S2)
 			res = _SUCCESS;
 
@@ -1146,7 +1146,7 @@ int _rtw_pwr_wakeup(struct adapter *padapter, u32 ips_deffer_ms, const char *cal
 	if (rf_off == pwrpriv->rf_pwrstate) {
 		{
 			DBG_8192C("%s call ips_leave....\n", __func__);
-			if (_FAIL ==  ips_leave(padapter)) {
+			if (ips_leave(padapter) == _FAIL) {
 				DBG_8192C("======> ips_leave fail.............\n");
 				ret = _FAIL;
 				goto exit;
@@ -1180,7 +1180,7 @@ int rtw_pm_set_lps(struct adapter *padapter, u8 mode)
 
 	if (mode < PS_MODE_NUM) {
 		if (pwrctrlpriv->power_mgnt != mode) {
-			if (PS_MODE_ACTIVE == mode)
+			if (mode == PS_MODE_ACTIVE)
 				LeaveAllPowerSaveMode(padapter);
 			else
 				pwrctrlpriv->LpsIdleCount = 2;
@@ -1206,7 +1206,7 @@ int rtw_pm_set_ips(struct adapter *padapter, u8 mode)
 	} else if (mode == IPS_NONE) {
 		rtw_ips_mode_req(pwrctrlpriv, mode);
 		DBG_871X("%s %s\n", __func__, "IPS_NONE");
-		if ((padapter->bSurpriseRemoved == 0) && (_FAIL == rtw_pwr_wakeup(padapter)))
+		if ((padapter->bSurpriseRemoved == 0) && (rtw_pwr_wakeup(padapter) == _FAIL))
 			return -EFAULT;
 	} else
 		return -EINVAL;
-- 
2.25.1

