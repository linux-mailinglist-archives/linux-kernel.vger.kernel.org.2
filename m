Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1DE31CC70
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 15:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhBPOwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 09:52:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:37598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229912AbhBPOwE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 09:52:04 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7551B64E02;
        Tue, 16 Feb 2021 14:51:23 +0000 (UTC)
Date:   Tue, 16 Feb 2021 09:51:21 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] ftrace: Do not reference symbols in sections without
 size
Message-ID: <20210216095121.4fe321dc@gandalf.local.home>
In-Reply-To: <YCumppsKxaheg/II@kroah.com>
References: <20210215164446.530f6311@gandalf.local.home>
        <20210216000504.axm3k4xho47c6drz@treble>
        <20210215200639.67141685@oasis.local.home>
        <20210215210057.4ceb6339@oasis.local.home>
        <YCumppsKxaheg/II@kroah.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Feb 2021 12:04:06 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> Thanks for this.
> 
> Should I also queue these up for 4.9 and 4.14 which do not have these
> commits in them either (but somehow do not show the problem, yet)?

This bothers me. I want to know exactly why this is a problem.

That said, it is fine to backport those patches, and I would include 4.9
and 4.14, as I would think you have a similar requirement that we have in
the stable-rt trees. That is you shouldn't experience a regression going
from an older kernel to a newer one because the older one had a fix
backported to it that a newer one did not. Basically the same rationale that
all fixes go into Linus's tree before backporting. We do the same on the
stable-rt, where all fixes go in all maintained stable trees that are newer
than the one you are backporting to.

Although, it does allow more to be traced than what recordmcount enables.
But hopefully it doesn't cause any issues. Maybe I should do some ftrace
testing before you go and release any of those stables with those patches.

I'm looking to see if this new "feature" of binutils isn't causing trouble
elsewhere. I'm thinking that ftrace is just the canary here.

-- Steve
