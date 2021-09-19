Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A62C6410C2F
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 17:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233562AbhISPjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 11:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233114AbhISPjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 11:39:07 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8233BC061757
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 08:37:41 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 192-20020a1c04c9000000b002f7a4ab0a49so10060201wme.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 08:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=obXtMIsM4RLVNn+oolK2BieCbKGQIPwqNDhNAdWDJk8=;
        b=e39LHPi3Im3dmq22NWlNuYd17p/jMTwSXEM7+oeo8DiRRO3XU4ps4sSaE5XgDOPPUA
         eEhLv/t448q06otsnmun642+J4kayYGoaoRKRB+SICOec4kmj1d9iqXSXQkbmB/FpsFe
         axxop60O/B+IBRRM4RRfljSaqmRV0qpXsI6yFQH3qlksWcXymgUjPLq+WJ3pbNog9DHQ
         ofYmbrSXP0ZCqU2lO5UjYEUU13VYKiG+BHYdK4puHE90UNrW5PyYvC4oT+q9EozPkxLj
         f19Im1ifaBTD8A6LOt0wuJ2J69KdM9np8blmquGCtxN0HEoqcPUSWx1igpa9zrh4cjxI
         znGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=obXtMIsM4RLVNn+oolK2BieCbKGQIPwqNDhNAdWDJk8=;
        b=DBzFfdi3hd9VPRDdq+oNasShs7kgWVnU6kOZqU3SQe6q3dBU7TKJ0E9QVfJWQvDRWc
         fFm8Y5JqsJcuFT48qUcJYMcnmFrgT/7ldus4dZAheFkrwXRMCszCS6xmC5AGvMfArQz6
         y73E/9TjP8PmTY4wCruKEgLHgiDhBFo6kSCD7NhlG8jsF0OAvNvH4fNgi2gmUNQ7Wpsj
         ea7TEsSQuiVxnqtdxxlY9OSFY+duaqNaHc0Mt8H0xb9DFbGikprmER8+iZb3bQG1mHU6
         0EKYxC4QadceDk6kd3vYfsw84/MnuxXKQWYreKhNY7T04iPh+noDfaTEk8GoDU1tCVJt
         hUjw==
X-Gm-Message-State: AOAM533Ja3zXTAtxTPIqSAfilxRjzj7g/qTB1A85e3ioYOk7BT2RRI/w
        +reKRPeeKEeNNtVhykotdxI=
X-Google-Smtp-Source: ABdhPJyVlyfrNVi160xf0P3U5hkwFspD3/O5ZHzx0jBkjNN06wgSWdd7aCv9Hg4KRUguun6f0Lqe5g==
X-Received: by 2002:a1c:2785:: with SMTP id n127mr12003818wmn.155.1632065860159;
        Sun, 19 Sep 2021 08:37:40 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cde])
        by smtp.gmail.com with ESMTPSA id l15sm16614501wme.42.2021.09.19.08.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 08:37:39 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/6] staging: r8188eu: remove rtw_acl_remove_sta()
Date:   Sun, 19 Sep 2021 17:36:56 +0200
Message-Id: <20210919153659.20826-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210919153659.20826-1-straube.linux@gmail.com>
References: <20210919153659.20826-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function rtw_acl_remove_sta() is not used, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ap.c    | 37 ------------------------
 drivers/staging/r8188eu/include/rtw_ap.h |  1 -
 2 files changed, 38 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ap.c b/drivers/staging/r8188eu/core/rtw_ap.c
index 60ef8092c40b..fff957fcaf40 100644
--- a/drivers/staging/r8188eu/core/rtw_ap.c
+++ b/drivers/staging/r8188eu/core/rtw_ap.c
@@ -995,43 +995,6 @@ void rtw_set_macaddr_acl(struct adapter *padapter, int mode)
 	pacl_list->mode = mode;
 }
 
-int rtw_acl_remove_sta(struct adapter *padapter, u8 *addr)
-{
-	struct list_head *plist, *phead;
-	int ret = 0;
-	struct rtw_wlan_acl_node *paclnode;
-	struct sta_priv *pstapriv = &padapter->stapriv;
-	struct wlan_acl_pool *pacl_list = &pstapriv->acl_list;
-	struct __queue *pacl_node_q = &pacl_list->acl_node_q;
-
-	DBG_88E("%s(acl_num =%d) =%pM\n", __func__, pacl_list->num, (addr));
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
-				paclnode->valid = false;
-
-				list_del_init(&paclnode->list);
-
-				pacl_list->num--;
-			}
-		}
-	}
-
-	spin_unlock_bh(&pacl_node_q->lock);
-
-	DBG_88E("%s, acl_num =%d\n", __func__, pacl_list->num);
-	return ret;
-}
-
 static void update_bcn_fixed_ie(struct adapter *padapter)
 {
 	DBG_88E("%s\n", __func__);
diff --git a/drivers/staging/r8188eu/include/rtw_ap.h b/drivers/staging/r8188eu/include/rtw_ap.h
index d0d1f3834bd6..4055d908c309 100644
--- a/drivers/staging/r8188eu/include/rtw_ap.h
+++ b/drivers/staging/r8188eu/include/rtw_ap.h
@@ -23,7 +23,6 @@ void update_sta_info_apmode(struct adapter *padapter, struct sta_info *psta);
 int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len);
 void rtw_ap_restore_network(struct adapter *padapter);
 void rtw_set_macaddr_acl(struct adapter *padapter, int mode);
-int rtw_acl_remove_sta(struct adapter *padapter, u8 *addr);
 
 void associated_clients_update(struct adapter *padapter, u8 updated);
 void bss_cap_update_on_sta_join(struct adapter *padapter, struct sta_info *psta);
-- 
2.33.0

