Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D454B42032B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 19:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbhJCRzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 13:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbhJCRzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 13:55:12 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F3CC0613EC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Oct 2021 10:53:25 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id y15so15931820ilu.12
        for <linux-kernel@vger.kernel.org>; Sun, 03 Oct 2021 10:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oeR+JF91jA1RQ/aOGCMv9JGlVQuVQcLbc+E39kT+rCw=;
        b=Oz0X13K4A5Wxv8TSwZFvrtgoZI8c1LLizlUsK5uGBqeK+lZRI6TeimzkkrpM0Cv6A0
         iz2hkBIW81q8lafmBy/39tXCCJDcXwa+cPmhWUk18g+ylhaNxXluF6bJzBy2jftvcBOt
         zs03g6CPTdDPDPeWzvVdmNaqOJtm+ECWep4sEtwmZr59hNKhZhVddVsiSGNLpbY4XPHi
         OIudMIGF7UqmTMgpzCUZpzpB2OEbCBEwSsXKtEhRt2I+xPhLX+Vrikuz7ZT6eWw1lUm7
         cksRa1KUS617K17wBYKmn1JUJ0gMWXH2O6NI50db6y94E281nr2TnhWqqAcBpCdvVU1U
         afUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oeR+JF91jA1RQ/aOGCMv9JGlVQuVQcLbc+E39kT+rCw=;
        b=jhF6/9b8Eg2JxeaIYiLbobDqqBAe2P4rCaxZU9s/coUCXroiO70kxp2ZPj8ei4QJQa
         cKO2EHmufix56ElDXtEG4u5pmmCcc3ZII3pxmuRYLP5EtKofBpCkNp5iIfX1emfD/bcV
         tz91jnsm0E+Fi0WNsb0iZDOqSkTZsSFFzCpG/1huiwwSf8AQTlI91r5YrKbROrr/6xmC
         +4KhnQeO4qZyiKHRMHlsLVx72qnyZhXyUDl2pgjVHMuzpzsLtexucZU1Y3mlD7ziFU6t
         YKHJXMNndd6ueKltxY855E+vIfS9f/q6nne+AjuQXcoeSu2wJ6yR/El0S7fgPWBNcUMW
         wvGg==
X-Gm-Message-State: AOAM533FqSjwoBKILNItmkNTkWoAdsuzXKh4ZEW4FGSAvZFNQeS1N+WA
        z8X6BDZGD+hQEiY/2pNF2r+LN5ER10HC7dDi4nI=
X-Google-Smtp-Source: ABdhPJx7lXt8UfdmzGB8wlRlWLvNEmXlmAbJHZpefNkY7xPuzVioB7oF5+VJLw+C1z2ZfelfEM3quw05Y87cASXBVTI=
X-Received: by 2002:a05:6e02:bf1:: with SMTP id d17mr2423631ilu.81.1633283604964;
 Sun, 03 Oct 2021 10:53:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210913112609.2651084-1-elver@google.com>
In-Reply-To: <20210913112609.2651084-1-elver@google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Sun, 3 Oct 2021 19:53:14 +0200
Message-ID: <CA+fCnZdvSmTguF_uKQTHgQK=QZhx7RHF-j_YaRGSPHvvqEU2cw@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] stackdepot, kasan, workqueue: Avoid expanding
 stackdepot slabs when holding raw_spin_lock
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Walter Wu <walter-zh.wu@mediatek.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vijayanand Jitta <vjitta@codeaurora.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Aleksandr Nogikh <nogikh@google.com>,
        Taras Madan <tarasmadan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 1:26 PM Marco Elver <elver@google.com> wrote:
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
> [1] https://lkml.kernel.org/r/20210902200134.25603-1-skhan@linuxfoundation.org
>
> v2:
> * Refer to __stack_depot_save() in comment of stack_depot_save().
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
>  lib/stackdepot.c           | 52 ++++++++++++++++++++++++++++++--------
>  mm/kasan/common.c          |  6 ++---
>  mm/kasan/generic.c         | 14 ++++++++--
>  mm/kasan/kasan.h           |  2 +-
>  7 files changed, 66 insertions(+), 18 deletions(-)
>
> --
> 2.33.0.309.g3052b89438-goog
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

for the series.
