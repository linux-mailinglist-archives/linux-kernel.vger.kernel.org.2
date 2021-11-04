Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E85CC445B35
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 21:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbhKDUtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 16:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbhKDUtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 16:49:15 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56580C061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 13:46:37 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id f8so9223307plo.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 13:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=EviwvTQlRlyLRIR3hN/eKbYcE4bKQll4vj8Wevr8vpc=;
        b=VMHDTF0KXgHXm+kT+Fb0bxn8To3VI0xxVfS5zg0628g1qFkz2cy78mhBOgwOI1D+uO
         3b577yGIfTyxnDG5Rd62CJPV4BXdHZ5FS/R6TG7xDM6iamRqT1t4EIq5otKaJ4LnJSKL
         5KbMCZDXrGq38cwCxUSG0xV+6aUHlAp7cxc2s3GC2CrV+sZmn7TU14OxXqIZWfAIhIqA
         PtvFzy8oIwa/3jZyWq5zAQ2IfAAbXxDdKYUopkeUpFo+W3legsvx04TfuMWqZp14OOU1
         qpdSJ7oTgqnsxxzPeCYrn5iHXXHfmDkKQpubfNMPhS92xrcBi1j9/ryRQpfq7LLgW+yG
         v1jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=EviwvTQlRlyLRIR3hN/eKbYcE4bKQll4vj8Wevr8vpc=;
        b=cfRN1Qw0SfbXHr8CnyEHUwuGlU736tAlFI796Bj/lyuiBYsrAEPfjzIh0GGrEGQTb6
         4pdoCeXxxya/BfS9/p6VKgRWU+LzRafwqeaFhZT+/h+Q7K1pD0Ns+t8pGTRbaqiFM0MC
         9ZY9o46uUil5MA72V3T+NBNl8hhGIHb8GWQ/i5sfBMyec/6MmqWT0RpAZVjtQ3BVgdRd
         K4WssIq17mK2qjKHudUx8fLYkz8SEI5d11To6QZ5Y5RFUGt78bVOjH+fk1CFeu+vyAFZ
         qbmjCo9SkPLo3EEJyvGsD0y72aOwV4iEL5lpjuBBtzg7TOAb+eh6NodIuPCkT6ejZNZ5
         MP7A==
X-Gm-Message-State: AOAM533iQxEGl/vAORmw2m99+aWgtdqrbZzL4skknv84eZXcBZOJzC+c
        xyDMOxlMxKCJU6NIBvV4MCjLhw==
X-Google-Smtp-Source: ABdhPJzzksovqdY+zGEl1HoODK2hH5QBJHcnc5K2p+Ncb0K17yElOGR9UMEGtcr15JDrir5E3aV9LA==
X-Received: by 2002:a17:902:c412:b0:141:f710:2a94 with SMTP id k18-20020a170902c41200b00141f7102a94mr24732805plk.1.1636058796654;
        Thu, 04 Nov 2021 13:46:36 -0700 (PDT)
Received: from bsegall-glaptop.localhost (c-73-71-82-80.hsd1.ca.comcast.net. [73.71.82.80])
        by smtp.gmail.com with ESMTPSA id c6sm5549050pfd.114.2021.11.04.13.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 13:46:34 -0700 (PDT)
From:   Benjamin Segall <bsegall@google.com>
To:     Mathias Krause <minipli@grsecurity.net>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        linux-kernel@vger.kernel.org, Odin Ugedal <odin@uged.al>,
        Kevin Tanguy <kevin.tanguy@corp.ovh.com>,
        Brad Spengler <spender@grsecurity.net>
Subject: Re: [PATCH] sched/fair: Prevent dead task groups from regaining
 cfs_rq's
References: <b98e3434-67cd-34b7-9e81-148ea31a851c@grsecurity.net>
        <20211103190613.3595047-1-minipli@grsecurity.net>
        <xm26ilx86gmp.fsf@google.com>
        <CAKfTPtBm4vHr=svju=Qg6eZmcv8YDghtM2r_pOahZ2gC3tzTxg@mail.gmail.com>
        <a6a3c6c9-d5ea-59b6-8871-0f72bff38833@grsecurity.net>
