Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86B65436BAC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 21:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbhJUUBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 16:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbhJUUBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 16:01:12 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613E7C061764
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 12:58:56 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id u6-20020a17090a3fc600b001a00250584aso3979921pjm.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 12:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hunu8VIKXcNrny3j2pos7KO6PvXPc5Dvy1fU9vz7EX0=;
        b=Z85SMHoXuvWe+8C9rzFW61Goo/2S+JbB4l5H/QEvINyMCyy1hGSvIpXw2QP/7L5qGo
         cfvwbEZUqwdk2ITr7mj2qvEonU4cFVtu+75X7/JuKQcGrZabyz1bDhDspdW85khUhlOa
         hh5v7OSEGd84iECT3Ihf1sGzxcsN23GMLNVYwKmBU4eOHQWwN+eHAUBycRKxLf9dpZfr
         EOxhXVDIm1QALM3dZdlx8hrV9EjxQkM1H46eTuquxN1ILsS/4PW2gDAplITB+bIs+6JV
         7mAd3wQ2XpqBl647fqyWa3WEFlTJ/FM0Hrue8wPbWMJmvj4YWLKup4YnZ15EnhFdcLUO
         t0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hunu8VIKXcNrny3j2pos7KO6PvXPc5Dvy1fU9vz7EX0=;
        b=QDf54ZVKFni08ebsR3HGYt2v1stEMDX7BBSaZbYMbBGFpxyrT+5yu+SMfehJoSl1cB
         GmjGlf9z/KqNL4KcvrNJhA5lW8qUQiW6T3VetoOvRQ6vD3cDEBxcGF+T75lgyAb7H/ko
         xmsFQ6tCe9xsW+8HGeWdS1cYPj65CLJWKLfhkd0wpfqzmz3oPoVtZyqOQBFsyasVWmAI
         ky0240nSTFvdW5Gn8jdu2yKYs2oG67KogDfE7MFPT/A5WWYRsK/TqE39OKQ0365w/7Nu
         a/lGxipZCYziR17ylvAneWkafvdNYt9AuUBNFR/NNQ5+U3laLvwY/9WIvZAjNZQVwrU3
         +bog==
X-Gm-Message-State: AOAM532tpL3G6U6orZqe0G6v/gOZ3qs3r/RcDZW/e9CuB9CR845QaRJi
        IN1brGW2V07+iJqhZ7TmCRA=
X-Google-Smtp-Source: ABdhPJzyiHmZqaS+okaCbNJDaNQ5QRMs4unzgukYBnjtfL8we85BxTuToQdvwRV6SuZTrhkXYyZDVw==
X-Received: by 2002:a17:902:7246:b0:138:a6ed:66cc with SMTP id c6-20020a170902724600b00138a6ed66ccmr7380499pll.22.1634846335830;
        Thu, 21 Oct 2021 12:58:55 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1fee:e3e7:7dfb:56c1:efef:3c0f])
        by smtp.googlemail.com with ESMTPSA id v9sm7198898pfc.23.2021.10.21.12.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 12:58:55 -0700 (PDT)
From:   Kushal Kothari <kushalkothari285@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     fabioaiuto83@gmail.com, kushalkothari285@gmail.com,
        ross.schm.dev@gmail.com, fmdefrancesco@gmail.com,
        marcocesati@gmail.com, straube.linux@gmail.com,
        philippesdixon@gmail.com, manuelpalenzuelamerino@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        mike.rapoport@gmail.com, kushalkotharitest@googlegroups.com,
        outreachy-kernel@googlegroups.com
Subject: [PATCH 2/4] staging: rtl8723bs: core: Remove unnecessary parentheses
Date:   Fri, 22 Oct 2021 01:27:51 +0530
Message-Id: <b97b81ff67867d564dca07a1737b2c53549b1fc5.1634845504.git.kushalkothari285@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1634845504.git.kushalkothari285@gmail.com>
References: <cover.1634845504.git.kushalkothari285@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Issue found with checkpatch.pl.
CHECK: Remove unnecessary parentheses

