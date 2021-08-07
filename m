Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A088B3E34AB
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 12:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbhHGKOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 06:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbhHGKMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 06:12:50 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C51FC0617A0
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 03:12:15 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id z11so16813253edb.11
        for <linux-kernel@vger.kernel.org>; Sat, 07 Aug 2021 03:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qV8iw6djfXUmd2Gv7gUFlbNA4+5Yhb28eV2GFAVS/AE=;
        b=S3Fpe2ZS/UCzUyjZbYbMXVyxG/VkmkZtPJ+x3qJ/Ekjyfa7qCuwIuLR1UezbEjcuOW
         yIEuLAQM170WerpqONf926MbbJbJyYy+G9Xczbm2e4sQ5TohdYzGuQsk6sLbWFCn7z5N
         ELkMgWnQ+Atl9tKam3AVE+u9k/zhhGRbl4hK3ToAqBLpic/48NtT2IiVlKLAfrENJkEv
         r6V1e6KnvVA9TXqJpa4ZAhBH05GdiUrPN5ZThjUvf711fBqyIZTGKc+aCRd2NzUFQ5Wk
         5+cnSgXTtV/Vb3h8HyqnGa9GJ3tWC8DMCriQ8u/sN15gwcSymfdtN3gUHnn8XBwWw7rU
         Di3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qV8iw6djfXUmd2Gv7gUFlbNA4+5Yhb28eV2GFAVS/AE=;
        b=jB9xuut/toVU1AzRwvxdJNXb99gXRMlDFh5rwQTXpdgwfBg3LU93TZ7trxpDaZiHUF
         rt9nENql+NxI3jNhLO/2QkOKXiiC1a01MiDYVoKGBcfWSKTjhs/f2VHgTz0HpA5/hkMg
         IEOYUZbZfGCPrhVwIPK36NkMDKVAEXGGX0xjVWOv7adItK11le77ReMy0rpQfAAlgjsu
         UmSXetWjOY0PqKNbaCftR7xyT+Vohwhl+qEp5vfH7fkvwzCZXeHzd5mQrF7mQuMi1AlD
         b1DYwUlng6Ysu2uisFKn0OcUSjtBcAPt9cCitEckrxq5SyQx62IOADP0I6OtUZqs4Mh3
         yRqg==
X-Gm-Message-State: AOAM5309oUW4DIj+AIlk3IBzwbEmXzq8dqLYaJAvBa6BXviNJaSvUm6z
        S8NTFYVCRPoDiJHv2HGbR1k=
X-Google-Smtp-Source: ABdhPJzjJL3gWzpfB2XtBZVxytCPzGhtytyq6j2saKqLl2pptP5t9DJ//SQuSfqSf5K8bZVvkQvSfw==
X-Received: by 2002:a05:6402:3588:: with SMTP id y8mr17931127edc.362.1628331133842;
        Sat, 07 Aug 2021 03:12:13 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::a83e])
        by smtp.gmail.com with ESMTPSA id u4sm3662514eje.81.2021.08.07.03.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 03:12:13 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 09/17] staging: r8188eu: remove unnecessary parentheses in core/rtw_mlme.c
Date:   Sat,  7 Aug 2021 12:11:11 +0200
Message-Id: <20210807101119.16085-10-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210807101119.16085-1-straube.linux@gmail.com>
References: <20210807101119.16085-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary parentheses in core/rtw_mlme.c reported by
checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme.c | 108 ++++++++++++------------
 1 file changed, 54 insertions(+), 54 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index f28c30a6efb0..d688f2427b03 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -48,9 +48,9 @@ int	_rtw_init_mlme_priv (struct adapter *padapter)
 	pmlmepriv->cur_network.network.InfrastructureMode = Ndis802_11AutoUnknown;
 	pmlmepriv->scan_mode = SCAN_ACTIVE;/*  1: active, 0: pasive. Maybe someday we should rename this varable to "active_mode" (Jeff) */
 
