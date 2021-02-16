Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB9131CFB0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 18:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbhBPRy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 12:54:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:38478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231231AbhBPRyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 12:54:13 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66FBE64E04;
        Tue, 16 Feb 2021 17:53:31 +0000 (UTC)
Date:   Tue, 16 Feb 2021 12:53:29 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] ftrace: Do not reference symbols in sections without
 size
Message-ID: <20210216125329.5dcc9e03@gandalf.local.home>
In-Reply-To: <YCvq0hkIvgcKAas2@kroah.com>
References: <20210215164446.530f6311@gandalf.local.home>
        <20210216000504.axm3k4xho47c6drz@treble>
        <20210215200639.67141685@oasis.local.home>
        <20210215210057.4ceb6339@oasis.local.home>
        <YCumppsKxaheg/II@kroah.com>
        <20210216095121.4fe321dc@gandalf.local.home>
        <20210216154539.qac763oef4czrtss@treble>
        <YCvq0hkIvgcKAas2@kroah.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Feb 2021 16:54:58 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Tue, Feb 16, 2021 at 09:45:39AM -0600, Josh Poimboeuf wrote:
> > On Tue, Feb 16, 2021 at 09:51:21AM -0500, Steven Rostedt wrote:  
> > > On Tue, 16 Feb 2021 12:04:06 +0100
> > > Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > >   
> > > > Thanks for this.
> > > > 
> > > > Should I also queue these up for 4.9 and 4.14 which do not have these
> > > > commits in them either (but somehow do not show the problem, yet)?  
> > >
> > > This bothers me. I want to know exactly why this is a problem.  
> > 
> > I actually see the same problem with 4.9 and 4.14, using the same
> > config.  
> 

Interesting. I removed the "-mrecordmcount" option from 5.10.16, and I'm
currently building it, and so far it has no issues. :-/

This is on a fresh install of archlinux using binutils 2.36-3.

> Ok, that's good to know.
> 
> > It's very config-specific.  Something has to convince the toolchain to
> > not reference those two weak functions by section.  
> 
> I've queued up all 3 patches (Steven collapsed 2 into 1 it seems) for
> 4.4.y, 4.9.y, and 4.14.y now.

Which were the three patches. And if I collapsed it into 1, that was by
mistake :-/  I was doing the work on the archlinux VM and was using quilt
to fix up the backport (as I usually do), but I was using vim instead of my
normal emacs (yes I'm one of those), and may have screwed things up.

> 
> > > That said, it is fine to backport those patches, and I would include 4.9
> > > and 4.14, as I would think you have a similar requirement that we have in
> > > the stable-rt trees. That is you shouldn't experience a regression going
> > > from an older kernel to a newer one because the older one had a fix
> > > backported to it that a newer one did not. Basically the same rationale that
> > > all fixes go into Linus's tree before backporting. We do the same on the
> > > stable-rt, where all fixes go in all maintained stable trees that are newer
> > > than the one you are backporting to.
> > > 
> > > Although, it does allow more to be traced than what recordmcount enables.
> > > But hopefully it doesn't cause any issues. Maybe I should do some ftrace
> > > testing before you go and release any of those stables with those patches.
> > > 
> > > I'm looking to see if this new "feature" of binutils isn't causing trouble
> > > elsewhere. I'm thinking that ftrace is just the canary here.  
> > 
> > It already caused quite a bit of trouble with objtool (as did a previous
> > similar change by the Clang assembler).  
> 
> I feel like we go through this every major binutils release.  Why isn't
> "build the Linux kernel" part of the binutils regression test suite by
> now?  :)

Perhaps it builds the latest kernel fine? As I said, I'm currently testing
a 5.10 build (couldn't get the 4.4 to boot, so I wanted to see if the issue
is on 5.10 as that's the kernel they were using).

-- Steve

