Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6086408452
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 08:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237122AbhIMGCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 02:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234655AbhIMGCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 02:02:52 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CACC061574
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 23:01:36 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 6so12638452oiy.8
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 23:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jdwXw6pKQ+eOL7alcxynWehyVWgh/32RHEhD8lJnqhE=;
        b=FBZ+QyXWzzvyrXbXx8dunA0rlJgVVLlx1xbZ3blIWhHw/bXZ3Jg7jH0+P6xUgYRtC9
         6dT6J4+Li3oGBbhVAQGdzW7YWyg2tM9PIoJRIW6BJ/0Zus/TeoBRKw90P5FTgR0d8b6s
         iBBPwjyj3SJfuu3fAMplt0edGhhjb+hSJyavqQeUgUYXCQPMuQplL2yeLijHwRb0R8ID
         ZhDmjQoUeycWH7tpD4newTt/r9NSQ9eZ4DgntF5zGRQEOcZRici5wZjrYMgKztElPf67
         oTIE2Je7DydJHu9kLAXD0Na/aNj+rPFCFY8z1MbKsWG4bJt2IvGci6uyKqkqvIN2INg5
         1oZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jdwXw6pKQ+eOL7alcxynWehyVWgh/32RHEhD8lJnqhE=;
        b=isGi/t3ilzzabMLizZnUh/Hyk3zHRbgLlvIu9jQHdHknTGq0XzF9lKeX1sn1JUX8jB
         KJy0wbMCtOD5btmFIuFLx/GuO3p405X33/7/OfjWpcKzkeEzliKMdTezKBbV9rNXUKY8
         VIobRJDvwcNBHl9sWqw60gTORjz1sFhcbuYgQel4hznhSoipwEoAMn7zPxXr/VuMMFRs
         7vaIr7JQqcQmB1BAQH63HUp9owZI9yXDdABWS2BboQC32xZsngUcT96oyb4FHZUqWNrA
         McHYgh1jPGRHm1F19AUZHTk66moWiXyQPc67xpzfqz1nKG3QZo4+BWiayLmUlPgVwI6i
         JsBw==
X-Gm-Message-State: AOAM53350ciuy17GQbPESJWilbajxVHN57t5uKCkuvWmojzBGAfinfMk
        Foj2mewk0b4de0ohZglO/Mr3pNBoQgzd1/o1FGtB4w==
X-Google-Smtp-Source: ABdhPJwLVPvofjlvZMRAK2IxjL00Q1B1EyeeOwdxBZGMGU9GZFSSkM2WueJgbZCEVgp0ggIYgRR7JcTuasdNPAtKmJQ=
X-Received: by 2002:a05:6808:21a5:: with SMTP id be37mr6405238oib.172.1631512896132;
 Sun, 12 Sep 2021 23:01:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210907141307.1437816-1-elver@google.com> <69f98dbd-e754-c34a-72cf-a62c858bcd2f@linuxfoundation.org>
 <1b1569ac-1144-4f9c-6938-b9d79c6743de@suse.cz> <20210910152819.ir5b2yijkqly3o6l@linutronix.de>
In-Reply-To: <20210910152819.ir5b2yijkqly3o6l@linutronix.de>
From:   Marco Elver <elver@google.com>
Date:   Mon, 13 Sep 2021 08:00:00 +0200
Message-ID: <CANpmjNM1eGjsvYUvtTEq4dwraBqw0S8adPn9o7SVZ6G-i-Eq-g@mail.gmail.com>
Subject: Re: [PATCH 0/6] stackdepot, kasan, workqueue: Avoid expanding
 stackdepot slabs when holding raw_spin_lock
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Shuah Khan <skhan@linuxfoundation.org>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Sept 2021 at 17:28, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> On 2021-09-10 12:50:51 [+0200], Vlastimil Babka wrote:
> > > Thank you. Tested all the 6 patches in this series on Linux 5.14. This problem
> > > exists in 5.13 and needs to be marked for both 5.14 and 5.13 stable releases.
> >
> > I think if this problem manifests only with CONFIG_PROVE_RAW_LOCK_NESTING
> > then it shouldn't be backported to stable. CONFIG_PROVE_RAW_LOCK_NESTING is
> > an experimental/development option to earlier discover what will collide
> > with RT lock semantics, without needing the full RT tree.
> > Thus, good to fix going forward, but not necessary to stable backport.
>
>   Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> for the series. Thank you.

Thank you. I'll send v2 with Acks/Tested-by added and the comment
addition you suggested.

> As for the backport I agree here with Vlastimil.
>
> I pulled it into my RT tree for some testing and it looked good. I had
> to
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3030,7 +3030,7 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func)
>         head->func = func;
>         head->next = NULL;
>         local_irq_save(flags);
> -       kasan_record_aux_stack(head);
> +       kasan_record_aux_stack_noalloc(head);
>         rdp = this_cpu_ptr(&rcu_data);
>
>         /* Add the callback to our list. */
>
> We could move kasan_record_aux_stack() before that local_irq_save() but
> then call_rcu() can be called preempt-disabled section so we would have
> the same problem.
>
> The second warning came from kasan_quarantine_remove_cache(). At the end
> per_cpu_remove_cache() -> qlist_free_all() will free memory with
> disabled interrupts (due to that smp-function call).
> Moving it to kworker would solve the problem. I don't mind keeping that
> smp_function call assuming that it is all debug-code and it increases
> overall latency anyway. But then could we maybe move all those objects
> to a single list which freed after on_each_cpu()?

The quarantine is per-CPU, and I think what you suggest would
fundamentally change its design. If you have something that works on
RT without a fundamental change would be ideal (it is all debug code
and not used on non-KASAN kernels).


> Otherwise I haven't seen any new warnings showing up with KASAN enabled.
>
> Sebastian
