Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53EB436DD24
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 18:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240424AbhD1QgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 12:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbhD1QgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 12:36:11 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5FBC061573
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 09:35:26 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id d3-20020a9d29030000b029027e8019067fso57016846otb.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 09:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=Nl+DHXIvt+VKBIZUla8kEIUg+AyptLAiIyesaY7Tl30=;
        b=ak8upl7G5GgK/rmdXxvAMX84QdXA0YmvXglcVkvEw0DmvW/Lbvcs6OegwEuVRjFAH+
         Zw3BGBuN3gjrYOOclSyqbVI38LNy/5NOBs//mTXPBaFSpweb5y77h8xU+murHMDSILo3
         +NfZ9W+PNv/018taVD7TIUEkMQhSgsL+x4UJNe0xZHBiTXec9LFPQ7afg8FaLjW2b5lC
         QoyAKft/QSwI1o1FvKPDw2P5ILqThdNQQm0MkLlVWtcjhBHjwVVqjJlx5HysVCIc7SSj
         3hv6//gxRUgk2ijf4iNl/MWxOCwFZyNAlCouL7snVqq+Y72skDWEphprF/24+iXt3f/M
         jvbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=Nl+DHXIvt+VKBIZUla8kEIUg+AyptLAiIyesaY7Tl30=;
        b=hXRtXMznh4WqrRQONC8QD2knAPiopi2nj2ZjMi3nAF3f1r3zXGacikveP+2JwjrVS/
         KZA47jyL0lLEQANlaW8Bze+G6DhpT8NQCMtK1t+prOtRUyoJ3h7qlR5a2hHKsEzzny/s
         6aO4AUpDjfPySJz6N+8HInn3FhN0fxNbRIBj5VsjnZCQmz9VDEcE3OIFuY5DHst+v9lD
         7phXvfXJw3vC94CYnnDmRqDn/l08d976xIKO7GF17hKrNHY37cMg8yGR9xgaE/KuphHV
         WLJbHJ8QgaCUv0JZ9AKzTN7bFZtcrBJOOUp1XPXYVGFsiZEL30e/Yrd7B94mmmi7HSRb
         2R+A==
X-Gm-Message-State: AOAM530dvgrMjUXzahlA/e9KsTi5yWhfJzXqS/qfeZ/Zp6FxXwl9XUp7
        gjEbiNNrCDY53ZIvimo8xas=
X-Google-Smtp-Source: ABdhPJz/xuJV+esSExFK0TP6Ahr2y5tlJB39JTsCS/JvdEOS3YpQzDA0rpaAX6wr55hMGosjgGp13Q==
X-Received: by 2002:a05:6830:10a:: with SMTP id i10mr9954597otp.36.1619627725802;
        Wed, 28 Apr 2021 09:35:25 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x24sm96955otk.16.2021.04.28.09.35.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Apr 2021 09:35:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] staging: rtl8188eu: Use list iterators and helpers
Date:   Wed, 28 Apr 2021 09:35:22 -0700
Message-Id: <20210428163522.129189-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rtl8188eu manually re-implements list helper functions
and macros in various ways. Replace with existing list helpers.

The following coccinelle script was used to convert the code.

@@
identifier v1, v2, v3, v4;
symbol next;
expression e;
iterator name list_for_each;
statement S;
@@

<+...
(
- e = v1->next;
|
- e = get_next(v1);
)
  ... when != e
- while ( \( v1 != e \| e != v1 \) )
+ list_for_each (e, v1)
  {
    ...
-   v2 = container_of(e, struct v3, v4);
+   v2 = list_entry(e, struct v3, v4);
?-  if (!v2) S
    ...
(
-   e = e->next;
|
- e = get_next(e);
)
    ... when != e
  }
...+>

@@
identifier v1, v2, v3, v4;
symbol next;
expression e;
iterator name list_for_each;
statement S;
@@

