Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAC8D3BBE36
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 16:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbhGEO32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 10:29:28 -0400
Received: from vmi485042.contaboserver.net ([161.97.139.209]:59138 "EHLO
        gentwo.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231404AbhGEO30 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 10:29:26 -0400
Received: by gentwo.de (Postfix, from userid 1001)
        id 34EC4B00241; Mon,  5 Jul 2021 16:26:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 3249FB00036;
        Mon,  5 Jul 2021 16:26:48 +0200 (CEST)
Date:   Mon, 5 Jul 2021 16:26:48 +0200 (CEST)
From:   Christoph Lameter <cl@gentwo.de>
To:     Marcelo Tosatti <mtosatti@redhat.com>
cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Nitesh Lal <nilal@redhat.com>
Subject: Re: [patch 0/5] optionally sync per-CPU vmstats counter on return
 to userspace
In-Reply-To: <20210702115959.GA239377@fuller.cnet>
Message-ID: <alpine.DEB.2.22.394.2107051622580.278143@gentwo.de>
References: <20210701210336.358118649@fuller.cnet> <alpine.DEB.2.22.394.2107020958430.201080@gentwo.de> <20210702115959.GA239377@fuller.cnet>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Jul 2021, Marcelo Tosatti wrote:

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
> >
> > Can we enter nohz_full after the app runs mlock?
>
> Hum, i don't think its a good idea to use that route, because
> entering or exiting nohz_full depends on a number of variable
> outside of one's control (and additional variables might be
> added in the future).

Then I do not see any need for this patch. Because after a certain time
of inactivity (after the mlock) the system will enter nohz_full again.
If userspace has no direct control over nohz_full and can only wait then
it just has to do so.

> So preparing the system to function
> while entering nohz_full at any location seems the sane thing to do.
>
> And that would be at return to userspace (since, if mlocked, after
> that point there will be no more changes to propagate to vmstat
> counters).
>
> Or am i missing something else you can think of ?

I assumed that the "enter nohz full" was an action by the user
space app because I saw some earlier patches to introduce such
functionality in the past.

