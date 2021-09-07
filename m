Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA9C6402A97
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 16:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236655AbhIGOSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 10:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233970AbhIGOSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 10:18:40 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA98EC061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 07:17:34 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id n27so13008798oij.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 07:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=41eOpaggA77QHE2mPAqNRgEMJRJWSV+8azyguMYtpmM=;
        b=EtwIW0igagjseOSzp2URGEilPWeMajVqYIFW0ddiz6c/duZDJeehXvUdAzNVPS7yOE
         seaFsEEJXpwaLbHCWpGGsJJIlrufOmnEd8regUYsoQHTr+5ag/CfCf+LtMbsQ2iWzUr6
         CvSe8W+Mro0dBHANjvzD5d6Z3ZttkEzk1uxBMQum1j4TeJiUl79hy8I6DkkCZfWPus5t
         H7VuHChcUpK6UnnjR8hBspqRb1EmTI5zAjYz02gMM7l51kfJqUMu6G8ib6L+lWZJUb4p
         +GRVDdaEYtyamjicCmfP7OTgeg20pMYkreUD2kfcisY+1DU48XYYl1LjbHAjzbm6prij
         Rcfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=41eOpaggA77QHE2mPAqNRgEMJRJWSV+8azyguMYtpmM=;
        b=NS3QQXLPmLqjkfTf3cIJXIS0I5rSpHwB/ZZGKKlve8TDcMa0O/j3mahiroIqi3UgJT
         HFA4g8qU3Z8m1RCzYIANqLxRMIAl8ob8JR2tNrcDmka4kn59dWEq4UONB67k1EoTtg9h
         Op6uiP2Ih49fV6vGbS1ek4Jqepdx3ET2JQ6yA4LPO9WzLGHnV+aedR6m5syfrXni/OB1
         sElvzEYZ5JdtR/OvEah12IyDlGCBE2R9A0zsuzuT2pnnQGd4SuGRVEhErgnwKjbsmWkE
         FxYzXOqP/3BlF8T4tzyUFxRnIAJOZzEOVlZnuLBPzz6PZUOkdl5Ae4m3i1HJCcN2fIDJ
         QFCg==
X-Gm-Message-State: AOAM531L2TW41lbeKbxpCNPWBa0npcew5Q8VQQL4kH0ULKju568nBcey
        ZuL6mzP281wg/4yQ3St1Ao6ysUWKgOFr+Lk+dwrD2Q==
X-Google-Smtp-Source: ABdhPJw24uKwJ66mYEDoqTBfJL7AR7WbHgTKwv/Kn2XnNEDj4FxfNFwauxvf89B5UPwsmABrzRX9KXpphcFtidc5SIU=
X-Received: by 2002:aca:4589:: with SMTP id s131mr3105616oia.121.1631024253637;
 Tue, 07 Sep 2021 07:17:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210907141307.1437816-1-elver@google.com>
In-Reply-To: <20210907141307.1437816-1-elver@google.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 7 Sep 2021 16:17:21 +0200
Message-ID: <CANpmjNMenewC=wBGOcRv0m=G-i4xjR+_nm2noK5QEkyG_DpnJg@mail.gmail.com>
Subject: Re: [PATCH 0/6] stackdepot, kasan, workqueue: Avoid expanding
 stackdepot slabs when holding raw_spin_lock
To:     elver@google.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Walter Wu <walter-zh.wu@mediatek.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vijayanand Jitta <vjitta@codeaurora.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Aleksandr Nogikh <nogikh@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+Cc: Thomas, Sebastian]

Sorry, forgot to Cc you... :-/

On Tue, 7 Sept 2021 at 16:14, Marco Elver <elver@google.com> wrote:
>
> Shuah Khan reported [1]:
>
>  | When CONFIG_PROVE_RAW_LOCK_NESTING=y and CONFIG_KASAN are enabled,
>  | kasan_record_aux_stack() runs into "BUG: Invalid wait context" when
>  | it tries to allocate memory attempting to acquire spinlock in page
>  | allocation code while holding workqueue pool raw_spinlock.
>  |
>  | There are several instances of this problem when block layer tries
>  | to __queue_work(). Call trace from one of these instances is below:
>  |
>  |     kblockd_mod_delayed_work_on()
>  |       mod_delayed_work_on()
>  |         __queue_delayed_work()
>  |           __queue_work() (rcu_read_lock, raw_spin_lock pool->lock held)
>  |             insert_work()
>  |               kasan_record_aux_stack()
>  |                 kasan_save_stack()
>  |                   stack_depot_save()
>  |                     alloc_pages()
>  |                       __alloc_pages()
>  |                         get_page_from_freelist()
>  |                           rm_queue()
>  |                             rm_queue_pcplist()
>  |                               local_lock_irqsave(&pagesets.lock, flags);
>  |                               [ BUG: Invalid wait context triggered ]
>
> [1] https://lkml.kernel.org/r/20210902200134.25603-1-skhan@linuxfoundation.org
>
> PROVE_RAW_LOCK_NESTING is pointing out that (on RT kernels) the locking
> rules are being violated. More generally, memory is being allocated from
> a non-preemptive context (raw_spin_lock'd c-s) where it is not allowed.
>
> To properly fix this, we must prevent stackdepot from replenishing its
> "stack slab" pool if memory allocations cannot be done in the current
> context: it's a bug to use either GFP_ATOMIC nor GFP_NOWAIT in certain
> non-preemptive contexts, including raw_spin_locks (see gfp.h and
> ab00db216c9c7).
>
> The only downside is that saving a stack trace may fail if: stackdepot
> runs out of space AND the same stack trace has not been recorded before.
> I expect this to be unlikely, and a simple experiment (boot the kernel)
> didn't result in any failure to record stack trace from insert_work().
>
> The series includes a few minor fixes to stackdepot that I noticed in
> preparing the series. It then introduces __stack_depot_save(), which
> exposes the option to force stackdepot to not allocate any memory.
> Finally, KASAN is changed to use the new stackdepot interface and
> provide kasan_record_aux_stack_noalloc(), which is then used by
> workqueue code.
>
> Marco Elver (6):
>   lib/stackdepot: include gfp.h
>   lib/stackdepot: remove unused function argument
>   lib/stackdepot: introduce __stack_depot_save()
>   kasan: common: provide can_alloc in kasan_save_stack()
>   kasan: generic: introduce kasan_record_aux_stack_noalloc()
>   workqueue, kasan: avoid alloc_pages() when recording stack
>
>  include/linux/kasan.h      |  2 ++
>  include/linux/stackdepot.h |  6 +++++
>  kernel/workqueue.c         |  2 +-
>  lib/stackdepot.c           | 51 ++++++++++++++++++++++++++++++--------
>  mm/kasan/common.c          |  6 ++---
>  mm/kasan/generic.c         | 14 +++++++++--
>  mm/kasan/kasan.h           |  2 +-
>  7 files changed, 65 insertions(+), 18 deletions(-)
>
> --
> 2.33.0.153.gba50c8fa24-goog
>
