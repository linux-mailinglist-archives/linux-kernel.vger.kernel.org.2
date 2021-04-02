Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41EB0352E54
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 19:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236022AbhDBRbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 13:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235134AbhDBRaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 13:30:39 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF170C0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 10:30:37 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id m20-20020a7bcb940000b029010cab7e5a9fso4610722wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 10:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NlEtSw2yb334S6OHokyLqfSbSWsCFUXj1IQBpWYM0ts=;
        b=VbTD3U5r1eU4nnsEYo9lsrcPWFqDblP226l2xygxMUP3JZb4Cu6WmtzONpdZHWj351
         gyEY4F3oICMNl9DlTFK+7avj97Xkbjz1LJ4lhU1fN4R68ziTUgr1f0gfuQy3Ksor1b22
         6Hj1XChCjWTDK1dQQjGBIqR4F9NimLao22uXUWcf52+CXTHrY5kGDsl+gNPq+iQEMuIP
         3EqGlbdvrp3xmhBni7eg64a9zfzlOcfNByA0eKVYtIq8DAS/U9qkkrH3RQjy1hnmNN4u
         oygORwchjVKMv1k/ckrJHP763GMUM3UTclNBkUmtMB8et95r/yUpKVy3yHAArK2Tolb+
         PHxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NlEtSw2yb334S6OHokyLqfSbSWsCFUXj1IQBpWYM0ts=;
        b=gWZGBZ3qCaKiM1WN/4jA19Mt38knh1QpKFpHJiFt9cvculXLveMsFRiUK60ll3+sV8
         8e+OoEhjxqGw3H/xrXaTqfns9GuGMnWjqgXGxtEQZDDJz8wXV0Glsdmo6r33uQQNPWIM
         Zr8t28EcyqvqDQ4WszS7gw44ls+dvTo4/UTN9cKurZe81iujPTyxGwNEC3hyG5neJNWe
         b0d1J9rVlXICrOAoqrI/kdxCPFf53OGC0Mzf2EfRPTskvtXRCStYyG2wLmY7IWLEFaSI
         BfR8B+6zTzK733WBxOcYi/yN9KTfPPsqohs+8GUNnkI4h6JNqQMq3kaQmx5qbWG4EXeh
         jKfA==
X-Gm-Message-State: AOAM531IB/78kdejp1pGZj7nCly5IZ/jHCDmUt9J5PaPJ7Ppt9PGfZo5
        PFMYUChJctZP5Fly0bK6bjM=
X-Google-Smtp-Source: ABdhPJymXxsrngrTgJcwC1rZrqmuNQR+PcysFvJfwU7RP5opn8hl/0wvGxsmX9HrgCtIuXRzChyb3Q==
X-Received: by 2002:a1c:a98a:: with SMTP id s132mr14185665wme.12.1617384636584;
        Fri, 02 Apr 2021 10:30:36 -0700 (PDT)
Received: from agape ([5.171.81.4])
        by smtp.gmail.com with ESMTPSA id x12sm3894409wrr.7.2021.04.02.10.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 10:30:36 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v2 12/30] staging: rtl8723bs: fix null check conditions
Date:   Fri,  2 Apr 2021 19:29:54 +0200
Message-Id: <dbb5f33f55441a4ea296da685a31833d7990bf6b.1617384172.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617384172.git.fabioaiuto83@gmail.com>
References: <cover.1617384172.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix post-commit hook issues:

CHECK: Comparison to NULL could be written "!psta"
178: FILE: drivers/staging/rtl8723bs/core/rtw_cmd.c:2012:
+			if (psta == NULL)

CHECK: Comparison to NULL could be written "!psta"
198: FILE: drivers/staging/rtl8723bs/core/rtw_cmd.c:2066:
+	if (psta == NULL)

CHECK: Comparison to NULL could be written "!psta"
211: FILE: drivers/staging/rtl8723bs/core/rtw_cmd.c:2081:
+	if (psta == NULL)

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_cmd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index 2086df056c44..840b9da9f2d9 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -2009,7 +2009,7 @@ void rtw_createbss_cmd_callback(struct adapter *padapter, struct cmd_obj *pcmd)
 		psta = rtw_get_stainfo(&padapter->stapriv, pnetwork->MacAddress);
 		if (!psta) {
 			psta = rtw_alloc_stainfo(&padapter->stapriv, pnetwork->MacAddress);
-			if (psta == NULL)
+			if (!psta)
 				goto createbss_cmd_fail;
 		}
 
@@ -2063,7 +2063,7 @@ void rtw_setstaKey_cmdrsp_callback(struct adapter *padapter,  struct cmd_obj *pc
 	struct set_stakey_rsp *psetstakey_rsp = (struct set_stakey_rsp *) (pcmd->rsp);
 	struct sta_info *psta = rtw_get_stainfo(pstapriv, psetstakey_rsp->addr);
 
-	if (psta == NULL)
+	if (!psta)
 		goto exit;
 
 exit:
@@ -2078,7 +2078,7 @@ void rtw_setassocsta_cmdrsp_callback(struct adapter *padapter,  struct cmd_obj *
 	struct set_assocsta_rsp *passocsta_rsp = (struct set_assocsta_rsp *) (pcmd->rsp);
 	struct sta_info *psta = rtw_get_stainfo(pstapriv, passocsta_parm->addr);
 
-	if (psta == NULL)
+	if (!psta)
 		goto exit;
 
 	psta->aid = passocsta_rsp->cam_id;
-- 
2.20.1

