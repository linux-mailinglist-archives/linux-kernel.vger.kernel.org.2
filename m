Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8A3D33CCF0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 06:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235278AbhCPFJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 01:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235196AbhCPFIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 01:08:30 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0851EC06175F
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 22:08:30 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id b5so11528921ilq.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 22:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0l3a9Uzu/ZRgWPegPcgX+r7C1XlHwt5hH3uR9JYCAhU=;
        b=GKcRVDCmsyXRAn4KH3qJDUjjzRPCTC4qwUi817VOVcVKbgG+FDUg8tekaG6OqsBams
         LOV9FMDOSSJ2TdsgpzsU7kKG5bzoOQ6LhsGM9wWZO9XQutYNQzvuwrnUu9zUqkMZBwnh
         1mAZfhggKGx22G6Dj30Ql4zLTUcwZMeFts/RSOxj8JdIswx7PsT5z+86kkU28Jm5SdG+
         Ap7E4LEZTHpI5ubOzpZXGBbIrNiB9pREnrqV1wB3IT6Y6EJ4Bn+2M5zOB0lp0p0m3sYj
         SyO9Tpm7oJA75JssNo/1HaH9QnUa7Qn1qdChzCjvkgHkuI/YMCn9mQgg+i+IatD8Xcv6
         sgRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0l3a9Uzu/ZRgWPegPcgX+r7C1XlHwt5hH3uR9JYCAhU=;
        b=neE4oCy5Zszs/UhglXgeiE7MTGHm2CrF6/+O/Y3j62cGrcoeI+PaSjjnzwfnUXdKZT
         syDQvGfgiKUpaEWZos1YdvG5ZPdz83GFA7yP/Iu4wfeq8yjGzY+lOh6uZyCfPSykDwaD
         ExdBsj+Zq725uy3uQypJH5gelqmh0+zc+9mHXwOLXGlHUjP4V1hWnjXoJw1vXVDcXFS6
         sOg/84TQY+NJI5etW6F4JontDPwNyTU1hwaDKp2iMwZ5pFtcA2vKVeORW2+ZwyKr+qvN
         zhdA/jYThlE2M7Q+lZTCpp4lmfFIu93FHUhBDbyuoanTbftqB+8OFr+MSoYrn3LrRpHP
         W37w==
X-Gm-Message-State: AOAM532HFqH+f0AgaTkDxKqSBsxtAS6h6wcuL/tF8emROVB+QM7DUT7f
        GSR5eRS4XWiI3GuqnKW5cLGZwaHBiY6CTQ==
X-Google-Smtp-Source: ABdhPJx9+XfZxZXHyAxsUsFPfyOANzrv+ANJYXle/JWsgRniRlrFj1EAWpaeJ4b0Y8QfOZ7nQBbwCA==
X-Received: by 2002:a92:d80f:: with SMTP id y15mr2281194ilm.96.1615871309534;
        Mon, 15 Mar 2021 22:08:29 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id y9sm8587469ill.15.2021.03.15.22.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 22:08:29 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v3 11/18] dyndbg: refactor ddebug_alter_site out of ddebug_change
Date:   Mon, 15 Mar 2021 23:07:54 -0600
Message-Id: <20210316050801.2446401-12-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210316050801.2446401-1-jim.cromie@gmail.com>
References: <20210316050801.2446401-1-jim.cromie@gmail.com>
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
index 2d011ac3308d..6fbd9099c2fa 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -191,6 +191,18 @@ static int ddebug_match_site(const struct ddebug_query *query,
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
@@ -227,13 +239,9 @@ static int ddebug_change(const struct ddebug_query *query,
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
2.29.2

