Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1130B326EC1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Feb 2021 20:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbhB0TTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Feb 2021 14:19:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:41620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230282AbhB0TSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Feb 2021 14:18:49 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C19E564E04;
        Sat, 27 Feb 2021 19:18:04 +0000 (UTC)
Date:   Sat, 27 Feb 2021 14:18:02 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jacob Wen <jian.w.wen@oracle.com>,
        Pawel Laszczak <pawell@cadence.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/2] tracing: Detect unsafe dereferencing of pointers
 from trace events
Message-ID: <20210227141802.5c9aca91@oasis.local.home>
In-Reply-To: <CAHk-=wiWF=ah_q1HBVUth2vuBx2TieN8U331y5FhXiehX-+=TQ@mail.gmail.com>
References: <20210226185909.100032746@goodmis.org>
        <CAHk-=wiWF=ah_q1HBVUth2vuBx2TieN8U331y5FhXiehX-+=TQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Feb 2021 14:21:00 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, Feb 26, 2021 at 11:07 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > The first patch scans the print fmts of the trace events looking for
> > dereferencing pointers from %p*, and making sure that they refer back
> > to the trace event itself.
> >
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

And after fixing the parsing to not trigger false positives, an
allyesconfig boot found this:

event cdns3_gadget_giveback has unsafe dereference of argument 11
print_fmt: "%s: req: %p, req buff %p, length: %u/%u %s%s%s, status: %d, trb: [start:%d, end:%d: virt addr %pa], flags:%x SID: %u", __get_str(name), REC->req, REC->buf,
 REC->actual, REC->length, REC->zero ? "Z" : "z", REC->short_not_ok ? "S" : "s", REC->no_interrupt ? "I" : "i", REC->status, REC->start_trb, REC->end_trb, REC->start_trb_addr, REC->flags, RE
C->stream_id

(as the above is from a trace event class, it triggered for every event
in that class).

As it looks like it uses %pa which IIUC from the printk code, it
dereferences the pointer to find it's virtual address. The event has
this as the field:

                __field(struct cdns3_trb *, start_trb_addr)

Assigns it with:

                __entry->start_trb_addr = req->trb;

And prints that with %pa, which will dereference pointer at the time of
reading, where the address in question may no longer be around. That
looks to me as a potential bug.

[ Cc'd the people responsible for that code. ]

-- Steve
