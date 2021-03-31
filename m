Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82FC9350A60
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 00:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbhCaWoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 18:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbhCaWni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 18:43:38 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9F7C061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 15:43:38 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id a12so57572pfc.7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 15:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=6uGqFwYNsuJezqdNtnoCaZngsfZNhT7oD8syM6fdc0M=;
        b=JRRQiRS4O+tVLW16RXB507/VUpJJqzf4AUm0fjg7ZotsNHyNZPl2D4rrkcCz3OQ7Op
         UWmNEFeztLqUutnGhRU2W7SHAd9twUMiBL4pSJ3Ym26Adew8Gqf7QTDwvGWQKT1hYkK9
         nZamQtODqFL4svPzYEUm7C9BZblIXLYUDzGUpxZJ3uJHi2c3QxK5foCOBzBOset55Oc3
         ckOWwcF5Jn+2EHr/p9R5doqr5z2cMTBXv6YvFvfj91V3gpU8FUigyVB/L9pHZraSN3nD
         hmwP9TAIcWbGOgQmB+RA117ozESeKUs9DbXTzS/X58+bvv0eckrPDKQBmxCnb3lwPxxQ
         af1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=6uGqFwYNsuJezqdNtnoCaZngsfZNhT7oD8syM6fdc0M=;
        b=CiDHWcKdDfFUZVTiV9EQ0d4CPEMClHUwFA+JNao4Hokg50iydAoHck8iLr9mixK1ZP
         Yld5MG/Esf4VWV7jmkxUfE+tN1bQL9afw8a33prQdraJUnoB38rl5X/F8WkgE49IBIHc
         I+3aEsoeH6vgOlXyegZkbsMbSpt5xlpmFUPlZrFT4kL/f2JByLE1R183n7b9Wh509aLn
         gyieupy3iIcPi5XSxir53cJSiV36G26uWwkpEzRlgBOE5zgbgv3b+84Jxnqs6nV9kx6a
         T45LCrQxJ+zHXPPeAVjx4ka253KG1ffVn2rwED/hwUzwakGs4xy+hZ4FlOkganFER2dJ
         K+eA==
X-Gm-Message-State: AOAM531vFvfMwuCrtZR/BayUE2t+RnzvVrIOTk6bmtby0VTi+8NXvwhR
        EGG7X9JMW+gBtaSk2/q68mQ=
X-Google-Smtp-Source: ABdhPJzQta4mcu6HE7SV8FE+HoUnHRVo2tfnZfntw5iyA4BmKj4hsjg/0mog07hpnAugX9xKvAQ9nA==
X-Received: by 2002:aa7:8f04:0:b029:1f7:d71b:6a51 with SMTP id x4-20020aa78f040000b02901f7d71b6a51mr5007010pfr.4.1617230617958;
        Wed, 31 Mar 2021 15:43:37 -0700 (PDT)
Received: from djbComp.hitronhub.home (S0106ac202ecb0523.gv.shawcable.net. [70.67.120.89])
        by smtp.gmail.com with ESMTPSA id h19sm3338830pfc.172.2021.03.31.15.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 15:43:37 -0700 (PDT)
From:   Deborah Brouwer <deborahbrouwer3563@gmail.com>
To:     gregkh@linuxfoundation.org, ross.schm.dev@gmail.com,
        marcocesati@gmail.com, fabioaiuto83@gmail.com,
        dan.carpenter@oracle.com, phil@philpotter.co.uk,
        amarjargal16@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com,
        Deborah Brouwer <deborahbrouwer3563@gmail.com>
Subject: [PATCH v2 2/3] staging: rtl8723bs: core: add * to block comments
Date:   Wed, 31 Mar 2021 15:42:30 -0700
Message-Id: <bd143fff718849274b065a1c71f1aa7f6fc6f40f.1617229359.git.deborahbrouwer3563@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1617229359.git.deborahbrouwer3563@gmail.com>
References: <cover.1617229359.git.deborahbrouwer3563@gmail.com>
In-Reply-To: <cover.1617229359.git.deborahbrouwer3563@gmail.com>
References: <cover.1617229359.git.deborahbrouwer3563@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add * at the beginning of each line in block comments to conform to the
Linux kernel coding style. Issue detected using checkpatch.

