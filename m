Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98806354372
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 17:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238190AbhDEP3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 11:29:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:49090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232714AbhDEP3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 11:29:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D76F6023C;
        Mon,  5 Apr 2021 15:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617636558;
        bh=uKy44W1uGRjErySUYpDqlKgjBfYLGjsAn/hSQdItGTs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=EtNEVH66w94/0W1R/exU9ugdf8+LILee3vFRBBTgxkBUySoQ3iRVang6Zu9YE203G
         syeM6hvA1HpXEH86f1yPzg6+V6tI7XL+xx0YLIQqX3Xrh0dPa18D/vgEcoxrWFY5zG
         BfPXrB9VhJ/g1iMcpqBat+NCZy8TG3pWylKpXQyvue75xrxn117d3hHjsamOjFYMm1
         L35EOvDwmS4bDQTANr6o3/O4qoa7HoPA2LHSInJkxfRq1uhyg8QUpO7ztG9Wn/qvH3
         lhv34jBfPNOfNqdW507nRKiQODraJOMbqHJVYYNQQSyFZVQxY28WnL8TUEbGAjTAc1
         4DrhL+nWYxQFA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 35BB135225D5; Mon,  5 Apr 2021 08:29:18 -0700 (PDT)
Date:   Mon, 5 Apr 2021 08:29:18 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, mhocko@suse.com, peterz@infradead.org
Subject: Re: [PATCH v3 3/4] kernel/smp: add more data to CSD lock debugging
Message-ID: <20210405152918.GH2696@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210302062838.14267-1-jgross@suse.com>
 <20210302062838.14267-4-jgross@suse.com>
 <7babbca6-1325-7a3a-d1f0-13a8dbf8043f@suse.com>
 <20210330173344.GX2696@paulmck-ThinkPad-P72>
 <5881c48a-0429-199c-8669-5fbceda0a283@suse.com>
 <20210402161105.GS2696@paulmck-ThinkPad-P72>
 <e2e75e97-b4ec-670d-1632-3d6cd529ae8c@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e2e75e97-b4ec-670d-1632-3d6cd529ae8c@suse.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2021 at 09:37:40AM +0200, Juergen Gross wrote:
