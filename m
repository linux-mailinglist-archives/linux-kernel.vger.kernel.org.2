Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 026013BBE62
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 16:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbhGEOst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 10:48:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21520 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230504AbhGEOss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 10:48:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625496371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OOqKHOlohjzGnRZzcmrcDqM3U2ntTIHRASX27gcm4o8=;
        b=BokQQykU079uj+6XbdXyjYTHgphDVNqnwOQ8O3lzzibamCMLh6Sgdd+oHlF3CC6DanXO4V
        SFJm+CY+y3hkAYWRMDL9DPx6ENmnW/0SwHOKvJSn1Q1TwWaoeOPmxZO3ddisoizQrTtD/M
        teu+60UVLI74xocpJG5sCNJpnPW3g5g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-bqnIr69iNIiD29belJmtJw-1; Mon, 05 Jul 2021 10:46:07 -0400
X-MC-Unique: bqnIr69iNIiD29belJmtJw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D87F01084F4C;
        Mon,  5 Jul 2021 14:46:06 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CB3C519CB4;
        Mon,  5 Jul 2021 14:46:02 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 7FFEF416F5D2; Mon,  5 Jul 2021 11:45:42 -0300 (-03)
Date:   Mon, 5 Jul 2021 11:45:42 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Christoph Lameter <cl@gentwo.de>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Nitesh Lal <nilal@redhat.com>
Subject: Re: [patch 0/5] optionally sync per-CPU vmstats counter on return to
 userspace
Message-ID: <20210705144542.GA27275@fuller.cnet>
References: <20210701210336.358118649@fuller.cnet>
 <alpine.DEB.2.22.394.2107020958430.201080@gentwo.de>
 <20210702115959.GA239377@fuller.cnet>
 <alpine.DEB.2.22.394.2107051622580.278143@gentwo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2107051622580.278143@gentwo.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 05, 2021 at 04:26:48PM +0200, Christoph Lameter wrote:
> On Fri, 2 Jul 2021, Marcelo Tosatti wrote:
> 
> > > > The logic to disable vmstat worker thread, when entering
> > > > nohz full, does not cover all scenarios. For example, it is possible
> > > > for the following to happen:
> > > >
> > > > 1) enter nohz_full, which calls refresh_cpu_vm_stats, syncing the stats.
> > > > 2) app runs mlock, which increases counters for mlock'ed pages.
> > > > 3) start -RT loop
> > > >
> > > > Since refresh_cpu_vm_stats from nohz_full logic can happen _before_
> > > > the mlock, vmstat shepherd can restart vmstat worker thread on
> > > > the CPU in question.
> > >
> > > Can we enter nohz_full after the app runs mlock?
> >
> > Hum, i don't think its a good idea to use that route, because
> > entering or exiting nohz_full depends on a number of variable
> > outside of one's control (and additional variables might be
> > added in the future).
> 
> Then I do not see any need for this patch. Because after a certain time
> of inactivity (after the mlock) the system will enter nohz_full again.
> If userspace has no direct control over nohz_full and can only wait then
> it just has to do so.

Sorry, fail to see what you mean.

The problem (well its not a bug per se, but basically the current
disablement of vmstat_worker thread is not aggressive enough).

From the initial message:

1) enter nohz_full, which calls refresh_cpu_vm_stats, syncing the stats.
2) app runs mlock, which increases counters for mlock'ed pages.
3) start -RT loop

Note that any activity that triggers stat counter changes (other than
mlock, it just happens that it was mlock in the test application i was 
using, just replace with any other system call that triggers writes
to per-CPU vmstat counters), will cause this.

You said:

"Because after a certain time of inactivity (after the mlock) the 
system will enter nohz_full again."

Yes, but we can't tolerate any activity from vmstat worker thread
on this particular CPU.

Do you want the app to wait for an event saying: "vmstat_worker is now
disabled, as long as you don't dirty vmstat counters, vmstat_shepherd
won't wake it up".

Rather than that, what this patch does is to sync the vmstat counters on 
return to userspace, so that:

"We synced per-CPU vmstat counters to global counters, and disable
local-CPU vmstat worker (on return to userspace). As long as you 
don't dirty vmstat counters, vmstat_shepherd won't wake it up".

Makes sense?

> > So preparing the system to function
> > while entering nohz_full at any location seems the sane thing to do.
> >
> > And that would be at return to userspace (since, if mlocked, after
> > that point there will be no more changes to propagate to vmstat
> > counters).
> >
> > Or am i missing something else you can think of ?
> 
> I assumed that the "enter nohz full" was an action by the user
> space app because I saw some earlier patches to introduce such
> functionality in the past.

No, it meant "enter nohz full" (in the current Linux codebase, for
existing applications). 

