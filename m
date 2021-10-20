Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC5FF434A9E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 13:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbhJTL7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 07:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhJTL7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 07:59:07 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E01C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 04:56:53 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id f5so22271365pgc.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 04:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DGAGxcqlo2VW/AD37sxcgcQQxtJtu50Aw5qmQcfn3f0=;
        b=nWcCHUcGDK6BW8OB5AJLUUIO7gptFX8QO0j/5OvUausYIl0D5IAIT64E2k72XGS6x0
         1yXLCMSsI7/Zo2cqbC/C6JuN74EcYLx20EBEme6wzn+MBJZaO4c3cwCe62hZTRZ6apNt
         RjVGJnFWLWGX6vbZ93vEtQy42pHj7byVor9Rs4/oe53Cqs0Om6dUa7spWAlk8VXsQ5TW
         JtmxwN2cir6TlJr1uMGpJzO18UTy6Ig/Zyb9CnZCKdZjPyuXHNWBwYPWreuQhFY4ltbr
         dkOJbgMpSt+HkTkpcMMnBjlLOo3iCRo8u1S8wiUFJJV9b/1FufGQmyy8Nt3kHofYx++X
         4e+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DGAGxcqlo2VW/AD37sxcgcQQxtJtu50Aw5qmQcfn3f0=;
        b=A+TFkLBIuwyeIetqVtDeaVlTU2N48focp9mxGjQasJ69qDZtjpzztUe3ZgJF4igoGQ
         hmWOEkEtoFTgTxvPI2jUQ3AlhKe8q6hWj4555iOGOXAvivgdJ7OBUI88VuJeTGcfiaKF
         IQKtiG6uElGLY1scsREXTsDo9RQfDT63A+KBRz16P43aGQTQxwnbk3j0TdRyTCzXIGzh
         cvWII89fskAXXXX/D7hBA+UWMdAgV72gah8rZxtEObvQ6oNe6Iyqwg+rvye9+/BpoeIZ
         0+MHPJ7oQTbyI4ayr3iDnwEc9byNR0yLuY6Vnq+UAu+Zwr8qHV+3S0bHcOvuWSM49T6g
         qu6A==
X-Gm-Message-State: AOAM533iIxK5hXuTozKTDT3AHM0TxeOmBIeD+LA2Xlhfup04X/zzzdwq
        2fX0hOx87IuC92FGcghLK/Q=
X-Google-Smtp-Source: ABdhPJw6rIPTL4aA4rnsdQluTtPWnGGdVcPbgmlWcAtR5OR0PPTwtu1FTmx7sUHg549gTKTsybFSnQ==
X-Received: by 2002:a63:ed13:: with SMTP id d19mr32905295pgi.430.1634731012850;
        Wed, 20 Oct 2021 04:56:52 -0700 (PDT)
Received: from localhost.localdomain ([115.96.219.100])
        by smtp.googlemail.com with ESMTPSA id rj2sm2417213pjb.32.2021.10.20.04.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 04:56:52 -0700 (PDT)
From:   Kushal Kothari <kushalkothari285@gmail.com>
To:     gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        marcocesati@gmail.com, dan.carpenter@oracle.com,
        ross.schm.dev@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com,
        mike.rapoport@gmail.com
Cc:     Kushal Kothari <kushalkothari285@gmail.com>
Subject: [PATCH v3] staging: rtl8723bs: core: Remove true and false comparison
Date:   Wed, 20 Oct 2021 17:26:21 +0530
Message-Id: <20211020115621.132500-1-kushalkothari285@gmail.com>
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

Changes in v2: No changes
Changes in v3: Remove unnecessary parantheses

 drivers/staging/rtl8723bs/core/rtw_cmd.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index efc9b1974e38..2624e994513f 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -309,9 +309,8 @@ int rtw_cmd_filter(struct cmd_priv *pcmdpriv, struct cmd_obj *cmd_obj)
 	if (cmd_obj->cmdcode == GEN_CMD_CODE(_SetChannelPlan))
 		bAllow = true;
 
