Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40F573E44C7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 13:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235213AbhHIL0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 07:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235195AbhHIL0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 07:26:08 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E5EC0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 04:25:48 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id j21-20020a25d2150000b029057ac4b4e78fso16761598ybg.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 04:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=N38MLkGU4ZaJtqmGfMRepocDJIz/MIPtNTpAOH3Apps=;
        b=vHWSpBBw9ABGw5wb7zf2yqlHlhYs468lfyb1p+NOpl1EhHrJ8q8ds4sl83n1vwVd3x
         YrxCl1KW7HDS0pj8QH5yJ2trL/UQ5TkO567UxPnC9UskPoUQdNP5Yx+CI7+fgmnj1boH
         D0UHh4XFWj9sq1WzMjbJXiLwIrskyn1ZFLfIl5MIC19plIVpW0mEy7hgIrfn9aztgUAE
         YvJ8RjZnfcnPyKrl9kHwPVnMipHA1eGQ/2wPQpOtD5fRMn3DJ6EwebZ/jPH9LArWcsMi
         RdJp2GDhL3dVX25G/U1Z9LEqpWdM5QKunTPr6no4y5rdi5Kc6sB2E7Nw6zNNDX3RN5wx
         55XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=N38MLkGU4ZaJtqmGfMRepocDJIz/MIPtNTpAOH3Apps=;
        b=VrLdiS9R+DPNkWLLokgeBVUijBpwE2FUZJIBLrnq+hCIhmGYz1qZms+p+Z5YEzImC5
         WOtevz8eOLBXBeNoUFfLdFfrDjuT8jZyGxeUDeMPrsy/NTEYOSBLpN0PDdsM/I5YQh0s
         4zILoRoBgSsLrgUxC2CO7zCCtmELNMdXKbp3JcnaZY5Z+zDUqYRAdcQpdhjd+BAwhZ0a
         TwdKRROXoKb9tSCG+ZxQhscng7tlrl6QMMwIYa+dGXC842WT2iSAPNuvrYNCCJF2SMlu
         AurZG+AJZV22dQSasm3H5OR5Z9vwvB4DGZBG6rZq13R/zU0WaxmYSkiyHfyQBORj2NAB
         qnsA==
X-Gm-Message-State: AOAM533Fld5tJrTP/1yo0JQZMllijFW3BcIRyErP/RS+zbBMHgRBYBD1
        +djbwOOgCiYcX41yVqbukrLy3dt02g==
X-Google-Smtp-Source: ABdhPJxI8M5tQOSpi1hjMlW1FRiHmCqyzUg2hDAgr9fBGjU7/5bH+FIl1QsF1IT+QppY/jE6BaXZO6AGrQ==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:e5a3:e652:2b8b:ef12])
 (user=elver job=sendgmr) by 2002:a25:f310:: with SMTP id c16mr28780799ybs.464.1628508347795;
 Mon, 09 Aug 2021 04:25:47 -0700 (PDT)
Date:   Mon,  9 Aug 2021 13:25:13 +0200
In-Reply-To: <20210809112516.682816-1-elver@google.com>
Message-Id: <20210809112516.682816-6-elver@google.com>
Mime-Version: 1.0
References: <20210809112516.682816-1-elver@google.com>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
Subject: [PATCH 5/8] kcsan: Save instruction pointer for scoped accesses
From:   Marco Elver <elver@google.com>
To:     elver@google.com, paulmck@kernel.org
Cc:     mark.rutland@arm.com, dvyukov@google.com, glider@google.com,
        boqun.feng@gmail.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Save the instruction pointer for scoped accesses, so that it becomes
possible for the reporting code to construct more accurate stack traces
that will show the start of the scope.

Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/kcsan-checks.h |  3 +++
 kernel/kcsan/core.c          | 12 +++++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/include/linux/kcsan-checks.h b/include/linux/kcsan-checks.h
index 9fd0ad80fef6..5f5965246877 100644
--- a/include/linux/kcsan-checks.h
+++ b/include/linux/kcsan-checks.h
@@ -100,9 +100,12 @@ void kcsan_set_access_mask(unsigned long mask);
 /* Scoped access information. */
 struct kcsan_scoped_access {
 	struct list_head list;
+	/* Access information. */
 	const volatile void *ptr;
 	size_t size;
 	int type;
+	/* Location where scoped access was set up. */
+	unsigned long ip;
 };
 /*
  * Automatically call kcsan_end_scoped_access() when kcsan_scoped_access goes
diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index bffd1d95addb..8b20af541776 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -202,6 +202,9 @@ static __always_inline struct kcsan_ctx *get_ctx(void)
 	return in_task() ? &current->kcsan_ctx : raw_cpu_ptr(&kcsan_cpu_ctx);
 }
 
+static __always_inline void
+check_access(const volatile void *ptr, size_t size, int type, unsigned long ip);
+
 /* Check scoped accesses; never inline because this is a slow-path! */
 static noinline void kcsan_check_scoped_accesses(void)
 {
@@ -210,8 +213,10 @@ static noinline void kcsan_check_scoped_accesses(void)
 	struct kcsan_scoped_access *scoped_access;
 
 	ctx->scoped_accesses.prev = NULL;  /* Avoid recursion. */
-	list_for_each_entry(scoped_access, &ctx->scoped_accesses, list)
-		__kcsan_check_access(scoped_access->ptr, scoped_access->size, scoped_access->type);
+	list_for_each_entry(scoped_access, &ctx->scoped_accesses, list) {
+		check_access(scoped_access->ptr, scoped_access->size,
+			     scoped_access->type, scoped_access->ip);
+	}
 	ctx->scoped_accesses.prev = prev_save;
 }
 
@@ -767,6 +772,7 @@ kcsan_begin_scoped_access(const volatile void *ptr, size_t size, int type,
 	sa->ptr = ptr;
 	sa->size = size;
 	sa->type = type;
+	sa->ip = _RET_IP_;
 
 	if (!ctx->scoped_accesses.prev) /* Lazy initialize list head. */
 		INIT_LIST_HEAD(&ctx->scoped_accesses);
@@ -798,7 +804,7 @@ void kcsan_end_scoped_access(struct kcsan_scoped_access *sa)
 
 	ctx->disable_count--;
 
-	__kcsan_check_access(sa->ptr, sa->size, sa->type);
+	check_access(sa->ptr, sa->size, sa->type, sa->ip);
 }
 EXPORT_SYMBOL(kcsan_end_scoped_access);
 
-- 
2.32.0.605.g8dce9f2422-goog