Signed-off-by: Kushal Kothari <kushalkothari285@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_cmd.c | 36 ++++++++++++------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index 0be3a8dbeec8..88f6b7405106 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -278,10 +278,10 @@ struct	cmd_obj	*_rtw_dequeue_cmd(struct __queue *queue)
 
 	/* spin_lock_bh(&(queue->lock)); */
 	spin_lock_irqsave(&queue->lock, irqL);
-	if (list_empty(&(queue->queue)))
+	if (list_empty(&queue->queue))
 		obj = NULL;
 	else {
-		obj = container_of(get_next(&(queue->queue)), struct cmd_obj, list);
+		obj = container_of(get_next(&queue->queue), struct cmd_obj, list);
 		list_del_init(&obj->list);
 	}
 
@@ -387,7 +387,7 @@ int rtw_cmd_thread(void *context)
 	u8 (*cmd_hdl)(struct adapter *padapter, u8 *pbuf);
 	void (*pcmd_callback)(struct adapter *dev, struct cmd_obj *pcmd);
 	struct adapter *padapter = context;
-	struct cmd_priv *pcmdpriv = &(padapter->cmdpriv);
+	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
 	struct drvextra_cmd_parm *extra_parm = NULL;
 
 	thread_enter("RTW_CMD_THREAD");
@@ -395,7 +395,7 @@ int rtw_cmd_thread(void *context)
 	pcmdbuf = pcmdpriv->cmd_buf;
 
 	pcmdpriv->stop_req = 0;
-	atomic_set(&(pcmdpriv->cmdthd_running), true);
+	atomic_set(&pcmdpriv->cmdthd_running, true);
 	complete(&pcmdpriv->terminate_cmdthread_comp);
 
 	while (1) {
@@ -471,7 +471,7 @@ int rtw_cmd_thread(void *context)
 
 post_process:
 
-		if (mutex_lock_interruptible(&(pcmd->padapter->cmdpriv.sctx_mutex)) == 0) {
+		if (mutex_lock_interruptible(&pcmd->padapter->cmdpriv.sctx_mutex) == 0) {
 			if (pcmd->sctx) {
 				netdev_dbg(padapter->pnetdev,
 					   FUNC_ADPT_FMT " pcmd->sctx\n",
@@ -482,7 +482,7 @@ int rtw_cmd_thread(void *context)
 				else
 					rtw_sctx_done_err(&pcmd->sctx, RTW_SCTX_DONE_CMD_ERROR);
 			}
-			mutex_unlock(&(pcmd->padapter->cmdpriv.sctx_mutex));
+			mutex_unlock(&pcmd->padapter->cmdpriv.sctx_mutex);
 		}
 
 		/* call callback function for post-processed */
@@ -522,7 +522,7 @@ int rtw_cmd_thread(void *context)
 	} while (1);
 
 	complete(&pcmdpriv->terminate_cmdthread_comp);
-	atomic_set(&(pcmdpriv->cmdthd_running), false);
+	atomic_set(&pcmdpriv->cmdthd_running, false);
 
 	thread_exit();
 }
@@ -724,7 +724,7 @@ u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network *pnetwork)
 	struct ht_priv 		*phtpriv = &pmlmepriv->htpriv;
 	enum ndis_802_11_network_infrastructure ndis_network_mode = pnetwork->network.infrastructure_mode;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 	u32 tmp_len;
 	u8 *ptmp = NULL;
 
@@ -1243,7 +1243,7 @@ u8 traffic_status_watchdog(struct adapter *padapter, u8 from_timer)
 	u8 bBusyTraffic = false, bTxBusyTraffic = false, bRxBusyTraffic = false;
 	u8 bHigherBusyTraffic = false, bHigherBusyRxTraffic = false, bHigherBusyTxTraffic = false;
 
-	struct mlme_priv 	*pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv 	*pmlmepriv = &padapter->mlmepriv;
 
 	collect_traffic_statistics(padapter);
 
