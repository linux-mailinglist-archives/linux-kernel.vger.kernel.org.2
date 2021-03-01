Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF39E329253
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 21:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243711AbhCAUnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 15:43:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237402AbhCARIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 12:08:15 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F81C06178A;
        Mon,  1 Mar 2021 09:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=S9ngvRlZtXf9VEt5DT/R9Al/YBoa50u8y8yRC5/eV3I=; b=DvRBJz9kin5uzPMV/NRyHhC0rI
        9Gg0FQgbtkHERwtTR2bCEGI/e54MTjeSd8b/hrXp98bMFZTcp3k4pCtIO/4h4huFXa9LRxdVFL2ys
        F8gMhjpzgjWZN9GAGqcizX9hN4IIaBrAwEzifE/ctLfiJXLSgATDLmaYHcUInSiYOsxTVz84rP5xI
        50hvL61tjgE0PRPn1+9rqJNbGOu67CKo3ViuCzIUuoFGxwXmo3/3FElmLhPLmYrVnLh/mX9vnRKT0
        ubudCUviIAg1aJV38q+iC2vzeDyNhcp/C5IHmr+323TaWt0NFivB6rVOsxBZaKq46/qIj66w8yh/O
        fbW6DGZw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lGm12-0006Aw-Av; Mon, 01 Mar 2021 17:07:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A23CE3003E1;
        Mon,  1 Mar 2021 18:07:24 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 942022059E7A6; Mon,  1 Mar 2021 18:07:24 +0100 (CET)
Date:   Mon, 1 Mar 2021 18:07:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        paulmck@kernel.org, mhocko@suse.com,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2 3/3] kernel/smp: add more data to CSD lock debugging
Message-ID: <YD0fTLnQTQ7/M7fx@hirez.programming.kicks-ass.net>
References: <20210301101336.7797-1-jgross@suse.com>
 <20210301101336.7797-4-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210301101336.7797-4-jgross@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2021 at 11:13:36AM +0100, Juergen Gross wrote:
> In order to help identifying problems with IPI handling and remote
> function execution add some more data to IPI debugging code.
> 
> There have been multiple reports of cpus looping long times (many
> seconds) in smp_call_function_many() waiting for another cpu executing
> a function like tlb flushing. Most of these reports have been for
> cases where the kernel was running as a guest on top of KVM or Xen
> (there are rumours of that happening under VMWare, too, and even on
> bare metal).
> 
> Finding the root cause hasn't been successful yet, even after more than
> 2 years of chasing this bug by different developers.
> 
> Commit 35feb60474bf4f7 ("kernel/smp: Provide CSD lock timeout
> diagnostics") tried to address this by adding some debug code and by
> issuing another IPI when a hang was detected. This helped mitigating
> the problem (the repeated IPI unlocks the hang), but the root cause is
> still unknown.
> 
> Current available data suggests that either an IPI wasn't sent when it
> should have been, or that the IPI didn't result in the target cpu
> executing the queued function (due to the IPI not reaching the cpu,
> the IPI handler not being called, or the handler not seeing the queued
> request).
> 
> Try to add more diagnostic data by introducing a global atomic counter
> which is being incremented when doing critical operations (before and
> after queueing a new request, when sending an IPI, and when dequeueing
> a request). The counter value is stored in percpu variables which can
> be printed out when a hang is detected.
> 
> The data of the last event (consisting of sequence counter, source
> cpu, target cpu, and event type) is stored in a global variable. When
> a new event is to be traced, the data of the last event is stored in
> the event related percpu location and the global data is updated with
> the new event's data. This allows to track two events in one data
> location: one by the value of the event data (the event before the
> current one), and one by the location itself (the current event).
> 
> A typical printout with a detected hang will look like this:
> 
> csd: Detected non-responsive CSD lock (#1) on CPU#1, waiting 5000000003 ns for CPU#06 scf_handler_1+0x0/0x50(0xffffa2a881bb1410).
> 	csd: CSD lock (#1) handling prior scf_handler_1+0x0/0x50(0xffffa2a8813823c0) request.
>         csd: cnt(00008cc): ffff->0000 dequeue (src cpu 0 == empty)
>         csd: cnt(00008cd): ffff->0006 idle
>         csd: cnt(0003668): 0001->0006 queue
>         csd: cnt(0003669): 0001->0006 ipi
>         csd: cnt(0003e0f): 0007->000a queue
>         csd: cnt(0003e10): 0001->ffff ping
>         csd: cnt(0003e71): 0003->0000 ping
>         csd: cnt(0003e72): ffff->0006 gotipi
>         csd: cnt(0003e73): ffff->0006 handle
>         csd: cnt(0003e74): ffff->0006 dequeue (src cpu 0 == empty)
>         csd: cnt(0003e7f): 0004->0006 ping
>         csd: cnt(0003e80): 0001->ffff pinged
>         csd: cnt(0003eb2): 0005->0001 noipi
>         csd: cnt(0003eb3): 0001->0006 queue
>         csd: cnt(0003eb4): 0001->0006 noipi
>         csd: cnt now: 0003f00
> 
> The idea is to print only relevant entries. Those are all events which
> are associated with the hang (so sender side events for the source cpu
> of the hanging request, and receiver side events for the target cpu),
> and the related events just before those (for adding data needed to
> identify a possible race). Printing all available data would be
> possible, but this would add large amounts of data printed on larger
> configurations.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> Tested-by: Paul E. McKenney <paulmck@kernel.org>
> ---
> V2:
> - add automatic data deciphering and sorting of entries
> - add new trace point for leaving flush_smp_call_function_queue()
> - add information when finding an empty call_single_queue

They do not apply on top of these:

  https://lkml.kernel.org/r/20210220231712.2475218-2-namit@vmware.com

:-/

> @@ -290,6 +476,19 @@ static DEFINE_PER_CPU_SHARED_ALIGNED(call_single_data_t, csd_data);
>  
>  void __smp_call_single_queue(int cpu, struct llist_node *node)
>  {
> +#ifdef CONFIG_CSD_LOCK_WAIT_DEBUG
> +	if (static_branch_unlikely(&csdlock_debug_extended)) {
> +		unsigned int type;
> +
> +		type = CSD_TYPE(container_of(node, call_single_data_t,
> +					     node.llist));
> +		if (type == CSD_TYPE_SYNC || type == CSD_TYPE_ASYNC) {
> +			__smp_call_single_queue_debug(cpu, node);
> +			return;
> +		}
> +	}
> +#endif

This really ought to be in generic_exec_single(), because there we know
the type matches.


