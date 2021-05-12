Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDD037CFB9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 19:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbhELRQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 13:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238564AbhELQF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 12:05:29 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18133C0612A9
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 08:32:14 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id v5so16505429edc.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 08:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q9xyIoE6CrjZqQcs86QMTM/B4ykQ6IuUZXiQ0CWZo0U=;
        b=pQlMk9VnhDTBGRLs8hPH0QQpSihJHLzY2vQCZyNMjS5cpYFqwn1j+EnmAjBAcF59i5
         FGyMzxEou7ykJLKPytdLn1UiRt3CFxQa3yVd9h468K5RJVcnUHDnwMHDYuyuaNzQGQgW
         RkDgp0K9iG5ty9tPbEuolzRPvZOOQ9sDZeguUFKDndQF75kmb5m6iiknGdWpN4HUR4P5
         tlxcu8FxavibfMAhQkTuL9vplOZsC24UYSY1PFx48HZr8xJ8ogTrPj+V1mr8G4yTd2Gm
         EDDxjAIl3PilQlVp0Z2yotpR1xq0VyWdbswTEHOKDTqygB5VFDQw2Do0tJua0rD1hLd3
         Gphw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q9xyIoE6CrjZqQcs86QMTM/B4ykQ6IuUZXiQ0CWZo0U=;
        b=k6Yq0layAFjXt1sxKVxIKt+Ru2yZJYCQHrO7NhdnwmHhTY8MDN8N7woGoXecJeTogb
         G/qJUC3qDV4AvsSkhkRhM5pGe7bf2qUjT/u6/eaaCqce85tGKpv4AMmBw8pz0WzKe68a
         0wz8SQHvavPuR0n76dDw2jRHRv/U7a0V23XvyRANk/FHTfuqrbe5/ys5/rB+QKdgnCZr
         +3edEH7bj8ll5BNlyeQP2VE1TCnJibpIMPlFO2BExj6aRbzEHqRCtCG3owVQzLYZEqhq
         bG+zdKIRfNBhUXWvtMaB0DdLNqr37cGlfQb18Y6vlyBKNEI97lnGkA4KFzXnBNkRagrO
         4jbg==
X-Gm-Message-State: AOAM531Xec6P35GGpRKEU3OVtv3yMcyZIpV0fE410folUGYOo6VOpoC3
        XbqPqxlb5KSo1xvIgQCFWnQ=
X-Google-Smtp-Source: ABdhPJyTOS3XGFR8y61FuIO8viOKx45YtC+kDNjtdX3dmmSVuFgqv9yPETZmKdBZ0PgAWb7XbQrfrA==
X-Received: by 2002:a05:6402:1807:: with SMTP id g7mr43524931edy.335.1620833532671;
        Wed, 12 May 2021 08:32:12 -0700 (PDT)
Received: from linux.local (host-79-52-107-152.retail.telecomitalia.it. [79.52.107.152])
        by smtp.gmail.com with ESMTPSA id q25sm28866ejd.9.2021.05.12.08.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 08:32:12 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev (open list:STAGING SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH] staging: rtl8723bs: core: Remove unnecessary lines of code
Date:   Wed, 12 May 2021 17:32:08 +0200
Message-Id: <20210512153208.9584-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed unnecessary lines of code inside an "else if" block.
That code acquires a spinlock and iterates over each item in
a linked list for no purpose.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 20 +------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index c5430e737bb1..74cfc7b0a5a2 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -5125,23 +5125,9 @@ void _linked_info_dump(struct adapter *padapter)
 
 	if (padapter->bLinkInfoDump) {
 
-		if ((pmlmeinfo->state&0x03) == WIFI_FW_STATION_STATE) {
+		if ((pmlmeinfo->state&0x03) == WIFI_FW_STATION_STATE)
 			rtw_hal_get_def_var(padapter, HAL_DEF_UNDERCORATEDSMOOTHEDPWDB, &UndecoratedSmoothedPWDB);
-		} else if ((pmlmeinfo->state&0x03) == _HW_STATE_AP_) {
-			struct list_head	*phead, *plist;
 
-			struct sta_info *psta = NULL;
-			struct sta_priv *pstapriv = &padapter->stapriv;
-
-			spin_lock_bh(&pstapriv->asoc_list_lock);
-			phead = &pstapriv->asoc_list;
-			list_for_each(plist, phead) {
-				psta = list_entry(plist, struct sta_info,
-						  asoc_list);
-			}
-			spin_unlock_bh(&pstapriv->asoc_list_lock);
-
-		}
 		for (i = 0; i < NUM_STA; i++) {
 			if (pdvobj->macid[i]) {
 				if (i != 1) /* skip bc/mc sta */
@@ -5150,11 +5136,7 @@ void _linked_info_dump(struct adapter *padapter)
 			}
 		}
 		rtw_hal_set_def_var(padapter, HAL_DEF_DBG_RX_INFO_DUMP, NULL);
-
-
 	}
-
-
 }
 
 static u8 chk_ap_is_alive(struct adapter *padapter, struct sta_info *psta)
-- 
2.31.1

