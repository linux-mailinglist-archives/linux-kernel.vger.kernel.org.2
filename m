Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBAFD36B5E1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 17:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbhDZPfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 11:35:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:38914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233674AbhDZPfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 11:35:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5757261076;
        Mon, 26 Apr 2021 15:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619451278;
        bh=nYfb459qFwWehbg682QkMMpTIrSHFTgfTvJhC2rPM4U=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=aWCuFGUK8yi1PFvfjGqucCiT0CIop6ymd3vSloQTA/ZK1ybT85ituwNSswELoRMnN
         5JzTpJ55mTK7vMrO4LRixNOTykIPtRJ2BB9XZ11o9OQ7I1OrgxCUgH3CxI/R5PVnKK
         myyWgQbY7J40LBO9FALlXz5KMZiOUEmTg31EdlN3dP4SMWsD6xuquq42epW1NpHchR
         ZqzHr8Tt8fNP4bAsomU/kxeCBk0EqXQi02pEYLmgxteHZIz4ndvX6qbm7DlEZs4+wC
         69yytJ+HzYrn8PD8fswkfr+zomiP2u1NThfG50jvwCPqvRiyvGTScIvCDpjRWM6Kb5
         JY8RywMTGoG9Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D6B0A5C0121; Mon, 26 Apr 2021 08:34:37 -0700 (PDT)
Date:   Mon, 26 Apr 2021 08:34:37 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     maranget <luc.maranget@inria.fr>
Cc:     Randy Dunlap <rdunlap@infradead.org>, szyhb810501.student@sina.com,
        stern <stern@rowland.harvard.edu>,
        "parri.andrea" <parri.andrea@gmail.com>, will <will@kernel.org>,
        peterz <peterz@infradead.org>,
        "boqun.feng" <boqun.feng@gmail.com>, npiggin <npiggin@gmail.com>,
        dhowells <dhowells@redhat.com>,
        "j.alglave" <j.alglave@ucl.ac.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Documentation/memory-barriers.txt: Is "stores are not
 speculated" correct?
Message-ID: <20210426153437.GZ975577@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210426022309.2333D4640475@webmail.sinamail.sina.com.cn>
 <20210426035043.GW975577@paulmck-ThinkPad-P17-Gen-1>
 <20210426093000.GA2583903@yquem.paris.inria.fr>
 <a1c077a9-cae3-724e-a2e5-832cf5a86708@infradead.org>
 <8846FB06-D0CD-4880-93A5-E6D959AF23C1@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8846FB06-D0CD-4880-93A5-E6D959AF23C1@inria.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 05:16:15PM +0200, maranget wrote:
