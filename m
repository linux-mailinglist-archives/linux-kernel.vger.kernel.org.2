Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8563505AD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 19:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233945AbhCaRm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 13:42:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52684 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbhCaRmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 13:42:44 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617212562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C967zpewr99fjORRJqIiBkZCuEwXzxaSkRDZao7dYL4=;
        b=4VcxFKDux1F1dnBF2huA55CyIjECtZ+hb6FlSSQe9/ETlERsswt1uMzgsR7Ufnyhv/Vf21
        3nUxMMoy8k2k7PxgE4gNw7Y3+tpo46/+8KZ2xqas+dAL22Yp1shwzplF3FcwufbZCOz8EV
        zNY6TCc+F5xDLkE7Q/EN1fqaZu3eGEVX6SDiiX0Bj5kLTblxAHpajRyc4NvWLi51Sljabw
        gDy6i65ZkNrAytcv47i+U3oucFVBbqI1fn+D914DnYnCvZ42PNTfZWVyC4ulMhAOjWg0vF
        0tDaoy0f45ed/kIrMYsUwIugmOwGK7Rm+g0YGcvPJuxewhJeSVP2nwGrxyhpkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617212562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C967zpewr99fjORRJqIiBkZCuEwXzxaSkRDZao7dYL4=;
        b=WeqxWCG+/VHYOYpCeH8Lx9mj5dDp/27+7rgsWQYstPZ3CJ5MegtJcGmVs/DaHYz6Q+VqYk
        UsiVd/EaTJKiLaCA==
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux-RT-Users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 2/6] mm/page_alloc: Convert per-cpu list protection to local_lock
In-Reply-To: <20210331110137.GA3697@techsingularity.net>
References: <20210329120648.19040-1-mgorman@techsingularity.net> <20210329120648.19040-3-mgorman@techsingularity.net> <877dln640j.ffs@nanos.tec.linutronix.de> <20210331110137.GA3697@techsingularity.net>
Date:   Wed, 31 Mar 2021 19:42:42 +0200
Message-ID: <871rbv5iel.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31 2021 at 12:01, Mel Gorman wrote:
> On Wed, Mar 31, 2021 at 11:55:56AM +0200, Thomas Gleixner wrote:
> @@ -887,13 +887,11 @@ void cpu_vm_stats_fold(int cpu)
>  
>  		pzstats = per_cpu_ptr(zone->per_cpu_zonestats, cpu);
>  
> -		preempt_disable();
>  		for (i = 0; i < NR_VM_ZONE_STAT_ITEMS; i++)
>  			if (pzstats->vm_stat_diff[i]) {
>  				int v;
>  
> -				v = pzstats->vm_stat_diff[i];
> -				pzstats->vm_stat_diff[i] = 0;
> +				v = this_cpu_xchg(pzstats->vm_stat_diff[i], 0);

Confused. pzstats is not a percpu pointer. zone->per_cpu_zonestats is.

But @cpu is not necessarily the current CPU.

Thanks,

        tglx
