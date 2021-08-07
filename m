Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C59B03E34B3
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 12:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbhHGKPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 06:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbhHGKMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 06:12:49 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8123C0617A2
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 03:12:16 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id k9so16824212edr.10
        for <linux-kernel@vger.kernel.org>; Sat, 07 Aug 2021 03:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vbN/79mS5cORZWWvLgOUVIMx3cPKWDGgv+719frs6/c=;
        b=e6+G0d/bYozh/cvCadNjfCsMNmcZ1d4pyA3JuSq+bji74MKNO3Csm+2uAv9q1104Mw
         ttJ9hRxZME+BuVHBZ2XddLP9GrncD+FrpoEo2sXzdbdLw6MBjY0jiMMh5tHdHfvtLIFs
         5KbYkcRGBbfEA/Lybcp82Pl/I8DxvGh9+hWlW+lV6CW54pH/GL0NNS5gHmuFxnwxf97d
         5mKcEsvGCb3MvqQEUjf29tRyOfjX210w8QkBputsdp6vdwqW1lPsCPPD1+ReIUTDX/zi
         qezOQnwYSWjrMFZqGITkjf/lp9NvczjjXzo8KP2ip8mGhwfB7raSn5pirem3ORhi3L48
         mcSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vbN/79mS5cORZWWvLgOUVIMx3cPKWDGgv+719frs6/c=;
        b=Ow+oyVB4o/aAUfRRgbOcegThSsUaUmOfAH6Mrqng62edW4QdHeidZkslQfXUuHYv2f
         2cJOLrAmWUpr1DVjQZ0De5vdhQ/DE+ARe7WGiTuUpYoLdFpP7QWjloaKKptaXwQSw2WE
         vQjJdC7RMgoMsU02Nz87ZRhyMvTYN3J0VglNNMkIqqYdbK9wxxr4hq3XSLLO3eiudBqB
         DYo7q52/cDcRGxA3+Yu8d+9sOtU1oZIrsvumMbW4+xXeOb3FCk8xn4ROQBHOUch43vPg
         AwQDnm04oTrjlRnpCvkwjov7Jcjz3GH1kiOEG2tAOUccux+uutVg+EltFfcPZnZPvH/m
         7a7g==
X-Gm-Message-State: AOAM531fUds+IW2svzYjsuzNBuVnBKNBeuugOJdzuhVcI8caDD75LgHC
        PBHv1R1fHFlKaryIe3nJJnUxPTBlvkg=
X-Google-Smtp-Source: ABdhPJwBFqiQT7P8vuqGTLzq8BdXJJeherbKl6STNBruwExt6xTO9F83wMFwWU4A+oURGs5Vm/XiwA==
X-Received: by 2002:aa7:cb19:: with SMTP id s25mr18573520edt.194.1628331135382;
        Sat, 07 Aug 2021 03:12:15 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::a83e])
        by smtp.gmail.com with ESMTPSA id u4sm3662514eje.81.2021.08.07.03.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 03:12:15 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 11/17] staging: r8188eu: remove unnecessary parentheses in core/rtw_sta_mgt.c
