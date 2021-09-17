Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66BAA40FA70
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 16:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343702AbhIQOlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 10:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245391AbhIQOlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 10:41:09 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32986C0613E6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 07:38:28 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 77-20020a9d0ed3000000b00546e10e6699so2043899otj.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 07:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GO6yNkAO2As+gyaSFwvR3MHVKDXqu7ThxhmfTtq/E50=;
        b=lDpUN20Im2TAcP3GJhxCm2FIu7hDYYZV6QzRwVn0CZfHtq8X2eqYutBYYATdCs5GI5
         e45bniguJ36npnNH5gBJQUvnTp5Bf49rALNp7WgJ+9LQZLxeL+e1OauP5yKevs9QLkKf
         UZBcyhhSj11AX11VoIrRqbh1qFqywIz5egr8zSOaoMi/VfkpAfQso40rqquHBMg9J8Rb
         4mlUmCykoVVPkwIqZdglZQgGMjHn4lIMDLSDHpHOCk+t1vgq4lmDSmhlxqToD79GTtOd
         LoxLjzOYqbAeExFQ2WjSw2AiNmhDY3G9JlN8s3Wr8PJwYvya41kZdLZS5pMqumnCoe95
         4F1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GO6yNkAO2As+gyaSFwvR3MHVKDXqu7ThxhmfTtq/E50=;
        b=sDqHqi86tCUySQeub6b2tW6gTB14NQ/2bzxxaDAkzX2SndJQMLN6/09HszaBTqA+39
         GMlkNMBUSnKvxOvNcguHcLvSz60DwVC6AvCAnDXFh6xA7FygKdj78aWxggwDDN5/hp0Z
         y90gYTSWdlER/+VEpaRObrISgePltPCwYfB6StQNPE/+VXJee2IFBq6PhlsQEJNN7H/h
         SAftgjBX1HKYJiwll8QnFxxUvmXxmACYHrEFYHY6ERDPrISrgge3pHVM210BVwLZZ/Yt
         QetbBurZJHqYx5/EpE2l2H1GPVCjRt9OeEWwqLIKJrgKqzRSlRwLB+jdqsF0oXhjVyAI
         L/Rg==
X-Gm-Message-State: AOAM53369MM5Ii248rqHfWJdd0yTQrTBeZkywR0CVQS+2FdOEnR9P5hT
        zQi42tdKfN7Hdq7EBvNxL/ln8TBzg9Clf7/5Ib4gdyHoxQ7LBQ==
X-Google-Smtp-Source: ABdhPJwFV1TmQGMteq5aid44X/ktsa1X/8B9T1dLKTPk0o/G9N/25J/9Z1IGv87lj+UYweTzrkvar4COsCm41K5p8xM=
X-Received: by 2002:a05:6830:34b:: with SMTP id h11mr9956039ote.319.1631889507365;
 Fri, 17 Sep 2021 07:38:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210830172627.267989-1-bigeasy@linutronix.de> <20210830172627.267989-4-bigeasy@linutronix.de>
In-Reply-To: <20210830172627.267989-4-bigeasy@linutronix.de>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 17 Sep 2021 16:38:16 +0200
Message-ID: <CACT4Y+Z9NqymRB5q-U27P8gGF21UTZzSOuNgZO-EBqQnbKNXhg@mail.gmail.com>
Subject: Re: [PATCH 3/5] kcov: Allocate per-CPU memory on the relevant node.
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Marco Elver <elver@google.com>,
        Clark Williams <williams@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Aug 2021 at 19:26, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> During boot kcov allocates per-CPU memory which is used later if remote/
> softirq processing is enabled.
>
> Allocate the per-CPU memory on the CPU local node to avoid cross node
> memory access.
>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Acked-by: Dmitry Vyukov <dvyukov@google.com>

> ---
>  kernel/kcov.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/kcov.c b/kernel/kcov.c
> index 80bfe71bbe13e..4f910231d99a2 100644
> --- a/kernel/kcov.c
> +++ b/kernel/kcov.c
> @@ -1034,8 +1034,8 @@ static int __init kcov_init(void)
>         int cpu;
>
>         for_each_possible_cpu(cpu) {
> -               void *area = vmalloc(CONFIG_KCOV_IRQ_AREA_SIZE *
> -                               sizeof(unsigned long));
> +               void *area = vmalloc_node(CONFIG_KCOV_IRQ_AREA_SIZE *
> +                               sizeof(unsigned long), cpu_to_node(cpu));
>                 if (!area)
>                         return -ENOMEM;
>                 per_cpu_ptr(&kcov_percpu_data, cpu)->irq_area = area;
> --
> 2.33.0
>
