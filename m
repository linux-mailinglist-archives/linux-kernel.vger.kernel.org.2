Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7EBF34FD2A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 11:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234920AbhCaJlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 05:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234821AbhCaJkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 05:40:31 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A3AC061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:40:29 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id l4so29068129ejc.10
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sN44X9WN09LZQNq8Yg3XRYRaWw1riUHmEayF7f44ixo=;
        b=MyvigBWIm1aOLHQOdoyoQuPQq1jSzVq9CpVfcpZRcVuWRsl1InTWBahnCSKhmZUmYv
         rjhX6Pdpq6Xxg/GtmmQWXw+f/wT+UhwUMDI/0Gk7mZ5vBfVl/J1svkeGwSFkYK0UPBwy
         5fZ2TiMHGM6kYtMhy+2kHcfoJBRvq77F4KDy0fdrvqxD4DzLVE1oomLBcGDo9IR3+Ecu
         6moQz4wpV3IzhPXtHYwqpbZhVxKV/F39kGe2WQOg4hiawXGCIJ899OGpKNgYq3dmKsgV
         WFDo3GD3V6ratXtrUMXWW172NqXgeKnQqWq+uUCa04+PjbxzLCuzs+lh79h1dVdIHBqM
         Fitg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sN44X9WN09LZQNq8Yg3XRYRaWw1riUHmEayF7f44ixo=;
        b=Sc9XfgeRgFORc8crD8JjzhMwKje8OpOPRrj3Fti2VHXIi7ex011mgRuHG+V544npN1
         3SS4NkrHQmfrPVFj+FIk7DZ0KN734tQMmG6njDiP/gW8E/zR4hr3v4fd5s1l9Ib1aapH
         im/cdkjY5oHYTvR6xWeLNIHFABFbLLjttsOdokJdAo8bw0XaOP/8n4wE1JkowAzNEpnB
         D69gOhKuBBLa7VobpUxj1gUCdPW1TbU/nXwv/JVJE5fqtQAW7p1QyeYhNOS2ucNPyB11
         0lfCnU9h4oEqEJ3hNkl4AuGtgJPbSr02Vtskd9BEWJJyJhxVdkOTetBVXpCy4asU4a7w
         BBXw==
X-Gm-Message-State: AOAM532vJdZGZl7IjqzzC68LgAMGxZFhV3hozAOiK43K+Myf1w0DJJuQ
        Ax9KXzeErhDso2Bcx2oKS58=
X-Google-Smtp-Source: ABdhPJxWRhhptdkd9Xpz4iY+F9KvTiASIwjS9u6VtMrg8vbm6YudiPfToTTOhPDBoD026TWmXGwBdw==
X-Received: by 2002:a17:906:a20c:: with SMTP id r12mr2493371ejy.554.1617183628116;
        Wed, 31 Mar 2021 02:40:28 -0700 (PDT)
Received: from agape ([5.171.73.44])
        by smtp.gmail.com with ESMTPSA id t17sm1132278edr.36.2021.03.31.02.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 02:40:27 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 09/40] staging: rtl8723bs: remove commented RT_TRACE calls in core/rtw_recv.c
Date:   Wed, 31 Mar 2021 11:39:37 +0200
Message-Id: <de4480c7fbeb96241b99c3bef5cc334ec21b8401.1617183374.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617183374.git.fabioaiuto83@gmail.com>
References: <cover.1617183374.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove commented RT_TRACE calls in core/rtw_recv.c

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_recv.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index 608a59286505..189f686a1f29 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -588,13 +588,11 @@ static union recv_frame *portctrl(struct adapter *adapter, union recv_frame *pre
 			prtnframe = precv_frame;
 			/* check is the EAPOL frame or not (Rekey) */
 			/* if (ether_type == eapol_type) { */
-			/* RT_TRACE(_module_rtl871x_recv_c_, _drv_notice_, ("########portctrl:ether_type == 0x888e\n")); */
 				/* check Rekey */
 
 			/* prtnframe =precv_frame; */
 			/*  */
 			/* else { */
-			/* RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("########portctrl:ether_type = 0x%04x\n", ether_type)); */
 			/*  */
 		}
 	} else
