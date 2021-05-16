Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87F76381F9F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 18:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbhEPQJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 12:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbhEPQI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 12:08:56 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9EACC061573;
        Sun, 16 May 2021 09:07:40 -0700 (PDT)
Received: from dslb-094-219-038-078.094.219.pools.vodafone-ip.de ([94.219.38.78] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1liJIf-0003Vl-DJ; Sun, 16 May 2021 18:07:29 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 3/6] staging: rtl8188eu: use safe iterator in expire_timeout_chk
Date:   Sun, 16 May 2021 18:06:10 +0200
Message-Id: <20210516160613.30489-3-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210516160613.30489-1-martin@kaiser.cx>
References: <20210516160613.30489-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the first loop in expire_timeout_chk, we may call rtw_free_stainfo and
remove an entry from auth_list.

In the second loop, we may call list_del_init on our list.

Use list_for_each_safe for both loops.

Fixes: 23017c8842d2 ("staging: rtl8188eu: Use list iterators and helpers")
Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
compile-tested only

 drivers/staging/rtl8188eu/core/rtw_ap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_ap.c b/drivers/staging/rtl8188eu/core/rtw_ap.c
index ca9a321c4921..a410b42ecb6e 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ap.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ap.c
@@ -164,7 +164,7 @@ static u8 chk_sta_is_alive(struct sta_info *psta)
 
 void expire_timeout_chk(struct adapter *padapter)
 {
-	struct list_head *phead, *plist;
+	struct list_head *phead, *plist, *temp;
 	u8 updated = 0;
 	struct sta_info *psta = NULL;
 	struct sta_priv *pstapriv = &padapter->stapriv;
@@ -176,7 +176,7 @@ void expire_timeout_chk(struct adapter *padapter)
 
 	phead = &pstapriv->auth_list;
 	/* check auth_queue */
-	list_for_each(plist, phead) {
+	list_for_each_safe(plist, temp, phead) {
 		psta = list_entry(plist, struct sta_info, auth_list);
 
 		if (psta->expire_to > 0) {
-- 
2.20.1

