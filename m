Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 545183BD774
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 15:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbhGFNMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 09:12:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:59820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231274AbhGFNMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 09:12:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 663F461C37;
        Tue,  6 Jul 2021 13:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625576967;
        bh=9w4h7HWs7WN0JFZ+JUDeaNoyRP8PBhFoCLo0HF0HiwI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sgnHa+JQeTG2wY3CPOETKIEJtFLZT/HJ+nPW4uGsIeh+rZuWzUrbA9XKFxCT49EWv
         FUGPsJnJ+SE/DPYSHZb0fEQp3i9+89/LfiGapwRCSrGcfkeHgPVJvKY49dGdtR7s1B
         WEMcWYnN+f9OMBu92VHO8bCFhpVErv0n7xeKYvHuvyIkewTK0GHYIOg8iP4P+HZ8XM
         sZ71eCQ93y3TNiz39mv2zLjMMKyWJuqfnekKTU9cCsWPZf195X9Dh3y2bPynpivCAB
         6VJIu7jEnL9W8ybP2Cxtx8xcME0XP38oT/OtXSVf3Klb4hyl+KCoFC2oag/mRuXqAl
         UnvrLuWyk0eJA==
Date:   Tue, 6 Jul 2021 15:09:25 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Nitesh Lal <nilal@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch 0/5] optionally sync per-CPU vmstats counter on return to
 userspace
Message-ID: <20210706130925.GC107277@lothringen>
References: <20210701210336.358118649@fuller.cnet>
 <20210702123032.GA72061@lothringen>
 <20210702152816.GA4122@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210702152816.GA4122@fuller.cnet>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 02, 2021 at 12:28:16PM -0300, Marcelo Tosatti wrote:
> 
> Hi Frederic,
> 
> On Fri, Jul 02, 2021 at 02:30:32PM +0200, Frederic Weisbecker wrote:
> > On Thu, Jul 01, 2021 at 06:03:36PM -0300, Marcelo Tosatti wrote:
> > > The logic to disable vmstat worker thread, when entering
> > > nohz full, does not cover all scenarios. For example, it is possible
> > > for the following to happen:
> > > 
> > > 1) enter nohz_full, which calls refresh_cpu_vm_stats, syncing the stats.
> > > 2) app runs mlock, which increases counters for mlock'ed pages.
> > > 3) start -RT loop
> > > 
> > > Since refresh_cpu_vm_stats from nohz_full logic can happen _before_
> > > the mlock, vmstat shepherd can restart vmstat worker thread on
> > > the CPU in question.
> > >  
> > > To fix this, optionally sync the vmstat counters when returning
> > > from userspace, controllable by a new "vmstat_sync" isolcpus
> > > flags (default off).
> > 
> > Wasn't the plan for such finegrained isolation features to do it at
> > the per task level using prctl()?
> 
> Yes, but its orthogonal: when we integrate the finegrained isolation
> interface, will be able to use this code (to sync vmstat counters
> on return to userspace) only when userspace informs that it has entered
> isolated mode, so you don't incur the performance penalty of frequent
> vmstat counter writes when not using isolated apps.
> 
> This is what the full task isolation task patchset mode is doing
> as well (CC'ing Alex BTW).

Right there can be two ways:

* A prctl request to sync vmstat only on exit from that prctl
* A prctl request to sync vmstat on all subsequent exit from
  kernel space.

> 
> This will require modifying applications (and the new kernel with the
> exposed interface).
> 
> But there is demand for fixing this now, for currently existing
> binary only applications.

I would agree if it were a regression but it's not. It's merely
a new feature and we don't want to rush on a broken interface.

And I suspect some other people won't like much a new extension
to isolcpus.
