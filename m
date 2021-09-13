Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFB97408A21
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 13:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239640AbhIML2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 07:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239584AbhIML17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 07:27:59 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254D0C061762
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 04:26:43 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id r9-20020a5d4989000000b0015d0fbb8823so2360174wrq.18
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 04:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uXbisNK0hzVjo0x7v5RilsBzlcwLLC23aSoidmJI5Q0=;
        b=H9qgnMTa7AwCb5iArY+iTSmQ//hjkA1MCsuLuaE4/RUP/gDWt1slOPQx83Is1+UEkZ
         7ldVIUBdbaEIP8vDVZbuoQ50dIniyyxtoZvPOB7cxVpBscdCyAJjLOWmnqdQeR+x+CNV
         R59jlsb5GGt4EU0SDMVHt3JiOYWGuHTSUdLo8AkvkHKv5yH8yYTSjCJrl4UZcNae/xqq
         wktQQsT9+pUVwO6scHnOqIkHX9607WZlLiri4nKPcHURD/uZZHKIepPX2DvcPENMqu+3
         F0+uiIXW/gXBoLzzXUe4/bIjb/o7pcxzwMA2jaCf0hlT4hzHNQQxAMwxo+HxFlz61eyy
         yNow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uXbisNK0hzVjo0x7v5RilsBzlcwLLC23aSoidmJI5Q0=;
        b=i6DzX9Hx9WtLwvYnDIG7imoYweu4ikxkizn+Kj/BMNsLSVjMSI0VBUlnbc1upDHq9O
         4ig37y0sCZql6DTx8Tb1m140mGhZV5DZVwcLymklAgAIdGznPNsHGATzgBiXJoUhDim2
         eQsHmcGCLY0VkfJkgT+wRkRUNXyPoXaaLdQ9AvKpd977isovOplYgtXYUflO+QM8gT//
         u+n0OAlegEUPMcsBffyRX3tLhEvYUOvneLSRCjMTXQhHunBacyCQhc4RZML1rSR64Xx6
         dkaDA/d+dB70/owe8+6jcgoWYC96kdzAlzdvL7Pl1wgdjjPBBzDyWp8UZJW0Y1V4NQFS
         zIQw==
X-Gm-Message-State: AOAM531gDfzcQIWsPDVU4vna7W3nYB4UgqDRtP9fNNQBplSKLKMPAyto
        NmpfMz785Tto7qGT+1zpor774T4sXQ==
X-Google-Smtp-Source: ABdhPJwrHYb2pQNJIWj/O8r94l5tGwmsJgjQ5oX69os6T91IbgkHBm7FGNsYkspC/6g0HsRIyu30TJmAcA==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:1f19:d46:38c8:7e48])
 (user=elver job=sendgmr) by 2002:a05:600c:245:: with SMTP id
 5mr9896478wmj.53.1631532401563; Mon, 13 Sep 2021 04:26:41 -0700 (PDT)
Date:   Mon, 13 Sep 2021 13:26:09 +0200
In-Reply-To: <20210913112609.2651084-1-elver@google.com>
Message-Id: <20210913112609.2651084-7-elver@google.com>
Mime-Version: 1.0
References: <20210913112609.2651084-1-elver@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH v2 6/6] workqueue, kasan: avoid alloc_pages() when recording stack
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
Tested-by: Shuah Khan <skhan@linuxfoundation.org>
Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/workqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 33a6b4a2443d..9a042a449002 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1350,7 +1350,7 @@ static void insert_work(struct pool_workqueue *pwq, struct work_struct *work,
 	struct worker_pool *pool = pwq->pool;
 
 	/* record the work call stack in order to print it in KASAN reports */
-	kasan_record_aux_stack(work);
+	kasan_record_aux_stack_noalloc(work);
 
 	/* we own @work, set data and link */
 	set_work_pwq(work, pwq, extra_flags);
-- 
2.33.0.309.g3052b89438-goog

