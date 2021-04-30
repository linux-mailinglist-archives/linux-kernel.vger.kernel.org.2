Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F64A36F8EA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 13:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbhD3LFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 07:05:02 -0400
Received: from foss.arm.com ([217.140.110.172]:45636 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229543AbhD3LFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 07:05:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE8A5ED1;
        Fri, 30 Apr 2021 04:04:01 -0700 (PDT)
Received: from [10.57.29.245] (unknown [10.57.29.245])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D2F73F70D;
        Fri, 30 Apr 2021 04:03:58 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] sched/fair: Only compute base_energy_pd if
 necessary
To:     Pierre.Gondois@arm.com
Cc:     linux-kernel@vger.kernel.org, xuewen.yan@unisoc.com,
        qperret@qperret.net, dietmar.eggemann@arm.com,
        Vincent.Donnefort@arm.com, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
References: <20210429101948.31224-1-Pierre.Gondois@arm.com>
 <20210429101948.31224-2-Pierre.Gondois@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <c7dba0eb-9e82-06ff-299c-aa3fc28c1107@arm.com>
Date:   Fri, 30 Apr 2021 12:03:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20210429101948.31224-2-Pierre.Gondois@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre,

On 4/29/21 11:19 AM, Pierre.Gondois@arm.com wrote:
> From: Pierre Gondois <Pierre.Gondois@arm.com>
> 
> find_energy_efficient_cpu() searches the best energy CPU
> to place a task on. To do so, the energy of each performance domain
> (pd) is computed w/ and w/o the task placed in each pd.
> 
> The energy of a pd w/o the task (base_energy_pd) is computed prior
> knowing whether a CPU is available in the pd.
> 
> Move the base_energy_pd computation after looping through the CPUs
> of a pd and only computes it if at least one CPU is available.
> 
> Suggested-by: Xuewen Yan <xuewen.yan@unisoc.com>
> Signed-off-by: Pierre Gondois <Pierre.Gondois@arm.com>
> ---
>   kernel/sched/fair.c | 38 ++++++++++++++++++++++----------------
>   1 file changed, 22 insertions(+), 16 deletions(-)
> 

Make sense. I will speed-up feec() on Android devices for tasks
being moved into 'background' cgroup (limited to subset of CPUs,
e.g. to only Little cores). LGTM.

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Regards,
Lukasz
