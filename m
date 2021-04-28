Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B62336DE57
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 19:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241660AbhD1Rdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 13:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241617AbhD1Rdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 13:33:51 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B93C061573
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 10:33:06 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id i11so1841237oig.8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 10:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=FFINBNoKMiY7f/aqEgnoWdIqZA3UkQqLjkIkXzXhdm8=;
        b=LGi7zG81i4tJukLkqlK2tsgeQc9XkQ0QWFSINubKjnwp7DYzNMVlh5BhosaiSM5Lv9
         kJlPPRrMPa076dtU9pSQswsogHEyYhuRbRIgXSm4jPS1xpvItpW4GUitirKCiFFWmoy0
         0ZHJ+izay1UAQwhOEGmQkwZ3yi6D+OF30LL9CwEzhXVabu7QXP4PnbqBSoe4eGfWueM8
         3O+8Ub6HXq7NxJZi2K9PKEPAKLoqXK5n0BYKGoELvKGwsHm7bDLkDWrJqAjKTY7jO51A
         0rFGWLS3hCXlYycRMzAhm97dUb/iawP3SR5XcK8ZTxXwycQG6cI6OsQxGIWkQQ2c7jJO
         5QeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=FFINBNoKMiY7f/aqEgnoWdIqZA3UkQqLjkIkXzXhdm8=;
        b=MgLGOnVUBAab5hlmeV3ZzTjyyqK/bv/eRRvnRGWSld3YAr/QOeOck+x1dyuxjDLAVg
         3rxfVAbU+BEefBpPlnCeKFwBv7f2O1hdH+uc6q/4ArRSyG32GscSajsoDy0dfyBDQfsl
         +qDpYX9EXgtI9YBzMeuLG35MNvO33PEI7lXmSP/z/4024ZKU7QZSzXumxMuS6C0TSEzg
         GpRFz0ElWA860si4DBiNiXxWLptOEbPbQOjWRu6Sf8HwEQMjf/6SzILjj+c2REenzqmL
         mT7CbNtCPAUm3pCRmtK2NHHSH/4de769pvrkpXI0zo6YtyXatxVTGSBFHCA40hPxA3rj
         +7Kw==
X-Gm-Message-State: AOAM530GqaF2gNeyY5VeCFDdq5shVredbeoOFtwT9aOzV40KNfwGJ8Pr
        1f37mdl4Y+7BC0HnzhE1mMI=
X-Google-Smtp-Source: ABdhPJxObvNY7L8NC34CxSR9KBJKYU/Y6vgwFolotvoqcyVFxFtg0sQyNurQE1JfoBworhBzUGXiVQ==
X-Received: by 2002:a54:438c:: with SMTP id u12mr21881929oiv.114.1619631185705;
        Wed, 28 Apr 2021 10:33:05 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id o25sm96187oie.45.2021.04.28.10.33.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Apr 2021 10:33:05 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] staging: rtl8723bs: Use list iterators and helpers
Date:   Wed, 28 Apr 2021 10:33:01 -0700
Message-Id: <20210428173301.149619-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rtl8723bs driver manually re-implements list helper functions
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

Manually fixed up formatting, and added auto-removed comments back in.
Compile tested only.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c       | 58 +++++----------
 drivers/staging/rtl8723bs/core/rtw_mlme.c     | 72 +++++--------------
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 16 ++---
 drivers/staging/rtl8723bs/core/rtw_sta_mgt.c  | 36 +++-------
 drivers/staging/rtl8723bs/core/rtw_xmit.c     | 43 ++++-------
 .../staging/rtl8723bs/hal/rtl8723bs_xmit.c    |  7 +-
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 19 ++---
 .../staging/rtl8723bs/os_dep/ioctl_linux.c    | 47 +++---------
 drivers/staging/rtl8723bs/os_dep/xmit_linux.c |  8 +--
 9 files changed, 82 insertions(+), 224 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index 4a9bd4825fab..1b92cf9da524 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -188,13 +188,9 @@ void expire_timeout_chk(struct adapter *padapter)
 	spin_lock_bh(&pstapriv->auth_list_lock);
 
 	phead = &pstapriv->auth_list;
-	plist = get_next(phead);
-
 	/* check auth_queue */
