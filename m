Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63CB0353337
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 11:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236472AbhDCJP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 05:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbhDCJOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 05:14:46 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CE5C0617AA
        for <linux-kernel@vger.kernel.org>; Sat,  3 Apr 2021 02:14:43 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id w203-20020a1c49d40000b029010c706d0642so5837843wma.0
        for <linux-kernel@vger.kernel.org>; Sat, 03 Apr 2021 02:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sh+75Edn4hEE8xT+ConlCJ3LH03ZiX4WkfM9jtzjfcE=;
        b=gC8j2rVEaAMqMIcnlVxJgMz4EWvmCfeDeAEJaDiDx6O94icC76wmjb/PZFIEEMDKKl
         WX6sb70YGJdyCBLqLrTxGVJTiapIb/A83Xxm+jPoA17ZvryvmQe9hRSG2/rrBcS/1kLF
         WmMbuPDWi/r+ZIhZO3SXpoMx2seV62ADP4nVCXH4hrAEojoEG1RDk2aCw6bLWLk4Rgkt
         b5u9qQVV0bifiAbNHIky55Se8jF1s9Sg4ROljUojrEB7dN26sM1M5QeUIQUzS90B/zf4
         wwzkybZswqx7WR3gIlmmcI1upR/jhGjDYHRY5hxxYvC5JedzVSFAv6iOCim1m9ayrJU7
         GEeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sh+75Edn4hEE8xT+ConlCJ3LH03ZiX4WkfM9jtzjfcE=;
        b=ER4jyd8Pya9Hm2ARCuNJuYUsGKETGeKnT1G+EHGXxktLdKTYPAh3ukfsMHkTwHHwn1
         8vl4aqKfIZkeeuIPX8CpkH16Abbomxtq6VJOLtYuXKfHy+Agyxt+bQr3azo817kVUQQa
         w4fiBKrOImUtH5GUODd9E3b3ffnJFRo9cC6Gdg+cEpPo5/wYyZoyNiVd89qd+TBioIDj
         yDRdGvVSQ/Res81nu+6nqRy8k5lvS4S62/6amO14V1qYs48gPw64Y/ervGB6etWVzegz
         wXT30GAggsc9DGRKWocM0+fVD9e84x5C+ZexaE6BS3pGmXZBx1EOrx1m0RGnBS0wabFv
         6jAg==
X-Gm-Message-State: AOAM533ApaqZYE7wNuSRBqVkBtVQB4dc8AY4mg22we8VQR9+IitERiRS
        6X8o7KbshTSxJ1NoN+Iecqw=
X-Google-Smtp-Source: ABdhPJw3NTl8ZnD+GEoFQqgZhiqA9i/eHrYLIfAgMroFvILvusGOvja0m8VZFhv2Rb1oCF+ldHCILQ==
X-Received: by 2002:a7b:c3cd:: with SMTP id t13mr16199093wmj.109.1617441282642;
        Sat, 03 Apr 2021 02:14:42 -0700 (PDT)
Received: from agape ([5.171.72.64])
        by smtp.gmail.com with ESMTPSA id y17sm1903704wmo.42.2021.04.03.02.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Apr 2021 02:14:42 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v3 18/30] staging: rtl8723bs: remove commented RT_TRACE calls in core/rtw_recv.c
Date:   Sat,  3 Apr 2021 11:13:40 +0200
Message-Id: <8b99b45780ab10b946bcb642aae8904cbce95717.1617440834.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617440833.git.fabioaiuto83@gmail.com>
References: <cover.1617440833.git.fabioaiuto83@gmail.com>
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

