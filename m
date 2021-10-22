Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 852D543761F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 13:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbhJVLk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 07:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbhJVLk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 07:40:57 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9FEC061764
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 04:38:40 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 75so3075113pga.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 04:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iLjS4KepaCWdqpcVUeddlXg6tm2lpMdlG4gBW7hEPSM=;
        b=CFe/Pv+89UG/hKSz9RPDaFrjKUHSA1Y08ppF4Cz78IRBGCLL0iO+Rey28EkwEfXSXZ
         +SpUz0UeBYXWtcFdbq3oEjwtPwNDSyI9I9341Dqvc39PuTab3XZytdhyvrKQbAdbTdIc
         Xz4p2rWbYukjxrjhy3+t6qKwobSy9dBmfqX8SpMAGZ3Ik7kcgmsMfn5HgI8CV/EsAsye
         F8vQcJV+lvkoCU9sEfGldZdPUqV2t9zROfw7OBaoK2HZLkRw3PRBvQs0RSXbN0AfZntX
         IyQWOnPjbSyzHwOV1c6z7baz4z/tN0Ml2HinyCWzHKmLyy55gHWAbYewmjHWcmB232w7
         lUXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iLjS4KepaCWdqpcVUeddlXg6tm2lpMdlG4gBW7hEPSM=;
        b=PIaKA4lq3v2zG4Ft4BiSAyz/rDsuKWADtU/holVu5kin6lclH/5VD0ldX/HWP7Dm06
         i9DDry6KuRD30YKkziO241TJVY3AUhPRyzKJ1gMTe5Tuk8ZrAZIiYjuCGPOR/Tf6lpKi
         G3qw1SQtvYD4CnJS+GzEaOq7AT+q388y/OyKKaCMNzuJkfaWz2Uq8KOAywuBphFdcRpT
         Jiv18ATK1UzrLs0tpYuagqk96ESh5758VLrCJSud8K2olYd41NHurbi9UIsUbaSb5Y1s
         GC33WotK7Ii51yjMSkw+WbAFZvv96rsY56aSQwetgRkCAUiNwQiBU5geNMqUjm3046TY
         iuBA==
X-Gm-Message-State: AOAM5307MRnBp5w8GptXBpUwPJwqO+4Bev+X1ROGGhTvEC6BTrLoRHHE
        Z7V8wjuU7fDggYC+WgRDkCM=
X-Google-Smtp-Source: ABdhPJzGIIk8slmMxk54DPEqc53EsDU/uKW6xUksE/9zUi5TYdLhvjiNBPuLfz2Tn0nm2ae56QSk/g==
X-Received: by 2002:a62:2cc2:0:b0:47b:b52e:c6d8 with SMTP id s185-20020a622cc2000000b0047bb52ec6d8mr1066927pfs.12.1634902720168;
        Fri, 22 Oct 2021 04:38:40 -0700 (PDT)
Received: from localhost.localdomain ([115.96.219.100])
        by smtp.googlemail.com with ESMTPSA id t22sm10946224pfg.148.2021.10.22.04.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 04:38:39 -0700 (PDT)
From:   Kushal Kothari <kushalkothari285@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     kushalkothari285@gmail.com, kush19992810@gmail.com,
        outreachy-kernel@googlegroups.com, fabioaiuto83@gmail.com,
        ross.schm.dev@gmail.com, fmdefrancesco@gmail.com,
        marcocesati@gmail.com, straube.linux@gmail.com,
        philippesdixon@gmail.com, manuelpalenzuelamerino@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        mike.rapoport@gmail.com, kushalkotharitest@googlegroups.com
Subject: [PATCH 4/4] v2 staging: rtl8723bs: core: Remove unnecessary blank lines
Date:   Fri, 22 Oct 2021 17:07:38 +0530
Message-Id: <99127ed4afce044c4f7c3838faab5235b8a6eb2f.1634899405.git.kushalkothari285@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1634899405.git.kushalkothari285@gmail.com>
References: <cover.1634899405.git.kushalkothari285@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove useless blank lines

Signed-off-by: Kushal Kothari <kushalkothari285@gmail.com>

Changes in v2: Removed whitespace errors
---
 drivers/staging/rtl8723bs/core/rtw_cmd.c | 26 ------------------------
 1 file changed, 26 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index fce3256cc275..639459d52261 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -316,8 +316,6 @@ int rtw_cmd_filter(struct cmd_priv *pcmdpriv, struct cmd_obj *cmd_obj)
 	return _SUCCESS;
 }
 
-
-
 int rtw_enqueue_cmd(struct cmd_priv *pcmdpriv, struct cmd_obj *cmd_obj)
 {
 	int res = _FAIL;
@@ -367,7 +365,6 @@ void rtw_free_cmd_obj(struct cmd_obj *pcmd)
 	kfree(pcmd);
 }
 
