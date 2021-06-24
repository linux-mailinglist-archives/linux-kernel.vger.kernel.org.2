Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D638A3B2867
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 09:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbhFXHPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 03:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbhFXHPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 03:15:34 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C363CC061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 00:13:08 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id a5-20020a7bc1c50000b02901e3bbe0939bso2933385wmj.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 00:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=MnThaWIKUm3/QjBSHS8iUnI7ZibIjMrulezFRHkYekY=;
        b=XoNOwq52RUGfP8DK5R6bOVIY69XuEooINPTnQOKIffhM+dmXSvqXvLYUOP9HZDuwrN
         5ReZ91fYeBJAlZtzjI/IQ4L3QWYLYdBT6+nhhRkpDwryAIU3UqY3xhyLy0l4kONMK2+X
         VzdSTAhaQBtCSyeht7e61/IOP6JSq8R+yYRdY/KqoD3InE9PKAB9Jb6x8WzQ1HSP5mce
         sV0kJ/l4oEOnLXZzLupJzxtetigk+jDy9lpoLs7uSfVPvneqHcsXrtFP6l9Ny3kpwZBx
         89VYkAn2w0gRwHXk+nrH1P/fZKVEv75fDKLJ4Qdwj8pa9/L+7bbP28AxEc1ooAV8MjPb
         x03w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=MnThaWIKUm3/QjBSHS8iUnI7ZibIjMrulezFRHkYekY=;
        b=kQuRKD5hZ9y9UXx7p75ywJEp9oJZrNjsOi3TLwcWVLnaBR4BRFpB2w6R5DuxDsMY72
         S7cuj0YOUX9PHIO6E7b6cS2wbR+K0zOn4Qd25H0Xk45NevPIBH+pRW1ZWFK30BoQwEZH
         Ww6rE5cHINYTyl+FfSJBN2kHdiilgjQuAAt1yw6H2GejcwsjD6Nzglyo9R/E4w9L3EFt
         hZ4NS/zd1RymdPk1EOggP9UmpEwLBKt/ERWpKOBo7kpd9FS5ZIUjMSXwGDM9Q93m88OK
         Dj6XZ0BcWM4oWXQJaX3Bo6R/nPP2/+2GxOsIa3GELIHe6guKCBfL+YQ9Fo65v9Ihd1v5
         8L9A==
X-Gm-Message-State: AOAM530/tahDqBNLKHVLVFj4qMdWnsHrnM2Pidm9UBM5zX6k1404lQiy
        Q4KSaRg54S9IEdFi7HBB0p0=
X-Google-Smtp-Source: ABdhPJzkFx174lRQ0tjjNb0RYTQcnazCmqre2SDyhkII/0SW/4h/FnF1ZEVAI8nChIXS+vkfHE+9/Q==
X-Received: by 2002:a7b:ca48:: with SMTP id m8mr2466474wml.75.1624518787299;
        Thu, 24 Jun 2021 00:13:07 -0700 (PDT)
Received: from gmail.com (0526E2ED.dsl.pool.telekom.hu. [5.38.226.237])
        by smtp.gmail.com with ESMTPSA id s62sm8009109wms.13.2021.06.24.00.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 00:13:06 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 24 Jun 2021 09:13:05 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] sigqueue cache fix
Message-ID: <YNQwgTR3n3mSO9+3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest core/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-2021-06-24

   # HEAD: 399f8dd9a866e107639eabd3c1979cd526ca3a98 signal: Prevent sigqueue caching after task got released

Fix a memory leak in the recently introduced sigqueue cache.

 Thanks,

	Ingo

------------------>
Thomas Gleixner (1):
      signal: Prevent sigqueue caching after task got released


 kernel/signal.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index f7c6ffcbd044..f1ecd8f0c11d 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -435,6 +435,12 @@ __sigqueue_alloc(int sig, struct task_struct *t, gfp_t gfp_flags,
 		 * Preallocation does not hold sighand::siglock so it can't
 		 * use the cache. The lockless caching requires that only
 		 * one consumer and only one producer run at a time.
+		 *
+		 * For the regular allocation case it is sufficient to
+		 * check @q for NULL because this code can only be called
+		 * if the target task @t has not been reaped yet; which
+		 * means this code can never observe the error pointer which is
+		 * written to @t->sigqueue_cache in exit_task_sigqueue_cache().
 		 */
 		q = READ_ONCE(t->sigqueue_cache);
 		if (!q || sigqueue_flags)
@@ -463,13 +469,18 @@ void exit_task_sigqueue_cache(struct task_struct *tsk)
 	struct sigqueue *q = tsk->sigqueue_cache;
 
 	if (q) {
-		tsk->sigqueue_cache = NULL;
 		/*
 		 * Hand it back to the cache as the task might
 		 * be self reaping which would leak the object.
 		 */
 		 kmem_cache_free(sigqueue_cachep, q);
 	}
+
+	/*
+	 * Set an error pointer to ensure that @tsk will not cache a
+	 * sigqueue when it is reaping it's child tasks
+	 */
+	tsk->sigqueue_cache = ERR_PTR(-1);
 }
 
 static void sigqueue_cache_or_free(struct sigqueue *q)
@@ -481,6 +492,10 @@ static void sigqueue_cache_or_free(struct sigqueue *q)
 	 * is intentional when run without holding current->sighand->siglock,
 	 * which is fine as current obviously cannot run __sigqueue_free()
 	 * concurrently.
+	 *
+	 * The NULL check is safe even if current has been reaped already,
+	 * in which case exit_task_sigqueue_cache() wrote an error pointer
+	 * into current->sigqueue_cache.
 	 */
 	if (!READ_ONCE(current->sigqueue_cache))
 		WRITE_ONCE(current->sigqueue_cache, q);
