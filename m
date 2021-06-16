Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEC923AA334
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 20:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbhFPSdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 14:33:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:39770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230267AbhFPSdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 14:33:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2FB78613C1;
        Wed, 16 Jun 2021 18:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623868267;
        bh=4iyLPBnjANgB4IOoNU9x++tyyeWJHhfFaJq3Jwp5nMs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=bTSuvnJQdPPULOJPC9vyw+MUPo4/gNpINZ0iIgTD8nfsOD0jkettsFLUbUNRx1hBW
         7op24yQm635zQFnkz1JE24RiZZMzqQPqnxSPthHYYWxkU+SmIgNFfW35f9sPyWR0IF
         m1gP1OZmFYkGz4wzmBdOBVvbwXr3NyF6+4BIwZkE/HFoWj3aM9tlCVNJ37exBfiLcO
         QzjHJYaw2QgyLoMXJDlypOWoraU0U25ImdCKTqGt5bxBKZxifXe5JqdME+einFaXJk
         BocR62NPGwrUmn3ztzkvsVFMXl4jKm7t7kgAQNS/r0lRSZqmQVkhhFrMW1ypKV4HlU
         UgcYfMHGQUqSQ==
Subject: Re: [PATCH 2/8] x86/mm: Handle unlazying membarrier core sync in the
 arch code
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     x86 <x86@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <cover.1623813516.git.luto@kernel.org>
 <571b7e6b6a907e8a1ffc541c3f0005d347406fd0.1623813516.git.luto@kernel.org>
 <1612817467.9041.1623865752655.JavaMail.zimbra@efficios.com>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <0b50604c-2953-29ab-ee67-94e91ba8d854@kernel.org>
Date:   Wed, 16 Jun 2021 11:31:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1612817467.9041.1623865752655.JavaMail.zimbra@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/21 10:49 AM, Mathieu Desnoyers wrote:
> ----- On Jun 15, 2021, at 11:21 PM, Andy Lutomirski luto@kernel.org wrote:
> [...]
>> @@ -473,16 +474,24 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct
>> mm_struct *next,
> 
> [...]
> 
>> @@ -510,16 +520,35 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct
>> mm_struct *next,
>> 		 * If the TLB is up to date, just use it.
>> 		 * The barrier synchronizes with the tlb_gen increment in
>> 		 * the TLB shootdown code.
>> +		 *
>> +		 * As a future optimization opportunity, it's plausible
>> +		 * that the x86 memory model is strong enough that this
>> +		 * smp_mb() isn't needed.
>> 		 */
>> 		smp_mb();
>> 		next_tlb_gen = atomic64_read(&next->context.tlb_gen);
>> 		if (this_cpu_read(cpu_tlbstate.ctxs[prev_asid].tlb_gen) ==
>> -				next_tlb_gen)
>> +		    next_tlb_gen) {
>> +#ifdef CONFIG_MEMBARRIER
>> +			/*
>> +			 * We switched logical mm but we're not going to
>> +			 * write to CR3.  We already did smp_mb() above,
>> +			 * but membarrier() might require a sync_core()
>> +			 * as well.
>> +			 */
>> +			if (unlikely(atomic_read(&next->membarrier_state) &
>> +				     MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE))
>> +				sync_core_before_usermode();
>> +#endif
>> +
>> 			return;
>> +		}
> 
> [...]
> 
> I find that mixing up preprocessor #ifdef and code logic hurts readability.
> Can you lift this into a static function within the same compile unit, and
> provides an empty implementation for the #else case ?

Done.

> 
> Thanks,
> 
> Mathieu
> 
> 	prev->sched_class->task_dead(prev);
> 
> 
> 

