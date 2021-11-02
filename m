Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3A5744290E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 09:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhKBIFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 04:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhKBIFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 04:05:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC3CC061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 01:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rMcaU0eXNJrQzQEGjllDL02FizhCwJm5AcvCOAERMAk=; b=DJ/r/DbPU1N+tG8eTERztYDKZX
        vEpPchywZxXvrlKBaYXzlF5z8d4aQhh0RJeUMqB2JZTD+nVy+9vY29QAOkCVxHXFi1F5Pp4uPwdJz
        790L6QY6KX6iZbc9sVwHj7ToVCJax039RCz49vshYkWDNBkA1SS2G8yvBGa83T+Andqj0V2+R/sA2
        xQbHuE4rA2J0Y+VyQCcoN3SHGC5UuMWm/vUrv92g73gKmN2Z/6EGKd3Lm31RW9lk3Q7xkb8pWkR7B
        W+nmtlEHiO4m3nUJPN5Wjfm7ehzmgkg1zwjI9sZ/be6wcWVH0W5mveyzKNu5elI9P8i/KYkuFAdm7
        3Ibg+Lfw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mhoij-004M5X-Sc; Tue, 02 Nov 2021 08:00:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3DC93300130;
        Tue,  2 Nov 2021 09:00:36 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2BE052D202F07; Tue,  2 Nov 2021 09:00:36 +0100 (CET)
Date:   Tue, 2 Nov 2021 09:00:36 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] objtool/core for v5.16-rc1
Message-ID: <YYDwJORywW2FjprP@hirez.programming.kicks-ass.net>
References: <163572864256.3357115.931779940195622047.tglx@xen13>
 <163572864563.3357115.8793939214537874196.tglx@xen13>
 <CAHk-=wgNzL3AaVNruwLv=kcGXi1EbJN9CZC6GoRY66t6WFcfGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgNzL3AaVNruwLv=kcGXi1EbJN9CZC6GoRY66t6WFcfGg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 01, 2021 at 01:44:39PM -0700, Linus Torvalds wrote:
> On Sun, Oct 31, 2021 at 6:16 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > please pull the latest objtool/core branch from:
> 
> Hmm. I've pulled this, but I'm not happy about the new warnings it
> generates with an allmodconfig build:

Right, due to fixing the dependency on !PARAVIRT, allyesconfig now does
a noinstr validation, and this is the result.

>   vmlinux.o: warning: objtool: __do_fast_syscall_32()+0xa: call to
> stackleak_track_stack() leaves .noinstr.text section
>    ..
>     mce_setup()+0x18: call to memset ...

Boris was having a poke at the MCE stuff.

>     rcu_dynticks_eqs_enter()+0x0: call to rcu_dynticks_task_trace_enter ...
>     rcu_dynticks_eqs_exit()+0xe: call to rcu_dynticks_task_trace_exit ...
>     rcu_nmi_enter()+0x36: call to __kasan_check_read ...

Fixes for those ^ should be in the rcu tree.

There were also a bunch of Xen ones that should be fixed in the Xen
tree, perhaps you've already pulled that.

>     do_machine_check()+0x27: call to stackleak_track_stack ...
>     do_syscall_64()+0x9: call to stackleak_track_stack ...
>     do_int80_syscall_32()+0x9: call to stackleak_track_stack ...
>     exc_general_protection()+0x22: call to stackleak_track_stack ...
>     fixup_bad_iret()+0x20: call to stackleak_track_stack ...
>     .entry.text+0x10e6: call to stackleak_erase ...
>     .entry.text+0x143: call to stackleak_erase ...
>     .entry.text+0x17d9: call to stackleak_erase ...
> 
> most seem to be about the stackleak thing,

Right, I recently ran into this and hacen't yet had time to look into
it. I suspect my normal build box doesn't have the GCC plugin crud
enabled or somesuch.

I think the GCC stackleak plugin needs fixing, specifically it needs a
function attribute such that it will not emit instrumentation in noinstr
functions. I'll go chase down the developer of that thing.
