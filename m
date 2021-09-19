Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEFA5410C30
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 17:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233658AbhISPjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 11:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233442AbhISPjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 11:39:06 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE97C061574
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 08:37:40 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id z2so2123720wmc.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 08:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w3kxpS1URn8OPwxyX4KDQ1NP2wd56BIFhiZc9SE8W3Q=;
        b=m2j+ort94V3aMDCKDO64QQwuPD5oO8Tnz+hVsfMRsR1OzNsNYiXnEiUxoVJk047lZb
         fKkuX44nNEhDSFk9FXqJceIYvIQh6IVQkMWi+e+WlJ6vSXXVxqqzrRFn2O4HSGyTcQLj
         OWGt3ODGki6urMZ96xsQtAXh6IYm5qzLbBHaRSD5WaH1YrcUDB1Gglo7yNAzsrpxkp4K
         mjXc8acQ8IKWxnh9YGDtCVzRT5FmdEJ0UKW9LfYPT3vubnMew9unPwTXIIS6H2QHz4wl
         5CJpUFSOW91LNUxGea2Nfc30YokakQGEKfFf+znRv5MsDGZQE3qeIgRcPembjnD8Z+YO
         MGnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w3kxpS1URn8OPwxyX4KDQ1NP2wd56BIFhiZc9SE8W3Q=;
        b=0zkpt4cXzBH4ggmA2QldxpkjVveULgPeravXwT1erC5qgw1l+iSaMnyJbyf338ixxH
         23KxKYdBYTS1jTxp54Dl1Q6j73ZstI77UAFsATyXP4kjzvQ2RklxZPBiATGGZk9IyUiv
         M45C/FC7xcANQydG03JxDzbsE23/frbnZO9/x1sq+JfoVEoOJ1pzMHng+zIwJm56taxy
         6K9kih6E3f9RZv/ZyTUFzG2+CaV3ra/fo77B/zaSc63TBIuswO7KmycGBTT/3IyLr4Hv
         +dtRMIFbWR5Db+aFdw0z7xbaaMjJZ0msGa8nCBVdmzAsvrgM90iXxC/OP3a51rGwuarM
         AIDg==
X-Gm-Message-State: AOAM533+imIPhAR0VGCAZFJp5bNBUA9uJiv1/7rH8jJr6orkgyyBK6Ar
        /tHbAMVWTd0JK6dNxth4Y3w=
X-Google-Smtp-Source: ABdhPJwDJYRhdlkYgLpZAuf3kZiBiyPCN2sHq9cBRaouKkh3X6kxQS/NAJAeVL+tcNng1m6udJLPtw==
X-Received: by 2002:a05:600c:3b89:: with SMTP id n9mr25160659wms.186.1632065859271;
        Sun, 19 Sep 2021 08:37:39 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cde])
        by smtp.gmail.com with ESMTPSA id l15sm16614501wme.42.2021.09.19.08.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 08:37:38 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/6] staging: r8188eu: remove rtw_acl_add_sta()
Date:   Sun, 19 Sep 2021 17:36:55 +0200
Message-Id: <20210919153659.20826-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210919153659.20826-1-straube.linux@gmail.com>
References: <20210919153659.20826-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function rtw_acl_add_sta() is not used, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ap.c    | 65 ------------------------
 drivers/staging/r8188eu/include/rtw_ap.h |  1 -
 2 files changed, 66 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ap.c b/drivers/staging/r8188eu/core/rtw_ap.c
index 49d65d5b3bac..60ef8092c40b 100644
--- a/drivers/staging/r8188eu/core/rtw_ap.c
+++ b/drivers/staging/r8188eu/core/rtw_ap.c
@@ -995,71 +995,6 @@ void rtw_set_macaddr_acl(struct adapter *padapter, int mode)
 	pacl_list->mode = mode;
 }
 
-int rtw_acl_add_sta(struct adapter *padapter, u8 *addr)
-{
-	struct list_head *plist, *phead;
-	u8 added = false;
-	int i, ret = 0;
-	struct rtw_wlan_acl_node *paclnode;
-	struct sta_priv *pstapriv = &padapter->stapriv;
-	struct wlan_acl_pool *pacl_list = &pstapriv->acl_list;
-	struct __queue *pacl_node_q = &pacl_list->acl_node_q;
-
-	DBG_88E("%s(acl_num =%d) =%pM\n", __func__, pacl_list->num, (addr));
-
-	if ((NUM_ACL - 1) < pacl_list->num)
-		return -1;
-
-	spin_lock_bh(&pacl_node_q->lock);
-
-	phead = get_list_head(pacl_node_q);
-	plist = phead->next;
-
-	while (phead != plist) {
-		paclnode = container_of(plist, struct rtw_wlan_acl_node, list);
-		plist = plist->next;
-
-		if (!memcmp(paclnode->addr, addr, ETH_ALEN)) {
-			if (paclnode->valid) {
-				added = true;
-				DBG_88E("%s, sta has been added\n", __func__);
-				break;
-			}
-		}
-	}
-
-	spin_unlock_bh(&pacl_node_q->lock);
-
-	if (added)
-		return ret;
-
-	spin_lock_bh(&pacl_node_q->lock);
-
-	for (i = 0; i < NUM_ACL; i++) {
-		paclnode = &pacl_list->aclnode[i];
-
-		if (!paclnode->valid) {
-			INIT_LIST_HEAD(&paclnode->list);
-
-			memcpy(paclnode->addr, addr, ETH_ALEN);
-
-			paclnode->valid = true;
-
-			list_add_tail(&paclnode->list, get_list_head(pacl_node_q));
-
-			pacl_list->num++;
-
-			break;
-		}
-	}
-
-	DBG_88E("%s, acl_num =%d\n", __func__, pacl_list->num);
-
-	spin_unlock_bh(&pacl_node_q->lock);
-
-	return ret;
-}
-
 int rtw_acl_remove_sta(struct adapter *padapter, u8 *addr)
 {
 	struct list_head *plist, *phead;
diff --git a/drivers/staging/r8188eu/include/rtw_ap.h b/drivers/staging/r8188eu/include/rtw_ap.h
index 11e6f799d577..d0d1f3834bd6 100644
--- a/drivers/staging/r8188eu/include/rtw_ap.h
+++ b/drivers/staging/r8188eu/include/rtw_ap.h
@@ -23,7 +23,6 @@ void update_sta_info_apmode(struct adapter *padapter, struct sta_info *psta);
 int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len);
 void rtw_ap_restore_network(struct adapter *padapter);
 void rtw_set_macaddr_acl(struct adapter *padapter, int mode);
-int rtw_acl_add_sta(struct adapter *padapter, u8 *addr);
 int rtw_acl_remove_sta(struct adapter *padapter, u8 *addr);
 
 void associated_clients_update(struct adapter *padapter, u8 updated);
-- 
2.33.0