-	spin_lock_init(&(pmlmepriv->lock));
-	_rtw_init_queue(&(pmlmepriv->free_bss_pool));
-	_rtw_init_queue(&(pmlmepriv->scanned_queue));
+	spin_lock_init(&pmlmepriv->lock);
+	_rtw_init_queue(&pmlmepriv->free_bss_pool);
+	_rtw_init_queue(&pmlmepriv->scanned_queue);
 
 	set_scanned_network_val(pmlmepriv, 0);
 
@@ -67,9 +67,9 @@ int	_rtw_init_mlme_priv (struct adapter *padapter)
 	pnetwork = (struct wlan_network *)pbuf;
 
 	for (i = 0; i < MAX_BSS_CNT; i++) {
-		INIT_LIST_HEAD(&(pnetwork->list));
+		INIT_LIST_HEAD(&pnetwork->list);
 
-		list_add_tail(&(pnetwork->list), &(pmlmepriv->free_bss_pool.queue));
+		list_add_tail(&pnetwork->list, &pmlmepriv->free_bss_pool.queue);
 
 		pnetwork++;
 	}
@@ -159,7 +159,7 @@ struct	wlan_network *_rtw_dequeue_network(struct __queue *queue)
 	} else {
 		pnetwork = container_of((&queue->queue)->next, struct wlan_network, list);
 
-		list_del_init(&(pnetwork->list));
+		list_del_init(&pnetwork->list);
 	}
 
 	spin_unlock_bh(&queue->lock);
@@ -179,7 +179,7 @@ struct	wlan_network *_rtw_alloc_network(struct	mlme_priv *pmlmepriv)/* _queue *f
 		pnetwork = NULL;
 		goto exit;
 	}
-	plist = (&(free_queue->queue))->next;
+	plist = (&free_queue->queue)->next;
 
 	pnetwork = container_of(plist, struct wlan_network, list);
 
@@ -203,7 +203,7 @@ void _rtw_free_network(struct mlme_priv *pmlmepriv, struct wlan_network *pnetwor
 {
 	u32 curr_time, delta_time;
 	u32 lifetime = SCANQUEUE_LIFETIME;
-	struct __queue *free_queue = &(pmlmepriv->free_bss_pool);
+	struct __queue *free_queue = &pmlmepriv->free_bss_pool;
 
 	if (!pnetwork)
 		return;
@@ -220,22 +220,22 @@ void _rtw_free_network(struct mlme_priv *pmlmepriv, struct wlan_network *pnetwor
 			return;
 	}
 	spin_lock_bh(&free_queue->lock);
-	list_del_init(&(pnetwork->list));
-	list_add_tail(&(pnetwork->list), &(free_queue->queue));
+	list_del_init(&pnetwork->list);
+	list_add_tail(&pnetwork->list, &free_queue->queue);
 	pmlmepriv->num_of_scanned--;
 	spin_unlock_bh(&free_queue->lock);
 }
 
 void _rtw_free_network_nolock(struct	mlme_priv *pmlmepriv, struct wlan_network *pnetwork)
 {
-	struct __queue *free_queue = &(pmlmepriv->free_bss_pool);
+	struct __queue *free_queue = &pmlmepriv->free_bss_pool;
 
 	if (!pnetwork)
 		return;
 	if (pnetwork->fixed)
 		return;
-	list_del_init(&(pnetwork->list));
-	list_add_tail(&(pnetwork->list), get_list_head(free_queue));
+	list_del_init(&pnetwork->list);
+	list_add_tail(&pnetwork->list, get_list_head(free_queue));
 	pmlmepriv->num_of_scanned--;
 }
 
@@ -473,7 +473,7 @@ void update_network(struct wlan_bssid_ex *dst, struct wlan_bssid_ex *src,
 	rtw_hal_antdiv_rssi_compared(padapter, dst, src); /* this will update src.Rssi, need consider again */
 
 	/* The rule below is 1/5 for sample value, 4/5 for history value */
