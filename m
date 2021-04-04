Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54150353865
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 16:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbhDDOLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 10:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbhDDOK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 10:10:27 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E992C0613E6
        for <linux-kernel@vger.kernel.org>; Sun,  4 Apr 2021 07:10:21 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id p19so4605711wmq.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Apr 2021 07:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sh+75Edn4hEE8xT+ConlCJ3LH03ZiX4WkfM9jtzjfcE=;
        b=CcmzmRz+/HYIg68d9xLuhCr6fGvuUs3KTTOgxfmnfmF3sVidEZCg28ctO3Gi7fMblN
         ulrkxOMgmPpRkeC2fO2XUx6PgB7TSpnKUHehPFF4Zff/AH99gQ4blCK0VXOqSCWs72o9
         B1QutnU7DZ5IWv1vsEjWVq1WJGH0GK2th9qV5zlAqHBg9w7Pn4qbYBU6M1WB23jkbZpQ
         9nJw0cCU3vq2a8Nryy5jZZrJAHSypMSu3TLvyfXMPfvCq8NjidpTpQUXtriN7bka3KHD
         Nlxot16gqnBA8V1J4r9CDqGMiPu6HzNJOPNDr4uBdzeSuSl143IJ+mOGV0JsCvQRj3mE
         hjhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sh+75Edn4hEE8xT+ConlCJ3LH03ZiX4WkfM9jtzjfcE=;
        b=PIBfxlJOXEoT+xMdiWwt/riw77L8k5eItzM3qk+yOGvqR2wDVC9WggF2MCfLoDJ7aa
         BdmMlMtIbOEANXkoriDpJWxXn/Oz9GfmkWRxqbW4BIY4Z4Xn56lyrf9M4d8DYglF4rZl
         zP7etzrQE6hiFYrGrDSchTf+8Ads6OAL3k9mWEnDZ5twkcMOpeFC12XOQjnwougu8pm+
         hpyAh3W9t6Rb3xErcEKlbEQC8T9mPddwEuP/oCMCufFWc7nYNUOVMw6fEaffl4QRDf3J
         jMVBZ+ElXREgEMtGlDKDDenk9xREnxJubVpdLPNptN/7xwvN9xxBwGdL0cc5BaIat9Ue
         pz5Q==
X-Gm-Message-State: AOAM530TgV6hN1CJktowiMfqlzGs8EdDU/DbUz8KUls4fxAexZRB7t5i
        sNtnoGgzKMOtysoqqY01B4Q=
X-Google-Smtp-Source: ABdhPJwJe6JGjmf4gYnFHMxO/EbKAV9/VCP4BW41ZjjcduwggS+Ss1zXTNx0dQUYg68o2kVkJF8hvA==
X-Received: by 2002:a1c:9dcf:: with SMTP id g198mr11211794wme.161.1617545420176;
        Sun, 04 Apr 2021 07:10:20 -0700 (PDT)
Received: from agape ([5.171.81.112])
        by smtp.gmail.com with ESMTPSA id n9sm23562818wrx.46.2021.04.04.07.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 07:10:19 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v4 18/30] staging: rtl8723bs: remove commented RT_TRACE calls in core/rtw_recv.c
Date:   Sun,  4 Apr 2021 16:09:34 +0200
Message-Id: <6986ce9c7bb0e9560d9463281973e1858347a966.1617545239.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617545239.git.fabioaiuto83@gmail.com>
References: <cover.1617545239.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove commented RT_TRACE calls

Remove all of the RT_TRACE logs in the core/rtw_recv.c file as they
currently do nothing as they require the code to be modified by
hand in order to be turned on. This obviously has not happened
since the code was merged. Moreover it relies on an unneeded
private log level tracing which overrides the in-kernel public one,
so just remove them as they are unused.

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

