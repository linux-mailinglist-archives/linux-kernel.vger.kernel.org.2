Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA34406E2B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 17:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234372AbhIJP3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 11:29:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39332 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234130AbhIJP3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 11:29:32 -0400
Date:   Fri, 10 Sep 2021 17:28:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631287700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EI3QVBpMpmvzHjzxfllWn6UuMbjPLIo79cBtSieAgwY=;
        b=ol31PPlDXDfl+M5gSmepoP9EKuJUmJsp8JJkOV05HaEFdXil1HBYXUccnaSkldCpGVSMwv
        2m8so64VziRj+v4bYNBow7z+MoMwEWytH2gwip8XuwRa7fQwlCfVqMmq3J8nvMmNnQfXUJ
        GB3bRwAAnQfl+NGZV4OBfnBzY7fwV8h1LVrHpJoFfOi9tk6AmvWKpBAVrV6wHJR62EB1oo
        4VoBvHzrj5LUWih47DumUm3N/rsGGmaTG2MV4CCs1oOzg+h8ZFiBiJVqbJOektAnR6tzn1
        XF1khQe5YB1upskf7gQ70gMZhsF5Cul6RtPus5Ob4bqbfRGiWn6fVKSF3NAeIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631287700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EI3QVBpMpmvzHjzxfllWn6UuMbjPLIo79cBtSieAgwY=;
        b=CTBuqRuz3Txo5V8Vb1FWxUyua1rQ2Bn2petDtwbDPd8lPf/aFLi22NPSg+P8fz5CeUVGde
        HuHq2ya8kCWcvZCA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        Taras Madan <tarasmadan@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/6] stackdepot, kasan, workqueue: Avoid expanding
 stackdepot slabs when holding raw_spin_lock
Message-ID: <20210910152819.ir5b2yijkqly3o6l@linutronix.de>
References: <20210907141307.1437816-1-elver@google.com>
 <69f98dbd-e754-c34a-72cf-a62c858bcd2f@linuxfoundation.org>
 <1b1569ac-1144-4f9c-6938-b9d79c6743de@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1b1569ac-1144-4f9c-6938-b9d79c6743de@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-09-10 12:50:51 [+0200], Vlastimil Babka wrote:
> > Thank you. Tested all the 6 patches in this series on Linux 5.14. This problem
> > exists in 5.13 and needs to be marked for both 5.14 and 5.13 stable releases.
> 
> I think if this problem manifests only with CONFIG_PROVE_RAW_LOCK_NESTING
> then it shouldn't be backported to stable. CONFIG_PROVE_RAW_LOCK_NESTING is
> an experimental/development option to earlier discover what will collide
> with RT lock semantics, without needing the full RT tree.
> Thus, good to fix going forward, but not necessary to stable backport.

  Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
for the series. Thank you.

As for the backport I agree here with Vlastimil.

I pulled it into my RT tree for some testing and it looked good. I had
to
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3030,7 +3030,7 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func)
        head->func = func;
        head->next = NULL;
        local_irq_save(flags);
-       kasan_record_aux_stack(head);
+       kasan_record_aux_stack_noalloc(head);
        rdp = this_cpu_ptr(&rcu_data);
 
        /* Add the callback to our list. */

We could move kasan_record_aux_stack() before that local_irq_save() but
then call_rcu() can be called preempt-disabled section so we would have
the same problem.

The second warning came from kasan_quarantine_remove_cache(). At the end
per_cpu_remove_cache() -> qlist_free_all() will free memory with
disabled interrupts (due to that smp-function call).
Moving it to kworker would solve the problem. I don't mind keeping that
smp_function call assuming that it is all debug-code and it increases
overall latency anyway. But then could we maybe move all those objects
to a single list which freed after on_each_cpu()?

Otherwise I haven't seen any new warnings showing up with KASAN enabled.

Sebastian
