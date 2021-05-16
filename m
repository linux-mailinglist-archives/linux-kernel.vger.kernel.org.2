Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D13F9381FA0
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 18:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbhEPQJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 12:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbhEPQI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 12:08:56 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0F5C061756;
        Sun, 16 May 2021 09:07:41 -0700 (PDT)
Received: from dslb-094-219-038-078.094.219.pools.vodafone-ip.de ([94.219.38.78] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1liJId-0003Vl-Nf; Sun, 16 May 2021 18:07:27 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 2/6] staging: rtl8188eu: use safe iterator in rtw_free_all_stainfo
Date:   Sun, 16 May 2021 18:06:09 +0200
Message-Id: <20210516160613.30489-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210516160613.30489-1-martin@kaiser.cx>
References: <20210516160613.30489-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is another case where we may remove list entries while we iterate over
the list. Use list_for_each_safe to avoid an endless loop.

Fixes: 23017c8842d2 ("staging: rtl8188eu: Use list iterators and helpers")
Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
Without this patch, unloading the module goes into an endless loop
sometimes.

 drivers/staging/rtl8188eu/core/rtw_sta_mgt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c b/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
index 7941ca0397ed..eda7a441acde 100644
--- a/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
+++ b/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
@@ -379,7 +379,7 @@ u32 rtw_free_stainfo(struct adapter *padapter, struct sta_info *psta)
 /*  free all stainfo which in sta_hash[all] */
 void rtw_free_all_stainfo(struct adapter *padapter)
 {
-	struct list_head *plist, *phead;
+	struct list_head *plist, *phead, *temp;
 	s32 index;
 	struct sta_info *psta = NULL;
 	struct sta_priv *pstapriv = &padapter->stapriv;
@@ -392,7 +392,7 @@ void rtw_free_all_stainfo(struct adapter *padapter)
 
 	for (index = 0; index < NUM_STA; index++) {
 		phead = &pstapriv->sta_hash[index];
-		list_for_each(plist, phead) {
+		list_for_each_safe(plist, temp, phead) {
 			psta = list_entry(plist, struct sta_info, hash_list);
 
 			if (pbcmc_stainfo != psta)
-- 
2.20.1

