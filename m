Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D579B36B091
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 11:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232660AbhDZJat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 05:30:49 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:23499
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232103AbhDZJas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 05:30:48 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Adni3r6PQeKGVXcBcTlijsMiAIKoaSvp033AA?=
 =?us-ascii?q?3SlKJiB9WMqeisyogbA/3Rj7lD4eVBgb6Le9EYOHRm7R8oMw3JkJMd6ZLW3bkU?=
 =?us-ascii?q?ahMY0K1+vf6hL6HSmWzIBg/IdmN5NzEdjhSWV95PyKhTWQN/YF7J25/LuzheHY?=
 =?us-ascii?q?pk0dLz1CT6179Q92BkK6PyRNJTVuPpYyGJqC6scvnVPJEkg/Vci1CmIIWOLOvb?=
 =?us-ascii?q?Tw+K7OWwIMBBIs9WC15w+A1biSKXWl9ysFXygK6bkv9nWtqX2b2pme?=
X-IronPort-AV: E=Sophos;i="5.82,252,1613430000"; 
   d="scan'208";a="379672947"
Received: from yquem.paris.inria.fr ([128.93.101.33])
  by mail3-relais-sop.national.inria.fr with ESMTP; 26 Apr 2021 11:30:00 +0200
Received: by yquem.paris.inria.fr (Postfix, from userid 18041)
        id 7C111A006F; Mon, 26 Apr 2021 11:30:00 +0200 (CEST)
Date:   Mon, 26 Apr 2021 11:30:00 +0200
From:   Luc Maranget <Luc.Maranget@inria.fr>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     szyhb810501.student@sina.com, stern <stern@rowland.harvard.edu>,
        "parri.andrea" <parri.andrea@gmail.com>, will <will@kernel.org>,
        peterz <peterz@infradead.org>,
        "boqun.feng" <boqun.feng@gmail.com>, npiggin <npiggin@gmail.com>,
        dhowells <dhowells@redhat.com>,
        "j.alglave" <j.alglave@ucl.ac.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Documentation/memory-barriers.txt: Is "stores are not
 speculated" correct?
Message-ID: <20210426093000.GA2583903@yquem.paris.inria.fr>
References: <20210426022309.2333D4640475@webmail.sinamail.sina.com.cn>
 <20210426035043.GW975577@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210426035043.GW975577@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Apr 26, 2021 at 10:23:09AM +0800, szyhb810501.student@sina.com wrote:
> > 
> > Hello everyone, I have a question."Documentation/memory-barriers.txt"
> > says:However, stores are not speculated.  This means that ordering -is-
> > providedfor load-store control dependencies, as in the following example:
> 	q = READ_ONCE(a);
> 	if (q) {
> 		WRITE_ONCE(b, 1);
> 	}
> > Is "stores are not speculated" correct? I
> > think store instructions can be executed speculatively.
> > "https://stackoverflow.com/questions/64141366/can-a-speculatively-executed-cpu-branch-contain-opcodes-that-access-ram"
> > says:Store instructions can also be executed speculatively thanks to the
> > store buffer. The actual execution of a store just writes the address and
> > data into the store buffer.Commit to L1d cache happens some time after
> > the store instruction retires from the ROB, i.e. when the store is known
> > to be non-speculative, the associated store-buffer entry "graduates"
> > and becomes eligible to commit to cache and become globally visible.
> 
> >From the viewpoint of other CPUs, the store hasn't really happened
> until it finds its way into a cacheline.  As you yourself note above,
> if the store is still in the store buffer, it might be squashed when
> speculation fails.
> 
> So Documentation/memory-barriers.txt and that stackoverflow entry are
> not really in conflict, but are instead using words a bit differently
> from each other.  The stackoverflow entry is considering a store to have
> in some sense happened during a time when it might later be squashed.
> In contrast, the Documentation/memory-barriers.txt document only considers
> a store to have completed once it is visible outside of the CPU executing
> that store.
> 
> So from a stackoverflow viewpoint, stores can be speculated, but until
> they are finalized, they must be hidden from other CPUs.
> 
> >From a Documentation/memory-barriers.txt viewpoint, stores don't complete
> until they update their cachelines, and stores may not be speculated.
> Some of the actions that lead up to the completion of a store may be
> speculated, but not the completion of the store itself.
> 
> Different words, but same effect.  Welcome to our world!  ;-)
> 
> 							Thanx, Paul

Hi all,

Here is a complement to Paul's excellent answer.

The "CPU-local" speculation of stores can be observed
by the following test (in C11)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

C PPOCA

{}

P0(volatile int* y, volatile int* x) {

  atomic_store(x,1);
  atomic_store(y,1);

}

P1(volatile int* z, volatile int* y, volatile int* x) {

  int r1=-1; int r2=-1;
  int r0 = atomic_load_explicit(y,memory_order_relaxed);
  if (r0) {
    atomic_store_explicit(z,1,memory_order_relaxed);
    r1 = atomic_load_explicit(z,memory_order_relaxed);
    r2 = atomic_load_explicit(x+(r1 & 128),memory_order_relaxed);
  }

}


This is a variation on the MP test.

Because of tht conditionnal "if (..) { S }" Statements "S" can be executed
speculatively.

More precisely, the store statement writes value 1 into the CPU local
structure for variable z. The next load statement reads the value,
and the last load statement can be peformed (speculatively)
as its address is known.

The resulting outcomme is observed for instance on a RaspBerry Pi3,
see attached file.

--Luc

