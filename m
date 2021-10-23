Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05274438238
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 09:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbhJWHjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 03:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbhJWHjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 03:39:41 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B0CC061764
        for <linux-kernel@vger.kernel.org>; Sat, 23 Oct 2021 00:37:22 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id o4-20020a17090a3d4400b001a1c8344c3fso5272245pjf.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Oct 2021 00:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q5L97OuwvQtPMGsCqSSGgMgXb4wrKIfzBKtlfkqJvOI=;
        b=lLTSW56+Lh2AK6bcA539cCpPFy2XFgZpbl6+f59UyIzQ+qx/kT774kanb0VHOOOXB3
         zXlA/az5KJhmCXh7+5t3uRBFYOriWC/tAaWrmAOItPBTndXeUXg9m1JbaZqKR2WgccTK
         nzT2KTpuXKDPiCqgWySnX2vh84/W5IkVJotbqJoTz/c/rU5Z+gyN0ZauXBMy8tWKfvIZ
         dQ/mZyLkJJJUn7wuCNO8f/pEEoOTcFVv25rrE5+pzNPcwOrCuoU3ormiBzw2mfN6Vox6
         Qakj/tV4L9jmDPky9A2JLAUggGL1xQczFDe5eNuRPBLrs7gX8IZu12g/ZOHx/2K5wW4Z
         a62g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q5L97OuwvQtPMGsCqSSGgMgXb4wrKIfzBKtlfkqJvOI=;
        b=Tuu9xwF1rV3mmSu6OTGmy5Yikv9Hs+KRwFtpEHMOrYbEzjWdC41pQ4cohbjKwzDeja
         0jzlpLez+bTxrydbOskzwXAbH8dfa4oAvaCNGhq71z3d6M9U0/8M3gpU0UOa71u3wdmU
         EbP4+60fHSre3po8WHAE7hVQhva/6ln4IYoQRt7PeCWy95ly8bTu+WRqKwv0nsd2F1Ck
         clDg8d15KXgByn6SmS0y2UfDBr9349BN1RvxySkrxAIpanhNYRZ52bQmmYMij2Sbh/lR
         +rJ7qxBLeSaVu020nfh5mROY0NYrQQxvlXTswy8LtjLsvmhnkIkNr8JlFWWteYa3jNHM
         UbhA==
X-Gm-Message-State: AOAM533lHCl7efm4MJUEBwwqIbRQAdutNeUITB/Dg912NzKXkr7VdIYt
        ki9OIGWMIu3ciCFVLefi5d4=
X-Google-Smtp-Source: ABdhPJzKraX28dMuIvjB4WYbMivSrkPfL6JR38arhnzCYkIKGCCEwlcfE6bw1m4bEztbQnfk92Pd2A==
X-Received: by 2002:a17:90b:3144:: with SMTP id ip4mr5458803pjb.23.1634974642253;
        Sat, 23 Oct 2021 00:37:22 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:5173:67c9:d8e4:2819:8ee8:8de4])
        by smtp.googlemail.com with ESMTPSA id c4sm13949791pfv.144.2021.10.23.00.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Oct 2021 00:37:21 -0700 (PDT)
From:   Kushal Kothari <kushalkothari285@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     kushalkothari285@gmail.com, kush19992810@gmail.com,
        outreachy-kernel@googlegroups.com, fabioaiuto83@gmail.com,
        ross.schm.dev@gmail.com, fmdefrancesco@gmail.com,
        marcocesati@gmail.com, straube.linux@gmail.com,
        philippesdixon@gmail.com, manuelpalenzuelamerino@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        mike.rapoport@gmail.com, kushalkotharitest@googlegroups.com
Subject: [PATCH v4 1/4] staging: rtl8723bs: core: Remove true and false comparison
Date:   Sat, 23 Oct 2021 13:05:47 +0530
Message-Id: <47dd38847c4e36742f88f4493773fef602ca079b.1634967010.git.kushalkothari285@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1634967010.git.kushalkothari285@gmail.com>
References: <cover.1634967010.git.kushalkothari285@gmail.com>
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