> On 02.04.21 18:11, Paul E. McKenney wrote:
> > On Fri, Apr 02, 2021 at 05:46:52PM +0200, Juergen Gross wrote:
> > > On 30.03.21 19:33, Paul E. McKenney wrote:
> > > > On Wed, Mar 24, 2021 at 11:18:03AM +0100, Jürgen Groß wrote:
> > > > > On 02.03.21 07:28, Juergen Gross wrote:
> > > > > > In order to help identifying problems with IPI handling and remote
> > > > > > function execution add some more data to IPI debugging code.
> > > > > > 
> > > > > > There have been multiple reports of cpus looping long times (many
> > > > > > seconds) in smp_call_function_many() waiting for another cpu executing
> > > > > > a function like tlb flushing. Most of these reports have been for
> > > > > > cases where the kernel was running as a guest on top of KVM or Xen
> > > > > > (there are rumours of that happening under VMWare, too, and even on
> > > > > > bare metal).
> > > > > > 
> > > > > > Finding the root cause hasn't been successful yet, even after more than
> > > > > > 2 years of chasing this bug by different developers.
> > > > > > 
> > > > > > Commit 35feb60474bf4f7 ("kernel/smp: Provide CSD lock timeout
> > > > > > diagnostics") tried to address this by adding some debug code and by
> > > > > > issuing another IPI when a hang was detected. This helped mitigating
> > > > > > the problem (the repeated IPI unlocks the hang), but the root cause is
> > > > > > still unknown.
> > > > > > 
> > > > > > Current available data suggests that either an IPI wasn't sent when it
> > > > > > should have been, or that the IPI didn't result in the target cpu
> > > > > > executing the queued function (due to the IPI not reaching the cpu,
> > > > > > the IPI handler not being called, or the handler not seeing the queued
> > > > > > request).
> > > > > > 
> > > > > > Try to add more diagnostic data by introducing a global atomic counter
> > > > > > which is being incremented when doing critical operations (before and
> > > > > > after queueing a new request, when sending an IPI, and when dequeueing
> > > > > > a request). The counter value is stored in percpu variables which can
> > > > > > be printed out when a hang is detected.
> > > > > > 
> > > > > > The data of the last event (consisting of sequence counter, source
> > > > > > cpu, target cpu, and event type) is stored in a global variable. When
> > > > > > a new event is to be traced, the data of the last event is stored in
> > > > > > the event related percpu location and the global data is updated with
> > > > > > the new event's data. This allows to track two events in one data
> > > > > > location: one by the value of the event data (the event before the
> > > > > > current one), and one by the location itself (the current event).
> > > > > > 
> > > > > > A typical printout with a detected hang will look like this:
> > > > > > 
> > > > > > csd: Detected non-responsive CSD lock (#1) on CPU#1, waiting 5000000003 ns for CPU#06 scf_handler_1+0x0/0x50(0xffffa2a881bb1410).
> > > > > > 	csd: CSD lock (#1) handling prior scf_handler_1+0x0/0x50(0xffffa2a8813823c0) request.
> > > > > >            csd: cnt(00008cc): ffff->0000 dequeue (src cpu 0 == empty)
> > > > > >            csd: cnt(00008cd): ffff->0006 idle
> > > > > >            csd: cnt(0003668): 0001->0006 queue
> > > > > >            csd: cnt(0003669): 0001->0006 ipi
> > > > > >            csd: cnt(0003e0f): 0007->000a queue
> > > > > >            csd: cnt(0003e10): 0001->ffff ping
> > > > > >            csd: cnt(0003e71): 0003->0000 ping
> > > > > >            csd: cnt(0003e72): ffff->0006 gotipi
> > > > > >            csd: cnt(0003e73): ffff->0006 handle
> > > > > >            csd: cnt(0003e74): ffff->0006 dequeue (src cpu 0 == empty)
> > > > > >            csd: cnt(0003e7f): 0004->0006 ping
> > > > > >            csd: cnt(0003e80): 0001->ffff pinged
> > > > > >            csd: cnt(0003eb2): 0005->0001 noipi
> > > > > >            csd: cnt(0003eb3): 0001->0006 queue
> > > > > >            csd: cnt(0003eb4): 0001->0006 noipi
> > > > > >            csd: cnt now: 0003f00
> > > > > > 
> > > > > > This example (being an artificial one, produced with a previous version
> > > > > > of this patch without the "hdlend" event), shows that cpu#6 started to
> > > > > > handle an IPI (cnt 3e72-3e74), bit didn't start to handle another IPI
> > > > > > (sent by cpu#4, cnt 3e7f). The next request from cpu#1 for cpu#6 was
> > > > > > queued (3eb3), but no IPI was needed (cnt 3eb4, there was the event
> > > > > > from cpu#4 in the queue already).
> > > > > > 
> > > > > > The idea is to print only relevant entries. Those are all events which
> > > > > > are associated with the hang (so sender side events for the source cpu
> > > > > > of the hanging request, and receiver side events for the target cpu),
> > > > > > and the related events just before those (for adding data needed to
> > > > > > identify a possible race). Printing all available data would be
> > > > > > possible, but this would add large amounts of data printed on larger
> > > > > > configurations.
> > > > > > 
> > > > > > Signed-off-by: Juergen Gross <jgross@suse.com>
> > > > > > Tested-by: Paul E. McKenney <paulmck@kernel.org>
> > > > > 
> > > > > Just an update regarding current status with debugging the underlying
> > > > > issue:
> > > > > 
> > > > > On a customer's machine with a backport of this patch applied we've
> > > > > seen another case of the hang. In the logs we've found:
> > > > > 
> > > > > smp: csd: Detected non-responsive CSD lock (#1) on CPU#18, waiting
> > > > > 5000000046 ns for CPU#06 do_flush_tlb_all+0x0/0x30(          (null)).
> > > > > smp: 	csd: CSD lock (#1) unresponsive.
> > > > > smp: 	csd: cnt(0000000): 0000->0000 queue
> > > > > smp: 	csd: cnt(0000001): ffff->0006 idle
> > > > > smp: 	csd: cnt(0025dba): 0012->0006 queue
> > > > > smp: 	csd: cnt(0025dbb): 0012->0006 noipi
> > > > > smp: 	csd: cnt(01d1333): 001a->0006 pinged
> > > > > smp: 	csd: cnt(01d1334): ffff->0006 gotipi
> > > > > smp: 	csd: cnt(01d1335): ffff->0006 handle
> > > > > smp: 	csd: cnt(01d1336): ffff->0006 dequeue (src cpu 0 == empty)
> > > > > smp: 	csd: cnt(01d1337): ffff->0006 hdlend (src cpu 0 == early)
> > > > > smp: 	csd: cnt(01d16cb): 0012->0005 ipi
> > > > > smp: 	csd: cnt(01d16cc): 0012->0006 queue
> > > > > smp: 	csd: cnt(01d16cd): 0012->0006 ipi
> > > > > smp: 	csd: cnt(01d16f3): 0012->001a ipi
> > > > > smp: 	csd: cnt(01d16f4): 0012->ffff ping
> > > > > smp: 	csd: cnt(01d1750): ffff->0018 hdlend (src cpu 0 == early)
> > > > > smp: 	csd: cnt(01d1751): 0012->ffff pinged
> > > > > smp: 	csd: cnt now: 01d1769
> > > > > 
> > > > > So we see that cpu#18 (0012 hex) is waiting for cpu#06 (first line of the
> > > > > data).
> > > > > 
> > > > > The next 4 lines of the csd actions are not really interesting, as they are
> > > > > rather old.
> > > > > 
> > > > > Then we see that cpu 0006 did handle a request rather recently (cnt 01d1333
> > > > > - 01d1337): cpu 001a pinged it via an IPI and it got the IPI, entered the
> > > > > handler, dequeued a request, and handled it.
> > > > > 
> > > > > Nearly all of the rest shows the critical request: cpu 0012 did a loop over
> > > > > probably all other cpus and queued the requests and marked them to be IPI-ed
> > > > > (including cpu 0006, cnt 01d16cd). Then the cpus marked to receive an IPI
> > > > > were pinged (cnt 01d16f4 and cnt 01d1751).
> > > > > 
> > > > > The entry cnt 01d1750 is not of interest here.
> > > > > 
> > > > > This data confirms that on sending side everything seems to be okay at the
> > > > > level above the actual IPI sending. On receiver side there seems no IPI to
> > > > > be seen, but there is no visible reason for a race either.
> > > > > 
> > > > > It seems as if we need more debugging in the deeper layers: is the IPI
> > > > > really sent out, and is something being received on the destination cpu?
> > > > > I'll have another try with even more debugging code, probably in private
> > > > > on the customer machine first.
> > > > 
> > > > Apologies for the late reply, was out last week.
> > > > 
> > > > Excellent news, and thank you!
> > > > 
> > > > For my part, I have put together a rough prototype script that allows
> > > > me to run scftorture on larger groups of systems and started running it,
> > > > though I am hoping that 1,000 is far more than will be required.
> > > > 
> > > > Your diagnosis of a lost IPI matches what we have been able to glean
> > > > from the occasional occurrences in the wild on our systems, for whatever
> > > > that might be worth.  The hope is to get something that reproduces more
> > > > quickly, which would allow deeper debugging at this end as well.
> > > 
> > > Sometimes one is lucky.
> > > 
> > > I've found a reproducer while hunting another bug. The test on that
> > > machine will trigger the csd_lock timeout about once a day.
> > 
> > Nice!!!  You are way ahead of me!
> > 
> > > I've used my new debug kernel and found that the IPI is really sent
> > > out (more precise: the hypervisor has been requested to do so, and
> > > it didn't report an error). On the target cpu there was no interrupt
> > > received after that, so the IPI has not been swallowed on the target
> > > cpu by the Linux kernel.
> > > 
> > > Will now try to instrument the hypervisor to get more data.
> > 
> > I am increasing the number and types of systems and the test duration.
> > Ijust started running three different systems with IPI workloads in both
> > guests and within host over the weekend.
> 
> Maybe you can try my kind of workload:
> 
> I have a guest with 16 vcpus and 8 GB of memory running 8 instances of
> 
> sysbench --test=fileio --file-test-mode=rndrw --rand-seed=0 --max-time=300
> --max-requests=0 run
> 
> on disjunct nfs mounts. Those have been created with:
> 
> mount -t nfs -o
> rw,proto=tcp,nolock,nfsvers=3,rsize=65536,wsize=65536,nosharetransport
> server:/share[1-8] /mount[1-8]
> 
> with the server running on the host system of the guest and the shares
> located in a ramdisk.
> 
> The host has 72 cpus and 48 GB of RAM.
> 
> A csd lock timeout happens about once per day on the host.

Thank you!  I will give it a try.  It has been quite some time since I
have done anything with NFS, so it should be entertaining.  ;-)

							Thanx, Paul
