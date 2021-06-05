Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7500739C9FF
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 18:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhFERBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 13:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbhFERBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 13:01:16 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C498FC061766;
        Sat,  5 Jun 2021 09:59:27 -0700 (PDT)
Received: from dslb-188-096-145-192.188.096.pools.vodafone-ip.de ([188.96.145.192] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1lpZdr-0002hw-UQ; Sat, 05 Jun 2021 18:59:24 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 4/9] staging: rtl8188eu: make rtw_free_recvframe return void
Date:   Sat,  5 Jun 2021 18:58:53 +0200
Message-Id: <20210605165858.3175-4-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210605165858.3175-1-martin@kaiser.cx>
References: <20210605165858.3175-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

None of the callers checks the return value of rtw_free_recvframe.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/rtl8188eu/core/rtw_recv.c    | 8 +++-----
 drivers/staging/rtl8188eu/include/rtw_recv.h | 3 +--
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_recv.c b/drivers/staging/rtl8188eu/core/rtw_recv.c
index e79cfdd4bf90..c20141638b73 100644
--- a/drivers/staging/rtl8188eu/core/rtw_recv.c
+++ b/drivers/staging/rtl8188eu/core/rtw_recv.c
@@ -114,11 +114,11 @@ struct recv_frame *rtw_alloc_recvframe(struct __queue *pfree_recv_queue)
 	return precvframe;
 }
 
-int rtw_free_recvframe(struct recv_frame *precvframe,
-		       struct __queue *pfree_recv_queue)
+void rtw_free_recvframe(struct recv_frame *precvframe, struct __queue *pfree_recv_queue)
 {
 	if (!precvframe)
-		return _FAIL;
+		return;
+
 	if (precvframe->pkt) {
 		dev_kfree_skb_any(precvframe->pkt);/* free skb by driver */
 		precvframe->pkt = NULL;
@@ -131,8 +131,6 @@ int rtw_free_recvframe(struct recv_frame *precvframe,
 	list_add_tail(&precvframe->list, get_list_head(pfree_recv_queue));
 
 	spin_unlock_bh(&pfree_recv_queue->lock);
-
-	return _SUCCESS;
 }
 
 int _rtw_enqueue_recvframe(struct recv_frame *precvframe, struct __queue *queue)
diff --git a/drivers/staging/rtl8188eu/include/rtw_recv.h b/drivers/staging/rtl8188eu/include/rtw_recv.h
index e20bab41708a..8c906b666b62 100644
--- a/drivers/staging/rtl8188eu/include/rtw_recv.h
+++ b/drivers/staging/rtl8188eu/include/rtw_recv.h
@@ -231,8 +231,7 @@ struct recv_frame *_rtw_alloc_recvframe(struct __queue *pfree_recv_queue);
 struct recv_frame *rtw_alloc_recvframe(struct __queue *pfree_recv_queue);
 void rtw_init_recvframe(struct recv_frame *precvframe,
 			struct recv_priv *precvpriv);
-int  rtw_free_recvframe(struct recv_frame *precvframe,
-			struct __queue *pfree_recv_queue);
+void rtw_free_recvframe(struct recv_frame *precvframe, struct __queue *pfree_recv_queue);
 #define rtw_dequeue_recvframe(queue) rtw_alloc_recvframe(queue)
 int _rtw_enqueue_recvframe(struct recv_frame *precvframe,
 			   struct __queue *queue);
-- 
2.20.1

