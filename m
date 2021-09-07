Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F311402A80
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 16:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235851AbhIGOPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 10:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233945AbhIGOPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 10:15:08 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D57EC061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 07:14:02 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id c20-20020a05622a059400b002a0bb6f8d84so12818401qtb.15
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 07:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=G9h0FcdPN7QTl0SnF2a3SazYP80XeLyqs+enOhlxDM0=;
        b=oOD572sLnXhVe7QgHu+KQer3JbHzc+LF3jzbIc6wUu3Sx3mScoDJUYuplStwzHfZkh
         6XzOfJA0dLRGgZtzm1dUj72473EonzHRboLP08B3iJdeRMwVP3k8Wj5ax5koBQakFdyX
         7pBm3mnVhEP6JdcIs3ypz72iIJD9gHNGwFPo7VPUoKBsIwM5hjKNQ57Oo1OpLFj5o+iV
         nv3Fc8dtJOw+UtyJiDmvrbcXstZGyJAMfFnXg+ZFUjplM7mdnu7kNoByGu4cY/aLTda1
         ajIhMfTn+7bSnZ+h6twkxVagx2H4M2bq1i3qVjrpOOLdAbJ1/0kaUKs+xkbfb/XDp3VS
         Vt2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=G9h0FcdPN7QTl0SnF2a3SazYP80XeLyqs+enOhlxDM0=;
        b=IJNVHgznbcjVWvDf5NRCjtPCD5qpMNMRwZrROqa3XoFbh9/ZKD7l87gqwjlsrcKoKZ
         auggu6I4E5+J5FmykGGUBMsopZny16G21sdPIzjwOVuV1B6raIIBmQLE3SNMzIUE91Zg
         gP9/U1cHzwmCYFAEj/AVP14PtOnNec35zApfLP5iJJk5PmGDqNpfGEqI0hmFtTdJUA+g
         DycKeNMrk40xjUJZRddEa2ZFxCNMFg+JsQmBgvSpufpROaCkbiBLV93Qkw3ESiyKR1js
         bHd2g/6ida0n12VbtnX2fCFVI7Nltr35LGZrWtwvMBJ20+1WN7Z0iw2mJPtJcRFoalVT
         LeTQ==
X-Gm-Message-State: AOAM530kNaJLVHw5hwFCaJm4PuXqqp26mssO5JlTxt12f5nO1Fh+rDrZ
        XUD40dDxzYNzycxtfuJ4HhjlQ8XixA==
X-Google-Smtp-Source: ABdhPJxc7oYPLHdGXrX4znzakcQKYmQM5QuhChGNkqrwNZoyRG5J0ql1yMnSwvUZSSFWUDlULeUgjiJRPg==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:6800:c1ea:4271:5898])
 (user=elver job=sendgmr) by 2002:ad4:4e86:: with SMTP id dy6mr17251813qvb.30.1631024041249;
 Tue, 07 Sep 2021 07:14:01 -0700 (PDT)
Date:   Tue,  7 Sep 2021 16:13:01 +0200
Message-Id: <20210907141307.1437816-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
Subject: [PATCH 0/6] stackdepot, kasan, workqueue: Avoid expanding stackdepot
 slabs when holding raw_spin_lock
From:   Marco Elver <elver@google.com>
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
        Taras Madan <tarasmadan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shuah Khan reported [1]:

 | When CONFIG_PROVE_RAW_LOCK_NESTING=y and CONFIG_KASAN are enabled,
 | kasan_record_aux_stack() runs into "BUG: Invalid wait context" when
 | it tries to allocate memory attempting to acquire spinlock in page
 | allocation code while holding workqueue pool raw_spinlock.
 |
 | There are several instances of this problem when block layer tries
 | to __queue_work(). Call trace from one of these instances is below:
 |
 |     kblockd_mod_delayed_work_on()
 |       mod_delayed_work_on()
 |         __queue_delayed_work()
 |           __queue_work() (rcu_read_lock, raw_spin_lock pool->lock held)
 |             insert_work()
 |               kasan_record_aux_stack()
 |                 kasan_save_stack()
 |                   stack_depot_save()
 |                     alloc_pages()
 |                       __alloc_pages()
 |                         get_page_from_freelist()
 |                           rm_queue()
 |                             rm_queue_pcplist()
 |                               local_lock_irqsave(&pagesets.lock, flags);
 |                               [ BUG: Invalid wait context triggered ]

[1] https://lkml.kernel.org/r/20210902200134.25603-1-skhan@linuxfoundation.org

PROVE_RAW_LOCK_NESTING is pointing out that (on RT kernels) the locking
rules are being violated. More generally, memory is being allocated from
a non-preemptive context (raw_spin_lock'd c-s) where it is not allowed.

To properly fix this, we must prevent stackdepot from replenishing its
"stack slab" pool if memory allocations cannot be done in the current
context: it's a bug to use either GFP_ATOMIC nor GFP_NOWAIT in certain
non-preemptive contexts, including raw_spin_locks (see gfp.h and
ab00db216c9c7).

The only downside is that saving a stack trace may fail if: stackdepot
runs out of space AND the same stack trace has not been recorded before.
I expect this to be unlikely, and a simple experiment (boot the kernel)
didn't result in any failure to record stack trace from insert_work().

The series includes a few minor fixes to stackdepot that I noticed in
preparing the series. It then introduces __stack_depot_save(), which
exposes the option to force stackdepot to not allocate any memory.
Finally, KASAN is changed to use the new stackdepot interface and
provide kasan_record_aux_stack_noalloc(), which is then used by
workqueue code.

Marco Elver (6):
  lib/stackdepot: include gfp.h
  lib/stackdepot: remove unused function argument
  lib/stackdepot: introduce __stack_depot_save()
  kasan: common: provide can_alloc in kasan_save_stack()
  kasan: generic: introduce kasan_record_aux_stack_noalloc()
  workqueue, kasan: avoid alloc_pages() when recording stack

 include/linux/kasan.h      |  2 ++
 include/linux/stackdepot.h |  6 +++++
 kernel/workqueue.c         |  2 +-
 lib/stackdepot.c           | 51 ++++++++++++++++++++++++++++++--------
 mm/kasan/common.c          |  6 ++---
 mm/kasan/generic.c         | 14 +++++++++--
 mm/kasan/kasan.h           |  2 +-
 7 files changed, 65 insertions(+), 18 deletions(-)

-- 
2.33.0.153.gba50c8fa24-goog

