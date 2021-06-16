Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B375D3AA2A3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 19:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbhFPRvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 13:51:23 -0400
Received: from mail.efficios.com ([167.114.26.124]:51030 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbhFPRvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 13:51:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id C691E34A274;
        Wed, 16 Jun 2021 13:49:14 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id pDcWAsNZDluG; Wed, 16 Jun 2021 13:49:12 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id D337C34A72C;
        Wed, 16 Jun 2021 13:49:12 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com D337C34A72C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1623865752;
        bh=1gEGS37d5YS5t+vNhypHegreBYEX0Oj0QX3lscVo1iA=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Q7qPgrVtmXKmYByg3gcfYI/JsDIWSrdvm5kK8zgFU2VG4RUfuic6riERTgfMdRTo3
         6H1EMwrqL3XciuKhrpzEPQiyKfkxuE7ecUSyYyr8sdll75Sy+YpllJBuWfmsWZmKuW
         gQKHENONavQcrpVL1KWXXSN/m+SqAqMDZdKwnt+pxyhH6HytSXKdlw16V8Ve5G5VHM
         9NUYEnwffySIgcQvainDSBKtQ+chYoa9VPdEzqlZGLfuhok/csktIalp6KivopOvwf
         x9NWtzMisfKryXNdwRPB3SU7GwiC0kL0n8xAoWRZZzc5x/U3MH/u3etFP1tz9IDq53
         2NVoo0ps8jd+g==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id TV_bkHwtGB11; Wed, 16 Jun 2021 13:49:12 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id C392034A2F7;
        Wed, 16 Jun 2021 13:49:12 -0400 (EDT)
Date:   Wed, 16 Jun 2021 13:49:12 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     x86 <x86@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Message-ID: <1612817467.9041.1623865752655.JavaMail.zimbra@efficios.com>
In-Reply-To: <571b7e6b6a907e8a1ffc541c3f0005d347406fd0.1623813516.git.luto@kernel.org>
References: <cover.1623813516.git.luto@kernel.org> <571b7e6b6a907e8a1ffc541c3f0005d347406fd0.1623813516.git.luto@kernel.org>
Subject: Re: [PATCH 2/8] x86/mm: Handle unlazying membarrier core sync in
 the arch code
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4018 (ZimbraWebClient - FF89 (Linux)/8.8.15_GA_4026)
Thread-Topic: x86/mm: Handle unlazying membarrier core sync in the arch code
Thread-Index: xNxHDRQh7RLqFnf5iMUzvQDlhdKF9A==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jun 15, 2021, at 11:21 PM, Andy Lutomirski luto@kernel.org wrote:
[...]
> @@ -473,16 +474,24 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct
> mm_struct *next,

[...]

> @@ -510,16 +520,35 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct
> mm_struct *next,
> 		 * If the TLB is up to date, just use it.
> 		 * The barrier synchronizes with the tlb_gen increment in
> 		 * the TLB shootdown code.
> +		 *
> +		 * As a future optimization opportunity, it's plausible
> +		 * that the x86 memory model is strong enough that this
> +		 * smp_mb() isn't needed.
> 		 */
> 		smp_mb();
> 		next_tlb_gen = atomic64_read(&next->context.tlb_gen);
> 		if (this_cpu_read(cpu_tlbstate.ctxs[prev_asid].tlb_gen) ==
> -				next_tlb_gen)
> +		    next_tlb_gen) {
> +#ifdef CONFIG_MEMBARRIER
> +			/*
> +			 * We switched logical mm but we're not going to
> +			 * write to CR3.  We already did smp_mb() above,
> +			 * but membarrier() might require a sync_core()
> +			 * as well.
> +			 */
> +			if (unlikely(atomic_read(&next->membarrier_state) &
> +				     MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE))
> +				sync_core_before_usermode();
> +#endif
> +
> 			return;
> +		}

[...]

I find that mixing up preprocessor #ifdef and code logic hurts readability.
Can you lift this into a static function within the same compile unit, and
provides an empty implementation for the #else case ?

Thanks,

Mathieu

	prev->sched_class->task_dead(prev);



-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