-
 void rtw_stop_cmd_thread(struct adapter *adapter)
 {
 	if (adapter->cmdThread &&
@@ -497,11 +494,8 @@ int rtw_cmd_thread(void *context)
 		} else {
 			rtw_free_cmd_obj(pcmd);
 		}
-
 		flush_signals_thread();
-
 		goto _next;
-
 	}
 
 	/*  free all cmd_obj resources */
@@ -591,7 +585,6 @@ u8 rtw_sitesurvey_cmd(struct adapter  *padapter, struct ndis_802_11_ssid *ssid,
 	res = rtw_enqueue_cmd(pcmdpriv, ph2c);
 
 	if (res == _SUCCESS) {
-
 		pmlmepriv->scan_start_time = jiffies;
 		_set_timer(&pmlmepriv->scan_to_timer, SCANNING_TIMEOUT);
 	} else {
@@ -752,7 +745,6 @@ u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network *pnetwork)
 		case Ndis802_11AutoUnknown:
 		case Ndis802_11InfrastructureMax:
 			break;
-
 		}
 	}
 
@@ -1010,9 +1002,7 @@ u8 rtw_clearstakey_cmd(struct adapter *padapter, struct sta_info *sta, u8 enqueu
 		psetstakey_para->algorithm = _NO_PRIVACY_;
 
 		res = rtw_enqueue_cmd(pcmdpriv, ph2c);
-
 	}
-
 exit:
 	return res;
 }
@@ -1080,7 +1070,6 @@ u8 rtw_reset_securitypriv_cmd(struct adapter *padapter)
 
 	/* rtw_enqueue_cmd(pcmdpriv, ph2c); */
 	res = rtw_enqueue_cmd(pcmdpriv, ph2c);
-
 exit:
 	return res;
 }
@@ -1112,10 +1101,8 @@ u8 rtw_free_assoc_resources_cmd(struct adapter *padapter)
 
 	init_h2fwcmd_w_parm_no_rsp(ph2c, pdrvextra_cmd_parm, GEN_CMD_CODE(_Set_Drv_Extra));
 
-
 	/* rtw_enqueue_cmd(pcmdpriv, ph2c); */
 	res = rtw_enqueue_cmd(pcmdpriv, ph2c);
-
 exit:
 	return res;
 }
@@ -1150,7 +1137,6 @@ u8 rtw_dynamic_chk_wk_cmd(struct adapter *padapter)
 
 	/* rtw_enqueue_cmd(pcmdpriv, ph2c); */
 	res = rtw_enqueue_cmd(pcmdpriv, ph2c);
-
 exit:
 	return res;
 }
@@ -1347,14 +1333,11 @@ static void dynamic_chk_wk_hdl(struct adapter *padapter)
 
 	/* for debug purpose */
 	_linked_info_dump(padapter);
-
-
 	/* if (check_fwstate(pmlmepriv, _FW_UNDER_LINKING|_FW_UNDER_SURVEY) ==false) */
 	{
 		linked_status_chk(padapter);
 		traffic_status_watchdog(padapter, 0);
 	}
-
 	rtw_hal_dm_watchdog(padapter);
 
 	/* check_hw_pbc(padapter, pdrvextra_cmd->pbuf, pdrvextra_cmd->type); */
@@ -1500,9 +1483,7 @@ u8 rtw_dm_in_lps_wk_cmd(struct adapter *padapter)
 	res = rtw_enqueue_cmd(pcmdpriv, ph2c);
 
 exit:
-
 	return res;
-
 }
 
 static void rtw_lps_change_dtim_hdl(struct adapter *padapter, u8 dtim)
@@ -1542,7 +1523,6 @@ u8 rtw_dm_ra_mask_wk_cmd(struct adapter *padapter, u8 *psta)
 	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
 	u8 res = _SUCCESS;
 
-
 	ph2c = rtw_zmalloc(sizeof(struct cmd_obj));
 	if (!ph2c) {
 		res = _FAIL;
@@ -1577,7 +1557,6 @@ u8 rtw_ps_cmd(struct adapter *padapter)
 	struct drvextra_cmd_parm	*pdrvextra_cmd_parm;
 	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
 	u8 res = _SUCCESS;
-
 	ppscmd = rtw_zmalloc(sizeof(struct cmd_obj));
 	if (!ppscmd) {
 		res = _FAIL;
@@ -1673,9 +1652,7 @@ u8 rtw_chk_hi_queue_cmd(struct adapter *padapter)
 	res = rtw_enqueue_cmd(pcmdpriv, ph2c);
 
 exit:
-
 	return res;
-
 }
 
 struct btinfo {
@@ -2021,11 +1998,8 @@ void rtw_createbss_cmd_callback(struct adapter *padapter, struct cmd_obj *pcmd)
 	rtw_free_cmd_obj(pcmd);
 }
 
-
-
 void rtw_setstaKey_cmdrsp_callback(struct adapter *padapter,  struct cmd_obj *pcmd)
 {
-
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	struct set_stakey_rsp *psetstakey_rsp = (struct set_stakey_rsp *)(pcmd->rsp);
 	struct sta_info *psta = rtw_get_stainfo(pstapriv, psetstakey_rsp->addr);
-- 
2.25.1

