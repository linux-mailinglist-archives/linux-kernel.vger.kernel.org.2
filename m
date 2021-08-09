Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F31D3E4A4B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 18:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234072AbhHIQvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 12:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbhHIQvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 12:51:18 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE2BC0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 09:50:57 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id l11-20020a7bcf0b0000b0290253545c2997so467567wmg.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 09:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uswxeYf6f1/DwUZZCO5hllYNFSqX0bnCw6vEoqvvI1o=;
        b=FDT5ZFhLNcGRTVnV05gh0+omGitXfllXXfYcuz0QNpMCowMEMY+WiwYVNxuNNuQBPg
         OkwPUs5pvUErpii23pdY3L0r+jLWm0OxReVxoKJ+cApiZpA7cmW5MNCjcTGG8ovGG1Sz
         kyRXXzvjV3KFB8kspC2S+ajnHCRmwGtpIut0X8AIuKPPSfHghBrSfgSyvlzJIJIhV2N4
         BaVEUdk9abrn7FhnCA8JWYSiVjHbg5xS7hUtXCOefxGr84ImkC1g1xlP0rV6Jfa80iQu
         iZLwVHsTCUUOGuMEwfW1OgdOTTVVeDck7xo6R7wXzn8DGheyqWUAh2a8DLCRhn4vKiuJ
         h1Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uswxeYf6f1/DwUZZCO5hllYNFSqX0bnCw6vEoqvvI1o=;
        b=OCbwXyDaFeW6JMlEpTgMQb0FPFjNTyT7aDw/iEM+EwWg0TQiNXHNFkp4QKAu3KZaR9
         0/CTCjI9p1WQLV5XYD+K/i0SUss4iZltZATQSkTEaeAp2eDZPrpSFuoyXLu8GqNA99u/
         FZQUsBEM5LBlfwlrjgD8Sg6h/J4EechpRqxQ8Vbh2ytkF1msIqxH6p+K8YrNtPxheA5p
         jpDW1NgweM2L3CqEQhL6dQm0rnx23Tt2FaDqOEPoxS1cU/OGM20zUUYgiwkT3LynQA3n
         aa9ChJLU4CxnABTpVEozxoJ65CLSj6V89MEU6VDI1nJTnaP3B4Vw9a3defUjQRVmdOpT
         8MUA==
X-Gm-Message-State: AOAM531FxkFEYkooKMdE0lFaQ5JjptZ/Wzl5PWBzZjUduVJ+vXDGZrDC
        JuwJDw62UdKmR5Y/hFWuWvg=
X-Google-Smtp-Source: ABdhPJxXMGxoEHpn+5h+aitTIMoBPUkK2e6X+T4unaVpaW5DWO4w2ZrKzYGlRKXlbbqm92yuinvrdQ==
X-Received: by 2002:a05:600c:896:: with SMTP id l22mr83868wmp.68.1628527855964;
        Mon, 09 Aug 2021 09:50:55 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::996b])
        by smtp.gmail.com with ESMTPSA id q5sm20484469wrx.33.2021.08.09.09.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 09:50:55 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 12/17] staging: r8188eu: remove unnecessary parentheses in core/rtw_recv.c