-	while (phead != plist) {
-		psta = container_of(plist, struct sta_info, auth_list);
-
-		plist = get_next(plist);
+	list_for_each(plist, phead) {
+		psta = list_entry(plist, struct sta_info, auth_list);
 
 		if (psta->expire_to > 0) {
 			psta->expire_to--;
@@ -217,12 +213,9 @@ void expire_timeout_chk(struct adapter *padapter)
 	spin_lock_bh(&pstapriv->asoc_list_lock);
 
 	phead = &pstapriv->asoc_list;
-	plist = get_next(phead);
-
 	/* check asoc_queue */
-	while (phead != plist) {
-		psta = container_of(plist, struct sta_info, asoc_list);
-		plist = get_next(plist);
+	list_for_each(plist, phead) {
+		psta = list_entry(plist, struct sta_info, asoc_list);
 		if (chk_sta_is_alive(psta) || !psta->expire_to) {
 			psta->expire_to = pstapriv->expire_to;
 			psta->keep_alive_trycnt = 0;
@@ -1210,11 +1203,8 @@ int rtw_acl_add_sta(struct adapter *padapter, u8 *addr)
 	spin_lock_bh(&(pacl_node_q->lock));
 
 	phead = get_list_head(pacl_node_q);
-	plist = get_next(phead);
-
-	while (phead != plist) {
-		paclnode = container_of(plist, struct rtw_wlan_acl_node, list);
-		plist = get_next(plist);
+	list_for_each(plist, phead) {
+		paclnode = list_entry(plist, struct rtw_wlan_acl_node, list);
 
 		if (!memcmp(paclnode->addr, addr, ETH_ALEN)) {
 			if (paclnode->valid == true) {
@@ -1266,11 +1256,8 @@ void rtw_acl_remove_sta(struct adapter *padapter, u8 *addr)
 	spin_lock_bh(&(pacl_node_q->lock));
 
 	phead = get_list_head(pacl_node_q);
-	plist = get_next(phead);
-
-	while (phead != plist) {
-		paclnode = container_of(plist, struct rtw_wlan_acl_node, list);
-		plist = get_next(plist);
+	list_for_each(plist, phead) {
+		paclnode = list_entry(plist, struct rtw_wlan_acl_node, list);
 
 		if (
 			!memcmp(paclnode->addr, addr, ETH_ALEN) ||
@@ -1716,13 +1703,9 @@ void associated_clients_update(struct adapter *padapter, u8 updated)
 		spin_lock_bh(&pstapriv->asoc_list_lock);
 
 		phead = &pstapriv->asoc_list;
-		plist = get_next(phead);
-
 		/* check asoc_queue */
-		while (phead != plist) {
-			psta = container_of(plist, struct sta_info, asoc_list);
-
-			plist = get_next(plist);
+		list_for_each(plist, phead) {
+			psta = list_entry(plist, struct sta_info, asoc_list);
 
 			VCS_update(padapter, psta);
 		}
@@ -1972,13 +1955,9 @@ void rtw_sta_flush(struct adapter *padapter)
 
 	spin_lock_bh(&pstapriv->asoc_list_lock);
 	phead = &pstapriv->asoc_list;
-	plist = get_next(phead);
-
 	/* free sta asoc_queue */
-	while (phead != plist) {
-		psta = container_of(plist, struct sta_info, asoc_list);
-
-		plist = get_next(plist);
+	list_for_each(plist, phead) {
+		psta = list_entry(plist, struct sta_info, asoc_list);
 
 		list_del_init(&psta->asoc_list);
 		pstapriv->asoc_list_cnt--;
@@ -2075,13 +2054,10 @@ void rtw_ap_restore_network(struct adapter *padapter)
 	spin_lock_bh(&pstapriv->asoc_list_lock);
 
 	phead = &pstapriv->asoc_list;
-	plist = get_next(phead);
-
-	while (phead != plist) {
+	list_for_each(plist, phead) {
 		int stainfo_offset;
 
-		psta = container_of(plist, struct sta_info, asoc_list);
-		plist = get_next(plist);
+		psta = list_entry(plist, struct sta_info, asoc_list);
 
 		stainfo_offset = rtw_stainfo_offset(pstapriv, psta);
 		if (stainfo_offset_valid(stainfo_offset))
@@ -2184,10 +2160,8 @@ void stop_ap_mode(struct adapter *padapter)
 	/* for ACL */
 	spin_lock_bh(&(pacl_node_q->lock));
 	phead = get_list_head(pacl_node_q);
-	plist = get_next(phead);
-	while (phead != plist) {
-		paclnode = container_of(plist, struct rtw_wlan_acl_node, list);
-		plist = get_next(plist);
+	list_for_each(plist, phead) {
+		paclnode = list_entry(plist, struct rtw_wlan_acl_node, list);
 
 		if (paclnode->valid) {
 			paclnode->valid = false;
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 4707dba90397..7886aca056ed 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -244,15 +244,11 @@ struct wlan_network *_rtw_find_network(struct __queue *scanned_queue, u8 *addr)
 	/* spin_lock_bh(&scanned_queue->lock); */
 
 	phead = get_list_head(scanned_queue);
-	plist = get_next(phead);
-
-	while (plist != phead) {
-		pnetwork = container_of(plist, struct wlan_network, list);
+	list_for_each(plist, phead) {
+		pnetwork = list_entry(plist, struct wlan_network, list);
 
 		if (!memcmp(addr, pnetwork->network.MacAddress, ETH_ALEN))
 			break;
-
-		plist = get_next(plist);
 	}
 
 	if (plist == phead)
@@ -274,13 +270,9 @@ void rtw_free_network_queue(struct adapter *padapter, u8 isfreeall)
 	spin_lock_bh(&scanned_queue->lock);
 
 	phead = get_list_head(scanned_queue);
-	plist = get_next(phead);
-
-	while (phead != plist) {
+	list_for_each(plist, phead) {
 
-		pnetwork = container_of(plist, struct wlan_network, list);
-
-		plist = get_next(plist);
+		pnetwork = list_entry(plist, struct wlan_network, list);
 
 		_rtw_free_network(pmlmepriv, pnetwork, isfreeall);
 
@@ -422,15 +414,11 @@ struct wlan_network *_rtw_find_same_network(struct __queue *scanned_queue, struc
 	struct wlan_network *found = NULL;
 
 	phead = get_list_head(scanned_queue);
-	plist = get_next(phead);
-
-	while (plist != phead) {
-		found = container_of(plist, struct wlan_network, list);
+	list_for_each(plist, phead) {
+		found = list_entry(plist, struct wlan_network, list);
 
 		if (is_same_network(&network->network, &found->network, 0))
 			break;
-
-		plist = get_next(plist);
 	}
 
 	if (plist == phead)
@@ -448,21 +436,14 @@ struct	wlan_network	*rtw_get_oldest_wlan_network(struct __queue *scanned_queue)
 
 	phead = get_list_head(scanned_queue);
 
-	plist = get_next(phead);
-
-	while (1) {
-
-		if (phead == plist)
-			break;
+	list_for_each(plist, phead) {
 
-		pwlan = container_of(plist, struct wlan_network, list);
+		pwlan = list_entry(plist, struct wlan_network, list);
 
 		if (!pwlan->fixed) {
 			if (oldest == NULL || time_after(oldest->last_scanned, pwlan->last_scanned))
 				oldest = pwlan;
 		}
-
-		plist = get_next(plist);
 	}
 	return oldest;
 
@@ -549,13 +530,8 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
 
 	spin_lock_bh(&queue->lock);
 	phead = get_list_head(queue);
-	plist = get_next(phead);
-
-	while (1) {
-		if (phead == plist)
-			break;
-
-		pnetwork = container_of(plist, struct wlan_network, list);
+	list_for_each(plist, phead) {
+		pnetwork = list_entry(plist, struct wlan_network, list);
 
 		rtw_bug_check(pnetwork, pnetwork, pnetwork, pnetwork);
 
@@ -571,8 +547,6 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
 		if (oldest == NULL || time_after(oldest->last_scanned, pnetwork->last_scanned))
 			oldest = pnetwork;
 
-		plist = get_next(plist);
-
 	}
 
 	/* If we didn't find a match, then get a new network slot to initialize
@@ -1788,17 +1762,10 @@ int rtw_select_roaming_candidate(struct mlme_priv *mlme)
 	spin_lock_bh(&(mlme->scanned_queue.lock));
 	phead = get_list_head(queue);
 
-	mlme->pscanned = get_next(phead);
-
-	while (phead != mlme->pscanned) {
+	list_for_each(mlme->pscanned, phead) {
 
-		pnetwork = container_of(mlme->pscanned, struct wlan_network, list);
-		if (!pnetwork) {
-			ret = _FAIL;
-			goto exit;
-		}
-
-		mlme->pscanned = get_next(mlme->pscanned);
+		pnetwork = list_entry(mlme->pscanned, struct wlan_network,
+				      list);
 
 		rtw_check_roaming_candidate(mlme, &candidate, pnetwork);
 
@@ -1892,17 +1859,10 @@ int rtw_select_and_join_from_scanned_queue(struct mlme_priv *pmlmepriv)
 	}
 
 	phead = get_list_head(queue);
-	pmlmepriv->pscanned = get_next(phead);
-
-	while (phead != pmlmepriv->pscanned) {
-
-		pnetwork = container_of(pmlmepriv->pscanned, struct wlan_network, list);
-		if (!pnetwork) {
-			ret = _FAIL;
-			goto exit;
-		}
+	list_for_each(pmlmepriv->pscanned, phead) {
 
-		pmlmepriv->pscanned = get_next(pmlmepriv->pscanned);
+		pnetwork = list_entry(pmlmepriv->pscanned,
+				      struct wlan_network, list);
 
 		rtw_check_join_candidate(pmlmepriv, &candidate, pnetwork);
 
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 9031cf7657ae..b01ff36cf08d 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -5135,10 +5135,9 @@ void _linked_info_dump(struct adapter *padapter)
 
 			spin_lock_bh(&pstapriv->asoc_list_lock);
 			phead = &pstapriv->asoc_list;
-			plist = get_next(phead);
-			while (phead != plist) {
-				psta = container_of(plist, struct sta_info, asoc_list);
-				plist = get_next(plist);
+			list_for_each(plist, phead) {
+				psta = list_entry(plist, struct sta_info,
+						  asoc_list);
 			}
 			spin_unlock_bh(&pstapriv->asoc_list_lock);
 
@@ -6080,12 +6079,9 @@ u8 chk_bmc_sleepq_hdl(struct adapter *padapter, unsigned char *pbuf)
 		spin_lock_bh(&pxmitpriv->lock);
 
 		xmitframe_phead = get_list_head(&psta_bmc->sleep_q);
-		xmitframe_plist = get_next(xmitframe_phead);
-
-		while (xmitframe_phead != xmitframe_plist) {
-			pxmitframe = container_of(xmitframe_plist, struct xmit_frame, list);
-
-			xmitframe_plist = get_next(xmitframe_plist);
+		list_for_each(xmitframe_plist, xmitframe_phead) {
+			pxmitframe = list_entry(xmitframe_plist,
+						struct xmit_frame, list);
 
 			list_del_init(&pxmitframe->list);
 
diff --git a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
index 85663182b388..9cb2c7a112d2 100644
--- a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
+++ b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
@@ -124,11 +124,8 @@ void kfree_all_stainfo(struct sta_priv *pstapriv)
 	spin_lock_bh(&pstapriv->sta_hash_lock);
 
 	phead = get_list_head(&pstapriv->free_sta_queue);
-	plist = get_next(phead);
-
-	while (phead != plist) {
-		psta = container_of(plist, struct sta_info, list);
-		plist = get_next(plist);
+	list_for_each(plist, phead) {
+		psta = list_entry(plist, struct sta_info, list);
 	}
 
 	spin_unlock_bh(&pstapriv->sta_hash_lock);
@@ -152,13 +149,11 @@ u32 _rtw_free_sta_priv(struct	sta_priv *pstapriv)
 		spin_lock_bh(&pstapriv->sta_hash_lock);
 		for (index = 0; index < NUM_STA; index++) {
 			phead = &(pstapriv->sta_hash[index]);
-			plist = get_next(phead);
-
-			while (phead != plist) {
+			list_for_each(plist, phead) {
 				int i;
 
-				psta = container_of(plist, struct sta_info, hash_list);
-				plist = get_next(plist);
+				psta = list_entry(plist, struct sta_info,
+						  hash_list);
 
 				for (i = 0; i < 16 ; i++) {
 					preorder_ctrl = &psta->recvreorder_ctrl[i];
@@ -442,12 +437,8 @@ void rtw_free_all_stainfo(struct adapter *padapter)
 
 	for (index = 0; index < NUM_STA; index++) {
 		phead = &(pstapriv->sta_hash[index]);
-		plist = get_next(phead);
-
-		while (phead != plist) {
-			psta = container_of(plist, struct sta_info, hash_list);
-
-			plist = get_next(plist);
+		list_for_each(plist, phead) {
+			psta = list_entry(plist, struct sta_info, hash_list);
 
 			if (pbcmc_stainfo != psta)
 				rtw_free_stainfo(padapter, psta);
@@ -479,17 +470,14 @@ struct sta_info *rtw_get_stainfo(struct sta_priv *pstapriv, u8 *hwaddr)
 	spin_lock_bh(&pstapriv->sta_hash_lock);
 
 	phead = &(pstapriv->sta_hash[index]);
-	plist = get_next(phead);
-
-	while (phead != plist) {
-		psta = container_of(plist, struct sta_info, hash_list);
+	list_for_each(plist, phead) {
+		psta = list_entry(plist, struct sta_info, hash_list);
 
 		if ((!memcmp(psta->hwaddr, addr, ETH_ALEN)))
 		 /*  if found the matched address */
 			break;
 
 		psta = NULL;
-		plist = get_next(plist);
 	}
 
 	spin_unlock_bh(&pstapriv->sta_hash_lock);
@@ -539,10 +527,8 @@ u8 rtw_access_ctrl(struct adapter *padapter, u8 *mac_addr)
 
 	spin_lock_bh(&(pacl_node_q->lock));
 	phead = get_list_head(pacl_node_q);
-	plist = get_next(phead);
-	while (phead != plist) {
-		paclnode = container_of(plist, struct rtw_wlan_acl_node, list);
-		plist = get_next(plist);
+	list_for_each(plist, phead) {
+		paclnode = list_entry(plist, struct rtw_wlan_acl_node, list);
 
 		if (!memcmp(paclnode->addr, mac_addr, ETH_ALEN))
 			if (paclnode->valid == true) {
diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
index bd3acdd7d75f..40e539596c52 100644
--- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
+++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
@@ -1731,12 +1731,8 @@ void rtw_free_xmitframe_queue(struct xmit_priv *pxmitpriv, struct __queue *pfram
 	spin_lock_bh(&pframequeue->lock);
 
 	phead = get_list_head(pframequeue);
-	plist = get_next(phead);
-
-	while (phead != plist) {
-		pxmitframe = container_of(plist, struct xmit_frame, list);
-
-		plist = get_next(plist);
+	list_for_each(plist, phead) {
+		pxmitframe = list_entry(plist, struct xmit_frame, list);
 
 		rtw_free_xmitframe(pxmitpriv, pxmitframe);
 	}
@@ -2136,12 +2132,8 @@ static void dequeue_xmitframes_to_sleeping_queue(struct adapter *padapter, struc
 	struct hw_xmit *phwxmits =  padapter->xmitpriv.hwxmits;
 
 	phead = get_list_head(pframequeue);
-	plist = get_next(phead);
-
-	while (phead != plist) {
-		pxmitframe = container_of(plist, struct xmit_frame, list);
-
-		plist = get_next(plist);
+	list_for_each(plist, phead) {
+		pxmitframe = list_entry(plist, struct xmit_frame, list);
 
 		pattrib = &pxmitframe->attrib;
 
@@ -2211,12 +2203,9 @@ void wakeup_sta_to_xmit(struct adapter *padapter, struct sta_info *psta)
 	spin_lock_bh(&pxmitpriv->lock);
 
 	xmitframe_phead = get_list_head(&psta->sleep_q);
-	xmitframe_plist = get_next(xmitframe_phead);
-
-	while (xmitframe_phead != xmitframe_plist) {
-		pxmitframe = container_of(xmitframe_plist, struct xmit_frame, list);
-
-		xmitframe_plist = get_next(xmitframe_plist);
+	list_for_each(xmitframe_plist, xmitframe_phead) {
+		pxmitframe = list_entry(xmitframe_plist, struct xmit_frame,
+					list);
 
 		list_del_init(&pxmitframe->list);
 
@@ -2285,12 +2274,9 @@ void wakeup_sta_to_xmit(struct adapter *padapter, struct sta_info *psta)
 
 	if ((pstapriv->sta_dz_bitmap&0xfffe) == 0x0) { /* no any sta in ps mode */
 		xmitframe_phead = get_list_head(&psta_bmc->sleep_q);
-		xmitframe_plist = get_next(xmitframe_phead);
-
-		while (xmitframe_phead != xmitframe_plist) {
-			pxmitframe = container_of(xmitframe_plist, struct xmit_frame, list);
-
-			xmitframe_plist = get_next(xmitframe_plist);
+		list_for_each(xmitframe_plist, xmitframe_phead) {
+			pxmitframe = list_entry(xmitframe_plist,
+						struct xmit_frame, list);
 
 			list_del_init(&pxmitframe->list);
 
@@ -2332,12 +2318,9 @@ void xmit_delivery_enabled_frames(struct adapter *padapter, struct sta_info *pst
 	spin_lock_bh(&pxmitpriv->lock);
 
 	xmitframe_phead = get_list_head(&psta->sleep_q);
-	xmitframe_plist = get_next(xmitframe_phead);
-
-	while (xmitframe_phead != xmitframe_plist) {
-		pxmitframe = container_of(xmitframe_plist, struct xmit_frame, list);
-
-		xmitframe_plist = get_next(xmitframe_plist);
+	list_for_each(xmitframe_plist, xmitframe_phead) {
+		pxmitframe = list_entry(xmitframe_plist, struct xmit_frame,
+					list);
 
 		switch (pxmitframe->attrib.priority) {
 		case 1:
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c b/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
index bd95e62fb053..ec9f275cbc7e 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
@@ -223,12 +223,11 @@ static s32 xmit_xmitframes(struct adapter *padapter, struct xmit_priv *pxmitpriv
 		spin_lock_bh(&pxmitpriv->lock);
 
 		sta_phead = get_list_head(phwxmit->sta_queue);
-		sta_plist = get_next(sta_phead);
 		/* because stop_sta_xmit may delete sta_plist at any time */
 		/* so we should add lock here, or while loop can not exit */
-		while (sta_phead != sta_plist) {
-			ptxservq = container_of(sta_plist, struct tx_servq, tx_pending);
-			sta_plist = get_next(sta_plist);
+		list_for_each(sta_plist, sta_phead) {
+			ptxservq = list_entry(sta_plist, struct tx_servq,
+					      tx_pending);
 
 			pframe_queue = &ptxservq->sta_pending;
 
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index c1dac6eec59f..11eadefc7225 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -1262,14 +1262,9 @@ void rtw_cfg80211_surveydone_event_callback(struct adapter *padapter)
 	spin_lock_bh(&(pmlmepriv->scanned_queue.lock));
 
 	phead = get_list_head(queue);
-	plist = get_next(phead);
-
-	while (1)
+	list_for_each(plist, phead)
 	{
-		if (phead == plist)
-			break;
-
-		pnetwork = container_of(plist, struct wlan_network, list);
+		pnetwork = list_entry(plist, struct wlan_network, list);
 
 		/* report network only if the current channel set contains the channel to which this network belongs */
 		if (rtw_ch_set_search_ch(padapter->mlmeextpriv.channel_set, pnetwork->network.Configuration.DSConfig) >= 0
@@ -1281,8 +1276,6 @@ void rtw_cfg80211_surveydone_event_callback(struct adapter *padapter)
 			rtw_cfg80211_inform_bss(padapter, pnetwork);
 		}
 
-		plist = get_next(plist);
-
 	}
 
 	spin_unlock_bh(&(pmlmepriv->scanned_queue.lock));
@@ -2486,13 +2479,9 @@ static int cfg80211_rtw_del_station(struct wiphy *wiphy, struct net_device *ndev
 	spin_lock_bh(&pstapriv->asoc_list_lock);
 
 	phead = &pstapriv->asoc_list;
-	plist = get_next(phead);
-
 	/* check asoc_queue */
-	while (phead != plist) {
-		psta = container_of(plist, struct sta_info, asoc_list);
-
-		plist = get_next(plist);
+	list_for_each(plist, phead) {
+		psta = list_entry(plist, struct sta_info, asoc_list);
 
 		if (!memcmp((u8 *)mac, psta->hwaddr, ETH_ALEN)) {
 			if (psta->dot8021xalg != 1 || psta->bpairwise_key_installed) {
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index e98e5388d5c7..23765b2f6177 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -1052,15 +1052,9 @@ static int rtw_wx_set_wap(struct net_device *dev,
 	authmode = padapter->securitypriv.ndisauthtype;
 	spin_lock_bh(&queue->lock);
 	phead = get_list_head(queue);
-	pmlmepriv->pscanned = get_next(phead);
-
-	while (1) {
-		if (phead == pmlmepriv->pscanned)
-			break;
-
-		pnetwork = container_of(pmlmepriv->pscanned, struct wlan_network, list);
-
-		pmlmepriv->pscanned = get_next(pmlmepriv->pscanned);
+	list_for_each(pmlmepriv->pscanned, phead) {
+		pnetwork = list_entry(pmlmepriv->pscanned,
+				      struct wlan_network, list);
 
 		dst_bssid = pnetwork->network.MacAddress;
 
@@ -1299,18 +1293,13 @@ static int rtw_wx_get_scan(struct net_device *dev, struct iw_request_info *a,
 	spin_lock_bh(&(pmlmepriv->scanned_queue.lock));
 
 	phead = get_list_head(queue);
-	plist = get_next(phead);
-
-	while (1) {
-		if (phead == plist)
-			break;
-
+	list_for_each(plist, phead) {
 		if ((stop - ev) < SCAN_ITEM_SIZE) {
 			ret = -E2BIG;
 			break;
 		}
 
-		pnetwork = container_of(plist, struct wlan_network, list);
+		pnetwork = list_entry(plist, struct wlan_network, list);
 
 		/* report network only if the current channel set contains the channel to which this network belongs */
 		if (rtw_ch_set_search_ch(padapter->mlmeextpriv.channel_set, pnetwork->network.Configuration.DSConfig) >= 0
@@ -1320,8 +1309,6 @@ static int rtw_wx_get_scan(struct net_device *dev, struct iw_request_info *a,
 			ev = translate_scan(padapter, a, pnetwork, ev, stop);
 		}
 
-		plist = get_next(plist);
-
 	}
 
 	spin_unlock_bh(&(pmlmepriv->scanned_queue.lock));
@@ -1387,15 +1374,9 @@ static int rtw_wx_set_essid(struct net_device *dev,
 
 		spin_lock_bh(&queue->lock);
 		phead = get_list_head(queue);
-		pmlmepriv->pscanned = get_next(phead);
-
-		while (1) {
-			if (phead == pmlmepriv->pscanned)
-				break;
-
-			pnetwork = container_of(pmlmepriv->pscanned, struct wlan_network, list);
-
-			pmlmepriv->pscanned = get_next(pmlmepriv->pscanned);
+		list_for_each(pmlmepriv->pscanned, phead) {
+			pnetwork = list_entry(pmlmepriv->pscanned,
+					      struct wlan_network, list);
 
 			dst_ssid = pnetwork->network.Ssid.Ssid;
 
@@ -2252,14 +2233,8 @@ static int rtw_get_ap_info(struct net_device *dev,
 	spin_lock_bh(&(pmlmepriv->scanned_queue.lock));
 
 	phead = get_list_head(queue);
-	plist = get_next(phead);
-
-	while (1) {
-		if (phead == plist)
-			break;
-
-
-		pnetwork = container_of(plist, struct wlan_network, list);
+	list_for_each(plist, phead) {
+		pnetwork = list_entry(plist, struct wlan_network, list);
 
 		if (!mac_pton(data, bssid)) {
 			spin_unlock_bh(&(pmlmepriv->scanned_queue.lock));
@@ -2282,8 +2257,6 @@ static int rtw_get_ap_info(struct net_device *dev,
 			}
 		}
 
-		plist = get_next(plist);
-
 	}
 
 	spin_unlock_bh(&(pmlmepriv->scanned_queue.lock));
diff --git a/drivers/staging/rtl8723bs/os_dep/xmit_linux.c b/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
index 639408eaf4df..29b579dbf1f3 100644
--- a/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
@@ -139,13 +139,11 @@ static int rtw_mlcst2unicst(struct adapter *padapter, struct sk_buff *skb)
 
 	spin_lock_bh(&pstapriv->asoc_list_lock);
 	phead = &pstapriv->asoc_list;
-	plist = get_next(phead);
-
 	/* free sta asoc_queue */
-	while (phead != plist) {
+	list_for_each(plist, phead) {
 		int stainfo_offset;
-		psta = container_of(plist, struct sta_info, asoc_list);
-		plist = get_next(plist);
+
+		psta = list_entry(plist, struct sta_info, asoc_list);
 
 		stainfo_offset = rtw_stainfo_offset(pstapriv, psta);
 		if (stainfo_offset_valid(stainfo_offset)) {
-- 
2.17.1

