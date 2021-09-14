Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C17A40AE62
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 14:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbhINM5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 08:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbhINM52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 08:57:28 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B21BC061762
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 05:56:11 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id c19so11261930qte.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 05:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=473xgTZGiwHmobEJ6/SAUPmhRqqxJ35dz9Kf/VHgaaM=;
        b=R7A0fnkxJVpOuOKgRus4AqD4RTf/Qm6ltxgszYDlLTSOdn7rdR9HiDKXPAB8o/HElJ
         9SLmLR5hhgFnc0o/wC1Hom/3v4+6hU5Jaf+rnP9orf7FDGHaVvZ4TZRsqq7znh1pWZr+
         SX/SNki1DCzMXdD4y+q8CewjP6vBqEbeN5EYXEhTeXzbpn7lzCHXPcyp4PWeBDnFqRJM
         Yua5EsTt0BbuEDh8qmmMmEFQT3PmeUcsH9vv5imbDmv+zZK0Qpby1/FIEMqXXvUKdXLv
         p0Ie9v5VD3BxVtevHV63v5pl/b22tuBZWr1oKrz6jR235WrskaFg3Q9D/RB8vs8ncfsY
         Y1sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=473xgTZGiwHmobEJ6/SAUPmhRqqxJ35dz9Kf/VHgaaM=;
        b=79G+CtDsNsypx4YuKCJCMH7YklXrGe9Bj5cHt6QVcCkUA4vsXgpURDnosTi2l0cJ2o
         iPGr4BSEAzhnuotQRcfe8rcfgWjvcPjLUGXfWfQO3CggKCYtvjLBAbHl+kVoTiIqkKCj
         XJf5sw2rH13VooFeHWSqlwMbYU9AhYuG28mEN6TndS0WOUW4rknfcJ6nEx2zeh/A5N0L
         jbmEYD2QnpSGxC4jw17ZJRCsFA/JkGgD2FgtsCXR3S+Te9dtmbdcs7nwfPwrWLKzm6QA
         Sp2lyMS6tSlRW1JtfLU3qT9Q1yI9ItQaV0eSdCH8dod8suoRX2u3fVU2Npbk+xtoGcxl
         Pi2Q==
X-Gm-Message-State: AOAM532PJmjvZ7FDauyU1qDFK0lD+cZbSf0kIznawLfVAn/fwa1mrS3q
        dxwv4In3SAzJ+WlQuEUCkj1CnG8uJOAUyi+cDUFDZg==
X-Google-Smtp-Source: ABdhPJzpwFpScSvyXLb64fpGC8STq+XZ2FvKKDr7h8qDk9CRc5YeUtRYqyuGHayHHqvZfki/vwuAjdSU7GZBSy985T0=
X-Received: by 2002:a05:622a:394:: with SMTP id j20mr4535974qtx.196.1631624169952;
 Tue, 14 Sep 2021 05:56:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210907141307.1437816-1-elver@google.com>
In-Reply-To: <20210907141307.1437816-1-elver@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 14 Sep 2021 14:55:33 +0200
Message-ID: <CAG_fn=U1iSYXmd=Y7mnvAbp5wqu_D6m9VXR6ebJRRzN=VfJcxQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] stackdepot, kasan, workqueue: Avoid expanding
 stackdepot slabs when holding raw_spin_lock
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Walter Wu <walter-zh.wu@mediatek.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 7, 2021 at 4:14 PM Marco Elver <elver@google.com> wrote:
>
> Shuah Khan reported [1]:
>
>  | When CONFIG_PROVE_RAW_LOCK_NESTING=3Dy and CONFIG_KASAN are enabled,
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
>  |           __queue_work() (rcu_read_lock, raw_spin_lock pool->lock held=
)
>  |             insert_work()
>  |               kasan_record_aux_stack()
>  |                 kasan_save_stack()
>  |                   stack_depot_save()
>  |                     alloc_pages()
>  |                       __alloc_pages()
>  |                         get_page_from_freelist()
>  |                           rm_queue()
>  |                             rm_queue_pcplist()
>  |                               local_lock_irqsave(&pagesets.lock, flags=
);
>  |                               [ BUG: Invalid wait context triggered ]
>
> [1] https://lkml.kernel.org/r/20210902200134.25603-1-skhan@linuxfoundatio=
n.org
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

Acked-by: Alexander Potapenko <glider@google.com>

for the whole series.

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


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
