Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B652C433D5C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 19:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234638AbhJSR05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 13:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233580AbhJSR0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 13:26:55 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F15FC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 10:24:42 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id i76so518700pfe.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 10:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5kvyUu/ou5/zjB+qAPejgXQ9ckRr2OTQAJI3Yt7aNfk=;
        b=Bb6h49qMbdOzJlZS1zXLlVZp/5Q7KCs1ve2qL9ZJ5qIjpR2IhPxwyHH64KNcZQjlEk
         0sCI99712I7mmpie62XQINyMfM1rh4+ztTivnOke2FaDEvOUmxKdI0K+Ib/vVjrgC+2g
         ZLrluHFki65ByTgu49Q5gn6X81xi4CeHfopPJjYrcbCVOwebj0EOg5crA+lVBxbH31YG
         cCUd2VeAm/3Y7DIe+mt19/ET0tC8xEB9gnS270I05Qwmhp+xiCbGS0iftpzp4t3+eMTC
         8c6nju39PzeUEyweBCgInixov1gNok/KXiqakoJakZxf+XOjwM4Y3vZKPxz6kc1IfsaX
         kkRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5kvyUu/ou5/zjB+qAPejgXQ9ckRr2OTQAJI3Yt7aNfk=;
        b=Z+V6wZTYG5ixEZqprP4vZzcP8cJzsXyUNkFOSW9hjv9FOZ3V3B5QDo10qUQcpDStqV
         Z5OLBnvOnerfoGS2hdBwClOxlN5/dp9t/9/rndvLahAeYUc3gnVTk4/k1H5FK8RviJQ3
         xhmngjcigkVbNZWiuF6p7kSTNVgv8iopoGVuPjwjrIcuE2jWiImcxC5vmKa2CO3D9b/1
         3MvVuwImEuNgAWxFk+RJR5qOr6GSouNZx3cPvnn6ptf2nSXoV38owqSNxyvq2dgE2gPN
         cbiMB9TDG+ziFLllEGkj24uL/E8COWtjkS1xwwAcpsdwcR9o1yceLnItkE8+xEytaPR+
         q8Gw==
X-Gm-Message-State: AOAM533DBNg7e8++KEsl9dswD+OEmN1eJIg9c7A+LNQj/dtCr8c+zi0q
        Ym002+MwrP/iLVVPn4lvlCqLWy1jwiuxveFo
X-Google-Smtp-Source: ABdhPJz3X39Tz5/B5FgZiomUPTOJigkTxJNs00vWzKkRwkOBkFZoBklrQmI+x4VYDok+CadYouO1mA==
X-Received: by 2002:a65:62c4:: with SMTP id m4mr30125512pgv.453.1634664281808;
        Tue, 19 Oct 2021 10:24:41 -0700 (PDT)
Received: from localhost.localdomain ([115.96.219.100])
        by smtp.googlemail.com with ESMTPSA id q8sm3132468pfu.167.2021.10.19.10.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 10:24:41 -0700 (PDT)
From:   Kushal Kothari <kushalkothari285@gmail.com>
To:     gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        marcocesati@gmail.com, dan.carpenter@oracle.com,
        ross.schm.dev@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com,
        mike.rapoport@gmail.com
Cc:     Kushal Kothari <kushalkothari285@gmail.com>
Subject: [PATCH] staging: rtl8723bs: core:  Remove true and false comparison
Date:   Tue, 19 Oct 2021 22:53:59 +0530
Message-Id: <20211019172359.63583-1-kushalkothari285@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove comparison to true and false in if statement.
Issue found with checkpatch.pl.
CHECK: Using comparison to true is error prone
CHECK: Using comparison to false is error prone

Signed-off-by: Kushal Kothari <kushalkothari285@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_cmd.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index efc9b1974e38..b473f1d1ce08 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -309,8 +309,8 @@ int rtw_cmd_filter(struct cmd_priv *pcmdpriv, struct cmd_obj *cmd_obj)
 	if (cmd_obj->cmdcode == GEN_CMD_CODE(_SetChannelPlan))
 		bAllow = true;
 