Date:   Sat,  7 Aug 2021 12:11:13 +0200
Message-Id: <20210807101119.16085-12-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210807101119.16085-1-straube.linux@gmail.com>
References: <20210807101119.16085-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary parentheses in core/rtw_sta_mgt.c reported by
checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_sta_mgt.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_sta_mgt.c b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
index 3e8e85756f25..c9644a3ecc4e 100644
--- a/drivers/staging/r8188eu/core/rtw_sta_mgt.c
+++ b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
@@ -81,7 +81,7 @@ u32	_rtw_init_sta_priv(struct	sta_priv *pstapriv)
 	for (i = 0; i < NUM_STA; i++) {
 		_rtw_init_stainfo(psta);
 
-		INIT_LIST_HEAD(&(pstapriv->sta_hash[i]));
+		INIT_LIST_HEAD(&pstapriv->sta_hash[i]);
 
 		list_add_tail(&psta->list, get_list_head(&pstapriv->free_sta_queue));
 
@@ -145,7 +145,7 @@ u32	_rtw_free_sta_priv(struct	sta_priv *pstapriv)
 		/*	delete all reordering_ctrl_timer		*/
 		spin_lock_bh(&pstapriv->sta_hash_lock);
 		for (index = 0; index < NUM_STA; index++) {
-			phead = &(pstapriv->sta_hash[index]);
+			phead = &pstapriv->sta_hash[index];
 			plist = phead->next;
 
 			while (phead != plist) {
@@ -190,7 +190,7 @@ struct	sta_info *rtw_alloc_stainfo(struct sta_priv *pstapriv, u8 *hwaddr)
 		psta = NULL;
 	} else {
 		psta = container_of((&pfree_sta_queue->queue)->next, struct sta_info, list);
-		list_del_init(&(psta->list));
+		list_del_init(&psta->list);
 		spin_unlock_bh(&pfree_sta_queue->lock);
 		_rtw_init_stainfo(psta);
 		memcpy(psta->hwaddr, hwaddr, ETH_ALEN);
@@ -199,7 +199,7 @@ struct	sta_info *rtw_alloc_stainfo(struct sta_priv *pstapriv, u8 *hwaddr)
 			psta = NULL;
 			goto exit;
 		}
-		phash_list = &(pstapriv->sta_hash[index]);
+		phash_list = &pstapriv->sta_hash[index];
 
 		spin_lock_bh(&pstapriv->sta_hash_lock);
 
@@ -273,19 +273,19 @@ u32	rtw_free_stainfo(struct adapter *padapter, struct sta_info *psta)
 
 	rtw_free_xmitframe_queue(pxmitpriv, &pstaxmitpriv->vo_q.sta_pending);
 
-	list_del_init(&(pstaxmitpriv->vo_q.tx_pending));
+	list_del_init(&pstaxmitpriv->vo_q.tx_pending);
 
 	rtw_free_xmitframe_queue(pxmitpriv, &pstaxmitpriv->vi_q.sta_pending);
 
-	list_del_init(&(pstaxmitpriv->vi_q.tx_pending));
+	list_del_init(&pstaxmitpriv->vi_q.tx_pending);
 
 	rtw_free_xmitframe_queue(pxmitpriv, &pstaxmitpriv->bk_q.sta_pending);
 
-	list_del_init(&(pstaxmitpriv->bk_q.tx_pending));
+	list_del_init(&pstaxmitpriv->bk_q.tx_pending);
 
 	rtw_free_xmitframe_queue(pxmitpriv, &pstaxmitpriv->be_q.sta_pending);
 
-	list_del_init(&(pstaxmitpriv->be_q.tx_pending));
+	list_del_init(&pstaxmitpriv->be_q.tx_pending);
 
 	spin_unlock_bh(&pxmitpriv->lock);
 
@@ -321,7 +321,7 @@ u32	rtw_free_stainfo(struct adapter *padapter, struct sta_info *psta)
 
 			plist = plist->next;
 
-			list_del_init(&(prframe->list));
+			list_del_init(&prframe->list);
 
 			rtw_free_recvframe(prframe, pfree_recv_queue);
 		}
@@ -389,7 +389,7 @@ void rtw_free_all_stainfo(struct adapter *padapter)
 	spin_lock_bh(&pstapriv->sta_hash_lock);
 
 	for (index = 0; index < NUM_STA; index++) {
-		phead = &(pstapriv->sta_hash[index]);
+		phead = &pstapriv->sta_hash[index];
 		plist = phead->next;
 
 		while (phead != plist) {
@@ -425,7 +425,7 @@ struct sta_info *rtw_get_stainfo(struct sta_priv *pstapriv, u8 *hwaddr)
 
 	spin_lock_bh(&pstapriv->sta_hash_lock);
 
-	phead = &(pstapriv->sta_hash[index]);
+	phead = &pstapriv->sta_hash[index];
 	plist = phead->next;
 
 	while (phead != plist) {
-- 
2.32.0

