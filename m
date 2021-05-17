Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED8A386B49
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 22:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240473AbhEQUWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 16:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240095AbhEQUVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 16:21:53 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BFEC06175F;
        Mon, 17 May 2021 13:20:36 -0700 (PDT)
Received: from dslb-084-059-234-229.084.059.pools.vodafone-ip.de ([84.59.234.229] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1lijj1-0001o4-2D; Mon, 17 May 2021 22:20:27 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v2 5/6] staging: rtl8188eu: use safe iterator in rtw_sta_flush
Date:   Mon, 17 May 2021 22:18:25 +0200
Message-Id: <20210517201826.25150-5-martin@kaiser.cx>
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

 drivers/staging/rtl8188eu/core/rtw_ap.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_ap.c b/drivers/staging/rtl8188eu/core/rtw_ap.c
index d297d5301153..bbecb07274f6 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ap.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ap.c
@@ -1573,8 +1573,8 @@ u8 ap_free_sta(struct adapter *padapter, struct sta_info *psta,
 
 int rtw_sta_flush(struct adapter *padapter)
 {
-	struct list_head *phead, *plist;
-	struct sta_info *psta = NULL;
+	struct list_head *phead;
+	struct sta_info *psta, *temp;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
@@ -1588,9 +1588,7 @@ int rtw_sta_flush(struct adapter *padapter)
 	spin_lock_bh(&pstapriv->asoc_list_lock);
 	phead = &pstapriv->asoc_list;
 	/* free sta asoc_queue */
-	list_for_each(plist, phead) {
-		psta = list_entry(plist, struct sta_info, asoc_list);
-
+	list_for_each_entry_safe(psta, temp, phead, asoc_list) {
 		list_del_init(&psta->asoc_list);
 		pstapriv->asoc_list_cnt--;
 
-- 
2.20.1

