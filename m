Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 308DF43D933
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 04:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbhJ1CLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 22:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbhJ1CLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 22:11:48 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0C1C061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 19:09:22 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id ls14-20020a17090b350e00b001a00e2251c8so3480271pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 19:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ble7IOfIzEnbv79a3b0quJyLS4gPTJh6sayl/P2HbZ8=;
        b=F29KAFYyi5qsU0b/7DAgW3WiBN14CEGx9TCOXbOUFzoUaQpZJIKyQP41DDNJULgkFj
         dUEJ4rALkdh9n8qIZeYvnqDpxV8w5IlB7ZBLV0/dC8DvusDNhaFJXWCopQz4QBDACWqC
         ufTgCmwyyALsT7wDa69OAklzeVGLOy2A/xR3YEM3cVU/5vw1D3M8TzQtV9TCLHVjNRBp
         xneiX9JBG3WhPaYfj+LJGNh6fIowl+84IgF4Z5FLxEMEFuI3gMgBu5W36VCf3+F5cICy
         ECGFdKQ81udt0Isx+eTWv7bxvUnDxGAzeizftZnGqrJ8HsVAhepH+mbTd2iSOtzW+nW7
         +mrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ble7IOfIzEnbv79a3b0quJyLS4gPTJh6sayl/P2HbZ8=;
        b=fQhYmVItC5OU4mhdrGNrvBh6nlx7ci85GTyyWH4yI+FroDuuctq4D2pQG4LpNnFEWa
         RVWQiCVSztDQcycisb8bIRRBT2x4DJZMDk30yUjzNdpPbVH1j/+mNo6tMbZS8BOCHACN
         4d8laacG9WGKvd2Tf8P6lXEaYokzFZZmDwZZ1wpW/bx4VizsaDLLnWmyx1sc572gARnT
         Yr64E5qyj7u2AYYC4gmiqCcI+r36Rl7aBv9fs0G3BMtQcK4kMnhem6Mbpne3AkxsOKte
         YkzdZDzclHM0CKCboiQHW8qutg8W/XS1penXxLOX50/Ytgp+E408xjz2P3zY8Q9jm2Fo
         NyWg==
X-Gm-Message-State: AOAM530xIorRKEXR0LxrP6WGkXS45Bvhr8TkBKPU+ewUgU06VLJjbB0U
        Xyab4Sf+DEl4g+qkKirdQPs=
X-Google-Smtp-Source: ABdhPJwSJQspPMDu5TeijBbMIe46c7wd8EFgFUy0qAaVAuAaT2bfyh9Boiz7/TsVfIRwjJqcXTAn3A==
X-Received: by 2002:a17:90a:9906:: with SMTP id b6mr9592628pjp.180.1635386962156;
        Wed, 27 Oct 2021 19:09:22 -0700 (PDT)
Received: from [192.168.255.10] ([203.205.141.111])
        by smtp.gmail.com with ESMTPSA id z22sm1290185pfe.1.2021.10.27.19.09.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Oct 2021 19:09:21 -0700 (PDT)
Message-ID: <165924b0-e000-cc86-dff9-8bd250827e0f@gmail.com>
Date:   Thu, 28 Oct 2021 10:08:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.0
Subject: Re: [RFC PATCH] sched/fair: use max_spare_cap_cpu if it is more
 energy efficient
Content-Language: en-US
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Xuewen Yan <xuewen.yan94@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1634804594-4163-1-git-send-email-brookxu.cn@gmail.com>
 <CAB8ipk_1-ZMMcaLiLGYBT3N3S_VdeGMhYmCqGytcAwmPE4Ni2g@mail.gmail.com>
 <d51b64b2-8efc-898b-d836-2917b5cf2d85@arm.com>
From:   brookxu <brookxu.cn@gmail.com>
In-Reply-To: <d51b64b2-8efc-898b-d836-2917b5cf2d85@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Dietmar Eggemann wrote on 2021/10/25 9:04 下午:
> On 22/10/2021 06:05, Xuewen Yan wrote:
>> Hi Chunguang
>>
>> brookxu <brookxu.cn@gmail.com> 于2021年10月21日周四 下午4:24写道：
>>>
>>> From: Chunguang Xu <brookxu@tencent.com>
>>>
>>> When debugging EAS, I found that if the task is migrated to
>>> max_spare_cap_cpu, even if the power consumption of pd is lower,
> 
> The task p hasn't been migrated yet. `max_spare_cap_cpu` here is only a
> potential candidate CPU to be selected for p.
> 
>>> we still put the task on prev_cpu. Maybe we should fix it.
>>>
>>> Signed-off-by: Chunguang Xu <brookxu@tencent.com>
>>> ---
>>>  kernel/sched/fair.c | 4 +++-
>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index ff69f245b939..2ae7e03de6d2 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -6867,8 +6867,10 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>>>                 /* Evaluate the energy impact of using max_spare_cap_cpu. */
>>>                 if (max_spare_cap_cpu >= 0) {
>>>                         cur_delta = compute_energy(p, max_spare_cap_cpu, pd);
>>> -                       if (cur_delta < base_energy_pd)
>>
>> this is aimed to prevent the cur_delta < 0, and usuallly, when the
>> task was put on the max_spare_cpu, the cur_power should be bigger than
>> base_pd_power,
>> if the cur_power < base_pd_power, the cpu util may have changed, at
>> this time, we should keep prev_cpu.
>>
>> You can look at below discuss and patch:
>> https://lore.kernel.org/all/20210429101948.31224-3-Pierre.Gondois@arm.com/
>> https://lore.kernel.org/all/CAB8ipk_vgtg5d1obH36BYfNLZosbwr2k_U3xnAD4=H5uZt_M_g@mail.gmail.com/
> 
> That's correct. `prev_delta < base_energy_pd` or `cur_delta <
> base_energy_pd` indicate the rare case that `compute_energy() { ->
> cpu_util_next() -> cpu util }` returns a higher energy value for the
> perf domain w/o the task p than w/ it.
> 
> `base_energy_pd` stands for the energy spend on the CPUs of the Perf
> Domain (PD) w/o considering the task p (compute_energy(p, *-1*, pd)),
> `dst_cpu == -1`.
> 
> If this happens to a candidate CPU (prev_cpu or a per-PD
> max_spare_cap_cpu) we bail out and return target (i.e. prev_cpu) because
> we can't compare the energy values (prev_delta and best_delta) later on
> in this case.

Right, thanks all :)

> [...]
> 
