Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03918446805
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 18:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbhKERmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 13:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbhKERmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 13:42:54 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13528C061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 10:40:14 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id o4-20020a1c7504000000b0032cab7473caso7156210wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 10:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MOlxXXwYAdTlFvZzrk87+YU73kZFfsVil59MoDSPjJw=;
        b=NDbD1m0+Isz2boRWDrdWYCFIq8jQlSJ9x+g2EQVSlhOYS0ZpS5mD+XZZW2TPU4mPO0
         d0T34sJcxjuyQn8hPPkZJ1aOiEX4gFKqfFSB+Tuy4wRrXVU/R7HzCOG8vwqAwhn2ex+h
         iduoJLxXn5ZEgBTNkcOQQWLOv7ZukXPSRxMzzykHTUhE44Be7UGsiqJvmIlloOBZwcML
         0u43sOIEGkzDEFNx38TOEp5v3I53MnsivObnKMM8JRc6XiyMduvoG4yn7Su+j/jr1soU
         2D7Hzo2ICZbln5LUOkhYIC79AHz+ahtcJh953rH0LuXxL2FtY2P4smgZ2m0hZlt+7WKs
         eMsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MOlxXXwYAdTlFvZzrk87+YU73kZFfsVil59MoDSPjJw=;
        b=0o0BCERfqezNIETmDyWUBfuELwe4TKqjUJuFXHwBJVR79bmGrWi31nRmrUJ1FUZYTd
         bLSgHtYSE28I5y5dGut+RZc//LwA2FYlyv5fuC1f30ezu+fjnpNEnDuxNWNnK6l3YXpY
         n104AoQvjEPziyRvfyQQDq7rsgqO08uTvn386BypHOL8UNAbAfWUVY1+wWKtq2da9IBF
         2PUqcSHlihnujzqf4YlscJWUp8xFQwytTFNSqFq/XFxKPPUsCzJ9mMrd/ffdN2dDP0yD
         1hcjHNr62EWKOIEDJl4BZXAcSfaPwjK+sFU0cdPDqthb6DNEL3ixTHzq4RYyvi7Mtzug
         xGQA==
X-Gm-Message-State: AOAM533n6ihfuaaOylZFQZKkI7GIkcONnZo2SgungOrmVy2M0V/DFhMi
        wDhoAsIrVo7rIiI4jMtMcyrB4w==
X-Google-Smtp-Source: ABdhPJyjwYjkjrYJlkc8k9AIOS5EDd/qa/IP3bN5vhRY/R/O/PzrBbp1l7NgP065m5NVYMMeb1Z36g==
X-Received: by 2002:a1c:447:: with SMTP id 68mr32177094wme.69.1636134012652;
        Fri, 05 Nov 2021 10:40:12 -0700 (PDT)
Received: from ?IPv6:2003:f6:af04:5300:7c00:c62b:b3aa:158b? (p200300f6af0453007c00c62bb3aa158b.dip0.t-ipconnect.de. [2003:f6:af04:5300:7c00:c62b:b3aa:158b])
        by smtp.gmail.com with ESMTPSA id m125sm11666647wmm.39.2021.11.05.10.40.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Nov 2021 10:40:12 -0700 (PDT)
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Benjamin Segall <bsegall@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        linux-kernel@vger.kernel.org, Odin Ugedal <odin@uged.al>,
        Kevin Tanguy <kevin.tanguy@corp.ovh.com>,
        Brad Spengler <spender@grsecurity.net>
References: <xm26ilx86gmp.fsf@google.com>
 <CAKfTPtBm4vHr=svju=Qg6eZmcv8YDghtM2r_pOahZ2gC3tzTxg@mail.gmail.com>
 <a6a3c6c9-d5ea-59b6-8871-0f72bff38833@grsecurity.net>
 <CAKfTPtBxoKBRWs4Z3Pxsk8==Ka9SG7NS3LzfOV33-2UXfhSM=g@mail.gmail.com>
 <cd3778d3-6980-a804-47e3-82b09dc960a4@grsecurity.net>
 <CAKfTPtDthksitm02sLowDMKbWZ29efth-YcPi0zVSFqbaZfiMA@mail.gmail.com>
 <8f4ed996-e6e5-75f4-b5fa-dffb7b7da05b@grsecurity.net>
 <20211105162914.215420-1-minipli@grsecurity.net>
 <YYVim5qpteqfwYjx@hirez.programming.kicks-ass.net>
 <a113044b-b5b6-8bc1-864b-c817535889ff@grsecurity.net>
 <YYVpm7LRWMZMzxId@hirez.programming.kicks-ass.net>
From:   Mathias Krause <minipli@grsecurity.net>
Subject: Re: [PATCH] sched/fair: Prevent dead task groups from regaining
 cfs_rq's
Message-ID: <00ec3c8e-6462-5cc4-ab79-e8887bcedad8@grsecurity.net>
Date:   Fri, 5 Nov 2021 18:40:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YYVpm7LRWMZMzxId@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 05.11.21 um 18:27 schrieb Peter Zijlstra:
> On Fri, Nov 05, 2021 at 06:14:33PM +0100, Mathias Krause wrote:
>> Am 05.11.21 um 17:58 schrieb Peter Zijlstra:
>>> On Fri, Nov 05, 2021 at 05:29:14PM +0100, Mathias Krause wrote:
>>>>> Looks like it needs to be the kfree_rcu() one in this case. I'll prepare
>>>>> a patch.
>>>>
>>>> Testing the below patch right now. Looking good so far. Will prepare a
>>>> proper patch later, if we all can agree that this covers all cases.
>>>>
>>>> But the basic idea is to defer the kfree()'s to after the next RCU GP,
>>>> which also means we need to free the tg object itself later. Slightly
>>>> ugly. :/
>>>
>>> Can't we add an rcu_head to struct task_group and simply call_rcu() the
>>> thing with a free function?
>>
>> There is already one and this patch makes use of it for the second RCU
>> GP requirement. Basically, the patch is doing what you request, no? See
>> the new free_fair_sched_group().
> 
> For some reason I thought you still did kfree_rcu(), I suppose reading
> is hard. I'll give it another go after dinner.

I wanted to go for kfree_rcu() initially, true. But after realizing,
that adding a rcu_head to struct cfs_rg, sched_entity and task_group
(which already has one) might be too much for what's needed, I went the
call_rcu() route instead and re-used the rcu_head of task_group.

Actually re-using the rcu_head in task_group is safe, as we'll use it
only sequentially: first in sched_destroy_group() to schedule
sched_free_group_rcu() and then, when it's executing, in
free_fair_sched_group() to schedule free_tg().

rcu_head's get unlinked prior to getting their callback function
invoked, which makes the above a valid use case.

Thanks,
Mathias
