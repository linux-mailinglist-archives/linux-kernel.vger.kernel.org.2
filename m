Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84A9E408A14
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 13:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239539AbhIML1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 07:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238684AbhIML1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 07:27:43 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82F2C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 04:26:27 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id k12-20020a05620a0b8c00b003d5c8646ec2so40845673qkh.20
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 04:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=8KTa3rnV38d0tCc/yNW+Mi1KFOkW66QAmkHuLxBgoOM=;
        b=QWAgyJAQpJzNm5NuzRZJ4nva8ZwJE6qjRgzxuHti+h2Zs4h4x56WAPN1va1TWGPAlA
         jg5piwUjTa+sxMkJ4mEguHKyhonRMnhJaSDiLMzqtuCcnxQu/Oo2OJY2dIhm8IIVZvlT
         vHIcVXuZXJ23ngDwcfi+RTpr0zkFGgfIVRecT7UH0T8e/t8a1muw8RGomMA02LuCD4Uv
         x1+2DYdJyMhd9OMktC2PCDjEZ5TG4hOoLOQd5z1yythtLGkPQeoqU3pgD0SZHdcbaZnW
         6wtIZqHXE6VtFaihHtpnAGIf2jg5Tc25/sIV+HdHucMzBiGLUsmo080snPVKZX2DEun2
         dEAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=8KTa3rnV38d0tCc/yNW+Mi1KFOkW66QAmkHuLxBgoOM=;
        b=ebOmzj++l1FiXXu4eM3DE3BERm0pZ5pslJ0ysQorfu5iWPdO6OEvigrdu1PdqSJtIJ
         /d3/A3Wd1MNyevTyNggQrod7rce6KSsqVdSPLeMXAyO+T6q4Lgfd951/Wez9uKB19mH3
         lFRGccdcK/cnUKdQJnsE5XpG6DdBI0+uSad+MrehsW1L3xweQp87dXffYqTFcwYS+S6I
         5COEszdJicjE7TOpPpeQ8vcyjUKCLYFeATGrUN/NyuWHDQJOWu6BbUcw57zi8cq5qFeZ
         xkGbUE3SqNElx23Uhkf79iOlceJZd4Tva8YtBjVYLCE+zG8o1AMxxwJ6io3NIOPbiBMP
         oFdQ==
X-Gm-Message-State: AOAM5330+EY7hBaMgYhBQCErjhdNojvQxeps6qzwSq+QeOeuzuVFWysT
        vVIACv3c11LqpK9WmBLkcr1Br5Qc8g==
X-Google-Smtp-Source: ABdhPJwqOStHIuDdjzeWbMc1hW8uij5bYeEzvF80haO40+nk/h5OhRKjiXd0hzfKpKer2DIDfYPROMI8nA==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:1f19:d46:38c8:7e48])
 (user=elver job=sendgmr) by 2002:a0c:e345:: with SMTP id a5mr10045238qvm.27.1631532386935;
 Mon, 13 Sep 2021 04:26:26 -0700 (PDT)
Date:   Mon, 13 Sep 2021 13:26:03 +0200
Message-Id: <20210913112609.2651084-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH v2 0/6] stackdepot, kasan, workqueue: Avoid expanding
 stackdepot slabs when holding raw_spin_lock
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Walter Wu <walter-zh.wu@mediatek.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
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

[1] https://lkml.kernel.org/r/20210902200134.25603-1-skhan@linuxfoundation.org

v2:
* Refer to __stack_depot_save() in comment of stack_depot_save().

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
 lib/stackdepot.c           | 52 ++++++++++++++++++++++++++++++--------
 mm/kasan/common.c          |  6 ++---
 mm/kasan/generic.c         | 14 ++++++++--
 mm/kasan/kasan.h           |  2 +-
 7 files changed, 66 insertions(+), 18 deletions(-)

-- 
2.33.0.309.g3052b89438-goog

