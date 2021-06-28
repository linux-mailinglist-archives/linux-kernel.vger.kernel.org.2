Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCA6B3B6982
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 22:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234906AbhF1UM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 16:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237318AbhF1UMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 16:12:47 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC0EC061760
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 13:10:21 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id h15so34771263lfv.12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 13:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aKntq9zj9C3lmXbOlECBxOpuMyE7fATYtBVOgQbgdBw=;
        b=STHIGwaKO4TwPixEhHTCX3RUjRHVcFp6ftt12txqWTVJ8qIhuUdHzV/Hgz3GVzetHF
         13P9xwrLj9IPlbcEeB6ahEGie62LKL/rU4uwBFj2e5WHkP23+KEKRNhzJp2ZBNNwl8ge
         OolxXmvTQzV24bdGbLNxX5RnZivB0duHGOxoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aKntq9zj9C3lmXbOlECBxOpuMyE7fATYtBVOgQbgdBw=;
        b=T18o29q4kDlKnVY9XXOgVwGLuZGbVVXfaDOoZJSw7ybceS2CQSKrl2cBD36Eee2Aop
         4LV2FwhvWf6Pd5Pf7bBwORIpUKGdzLMVSvk4sTlyZs33kjhiOmu4A4lso3o5SjteyjBR
         RmkLEmcaSARf/kV3cUd2qvcUK+3yGuL9FrV9f+q4WkgPGFq8Ffk64ztRwBv28tOyE5HN
         mjC/t07Em0/ZMKRmZwc8qUN3IYnYv6wF2Lz6XZZgted+ZuYgR47JyGEu6m4+QtFcqhk+
         6Pu6ceKWo40puj0pjDBE8bEkbhxkIYZ1IxiBeMHeofTUywgXVdvfCH5QKKJU1t9xGQq8
         ugYg==
X-Gm-Message-State: AOAM5305oZMCTEwbCvHbXNe9Ci2lKE5ucYxZhtSstXa7x2uUubT4WsCA
        Du/Y4NnSEMU2d4TwCPBw+HPX07G6LqP8CfZz
X-Google-Smtp-Source: ABdhPJwTgyqxjkIzO3omp+uvomDvEJ9rHMaQlfgebi/gIYlUq69fvHNttzIPSuBrFxMKTghpyZrm5Q==
X-Received: by 2002:a19:7d8b:: with SMTP id y133mr20767155lfc.284.1624911019051;
        Mon, 28 Jun 2021 13:10:19 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id y24sm1650727ljj.16.2021.06.28.13.10.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jun 2021 13:10:18 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id k21so6770871ljh.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 13:10:18 -0700 (PDT)
X-Received: by 2002:a05:651c:32e:: with SMTP id b14mr850972ljp.251.1624911018010;
 Mon, 28 Jun 2021 13:10:18 -0700 (PDT)
MIME-Version: 1.0
References: <YNlxcCpk4shGcPrU@gmail.com> <CAHk-=wisVoq7COhA-B+5UAbisJqTn7Sehh-brqn6K3UVuFzoew@mail.gmail.com>
 <YNopqw/BbJGjOGMq@gmail.com>
In-Reply-To: <YNopqw/BbJGjOGMq@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 28 Jun 2021 13:10:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjNP8Oi4nve=uu=Q3+rGar3CY9fBUQFuJK-WYCK3F198w@mail.gmail.com>
Message-ID: <CAHk-=wjNP8Oi4nve=uu=Q3+rGar3CY9fBUQFuJK-WYCK3F198w@mail.gmail.com>
Subject: Re: [PATCH] sched/core: Disable CONFIG_SCHED_CORE by default
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2021 at 12:57 PM Ingo Molnar <mingo@kernel.org> wrote:
>
> You are completely right, I missed this. Find below the patch to fix it -

I think you should update the helptext too, which currently says that
it's enabled if SCHED_SMT is enabled.

And yes, it may be that there is no measurable performance downside,
but this feature has been discussed and under development for a long
time now, and I'd like the default to try to limit the impact since it
makes little sense to most people.

          Linus