@@ -1693,7 +1691,6 @@ static signed int validate_recv_frame(struct adapter *adapter, union recv_frame
 		retval = validate_recv_data_frame(adapter, precv_frame);
 		if (retval == _FAIL) {
 			struct recv_priv *precvpriv = &adapter->recvpriv;
-			/* RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("validate_recv_data_frame fail\n")); */
 			precvpriv->rx_drop++;
 		} else if (retval == _SUCCESS) {
 #ifdef DBG_RX_DUMP_EAP
@@ -1889,7 +1886,6 @@ static int check_indicate_seq(struct recv_reorder_ctrl *preorder_ctrl, u16 seq_n
 
 	/*  Drop out the packet which SeqNum is smaller than WinStart */
 	if (SN_LESS(seq_num, preorder_ctrl->indicate_seq)) {
-		/* RT_TRACE(COMP_RX_REORDER, DBG_LOUD, ("CheckRxTsIndicateSeq(): Packet Drop! IndicateSeq: %d, NewSeq: %d\n", pTS->RxIndicateSeq, NewSeqNum)); */
 		/* DbgPrint("CheckRxTsIndicateSeq(): Packet Drop! IndicateSeq: %d, NewSeq: %d\n", precvpriv->indicate_seq, seq_num); */
 
 		#ifdef DBG_RX_DROP_FRAME
@@ -1914,7 +1910,6 @@ static int check_indicate_seq(struct recv_reorder_ctrl *preorder_ctrl, u16 seq_n
 			preorder_ctrl->indicate_seq, seq_num);
 		#endif
 	} else if (SN_LESS(wend, seq_num)) {
-		/* RT_TRACE(COMP_RX_REORDER, DBG_LOUD, ("CheckRxTsIndicateSeq(): Window Shift! IndicateSeq: %d, NewSeq: %d\n", pTS->RxIndicateSeq, NewSeqNum)); */
 		/* DbgPrint("CheckRxTsIndicateSeq(): Window Shift! IndicateSeq: %d, NewSeq: %d\n", precvpriv->indicate_seq, seq_num); */
 
 		/*  boundary situation, when seq_num cross 0xFFF */
@@ -1959,7 +1954,6 @@ static int enqueue_reorder_recvframe(struct recv_reorder_ctrl *preorder_ctrl, un
 			plist = get_next(plist);
 		else if (SN_EQUAL(pnextattrib->seq_num, pattrib->seq_num))
 			/* Duplicate entry is found!! Do not insert current entry. */
-			/* RT_TRACE(COMP_RX_REORDER, DBG_TRACE, ("InsertRxReorderList(): Duplicate packet is dropped!! IndicateSeq: %d, NewSeq: %d\n", pTS->RxIndicateSeq, SeqNum)); */
 			/* spin_unlock_irqrestore(&ppending_recvframe_queue->lock, irql); */
 			return false;
 		else
@@ -1980,8 +1974,6 @@ static int enqueue_reorder_recvframe(struct recv_reorder_ctrl *preorder_ctrl, un
 	/* spin_unlock(&ppending_recvframe_queue->lock); */
 	/* spin_unlock_irqrestore(&ppending_recvframe_queue->lock, irql); */
 
-
-	/* RT_TRACE(COMP_RX_REORDER, DBG_TRACE, ("InsertRxReorderList(): Pkt insert into buffer!! IndicateSeq: %d, NewSeq: %d\n", pTS->RxIndicateSeq, SeqNum)); */
 	return true;
 
 }
@@ -2437,8 +2429,6 @@ s32 rtw_recv_entry(union recv_frame *precvframe)
 	struct recv_priv *precvpriv;
 	s32 ret = _SUCCESS;
 
-	/* RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("+rtw_recv_entry\n")); */
-
 	padapter = precvframe->u.hdr.adapter;
 
 	precvpriv = &padapter->recvpriv;
@@ -2456,8 +2446,6 @@ s32 rtw_recv_entry(union recv_frame *precvframe)
 
 _recv_entry_drop:
 
-	/* RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("_recv_entry_drop\n")); */
-
 	return ret;
 }
 
-- 
2.20.1

