Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46EFF3AD2E1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 21:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234518AbhFRTdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 15:33:09 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:16312 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234180AbhFRTcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 15:32:53 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624044643; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=ngtIxYdkcY1ZGO7iP/NKgURChnlfcoICCHRSQ31Yuhs=; b=SUzyrsiA8tQlutVARP1Et6sExin9KATsZ80g5HRLx+f3TSFRjSzHLZVzlZNav6gIb80maY4A
 NM0TbT7BCTldyEkgHIwkbvveBQ9H/+1DE7RY4A062TXeIxrq4Q6yFkK+R3Dtq3UtRtFnsmzC
 4mEv8rHM3eC0XUlP4CTuvFPxtP4=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 60ccf452e570c0561967965a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 18 Jun 2021 19:30:26
 GMT
Sender: adharmap=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3779FC43147; Fri, 18 Jun 2021 19:30:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [192.168.1.70] (99-38-106-161.lightspeed.sndgca.sbcglobal.net [99.38.106.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: adharmap)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 82A39C433D3;
        Fri, 18 Jun 2021 19:30:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 82A39C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=adharmap@codeaurora.org
Subject: Re: [PATCH v2 0/6] arm/arm64: Allow the rescheduling IPI to bypass
 irq_enter/exit
To:     Marc Zyngier <maz@kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@arm.linux.org.uk>,
        Android Kernel Team <kernel-team@android.com>,
        dickey@codeaurora.org, Yuichi Ito <ito-yuichi@fujitsu.com>
References: <20201124141449.572446-1-maz@kernel.org>
From:   Abhijeet Dharmapurikar <adharmap@codeaurora.org>
Message-ID: <32d7376c-8b30-7729-25d7-b0fb24be57cf@codeaurora.org>
Date:   Fri, 18 Jun 2021 12:30:22 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20201124141449.572446-1-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

We are seeing significant improvements in time it takes for a task to be 
woken up on an idle cpu with these patches.

A trace output without
<<< 96uS total cost: cpu 1 wakes up rt-app task on cpu 2 >>>
           rt-app-955     [001]    149.387611: sched_wakeup_new: 
comm=rt-app pid=957 prio=120 target_cpu=002
           rt-app-955     [001]    149.387616: ipi_raise: 
target_mask=00000000,00000004 (Rescheduling interrupts)
           <idle>-0       [002]    149.387622: cpu_idle: 
state=4294967295 cpu_id=2
           <idle>-0       [002]    149.387640: irq_handler_entry: irq=1 
name=IPI
           <idle>-0       [002]    149.387643: ipi_entry: (Rescheduling 
interrupts)
           <idle>-0       [002]    149.387646: ipi_exit: (Rescheduling 
interrupts)
           <idle>-0       [002]    149.387648: irq_handler_exit: irq=1 
ret=handled
           <idle>-0       [002]    149.387707: sched_switch: 
prev_comm=swapper/2 prev_pid=0 prev_prio=120 prev_state=R ==> 
next_comm=rt-app next_pid=957 next_prio=120

With the patches.
<<< 68uS total cost: cpu 1 wakes up T0 on cpu 3 >>>
           rt-app-956     [001]     28.034953: sched_wakeup_new: 
comm=rt-app pid=958 prio=120 target_cpu=003
           rt-app-956     [001]     28.034958: ipi_raise: 
target_mask=00000000,00000008 (Rescheduling interrupts)
           <idle>-0       [003]     28.034964: cpu_idle: 
state=4294967295 cpu_id=3
           <idle>-0       [003]     28.034970: irq_handler_entry: irq=1 
name=IPI
           <idle>-0       [003]     28.034974: ipi_entry: (Rescheduling 
interrupts)
           <idle>-0       [003]     28.034977: ipi_exit: (Rescheduling 
interrupts)
           <idle>-0       [003]     28.034979: irq_handler_exit: irq=1 
ret=handled
           <idle>-0       [003]     28.035021: sched_switch: 
prev_comm=swapper/3 prev_pid=0 prev_prio=120 prev_state=R ==> 
next_comm=rt-app next_pid=958 next_prio=120

This was taken on a snapdragon device similar to 8350.  This patch 
series helps in reducing the load time on idle cpus and thereby increase 
performance KPIs on various benchmarks.

Sent this data in hopes that we resurrect the discussion and get these 
fixes in.

Thanks,
Abhijeet

On 11/24/2020 6:14 AM, Marc Zyngier wrote:
> This is the second version of my earlier series [1], which aims at
> fixing (or papering over, depending on how you look at things) a
> performance regression seen on arm64 for reched IPI heavy workloads
> (such as "perf bench sched pipe").
>
> As eloquently described by Thomas in his earlier replies [2], the
> current situation is less than ideal on most architecture except x86,
> and my conclusion is that what was broken in 5.9 wouldn't be more
> broken in 5.10 with these patches (and addresses the performance
> regression).
>
> Needless to say, I intend to try and help fixing the issues Thomas
> mentioned, and I believe that Mark (cc'd) already has something that
> could be used as a healthy starting point (Mark, do correct me if I
> misrepresented your work).
>
> Thanks,
>
> 	M.
>
> * From v1:
>    - Added a new __irq_modify_status() helper
>    - Renamed IRQ_NAKED to IRQ_RAW
>    - Renamed IRQ_HIDDEN to IRQ_IPI
>    - Applied the same workaround to 32bit ARM for completeness
>
> [1] https://lore.kernel.org/r/20201101131430.257038-1-maz@kernel.org/
> [2] https://lore.kernel.org/r/87lfewnmdz.fsf@nanos.tec.linutronix.de/
>
> Marc Zyngier (6):
>    genirq: Add __irq_modify_status() helper to clear/set special flags
>    genirq: Allow an interrupt to be marked as 'raw'
>    arm64: Mark the recheduling IPI as raw interrupt
>    arm: Mark the recheduling IPI as raw interrupt
>    genirq: Drop IRQ_HIDDEN from IRQF_MODIFY_MASK
>    genirq: Rename IRQ_HIDDEN to IRQ_IPI
>
>   arch/arm/Kconfig        |  1 +
>   arch/arm/kernel/smp.c   |  6 +++++-
>   arch/arm64/Kconfig      |  1 +
>   arch/arm64/kernel/smp.c |  6 +++++-
>   include/linux/irq.h     | 11 ++++++++---
>   kernel/irq/Kconfig      |  3 +++
>   kernel/irq/chip.c       | 12 ++++++++++--
>   kernel/irq/debugfs.c    |  3 ++-
>   kernel/irq/irqdesc.c    | 17 ++++++++++++-----
>   kernel/irq/proc.c       |  2 +-
>   kernel/irq/settings.h   | 33 +++++++++++++++++++++++++++------
>   11 files changed, 75 insertions(+), 20 deletions(-)
>
