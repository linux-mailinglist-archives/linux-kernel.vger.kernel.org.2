Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAE9D3DA9FD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 19:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbhG2RVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 13:21:15 -0400
Received: from foss.arm.com ([217.140.110.172]:53484 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229657AbhG2RVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 13:21:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D3D71FB;
        Thu, 29 Jul 2021 10:21:10 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E4913F73D;
        Thu, 29 Jul 2021 10:21:08 -0700 (PDT)
Subject: Re: [PATCH 2/2] sched: Don't report SCHED_FLAG_SUGOV in
 sched_getattr()
To:     Juri Lelli <juri.lelli@redhat.com>,
        Quentin Perret <qperret@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20210727101103.2729607-1-qperret@google.com>
 <20210727101103.2729607-3-qperret@google.com>
 <YQEfY730Sjkr3w+Y@localhost.localdomain> <YQEl2t2RgaB9eEOZ@google.com>
 <YQFPYIqJG5PSPH1S@localhost.localdomain>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <97c06d07-bb6a-e8b5-b230-390edd8bcfbe@arm.com>
Date:   Thu, 29 Jul 2021 19:21:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YQFPYIqJG5PSPH1S@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2021 14:36, Juri Lelli wrote:
> On 28/07/21 10:39, Quentin Perret wrote:
>> On Wednesday 28 Jul 2021 at 11:12:03 (+0200), Juri Lelli wrote:

[...]

>>> Maybe we can do this in the previous patch so that it's kept confined to
>>> deadline bits?
>>
>> That works too, it just felt like this could happen again if we start
>> using non-standard flags outside of deadline for any reason at some
>> point in the future. But no strong opinion really.
> 
> Yeah, I also see this point. :)
> 
> So no prob with me to keep it in core.c as you do here.
> 
> Best,
> Juri
> 

I would vote for not exporting SCHED_FLAG_SUGOV from __getparam_dl() in
patch 1/2 to underpin the idea that this flag is a hack.

@ -2759,7 +2759,7 @@ void __getparam_dl(struct task_struct *p, struct
sched_attr *attr)
        attr->sched_deadline = dl_se->dl_deadline;
        attr->sched_period = dl_se->dl_period;
        attr->sched_flags &= ~SCHED_DL_FLAGS;
-       attr->sched_flags |= dl_se->flags;
+       attr->sched_flags |= dl_se->flags & ~SCHED_FLAG_SUGOV;
