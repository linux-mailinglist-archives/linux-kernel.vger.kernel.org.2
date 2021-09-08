Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C73440367B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 10:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348401AbhIHI7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 04:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351279AbhIHI7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 04:59:31 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CA5C061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 01:58:23 -0700 (PDT)
Received: from pd956d63d.dip0.t-ipconnect.de ([217.86.214.61] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mNtPQ-0000yP-G6; Wed, 08 Sep 2021 10:58:20 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 3/3] staging: r8188eu: this endless loop is executed only once
Date:   Wed,  8 Sep 2021 10:57:47 +0200
Message-Id: <20210908085747.32254-4-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210908085747.32254-1-martin@kaiser.cx>
References: <20210908085747.32254-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a funny "loop" in rtl8188eu_xmitframe_complete. It looks like

do {
  ... some commands...
  break;
} while (1);

Remove it.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/rtl8188eu_xmit.c | 34 +++++++++-----------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
index 17be67ac5fae..3b870d0c72fd 100644
--- a/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
+++ b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
@@ -437,30 +437,26 @@ s32 rtl8188eu_xmitframe_complete(struct adapter *adapt, struct xmit_priv *pxmitp
 	}
 
 	/* 3 1. pick up first frame */
-	do {
-		rtw_free_xmitframe(pxmitpriv, pxmitframe);
-
-		pxmitframe = rtw_dequeue_xframe(pxmitpriv, pxmitpriv->hwxmits, pxmitpriv->hwxmit_entry);
-		if (!pxmitframe) {
-			/*  no more xmit frame, release xmit buffer */
-			rtw_free_xmitbuf(pxmitpriv, pxmitbuf);
-			return false;
-		}
+	rtw_free_xmitframe(pxmitpriv, pxmitframe);
 
-		pxmitframe->pxmitbuf = pxmitbuf;
-		pxmitframe->buf_addr = pxmitbuf->pbuf;
-		pxmitbuf->priv_data = pxmitframe;
+	pxmitframe = rtw_dequeue_xframe(pxmitpriv, pxmitpriv->hwxmits, pxmitpriv->hwxmit_entry);
+	if (!pxmitframe) {
+		/*  no more xmit frame, release xmit buffer */
+		rtw_free_xmitbuf(pxmitpriv, pxmitbuf);
+		return false;
+	}
 
-		pxmitframe->agg_num = 1; /*  alloc xmitframe should assign to 1. */
-		pxmitframe->pkt_offset = 1; /*  first frame of aggregation, reserve offset */
+	pxmitframe->pxmitbuf = pxmitbuf;
+	pxmitframe->buf_addr = pxmitbuf->pbuf;
+	pxmitbuf->priv_data = pxmitframe;
 
-		rtw_xmitframe_coalesce(adapt, pxmitframe->pkt, pxmitframe);
+	pxmitframe->agg_num = 1; /*  alloc xmitframe should assign to 1. */
+	pxmitframe->pkt_offset = 1; /*  first frame of aggregation, reserve offset */
 
-		/*  always return ndis_packet after rtw_xmitframe_coalesce */
-		rtw_os_xmit_complete(adapt, pxmitframe);
+	rtw_xmitframe_coalesce(adapt, pxmitframe->pkt, pxmitframe);
 
-		break;
-	} while (1);
+	/*  always return ndis_packet after rtw_xmitframe_coalesce */
+	rtw_os_xmit_complete(adapt, pxmitframe);
 
 	/* 3 2. aggregate same priority and same DA(AP or STA) frames */
 	pfirstframe = pxmitframe;
-- 
2.20.1

