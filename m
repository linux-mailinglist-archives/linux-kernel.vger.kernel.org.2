Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40DEA31DBBA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 15:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233556AbhBQOy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 09:54:58 -0500
Received: from mail.efficios.com ([167.114.26.124]:60202 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbhBQOy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 09:54:56 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 71DB8321AD4;
        Wed, 17 Feb 2021 09:54:15 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id PGxdqeZkWP_m; Wed, 17 Feb 2021 09:54:15 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 1B70E321872;
        Wed, 17 Feb 2021 09:54:15 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 1B70E321872
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1613573655;
        bh=p8rzk+9PWX0J6QS6PkL3eYmf4NkHf+hW8bzcZcs99bk=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Yau5Agp9OVisj4/vcVlU3y7L7YOusdltgzM4nrze0XE2MYO+fjZfWV+4kYtxZSaCn
         P3zvtBLy4o1D/XciP/qlvMvzg9eC90StwRdA030lATLEnmef2g8mzi8ueL35Dg1Ycf
         HYp8TeUAMZsDpmXaAw1oeIR2+X9SzhADimR765gKXieKY8uZfsQxURlkjp3Kfih3/T
         0pQPOFC2i03iDL+1+zyksjSu0d1Tq1puA9sKHFyMRFJjP1oYRHLZ/PmZk5PuwIdr0L
         VQoSgpJ1FWdqb+S32kn0H1hUE2K+RXnDiS6FT/3jozNCBArIhjKWVckagjVpFhcect
         Z0QmtPn3Rt+wQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id st-EjuNfwK2n; Wed, 17 Feb 2021 09:54:15 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id F2849321D87;
        Wed, 17 Feb 2021 09:54:14 -0500 (EST)
Date:   Wed, 17 Feb 2021 09:54:14 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Message-ID: <330895069.24567.1613573654866.JavaMail.zimbra@efficios.com>
In-Reply-To: <74F1E842-4A84-47BF-B6C2-5407DFDD4A4A@gmail.com>
References: <74F1E842-4A84-47BF-B6C2-5407DFDD4A4A@gmail.com>
Subject: Re: Local execution of ipi_sync_rq_state() on
 sync_runqueues_membarrier_state()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3996 (ZimbraWebClient - FF85 (Linux)/8.8.15_GA_3996)
Thread-Topic: Local execution of ipi_sync_rq_state() on sync_runqueues_membarrier_state()
Thread-Index: aQ9FvzemhUrCAb4Wf2CU2pP04nc+YQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Feb 16, 2021, at 4:35 PM, Nadav Amit nadav.amit@gmail.com wrote:

> Hello Mathieu,
> 
> While trying to find some unrelated by, something in
> sync_runqueues_membarrier_state() caught my eye:
> 
> 
>  static int sync_runqueues_membarrier_state(struct mm_struct *mm)
>  {
>        if (atomic_read(&mm->mm_users) == 1 || num_online_cpus() == 1) {
>                this_cpu_write(runqueues.membarrier_state, membarrier_state);
> 
>                /*
>                 * For single mm user, we can simply issue a memory barrier
>                 * after setting MEMBARRIER_STATE_GLOBAL_EXPEDITED in the
>                 * mm and in the current runqueue to guarantee that no memory
>                 * access following registration is reordered before
>                 * registration.
>                 */
>                smp_mb();
>                return 0;
>        }
> 
> [ snip ]
> 
>  	smp_call_function_many(tmpmask, ipi_sync_rq_state, mm, 1);
> 
> 
> And ipi_sync_rq_state() does:
> 
>	this_cpu_write(runqueues.membarrier_state,
>                       atomic_read(&mm->membarrier_state));
> 
> 
> So my question: are you aware smp_call_function_many() would not run
> ipi_sync_rq_state() on the local CPU?

Generally, yes, I am aware of it, but it appears that when I wrote that
code, I missed that important fact. See

commit 227a4aadc75b ("sched/membarrier: Fix p->mm->membarrier_state racy load")

> Is that the intention of the code?

Clearly not! If we look at sync_runqueues_membarrier_state(), there is even a
special-case for mm_users==1 || num online cpus == 1 where it writes the membarrier
state into the current cpu runqueue. I'll prepare a fix, thanks a bunch for spotting
this.

Mathieu

> 
> Thanks,
> Nadav

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
