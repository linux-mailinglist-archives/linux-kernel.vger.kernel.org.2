Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF49352942
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 12:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235092AbhDBKCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 06:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234904AbhDBKCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 06:02:06 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB7EC0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 03:02:04 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id l4so6740056ejc.10
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 03:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sN44X9WN09LZQNq8Yg3XRYRaWw1riUHmEayF7f44ixo=;
        b=YoXlqjj4M3mLIhlrjfH8ptCZuYrQUgeG+peyA6oqIwAmw88+mLasI4jEAId0xWhb0/
         K2DVWvKLrpPFtAbFsnKzW2hfPQOHUy0zq0yHSBU1L3Ug4azsZpf+I5nQvGVlV+V0du0N
         KlWBDURu7wzZ8vtYYmMovQurGpYN+xwQBrwh40XekZweyktjxahGjuSRcXKJbWHKmaHl
         G3NyNbTxsdQcneiBd3i9SbZqyVXw4LHuoJUy+EgHjOywwoqK81alkKR/J1Q/IN1DWQxY
         CQDNeBmgmjdQXwrDJQs80vFdgW4iioHjJ0Spbm+JedtMOF0KFtuqeVFcJbnCVLmxY3uD
         KgGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sN44X9WN09LZQNq8Yg3XRYRaWw1riUHmEayF7f44ixo=;
        b=G9sq36619iR5/FCO+t0jodVz1YEPAVDwOSZ+h9fM3/gkjNAmR39w+MFEssd2Gsbnkz
         R/PKQbuNL7of+FyeecvNNFWQbomY4XUH8/YVgWIn5lvxmTk/rmyrYiQc+fmQWxKHtH8a
         KPR0pDBqFxukr9dx056n6uzayu35j7A1SzNrkU9UIQX1/uNVBhXeGUrix8lC63QP3KZF
         gH4NIIWMD53ZX6X+/a6SLh0RziILqXpbSvF5OJp3pF2PkEGtFqcxQAeAa066hQ4DK+9P
         UXRyz1Vj1LcDYWDauUlGlzf51yiryUmxWq85I57tbfNTsH1gGozJzCs5Z4Cv/JoArdsz
         hRpw==
X-Gm-Message-State: AOAM530ygGp/4HcruzKyzLWkEgYdQOuKxnZeDf1fqlPHqAvqEPG6I/tn
        LumIXww6Jqf1DCQNHV+O5gU=
X-Google-Smtp-Source: ABdhPJxMJRQI+Lu+JTlsdmtNeGEK7zywIhBHKSxGHIKwNHV1+P2FlhkHM2F4AtH6JWblDQ6zh+bh0g==
X-Received: by 2002:a17:906:51c3:: with SMTP id v3mr13414076ejk.497.1617357723623;
        Fri, 02 Apr 2021 03:02:03 -0700 (PDT)
Received: from agape ([5.171.72.128])
        by smtp.gmail.com with ESMTPSA id s11sm5128061edt.27.2021.04.02.03.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 03:02:03 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 10/16] staging: rtl8723bs: remove commented RT_TRACE calls in core/rtw_recv.c
Date:   Fri,  2 Apr 2021 12:01:30 +0200
Message-Id: <da9c29a61105b5c9d40d0f7da3eccc7b71b879d4.1617356821.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617356821.git.fabioaiuto83@gmail.com>
References: <cover.1617356821.git.fabioaiuto83@gmail.com>
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

