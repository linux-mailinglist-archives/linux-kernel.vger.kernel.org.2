Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B83D0386B4A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 22:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242112AbhEQUWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 16:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239639AbhEQUV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 16:21:57 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD84C061573;
        Mon, 17 May 2021 13:20:40 -0700 (PDT)
Received: from dslb-084-059-234-229.084.059.pools.vodafone-ip.de ([84.59.234.229] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1lijj2-0001o4-6W; Mon, 17 May 2021 22:20:28 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v2 6/6] staging: rtl8188eu: use safe iterator in rtw_free_xmitframe_queue
Date:   Mon, 17 May 2021 22:18:26 +0200
Message-Id: <20210517201826.25150-6-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210517201826.25150-1-martin@kaiser.cx>
References: <20210516160613.30489-1-martin@kaiser.cx>
 <20210517201826.25150-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use list_for_each_entry_safe, we may delete list items while iterating
over the list.

Fixes: 23017c8842d2 ("staging: rtl8188eu: Use list iterators and helpers")
Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
v2:
 - use list_for_each_entry_safe

 drivers/staging/rtl8188eu/core/rtw_xmit.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_xmit.c b/drivers/staging/rtl8188eu/core/rtw_xmit.c
index 3763d188b892..dcc29a74612d 100644
--- a/drivers/staging/rtl8188eu/core/rtw_xmit.c
+++ b/drivers/staging/rtl8188eu/core/rtw_xmit.c
@@ -1329,17 +1329,15 @@ s32 rtw_free_xmitframe(struct xmit_priv *pxmitpriv, struct xmit_frame *pxmitfram
 
 void rtw_free_xmitframe_queue(struct xmit_priv *pxmitpriv, struct __queue *pframequeue)
 {
-	struct list_head *plist, *phead;
-	struct	xmit_frame	*pxmitframe;
+	struct list_head *phead;
+	struct	xmit_frame	*pxmitframe, *temp;
 
 	spin_lock_bh(&pframequeue->lock);
 
 	phead = get_list_head(pframequeue);
-	list_for_each(plist, phead) {
-		pxmitframe = list_entry(plist, struct xmit_frame, list);
-
+	list_for_each_entry_safe(pxmitframe, temp, phead, list)
 		rtw_free_xmitframe(pxmitpriv, pxmitframe);
-	}
+
 	spin_unlock_bh(&pframequeue->lock);
 }
 
-- 
2.20.1