Changes in v4: move these version notes
Changes in v3: Enclose the version number inside the square bracket.
Changes in v2: Unnecessary parantheses handled in *v2 staging: rtl8723bs: core: Remove unnecessary parentheses*

 drivers/staging/rtl8723bs/core/rtw_cmd.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index 2624e994513f..acd4e8b1fad5 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -371,7 +371,7 @@ void rtw_free_cmd_obj(struct cmd_obj *pcmd)
 void rtw_stop_cmd_thread(struct adapter *adapter)
 {
 	if (adapter->cmdThread &&
-		atomic_read(&(adapter->cmdpriv.cmdthd_running)) == true &&
+		atomic_read(&(adapter->cmdpriv.cmdthd_running)) &&
 		adapter->cmdpriv.stop_req == 0) {
 		adapter->cmdpriv.stop_req = 1;
 		complete(&adapter->cmdpriv.cmd_queue_comp);
@@ -542,7 +542,7 @@ u8 rtw_sitesurvey_cmd(struct adapter  *padapter, struct ndis_802_11_ssid *ssid,
 	struct cmd_priv 	*pcmdpriv = &padapter->cmdpriv;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
-	if (check_fwstate(pmlmepriv, _FW_LINKED) == true)
+	if (check_fwstate(pmlmepriv, _FW_LINKED))
 		rtw_lps_ctrl_wk_cmd(padapter, LPS_CTRL_SCAN, 1);
 
 	ph2c = rtw_zmalloc(sizeof(struct cmd_obj));
@@ -775,7 +775,7 @@ u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network *pnetwork)
 	/*  If not,  we have to copy the connecting AP's MAC address to it so that */
 	/*  the driver just has the bssid information for PMKIDList searching. */
 
-	if (pmlmepriv->assoc_by_bssid == false)
+	if (!pmlmepriv->assoc_by_bssid)
 		memcpy(&pmlmepriv->assoc_bssid[0], &pnetwork->network.mac_address[0], ETH_ALEN);
 
 	psecnetwork->ie_length = rtw_restruct_sec_ie(padapter, &pnetwork->network.ies[0], &psecnetwork->ies[0], pnetwork->network.ie_length);
@@ -1164,7 +1164,7 @@ u8 rtw_set_chplan_cmd(struct adapter *padapter, u8 chplan, u8 enqueue, u8 swconf
 	u8 res = _SUCCESS;
 
 	/*  check if allow software config */
-	if (swconfig && rtw_hal_is_disable_sw_channel_plan(padapter) == true) {
+	if (swconfig && rtw_hal_is_disable_sw_channel_plan(padapter)) {
 		res = _FAIL;
 		goto exit;
 	}
@@ -1250,7 +1250,7 @@ u8 traffic_status_watchdog(struct adapter *padapter, u8 from_timer)
 	/*  */
 	/*  Determine if our traffic is busy now */
 	/*  */
-	if ((check_fwstate(pmlmepriv, _FW_LINKED) == true)
+	if ((check_fwstate(pmlmepriv, _FW_LINKED))
 		/*&& !MgntInitAdapterInProgress(pMgntInfo)*/) {
 		/*  if we raise bBusyTraffic in last watchdog, using lower threshold. */
 		if (pmlmepriv->LinkDetectInfo.bBusyTraffic)
@@ -1342,7 +1342,7 @@ static void dynamic_chk_wk_hdl(struct adapter *padapter)
 
 	pmlmepriv = &(padapter->mlmepriv);
 
-	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) == true)
+	if (check_fwstate(pmlmepriv, WIFI_AP_STATE))
 		expire_timeout_chk(padapter);
 
 	/* for debug purpose */
@@ -1377,8 +1377,8 @@ void lps_ctrl_wk_hdl(struct adapter *padapter, u8 lps_ctrl_type)
 	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
 	u8 mstatus;
 
-	if ((check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) == true)
-		|| (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true)) {
+	if ((check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE)) ||
+		(check_fwstate(pmlmepriv, WIFI_ADHOC_STATE))) {
 		return;
 	}
 
@@ -1386,7 +1386,7 @@ void lps_ctrl_wk_hdl(struct adapter *padapter, u8 lps_ctrl_type)
 	case LPS_CTRL_SCAN:
 		hal_btcoex_ScanNotify(padapter, true);
 
-		if (check_fwstate(pmlmepriv, _FW_LINKED) == true) {
+		if (check_fwstate(pmlmepriv, _FW_LINKED)) {
 			/*  connect */
 			LPS_Leave(padapter, "LPS_CTRL_SCAN");
 		}
@@ -1512,7 +1512,7 @@ static void rtw_lps_change_dtim_hdl(struct adapter *padapter, u8 dtim)
 	if (dtim <= 0 || dtim > 16)
 		return;
 
-	if (hal_btcoex_IsBtControlLps(padapter) == true)
+	if (hal_btcoex_IsBtControlLps(padapter))
 		return;
 
 	mutex_lock(&pwrpriv->lock);
@@ -1840,7 +1840,7 @@ static void c2h_wk_callback(struct work_struct *work)
 			continue;
 		}
 
-		if (ccx_id_filter(c2h_evt) == true) {
+		if (ccx_id_filter(c2h_evt)) {
 			/* Handle CCX report here */
 			rtw_hal_c2h_handler(adapter, c2h_evt);
 			kfree(c2h_evt);
-- 
2.25.1

