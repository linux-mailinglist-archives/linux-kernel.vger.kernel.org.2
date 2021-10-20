Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9796434FF9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 18:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbhJTQTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 12:19:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:53506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230077AbhJTQTp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 12:19:45 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDBFF60F24;
        Wed, 20 Oct 2021 16:17:29 +0000 (UTC)
Date:   Wed, 20 Oct 2021 12:17:27 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [GIT PULL] tracing: Fix to recursion protection for 5.15
Message-ID: <20211020121727.57f46a15@gandalf.local.home>
In-Reply-To: <CAHk-=wjvGRtwMHDJ9VR8197+_rVveqE73Uv-MMFbvuUEbWKNtQ@mail.gmail.com>
References: <20211019091344.65629198@gandalf.local.home>
        <CAHk-=wjvGRtwMHDJ9VR8197+_rVveqE73Uv-MMFbvuUEbWKNtQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Oct 2021 06:10:22 -1000
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> Either let the email tools do proper decoding of the headers and
> cut-and-paste from that, or use one of the explicit tools that do
> email header decoding (there's at least a few online ones).
> 
> Yeah, yeah, I know, we're much too used to US-ASCII (or, in my case,
> the slightly expanded Western Latin1), and there's a couple of other
> examples of this in the git history, but we really should strive to
> get peoples names right.
> 

I don't cut-and-paste, but I do pull from my internal patchwork tool. Let
me go and see if that caused the format change.

Oh, and I have a perl script that also adds "Cc"s. That could have done it
as well. :-/

I'll go reproduce it and see where it happened.

-- Steve
