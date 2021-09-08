Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62BC9403F29
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 20:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350200AbhIHShl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 14:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345805AbhIHShk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 14:37:40 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D504C061757
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 11:36:32 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id z5so6219756ybj.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 11:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=czFKAT4Di1kKVjpRX4ncrD9kt4xU5KfWJk/P6TiXJug=;
        b=sKebpZ0GYa3NUpk7ZZpc/alL6MeFz4PBjPfL4/wsce1NbcpH1MU5OR7O+C6x3RtRjo
         BzKPQWBGzZzvaHPw7iuhNoGbeI4ajWAER/D275f3+FTubd0wmhXBc6Zon/LGiRLrSVq+
         j3fPelIbmY5vZ4nf4GVG/7cTQ0oKIjzZ98PsVjUuMPA2iu/vcuDOQwQeJ4bDqqnhMTVh
         2MobHNH+jk4u8wySdQQziE2U2KYMWQDqV4wTEuHRWCsgOrxbTujbnQOMOnqaqeL1FOA2
         4OG3bkxxD14pOm3GPrbxNxeQC1njAgBbCVXs77w+pNRYZ/z90u7tgoJmMiBz8HchZzbh
         /Vbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=czFKAT4Di1kKVjpRX4ncrD9kt4xU5KfWJk/P6TiXJug=;
        b=hZfJaj6Djs9hN54IFK71VUwASFgCqZy6WjtnYPpDqvLrW03PFPfaJu0xKXqoqC0Bkf
         GNmZKhHAAB7yYsVN/Mu/9tCAGTCKCMH9IzkwRGpyRUXuhWraN+y8xilLIixKDS6xYiSL
         bJelZ4ABLy4/1W9NYUm7tcgTxqcZDG/m3yPfiQJDQjiZexiZjyIs8ad23FFTYmqUzuq0
         RzpVJe/sp3cXTUl7+oX/ATNGJnOuEisOFX1NvjdIFYmu4Wat1aXisfN21Tsxeds6lT9o
         xylK3SccNohyFry5BZZTwnGSHjFGs5NurlJZISgsiRnY/kEuru0P6U2fU3gkjnYM6Bek
         NaeQ==
X-Gm-Message-State: AOAM530sONtWJpKPGZy7Ic+CHpVVDv0N8lykiRTQdWCPs3AHQBsfhi+m
        58/foOLtC0GFct7yPNfSXrKLkHxXZjMgdNqxZEVZ1Q==
X-Google-Smtp-Source: ABdhPJxy0oyG+ekT7mLiHekU3i/rcWyHMbvArduGQfW0N/JWPo/TuXMlOdlBdCQDM5F3yl7mpvVCZ3QwNirtNPsKCEA=
X-Received: by 2002:a25:ad45:: with SMTP id l5mr7750425ybe.228.1631126191516;
 Wed, 08 Sep 2021 11:36:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210820010403.946838-1-joshdon@google.com> <20210820010403.946838-2-joshdon@google.com>
In-Reply-To: <20210820010403.946838-2-joshdon@google.com>
From:   Josh Don <joshdon@google.com>
Date:   Wed, 8 Sep 2021 11:36:20 -0700
Message-ID: <CABk29NtMdwYACJ4k5R=tz66_GFeFf8uTOK000baz6PCbdJAcrg@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] sched: cgroup SCHED_IDLE support
To:     alexs@kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Paul Turner <pjt@google.com>,
        Oleg Rombakh <olegrom@google.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Steve Sistare <steven.sistare@oracle.com>,
        Tejun Heo <tj@kernel.org>, Rik van Riel <riel@surriel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 6, 2021 at 5:47 AM <alexs@kernel.org> wrote:
>
> ...
>
> > For now, we maintain the existing SCHED_IDLE semantics. Future patches
> > may make improvements that extend how we treat SCHED_IDLE entities.
> >
> > The per-task_group idle field is an integer that currently only holds
> > either a 0 or a 1. This is explicitly typed as an integer to allow for
> > further extensions to this API. For example, a negative value may
> > indicate a highly latency-sensitive cgroup that should be preferred for
> > preemption/placement/etc.
>
> Hi Josh,
>
> Sounds there is a ready solutions for colocation problem, isn't there?
> I'd like to evaluate its effects if it could be sent out.
>
> Thanks
> Alex
> >

Hi Alex,

I don't have a patch written just yet. The basic idea is to utilize
the (negative) idle values to make relative decisions about task
preemption and wakeup vruntime placement.

Could you describe your use case?

Best,
Josh