Signed-off-by: Deborah Brouwer <deborahbrouwer3563@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_xmit.c | 58 +++++++++++------------
 1 file changed, 27 insertions(+), 31 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
index 3878caf0b56c..cb8d19e4dd3c 100644
--- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
+++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
@@ -46,8 +46,8 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 	init_completion(&pxmitpriv->terminate_xmitthread_comp);
 
 	/*
-	Please insert all the queue initializaiton using _rtw_init_queue below
-	*/
+	 * Please insert all the queue initializaiton using _rtw_init_queue below
+	 */
 
 	pxmitpriv->adapter = padapter;
 
@@ -60,10 +60,10 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 	_rtw_init_queue(&pxmitpriv->free_xmit_queue);
 
 	/*
-	Please allocate memory with the sz = (struct xmit_frame) * NR_XMITFRAME,
-	and initialize free_xmit_frame below.
-	Please also apply  free_txobj to link_up all the xmit_frames...
-	*/
+	 * Please allocate memory with the sz = (struct xmit_frame) * NR_XMITFRAME,
+	 * and initialize free_xmit_frame below.
+	 * Please also apply  free_txobj to link_up all the xmit_frames...
+	 */
 
 	pxmitpriv->pallocated_frame_buf = vzalloc(NR_XMITFRAME * sizeof(struct xmit_frame) + 4);
 
@@ -1069,17 +1069,14 @@ u32 rtw_calculate_wlan_pkt_size_by_attribue(struct pkt_attrib *pattrib)
 }
 
 /*
-
-This sub-routine will perform all the following:
-
-1. remove 802.3 header.
-2. create wlan_header, based on the info in pxmitframe
-3. append sta's iv/ext-iv
-4. append LLC
-5. move frag chunk from pframe to pxmitframe->mem
-6. apply sw-encrypt, if necessary.
-
-*/
+ * This sub-routine will perform all the following:
+ * 1. remove 802.3 header.
+ * 2. create wlan_header, based on the info in pxmitframe
+ * 3. append sta's iv/ext-iv
+ * 4. append LLC
+ * 5. move frag chunk from pframe to pxmitframe->mem
+ * 6. apply sw-encrypt, if necessary.
+ */
 s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct xmit_frame *pxmitframe)
 {
 	struct pkt_file pktfile;
@@ -1693,23 +1690,22 @@ static void rtw_init_xmitframe(struct xmit_frame *pxframe)
 }
 
 /*
-Calling context:
-1. OS_TXENTRY
-2. RXENTRY (rx_thread or RX_ISR/RX_CallBack)
-
-If we turn on USE_RXTHREAD, then, no need for critical section.
-Otherwise, we must use _enter/_exit critical to protect free_xmit_queue...
-
-Must be very, very cautious...
-
-*/
+ * Calling context:
+ * 1. OS_TXENTRY
+ * 2. RXENTRY (rx_thread or RX_ISR/RX_CallBack)
+ *
+ * If we turn on USE_RXTHREAD, then, no need for critical section.
+ * Otherwise, we must use _enter/_exit critical to protect free_xmit_queue...
+ *
+ * Must be very, very cautious...
+ */
 struct xmit_frame *rtw_alloc_xmitframe(struct xmit_priv *pxmitpriv)/* _queue *pfree_xmit_queue) */
 {
 	/*
-		Please remember to use all the osdep_service api,
-		and lock/unlock or _enter/_exit critical to protect
-		pfree_xmit_queue
-	*/
+	 *	Please remember to use all the osdep_service api,
+	 *	and lock/unlock or _enter/_exit critical to protect
+	 *	pfree_xmit_queue
+	 */
 
 	struct xmit_frame *pxframe = NULL;
 	struct list_head *plist, *phead;
-- 
2.17.1

