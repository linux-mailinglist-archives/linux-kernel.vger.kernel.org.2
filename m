Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 431AA3AC166
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 05:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbhFRDhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 23:37:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:36774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229819AbhFRDha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 23:37:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1A43661040;
        Fri, 18 Jun 2021 03:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623987322;
        bh=JQqtOevdSJmvOE0cj9b8z4Exyggba2zj4+9rjagc7po=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=rg73rkBSPBiX+pw25gbdLb4TIN2hO6vDj6oj1NAM/7TRByaYQlXDx9nh9kIWF1pjE
         DIfvHB7udXIVl29zm9v/TyIPBRlUs2WYhMENfHJO/Dr7jmhz7fnQ2voCqSXhiDwcm8
         SVuNF3SeGii2Vegub4w/A3roFJXfNXYZIwhuWLpm6s/zZWKUOwyOZbTw5LQo8FmGps
         mmsd8aW+e0vPFCoNWla9GuC3n0T+xzZBIXVezyoWbbiPAFuBdl7+L3iNe3RYwqNUix
         g8f4ZtTxtLCUDj7RPnc0NyXp9lkmAUpBQjjplgkPuTBSsrfW8JiBPIKHDjqQObqKFr
         HCFauQRHr++Cw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DF52A5C0124; Thu, 17 Jun 2021 20:35:21 -0700 (PDT)
Date:   Thu, 17 Jun 2021 20:35:21 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [PATCH 4/8] membarrier: Make the post-switch-mm barrier explicit
Message-ID: <20210618033521.GE4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <cover.1623813516.git.luto@kernel.org>
 <f184d013a255a523116b692db4996c5db2569e86.1623813516.git.luto@kernel.org>
 <1623816595.myt8wbkcar.astroid@bobo.none>
 <YMmpxP+ANG5nIUcm@hirez.programming.kicks-ass.net>
 <617cb897-58b1-8266-ecec-ef210832e927@kernel.org>
 <1623893358.bbty474jyy.astroid@bobo.none>
 <58b949fb-663e-4675-8592-25933a3e361c@www.fastmail.com>
 <c3c7a1cf-1c87-42cc-b2d6-cc2df55e5b57@www.fastmail.com>
 <20210617150214.GX4397@paulmck-ThinkPad-P17-Gen-1>
 <a2df9a2c-520c-55aa-dd48-a4e8fa861bde@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2df9a2c-520c-55aa-dd48-a4e8fa861bde@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 05:06:02PM -0700, Andy Lutomirski wrote:
> On 6/17/21 8:02 AM, Paul E. McKenney wrote:
> > On Wed, Jun 16, 2021 at 10:32:15PM -0700, Andy Lutomirski wrote:
> >> I would appreciate everyone's thoughts as to whether this scheme is sane.
> >>
> >> Paul, I'm adding you for two reasons.  First, you seem to enjoy bizarre locking schemes.  Secondly, because maybe RCU could actually work here.  The basic idea is that we want to keep an mm_struct from being freed at an inopportune time.  The problem with naively using RCU is that each CPU can use one single mm_struct while in an idle extended quiescent state (but not a user extended quiescent state).  So rcu_read_lock() is right out.  If RCU could understand this concept, then maybe it could help us, but this seems a bit out of scope for RCU.
> > 
> > OK, I should look at your patch, but that will be after morning meetings.
> > 
> > On RCU and idle, much of the idle code now allows rcu_read_lock() to be
> > directly, thanks to Peter's recent work.  Any sort of interrupt or NMI
> > from idle can also use rcu_read_lock(), including the IPIs that are now
> > done directly from idle.  RCU_NONIDLE() makes RCU pay attention to the
> > code supplied as its sole argument.
> > 
> > Or is your patch really having the CPU expect a mm_struct to stick around
> > across the full idle sojourn, and without the assistance of mmgrab()
> > and mmdrop()?
> 
> I really do expect it to stick around across the full idle sojourn.
> Unless RCU is more magical than I think it is, this means I can't use RCU.

You are quite correct.  And unfortunately, making RCU pay attention
across the full idle sojourn would make the battery-powered embedded
guys quite annoyed.  And would result in OOM.  You could use something
like percpu_ref, but at a large memory expense.  You could use something
like SRCU or Tasks Trace RCU, but this would increase the overhead of
freeing mm_struct structures.

Your use of per-CPU pointers seems sound in principle, but I am uncertain
of some of the corner cases.  And either current mainline gained an
mmdrop-balance bug or rcutorture is also uncertain of those corner cases.
But again, the overall concept looks quite good.  Just some bugs to
be found and fixed, whether in this patch or in current mainline.
As always...  ;-)

						Thanx, Paul