-	if ((pcmdpriv->padapter->hw_init_completed == false && bAllow == false)
-		|| atomic_read(&(pcmdpriv->cmdthd_running)) == false	/* com_thread not running */
+	if ((!pcmdpriv->padapter->hw_init_completed && !bAllow)
+		|| !atomic_read(&(pcmdpriv->cmdthd_running))	/* com_thread not running */
 	)
 		return _FAIL;
 
@@ -407,7 +407,7 @@ int rtw_cmd_thread(void *context)
 			break;
 		}
 
-		if ((padapter->bDriverStopped == true) || (padapter->bSurpriseRemoved == true)) {
+		if ((padapter->bDriverStopped) || (padapter->bSurpriseRemoved)) {
 			netdev_dbg(padapter->pnetdev,
 				   "%s: DriverStopped(%d) SurpriseRemoved(%d) break at line %d\n",
 				   __func__, padapter->bDriverStopped,
@@ -430,7 +430,7 @@ int rtw_cmd_thread(void *context)
 			continue;
 
 _next:
-		if ((padapter->bDriverStopped == true) || (padapter->bSurpriseRemoved == true)) {
+		if ((padapter->bDriverStopped) || (padapter->bSurpriseRemoved)) {
 			netdev_dbg(padapter->pnetdev,
 				   "%s: DriverStopped(%d) SurpriseRemoved(%d) break at line %d\n",
 				   __func__, padapter->bDriverStopped,
@@ -927,7 +927,7 @@ u8 rtw_setstakey_cmd(struct adapter *padapter, struct sta_info *sta, u8 unicast_
 	else
 		GET_ENCRY_ALGO(psecuritypriv, sta, psetstakey_para->algorithm, false);
 
-	if (unicast_key == true)
+	if (unicast_key)
 		memcpy(&psetstakey_para->key, &sta->dot118021x_UncstKey, 16);
 	else
 		memcpy(&psetstakey_para->key, &psecuritypriv->dot118021XGrpKey[psecuritypriv->dot118021XGrpKeyid].skey, 16);
@@ -1283,7 +1283,7 @@ u8 traffic_status_watchdog(struct adapter *padapter, u8 from_timer)
 			(pmlmepriv->LinkDetectInfo.NumRxUnicastOkInPeriod > 2)) {
 			bEnterPS = false;
 
-			if (bBusyTraffic == true) {
+			if (bBusyTraffic) {
 				if (pmlmepriv->LinkDetectInfo.TrafficTransitionCount <= 4)
 					pmlmepriv->LinkDetectInfo.TrafficTransitionCount = 4;
 
@@ -1619,7 +1619,7 @@ static void rtw_chk_hi_queue_hdl(struct adapter *padapter)
 
 	rtw_hal_get_hwreg(padapter, HW_VAR_CHK_HI_QUEUE_EMPTY, &empty);
 
-	while (false == empty && jiffies_to_msecs(jiffies - start) < g_wait_hiq_empty) {
+	while (!empty && jiffies_to_msecs(jiffies - start) < g_wait_hiq_empty) {
 		msleep(100);
 		rtw_hal_get_hwreg(padapter, HW_VAR_CHK_HI_QUEUE_EMPTY, &empty);
 	}
@@ -2054,7 +2054,7 @@ void rtw_setassocsta_cmdrsp_callback(struct adapter *padapter,  struct cmd_obj *
 
 	spin_lock_bh(&pmlmepriv->lock);
 
-	if ((check_fwstate(pmlmepriv, WIFI_MP_STATE) == true) && (check_fwstate(pmlmepriv, _FW_UNDER_LINKING) == true))
+	if ((check_fwstate(pmlmepriv, WIFI_MP_STATE)) && (check_fwstate(pmlmepriv, _FW_UNDER_LINKING)))
 		_clr_fwstate_(pmlmepriv, _FW_UNDER_LINKING);
 
 	set_fwstate(pmlmepriv, _FW_LINKED);
-- 
2.25.1

