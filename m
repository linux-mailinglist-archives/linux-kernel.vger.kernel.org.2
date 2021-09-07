Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E06D7402A8B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 16:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234505AbhIGOQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 10:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232439AbhIGOPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 10:15:24 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056B8C06179A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 07:14:17 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id y11-20020aa7d50b000000b003ca1ef38cf3so5351719edq.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 07:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7ChlQWANvSBXBNUBCDuMgq5Cekd+HYTjR/ntyIg1Zyg=;
        b=edoUkiH2Kkf33Hq4VE8PDcQnBfHm5jDj20cp4k+Ev2uzNaB5gKzMC6RyQBjJ/HqWeA
         9uhk1YYgKb1sTHBCprikkPstROStRUGJt+ih9Bl0vPYrM4fJzRNU+8YVNEU2c/lesHKs
         fMkeV5JG0zhQBnMlXbQB78wv25kORlv1naya33fky1/kGMs6AoB4XkDmbXevrTe9zsdB
         3gvNw2jML5LfuIwNd8Uu5m9X7nB5Sy0pv7mJcrSPiRtPY0KRkWCf8dbv6a6uZAWAdm7w
         HYrhWzMSDLxOwDjA2liJXFub2QPHIr2N2pdYf3Z6AsIazDG3kWr4p7d8hMmTeoUc2pBb
         Q5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7ChlQWANvSBXBNUBCDuMgq5Cekd+HYTjR/ntyIg1Zyg=;
        b=CRzBg0wQ20dieAqQtnnjy+512/z/ssEv7rGHeeOXzPoPQBxvYldqZ1mMI8dCr4cHKZ
         jrWFa8Wby4hyv9kEkaOANIsraBhN5Pn/8g0Jq1qD2jWRebnblGlOiK2VsdaBZeVuDAGI
         rsQN7JErDU6WBok5eY1cwrGQsEbWgHMj43iFUFIpjCRLZw5Bq1CgPM3z90O34CgkvFSk
         EA8qTqcQ32ibulrnv4Bu9QrqEq0DDAGmYHoPklDYvtHNbJc0tBl38gt9FF2+CSxt0b7b
         L8bfZvFCGu1WiR15ftfJxXfvMcBqm2/3SaSCL9lEUyuUJBUDZvvvgeK6UkqvyrHiSstG
         x4nw==
X-Gm-Message-State: AOAM5336o/CZRCnDfAUWyZSeC9CBKl1Rm7SmSw6ENu5rcAw2WMqLp+gV
        3KIu0JFN61zSDIhhseLJf5OMaR9HzQ==
X-Google-Smtp-Source: ABdhPJyGsdfkionufVLXwZil0TbakqGI5ZpVw9BOrl5sbBB/o1m93aEaygEZ4Rn6IuxIMOU0utYtynfPFQ==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:6800:c1ea:4271:5898])
 (user=elver job=sendgmr) by 2002:a05:6402:3107:: with SMTP id
 dc7mr18886580edb.341.1631024055406; Tue, 07 Sep 2021 07:14:15 -0700 (PDT)
Date:   Tue,  7 Sep 2021 16:13:07 +0200
In-Reply-To: <20210907141307.1437816-1-elver@google.com>
Message-Id: <20210907141307.1437816-7-elver@google.com>
Mime-Version: 1.0
References: <20210907141307.1437816-1-elver@google.com>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
Subject: [PATCH 6/6] workqueue, kasan: avoid alloc_pages() when recording stack
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
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

Shuah Khan reported:

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

The default kasan_record_aux_stack() calls stack_depot_save() with
GFP_NOWAIT, which in turn can then call alloc_pages(GFP_NOWAIT, ...).
In general, however, it is not even possible to use either GFP_ATOMIC
nor GFP_NOWAIT in certain non-preemptive contexts, including
raw_spin_locks (see gfp.h and ab00db216c9c7).

Fix it by instructing stackdepot to not expand stack storage via
alloc_pages() in case it runs out by using kasan_record_aux_stack_noalloc().

While there is an increased risk of failing to insert the stack trace,
this is typically unlikely, especially if the same insertion had already
succeeded previously (stack depot hit). For frequent calls from the same
location, it therefore becomes extremely unlikely that
kasan_record_aux_stack_noalloc() fails.

Link: https://lkml.kernel.org/r/20210902200134.25603-1-skhan@linuxfoundation.org
Reported-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/workqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 50142fc08902..0681774e6908 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1329,7 +1329,7 @@ static void insert_work(struct pool_workqueue *pwq, struct work_struct *work,
 	struct worker_pool *pool = pwq->pool;
 
 	/* record the work call stack in order to print it in KASAN reports */
-	kasan_record_aux_stack(work);
+	kasan_record_aux_stack_noalloc(work);
 
 	/* we own @work, set data and link */
 	set_work_pwq(work, pwq, extra_flags);
-- 
2.33.0.153.gba50c8fa24-goog