> 
> 
> > On 26 Apr 2021, at 17:13, Randy Dunlap <rdunlap@infradead.org> wrote:
> > 
> > On 4/26/21 2:30 AM, Luc Maranget wrote:
> >>> On Mon, Apr 26, 2021 at 10:23:09AM +0800, szyhb810501.student@sina.com wrote:
> >>>> 
> >>>> Hello everyone, I have a question."Documentation/memory-barriers.txt"
> >>>> says:However, stores are not speculated.  This means that ordering -is-
> >>>> providedfor load-store control dependencies, as in the following example:
> >>> 	q = READ_ONCE(a);
> >>> 	if (q) {
> >>> 		WRITE_ONCE(b, 1);
> >>> 	}
> >>>> Is "stores are not speculated" correct? I
> >>>> think store instructions can be executed speculatively.
> >>>> "https://stackoverflow.com/questions/64141366/can-a-speculatively-executed-cpu-branch-contain-opcodes-that-access-ram"
> >>>> says:Store instructions can also be executed speculatively thanks to the
> >>>> store buffer. The actual execution of a store just writes the address and
> >>>> data into the store buffer.Commit to L1d cache happens some time after
> >>>> the store instruction retires from the ROB, i.e. when the store is known
> >>>> to be non-speculative, the associated store-buffer entry "graduates"
> >>>> and becomes eligible to commit to cache and become globally visible.
> >>> 
> >>>> From the viewpoint of other CPUs, the store hasn't really happened
> >>> until it finds its way into a cacheline.  As you yourself note above,
> >>> if the store is still in the store buffer, it might be squashed when
> >>> speculation fails.
> >>> 
> >>> So Documentation/memory-barriers.txt and that stackoverflow entry are
> >>> not really in conflict, but are instead using words a bit differently
> >>> from each other.  The stackoverflow entry is considering a store to have
> >>> in some sense happened during a time when it might later be squashed.
> >>> In contrast, the Documentation/memory-barriers.txt document only considers
> >>> a store to have completed once it is visible outside of the CPU executing
> >>> that store.
> >>> 
> >>> So from a stackoverflow viewpoint, stores can be speculated, but until
> >>> they are finalized, they must be hidden from other CPUs.
> >>> 
> >>>> From a Documentation/memory-barriers.txt viewpoint, stores don't complete
> >>> until they update their cachelines, and stores may not be speculated.
> >>> Some of the actions that lead up to the completion of a store may be
> >>> speculated, but not the completion of the store itself.
> >>> 
> >>> Different words, but same effect.  Welcome to our world!  ;-)
> >>> 
> >>> 							Thanx, Paul
> >> 
> >> Hi all,
> >> 
> >> Here is a complement to Paul's excellent answer.
> >> 
> >> The "CPU-local" speculation of stores can be observed
> >> by the following test (in C11)
> >> 
> >> %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
> >> 
> >> C PPOCA
> >> 
> >> {}
> >> 
> >> P0(volatile int* y, volatile int* x) {
> >> 
> >>  atomic_store(x,1);
> >>  atomic_store(y,1);
> >> 
> >> }
> >> 
> >> P1(volatile int* z, volatile int* y, volatile int* x) {
> >> 
> >>  int r1=-1; int r2=-1;
> >>  int r0 = atomic_load_explicit(y,memory_order_relaxed);
> >>  if (r0) {
> >>    atomic_store_explicit(z,1,memory_order_relaxed);
> >>    r1 = atomic_load_explicit(z,memory_order_relaxed);
> >>    r2 = atomic_load_explicit(x+(r1 & 128),memory_order_relaxed);
> >>  }
> >> 
> >> }
> >> 
> >> 
> >> This is a variation on the MP test.
> >> 
> >> Because of tht conditionnal "if (..) { S }" Statements "S" can be executed
> >> speculatively.
> >> 
> >> More precisely, the store statement writes value 1 into the CPU local
> >> structure for variable z. The next load statement reads the value,
> >> and the last load statement can be peformed (speculatively)
> >> as its address is known.
> >> 
> >> The resulting outcomme is observed for instance on a RaspBerry Pi3,
> >> see attached file.
> > 
> > ?attached file?
> > 
> > -- 
> > ~Randy
> > 
> 
> Oups, sorry I forgot the attachement:
> 
> —Luc

> Mon Apr 26 09:07:19 UTC 2021
> %%%%%%%%%%%%%%%%%%%%%%%%%%%%
> % Results for PPOCA.litmus %
> %%%%%%%%%%%%%%%%%%%%%%%%%%%%
> C PPOCA
> 
> {}
> 
> P0(volatile int* y, volatile int* x) {
> 
>   atomic_store(x,1);
>   atomic_store(y,1);
> 
> }
> 
> P1(volatile int* z, volatile int* y, volatile int* x) {
> 
>   int r1=-1; int r2=-1;
>   int r0 = atomic_load_explicit(y,memory_order_relaxed);
>   if (r0) {
>     atomic_store_explicit(z,1,memory_order_relaxed);
>     r1 = atomic_load_explicit(z,memory_order_relaxed);
>     r2 = atomic_load_explicit(x+(r1 & 128),memory_order_relaxed);
>   }
> 
> }
> 
> 
> exists (1:r0=1 /\ 1:r1=1 /\ 1:r2=0)
> 
> Histogram (3 states)
> 11057696:>1:r0=0; 1:r1=-1; 1:r2=-1;
> 2     *>1:r0=1; 1:r1=1; 1:r2=0;

Fun!!!  ;-)

							Thanx, Paul

> 8942302:>1:r0=1; 1:r1=1; 1:r2=1;
> Ok
> 
> Witnesses
> Positive: 2, Negative: 19999998
> Condition exists (1:r0=1 /\ 1:r1=1 /\ 1:r2=0) is validated
> Hash=bb2426936c19f1555410d1483dd31452
> Observation PPOCA Sometimes 2 19999998
> Time PPOCA 3.30
> Revision 45690d9d0f7a956a6d3dbaf9e912efb22835756e, version 7.56+02~dev
> Command line: litmus7 -mach vougeot -c11 true -o R.tar PPOCA.litmus
> Parameters
> #define SIZE_OF_TEST 10000
> #define NUMBER_OF_RUN 100
> #define AVAIL 4
> #define STRIDE 1
> #define MAX_LOOP 0
> /* gcc options: -Wall -std=gnu11 -O2 -pthread */
> /* barrier: userfence */
> /* launch: changing */
> /* affinity: none */
> /* alloc: dynamic */
> /* memory: direct */
> /* stride: 1 */
> /* safer: write */
> /* preload: random */
> /* speedcheck: no */
> /* proc used: 4 */
> GCC=gcc
> LITMUSOPTS=-s 5k -r 2k -st 1
> Mon Apr 26 09:07:23 UTC 2021

> 
> 