@@ -1315,7 +1315,7 @@ u8 traffic_status_watchdog(struct adapter *padapter, u8 from_timer)
 		struct dvobj_priv *dvobj = adapter_to_dvobj(padapter);
 		int n_assoc_iface = 0;
 
-		if (check_fwstate(&(dvobj->padapters->mlmepriv), WIFI_ASOC_STATE))
+		if (check_fwstate(&dvobj->padapters->mlmepriv, WIFI_ASOC_STATE))
 			n_assoc_iface++;
 
 		if (!from_timer && n_assoc_iface == 0)
@@ -1340,7 +1340,7 @@ static void dynamic_chk_wk_hdl(struct adapter *padapter)
 {
 	struct mlme_priv *pmlmepriv;
 
-	pmlmepriv = &(padapter->mlmepriv);
+	pmlmepriv = &padapter->mlmepriv;
 
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE))
 		expire_timeout_chk(padapter);
@@ -1374,7 +1374,7 @@ void lps_ctrl_wk_hdl(struct adapter *padapter, u8 lps_ctrl_type);
 void lps_ctrl_wk_hdl(struct adapter *padapter, u8 lps_ctrl_type)
 {
 	struct pwrctrl_priv *pwrpriv = adapter_to_pwrctl(padapter);
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	u8 mstatus;
 
 	if (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) ||
@@ -1959,7 +1959,7 @@ void rtw_createbss_cmd_callback(struct adapter *padapter, struct cmd_obj *pcmd)
 	struct wlan_network *pwlan = NULL;
 	struct	mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct wlan_bssid_ex *pnetwork = (struct wlan_bssid_ex *)pcmd->parmbuf;
-	struct wlan_network *tgt_network = &(pmlmepriv->cur_network);
+	struct wlan_network *tgt_network = &pmlmepriv->cur_network;
 
 	if (!pcmd->parmbuf)
 		goto exit;
@@ -1983,20 +1983,20 @@ void rtw_createbss_cmd_callback(struct adapter *padapter, struct cmd_obj *pcmd)
 		rtw_indicate_connect(padapter);
 	} else {
 		pwlan = rtw_alloc_network(pmlmepriv);
-		spin_lock_bh(&(pmlmepriv->scanned_queue.lock));
+		spin_lock_bh(&pmlmepriv->scanned_queue.lock);
 		if (!pwlan) {
 			pwlan = rtw_get_oldest_wlan_network(&pmlmepriv->scanned_queue);
 			if (!pwlan) {
-				spin_unlock_bh(&(pmlmepriv->scanned_queue.lock));
+				spin_unlock_bh(&pmlmepriv->scanned_queue.lock);
 				goto createbss_cmd_fail;
 			}
 			pwlan->last_scanned = jiffies;
 		} else {
-			list_add_tail(&(pwlan->list), &pmlmepriv->scanned_queue.queue);
+			list_add_tail(&pwlan->list, &pmlmepriv->scanned_queue.queue);
 		}
 
 		pnetwork->length = get_wlan_bssid_ex_sz(pnetwork);
-		memcpy(&(pwlan->network), pnetwork, pnetwork->length);
+		memcpy(&pwlan->network, pnetwork, pnetwork->length);
 		/* pwlan->fixed = true; */
 
 		/* list_add_tail(&(pwlan->list), &pmlmepriv->scanned_queue.queue); */
@@ -2009,7 +2009,7 @@ void rtw_createbss_cmd_callback(struct adapter *padapter, struct cmd_obj *pcmd)
 
 		_clr_fwstate_(pmlmepriv, _FW_UNDER_LINKING);
 
-		spin_unlock_bh(&(pmlmepriv->scanned_queue.lock));
+		spin_unlock_bh(&pmlmepriv->scanned_queue.lock);
 		/*  we will set _FW_LINKED when there is one more sat to join us (rtw_stassoc_event_callback) */
 
 	}
-- 
2.25.1

