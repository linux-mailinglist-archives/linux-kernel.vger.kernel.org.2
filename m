Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E61863E361F
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 17:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbhHGPjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 11:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbhHGPhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 11:37:54 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE7BC0613D3
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 08:37:22 -0700 (PDT)
Received: from dslb-084-059-249-202.084.059.pools.vodafone-ip.de ([84.59.249.202] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mCONx-0003Y3-T7; Sat, 07 Aug 2021 17:37:17 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 08/12] staging: r8188eu: remove RT_TRACE prints from recv_linux.c
Date:   Sat,  7 Aug 2021 17:36:32 +0200
Message-Id: <20210807153636.11712-9-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210807153636.11712-1-martin@kaiser.cx>
References: <20210807153636.11712-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should use the standard mechanism for debug prints. Remove the prints
that use driver-specific macros.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/os_dep/recv_linux.c | 23 +--------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/recv_linux.c b/drivers/staging/r8188eu/os_dep/recv_linux.c
index 1fd3f1bf1fe5..8dfabdb02494 100644
--- a/drivers/staging/r8188eu/os_dep/recv_linux.c
+++ b/drivers/staging/r8188eu/os_dep/recv_linux.c
@@ -118,21 +118,8 @@ int rtw_recv_indicatepkt(struct adapter *padapter,
 	pfree_recv_queue = &(precvpriv->free_recv_queue);
 
 	skb = precv_frame->pkt;
-	if (!skb) {
-		RT_TRACE(_module_recv_osdep_c_, _drv_err_,
-			 ("rtw_recv_indicatepkt():skb == NULL something wrong!!!!\n"));
+	if (!skb)
 		goto _recv_indicatepkt_drop;
-	}
-
-	RT_TRACE(_module_recv_osdep_c_, _drv_info_,
-		 ("rtw_recv_indicatepkt():skb != NULL !!!\n"));
-	RT_TRACE(_module_recv_osdep_c_, _drv_info_,
-		 ("rtw_recv_indicatepkt():precv_frame->rx_head =%p  precv_frame->hdr.rx_data =%p\n",
-		 precv_frame->rx_head, precv_frame->rx_data));
-	RT_TRACE(_module_recv_osdep_c_, _drv_info_,
-		 ("precv_frame->hdr.rx_tail =%p precv_frame->rx_end =%p precv_frame->hdr.len =%d\n",
-		 precv_frame->rx_tail, precv_frame->rx_end,
-		 precv_frame->len));
 
 	skb->data = precv_frame->rx_data;
 
@@ -140,11 +127,6 @@ int rtw_recv_indicatepkt(struct adapter *padapter,
 
 	skb->len = precv_frame->len;
 
-	RT_TRACE(_module_recv_osdep_c_, _drv_info_,
-		 ("skb->head =%p skb->data =%p skb->tail =%p skb->end =%p skb->len =%d\n",
-		 skb->head, skb->data, skb_tail_pointer(skb),
-		 skb_end_pointer(skb), skb->len));
-
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
 		struct sk_buff *pskb2 = NULL;
 		struct sta_info *psta = NULL;
@@ -195,9 +177,6 @@ int rtw_recv_indicatepkt(struct adapter *padapter,
 
 	rtw_free_recvframe(precv_frame, pfree_recv_queue);
 
-	RT_TRACE(_module_recv_osdep_c_, _drv_info_,
-		 ("\n rtw_recv_indicatepkt :after netif_rx!!!!\n"));
-
 	return _SUCCESS;
 
 _recv_indicatepkt_drop:
-- 
2.20.1

