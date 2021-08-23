Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEEF53F53A0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 01:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233201AbhHWXZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 19:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233093AbhHWXZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 19:25:23 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB36C061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 16:24:39 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id n126so24031854ybf.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 16:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A7bP/SLiBOnFDu0wqR6On8yDXES3VpQI1qN5SJ7wmMs=;
        b=gJFq/xCdHjs7QbiMdC417WnTvz/zKpowi8pkIkcfTBnnewL6j5f+pPlvM2aiJ5V/nD
         iMG4f+sRyjHF6v5l4z2zzU2pinlby/+532gNIphkVgfTYuI89wtJiPLrMnJMK0X5dWxx
         fLQ0SGJd+nbEYwAQCQ+PROfmMIwIdD0llsvVuVyIwOVgJP/1FA8crQEQ2MBLLxVFJABa
         Wng8LXFjBKM2owQAweuvQmZLqydSMvex+/K/4UA3CeZdrjNJSN43arD0xhxgKvaov3d8
         5ktD+YH1yFNw355XcMl7jJbSwxJL2aayX3RNo5mru9QjmSaf+TokyblQOUVdz0xRr3gi
         ujlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A7bP/SLiBOnFDu0wqR6On8yDXES3VpQI1qN5SJ7wmMs=;
        b=EBlwSLBBtu9ANtxqa5rE8yW68Nw0sk2ziJ1pYP3VA88Q2KTFcGw1Sro4i+tRsbwbVB
         LV3wPIkTy0Iie/HS3aHcFaT6vMwEViIYecaGbXMbDKJHdhZNaFivLG0BF9N6IjblKu9O
         O2dXx3PxJ9ACHlhyjcCCMeo72U3/dCCXEdq9AsVZd47mvhaFvNi3t+lsecAUZ8kIX6Pz
         AKubdIqyg/rtU8iQYZ8Yxl0lWgc73CbGWKs9JGTVwfMKCXOFCt3o/DYGnZLvSpHbNEWS
         XvNuUcuLjLO0uBZtQI2IbkOYdO3avgz1mxHGHfCfhoriDaV0ao1J1mVaAHeoyeI+lA/K
         eIXg==
X-Gm-Message-State: AOAM530xRnmD+SM6A9xP0fROKlhI3tNMeSrE5Ztn0tkR+zfSBYSDOBWq
        lvR7QYR96mbq2OIeiuYwIpFSfNI3nYrt0f9GS4ABlA==
X-Google-Smtp-Source: ABdhPJy4KqB7TrHTE9lGWs6TmAHhCXyz1Xt1bcuNWDbI235bhHj+r9KTJ9F6YE54orRxvh3hy9fnvx8ePaqOfQttlxM=
X-Received: by 2002:a25:c095:: with SMTP id c143mr6437050ybf.179.1629761077639;
 Mon, 23 Aug 2021 16:24:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210818005615.138527-1-joshdon@google.com> <YSODqN9G7VuV+kNR@hirez.programming.kicks-ass.net>
In-Reply-To: <YSODqN9G7VuV+kNR@hirez.programming.kicks-ass.net>
From:   Josh Don <joshdon@google.com>
Date:   Mon, 23 Aug 2021 16:24:26 -0700
Message-ID: <CABk29Ns-aiSjf8WTWL5U0ggKr32NKC3Q6ANJ8MheDP5P-k_JuA@mail.gmail.com>
Subject: Re: [PATCH] sched/core: fix pick_next_task 'max' tracking
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Vineeth Pillai <vineethrp@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tao Zhou <tao.zhou@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Mon, Aug 23, 2021 at 4:17 AM Peter Zijlstra <peterz@infradead.org> wrote:
[snip]
> +       for_each_cpu(i, smt_mask) {
> +               rq_i = cpu_rq(i);
> +               p = rq_i->core_temp;
>
> -                       /*
> -                        * If this sibling doesn't yet have a suitable task to
> -                        * run; ask for the most eligible task, given the
> -                        * highest priority task already selected for this
> -                        * core.
> -                        */
> -                       p = pick_task(rq_i, class, max, fi_before);
> +               if (!cookie_equals(p, cookie)) {
> +                       p = NULL;
> +                       if (cookie)
> +                               p = sched_core_find(rq_i, cookie);

In the case that 'max' has a zero cookie, shouldn't we search for a
match on this cpu if the original class pick ('p') had a non-zero
cookie? We don't enqueue tasks with zero cookie in the core_tree, so I
forget if there was some other reasoning here.

>                         if (!p)
> -                               continue;
> +                               p = idle_sched_class.pick_task(rq_i);
> +               }
