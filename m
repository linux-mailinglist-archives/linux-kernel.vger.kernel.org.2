Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9089B3E34AA
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 12:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbhHGKOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 06:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbhHGKMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 06:12:50 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDA5C0617A3
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 03:12:17 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id y12so16835197edo.6
        for <linux-kernel@vger.kernel.org>; Sat, 07 Aug 2021 03:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uswxeYf6f1/DwUZZCO5hllYNFSqX0bnCw6vEoqvvI1o=;
        b=s99EeJoFBqtY/iQ8Zxyj8nYrClnMCS/BS1PFt+cboAaphWP5RbTjJCQ4bohZ9FMQkx
         UCznaIzHNftsfKtf3WfY5yQTWFn9EQ9/yBBzFECq9GPXUX5aQ6ruzjrURqhhJVf8tlP2
         XEqsxxay+Y2+AynpyVc1HTAt3wClW54rfKlO0tLGjHsa7Z2Xr4svDDgGs+BriYpK+cQT
         7bNkLRkawktvc1Ol/e9ZTpIB8UW1JuxIkx3GGjQ3Ljh6Mrz8hwsqmMTqryv2Nx20oqJY
         kvDYASaZxJxOvO+8ljqqYpxVtlRCc2R11ZDuHWtcqbfPUUmmj+VAF8Rny7qwxswvjo9O
         dfOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uswxeYf6f1/DwUZZCO5hllYNFSqX0bnCw6vEoqvvI1o=;
        b=CqxSJRn0Cj4H5h44uv+4WLVufcanpXnRKuf41jn0M/urNvxWiWx3aKz2JhB5QcFICN
         i6uY6clcdNolg0eOFbSA4QswF0A25G8751zI0jdT5rD+J3xRADWW+3cBE2l3nQaJwz7A
         gvLWaZnz57StStxad/GRHr3CeHH0VA2s/CJjDk1zgxq4dBIQCF9iZ0ZoS62D9TSuvDlo
         t50xEz7e/d0HI76S3HaOeYYu3DXNG+J15Fd+NdLf6C3WKVqzc9pKcghdZQ4jy7XFdhvm
         Il1m65ezioJrt/f9lOkMiY4JQ9mJXfQvzSRMBtZ9P4IuuN6WViRpkkFDskT6hv9WAIgw
         sCgA==
X-Gm-Message-State: AOAM5328dwl1bhe5MgmUHLGrBNKDRALVfrxEuEGsOEi+E+0c7O3OyAGF
        SrC1wDcjtKjKP/RAEwsN391NckYSv/A=
X-Google-Smtp-Source: ABdhPJynqORWDCDweoaPwSHW8SDJ80vQRTEF20cpTNe7bln6XcTsURS7QVtqInOZ/UoOOCmoEL2l9w==
X-Received: by 2002:a05:6402:28a0:: with SMTP id eg32mr17729065edb.203.1628331136143;
        Sat, 07 Aug 2021 03:12:16 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::a83e])
        by smtp.gmail.com with ESMTPSA id u4sm3662514eje.81.2021.08.07.03.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 03:12:15 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 12/17] staging: r8188eu: remove unnecessary parentheses in core/rtw_recv.c
Date:   Sat,  7 Aug 2021 12:11:14 +0200
Message-Id: <20210807101119.16085-13-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210807101119.16085-1-straube.linux@gmail.com>
References: <20210807101119.16085-1-straube.linux@gmail.com>
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

