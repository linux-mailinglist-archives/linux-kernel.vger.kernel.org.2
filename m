Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7C4D437A32
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 17:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbhJVPmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 11:42:50 -0400
Received: from foss.arm.com ([217.140.110.172]:56094 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233222AbhJVPms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 11:42:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2616D1FB;
        Fri, 22 Oct 2021 08:40:30 -0700 (PDT)
Received: from [10.57.27.181] (unknown [10.57.27.181])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E04DE3F694;
        Fri, 22 Oct 2021 08:40:27 -0700 (PDT)
Subject: Re: [RFCv1 4/4] perf: arm_spe: Dynamically switch PID tracing to
 contextidr
From:   James Clark <james.clark@arm.com>
To:     Leo Yan <leo.yan@linaro.org>
References: <20211021134530.206216-1-leo.yan@linaro.org>
 <20211021134530.206216-5-leo.yan@linaro.org>
 <854fb1a2-e5f1-f237-685f-8ddb0557c98b@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        James Morse <james.morse@arm.com>,
        Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Message-ID: <cb62ba81-0e86-c4d8-a5bb-65382db40ada@arm.com>
Date:   Fri, 22 Oct 2021 16:40:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <854fb1a2-e5f1-f237-685f-8ddb0557c98b@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/10/2021 16:36, James Clark wrote:
> 
> 
> On 21/10/2021 14:45, Leo Yan wrote:
>> Now Arm64 provides API for enabling and disable PID tracing, Arm SPE
>> driver invokes these functions to dynamically enable it during
>> profiling when the program runs in root PID name space, and disable PID
>> tracing when the perf event is stopped.
>>
>> Device drivers should not depend on CONFIG_PID_IN_CONTEXTIDR for PID
>> tracing, so this patch uses the consistent condition for setting bit
>> EL1_CX for PMSCR.
> 
> Hi Leo,
> 
> I've been testing this change, but I'm seeing something strange. Not sure
> if it's a problem on my side or not yet. With this command:
> 
>  sudo ./perf record -vvv -e arm_spe//u -- taskset --cpu-list 1 bash -c ls
> 
> I'm only seeing 0 values for context:
> 
>  sudo ./perf report -D | grep CONTEXT
> 
> .  00038dce:  65 00 00 00 00                                  CONTEXT 0x0 el2
> .  00038e0e:  65 00 00 00 00                                  CONTEXT 0x0 el2
> 
> I added a printk to the function, and I see it print non zero values, although
> there are some zero ones mixed in there too:
> 
>  diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
> index 0c1669db19a1..8f0fb43a5fac 100644
> --- a/arch/arm64/include/asm/mmu_context.h
> +++ b/arch/arm64/include/asm/mmu_context.h
> @@ -33,7 +33,8 @@ static inline void contextidr_thread_switch(struct task_struct *next)
>         if (!static_branch_unlikely(&contextidr_in_use))
>                 return;
>  
> -       write_sysreg(task_pid_nr(next), contextidr_el1);
> +       printk("Set %d\n", task_pid_nr(next));
> +       write_sysreg(task_pid_nr(next), contextidr_el2);

Ignore this second line change, that doesn't even compile. It's just the printk that I added.

