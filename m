Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 040F2342C08
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 12:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbhCTLUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 07:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbhCTLTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 07:19:36 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7DBC061786
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 03:31:38 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id s2so8760890qtx.10
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 03:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sAYxe/MgqUsNqr4f1D0Ygv2g1tYWDuCphwxfFAeX54U=;
        b=MrQOUiPGFHjWPQj30lmCdUbN7/Erh6f65Zl3n9XkeQmOVfUnYVTiAKmMp8MKNdRhkp
         r/nu930lYTAXloV7XwSwOmuMYqUWPv5TstvgNOTtIAX2PRSbgiMrVLKamB7f7okQhE4t
         0uFtUgZDdFaL7aceQauqtAAvea38RsdwOwS8xdQEeYiGm9I/KQVJ8PP9ILMQEbDjmCmC
         yuRbZH7YibQS8ox5a1gOVY622BzqEvdw59RGDDKteutGV3yNyysMnELpprKvXN2DC5pB
         3qB2q0n3UMC8hPBDzfCoscjKpmr/Dwpt8yHk6vebfBSSJ3wTJLcgEPu6w6KTxXdFDJkV
         AaBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sAYxe/MgqUsNqr4f1D0Ygv2g1tYWDuCphwxfFAeX54U=;
        b=MTH5Ygmoyy0eqQibot+1sqPtCZEJNKJCkCPjwxDxYp1u6T47Ri5z0w5Bz++2Y7FaTB
         J7PI5dUXbl9O1DnHQdl438fE761yIDBJLsnxUCgBS27rdBe+Gx1Pa6316rizSrG1zQyN
         /91IxlU66pM/bRr2UIPIpwTnHxJRHewZS/9cQbG17yF3tIRb6VLmI9tUbLLSiZof72xU
         2Eirz9LH61hsZyRgKFTOmqQuMKKsV8foN/vhFLypi7ubSywP3EqpL/B11VANVGdMdt2e
         NVR6XUCMKFKmH9uQ7B4XGjakfK7mDd+bucaWBIyc7e8IEP/6Ey0vrO/8fWGAluQnd9A2
         XdWQ==
X-Gm-Message-State: AOAM532RclBccubiajgiMyFFH6Jnt4XESR6qMqmy9En1bS8wIggvizFL
        sifeF1OapTDtHwgyVicAKDBx6RY+3ksqZ2gaiPaEYRnMpRM=
X-Google-Smtp-Source: ABdhPJwNNSsf44UFPRVuO6KPdICyMV8x8qUYWToGUtnih1jF21ygcTRF9ATkJSlPxLu9JiQiYcM63ftYGV/aRJhrZu8=
X-Received: by 2002:a05:620a:2095:: with SMTP id e21mr2013901qka.265.1616225657617;
 Sat, 20 Mar 2021 00:34:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210208102551.5256-1-penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20210208102551.5256-1-penguin-kernel@I-love.SAKURA.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 20 Mar 2021 08:34:06 +0100
Message-ID: <CACT4Y+YnHFV1p5mbhby2nyOaNTy8c_yoVk86z5avo14KWs0s1A@mail.gmail.com>
Subject: Re: [PATCH v5] lockdep: Allow tuning tracing capacity constants.
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 8, 2021 at 11:29 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Since syzkaller continues various test cases until the kernel crashes,
> syzkaller tends to examine more locking dependencies than normal systems.
> As a result, syzbot is reporting that the fuzz testing was terminated
> due to hitting upper limits lockdep can track [1] [2] [3]. Since analysis
> via /proc/lockdep* did not show any obvious culprit [4] [5], we have no
> choice but allow tuning tracing capacity constants.
>
> [1] https://syzkaller.appspot.com/bug?id=3d97ba93fb3566000c1c59691ea427370d33ea1b
> [2] https://syzkaller.appspot.com/bug?id=381cb436fe60dc03d7fd2a092b46d7f09542a72a
> [3] https://syzkaller.appspot.com/bug?id=a588183ac34c1437fc0785e8f220e88282e5a29f
> [4] https://lkml.kernel.org/r/4b8f7a57-fa20-47bd-48a0-ae35d860f233@i-love.sakura.ne.jp
> [5] https://lkml.kernel.org/r/1c351187-253b-2d49-acaf-4563c63ae7d2@i-love.sakura.ne.jp
>
> Reported-by: syzbot <syzbot+cd0ec5211ac07c18c049@syzkaller.appspotmail.com>
> Reported-by: syzbot <syzbot+91fd909b6e62ebe06131@syzkaller.appspotmail.com>
> Reported-by: syzbot <syzbot+62ebe501c1ce9a91f68c@syzkaller.appspotmail.com>
> References: https://lkml.kernel.org/r/1595640639-9310-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Acked-by: Dmitry Vyukov <dvyukov@google.com>

