Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEDF435601
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 00:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbhJTWnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 18:43:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:38684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229771AbhJTWnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 18:43:18 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F65B6121E;
        Wed, 20 Oct 2021 22:41:02 +0000 (UTC)
Date:   Wed, 20 Oct 2021 18:41:01 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [GIT PULL] tracing: Fix to recursion protection for 5.15
Message-ID: <20211020184101.25b7e583@gandalf.local.home>
In-Reply-To: <20211020181241.0e6a2b47@gandalf.local.home>
References: <20211019091344.65629198@gandalf.local.home>
        <CAHk-=wjvGRtwMHDJ9VR8197+_rVveqE73Uv-MMFbvuUEbWKNtQ@mail.gmail.com>
        <20211020121727.57f46a15@gandalf.local.home>
        <CAHk-=whr2M-jzyv9B8Co0V0TMvCpnH24fWYwxXrN9YeGKicoVw@mail.gmail.com>
        <20211020181241.0e6a2b47@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Oct 2021 18:12:41 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> error: cannot convert from US-ASCII to UTF-8
> fatal: could not parse patch
> 
> But you are right. It's the copying of the header Cc list into the Cc list
> of the commit that is causing my issue. Will investigate it more.

Fixed it.

Had to change the email content type from "US-ASCII" to "UTF-8", which my
perl script now does.

Then with the decode() line you provided, it works as expected.

> 
> I probably could just stop doing that, as it also adds the Link: tag to the
> lore email, which includes all the Cc's.

I guess I can still automate the Cc's without issue. Although I do have
some other scripts that will probably need to be updated.

-- Steve

