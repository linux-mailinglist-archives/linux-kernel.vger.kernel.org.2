Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA003BD884
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 16:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbhGFOmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 10:42:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54118 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232600AbhGFOmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 10:42:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625582407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1f7UONqM89FkJImoQjQslwhMUM1DR3oNSRiU3y3RxGU=;
        b=VjTk1r/A3m/zGEoL7ZrqbcRuS4usQ/kWARR+KYP6+LXLMVToXbyAzmtOw6JA+TAqwc0duT
        ne2Z4PNs2FvgdmrqbxW+mFTMKGF+Wi+lAJSQMDftV+jXaWnL/0Lwh4NGulJvRQfX2YSh6x
        Umk7T6aNaqX1MQpY/OIwZnGuSU5WHAY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-3RjgmylcOHeQDcT89JEE1Q-1; Tue, 06 Jul 2021 10:09:42 -0400
X-MC-Unique: 3RjgmylcOHeQDcT89JEE1Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 961F61023F47;
        Tue,  6 Jul 2021 14:09:41 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6177A6E0B6;
        Tue,  6 Jul 2021 14:09:37 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 34E02416F5D2; Tue,  6 Jul 2021 11:09:20 -0300 (-03)
Date:   Tue, 6 Jul 2021 11:09:20 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Nitesh Lal <nilal@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch 0/5] optionally sync per-CPU vmstats counter on return to
 userspace
Message-ID: <20210706140920.GA68399@fuller.cnet>
References: <20210701210336.358118649@fuller.cnet>
 <20210702123032.GA72061@lothringen>
 <20210702152816.GA4122@fuller.cnet>
 <20210706130925.GC107277@lothringen>
 <20210706140550.GA64308@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210706140550.GA64308@fuller.cnet>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2021 at 11:05:50AM -0300, Marcelo Tosatti wrote:
> On Tue, Jul 06, 2021 at 03:09:25PM +0200, Frederic Weisbecker wrote:
> > On Fri, Jul 02, 2021 at 12:28:16PM -0300, Marcelo Tosatti wrote:
> > > 
> > > Hi Frederic,
> > > 
> > > On Fri, Jul 02, 2021 at 02:30:32PM +0200, Frederic Weisbecker wrote:
> > > > On Thu, Jul 01, 2021 at 06:03:36PM -0300, Marcelo Tosatti wrote:
> > > > > The logic to disable vmstat worker thread, when entering
> > > > > nohz full, does not cover all scenarios. For example, it is possible
> > > > > for the following to happen:
> > > > > 
> > > > > 1) enter nohz_full, which calls refresh_cpu_vm_stats, syncing the stats.
> > > > > 2) app runs mlock, which increases counters for mlock'ed pages.
> > > > > 3) start -RT loop
> > > > > 
> > > > > Since refresh_cpu_vm_stats from nohz_full logic can happen _before_
> > > > > the mlock, vmstat shepherd can restart vmstat worker thread on
> > > > > the CPU in question.
> > > > >  
> > > > > To fix this, optionally sync the vmstat counters when returning
> > > > > from userspace, controllable by a new "vmstat_sync" isolcpus
> > > > > flags (default off).
> > > > 
> > > > Wasn't the plan for such finegrained isolation features to do it at
> > > > the per task level using prctl()?
> > > 
> > > Yes, but its orthogonal: when we integrate the finegrained isolation
> > > interface, will be able to use this code (to sync vmstat counters
> > > on return to userspace) only when userspace informs that it has entered
> > > isolated mode, so you don't incur the performance penalty of frequent
> > > vmstat counter writes when not using isolated apps.
> > > 
> > > This is what the full task isolation task patchset mode is doing
> > > as well (CC'ing Alex BTW).
> > 
> > Right there can be two ways:
> 
> 
>   * An isolcpus flag to request sync of vmstat on all exits
>     to userspace.
> > * A prctl request to sync vmstat only on exit from that prctl
> > * A prctl request to sync vmstat on all subsequent exit from
> >   kernel space.
> 
> * A prctl to expose "vmstat is out of sync" information 
> to userspace, so that it can be queried and flushed
> (Christoph's suggestion:
> https://www.spinics.net/lists/linux-mm/msg243788.html).
> 
> > > This will require modifying applications (and the new kernel with the
> > > exposed interface).
> > > 
> > > But there is demand for fixing this now, for currently existing
> > > binary only applications.
> > 
> > I would agree if it were a regression but it's not. It's merely
> > a new feature and we don't want to rush on a broken interface.
> 
> Well, people out there need it in some form (vmstat sync).
> Can we please agree on an acceptable way to allow this.
> 
> Why its a broken interface? It has good qualities IMO:
> 
> - Its well contained (if you don't need, don't use it).
> - Does not require modifying -RT applications.
> - Works well for a set of applications (where the overhead of
> syncing vmstat is largely irrelevant, but the vmstat_worker 
> interruption is).
> 
> And its patchset integrates part another piece of full task isolation.
> 
> > And I suspect some other people won't like much a new extension
> > to isolcpus.
> 
> Why is that so? 

Ah, yes, that would be PeterZ.

IIRC his main point was that its not runtime changeable.
We can (partially fix that), if that is the case.

Peter, was that the only problem you saw with isolcpus interface?

