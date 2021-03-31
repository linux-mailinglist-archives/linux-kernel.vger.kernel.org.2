Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36E5F3507CA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 22:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236414AbhCaUHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 16:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236408AbhCaUGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 16:06:39 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B256BC061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 13:06:39 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id m7so75046pgj.8
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 13:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=k3BtLfKmoPsibyUgIOZU62iLipoHU12iPAWHYT8Z37Y=;
        b=bvjYxHv/6etzeVjArSNWSn51LE0kU0Oga8xIzt22Z+CI8dMAmAgMgQqAFCn+S6O8D7
         dDGK20Nh/p5PCB9y3KVqn9t3TAzSviabgAEfg85I316bEXjBcpVAhLZmcGS33Ujnbwpa
         H6sZArdCEG7MDaA2c5zk4kBmFOQspr1r/52vCiBN+S7t2rYTXr7m/1GkVM7NyupBnCEp
         orOOkndb9Gz1cWJt1kVPKCrWsHmLc3kbOwJ4pdz7Ocd86ALfH0iXAa0PT0fcV3vKVibp
         s/C749x9MvF6s60cOxC4trWt4hRZFhS7cHtT5DWHRXT1DZ45IBeibDbSpq6csLPOYWGQ
         0OSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=k3BtLfKmoPsibyUgIOZU62iLipoHU12iPAWHYT8Z37Y=;
        b=EA0mbAd1Vp7PHsFHHh7mUFh5245N6PftcBwZEiUN2ykjP8ER6YXnd2vhOm2uB0gn9D
         isw+NomJTkIS4kf/ie1L+IeKXRKBE3ozZKXGxtwYctq9J9IqNO8R0GKrP5bew8L0EA8u
         VNu3GPJk++eZCuYH9UZZWHwBJz0YSNsb+/fMJ/NKCWf5pLiaY9YC3dXfc6tRtcS57aHF
         kks0HZeiwDuSgqg2NTv0UNzox09O/6Y1jLBlZ5grPCVGYbURzzVAfHEWIl8fbcc8vhus
         yJ1X1UGkyYtbredHQ8uVwFqyzYArwiorbN3jgsjEZT30jj9wI6+oHOObPmmBxpzzjaHD
         WFcA==
X-Gm-Message-State: AOAM533nwc0u2PNLHQcs1XJzZX0Pwt+1Z8CIoYNpkZJQTxfdWYDCA6Uc
        x1lse4FIeAsWJ4xc5IVgekU=
X-Google-Smtp-Source: ABdhPJzo/ciRKeEVV1Usujjl+R1FBukLDPkJJ64fjyu7ko/G/I0CRjWyMaZXkXbL9Ecba5xHEfnIrQ==
X-Received: by 2002:aa7:9f90:0:b029:204:99fa:3374 with SMTP id z16-20020aa79f900000b029020499fa3374mr4470948pfr.11.1617221199294;
        Wed, 31 Mar 2021 13:06:39 -0700 (PDT)
Received: from djbComp.hitronhub.home (S0106ac202ecb0523.gv.shawcable.net. [70.67.120.89])
        by smtp.gmail.com with ESMTPSA id d22sm2985668pjx.24.2021.03.31.13.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 13:06:39 -0700 (PDT)
From:   Deborah Brouwer <deborahbrouwer3563@gmail.com>
To:     gregkh@linuxfoundation.org, ross.schm.dev@gmail.com,
        marcocesati@gmail.com, fabioaiuto83@gmail.com,
        dan.carpenter@oracle.com, phil@philpotter.co.uk,
        amarjargal16@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com,
        Deborah Brouwer <deborahbrouwer3563@gmail.com>
Subject: [PATCH 2/3] staging: rtl8723bs: core: fix block comment warning
Date:   Wed, 31 Mar 2021 13:05:36 -0700
Message-Id: <5ff15315036be9bdf2059bab2ddd00f7dce0d20a.1617221075.git.deborahbrouwer3563@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1617221075.git.deborahbrouwer3563@gmail.com>
References: <cover.1617221075.git.deborahbrouwer3563@gmail.com>
In-Reply-To: <cover.1617221075.git.deborahbrouwer3563@gmail.com>
References: <cover.1617221075.git.deborahbrouwer3563@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch warning:
WARNING: Block comments use * on subsequent lines

Signed-off-by: Deborah Brouwer <deborahbrouwer3563@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_xmit.c | 59 +++++++++++------------
 1 file changed, 28 insertions(+), 31 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
index 3878caf0b56c..428c71ce0334 100644
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
 
@@ -1069,17 +1069,15 @@ u32 rtw_calculate_wlan_pkt_size_by_attribue(struct pkt_attrib *pattrib)
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
+ *
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
@@ -1693,23 +1691,22 @@ static void rtw_init_xmitframe(struct xmit_frame *pxframe)
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

