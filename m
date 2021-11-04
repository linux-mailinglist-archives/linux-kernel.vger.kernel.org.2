Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26816445616
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 16:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbhKDPQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 11:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbhKDPP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 11:15:59 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE9DC061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 08:13:21 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id o14so9088929wra.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 08:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZymXZTGWKU+upmR7RvoJbCAGVXO7Iv9RWWTcPFHB+Xo=;
        b=HSuk7S9NUUV1vfnYDaM3Xn6mNjBGsKWcrGD5471gGZHXYrfx8M66FWPn53VN55vSLy
         YB/nW/8rnTdCCZh4n+YfBa3BcTAP3zq+Bf1r+xodf6nzUlrSI+XsTzcvyHeGOm0Yfmck
         Vr6X0AoRV9lNvszXgmhUNbL8U+OD+k+ngEHmh7hKH7Kv0W/L8SxEnEqVulU1GHaPt6xN
         iRitDmooCsCWF3yHWmF1tWckNo6iSbXe8b+mWpbHTbgrXFCNIzGISmjasNLxvZxNmlp2
         xlDr0Kf14Ml8wwBnkN5yYaSXJwDjj1lV+1/uzcAk6dR+4BNWDY34Fx9yjhnwnAjTYtkl
         QETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZymXZTGWKU+upmR7RvoJbCAGVXO7Iv9RWWTcPFHB+Xo=;
        b=4szxz6+d1QqC38SGlcdZ7+wNz+e2N/WLf8pAavqr2iq0+davlJ2Hei/yk3ZUSv8Kaf
         xAZGYt7otjxzKRwGIqG0Hl2sFwEWBqnIcoE0AHn63i2dH9ZCBCXBlc6iwrYPcBXpDTEW
         R9RUnw1UvvCja4NxroVvExl3SdZAqgVCBCn/vjP182GyVCajze8lttjMk6w4vOdpLoZK
         7qV7VxNMk8/cfUs2TAys6AeB1Q4XbzBjljDTanLlCm1qi7sduqcgly9TynoFT/NQfmSl
         MNfQl35ABgevYZFg7oRqNwDUQg6WehXSNY8viUCdj+aGknRckzQLLg1G5Rxjdf4WgTMg
         vj9Q==
X-Gm-Message-State: AOAM5322QG2Rv+IEuuhIG6TG4qCPdXxo5EF6xPDFWIC/G0dzgcQadXzl
        IA4UX7yObcpHod44lnsK2Bj56g==
X-Google-Smtp-Source: ABdhPJxckjLwYk6F603gm5chKzcvnufDIqA/LUIAHf4WrR7gxw4whQ7XHJ9bEQEaq4sQHbTTFs59pQ==
X-Received: by 2002:adf:cd06:: with SMTP id w6mr50179487wrm.431.1636038799001;
        Thu, 04 Nov 2021 08:13:19 -0700 (PDT)
Received: from ?IPv6:2003:f6:af07:3b00:c7c0:ba0:afa0:f76a? (p200300f6af073b00c7c00ba0afa0f76a.dip0.t-ipconnect.de. [2003:f6:af07:3b00:c7c0:ba0:afa0:f76a])
        by smtp.gmail.com with ESMTPSA id g18sm5442558wrv.42.2021.11.04.08.13.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 08:13:18 -0700 (PDT)
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Benjamin Segall <bsegall@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        linux-kernel@vger.kernel.org, Odin Ugedal <odin@uged.al>,
        Kevin Tanguy <kevin.tanguy@corp.ovh.com>,
        Brad Spengler <spender@grsecurity.net>
References: <b98e3434-67cd-34b7-9e81-148ea31a851c@grsecurity.net>
 <20211103190613.3595047-1-minipli@grsecurity.net>
 <xm26ilx86gmp.fsf@google.com>
 <CAKfTPtBm4vHr=svju=Qg6eZmcv8YDghtM2r_pOahZ2gC3tzTxg@mail.gmail.com>
From:   Mathias Krause <minipli@grsecurity.net>
Subject: Re: [PATCH] sched/fair: Prevent dead task groups from regaining
 cfs_rq's