-	if (check_fwstate(&padapter->mlmepriv, _FW_LINKED) && is_same_network(&(padapter->mlmepriv.cur_network.network), src)) {
+	if (check_fwstate(&padapter->mlmepriv, _FW_LINKED) && is_same_network(&padapter->mlmepriv.cur_network.network, src)) {
 		/* Take the recvpriv's value for the connected AP*/
 		ss_final = padapter->recvpriv.signal_strength;
 		sq_final = padapter->recvpriv.signal_qual;
@@ -507,11 +507,11 @@ void update_network(struct wlan_bssid_ex *dst, struct wlan_bssid_ex *src,
 
 static void update_current_network(struct adapter *adapter, struct wlan_bssid_ex *pnetwork)
 {
-	struct	mlme_priv	*pmlmepriv = &(adapter->mlmepriv);
+	struct	mlme_priv	*pmlmepriv = &adapter->mlmepriv;
 
 	if ((check_fwstate(pmlmepriv, _FW_LINKED) == true) &&
-	    (is_same_network(&(pmlmepriv->cur_network.network), pnetwork))) {
-		update_network(&(pmlmepriv->cur_network.network), pnetwork, adapter, true);
+	    (is_same_network(&pmlmepriv->cur_network.network, pnetwork))) {
+		update_network(&pmlmepriv->cur_network.network, pnetwork, adapter, true);
 		rtw_update_protection(adapter, (pmlmepriv->cur_network.network.IEs) + sizeof(struct ndis_802_11_fixed_ie),
 				      pmlmepriv->cur_network.network.IELength);
 	}
@@ -525,8 +525,8 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
 {
 	struct list_head *plist, *phead;
 	u32	bssid_ex_sz;
-	struct mlme_priv	*pmlmepriv = &(adapter->mlmepriv);
-	struct __queue *queue	= &(pmlmepriv->scanned_queue);
+	struct mlme_priv	*pmlmepriv = &adapter->mlmepriv;
+	struct __queue *queue	= &pmlmepriv->scanned_queue;
 	struct wlan_network	*pnetwork = NULL;
 	struct wlan_network	*oldest = NULL;
 
@@ -537,7 +537,7 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
 	while (phead != plist) {
 		pnetwork	= container_of(plist, struct wlan_network, list);
 
-		if (is_same_network(&(pnetwork->network), target))
+		if (is_same_network(&pnetwork->network, target))
 			break;
 		if ((oldest == ((struct wlan_network *)0)) ||
 		    time_after(oldest->last_scanned, pnetwork->last_scanned))
@@ -547,12 +547,12 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
 	/* If we didn't find a match, then get a new network slot to initialize
 	 * with this beacon's information */
 	if (phead == plist) {
-		if (list_empty(&(pmlmepriv->free_bss_pool.queue))) {
+		if (list_empty(&pmlmepriv->free_bss_pool.queue)) {
 			/* If there are no more slots, expire the oldest */
 			pnetwork = oldest;
 
-			rtw_hal_get_def_var(adapter, HAL_DEF_CURRENT_ANTENNA, &(target->PhyInfo.Optimum_antenna));
-			memcpy(&(pnetwork->network), target,  get_wlan_bssid_ex_sz(target));
+			rtw_hal_get_def_var(adapter, HAL_DEF_CURRENT_ANTENNA, &target->PhyInfo.Optimum_antenna);
+			memcpy(&pnetwork->network, target,  get_wlan_bssid_ex_sz(target));
 			/*  variable initialize */
 			pnetwork->fixed = false;
 			pnetwork->last_scanned = jiffies;
@@ -574,15 +574,15 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
 
 			bssid_ex_sz = get_wlan_bssid_ex_sz(target);
 			target->Length = bssid_ex_sz;
-			rtw_hal_get_def_var(adapter, HAL_DEF_CURRENT_ANTENNA, &(target->PhyInfo.Optimum_antenna));
-			memcpy(&(pnetwork->network), target, bssid_ex_sz);
+			rtw_hal_get_def_var(adapter, HAL_DEF_CURRENT_ANTENNA, &target->PhyInfo.Optimum_antenna);
+			memcpy(&pnetwork->network, target, bssid_ex_sz);
 
 			pnetwork->last_scanned = jiffies;
 
 			/* bss info not receiving from the right channel */
 			if (pnetwork->network.PhyInfo.SignalQuality == 101)
 				pnetwork->network.PhyInfo.SignalQuality = 0;
-			list_add_tail(&(pnetwork->list), &(queue->queue));
+			list_add_tail(&pnetwork->list, &queue->queue);
 		}
 	} else {
 		/* we have an entry and we are going to update it. But this entry may
@@ -600,7 +600,7 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
 			update_ie = true;
 		else
 			update_ie = false;
-		update_network(&(pnetwork->network), target, adapter, update_ie);
+		update_network(&pnetwork->network, target, adapter, update_ie);
 	}
 
 exit:
@@ -682,7 +682,7 @@ void rtw_survey_event_callback(struct adapter	*adapter, u8 *pbuf)
 {
 	u32 len;
 	struct wlan_bssid_ex *pnetwork;
-	struct	mlme_priv	*pmlmepriv = &(adapter->mlmepriv);
+	struct	mlme_priv	*pmlmepriv = &adapter->mlmepriv;
 
 	pnetwork = (struct wlan_bssid_ex *)pbuf;
 
@@ -693,7 +693,7 @@ void rtw_survey_event_callback(struct adapter	*adapter, u8 *pbuf)
 
 	/*  update IBSS_network 's timestamp */
 	if ((check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE)) == true) {
-		if (!memcmp(&(pmlmepriv->cur_network.network.MacAddress), pnetwork->MacAddress, ETH_ALEN)) {
+		if (!memcmp(&pmlmepriv->cur_network.network.MacAddress, pnetwork->MacAddress, ETH_ALEN)) {
 			struct wlan_network *ibss_wlan = NULL;
 
 			memcpy(pmlmepriv->cur_network.network.IEs, pnetwork->IEs, 8);
@@ -704,7 +704,7 @@ void rtw_survey_event_callback(struct adapter	*adapter, u8 *pbuf)
 				spin_unlock_bh(&pmlmepriv->scanned_queue.lock);
 				goto exit;
 			}
-			spin_unlock_bh(&(pmlmepriv->scanned_queue.lock));
+			spin_unlock_bh(&pmlmepriv->scanned_queue.lock);
 		}
 	}
 
@@ -722,7 +722,7 @@ void rtw_survey_event_callback(struct adapter	*adapter, u8 *pbuf)
 
 void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 {
-	struct	mlme_priv *pmlmepriv = &(adapter->mlmepriv);
+	struct	mlme_priv *pmlmepriv = &adapter->mlmepriv;
 	u8 timer_cancelled = 0;
 
 	spin_lock_bh(&pmlmepriv->lock);
@@ -755,7 +755,7 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 				if (rtw_select_and_join_from_scanned_queue(pmlmepriv) == _SUCCESS) {
 					_set_timer(&pmlmepriv->assoc_timer, MAX_JOIN_TIMEOUT);
 				} else {
-					struct wlan_bssid_ex    *pdev_network = &(adapter->registrypriv.dev_network);
+					struct wlan_bssid_ex    *pdev_network = &adapter->registrypriv.dev_network;
 					u8 *pibss = adapter->registrypriv.dev_network.MacAddress;
 
 					_clr_fwstate_(pmlmepriv, _FW_UNDER_SURVEY);
@@ -949,8 +949,8 @@ inline void rtw_indicate_scan_done(struct adapter *padapter, bool aborted)
 void rtw_scan_abort(struct adapter *adapter)
 {
 	u32 start;
-	struct mlme_priv	*pmlmepriv = &(adapter->mlmepriv);
-	struct mlme_ext_priv	*pmlmeext = &(adapter->mlmeextpriv);
+	struct mlme_priv	*pmlmepriv = &adapter->mlmepriv;
+	struct mlme_ext_priv	*pmlmeext = &adapter->mlmeextpriv;
 
 	start = jiffies;
 	pmlmeext->scan_abort = true;
@@ -1038,8 +1038,8 @@ static struct sta_info *rtw_joinbss_update_stainfo(struct adapter *padapter, str
 /* ptarget_wlan: found from scanned_queue */
 static void rtw_joinbss_update_network(struct adapter *padapter, struct wlan_network *ptarget_wlan, struct wlan_network  *pnetwork)
 {
-	struct mlme_priv	*pmlmepriv = &(padapter->mlmepriv);
-	struct wlan_network  *cur_network = &(pmlmepriv->cur_network);
+	struct mlme_priv	*pmlmepriv = &padapter->mlmepriv;
+	struct wlan_network  *cur_network = &pmlmepriv->cur_network;
 
 	DBG_88E("%s\n", __func__);
 
@@ -1092,9 +1092,9 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 	u8 timer_cancelled;
 	struct sta_info *ptarget_sta = NULL, *pcur_sta = NULL;
 	struct	sta_priv *pstapriv = &adapter->stapriv;
-	struct	mlme_priv	*pmlmepriv = &(adapter->mlmepriv);
+	struct	mlme_priv	*pmlmepriv = &adapter->mlmepriv;
 	struct wlan_network	*pnetwork	= (struct wlan_network *)pbuf;
-	struct wlan_network	*cur_network = &(pmlmepriv->cur_network);
+	struct wlan_network	*cur_network = &pmlmepriv->cur_network;
 	struct wlan_network	*pcur_wlan = NULL, *ptarget_wlan = NULL;
 	unsigned int		the_same_macaddr = false;
 
@@ -1203,11 +1203,11 @@ static u8 search_max_mac_id(struct adapter *padapter)
 	u8 mac_id;
 #if defined (CONFIG_88EU_AP_MODE)
 	u8 aid;
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 #endif
-	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 
 #if defined (CONFIG_88EU_AP_MODE)
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
@@ -1248,9 +1248,9 @@ void rtw_sta_media_status_rpt(struct adapter *adapter, struct sta_info *psta,
 void rtw_stassoc_event_callback(struct adapter *adapter, u8 *pbuf)
 {
 	struct sta_info *psta;
-	struct mlme_priv *pmlmepriv = &(adapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &adapter->mlmepriv;
 	struct stassoc_event	*pstassoc = (struct stassoc_event *)pbuf;
-	struct wlan_network	*cur_network = &(pmlmepriv->cur_network);
+	struct wlan_network	*cur_network = &pmlmepriv->cur_network;
 	struct wlan_network	*ptarget_wlan = NULL;
 
 	if (rtw_access_ctrl(adapter, pstassoc->macaddr) == false)
@@ -1307,10 +1307,10 @@ void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf)
 	struct wlan_network *pwlan = NULL;
 	struct wlan_bssid_ex *pdev_network = NULL;
 	u8 *pibss = NULL;
-	struct	mlme_priv *pmlmepriv = &(adapter->mlmepriv);
+	struct	mlme_priv *pmlmepriv = &adapter->mlmepriv;
 	struct	stadel_event *pstadel = (struct stadel_event *)pbuf;
 	struct	sta_priv *pstapriv = &adapter->stapriv;
-	struct wlan_network *tgt_network = &(pmlmepriv->cur_network);
+	struct wlan_network *tgt_network = &pmlmepriv->cur_network;
 
 	psta = rtw_get_stainfo(&adapter->stapriv, pstadel->macaddr);
 	if (psta)
@@ -1362,7 +1362,7 @@ void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf)
 	}
 	if (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) ||
 	    check_fwstate(pmlmepriv, WIFI_ADHOC_STATE)) {
-		spin_lock_bh(&(pstapriv->sta_hash_lock));
+		spin_lock_bh(&pstapriv->sta_hash_lock);
 		rtw_free_stainfo(adapter,  psta);
 		spin_unlock_bh(&pstapriv->sta_hash_lock);
 
@@ -1376,7 +1376,7 @@ void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf)
 			}
 			spin_unlock_bh(&pmlmepriv->scanned_queue.lock);
 			/* re-create ibss */
-			pdev_network = &(adapter->registrypriv.dev_network);
+			pdev_network = &adapter->registrypriv.dev_network;
 			pibss = adapter->registrypriv.dev_network.MacAddress;
 
 			memcpy(pdev_network, &tgt_network->network, get_wlan_bssid_ex_sz(&tgt_network->network));
@@ -1586,7 +1586,7 @@ int rtw_select_and_join_from_scanned_queue(struct mlme_priv *pmlmepriv)
 	int ret;
 	struct list_head *phead;
 	struct adapter *adapter;
-	struct __queue *queue	= &(pmlmepriv->scanned_queue);
+	struct __queue *queue	= &pmlmepriv->scanned_queue;
 	struct	wlan_network	*pnetwork = NULL;
 	struct	wlan_network	*candidate = NULL;
 	u8	supp_ant_div = false;
@@ -1645,7 +1645,7 @@ int rtw_set_auth(struct adapter *adapter, struct security_priv *psecuritypriv)
 {
 	struct	cmd_obj *pcmd;
 	struct	setauth_parm *psetauthparm;
-	struct	cmd_priv *pcmdpriv = &(adapter->cmdpriv);
+	struct	cmd_priv *pcmdpriv = &adapter->cmdpriv;
 	int		res = _SUCCESS;
 
 	pcmd = kzalloc(sizeof(struct cmd_obj), GFP_KERNEL);
@@ -1679,8 +1679,8 @@ int rtw_set_key(struct adapter *adapter, struct security_priv *psecuritypriv, in
 	u8	keylen;
 	struct cmd_obj		*pcmd;
 	struct setkey_parm	*psetkeyparm;
-	struct cmd_priv		*pcmdpriv = &(adapter->cmdpriv);
-	struct mlme_priv		*pmlmepriv = &(adapter->mlmepriv);
+	struct cmd_priv		*pcmdpriv = &adapter->cmdpriv;
+	struct mlme_priv		*pmlmepriv = &adapter->mlmepriv;
 	int	res = _SUCCESS;
 
 	pcmd = kzalloc(sizeof(struct cmd_obj), GFP_KERNEL);
@@ -1710,11 +1710,11 @@ int rtw_set_key(struct adapter *adapter, struct security_priv *psecuritypriv, in
 	switch (psetkeyparm->algorithm) {
 	case _WEP40_:
 		keylen = 5;
-		memcpy(&(psetkeyparm->key[0]), &(psecuritypriv->dot11DefKey[keyid].skey[0]), keylen);
+		memcpy(&psetkeyparm->key[0], &psecuritypriv->dot11DefKey[keyid].skey[0], keylen);
 		break;
 	case _WEP104_:
 		keylen = 13;
-		memcpy(&(psetkeyparm->key[0]), &(psecuritypriv->dot11DefKey[keyid].skey[0]), keylen);
+		memcpy(&psetkeyparm->key[0], &psecuritypriv->dot11DefKey[keyid].skey[0], keylen);
 		break;
 	case _TKIP_:
 		keylen = 16;
@@ -2059,7 +2059,7 @@ void rtw_update_ht_cap(struct adapter *padapter, u8 *pie, uint ie_len)
 	struct ht_priv		*phtpriv = &pmlmepriv->htpriv;
 	struct registry_priv *pregistrypriv = &padapter->registrypriv;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 
 	if (!phtpriv->ht_option)
 		return;
-- 
2.32.0

