Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1785A33B102
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 12:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhCOL0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 07:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbhCOL0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 07:26:25 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E777BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 04:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PkS09dHjL7wCqFAVZrH7z1VTUzqbWyeJVd/Z0fvQH6E=; b=bbWakZfRQePriJK7RQpP+6HPPJ
        WLKnbSK6AEmTwbGms5NiChu8Ut3sUkZAyw0r0DayNaIqD8mbMT1+1VxxoiSi5EszTxWmAhoiEt+iW
        2F4nfy8i9ho2ok/AET6xVi9Let9w5lw+Z6P7fKJN6rRfJpDx3IIwC0PCe5AKrBM6nqHKY6rKKQDCo
        2CM1RNaDHM090CIfNjrJ/sqAZElILJc6FKDRHOJpV4As3XVsO+RQH/tZVB4L0NqD//YXGJ1GVOsiD
        X5bdQ9/npAalmQcQxbRFkV2b75uQmZxR5DKqEDcECDnWyyEV70GYjK3Za/evvgrvBk8GsHYV2bSKk
        aoBD4MlA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lLlMT-00Ff1J-Cg; Mon, 15 Mar 2021 11:26:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 033E5301324;
        Mon, 15 Mar 2021 12:26:12 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AC46A23CC2263; Mon, 15 Mar 2021 12:26:12 +0100 (CET)
Date:   Mon, 15 Mar 2021 12:26:12 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [GIT pull] locking/urgent for v5.12-rc3
Message-ID: <YE9EVNG4/5UMJvFp@hirez.programming.kicks-ass.net>
References: <161573639668.27979.17827928369874291298.tglx@nanos>
 <CAHk-=wjuD2cCptSJmmHBp2c9chTPnZcSi+0vA+QJ8JNjYTJKCw@mail.gmail.com>
 <YE8b6dgsEG4OU0ay@hirez.programming.kicks-ass.net>
 <YE9AkgbqL+eVO6p1@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YE9AkgbqL+eVO6p1@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 12:10:10PM +0100, Peter Zijlstra wrote:
> On Mon, Mar 15, 2021 at 09:33:45AM +0100, Peter Zijlstra wrote:
> > On Sun, Mar 14, 2021 at 01:15:25PM -0700, Linus Torvalds wrote:
> > > On Sun, Mar 14, 2021 at 8:40 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> > > >
> > > >  - A fix for the static_call mechanism so it handles unaligned
> > > >    addresses correctly.
> > > 
> > > I'm not disputing the fix in any way, but why weren't the relocation
> > > info and function start addresses mutually aligned?
> > > 
> > > Are we perhaps missing some .align directive somewhere?
> > > 
> > > Or am I missing something?
> > 
> > So I considered looking into that, but since carrying the flag on the
> > absolute address is always correct I figured it was the more robust fix.
> > 
> > I suppose I can try and figure out where alignment went wobbly.
> 
> include/asm-generic/vmlinux.lds.h:
> 
> #define STATIC_CALL_DATA						\
> 	. = ALIGN(8);							\
> 	__start_static_call_sites = .;					\
> 	KEEP(*(.static_call_sites))					\
> 	__stop_static_call_sites = .;					\
> 	__start_static_call_tramp_key = .;				\
> 	KEEP(*(.static_call_tramp_key))					\
> 	__stop_static_call_tramp_key = .;
> 
> #ifndef RO_AFTER_INIT_DATA
> #define RO_AFTER_INIT_DATA						\
> 	. = ALIGN(8);							\
> 	__start_ro_after_init = .;					\
> 	*(.data..ro_after_init)						\
> 	JUMP_TABLE_DATA							\
> 	STATIC_CALL_DATA						\
> 	__end_ro_after_init = .;
> #endif
> 
> 	.rodata           : AT(ADDR(.rodata) - LOAD_OFFSET) {		\
> 		__start_rodata = .;					\
> 		*(.rodata) *(.rodata.*)					\
> 		SCHED_DATA						\
> 		RO_AFTER_INIT_DATA	/* Read only after init */	\
> 		. = ALIGN(8);						\
> 		__start___tracepoints_ptrs = .;				\
> 		KEEP(*(__tracepoints_ptrs)) /* Tracepoints: pointer array */ \
> 		__stop___tracepoints_ptrs = .;				\
> 		*(__tracepoints_strings)/* Tracepoints: strings */	\
> 	}								\
> 
> 
> $ nm defconfig-build/vmlinux | grep static_call_sites
> ffffffff82916dc0 D __start_static_call_sites
> ffffffff8291aaf0 D __stop_static_call_sites
> 
> 
> Which all reads to me like it *SHOULD* work. Howver when I was debugging
> the crash as reported by Steve (using his .config), I definitely saw
> non-aligned base offsets causing mayhem.

Ooooh, modules don't have this. They still have regular
.static_call_sites sections, and *those* are unaligned.

Section Headers:
[Nr] Name              Type            Address          Off    Size   ES Flg Lk Inf Al

[16] .static_call_sites PROGBITS        0000000000000000 008aa1 0006f0 00  WA  0   0  1

And that goes *BOOM*.. Let me ses if I can figure out how to make
objtool align those sections.
