Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7700543823B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 09:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbhJWHkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 03:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbhJWHkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 03:40:06 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613A5C061766
        for <linux-kernel@vger.kernel.org>; Sat, 23 Oct 2021 00:37:47 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id gn3so4499605pjb.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Oct 2021 00:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JBgnyAymbMlZzBjwCM1w0weMiRh/0NNAG6lng/vwJrY=;
        b=ohmblJTbXi5lxEg9vYHKWeZWZmjf8pnULMSTu6HJ3gyJwn4Q6/ydLLHtKDJI38nqiF
         eLijtzM/mYDQuIyP40aOIRm6Icaaj4t24j4b5UXMpp/Vvqard7MJaJ9hJtIYwHfFjGRA
         9Zg7Vy1C8QK9nfjLOP983Uflnf74rBejcil5wjQvvaI4u7eRYk6qGkpgzG25V2LUKOXT
         cQvia8Ka5+ry+sds87AlsLCZxAhi+aqR0ORUyb1MFkKSZwvyi4WeGDrFS73PaqtQeBO8
         hzU3xGaPqe8pFLKTveA5MCqqRmR5ntv1LTDvCyTdugbuOMgd24epDsHN5WN3t/pKGgL1
         Yffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JBgnyAymbMlZzBjwCM1w0weMiRh/0NNAG6lng/vwJrY=;
        b=KcbHV/i0CIPp2IkrlEtkBoXSFngr96vr1uzSvLvEp4PPcvALQd7Su8JZCFtIai7IeL
         EWApWfYwgWKc+6kT9C4fOPHxtiEiP/zHEUTqO4k39gobSBmvJSdXUg+Klo4Y/m0GBg4X
         XRgZBzFG9b5mA1bQpcRqcoXvBH4cZTdmAg8Otihrh27zCTsf8RICoO/KnaF2ClD2MkKB
         mSnmDyB9kvyzgI6QsJHqTsSMKHlYkK6vMVlBPe8jCQPyetqbpSRV4EpaAgvyIpcL5Ovz
         NHtaR31CkIMsqe+2O+FJibTVv9oxnvNvfFwQXLgxpfHm2WIdDzUjoNSKS7/knU72sUGg
         y6cw==
X-Gm-Message-State: AOAM533lXQ3w+O4XgHrZAXkbJw+b0buVExIMHbQaoN8IhncxCfM9+QhJ
        p1YgwtYj3Lw71sBtNhaZ29vrP3wgeoOHgQ==
X-Google-Smtp-Source: ABdhPJxIkzUW6jsB1/tS5UpW4daYUR7JKtFHq6AD/9pt/KrSCA01djhLUwEBBTVAY+wCqFTsuULVzw==
X-Received: by 2002:a17:90b:4f4d:: with SMTP id pj13mr16595670pjb.243.1634974666927;
        Sat, 23 Oct 2021 00:37:46 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:5173:67c9:d8e4:2819:8ee8:8de4])
        by smtp.googlemail.com with ESMTPSA id c4sm13949791pfv.144.2021.10.23.00.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Oct 2021 00:37:46 -0700 (PDT)
From:   Kushal Kothari <kushalkothari285@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     kushalkothari285@gmail.com, kush19992810@gmail.com,
        outreachy-kernel@googlegroups.com, fabioaiuto83@gmail.com,
        ross.schm.dev@gmail.com, fmdefrancesco@gmail.com,
        marcocesati@gmail.com, straube.linux@gmail.com,
        philippesdixon@gmail.com, manuelpalenzuelamerino@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        mike.rapoport@gmail.com, kushalkotharitest@googlegroups.com
Subject: [PATCH v4 4/4] staging: rtl8723bs: core: Remove unnecessary blank lines
Date:   Sat, 23 Oct 2021 13:05:50 +0530
Message-Id: <78aabc0031d43c21ef06ae8d70f79412142d0784.1634967010.git.kushalkothari285@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1634967010.git.kushalkothari285@gmail.com>
References: <cover.1634967010.git.kushalkothari285@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove useless blank lines

Signed-off-by: Kushal Kothari <kushalkothari285@gmail.com>
---

Changes in v4: Move the version notes
Changes in v3: Enclose the version number inside the square bracket.
Changes in v2: Removed whitespace errors


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

