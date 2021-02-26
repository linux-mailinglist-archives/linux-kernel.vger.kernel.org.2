Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAAB326A6A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Feb 2021 00:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbhBZXdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 18:33:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:51076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229698AbhBZXdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 18:33:52 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B907764E83;
        Fri, 26 Feb 2021 23:33:11 +0000 (UTC)
Date:   Fri, 26 Feb 2021 18:33:09 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jacob Wen <jian.w.wen@oracle.com>
Subject: Re: [PATCH 0/2] tracing: Detect unsafe dereferencing of pointers
 from trace events
Message-ID: <20210226183309.0edcc54d@gandalf.local.home>
In-Reply-To: <CAHk-=wiWF=ah_q1HBVUth2vuBx2TieN8U331y5FhXiehX-+=TQ@mail.gmail.com>
References: <20210226185909.100032746@goodmis.org>
        <CAHk-=wiWF=ah_q1HBVUth2vuBx2TieN8U331y5FhXiehX-+=TQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Feb 2021 14:21:00 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> > The second patch handles strings "%s" [..]  
> 
> Doing this at runtime really feels like the wrong thing to do.
> 
> It won't even protect us from what happened - people like me and
> Andrew won't even run those tracepoints in the first place, so we
> won't notice.
> 
> It really would be much better in every respect to have this done by
> checkpatch, I think.

They are not mutually exclusive. We could have both. One thing that's nice
about this patch is that it removes the possibility of a real bug. That is,
it will catch the dereferencing of a string that is not valid, WARN about
it, but it wont try to dereference it (outside of the
strcpy_from_kernel_nofault()). And hopefully the warning and lack of data
they want, will have this get caught during development.

Also, there's cases that %s is allowed to reference data that I don't know
if checkpatch would be able to differentiate.

As for the other pointer dereferences (the first patch), those get caught
at boot up if they are compiled in. That is, you don't need to have the
events enabled. The boot up code will do the verification on all events
that are loaded (allyesconfig will catch all of them, which I need to try
to boot with this code).

-- Steve
