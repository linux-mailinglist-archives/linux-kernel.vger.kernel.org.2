Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77DDB44433A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 15:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbhKCOTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 10:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbhKCOTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 10:19:13 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CEEC061203
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 07:16:36 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id i5so3840417wrb.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 07:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=737JPmdviG+HYxTa2mZiLm53jNQ3R1sfaGvgdUd+sAo=;
        b=UXM6hfddfNIocHN3LD2D1o+9CstFpmTBNB7K9vMflO4eDi/CxuRxez+It7+3axyhGe
         yGSywRpyOLPSSWJaMuAUPzq5xGZBAidwDCl+0l2qVGrU2p+Mo+hhyDhF07+karkcTdRu
         4y79REUS8IgO6Fowgiq35etsLwmrTVnLxo1Y+EBwLS9RUFp7MnfZdRe3AsAKdPcy9qY7
         cjWLuJ7cu4yQQNi5BMV3lph8ad8GTM6ufqhZlY/1KbUhFPfNScveXM9VEdIo9WmKeb8g
         vJbc1R0UNDUVqWvHFgxUHgFZubPVPGK/IjWNQi33awvG5x717PdcQTNMuqhBK9EfhtNc
         ICUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=737JPmdviG+HYxTa2mZiLm53jNQ3R1sfaGvgdUd+sAo=;
        b=W/wzhT3Z+7H3Qq20TgejwOwyT+bQd/U7JqDjFBOqLEDpBdrrDoOsFx3Gam+rx0K8QH
         kRaOuWzCQoYwvbl1u4evBPFWe43DQugPSnCxYzPIpcmau7Kv7TACSaDC0PFH1PvjNWgb
         RcnHLEx3GVeBdvuByyvZJ+7dNeusBLnFnWJ1L10XKVJ6rEW28Tm5vkPZVjp25thD7JDZ
         8tZBZ6wuiiak8izVo8vWt1IBWIsxiVcp8wvZk1FrPNR4x+mdTtWvE93JtsU0TKfWXRyZ
         xr/rSHQJZ+TjhR8PZargFGYXwUwozfd63xNzlNKST+PHEHpvlaSOEhCRPEN9hnbVNYZB
         KQzA==
X-Gm-Message-State: AOAM533j80ed2kzCtMSO/de+EkVSbmuZmdPRXupaLTEeuR+wuTRz+bQX
        Tdi54dHXjFLNqQlhcowKgw0QW8DVLtqQag15
X-Google-Smtp-Source: ABdhPJyo9Pb2z4g4MB1LMaQoYVpjlNMyXK2hs/REOQ6adZ7L4ZqAsrtBoNiztsFNbWA3hLEbE3g9Fg==
X-Received: by 2002:a5d:5144:: with SMTP id u4mr49725580wrt.91.1635948994987;
        Wed, 03 Nov 2021 07:16:34 -0700 (PDT)
Received: from [192.168.24.132] (pd9fe9a3e.dip0.t-ipconnect.de. [217.254.154.62])
        by smtp.gmail.com with ESMTPSA id e12sm2498794wrq.20.2021.11.03.07.16.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Nov 2021 07:16:34 -0700 (PDT)
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Odin Ugedal <odin@uged.al>,
        Kevin Tanguy <kevin.tanguy@corp.ovh.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20211011172236.11223-1-mkoutny@suse.com>
 <CAKfTPtAQmqgAiNGqk9xRmiB4_dzHxaKK68+fWwea25mZv0kT2w@mail.gmail.com>
 <20211013142643.GA48428@blackbody.suse.cz>
 <20211102160228.GA57072@blackbody.suse.cz>
 <73b4bddb-335b-1f25-a203-199be546e44a@grsecurity.net>
 <e2bcfc90-18b6-8da5-517c-023d2242ba97@grsecurity.net>
 <20211103111036.GA10034@blackbody.suse.cz>
From:   Mathias Krause <minipli@grsecurity.net>
Subject: Re: task_group unthrottling and removal race (was Re: [PATCH]
 sched/fair: Use rq->lock when checking cfs_rq list) presence
Message-ID: <b98e3434-67cd-34b7-9e81-148ea31a851c@grsecurity.net>
Date:   Wed, 3 Nov 2021 15:16:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211103111036.GA10034@blackbody.suse.cz>
Content-Type: multipart/mixed;
 boundary="------------96D01DF2FF86D0996DCA7449"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------96D01DF2FF86D0996DCA7449
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Am 03.11.21 um 12:10 schrieb Michal Koutný:
> On Wed, Nov 03, 2021 at 11:51:12AM +0100, Mathias Krause <minipli@grsecurity.net> wrote:
>> Adding synchronize_rcu() here will ensure all concurrent RCU "readers"
>> will have finished what they're doing, so we can unlink safely. That
>> was, apparently, the missing piece.
> 
> What reader(s) are you referring to here? The
> list_for_each_entry_rcu(cfs_rq, &cfs_b->throttled_cfs_rq,
> throttled_list) in distribute_cfs_runtime()?

Let me quote a little bit more context here to explain my rationale:

>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 978460f891a1..afee07e9faf9 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -9506,13 +9506,17 @@ void sched_offline_group(struct task_group *tg)
>>  {
>>  	unsigned long flags;
>>
>> -	/* End participation in shares distribution: */
>> -	unregister_fair_sched_group(tg);
>> -
>> +	/*
>> +	 * Unlink first, to avoid walk_tg_tree_from() from finding us
>> +	 * (via sched_cfs_period_timer()).
>> +	 */

>>  	spin_lock_irqsave(&task_group_lock, flags);
>>  	list_del_rcu(&tg->list);
>>  	list_del_rcu(&tg->siblings);
>>  	spin_unlock_irqrestore(&task_group_lock, flags);

The above list_del_rcu() implies there are users that use RCU semantics
to walk the lists, namely tg->list and tg->siblings. And, in fact,
walk_tg_tree_from() does just that:

    [...]
    list_for_each_entry_rcu(child, &parent->children, siblings) {
        [...]
    }

Now, taking the task_group_lock in sched_offline_group() just prevents
multiple users from entering this code path. But walk_tg_tree_from()
does not take that lock, so can walk the task group hierarchy concurrently.

Disabling IRQs also doesn't protect us from do_sched_cfs_period_timer()
running in parallel, as the timer interrupt might fire on a different
CPU than the one we're currently running on.

So, assuming the scenario in race.txt (sorry, my mailer is just too dump
for bigger ASCI art), CPU2 will walk the task group list in parallel to
sched_offline_group(), specifically it'll read the soon to be unlinked
task group entry in (1). So removing it on CPU1 in (2) won't prevent
CPU2 from still passing it on to tg_unthrottle_up(). Assuming
unregister_fair_sched_group() on CPU1 now tries to unlink all cfs_rq's
via calls to list_del_leaf_cfs_rq(), CPU2 will re-add some in (3), which
is the cause of the UAF later on. Now, if we would add a
synchronize_rcu() prior to calling unregister_fair_sched_group(), we
would wait until the walk on CPU2 has finished at (4). Afterwards each
new walk won't see the dying task group any more, thereby preventing the
UAF from happening. Or am I missing something?

>> +
>> +	/* End participation in shares distribution: */
> 
> Adding synchronize_rcu() here will ensure all concurrent RCU "readers"
> will have finished what they're doing, so we can unlink safely. That
> was, apparently, the missing piece.
> 
>> +	unregister_fair_sched_group(tg);
>>  }
>>
>>  static void sched_change_group(struct task_struct *tsk, int type)
>>

Btw, the above patch (plus the warning debug patch) is running your
reproducer here for 3.5h without triggering any warnings. It used to
trigger them within the first few minutes.

> I'm think (not sure) that wouldn't work since the unthrottle_cfs_rq can
> still be called after this synchronize_rcu() but before
> free_fair_sched_group().

Sure, but it won't see the dying task group any more. So won't re-add
cfs_rq's to them, preventing the UAF from happening.

> (But if you considered update_blocked_averages() as the reader(s) and
> synchronize_rcu() within free_fair_sched_group(), that may ensure UBA
> won't step on a free'd cfs_rq (+unlinking would need to happen only in
> free_fair_sched_group() too.))

I'd prefer not linking cfs_rq's to a dead tg. Trying to cover up just
before we're about to free the memory feels hacky.

Thanks,
Mathias

--------------96D01DF2FF86D0996DCA7449
Content-Type: text/plain; charset=UTF-8;
 name="race.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="race.txt"

ICBDUFUxOiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQ1BVMjoK
ICAgIDogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdGltZXIg
SVJROgogICAgOiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGRvX3NjaGVkX2Nmc19wZXJpb2RfdGltZXIoKToKICAgIDogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIDoKICAgIDogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRpc3RyaWJ1dGVfY2ZzX3J1bnRpbWUoKToK
ICAgIDogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
cmN1X3JlYWRfbG9jaygpOwogICAgOiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICA6CiAgICA6ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHVudGhyb3R0bGVfY2ZzX3JxKCk6CiAgc2NoZWRfb2ZmbGlu
ZV9ncm91cCgpOiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgOgogICAgOiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHdhbGtfdGdf
dHJlZV9mcm9tKOKApix0Z191bnRocm90dGxlX3VwLOKApik6CiAgICBsaXN0X2RlbF9yY3Uo
JnRnLT5saXN0KTsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA6CigxKSA6ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBsaXN0X2Zv
cl9lYWNoX2VudHJ5X3JjdShjaGlsZCwgJnBhcmVudC0+Y2hpbGRyZW4sIHNpYmxpbmdzKQog
ICAgOiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICA6CigyKSBsaXN0X2RlbF9yY3UoJnRnLT5zaWJsaW5ncyk7ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIDoKICAgIDogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgdGdfdW50aHJvdHRsZV91cCgpOgogICAgdW5yZWdpc3Rl
cl9mYWlyX3NjaGVkX2dyb3VwKCk6ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVj
dCBjZnNfcnEgKmNmc19ycSA9IHRnLT5jZnNfcnFbY3B1X29mKHJxKV07CiAgICAgIDogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgOgog
ICAgICBsaXN0X2RlbF9sZWFmX2Nmc19ycSh0Zy0+Y2ZzX3JxW2NwdV0pOyAgICAgICAgICAg
ICAgICAgIDoKICAgICAgOiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICA6CiAgICAgIDogICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKCFjZnNfcnFfaXNfZGVjYXllZChjZnNf
cnEpIHx8IGNmc19ycS0+bnJfcnVubmluZykKKDMpICAgOiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbGlzdF9hZGRfbGVhZl9j
ZnNfcnEoY2ZzX3JxKTsKICAgIDogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICA6CiAgICA6ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDoKICAgIDogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDoKICAgIDogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA6CiAgICA6ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDoKKDQpIDogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmN1X3JlYWRf
dW5sb2NrKCk7Cg==
--------------96D01DF2FF86D0996DCA7449--