Date:   Mon,  9 Aug 2021 18:50:02 +0200
Message-Id: <20210809165007.23204-13-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210809165007.23204-1-straube.linux@gmail.com>
References: <20210809165007.23204-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary parentheses in core/rtw_recv.c reported by
checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_recv.c | 26 ++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 3f5a7282c857..08aea680312c 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -70,9 +70,9 @@ int _rtw_init_recv_priv(struct recv_priv *precvpriv, struct adapter *padapter)
 	precvframe = (struct recv_frame *)precvpriv->precv_frame_buf;
 
 	for (i = 0; i < NR_RECVFRAME; i++) {
-		INIT_LIST_HEAD(&(precvframe->list));
+		INIT_LIST_HEAD(&precvframe->list);
 
-		list_add_tail(&(precvframe->list), &(precvpriv->free_recv_queue.queue));
+		list_add_tail(&precvframe->list, &precvpriv->free_recv_queue.queue);
 
 		res = rtw_os_recv_resource_alloc(padapter, precvframe);
 
@@ -174,11 +174,11 @@ int rtw_free_recvframe(struct recv_frame *precvframe, struct __queue *pfree_recv
 
 	spin_lock_bh(&pfree_recv_queue->lock);
 
-	list_del_init(&(precvframe->list));
+	list_del_init(&precvframe->list);
 
 	precvframe->len = 0;
 
-	list_add_tail(&(precvframe->list), get_list_head(pfree_recv_queue));
+	list_add_tail(&precvframe->list, get_list_head(pfree_recv_queue));
 
 	if (padapter) {
 		if (pfree_recv_queue == &precvpriv->free_recv_queue)
@@ -195,8 +195,8 @@ int _rtw_enqueue_recvframe(struct recv_frame *precvframe, struct __queue *queue)
 	struct adapter *padapter = precvframe->adapter;
 	struct recv_priv *precvpriv = &padapter->recvpriv;
 
-	list_del_init(&(precvframe->list));
-	list_add_tail(&(precvframe->list), get_list_head(queue));
+	list_del_init(&precvframe->list);
+	list_add_tail(&precvframe->list, get_list_head(queue));
 
 	if (padapter) {
 		if (queue == &precvpriv->free_recv_queue)
@@ -323,7 +323,7 @@ static int recvframe_chkmic(struct adapter *adapter,  struct recv_frame *precvfr
 	struct	security_priv	*psecuritypriv = &adapter->securitypriv;
 
 	struct mlme_ext_priv	*pmlmeext = &adapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 
 	stainfo = rtw_get_stainfo(&adapter->stapriv, &prxattrib->ta[0]);
 
@@ -1338,7 +1338,7 @@ static struct recv_frame *recvframe_defrag(struct adapter *adapter, struct __que
 	plist = phead->next;
 	pfhdr = container_of(plist, struct recv_frame, list);
 	prframe = (struct recv_frame *)pfhdr;
-	list_del_init(&(prframe->list));
+	list_del_init(&prframe->list);
 
 	if (curfragnum != pfhdr->attrib.frag_num) {
 		/* the first fragment number must be 0 */
@@ -1355,7 +1355,7 @@ static struct recv_frame *recvframe_defrag(struct adapter *adapter, struct __que
 	plist = phead->next;
 	pfhdr = container_of(plist, struct recv_frame, list);
 	prframe = (struct recv_frame *)pfhdr;
-	list_del_init(&(prframe->list));
+	list_del_init(&prframe->list);
 
 	plist = plist->next;
 
@@ -1506,7 +1506,7 @@ static int amsdu_to_msdu(struct adapter *padapter, struct recv_frame *prframe)
 	unsigned char *data_ptr;
 	struct sk_buff *sub_skb, *subframes[MAX_SUBFRAME_COUNT];
 	struct recv_priv *precvpriv = &padapter->recvpriv;
-	struct __queue *pfree_recv_queue = &(precvpriv->free_recv_queue);
+	struct __queue *pfree_recv_queue = &precvpriv->free_recv_queue;
 	int	ret = _SUCCESS;
 	nr_subframes = 0;
 
@@ -1668,9 +1668,9 @@ int enqueue_reorder_recvframe(struct recv_reorder_ctrl *preorder_ctrl, struct re
 			break;
 	}
 
-	list_del_init(&(prframe->list));
+	list_del_init(&prframe->list);
 
-	list_add_tail(&(prframe->list), plist);
+	list_add_tail(&prframe->list, plist);
 	return true;
 }
 
@@ -1704,7 +1704,7 @@ static int recv_indicatepkts_in_order(struct adapter *padapter, struct recv_reor
 
 		if (!SN_LESS(preorder_ctrl->indicate_seq, pattrib->seq_num)) {
 			plist = plist->next;
-			list_del_init(&(prframe->list));
+			list_del_init(&prframe->list);
 
 			if (SN_EQUAL(preorder_ctrl->indicate_seq, pattrib->seq_num))
 				preorder_ctrl->indicate_seq = (preorder_ctrl->indicate_seq + 1) & 0xFFF;
-- 
2.32.0

