Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA59353331
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 11:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236645AbhDCJO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 05:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236431AbhDCJOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 05:14:37 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF9DC06178C
        for <linux-kernel@vger.kernel.org>; Sat,  3 Apr 2021 02:14:34 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id f12so559536wro.0
        for <linux-kernel@vger.kernel.org>; Sat, 03 Apr 2021 02:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fwdqSVIbe15EmqulmndVdLGM1V+ZcYJqDXqI1hmDV28=;
        b=B2zKceQJMvJZps4KGFbrQ/dcZmkQUpB+C30A4wehgt5gfKeMeeEvQXrgmTNZ4Jvcnw
         LLkB7ByBIIwxsoyKNRiASU6qQy7q6uSo2CJkj2vjV0X3OiUyE3KWKgAgU8UyOC7ZJF37
         pYwEYQd+IuQrZKkqnrpoRFByq0oTnj5RB3zasfTF+/Qe6MaqD+GgurWwQskRDRkhl8bf
         6nGTC3AKgNQpj/azbxcDzTj9FFMfNFUKXDSQqKVy/xec1rLFMjdTAA1GA7dWAfymdlD/
         UPhWP9mIYjvRh3xDH89sjO+ZWK3mmQ2STjMXGJtTUp+3LhAPiUoJOzplbP4XIFYUvu3X
         S77Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fwdqSVIbe15EmqulmndVdLGM1V+ZcYJqDXqI1hmDV28=;
        b=r+OKNAdN6r1MApHTZ5s/FzGxdtBRmkDq/mVLHoPyixjOuZ6gxIe3Zqeh1M4WWwPQpM
         bxNKr1JoKtLzm/s45GMevUM9JjjI2b9YPvWgCy/yTDQ7BvK4FXZ1bOULpXD9ELol3R8f
         TpEDG0pyvRig5NU2VlEJNO3i89ycSEtRQTbCG+NybwgppggHYxuhr8Vyx9gNGSrygyzP
         7T/cQwKEN0HGM+jsrO5FNew/O9RQ2guwUfRvhue/lauFG8M28eQ8w1aU+GrDzlzJKOQT
         XjdTi+J1NREWEqMw5gvU9fqA6ZzMtjhLkugt+t4AxNOlhCgpjPMFzhQNvkeOZ7te7AB0
         A5ew==
X-Gm-Message-State: AOAM532uaWL3gpXz4mILWrD7KjUv5akQKZFpYmsKV3jINrWB+so51qRe
        1BUfbNk5vHMtXpnVlLpyQb4=
X-Google-Smtp-Source: ABdhPJyIuN1hBeQSCQvNnXuY1JY4jFiY2leEdEiS2S9ELnW4xNibCq8/wqSnOGzKyEs2RNlLCe0j0Q==
X-Received: by 2002:adf:ec8c:: with SMTP id z12mr19217699wrn.405.1617441273494;
        Sat, 03 Apr 2021 02:14:33 -0700 (PDT)
Received: from agape ([5.171.72.64])
        by smtp.gmail.com with ESMTPSA id c131sm15748535wma.37.2021.04.03.02.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Apr 2021 02:14:33 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v3 12/30] staging: rtl8723bs: fix null check conditions in core/rtw_cmd.c
Date:   Sat,  3 Apr 2021 11:13:34 +0200
Message-Id: <03e36e1710ea4dfd07c3753d9a8df5746e59bc18.1617440834.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617440833.git.fabioaiuto83@gmail.com>
References: <cover.1617440833.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix post-commit hook checkpatch issues:

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

