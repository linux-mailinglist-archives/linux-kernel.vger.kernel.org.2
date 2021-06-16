Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFBC13A9BD5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 15:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbhFPNWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 09:22:41 -0400
Received: from foss.arm.com ([217.140.110.172]:37186 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232949AbhFPNWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 09:22:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 832C931B;
        Wed, 16 Jun 2021 06:20:33 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 174803F719;
        Wed, 16 Jun 2021 06:20:31 -0700 (PDT)
Subject: Re: sched: Question about big and little cores system with SMP and
 EAS
To:     Peter Zijlstra <peterz@infradead.org>,
        Ley Foon Tan <lftan.linux@gmail.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Quentin Perret <qperret@google.com>
References: <CAFiDJ5-ZO=BuSwBPPPecZhLyjyipTLenQxgCK=t52Pj7r659sQ@mail.gmail.com>
 <YMni2eclmqf05cL4@hirez.programming.kicks-ass.net>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <c81ac071-c648-54ac-72ad-2dab0fa1dd4b@arm.com>
Date:   Wed, 16 Jun 2021 15:20:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YMni2eclmqf05cL4@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Quentin Perret <quentin.perret@arm.com>
+ Quentin Perret <qperret@google.com>

On 16/06/2021 13:39, Peter Zijlstra wrote:
> On Wed, Jun 16, 2021 at 07:29:26PM +0800, Ley Foon Tan wrote:
>> Hi all
>>
>> Would like to ask the experts here regarding the Symmetric
>> Multi-Processing mode (SMP) with Energy aware scheduler (EAS) support
>> on the big + little cores system.
> 
> And the you ask a question unrelated to either Symmetric MP or EAS :-)
> 
>> Hardware system:
>> Big and little cores have almost the same ISA, but the big core has
>> some extension instructions that little core doesn't have.
> 
> That problem is unrelated to big.Little / EAS, also by definition that
> is not SMP seeing how the 'S' is a blatant lie.
> 
> The simplest solution is to simply disallow usage of the extended ISA
> and force mandate the common subset. The complicated answer is something
> along the lines of:
> 
>   https://lkml.kernel.org/r/20210608180313.11502-1-will@kernel.org

We don't encourage asymmetric ISA extensions for EAS*/CAS** on
big.Little systems.
It would be simply a nightmare to schedule tasks on such systems.

The exception to this is the 'asymmetric 32-bit Soc' to support 32bit
legacy Apps. The nightmare for scheduling is reduced in this case to CPU
affinity, something the task scheduler has to live with already today.
(+ DL admission control for 32bit tasks).

*  Documentation/scheduler/sched-energy.rst
** Documentation/scheduler/sched-capacity.rst
