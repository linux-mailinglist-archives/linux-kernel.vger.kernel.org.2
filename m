Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC28446547
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 15:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbhKEO6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 10:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233289AbhKEO6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 10:58:17 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77CBC061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 07:55:37 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id r8so14121180wra.7
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 07:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=usXdWUOIdQxMuchtyqFk9vaJkdyOXIN0o0UnmjgkBB8=;
        b=sfM7nxs9IOBwwA0qV5WQdskzlsJf/JhX9WI3JY6F3Cc/FJaFMJQoSHWOSkEglU4IUh
         prZS6nzvG6FPLpNbBwCpqF6f2+uEk5XmF4Zb8JIcDMtWkqyvU6dGrVWInFcnBrMNLG6c
         QWRGhCDRjyBS5uMN+LUBCufgiDAeUA66HX8OynzQXIEklIIiavF2mpRUWFdX3n1p6oOt
         SbWceP5Oun/v/sOtb0dVAp35Bt06XOqevvwphQF0qd/7XwZCUrM9Zk3XfwabWnlJ9efv
         4WiyT8+lfzxuZ675POKecV0x0oGK6Vqzj/EbidJD0V3vGIEIArXDhOAuX+SM13LfBPJR
         pV8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=usXdWUOIdQxMuchtyqFk9vaJkdyOXIN0o0UnmjgkBB8=;
        b=hxb+Ccl5A5ctAfdl0N7IH2Zp71VUohuptLBy6vxitpGMnqEJLhpfApqdByOeuSvD7v
         pCFpSBa9rgkvdVLGkiXMrmSpCJ3Kip7VPgZ6UkhrcHUuY0RWQb6ixi2VQHo+dLotF3W1
         oaEUmm90UCUIJd2XZU/94Qev0CFmW7KB9qZp5uhMfpf1T1A306toEZRnMsHZEp2TLD9u
         5WlZWBHFCpeiOmqn+IqxtyLUskYnXPcn7s+3i4u1PoQ5R8ZxS0UVV1KuRc/tHe+TP/la
         seD1SkeR5YxVVsVOe3o3WlJeKm/SsWtt3M8JkIhM/J2uJ3Ck/rQ4/70Nbw6gy7/AOA38
         9B9g==
X-Gm-Message-State: AOAM531Qc9OaqOUSNuEl3C+Z7iEhxn2h0afZyM4o4fIr2aXtFlV9zYl0
        vQsEgJuL7JauQjotcwBmSsIRbg==
X-Google-Smtp-Source: ABdhPJwMgynuxEDjJ4aOFYF+H3JASWPWpEstVDcICWY/2OSiE/INKJ2LAhmcKjIL856cj2uz8ZdkAQ==
X-Received: by 2002:adf:efc6:: with SMTP id i6mr50750631wrp.428.1636124136345;
        Fri, 05 Nov 2021 07:55:36 -0700 (PDT)
Received: from ?IPv6:2003:f6:af04:5300:7c00:c62b:b3aa:158b? (p200300f6af0453007c00c62bb3aa158b.dip0.t-ipconnect.de. [2003:f6:af04:5300:7c00:c62b:b3aa:158b])
        by smtp.gmail.com with ESMTPSA id h16sm9250684wrm.27.2021.11.05.07.55.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Nov 2021 07:55:36 -0700 (PDT)
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org, Odin Ugedal <odin@uged.al>,
        Kevin Tanguy <kevin.tanguy@corp.ovh.com>,
        Brad Spengler <spender@grsecurity.net>
References: <b98e3434-67cd-34b7-9e81-148ea31a851c@grsecurity.net>
 <20211103190613.3595047-1-minipli@grsecurity.net>
 <20211104184939.GA23576@blackbody.suse.cz>
From:   Mathias Krause <minipli@grsecurity.net>
Subject: Re: [PATCH] sched/fair: Prevent dead task groups from regaining
 cfs_rq's