<+...
(
- e = v1->next;
|
- e = get_next(v1);
)
  ... when != e
- while (1)
+ list_for_each (e, v1)
  {
- if ( \( e == v1 \| v1 == e \) )
-   break;
    ...
-   v2 = container_of(e, struct v3, v4);
+   v2 = list_entry(e, struct v3, v4);
?-  if (!v2) S
    ...
(
-   e = e->next;
|
- e = get_next(e);
)
    ... when != e
  }
...+>

Manually fixed up formatting, and added autoremoved comments back in.
Compile tested only.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/staging/rtl8188eu/core/rtw_ap.c       | 50 +++++-------------
 drivers/staging/rtl8188eu/core/rtw_mlme.c     | 34 ++++--------
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c | 19 +++----
 drivers/staging/rtl8188eu/core/rtw_sta_mgt.c  | 28 +++-------
 drivers/staging/rtl8188eu/core/rtw_xmit.c     | 52 ++++++-------------
 .../staging/rtl8188eu/hal/rtl8188eu_xmit.c    |  8 ++-
 .../staging/rtl8188eu/os_dep/ioctl_linux.c    | 26 +++-------
 drivers/staging/rtl8188eu/os_dep/xmit_linux.c |  8 +--
 8 files changed, 67 insertions(+), 158 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_ap.c b/drivers/staging/rtl8188eu/core/rtw_ap.c
index 008b60e72758..ca9a321c4921 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ap.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ap.c
@@ -175,12 +175,9 @@ void expire_timeout_chk(struct adapter *padapter)
 	spin_lock_bh(&pstapriv->auth_list_lock);
 
 	phead = &pstapriv->auth_list;
-	plist = phead->next;
-
 	/* check auth_queue */