-	if ((pcmdpriv->padapter->hw_init_completed == false && bAllow == false)
-		|| atomic_read(&(pcmdpriv->cmdthd_running)) == false	/* com_thread not running */
-	)
+	if ((!pcmdpriv->padapter->hw_init_completed && !bAllow) ||
+		!atomic_read(&pcmdpriv->cmdthd_running))	/* com_thread not running */
 		return _FAIL;
 
 	return _SUCCESS;
@@ -407,7 +406,7 @@ int rtw_cmd_thread(void *context)
 			break;
 		}
 
-		if ((padapter->bDriverStopped == true) || (padapter->bSurpriseRemoved == true)) {
+		if (padapter->bDriverStopped || padapter->bSurpriseRemoved) {
 			netdev_dbg(padapter->pnetdev,
 				   "%s: DriverStopped(%d) SurpriseRemoved(%d) break at line %d\n",
 				   __func__, padapter->bDriverStopped,
@@ -430,7 +429,7 @@ int rtw_cmd_thread(void *context)
 			continue;
 
 _next:
-		if ((padapter->bDriverStopped == true) || (padapter->bSurpriseRemoved == true)) {
+		if (padapter->bDriverStopped || padapter->bSurpriseRemoved) {
 			netdev_dbg(padapter->pnetdev,
 				   "%s: DriverStopped(%d) SurpriseRemoved(%d) break at line %d\n",
 				   __func__, padapter->bDriverStopped,
@@ -927,7 +926,7 @@ u8 rtw_setstakey_cmd(struct adapter *padapter, struct sta_info *sta, u8 unicast_
 	else
 		GET_ENCRY_ALGO(psecuritypriv, sta, psetstakey_para->algorithm, false);
 
-	if (unicast_key == true)
+	if (unicast_key)
 		memcpy(&psetstakey_para->key, &sta->dot118021x_UncstKey, 16);
 	else
 		memcpy(&psetstakey_para->key, &psecuritypriv->dot118021XGrpKey[psecuritypriv->dot118021XGrpKeyid].skey, 16);
@@ -1283,7 +1282,7 @@ u8 traffic_status_watchdog(struct adapter *padapter, u8 from_timer)
 			(pmlmepriv->LinkDetectInfo.NumRxUnicastOkInPeriod > 2)) {
 			bEnterPS = false;
 
-			if (bBusyTraffic == true) {
+			if (bBusyTraffic) {
 				if (pmlmepriv->LinkDetectInfo.TrafficTransitionCount <= 4)
 					pmlmepriv->LinkDetectInfo.TrafficTransitionCount = 4;
 
@@ -1619,7 +1618,7 @@ static void rtw_chk_hi_queue_hdl(struct adapter *padapter)
 
 	rtw_hal_get_hwreg(padapter, HW_VAR_CHK_HI_QUEUE_EMPTY, &empty);
 
-	while (false == empty && jiffies_to_msecs(jiffies - start) < g_wait_hiq_empty) {
+	while (!empty && jiffies_to_msecs(jiffies - start) < g_wait_hiq_empty) {
 		msleep(100);
 		rtw_hal_get_hwreg(padapter, HW_VAR_CHK_HI_QUEUE_EMPTY, &empty);
 	}
@@ -2054,7 +2053,7 @@ void rtw_setassocsta_cmdrsp_callback(struct adapter *padapter,  struct cmd_obj *
 
 	spin_lock_bh(&pmlmepriv->lock);
 
-	if ((check_fwstate(pmlmepriv, WIFI_MP_STATE) == true) && (check_fwstate(pmlmepriv, _FW_UNDER_LINKING) == true))
+	if (check_fwstate(pmlmepriv, WIFI_MP_STATE) && check_fwstate(pmlmepriv, _FW_UNDER_LINKING))
 		_clr_fwstate_(pmlmepriv, _FW_UNDER_LINKING);
 
 	set_fwstate(pmlmepriv, _FW_LINKED);
-- 
2.25.1

