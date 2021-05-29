Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35009394E08
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 22:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbhE2UEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 16:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbhE2UED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 16:04:03 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC8BC061574
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:02:26 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id t10-20020a05683022eab0290304ed8bc759so6949926otc.12
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ATBwXD0kFwoJv/VdiHBEZd3i3+fpJe73CIUjNU9psDQ=;
        b=PcmxOa55p1nQvi9wfEV7lp5O+4daHcpB2XaQ/e4edhltW8xdU2YEQm4XuKtWA6nBIu
         J8KZX0EGtt2HCqCTPPZCR47dh9TWGpPB8tYRAjf6OD3GudoIOFmkYyfE57tYA0YKGBw3
         AXMY0VxAqvGBPlgOqjqUgJSgcnTdL8idOuSVXEuOY+eTrraF6E8EoOJz3sJ0Mp30Y2E0
         GRzZMT3j7RvXntIAGuWNMNDUWi27VWXBRgTdQA2pBFw+NdqgJZZlBsl6f29HHRzdGzTQ
         MSUSbqx4rbI0uHbSt58XgGFi9rtqzrqMvsBIPUgmWYuxFUmOcEUvXeoUxDZ2xl+sU/aH
         OtuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ATBwXD0kFwoJv/VdiHBEZd3i3+fpJe73CIUjNU9psDQ=;
        b=iFULGA71z1FUJtSCdFaTdTZgu7reEPKKWCJj/kG7wSe1Lt/f/+vwe18BbKmFcbpFOz
         B0SPn+mf5PLROqOozkWyIKkxS5O300A0K2+eRFtXJ/1VNbli1n9mkji828smU37r8/5a
         sL08QJbW0HK8GrcAR69+e9aXS7fht5YxVMage9yOMkPU4adwY2lIs5JxHEnuf+RERqho
         3ekjVALLGysMsAeMGrAqBJXbt60BqLQ/hF90Vo+y0G1dQcQbXwqxGybUagJUl4hP0CRf
         WfIjseFiQeQsZCT563lwBwPR7ZIsQJcMriUhXc13OsiwTJWwSfWbcGVcVD1mr3A3Rujj
         Q/BQ==
X-Gm-Message-State: AOAM530utfN+ntgcp8dZ4OmFK9QRqdhwcClw/iLF5O9EnWdw2c9Ry16A
        dCS9DE3oYRNxyZ43Vf81UIM=
X-Google-Smtp-Source: ABdhPJxg64OhfNeg3SPkwFspjvNng3EPBytAYddY+HeaipVqK58+wIjn5nlnxkGt0t0+BFGwstD64g==
X-Received: by 2002:a05:6830:2684:: with SMTP id l4mr12166648otu.294.1622318546325;
        Sat, 29 May 2021 13:02:26 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id t39sm1868064ooi.42.2021.05.29.13.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 13:02:25 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v6 13/34] dyndbg: refactor ddebug_alter_site out of ddebug_change
Date:   Sat, 29 May 2021 14:00:08 -0600
Message-Id: <20210529200029.205306-14-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210529200029.205306-1-jim.cromie@gmail.com>
References: <20210529200029.205306-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the JUMP_LABEL/static-key code to a separate function.

no functional changes.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 592aaaf79fd7..ad7cda840733 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -192,6 +192,18 @@ static int ddebug_match_site(const struct ddebug_query *query,
 	return true;
 }
 
+static void ddebug_alter_site(struct _ddebug *dp,
+			      struct flag_settings *modifiers)
+{
+#ifdef CONFIG_JUMP_LABEL
+	if (dp->flags & _DPRINTK_FLAGS_PRINT) {
+		if (!(modifiers->flags & _DPRINTK_FLAGS_PRINT))
+			static_branch_disable(&dp->key.dd_key_true);
+	} else if (modifiers->flags & _DPRINTK_FLAGS_PRINT)
+		static_branch_enable(&dp->key.dd_key_true);
+#endif
+}
+
 /*
  * Search the tables for _ddebug's which match the given `query' and
  * apply the `flags' and `mask' to them.  Returns number of matching
@@ -228,13 +240,9 @@ static int ddebug_change(const struct ddebug_query *query,
 			newflags = (dp->flags & modifiers->mask) | modifiers->flags;
 			if (newflags == dp->flags)
 				continue;
-#ifdef CONFIG_JUMP_LABEL
-			if (dp->flags & _DPRINTK_FLAGS_PRINT) {
-				if (!(modifiers->flags & _DPRINTK_FLAGS_PRINT))
-					static_branch_disable(&dp->key.dd_key_true);
-			} else if (modifiers->flags & _DPRINTK_FLAGS_PRINT)
-				static_branch_enable(&dp->key.dd_key_true);
-#endif
+
+			ddebug_alter_site(dp, modifiers);
+
 			dp->flags = newflags;
 
 			if (dc)
-- 
2.31.1