-	while (phead != plist) {
-		psta = container_of(plist, struct sta_info, auth_list);
-		plist = plist->next;
+	list_for_each(plist, phead) {
+		psta = list_entry(plist, struct sta_info, auth_list);
 
 		if (psta->expire_to > 0) {
 			psta->expire_to--;
@@ -208,12 +205,9 @@ void expire_timeout_chk(struct adapter *padapter)
 	spin_lock_bh(&pstapriv->asoc_list_lock);
 
 	phead = &pstapriv->asoc_list;
-	plist = phead->next;
-
 	/* check asoc_queue */
-	while (phead != plist) {
-		psta = container_of(plist, struct sta_info, asoc_list);
-		plist = plist->next;
+	list_for_each(plist, phead) {
+		psta = list_entry(plist, struct sta_info, asoc_list);
 
 		if (chk_sta_is_alive(psta) || !psta->expire_to) {
 			psta->expire_to = pstapriv->expire_to;
@@ -1032,11 +1026,8 @@ int rtw_acl_add_sta(struct adapter *padapter, u8 *addr)
 	spin_lock_bh(&pacl_node_q->lock);
 
 	phead = get_list_head(pacl_node_q);
-	plist = phead->next;
-
-	while (phead != plist) {
-		paclnode = container_of(plist, struct rtw_wlan_acl_node, list);
-		plist = plist->next;
+	list_for_each(plist, phead) {
+		paclnode = list_entry(plist, struct rtw_wlan_acl_node, list);
 
 		if (!memcmp(paclnode->addr, addr, ETH_ALEN)) {
 			if (paclnode->valid) {
@@ -1092,11 +1083,8 @@ int rtw_acl_remove_sta(struct adapter *padapter, u8 *addr)
 	spin_lock_bh(&pacl_node_q->lock);
 
 	phead = get_list_head(pacl_node_q);
-	plist = phead->next;
-
-	while (phead != plist) {
-		paclnode = container_of(plist, struct rtw_wlan_acl_node, list);
-		plist = plist->next;
+	list_for_each(plist, phead) {
+		paclnode = list_entry(plist, struct rtw_wlan_acl_node, list);
 
 		if (!memcmp(paclnode->addr, addr, ETH_ALEN)) {
 			if (paclnode->valid) {
@@ -1338,13 +1326,9 @@ void associated_clients_update(struct adapter *padapter, u8 updated)
 		spin_lock_bh(&pstapriv->asoc_list_lock);
 
 		phead = &pstapriv->asoc_list;
-		plist = phead->next;
-
 		/* check asoc_queue */
-		while (phead != plist) {
-			psta = container_of(plist, struct sta_info, asoc_list);
-
-			plist = plist->next;
+		list_for_each(plist, phead) {
+			psta = list_entry(plist, struct sta_info, asoc_list);
 
 			VCS_update(padapter, psta);
 		}
@@ -1609,13 +1593,9 @@ int rtw_sta_flush(struct adapter *padapter)
 
 	spin_lock_bh(&pstapriv->asoc_list_lock);
 	phead = &pstapriv->asoc_list;
-	plist = phead->next;
-
 	/* free sta asoc_queue */
-	while (phead != plist) {
-		psta = container_of(plist, struct sta_info, asoc_list);
-
-		plist = plist->next;
+	list_for_each(plist, phead) {
+		psta = list_entry(plist, struct sta_info, asoc_list);
 
 		list_del_init(&psta->asoc_list);
 		pstapriv->asoc_list_cnt--;
@@ -1738,10 +1718,8 @@ void stop_ap_mode(struct adapter *padapter)
 	/* for ACL */
 	spin_lock_bh(&pacl_node_q->lock);
 	phead = get_list_head(pacl_node_q);
-	plist = phead->next;
-	while (phead != plist) {
-		paclnode = container_of(plist, struct rtw_wlan_acl_node, list);
-		plist = plist->next;
+	list_for_each(plist, phead) {
+		paclnode = list_entry(plist, struct rtw_wlan_acl_node, list);
 
 		if (paclnode->valid) {
 			paclnode->valid = false;
diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme.c b/drivers/staging/rtl8188eu/core/rtw_mlme.c
index b6ac5b8915b1..049e25455849 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme.c
@@ -188,13 +188,10 @@ struct wlan_network *rtw_find_network(struct __queue *scanned_queue, u8 *addr)
 		goto exit;
 	}
 	phead = get_list_head(scanned_queue);
-	plist = phead->next;
-
-	while (plist != phead) {
-		pnetwork = container_of(plist, struct wlan_network, list);
+	list_for_each(plist, phead) {
+		pnetwork = list_entry(plist, struct wlan_network, list);
 		if (!memcmp(addr, pnetwork->network.MacAddress, ETH_ALEN))
 			break;
-		plist = plist->next;
 	}
 	if (plist == phead)
 		pnetwork = NULL;
@@ -212,12 +209,8 @@ void rtw_free_network_queue(struct adapter *padapter, u8 isfreeall)
 	spin_lock_bh(&scanned_queue->lock);
 
 	phead = get_list_head(scanned_queue);
-	plist = phead->next;
-
-	while (phead != plist) {
-		pnetwork = container_of(plist, struct wlan_network, list);
-
-		plist = plist->next;
+	list_for_each(plist, phead) {
+		pnetwork = list_entry(plist, struct wlan_network, list);
 
 		_rtw_free_network(pmlmepriv, pnetwork, isfreeall);
 	}
@@ -400,17 +393,14 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
 
 	spin_lock_bh(&queue->lock);
 	phead = get_list_head(queue);
-	plist = phead->next;
-
-	while (phead != plist) {
-		pnetwork = container_of(plist, struct wlan_network, list);
+	list_for_each(plist, phead) {
+		pnetwork = list_entry(plist, struct wlan_network, list);
 
 		if (is_same_network(&pnetwork->network, target))
 			break;
 		if ((oldest == ((struct wlan_network *)0)) ||
 		    time_after(oldest->last_scanned, pnetwork->last_scanned))
 			oldest = pnetwork;
-		plist = plist->next;
 	}
 	/* If we didn't find a match, then get a new network slot to initialize
 	 * with this beacon's information
@@ -1465,15 +1455,9 @@ int rtw_select_and_join_from_scanned_queue(struct mlme_priv *pmlmepriv)
 	spin_lock_bh(&pmlmepriv->scanned_queue.lock);
 	phead = get_list_head(queue);
 	adapter = (struct adapter *)pmlmepriv->nic_hdl;
-	pmlmepriv->pscanned = phead->next;
-	while (phead != pmlmepriv->pscanned) {
-		pnetwork = container_of(pmlmepriv->pscanned, struct wlan_network, list);
-		if (!pnetwork) {
-			RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("%s return _FAIL:(pnetwork==NULL)\n", __func__));
-			ret = _FAIL;
-			goto exit;
-		}
-		pmlmepriv->pscanned = pmlmepriv->pscanned->next;
+	list_for_each(pmlmepriv->pscanned, phead) {
+		pnetwork = list_entry(pmlmepriv->pscanned,
+				      struct wlan_network, list);
 		rtw_check_join_candidate(pmlmepriv, &candidate, pnetwork);
 	}
 	if (!candidate) {
diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
index 50d3c3631be0..53a3939666ea 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
@@ -1760,16 +1760,13 @@ static void issue_action_BSSCoexistPacket(struct adapter *padapter)
 		spin_lock_bh(&pmlmepriv->scanned_queue.lock);
 
 		phead = get_list_head(queue);
-		plist = phead->next;
-
-		while (phead != plist) {
+		list_for_each(plist, phead) {
 			uint len;
 			u8 *p;
 			struct wlan_bssid_ex *pbss_network;
 
-			pnetwork = container_of(plist, struct wlan_network, list);
-
-			plist = plist->next;
+			pnetwork = list_entry(plist, struct wlan_network,
+					      list);
 
 			pbss_network = &pnetwork->network;
 
@@ -5400,12 +5397,10 @@ u8 tx_beacon_hdl(struct adapter *padapter, unsigned char *pbuf)
 			spin_lock_bh(&psta_bmc->sleep_q.lock);
 
 			xmitframe_phead = get_list_head(&psta_bmc->sleep_q);
-			xmitframe_plist = xmitframe_phead->next;
-
-			while (xmitframe_phead != xmitframe_plist) {
-				pxmitframe = container_of(xmitframe_plist, struct xmit_frame, list);
-
-				xmitframe_plist = xmitframe_plist->next;
+			list_for_each(xmitframe_plist, xmitframe_phead) {
+				pxmitframe = list_entry(xmitframe_plist,
+							struct xmit_frame,
+							list);
 
 				list_del_init(&pxmitframe->list);
 
diff --git a/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c b/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
index 3c03141e25b1..7941ca0397ed 100644
--- a/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
+++ b/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
@@ -142,13 +142,10 @@ u32 _rtw_free_sta_priv(struct sta_priv *pstapriv)
 	spin_lock_bh(&pstapriv->sta_hash_lock);
 	for (index = 0; index < NUM_STA; index++) {
 		phead = &pstapriv->sta_hash[index];
-		plist = phead->next;
-
-		while (phead != plist) {
+		list_for_each(plist, phead) {
 			int i;
 
-			psta = container_of(plist, struct sta_info, hash_list);
-			plist = plist->next;
+			psta = list_entry(plist, struct sta_info, hash_list);
 
 			for (i = 0; i < 16; i++) {
 				preorder_ctrl = &psta->recvreorder_ctrl[i];
@@ -395,12 +392,8 @@ void rtw_free_all_stainfo(struct adapter *padapter)
 
 	for (index = 0; index < NUM_STA; index++) {
 		phead = &pstapriv->sta_hash[index];
-		plist = phead->next;
-
-		while (phead != plist) {
-			psta = container_of(plist, struct sta_info, hash_list);
-
-			plist = plist->next;
+		list_for_each(plist, phead) {
+			psta = list_entry(plist, struct sta_info, hash_list);
 
 			if (pbcmc_stainfo != psta)
 				rtw_free_stainfo(padapter, psta);
@@ -431,17 +424,14 @@ struct sta_info *rtw_get_stainfo(struct sta_priv *pstapriv, u8 *hwaddr)
 	spin_lock_bh(&pstapriv->sta_hash_lock);
 
 	phead = &pstapriv->sta_hash[index];
-	plist = phead->next;
-
-	while (phead != plist) {
-		psta = container_of(plist, struct sta_info, hash_list);
+	list_for_each(plist, phead) {
+		psta = list_entry(plist, struct sta_info, hash_list);
 
 		if (!memcmp(psta->hwaddr, addr, ETH_ALEN)) {
 			/*  if found the matched address */
 			break;
 		}
 		psta = NULL;
-		plist = plist->next;
 	}
 
 	spin_unlock_bh(&pstapriv->sta_hash_lock);
@@ -489,10 +479,8 @@ bool rtw_access_ctrl(struct adapter *padapter, u8 *mac_addr)
 
 	spin_lock_bh(&pacl_node_q->lock);
 	phead = get_list_head(pacl_node_q);
-	plist = phead->next;
-	while (phead != plist) {
-		paclnode = container_of(plist, struct rtw_wlan_acl_node, list);
-		plist = plist->next;
+	list_for_each(plist, phead) {
+		paclnode = list_entry(plist, struct rtw_wlan_acl_node, list);
 
 		if (!memcmp(paclnode->addr, mac_addr, ETH_ALEN)) {
 			if (paclnode->valid) {
diff --git a/drivers/staging/rtl8188eu/core/rtw_xmit.c b/drivers/staging/rtl8188eu/core/rtw_xmit.c
index 99e44b2c6f36..3763d188b892 100644
--- a/drivers/staging/rtl8188eu/core/rtw_xmit.c
+++ b/drivers/staging/rtl8188eu/core/rtw_xmit.c
@@ -1335,12 +1335,8 @@ void rtw_free_xmitframe_queue(struct xmit_priv *pxmitpriv, struct __queue *pfram
 	spin_lock_bh(&pframequeue->lock);
 
 	phead = get_list_head(pframequeue);
-	plist = phead->next;
-
-	while (phead != plist) {
-		pxmitframe = container_of(plist, struct xmit_frame, list);
-
-		plist = plist->next;
+	list_for_each(plist, phead) {
+		pxmitframe = list_entry(plist, struct xmit_frame, list);
 
 		rtw_free_xmitframe(pxmitpriv, pxmitframe);
 	}
@@ -1404,10 +1400,9 @@ struct xmit_frame *rtw_dequeue_xframe(struct xmit_priv *pxmitpriv, struct hw_xmi
 		phwxmit = phwxmit_i + inx[i];
 
 		sta_phead = get_list_head(phwxmit->sta_queue);
-		sta_plist = sta_phead->next;
-
-		while (sta_phead != sta_plist) {
-			ptxservq = container_of(sta_plist, struct tx_servq, tx_pending);
+		list_for_each(sta_plist, sta_phead) {
+			ptxservq = list_entry(sta_plist, struct tx_servq,
+					      tx_pending);
 
 			pframe_queue = &ptxservq->sta_pending;
 
@@ -1421,8 +1416,6 @@ struct xmit_frame *rtw_dequeue_xframe(struct xmit_priv *pxmitpriv, struct hw_xmi
 					list_del_init(&ptxservq->tx_pending);
 				goto exit;
 			}
-
-			sta_plist = sta_plist->next;
 		}
 	}
 exit:
@@ -1746,12 +1739,8 @@ static void dequeue_xmitframes_to_sleeping_queue(struct adapter *padapter, struc
 	struct hw_xmit *phwxmits =  padapter->xmitpriv.hwxmits;
 
 	phead = get_list_head(pframequeue);
-	plist = phead->next;
-
-	while (phead != plist) {
-		pxmitframe = container_of(plist, struct xmit_frame, list);
-
-		plist = plist->next;
+	list_for_each(plist, phead) {
+		pxmitframe = list_entry(plist, struct xmit_frame, list);
 
 		xmitframe_enqueue_for_sleeping_sta(padapter, pxmitframe);
 
@@ -1818,12 +1807,9 @@ void wakeup_sta_to_xmit(struct adapter *padapter, struct sta_info *psta)
 	spin_lock_bh(&psta->sleep_q.lock);
 
 	xmitframe_phead = get_list_head(&psta->sleep_q);
-	xmitframe_plist = xmitframe_phead->next;
-
-	while (xmitframe_phead != xmitframe_plist) {
-		pxmitframe = container_of(xmitframe_plist, struct xmit_frame, list);
-
-		xmitframe_plist = xmitframe_plist->next;
+	list_for_each(xmitframe_plist, xmitframe_phead) {
+		pxmitframe = list_entry(xmitframe_plist, struct xmit_frame,
+					list);
 
 		list_del_init(&pxmitframe->list);
 
@@ -1899,12 +1885,9 @@ void wakeup_sta_to_xmit(struct adapter *padapter, struct sta_info *psta)
 		spin_lock_bh(&psta_bmc->sleep_q.lock);
 
 		xmitframe_phead = get_list_head(&psta_bmc->sleep_q);
-		xmitframe_plist = xmitframe_phead->next;
-
-		while (xmitframe_phead != xmitframe_plist) {
-			pxmitframe = container_of(xmitframe_plist, struct xmit_frame, list);
-
-			xmitframe_plist = xmitframe_plist->next;
+		list_for_each(xmitframe_plist, xmitframe_phead) {
+			pxmitframe = list_entry(xmitframe_plist,
+						struct xmit_frame, list);
 
 			list_del_init(&pxmitframe->list);
 
@@ -1946,12 +1929,9 @@ void xmit_delivery_enabled_frames(struct adapter *padapter, struct sta_info *pst
 	spin_lock_bh(&psta->sleep_q.lock);
 
 	xmitframe_phead = get_list_head(&psta->sleep_q);
-	xmitframe_plist = xmitframe_phead->next;
-
-	while (xmitframe_phead != xmitframe_plist) {
-		pxmitframe = container_of(xmitframe_plist, struct xmit_frame, list);
-
-		xmitframe_plist = xmitframe_plist->next;
+	list_for_each(xmitframe_plist, xmitframe_phead) {
+		pxmitframe = list_entry(xmitframe_plist, struct xmit_frame,
+					list);
 
 		switch (pxmitframe->attrib.priority) {
 		case 1:
diff --git a/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c b/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c
index 2866283c211d..10a8dcc6ca95 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c
@@ -507,11 +507,9 @@ bool rtl8188eu_xmitframe_complete(struct adapter *adapt,
 	spin_lock_bh(&pxmitpriv->lock);
 
 	xmitframe_phead = get_list_head(&ptxservq->sta_pending);
-	xmitframe_plist = xmitframe_phead->next;
-
-	while (xmitframe_phead != xmitframe_plist) {
-		pxmitframe = container_of(xmitframe_plist, struct xmit_frame, list);
-		xmitframe_plist = xmitframe_plist->next;
+	list_for_each(xmitframe_plist, xmitframe_phead) {
+		pxmitframe = list_entry(xmitframe_plist, struct xmit_frame,
+					list);
 
 		pxmitframe->agg_num = 0; /*  not first frame of aggregation */
 		pxmitframe->pkt_offset = 0; /*  not first frame of aggregation, no need to reserve offset */
diff --git a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
index c95ae4d6a3b6..b402c85888ae 100644
--- a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
@@ -952,12 +952,9 @@ static int rtw_wx_set_wap(struct net_device *dev,
 	authmode = padapter->securitypriv.ndisauthtype;
 	spin_lock_bh(&queue->lock);
 	phead = get_list_head(queue);
-	pmlmepriv->pscanned = phead->next;
-
-	while (phead != pmlmepriv->pscanned) {
-		pnetwork = container_of(pmlmepriv->pscanned, struct wlan_network, list);
-
-		pmlmepriv->pscanned = pmlmepriv->pscanned->next;
+	list_for_each(pmlmepriv->pscanned, phead) {
+		pnetwork = list_entry(pmlmepriv->pscanned,
+				      struct wlan_network, list);
 
 		dst_bssid = pnetwork->network.MacAddress;
 
@@ -1211,21 +1208,17 @@ static int rtw_wx_get_scan(struct net_device *dev, struct iw_request_info *a,
 	spin_lock_bh(&pmlmepriv->scanned_queue.lock);
 
 	phead = get_list_head(queue);
-	plist = phead->next;
-
-	while (phead != plist) {
+	list_for_each(plist, phead) {
 		if ((stop - ev) < SCAN_ITEM_SIZE) {
 			ret = -E2BIG;
 			break;
 		}
 
-		pnetwork = container_of(plist, struct wlan_network, list);
+		pnetwork = list_entry(plist, struct wlan_network, list);
 
 		/* report network only if the current channel set contains the channel to which this network belongs */
 		if (rtw_ch_set_search_ch(padapter->mlmeextpriv.channel_set, pnetwork->network.Configuration.DSConfig) >= 0)
 			ev = translate_scan(padapter, a, pnetwork, ev, stop);
-
-		plist = plist->next;
 	}
 
 	spin_unlock_bh(&pmlmepriv->scanned_queue.lock);
@@ -1295,12 +1288,9 @@ static int rtw_wx_set_essid(struct net_device *dev,
 		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_, ("%s: ssid =[%s]\n", __func__, src_ssid));
 		spin_lock_bh(&queue->lock);
 		phead = get_list_head(queue);
-		pmlmepriv->pscanned = phead->next;
-
-		while (phead != pmlmepriv->pscanned) {
-			pnetwork = container_of(pmlmepriv->pscanned, struct wlan_network, list);
-
-			pmlmepriv->pscanned = pmlmepriv->pscanned->next;
+		list_for_each(pmlmepriv->pscanned, phead) {
+			pnetwork = list_entry(pmlmepriv->pscanned,
+					      struct wlan_network, list);
 
 			dst_ssid = pnetwork->network.ssid.ssid;
 
diff --git a/drivers/staging/rtl8188eu/os_dep/xmit_linux.c b/drivers/staging/rtl8188eu/os_dep/xmit_linux.c
index a9c42fb80583..6935bdb2d7d2 100644
--- a/drivers/staging/rtl8188eu/os_dep/xmit_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/xmit_linux.c
@@ -118,13 +118,9 @@ static int rtw_mlcst2unicst(struct adapter *padapter, struct sk_buff *skb)
 
 	spin_lock_bh(&pstapriv->asoc_list_lock);
 	phead = &pstapriv->asoc_list;
-	plist = phead->next;
-
 	/* free sta asoc_queue */
-	while (phead != plist) {
-		psta = container_of(plist, struct sta_info, asoc_list);
-
-		plist = plist->next;
+	list_for_each(plist, phead) {
+		psta = list_entry(plist, struct sta_info, asoc_list);
 
 		/* avoid come from STA1 and send back STA1 */
 		if (!memcmp(psta->hwaddr, &skb->data[6], 6))
-- 
2.17.1

