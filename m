Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEB35392DE1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 14:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235126AbhE0MYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 08:24:30 -0400
Received: from foss.arm.com ([217.140.110.172]:56806 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234702AbhE0MY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 08:24:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0437513A1;
        Thu, 27 May 2021 05:22:56 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 00C963F73D;
        Thu, 27 May 2021 05:22:53 -0700 (PDT)
Subject: Re: [PATCH v5 2/3] sched/topology: Rework CPU capacity asymmetry
 detection
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Beata Michalska <beata.michalska@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org, corbet@lwn.net,
        rdunlap@infradead.org, linux-doc@vger.kernel.org
References: <20210524101617.8965-1-beata.michalska@arm.com>
 <20210524101617.8965-3-beata.michalska@arm.com> <87fsyc6mfz.mognet@arm.com>
 <20210524225508.GA14880@e120325.cambridge.arm.com>
 <87a6oj6sxo.mognet@arm.com>
 <20210525102945.GA24210@e120325.cambridge.arm.com>
 <98ad8837-b9b8-ff50-5a91-8d5951ee757c@arm.com>
 <YK9ESqNEo+uacyMD@hirez.programming.kicks-ass.net>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <315b4b5d-05f5-e311-8ed9-b55072cf84f9@arm.com>
Date:   Thu, 27 May 2021 14:22:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YK9ESqNEo+uacyMD@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/05/2021 09:03, Peter Zijlstra wrote:
> On Wed, May 26, 2021 at 11:52:25AM +0200, Dietmar Eggemann wrote:
> 
>> For me asym_cpu_capacity_classify() is pretty hard to digest ;-) But I
>> wasn't able to break it. It also performs correctly on (non-existing SMT)
>> layer (with sd span eq. single CPU).
> 
> This is the simplest form I could come up with this morning:
> 
> static inline int
> asym_cpu_capacity_classify(struct sched_domain *sd,
>                           const struct cpumask *cpu_map)
> {
> 	struct asym_cap_data *entry;
> 	int i = 0, n = 0;
> 
> 	list_for_each_entry(entry, &asym_cap_list, link) {
> 		if (cpumask_intersects(sched_domain_span(sd), entry->cpu_mask))
> 			i++;
> 		else
> 			n++;
> 	}
> 
> 	if (WARN_ON_ONCE(!i) || i == 1) /* no asymmetry */
> 		return 0;
> 
> 	if (n) /* partial asymmetry */
> 		return SD_ASYM_CPUCAPACITY;
> 
> 	/* full asymmetry */
> 	return SD_ASYM_CPUCAPACITY | SD_ASYM_CPUCAPACITY_FULL;
> }
> 
> 
> The early termination and everything was cute; but this isn't
> performance critical code and clarity is paramount.

This is definitely easier to grasp.

What about the missing `if (cpumask_intersects(entry->cpu_mask,
cpu_map))` condition in the else path to increment n?

Example:

cpus = {[446 446] [871 871] [1024 1024]}

So 3 asym_cap_list entries.

After hp'ing out CPU4 and CPU5:

DIE: 'partial asymmetry'

In case we would increment n only when the condition is met, we would
have `full asymmetry`.

I guess we want to allow EAS task placement, hence have
sd_asym_cpucapacity set in case there are only 446 and 871 left?