Message-ID: <b48a4e5f-a9b7-1aff-7f27-6b8fddc34da0@grsecurity.net>
Date:   Fri, 5 Nov 2021 15:55:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211104184939.GA23576@blackbody.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 04.11.21 um 19:49 schrieb Michal Koutný:
> On Wed, Nov 03, 2021 at 08:06:13PM +0100, Mathias Krause <minipli@grsecurity.net> wrote:
>> When unregister_fair_sched_group() unlinks all cfs_rq's from the dying
>> task group, it doesn't protect itself from getting interrupted. If the
>> timer interrupt triggers while we iterate over all CPUs or after
>> unregister_fair_sched_group() has finished but prior to unlinking the
>> task group, sched_cfs_period_timer() will execute and walk the list of
>> task groups, trying to unthrottle cfs_rq's, i.e. re-add them to the
>> dying task group. These will later -- in free_fair_sched_group() -- be
>> kfree()'ed while still being linked, leading to the fireworks Kevin and
>> Michal are seeing.
> 
> [...]
>  
>>     CPU1:                                      CPU2:
>>       :                                        timer IRQ:
>>       :                                          do_sched_cfs_period_timer():
>>       :                                            :
>>       :                                            distribute_cfs_runtime():
>>       :                                              rcu_read_lock();
>>       :                                              :
>>       :                                              unthrottle_cfs_rq():
>>     sched_offline_group():                             :
>>       :                                                walk_tg_tree_from(…,tg_unthrottle_up,…):
>>       list_del_rcu(&tg->list);                           :
>>  (1)  :                                                  list_for_each_entry_rcu(child, &parent->children, siblings)
>>       :                                                    :
>>  (2)  list_del_rcu(&tg->siblings);                         :
>>       :                                                    tg_unthrottle_up():
>>       unregister_fair_sched_group():                         struct cfs_rq *cfs_rq = tg->cfs_rq[cpu_of(rq)];
>>         :                                                    :
>>         list_del_leaf_cfs_rq(tg->cfs_rq[cpu]);               :
>>         :                                                    :
>>         :                                                    if (!cfs_rq_is_decayed(cfs_rq) || cfs_rq->nr_running)
>>  (3)    :                                                        list_add_leaf_cfs_rq(cfs_rq);
>>       :                                                      :
>>       :                                                    :
>>       :                                                  :
>>       :                                                :
>>       :                                              :
>>  (4)  :                                              rcu_read_unlock();
> 
> The list traversal (1) may happen in some scenarios (quota on non-leaf
> task_group) but in the presented reproducer, the quota is set on the
> leaf task_group. That means it has no children and this list iteration
> is irrelevant.
> The cause is that walk_tg_tree_from includes `from` task_group and
> calls tg_unthrottle_up() on it too.
> What I mean is that the unlinking of tg->list and tg->siblings is
> irrelevant in this case.

Interesting.

> The timer can still fire after
> sched_offline_group()/unregister_fair_sched_group() finished (i.e. after
> synchronize_rcu())

Yeah, I also noticed the timer gets disabled rather late, in
free_fair_sched_group() via destroy_cfs_bandwidth(). But as I saw no
more warnings from my debug patch I was under the impression,
do_sched_cfs_period_timer() won't see this thread group any more.
Apparently, this is not true?

Anyhow, see below.

>> This patch survives Michal's reproducer[2] for 8h+ now, which used to
>> trigger within minutes before.
> 
> Note that the reproducer is sensitive to the sleep between last task
> exit and cgroup rmdir. I assume that the added synchronize_rcu() before
> list_del_leaf_cfs_rq() shifted the list removal after the last timer
> callback and prevented re-adding of the offlined task_group in
> unthrottle_cfs_rq().

As Vincent reported in the other thread, synchronize_rcu() is actually
problematic, as we're not allowed to block here. :( So I'd go for the
kfree_rcu() route and move unregister_fair_sched_group() to
free_fair_sched_group(), after disabling the timers.

> (Of course, it'd more convincing if I backed this theory by results from
> the reproducer with the increased interval to crash again. I may get
> down to that later.)
> 
> Does your patch fix the crashes also in your real workload?

I haven't heard back from Kevin since. But he might just be busy.

Thanks,
Mathias