Date:   Thu, 04 Nov 2021 13:46:33 -0700
In-Reply-To: <a6a3c6c9-d5ea-59b6-8871-0f72bff38833@grsecurity.net> (Mathias
        Krause's message of "Thu, 4 Nov 2021 16:13:17 +0100")
Message-ID: <xm26a6ij6446.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mathias Krause <minipli@grsecurity.net> writes:

> Am 04.11.21 um 09:50 schrieb Vincent Guittot:
>> On Wed, 3 Nov 2021 at 23:04, Benjamin Segall <bsegall@google.com> wrote:
>>>
>>> Mathias Krause <minipli@grsecurity.net> writes:
>>>
>>>> Kevin is reporting crashes which point to a use-after-free of a cfs_rq
>>>> in update_blocked_averages(). Initial debugging revealed that we've li=
ve
>>>> cfs_rq's (on_list=3D1) in an about to be kfree()'d task group in
>>>> free_fair_sched_group(). However, it was unclear how that can happen.
>>>> [...]
>>>> Fixes: a7b359fc6a37 ("sched/fair: Correctly insert cfs_rq's to list on=
 unthrottle")
>>>> Cc: Odin Ugedal <odin@uged.al>
>>>> Cc: Michal Koutn=C3=BD <mkoutny@suse.com>
>>>> Reported-by: Kevin Tanguy <kevin.tanguy@corp.ovh.com>
>>>> Suggested-by: Brad Spengler <spender@grsecurity.net>
>>>> Signed-off-by: Mathias Krause <minipli@grsecurity.net>
>>>> ---
>>>>  kernel/sched/core.c | 18 +++++++++++++++---
>>>>  1 file changed, 15 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>>>> index 978460f891a1..60125a6c9d1b 100644
>>>> --- a/kernel/sched/core.c
>>>> +++ b/kernel/sched/core.c
>>>> @@ -9506,13 +9506,25 @@ void sched_offline_group(struct task_group *tg)
>>>>  {
>>>>       unsigned long flags;
>>>>
>>>> -     /* End participation in shares distribution: */
>>>> -     unregister_fair_sched_group(tg);
>>>> -
>>>> +     /*
>>>> +      * Unlink first, to avoid walk_tg_tree_from() from finding us (v=
ia
>>>> +      * sched_cfs_period_timer()).
>>>> +      */
>>>>       spin_lock_irqsave(&task_group_lock, flags);
>>>>       list_del_rcu(&tg->list);
>>>>       list_del_rcu(&tg->siblings);
>>>>       spin_unlock_irqrestore(&task_group_lock, flags);
>>>> +
>>>> +     /*
>>>> +      * Wait for all pending users of this task group to leave their =
RCU
>>>> +      * critical section to ensure no new user will see our dying task
>>>> +      * group any more. Specifically ensure that tg_unthrottle_up() w=
on't
>>>> +      * add decayed cfs_rq's to it.
>>>> +      */
>>>> +     synchronize_rcu();
>>>
>>> I was going to suggest that we could just clear all of avg.load_sum/etc=
, but
>>> that breaks the speculative on_list read. Currently the final avg update
>>> just races, but that's not good enough if we wanted to rely on it to
>>> prevent UAF. synchronize_rcu() doesn't look so bad if the alternative is
>>> taking every rqlock anyways.
>>>
>>> I do wonder if we can move the relevant part of
>>> unregister_fair_sched_group into sched_free_group_rcu. After all
>>> for_each_leaf_cfs_rq_safe is not _rcu and update_blocked_averages does
>>> in fact hold the rqlock (though print_cfs_stats thinks it is _rcu and
>>> should be updated).
>>=20
>> I was wondering the same thing.
>> we would have to move unregister_fair_sched_group() completely in
>> sched_free_group_rcu() and probably in cpu_cgroup_css_free() too.
>
> Well, the point is, print_cfs_stats() pretty much relies on the list to
> be stable, i.e. safe to traverse. It doesn't take locks while walking it
> (beside the RCU lock), so if we would modify it concurrently, bad things
> would happen.


Yeah, my idea was that print_cfs_stats is just debug info so it wouldn't
be a disaster to hold the lock, but I forgot that we probably can't hold
it over all that writing.
