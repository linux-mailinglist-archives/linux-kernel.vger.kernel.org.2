Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADD831360B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 16:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232729AbhBHPFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 10:05:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:51776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232212AbhBHPDC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 10:03:02 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2FCB64E8C;
        Mon,  8 Feb 2021 15:02:08 +0000 (UTC)
Date:   Mon, 8 Feb 2021 10:02:06 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@intel.com>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [GIT PULL] x86/urgent for v5.11-rc7
Message-ID: <20210208100206.3b74891e@gandalf.local.home>
In-Reply-To: <20210207224540.ercf5657pftibyaw@treble>
References: <20210207104022.GA32127@zn.tnic>
        <CAHk-=widXSyJ8W3vRrqO-zNP12A+odxg2J2_-oOUskz33wtfqA@mail.gmail.com>
        <20210207175814.GF32127@zn.tnic>
        <CAHk-=wi5z9S7x94SKYNj6qSHBqz+OD76GW=MDzo-KN2Fzm-V4Q@mail.gmail.com>
        <20210207224540.ercf5657pftibyaw@treble>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Feb 2021 16:45:40 -0600
Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> > I do suspect involved people should start thinking about how they want
> > to deal with functions starting with
> > 
> >         endbr64
> >         call __fentry__
> > 
> > instead of the call being at the very top of the function.  
> 
> FWIW, objtool's already fine with it (otherwise we would have discovered
> the need to disable fcf-protection much sooner).

And this doesn't really affect tracing (note, another user that might be
affected is live kernel patching). The way this change was noticed, was
that there was a report of someone that was be able to connect a bpf
program to a function for one machine but not for another machine. The
other machine had this CET thingy.

The difference is, when you attach a probe to the start of a function,
kprobes will check if the probe address (start of function) is located at a
ftrace location (nop / __fentry__) and if it is, it would use the ftrace
infrastructure instead of attaching an int3 breakpoint. Because of the
enbr64 being at the start of the function, the check returned false (it was
not a ftrace location) and it attached an int3 breakpoint instead.

This uncovered another "bug". Peter Zijlstra made int3 handlers look like
NMIs (in_nmi() would return true in an int3 handler). The BPF programs would
not run in NMI context. But nobody noticed, because people usually attach
BPF programs to the start of a function using kprobes, and since kprobes
would use ftrace handlers (that don't set in_nmi() to true), everything
worked. But when the "endbr64" was added at the start of the program,
kprobes fell back to int3, and suddenly the BPF programs stopped working.

-- Steve
