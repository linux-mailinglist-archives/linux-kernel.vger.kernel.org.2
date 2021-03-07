Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 163A33303DD
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 19:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbhCGSUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 13:20:00 -0500
Received: from foss.arm.com ([217.140.110.172]:54594 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230425AbhCGSTu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 13:19:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67A9ED6E;
        Sun,  7 Mar 2021 10:19:50 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC2C93F73C;
        Sun,  7 Mar 2021 10:19:48 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     "Song Bao Hua \(Barry Song\)" <song.bao.hua@hisilicon.com>,
        "vincent.guittot\@linaro.org" <vincent.guittot@linaro.org>,
        "mingo\@redhat.com" <mingo@redhat.com>,
        "peterz\@infradead.org" <peterz@infradead.org>,
        "juri.lelli\@redhat.com" <juri.lelli@redhat.com>,
        "dietmar.eggemann\@arm.com" <dietmar.eggemann@arm.com>,
        "rostedt\@goodmis.org" <rostedt@goodmis.org>,
        "bsegall\@google.com" <bsegall@google.com>,
        "mgorman\@suse.de" <mgorman@suse.de>
Cc:     "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm\@openeuler.org" <linuxarm@openeuler.org>
Subject: RE: [PATCH] sched/topology: remove redundant cpumask_and in init_overlap_sched_group
In-Reply-To: <27e60cb105e040deb16af774399db15e@hisilicon.com>
References: <20210304222944.32504-1-song.bao.hua@hisilicon.com> <jhjeegt7rdg.mognet@arm.com> <27e60cb105e040deb16af774399db15e@hisilicon.com>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Sun, 07 Mar 2021 18:19:43 +0000
Message-ID: <jhj8s6y7rnk.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/03/21 20:25, Song Bao Hua (Barry Song) wrote:
>> -----Original Message-----
>> From: Valentin Schneider [mailto:valentin.schneider@arm.com]
>> Sent: Saturday, March 6, 2021 12:49 AM
>> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>;
>> vincent.guittot@linaro.org; mingo@redhat.com; peterz@infradead.org;
>> juri.lelli@redhat.com; dietmar.eggemann@arm.com; rostedt@goodmis.org;
>> bsegall@google.com; mgorman@suse.de
>> Cc: linux-kernel@vger.kernel.org; linuxarm@openeuler.org; Song Bao Hua (Barry
>> Song) <song.bao.hua@hisilicon.com>
>> Subject: Re: [PATCH] sched/topology: remove redundant cpumask_and in
>> init_overlap_sched_group
>>
>> On 05/03/21 11:29, Barry Song wrote:
>> > mask is built in build_balance_mask() by for_each_cpu(i, sg_span), so
>> > it must be a subset of sched_group_span(sg).
>>
>> So we should indeed have
>>
>>   cpumask_subset(sched_group_span(sg), mask)
>>
>> but that doesn't imply
>>
>>   cpumask_first(sched_group_span(sg)) == cpumask_first(mask)
>>
>> does it? I'm thinking if in your topology of N CPUs, CPUs 0 and N-1 are the
>> furthest away, you will most likely hit
>
> It is true:
> cpumask_first(sched_group_span(sg)) != cpumask_first(mask)
>
> but
>
> cpumask_first_and(sched_group_span(sg), mask) = cpumask_first(mask)
>
> since mask is always subset of sched_group_span(sg).
>

You're right, I read it the wrong way around, sorry about that.

Reviewed-by: Valentin Schneider <Valentin.Schneider@arm.com>