Message-ID: <a6a3c6c9-d5ea-59b6-8871-0f72bff38833@grsecurity.net>
Date:   Thu, 4 Nov 2021 16:13:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtBm4vHr=svju=Qg6eZmcv8YDghtM2r_pOahZ2gC3tzTxg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 04.11.21 um 09:50 schrieb Vincent Guittot:
> On Wed, 3 Nov 2021 at 23:04, Benjamin Segall <bsegall@google.com> wrote:
>>
>> Mathias Krause <minipli@grsecurity.net> writes:
>>
>>> Kevin is reporting crashes which point to a use-after-free of a cfs_rq
>>> in update_blocked_averages(). Initial debugging revealed that we've live
>>> cfs_rq's (on_list=1) in an about to be kfree()'d task group in
>>> free_fair_sched_group(). However, it was unclear how that can happen.
>>> [...]
>>> Fixes: a7b359fc6a37 ("sched/fair: Correctly insert cfs_rq's to list on unthrottle")
>>> Cc: Odin Ugedal <odin@uged.al>
>>> Cc: Michal Koutný <mkoutny@suse.com>
>>> Reported-by: Kevin Tanguy <kevin.tanguy@corp.ovh.com>
>>> Suggested-by: Brad Spengler <spender@grsecurity.net>
>>> Signed-off-by: Mathias Krause <minipli@grsecurity.net>
>>> ---
>>>  kernel/sched/core.c | 18 +++++++++++++++---
>>>  1 file changed, 15 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>>> index 978460f891a1..60125a6c9d1b 100644
>>> --- a/kernel/sched/core.c
>>> +++ b/kernel/sched/core.c
>>> @@ -9506,13 +9506,25 @@ void sched_offline_group(struct task_group *tg)
>>>  {
>>>       unsigned long flags;
>>>
>>> -     /* End participation in shares distribution: */
>>> -     unregister_fair_sched_group(tg);
>>> -
>>> +     /*
>>> +      * Unlink first, to avoid walk_tg_tree_from() from finding us (via
>>> +      * sched_cfs_period_timer()).
>>> +      */
>>>       spin_lock_irqsave(&task_group_lock, flags);
>>>       list_del_rcu(&tg->list);
>>>       list_del_rcu(&tg->siblings);
>>>       spin_unlock_irqrestore(&task_group_lock, flags);
>>> +
>>> +     /*
>>> +      * Wait for all pending users of this task group to leave their RCU
>>> +      * critical section to ensure no new user will see our dying task
>>> +      * group any more. Specifically ensure that tg_unthrottle_up() won't
>>> +      * add decayed cfs_rq's to it.
>>> +      */
>>> +     synchronize_rcu();
>>
>> I was going to suggest that we could just clear all of avg.load_sum/etc, but
>> that breaks the speculative on_list read. Currently the final avg update
>> just races, but that's not good enough if we wanted to rely on it to
>> prevent UAF. synchronize_rcu() doesn't look so bad if the alternative is
>> taking every rqlock anyways.
>>
>> I do wonder if we can move the relevant part of
>> unregister_fair_sched_group into sched_free_group_rcu. After all
>> for_each_leaf_cfs_rq_safe is not _rcu and update_blocked_averages does
>> in fact hold the rqlock (though print_cfs_stats thinks it is _rcu and
>> should be updated).
> 
> I was wondering the same thing.
> we would have to move unregister_fair_sched_group() completely in
> sched_free_group_rcu() and probably in cpu_cgroup_css_free() too.

Well, the point is, print_cfs_stats() pretty much relies on the list to
be stable, i.e. safe to traverse. It doesn't take locks while walking it
(beside the RCU lock), so if we would modify it concurrently, bad things
would happen.

Now, all manipulations of &cfs_rq->leaf_cfs_rq_list happen via the
list_*_rcu() variants, so that assumption in print_cfs_stats() is
actually sound -- the list chain can be walked without fearing to
dereference bad pointers. But if we would move the unchaining of
cfs_rq's down to sched_free_group_rcu() (or free_fair_sched_group(), as
that gets called more or less directly from sched_free_group_rcu()), we
would have the unchaining and kfree() of cfs_rq's in the same RCU GP.
Or, ignoring RCU for a moment, print_cfs_stats() may see a cfs_rq on one
CPU we're about to kfree() on the other. So, at least, the
kfree(tg->cfs_rq[i]) would need to become a kfree_rcu(). But likely all
the others as well, as print_cfs_stats() looks at cfs_rq->tg and
cfs_rq->tg->se[cpu], too.

> remove_entity_load_avg(tg->se[cpu]); has to be called only once we are
> sure that se->my_q will not be updated which means no more in the
> leaf_list

And that would be only be after tq was unlinked in sched_offline_group()
so walk_tg_tree_from() can't find it any more (to prevent re-linking the
cfs_rq) and after unregister_fair_sched_group() has run. But between the
two an RCU GP is needed. We can, sure, use the existing one by moving
unregister_fair_sched_group() to sched_free_group_rcu() /
cpu_cgroup_css_free(). But then we also need another RCU GP after that,
prior to releasing the involved objects, to ensure print_cfs_stats()
won't be the new UAF subject.

Thanks,
Mathias
