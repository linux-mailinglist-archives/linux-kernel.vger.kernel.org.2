Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8CEE442A16
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 10:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhKBJIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 05:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhKBJIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 05:08:37 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69D4C061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 02:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=t5NNARZCESkBMHbSFDkU2uCQli76k4Fpys6MwbkQNlo=; b=mSQ2ZFseLavWzq0jedg7nLp2UV
        zjZuZR/r/S4Xu2qHwUi51oGatHYNHlYSK98Z7QrgzNukrlAVxxFHoe8Ig92/rKA4/hd1W3vxgwp7d
        fAlBDfArWqZhgUZOA2A2nadUpkFy0YdJ1n57vrUZGZO6l1VL6hUjZQuqqRXawOEZfdU0VUUs3fdot
        7shBeHxjO0xURBIbiumt6BPkrfr1pOg3iFhQX6c8PpnThDuz/1mhmVZOoqFoln5NpsssIQ7exLZ/j
        zFUVI3zHvNXaCRnze6bupk38Mk4StB7tVotrqqRQlYQQSBHei21Q853ZweFbyPkMkbECmihpv9iqL
        8NzWmdvA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mhpjt-00DjBb-1H; Tue, 02 Nov 2021 09:05:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9FF1E30022C;
        Tue,  2 Nov 2021 10:05:50 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 88106202732EF; Tue,  2 Nov 2021 10:05:50 +0100 (CET)
Date:   Tue, 2 Nov 2021 10:05:50 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Alexander Popov <alex.popov@linux.com>
Subject: Stackleak vs noinstr (Was: [GIT pull] objtool/core for v5.16-rc1)
Message-ID: <YYD/bpLabfumrvL+@hirez.programming.kicks-ass.net>
References: <163572864256.3357115.931779940195622047.tglx@xen13>
 <163572864563.3357115.8793939214537874196.tglx@xen13>
 <CAHk-=wgNzL3AaVNruwLv=kcGXi1EbJN9CZC6GoRY66t6WFcfGg@mail.gmail.com>
 <YYDwJORywW2FjprP@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYDwJORywW2FjprP@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2021 at 09:00:36AM +0100, Peter Zijlstra wrote:
> On Mon, Nov 01, 2021 at 01:44:39PM -0700, Linus Torvalds wrote:

> >     do_machine_check()+0x27: call to stackleak_track_stack ...
> >     do_syscall_64()+0x9: call to stackleak_track_stack ...
> >     do_int80_syscall_32()+0x9: call to stackleak_track_stack ...
> >     exc_general_protection()+0x22: call to stackleak_track_stack ...
> >     fixup_bad_iret()+0x20: call to stackleak_track_stack ...
> >     .entry.text+0x10e6: call to stackleak_erase ...
> >     .entry.text+0x143: call to stackleak_erase ...
> >     .entry.text+0x17d9: call to stackleak_erase ...
> > 
> > most seem to be about the stackleak thing,
> 
> Right, I recently ran into this and hacen't yet had time to look into
> it. I suspect my normal build box doesn't have the GCC plugin crud
> enabled or somesuch.
> 
> I think the GCC stackleak plugin needs fixing, specifically it needs a
> function attribute such that it will not emit instrumentation in noinstr
> functions. I'll go chase down the developer of that thing.

Alexander, is there any way to make this plugin grow a function
attribute which we can add to noinstr ? There's a strict requirement the
compiler doesn't add extra code to noinstr functions these days.

We'll 'soon' be running noinstr C code before switching to kernel page
tables even.
