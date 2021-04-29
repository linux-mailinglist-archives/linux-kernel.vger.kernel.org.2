Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 640B836EF6E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 20:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241064AbhD2SZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 14:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233338AbhD2SZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 14:25:19 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299A7C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 11:24:32 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id x20so76008980lfu.6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 11:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ykWrXGycxSeYLE6z1WE0zVh/XXJJOlGXtFhHyus2kiU=;
        b=DXTovYi6u/rI4R6PUosmg+OSoth6e+DYO//fTTMJJQoT3qBj/rN3BitqhpxxjTzXNU
         /tJJsiKvrSYFQcbZPsgc5UVeFdvS3hezgrvlWe4wn/C5pucaV2p0tbXGRAu91LKcg9PY
         7T01WkxzoIyUen9+PE2kIYtVl5R77vMTtQrKJ2AMliqIc8aRy837DomZpLwncprSZwC4
         xeBEde2jOulktL1a5VqUWTUiEFIavDywzFBUJdKR6VzBt0LwOF0mU9eDRkTLmrgBqkRl
         wdzrma8nJpYv0Xe3tyX/luekMqSA8eyjJorGd0DbSMjEpmOgCdcj3EDZQ5p5ISVbZsXJ
         VvHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ykWrXGycxSeYLE6z1WE0zVh/XXJJOlGXtFhHyus2kiU=;
        b=CF9bO8xIDNBUThZZxJUHB3ZkRp4JXEXc/BkDiMiDTNN/4VXR2W5lqoc4YOScB68A69
         wZC0yuOAco9usWFO1jaqg2s+n3fxEIci7YlEQrQmHCjQyq0IZ01GBQmk5IJDzv6Y6FDJ
         rr3B6YG+ZkTnqSCroJ9698oQcGvkixUu3p1ZJFiO/Z62Y6tw5eI8GhzXTMLiaWJ7W5tQ
         npGlNTLOY+UsvvHjM5gyzBbH66yqOSt6HtTAEXf4kMn8cKPJ3E8ZZlmdoGIBKxQc/d7V
         etHV+OPXEOos0u1yzRRhO6K911cEwEr8ZOLp5/iVGKaAEBRBqOonX3ss1bj2ZaejG9fn
         Zzmw==
X-Gm-Message-State: AOAM530QkfKkwaDlduAHe79GKdDjcMHtyGJ/qVRYaoxph49Hp+w4Nqsd
        21/dfR2AmWTQEvFM06otWQM9Wj3PoQKDyGqw98z3rg==
X-Google-Smtp-Source: ABdhPJzj7RNt80aN/ZcabS0fIh0N0udJkgfrCyqYCYUL9n+FWsnH8uqslrJ2S63RqPuA7jawo+dAFFEpcgFq+6VgNz8=
X-Received: by 2002:a05:6512:94d:: with SMTP id u13mr588562lft.368.1619720668888;
 Thu, 29 Apr 2021 11:24:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210429150940.3256656-1-arnd@kernel.org> <20210429181716.2409874-1-ndesaulniers@google.com>
In-Reply-To: <20210429181716.2409874-1-ndesaulniers@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 29 Apr 2021 11:24:18 -0700
Message-ID: <CAKwvOd=5sLHssCf0Umfh+E__TjSwpxtO9K2MYVcXEhxvVp8okw@mail.gmail.com>
Subject: Re: [PATCH] smp: fix smp_call_function_single_async prototype
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>,
        Borislav Petkov <bp@suse.de>, eric.dumazet@gmail.com,
        Juergen Gross <jgross@suse.com>, Jian Cai <jiancai@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, ying.huang@intel.com,
        Nathan Chancellor <nathan@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 11:17 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> (replying manually to
> https://lore.kernel.org/lkml/20210429150940.3256656-1-arnd@kernel.org/)
>
> Thanks for the patch; with this applied I observe the following new warnings
> though (for x86_64 defconfig; make LLVM=1 LLVM_IAS=1 -j72)
>
> kernel/smp.c:515:19: warning: passing 8-byte aligned argument to 32-byte
> aligned parameter 1 of 'csd_lock_record' may result in an unaligned pointer
> access [-Walign-mismatch]
>                 csd_lock_record(csd);
>                                 ^
> kernel/smp.c:516:14: warning: passing 8-byte aligned argument to 32-byte
> aligned parameter 1 of 'csd_unlock' may result in an unaligned pointer access
> [-Walign-mismatch]
>                 csd_unlock(csd);
>                            ^
> kernel/smp.c:525:14: warning: passing 8-byte aligned argument to 32-byte
> aligned parameter 1 of 'csd_unlock' may result in an unaligned pointer access
> [-Walign-mismatch]
>                 csd_unlock(csd);
>                            ^

Perhaps roll this into a v2?

diff --git a/kernel/smp.c b/kernel/smp.c
index 1ec771d9f91c..499be1eb5189 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -226,7 +226,7 @@ static void __csd_lock_record(call_single_data_t *csd)
                  /* Or before unlock, as the case may be. */
 }

-static __always_inline void csd_lock_record(call_single_data_t *csd)
+static __always_inline void csd_lock_record(struct __call_single_data *csd)
 {
        if (static_branch_unlikely(&csdlock_debug_enabled))
                __csd_lock_record(csd);
@@ -431,7 +431,7 @@ static void __smp_call_single_queue_debug(int cpu,
struct llist_node *node)
 #else
 #define cfd_seq_store(var, src, dst, type)

-static void csd_lock_record(call_single_data_t *csd)
+static void csd_lock_record(struct __call_single_data *csd)
 {
 }

@@ -454,7 +454,7 @@ static __always_inline void
csd_lock(call_single_data_t *csd)
        smp_wmb();
 }

-static __always_inline void csd_unlock(call_single_data_t *csd)
+static __always_inline void csd_unlock(struct __call_single_data *csd)
 {
        WARN_ON(!(csd->node.u_flags & CSD_FLAG_LOCK));

-- 
Thanks,
~Nick Desaulniers
