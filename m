Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13D923F5209
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 22:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbhHWU00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 16:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbhHWU0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 16:26:23 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F15C061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 13:25:40 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id e5so11416460wrp.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 13:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XA/U7CbvSIHKK66o3nJxmSeGYBaHonHFImu9Oh5UX2A=;
        b=Savy0dtjx7o4Aqu7CBxxzc8ewmDn9EunBQaxTV4NbqlxfqCJeRB2lscks5obwevqWE
         Oa84PwV1s+eZtxZcICaa7Vk/6pLdFvoA2IQNJZPj9pcRZ70RTs7eLEvYo8S7F0TfjwQv
         9Uv/bHtyyeRkEasrUlf9aP0aI5fGlPJWwe8aBbdyplJoCnG6h41PoOoZ58Ea6HHLdN+n
         7k3cpIlO13/VaXzx2vW/MW8i6hVtcMgobFmPSueVrJObXb0mZZinwI7HtFvYBTU8svHc
         U+sQcWsdv8efpqYh2VS8zDHfZZo9GAOomihCEjrVO7pw9vA4wZBrrXhbyY1spwtE195S
         xkQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XA/U7CbvSIHKK66o3nJxmSeGYBaHonHFImu9Oh5UX2A=;
        b=s6f+4lLU1+T9rzE+zAXpLVH8H0g7dOiwCAnDS/XZ3eAvZPCHBxSCBiVL2A0DUjiY0W
         9EdcTvD1pLP/tBI7ed03tYoCduio3domMmDi82h94YE6vSUlYyr0sAqFo4crZbRnmHow
         Ah7089d0Ci4OOQkd2g8BaIqhae8wasaUVL+cnfVNUU3NUlZ6c8uFsEFj4B6tsDhqMeic
         UDepcXxB13UWPXkxF8Yoxdii2DO5BU5w65/L2zi3UnvROc6J5MnHQGecczQ2/Vft9qaF
         JeTeBcftDEoGjR4xdwgui1ctcNbZ4Y6RLQqg/V//Z6lucK+tsHnaWrfE+tdl48ufmZsO
         9Iag==
X-Gm-Message-State: AOAM532DWnqDDqtnrw04WDts2epk6V7GFNqT/iqUYsNmEF8kSevE6wag
        iboYb1jHjhMH6NGYdP/NImHPOozg407vM/n8HGA=
X-Google-Smtp-Source: ABdhPJyNa4Lhm1KPbXEFf/bFRJxZKAu46GiYfOhGAEuvv8PN5HHbO365Vb1nUqKVFQ4BuYLk/jroKtWvh7NyYYQuoBQ=
X-Received: by 2002:a5d:4d03:: with SMTP id z3mr15596912wrt.229.1629750339391;
 Mon, 23 Aug 2021 13:25:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210818005615.138527-1-joshdon@google.com> <YSODqN9G7VuV+kNR@hirez.programming.kicks-ass.net>
In-Reply-To: <YSODqN9G7VuV+kNR@hirez.programming.kicks-ass.net>
From:   Vineeth Pillai <vineethrp@gmail.com>
Date:   Mon, 23 Aug 2021 16:25:28 -0400
Message-ID: <CAOBnfPjH=y3Lk7AukLeG4mNcJnf5cgV260=PZCbF9u69-T+Q6Q@mail.gmail.com>
Subject: Re: [PATCH] sched/core: fix pick_next_task 'max' tracking
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, tao.zhou@linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,


> > Here, we should have instead updated 'max' when picking for SMT-1. Note
> > that this code would eventually have righted itself, since the retry
> > loop would re-pick p2, and update 'max' accordingly. However, this patch
> > avoids the extra round-trip.
>
> Going with the observation Tao made; how about we rewrite the whole lot
> to not be mind-bending complicated :-)
>
> How's this? It seems to build and pass the core-sched selftest thingy
> (so it must be perfect, right? :-)
>
Nice, the code is much simpler now :-). A minor suggestion down..

> -       for_each_cpu(i, smt_mask) {
> -               struct rq *rq_i = cpu_rq(i);
> -
> +       /*
> +        * For each thread: do the regular task pick and find the max prio task
> +        * amongst them.
> +        *
> +        * Tie-break prio towards the current CPU
> +        */
> +       for_each_cpu_wrap(i, smt_mask, cpu) {
> +               rq_i = cpu_rq(i);
>                 rq_i->core_pick = NULL;
>
>                 if (i != cpu)
>                         update_rq_clock(rq_i);
> +
> +               for_each_class(class) {
> +                       p = rq_i->core_temp = class->pick_task(rq_i);
I think we can use core_pick to store the pick here and core_temp
might not be required. What do you feel?

> +                       if (p)
> +                               break;
> +               }
> +
> +               if (!max || prio_less(max, p, fi_before))
> +                       max = p;


Thanks,
Vineeth
