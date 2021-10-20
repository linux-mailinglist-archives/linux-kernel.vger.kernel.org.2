Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09FFD4355C4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 00:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbhJTWO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 18:14:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:33418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229695AbhJTWO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 18:14:58 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6E47611CB;
        Wed, 20 Oct 2021 22:12:42 +0000 (UTC)
Date:   Wed, 20 Oct 2021 18:12:41 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [GIT PULL] tracing: Fix to recursion protection for 5.15
Message-ID: <20211020181241.0e6a2b47@gandalf.local.home>
In-Reply-To: <CAHk-=whr2M-jzyv9B8Co0V0TMvCpnH24fWYwxXrN9YeGKicoVw@mail.gmail.com>
References: <20211019091344.65629198@gandalf.local.home>
        <CAHk-=wjvGRtwMHDJ9VR8197+_rVveqE73Uv-MMFbvuUEbWKNtQ@mail.gmail.com>
        <20211020121727.57f46a15@gandalf.local.home>
        <CAHk-=whr2M-jzyv9B8Co0V0TMvCpnH24fWYwxXrN9YeGKicoVw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Oct 2021 10:59:28 -1000
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, Oct 20, 2021 at 6:17 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > Oh, and I have a perl script that also adds "Cc"s. That could have done it
> > as well. :-/  
> 
> That sounds like the likely culprit.
> 
> I think doing a simple
> 
>    decode("MIME-Header", $cc)
> 
> should do it, but I'm not a perl person.

Well, that solves it from copying the header into the Cc list. But then I
have this error when running the git am:

error: cannot convert from US-ASCII to UTF-8
fatal: could not parse patch

But you are right. It's the copying of the header Cc list into the Cc list
of the commit that is causing my issue. Will investigate it more.

I probably could just stop doing that, as it also adds the Link: tag to the
lore email, which includes all the Cc's.

-- Steve
