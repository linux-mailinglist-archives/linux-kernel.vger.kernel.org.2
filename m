Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C350442F4AD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 16:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239730AbhJOOGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 10:06:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:57196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236710AbhJOOGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 10:06:10 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 688D260F70;
        Fri, 15 Oct 2021 14:04:03 +0000 (UTC)
Date:   Fri, 15 Oct 2021 10:04:01 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Norbert <nbrtt01@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Performance regression: thread wakeup time (latency) increased
 up to 3x
Message-ID: <20211015100401.45833169@gandalf.local.home>
In-Reply-To: <5fe0ffa5-f2db-ca79-5a10-305310066ff9@gmail.com>
References: <035c23b4-118e-6a35-36d9-1b11e3d679f8@gmail.com>
        <YWlBUVDy9gOMiXls@hirez.programming.kicks-ass.net>
        <5fe0ffa5-f2db-ca79-5a10-305310066ff9@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Oct 2021 02:36:03 -0700
Norbert <nbrtt01@gmail.com> wrote:

> On 10/15/21 01:52, Peter Zijlstra wrote:
> > On Fri, Oct 15, 2021 at 12:43:45AM -0700, Norbert wrote:  
> >> Performance regression: thread wakeup time (latency) increased up to 3x.
> >>
> >> Happened between 5.13.8 and 5.14.0. Still happening at least on 5.14.11.  
> > 
> > Could you git-bisect this?
> >   
> 
> So far I haven't built a kernel yet, I'm quite new to Linux in that way, 
> so it may take me some time to figure it all out, but yes.

If you do test a kernel you build yourself, you may want to use
"localmodconfig". Which will look at all the modules that are loaded on the
local system and turn off the configs for modules that are not loaded. This
will save a lot of time compiling the kernel. Especially if your basing off
of a distro config.

  $ git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
  $ cd linux
  $ cp /boot/config-[whatever your kernel is] .config
  $ yes '' | make localmodconfig

Then build your kernel.

  $ make -j10
  $ sudo make modules_install install

> 
> (By the way, of course I meant that throughput *de*creases, not increases.)

of course ;-)

-- Steve
