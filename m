Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B967386B47
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 22:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241219AbhEQUWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 16:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239005AbhEQUVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 16:21:51 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD44DC061573;
        Mon, 17 May 2021 13:20:34 -0700 (PDT)
Received: from dslb-084-059-234-229.084.059.pools.vodafone-ip.de ([84.59.234.229] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1lijiy-0001o4-K8; Mon, 17 May 2021 22:20:24 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v2 3/6] staging: rtl8188eu: use safe iterator in expire_timeout_chk
Date:   Mon, 17 May 2021 22:18:23 +0200
Message-Id: <20210517201826.25150-3-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210517201826.25150-1-martin@kaiser.cx>
References: <20210516160613.30489-1-martin@kaiser.cx>
 <20210517201826.25150-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the first loop in expire_timeout_chk, we may call rtw_free_stainfo and
remove an entry from auth_list.

In the second loop, we may call list_del_init on our list.

Use list_for_each_entry_safe for both loops.

Fixes: 23017c8842d2 ("staging: rtl8188eu: Use list iterators and helpers")
Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
v2:
 - use list_for_each_entry_safe
 - update both loops (I forgot the 2nd loop in v1)

 drivers/staging/rtl8188eu/core/rtw_ap.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_ap.c b/drivers/staging/rtl8188eu/core/rtw_ap.c
index ca9a321c4921..6d7c96f1aa42 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ap.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ap.c
@@ -164,9 +164,9 @@ static u8 chk_sta_is_alive(struct sta_info *psta)
 
 void expire_timeout_chk(struct adapter *padapter)
 {
-	struct list_head *phead, *plist;
+	struct list_head *phead;
 	u8 updated = 0;
-	struct sta_info *psta = NULL;
+	struct sta_info *psta, *temp;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	u8 chk_alive_num = 0;
 	char chk_alive_list[NUM_STA];
@@ -176,9 +176,7 @@ void expire_timeout_chk(struct adapter *padapter)
 
 	phead = &pstapriv->auth_list;
 	/* check auth_queue */
-	list_for_each(plist, phead) {
-		psta = list_entry(plist, struct sta_info, auth_list);
-
+	list_for_each_entry_safe(psta, temp, phead, auth_list) {
 		if (psta->expire_to > 0) {
 			psta->expire_to--;
 			if (psta->expire_to == 0) {
@@ -206,9 +204,7 @@ void expire_timeout_chk(struct adapter *padapter)
 
 	phead = &pstapriv->asoc_list;
 	/* check asoc_queue */
-	list_for_each(plist, phead) {
-		psta = list_entry(plist, struct sta_info, asoc_list);
-
+	list_for_each_entry_safe(psta, temp, phead, asoc_list) {
 		if (chk_sta_is_alive(psta) || !psta->expire_to) {
 			psta->expire_to = pstapriv->expire_to;
 			psta->keep_alive_trycnt = 0;
-- 
2.20.1

