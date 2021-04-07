Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6E8C356E35
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 16:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348130AbhDGOLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 10:11:54 -0400
Received: from foss.arm.com ([217.140.110.172]:57824 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234134AbhDGOLx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 10:11:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5BFAA1FB;
        Wed,  7 Apr 2021 07:11:43 -0700 (PDT)
Received: from [10.57.54.6] (unknown [10.57.54.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 590DC3F792;
        Wed,  7 Apr 2021 07:11:40 -0700 (PDT)
From:   Pierre <pierre.gondois@arm.com>
Subject: Re: [PATCH] sched/fair: use signed long when compute energy delta in
 eas
To:     Xuewen Yan <xuewen.yan94@gmail.com>,
        Dietmar Eggemann <Dietmar.Eggemann@arm.com>, qperret@google.com
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Ryan Y <xuewyan@foxmail.com>
References: <20210330052154.26861-1-xuewen.yan94@gmail.com>
 <YGLzQAvVqlrKb8AB@google.com> <34ce11ad-9c20-7ba7-90d8-4830725bf38a@arm.com>
 <CAB8ipk9JATYxJBnpVFfH_XHLqh=yHesbo73wx=Mm7t8mSqW_Gg@mail.gmail.com>
Message-ID: <1ebddd33-4666-1e6e-7788-a3fe28c9e99c@arm.com>
Date:   Wed, 7 Apr 2021 15:11:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CAB8ipk9JATYxJBnpVFfH_XHLqh=yHesbo73wx=Mm7t8mSqW_Gg@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
> I test the patch, but the overflow still exists.
> In the "sched/fair: Use pd_cache to speed up find_energy_efficient_cpu()"
> I wonder why recompute the cpu util when cpu==dst_cpu in compute_energy(),
> when the dst_cpu's util change, it also would cause the overflow.

The patches aim to cache the energy values for the CPUs whose 
utilization is not modified (so we don't have to compute it multiple 
times). The values cached are the 'base values' of the CPUs, i.e. when 
the task is not placed on the CPU. When (cpu==dst_cpu) in 
compute_energy(), it means the energy values need to be updated instead 
of using the cached ones.

You are right, there is still a possibility to have a negative delta 
with the patches at:
https://gitlab.arm.com/linux-arm/linux-power/-/commits/eas/next/integration-20210129
Adding a check before subtracting the values, and bailing out in such 
case would avoid this, such as at:
https://gitlab.arm.com/linux-arm/linux-pg/-/commits/feec_bail_out/

I think a similar modification should be done in your patch. Even though 
this is a good idea to group the calls to compute_energy() to reduce the 
chances of having updates of utilization values in between the 
compute_energy() calls,
there is still a chance to have updates. I think it happened when I 
applied your patch.

About changing the delta(s) from 'unsigned long' to 'long', I am not 
sure of the meaning of having a negative delta. I thing it would be 
better to check and fail before it happens instead.

Regards

