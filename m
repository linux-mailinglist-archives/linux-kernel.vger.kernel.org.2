Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE49350854
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 22:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236510AbhCaUma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 16:42:30 -0400
Received: from outbound-smtp46.blacknight.com ([46.22.136.58]:58713 "EHLO
        outbound-smtp46.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236637AbhCaUmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 16:42:12 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp46.blacknight.com (Postfix) with ESMTPS id 8E85FFAE77
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 21:42:11 +0100 (IST)
Received: (qmail 5619 invoked from network); 31 Mar 2021 20:42:11 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 31 Mar 2021 20:42:11 -0000
Date:   Wed, 31 Mar 2021 21:42:10 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux-RT-Users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 2/6] mm/page_alloc: Convert per-cpu list protection to
 local_lock
Message-ID: <20210331204210.GB3697@techsingularity.net>
References: <20210329120648.19040-1-mgorman@techsingularity.net>
 <20210329120648.19040-3-mgorman@techsingularity.net>
 <877dln640j.ffs@nanos.tec.linutronix.de>
 <20210331110137.GA3697@techsingularity.net>
 <871rbv5iel.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <871rbv5iel.ffs@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 07:42:42PM +0200, Thomas Gleixner wrote:
> On Wed, Mar 31 2021 at 12:01, Mel Gorman wrote:
> > On Wed, Mar 31, 2021 at 11:55:56AM +0200, Thomas Gleixner wrote:
> > @@ -887,13 +887,11 @@ void cpu_vm_stats_fold(int cpu)
> >  
> >  		pzstats = per_cpu_ptr(zone->per_cpu_zonestats, cpu);
> >  
> > -		preempt_disable();
> >  		for (i = 0; i < NR_VM_ZONE_STAT_ITEMS; i++)
> >  			if (pzstats->vm_stat_diff[i]) {
> >  				int v;
> >  
> > -				v = pzstats->vm_stat_diff[i];
> > -				pzstats->vm_stat_diff[i] = 0;
> > +				v = this_cpu_xchg(pzstats->vm_stat_diff[i], 0);
> 
> Confused. pzstats is not a percpu pointer. zone->per_cpu_zonestats is.
> 
> But @cpu is not necessarily the current CPU.
> 

I was drinking drain cleaner instead of coffee. The code was also broken
to begin with.

drain_pages() is draining pagesets of a local or dead CPU. For a local
CPU, disabling IRQs prevent an IRQ arriving during the drain, trying to
allocate a page and potentially corrupt the local pageset -- ok.

zone_pcp_reset is accessing a remote CPUs pageset, freeing the percpu
pointer and resetting it to boot_pageset. zone_pcp_reset calling
local_irq_save() does not offer any special protection against
drain_pages because there are two separate IRQs involved.

This particular patch may have no reason to touch zone_pcp_reset,
cpu_vm_stats_fold or drain_zonestat at all but I need to think about it
more tomorrow.

-- 
Mel Gorman
SUSE Labs
