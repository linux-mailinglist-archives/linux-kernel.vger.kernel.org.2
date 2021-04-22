Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 843A3367E2E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 11:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235491AbhDVJzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 05:55:55 -0400
Received: from foss.arm.com ([217.140.110.172]:49222 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230270AbhDVJzx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 05:55:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C9B211D4;
        Thu, 22 Apr 2021 02:55:18 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CDC8C3F774;
        Thu, 22 Apr 2021 02:55:15 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Oliver Sang <oliver.sang@intel.com>
Cc:     0day robot <lkp@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        ying.huang@intel.com, feng.tang@intel.com, zhengjun.xing@intel.com,
        Lingutla Chandrasekhar <clingutla@codeaurora.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Quentin Perret <qperret@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Rik van Riel <riel@surriel.com>, aubrey.li@linux.intel.com,
        yu.c.chen@intel.com
Subject: Re: [sched/fair]  38ac256d1c:  stress-ng.vm-segv.ops_per_sec -13.8% regression
In-Reply-To: <20210422074742.GE31382@xsang-OptiPlex-9020>
References: <20210414052151.GB21236@xsang-OptiPlex-9020> <87im4on5u5.mognet@arm.com> <20210421032022.GA13430@xsang-OptiPlex-9020> <87bla8ue3e.mognet@arm.com> <20210422074742.GE31382@xsang-OptiPlex-9020>
Date:   Thu, 22 Apr 2021 10:55:10 +0100
Message-ID: <87wnsutzi9.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/21 15:47, Oliver Sang wrote:
> hi, Valentin Schneider,
>
> On Wed, Apr 21, 2021 at 11:27:49AM +0100, Valentin Schneider wrote:
>> On 21/04/21 11:20, Oliver Sang wrote:
>> > what's the machine model you used upon which the regression cannot be reproduced?
>> > we could check if we have similar model then re-check on the our machine.
>> >
>> 
>> I tested this on:
>> o Ampere eMAG (arm64, 32 cores)
>> o 2-socket Xeon E5-2690 (x86, 40 cores)
>> 
>> and found at worse a -0.3% regression and at best a 2% improvement. I know
>> that x86 box is somewhat ancient, but it's been my go-to "have I broken
>> x86?" test victim for a while :-)
>
> we don't have exactly 2-socket Xeon E5-2690 model, but we have one:
> Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz (2-socket, 48 cores with 112G memory)
> the test on it shows the regression is existing, too. but smaller (-5.3%)
> hope it's helpful
>

It is, thank you for trying this out on another system and figuring out
it's still visible! I'll go find myself some other x86 box and dig into it;
I'd rather not leave this hanging for too long.