Peter, ping.
Please at least provide some feedback.
This is still the top crasher on syzbot and harms testing of the whole
kernel. I am periodically thinking of disabling LOCKDEP on syzbot as
harming more than helping, but so far talking myself out of it because
it will likely be broken more when we try to re-enable it and I still
hope for a timely resolution of this issue.


> ---
>  kernel/locking/lockdep.c           |  2 +-
>  kernel/locking/lockdep_internals.h |  8 +++---
>  lib/Kconfig.debug                  | 40 ++++++++++++++++++++++++++++++
>  3 files changed, 45 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index bdaf4829098c..65b3777e8089 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -1391,7 +1391,7 @@ static int add_lock_to_list(struct lock_class *this,
>  /*
>   * For good efficiency of modular, we use power of 2
>   */
> -#define MAX_CIRCULAR_QUEUE_SIZE                4096UL
> +#define MAX_CIRCULAR_QUEUE_SIZE                (1UL << CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS)
>  #define CQ_MASK                                (MAX_CIRCULAR_QUEUE_SIZE-1)
>
>  /*
> diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
> index de49f9e1c11b..ecb8662e7a4e 100644
> --- a/kernel/locking/lockdep_internals.h
> +++ b/kernel/locking/lockdep_internals.h
> @@ -99,16 +99,16 @@ static const unsigned long LOCKF_USED_IN_IRQ_READ =
>  #define MAX_STACK_TRACE_ENTRIES        262144UL
>  #define STACK_TRACE_HASH_SIZE  8192
>  #else
> -#define MAX_LOCKDEP_ENTRIES    32768UL
> +#define MAX_LOCKDEP_ENTRIES    (1UL << CONFIG_LOCKDEP_BITS)
>
> -#define MAX_LOCKDEP_CHAINS_BITS        16
> +#define MAX_LOCKDEP_CHAINS_BITS        CONFIG_LOCKDEP_CHAINS_BITS
>
>  /*
>   * Stack-trace: tightly packed array of stack backtrace
>   * addresses. Protected by the hash_lock.
>   */
> -#define MAX_STACK_TRACE_ENTRIES        524288UL
> -#define STACK_TRACE_HASH_SIZE  16384
> +#define MAX_STACK_TRACE_ENTRIES        (1UL << CONFIG_LOCKDEP_STACK_TRACE_BITS)
> +#define STACK_TRACE_HASH_SIZE  (1 << CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS)
>  #endif
>
>  /*
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 7937265ef879..4cb84b499636 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1332,6 +1332,46 @@ config LOCKDEP
>  config LOCKDEP_SMALL
>         bool
>
> +config LOCKDEP_BITS
> +       int "Bitsize for MAX_LOCKDEP_ENTRIES"
> +       depends on LOCKDEP && !LOCKDEP_SMALL
> +       range 10 30
> +       default 15
> +       help
> +         Try increasing this value if you hit "BUG: MAX_LOCKDEP_ENTRIES too low!" message.
> +
> +config LOCKDEP_CHAINS_BITS
> +       int "Bitsize for MAX_LOCKDEP_CHAINS"
> +       depends on LOCKDEP && !LOCKDEP_SMALL
> +       range 10 30
> +       default 16
> +       help
> +         Try increasing this value if you hit "BUG: MAX_LOCKDEP_CHAINS too low!" message.
> +
> +config LOCKDEP_STACK_TRACE_BITS
> +       int "Bitsize for MAX_STACK_TRACE_ENTRIES"
> +       depends on LOCKDEP && !LOCKDEP_SMALL
> +       range 10 30
> +       default 19
> +       help
> +         Try increasing this value if you hit "BUG: MAX_STACK_TRACE_ENTRIES too low!" message.
> +
> +config LOCKDEP_STACK_TRACE_HASH_BITS
> +       int "Bitsize for STACK_TRACE_HASH_SIZE"
> +       depends on LOCKDEP && !LOCKDEP_SMALL
> +       range 10 30
> +       default 14
> +       help
> +         Try increasing this value if you need large MAX_STACK_TRACE_ENTRIES.
> +
> +config LOCKDEP_CIRCULAR_QUEUE_BITS
> +       int "Bitsize for elements in circular_queue struct"
> +       depends on LOCKDEP
> +       range 10 30
> +       default 12
> +       help
> +         Try increasing this value if you hit "lockdep bfs error:-1" warning due to __cq_enqueue() failure.
> +
>  config DEBUG_LOCKDEP
>         bool "Lock dependency engine debugging"
>         depends on DEBUG_KERNEL && LOCKDEP
> --
> 2.18.4
>
