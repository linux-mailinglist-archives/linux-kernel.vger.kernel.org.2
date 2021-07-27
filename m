Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF8D3D78BE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 16:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236986AbhG0Oog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 10:44:36 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:57022 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbhG0Oob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 10:44:31 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m8OHl-004NhG-6G; Tue, 27 Jul 2021 14:42:21 +0000
Date:   Tue, 27 Jul 2021 14:42:21 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC][CFT] signal handling fixes
Message-ID: <YQAbTazP4/JB8Aas@zeniv-ca.linux.org.uk>
References: <YP2c1xk9LJ0zE3KW@zeniv-ca.linux.org.uk>
 <5622d120-1b89-6898-d091-8b4ceff6418@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5622d120-1b89-6898-d091-8b4ceff6418@linux-m68k.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2021 at 08:21:52PM +1000, Finn Thain wrote:
> On Sun, 25 Jul 2021, Al Viro wrote:
> 
> > 
> > 	The series is on top of 5.14-rc1; it lives in
> > git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #untested.m68k
> > Individual patches in followups...
> > 
> > 	_Very_ lightly tested on aranym; no real hardware to test it on.
> > Any help with review and testing would be very welcome.
> > 
> 
> I can test this branch on a Motorola 68040 machine I have here. Can you 
> advise how to get decent code coverage? Maybe there's a package out there 
> with a signal-heavy test suite? Maybe I need a break point in a signal 
> handler? Or perhaps just send ^C to a process running under strace?

Generally, SIGINT is not the best insertion vector...

Set a handler of e.g. SIGALRM with sigaction(), with a couple of other signals
in sa_mask (e.g. SIGUSR1 and SIGUSR2).  With raise() on those inside the
SIGALRM handler - then they will become deliverable on return from handler.
And have SIGUSR1 and SIGUSR2 handlers print siginfo and ucontext contents
(have them set with SA_SIGINFO in sa_flags, look at the second and third
arguments of sighandler).

Use alarm(2) to arrange for SIGALRM and sit in a tight loop - that'll give you
delivery on return from interrupt.  Alternatively, raise(SIGALRM) will give
you delivery on return from trap.  And making that a SIGBUS handler instead,
mmapping a file, truncating it to 0 and dereferencing something in mmapped
area will give you delivery on return from access error trap.  Division by
zero (and insertion handler on SIGFPE) ought to give you a type 2 exception
stack frame (4 bytes of aux data, that makes shifted exception frame bugger
format and vector fields of the original).

FWIW, the third argument of handler points to
struct ucontext {
        unsigned long     uc_flags;
        struct ucontext  *uc_link;
        stack_t           uc_stack;
        struct mcontext   uc_mcontext;
        unsigned long     uc_filler[80];
        sigset_t          uc_sigmask;   /* mask last for extensibility */
};
and type/vector is stored in uc_filler[54] (216 bytes into the array), with
aux data from exception stack frame starting from uc_filler[55].
