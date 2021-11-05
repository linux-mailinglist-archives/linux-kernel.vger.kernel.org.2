Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B808A44652F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 15:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbhKEOrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 10:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbhKEOrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 10:47:09 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8BEC061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 07:44:30 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id d5so14139866wrc.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 07:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3osXuZPM0CIjpDvKOd2/eycIEGooDm3rDaaca3FvesI=;
        b=YTslvDp5Fgvn8LLdp3Kq7jQlUD+dztLUGHFKNc30WlVQAYj08qHDmCXxHCrROpKHFh
         jaWBSdxF8ppWLqQFUPDs+NfikZOESMyqVeY0K0PGZK1P6774pTgr8j5SEL/kCEdZx8OU
         KHRtEvIQFZyqphq2NtrKMgO28Htk4i3/M5tX8GjRj24KkDQ/i7iqp9/vWagYgZ4gtyZz
         asTC9jNsEOev1KzQIBG94Z3I3EcCXwT8pKd1UQGrpNLxWpIsX0MIjOoQGh3DsrYZ8mOk
         0kXjwHEY7OneGuZ2KZo7tCOuBL2dtfHF1tSIGowUDf8WJ9KzEUzeOVVLJd/oEaga7Y/6
         zOqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3osXuZPM0CIjpDvKOd2/eycIEGooDm3rDaaca3FvesI=;
        b=s2D+rbICAw5CHrGg4Ivn6yG7iv7zgOMUE4hpcZyrFNaqJeW3Bc0QF8Li9w85ldwJ7J
         uj5lsK05yXFhiJ3ZohSH4jkgSKZI2+V9Rsdvq8gwcWLiV4EWnUKGLjmuPUHAQUjD4idI
         GMzWIEY/VLQm5BYigKt+w03lSCf92OgxE7GS1LkaWkI98CdxyJUatFMqSDvA9AjzYRRO
         eExbC3ODxjjkl1jNLEuQ5yc96PtI53VVfFa+VIa5Bi7g/FEFWeFQ6uaeOH3m2/JTXQJ6
         3KX3onVCIo5SFUDVfaarCkYJKBX0T1ykbZ3xPkNpbKsk1OuZTG/MKbd4wbks9//oCQWS
         cJXg==
X-Gm-Message-State: AOAM5322jNAJRLeMCXRPmU+EHs17IY+WH44mcv9nKWRvC4QTVbIzkh2+
        9/E9M10MZkl9nk5Kqtqd9+jljw==
X-Google-Smtp-Source: ABdhPJxgctQX0K+xuh3CAjcuJkGIn2q0XBjdGzGuk9Hc8VzUhPgwQHpY57vcwxGpD9n/WnfTuur3ZA==
X-Received: by 2002:adf:dd0a:: with SMTP id a10mr21654919wrm.60.1636123468823;
        Fri, 05 Nov 2021 07:44:28 -0700 (PDT)
Received: from ?IPv6:2003:f6:af04:5300:7c00:c62b:b3aa:158b? (p200300f6af0453007c00c62bb3aa158b.dip0.t-ipconnect.de. [2003:f6:af04:5300:7c00:c62b:b3aa:158b])
        by smtp.gmail.com with ESMTPSA id c15sm7896981wrs.19.2021.11.05.07.44.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Nov 2021 07:44:28 -0700 (PDT)
Subject: Re: [PATCH] sched/fair: Prevent dead task groups from regaining
 cfs_rq's
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Benjamin Segall <bsegall@google.com>,
        Ingo Molnar <mingo@redhat.com>,
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
 <a6a3c6c9-d5ea-59b6-8871-0f72bff38833@grsecurity.net>
 <CAKfTPtBxoKBRWs4Z3Pxsk8==Ka9SG7NS3LzfOV33-2UXfhSM=g@mail.gmail.com>
 <cd3778d3-6980-a804-47e3-82b09dc960a4@grsecurity.net>
 <CAKfTPtDthksitm02sLowDMKbWZ29efth-YcPi0zVSFqbaZfiMA@mail.gmail.com>
From:   Mathias Krause <minipli@grsecurity.net>
Message-ID: <8f4ed996-e6e5-75f4-b5fa-dffb7b7da05b@grsecurity.net>
Date:   Fri, 5 Nov 2021 15:44:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtDthksitm02sLowDMKbWZ29efth-YcPi0zVSFqbaZfiMA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 05.11.21 um 15:25 schrieb Vincent Guittot:
> On Thu, 4 Nov 2021 at 18:37, Mathias Krause <minipli@grsecurity.net> wrote:
>>
>> Am 04.11.21 um 17:49 schrieb Vincent Guittot:
>>> [snip]
>>>
>>> Ok so we must have 2 GPs:
>>>
>>> list_del_rcu(&tg->siblings);
>>> GP to wait for the end of ongoing walk_tg_tree_from : synchronize_rcu
>>> in your patch
>>> list_del_leaf_cfs_rq(tg->cfs_rq[cpu]); if on_list
>>> remove_entity_load_avg(tg->se[cpu]);
>>> GP to wait for the end of ongoing for_each_leaf_cfs_rq_safe (print_cfs_stats)
>>> kfree everything
>>
>> Basically yes, but with my patch we already have these two, as there's
>> at least one RCU GP between after sched_offline_group() finishes and
>> sched_free_group() / cpu_cgroup_css_free() starts.
>>
>> So we either use my patch as-is or move unregister_fair_sched_group() to
>> free_fair_sched_group() and use kfree_rcu() instead of kfree(). Both
>> approaches have pros and cons.
>>
>> Pro for my version is the early unlinking of cfs_rq's for dead task
>> groups, so no surprises later on. Con is the explicit synchronize_rcu().
> 
> which blocks the caller and could be problematic
> 
> It seems that LKP has reported such issue:
> 20211104145128.GC6499@xsang-OptiPlex-9020

Heh, indeed.

>>
>> Pro for the kfree_rcu() approach is the lack of the explicit
>> synchronize_rcu() call, so no explicit blocking operation. Con is that
>> we have cfs_rq's re-added to dead task groups which feels wrong and need
>> to find a suitable member to overlap with the rcu_head in each involved
>> data type.
>>
>> Which one do you prefer?

Looks like it needs to be the kfree_rcu() one in this case. I'll prepare
a patch.

Thanks,
Mathias
