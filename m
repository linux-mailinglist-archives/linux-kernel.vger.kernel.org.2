Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4752E32A2FC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377935AbhCBIpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 03:45:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:50252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349458AbhCBIZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 03:25:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E01326148E;
        Tue,  2 Mar 2021 08:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614673441;
        bh=CpzI4Qq3HpAUm+Ff4gmctdpIRhmEXGG9TE6ucokTozY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qYL67jtv2Q77JAOc80jZRkCXt1bfXU0wzM8OLiKhzyPd8un1t1a6G8aEs4tSzw5qG
         8yH6NQoWIUi7R1FC1LTn+nmsJd0bPXWAFKej1MDxtf8YY3AJWZf2d8mCLqcDKBm8sG
         3ru9kMH8gSZHSNNSwNhQB5u47MARpQm0ql5A2EUELSMJyIXSj6+QQXXpfQaOPmhR9l
         7Fbvn41n9w4MBw07B/74PTimC/tZxnL7FlqAVr5XSo9GUymkhnj7YJ8o3cVjZnIWY+
         gE7bNRb09QH382MlgBTu9lG7JgrIUOSRLlJCytW/Ft8OQJ6iwoiySWzkrEIx0MZnI+
         qyEqqHyMoyYlA==
Date:   Tue, 2 Mar 2021 16:23:55 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Pawel Laszczak <pawell@cadence.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jacob Wen <jian.w.wen@oracle.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/2] tracing: Detect unsafe dereferencing of pointers
 from trace events
Message-ID: <20210302082355.GA8633@nchen>
References: <20210226185909.100032746@goodmis.org>
 <CAHk-=wiWF=ah_q1HBVUth2vuBx2TieN8U331y5FhXiehX-+=TQ@mail.gmail.com>
 <20210227141802.5c9aca91@oasis.local.home>
 <20210227190831.56956c80@oasis.local.home>
 <BYAPR07MB5381637CFA12C3988CA06550DD9A9@BYAPR07MB5381.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR07MB5381637CFA12C3988CA06550DD9A9@BYAPR07MB5381.namprd07.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-03-01 05:27:04, Pawel Laszczak wrote:
> 
> + Peter Chen - Maintainer of CDNS3 driver
> 
> >
> >[ Resending with an address that should work for Felipe ]
> >
> >On Sat, 27 Feb 2021 14:18:02 -0500
> >Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> >> On Fri, 26 Feb 2021 14:21:00 -0800
> >> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> >>
> >> > On Fri, Feb 26, 2021 at 11:07 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >> > >
> >> > > The first patch scans the print fmts of the trace events looking for
> >> > > dereferencing pointers from %p*, and making sure that they refer back
> >> > > to the trace event itself.
> >> > >
> >> > > The second patch handles strings "%s" [..]
> >> >
> >> > Doing this at runtime really feels like the wrong thing to do.
> >> >
> >> > It won't even protect us from what happened - people like me and
> >> > Andrew won't even run those tracepoints in the first place, so we
> >> > won't notice.
> >> >
> >> > It really would be much better in every respect to have this done by
> >> > checkpatch, I think.
> >>
> >> And after fixing the parsing to not trigger false positives, an
> >> allyesconfig boot found this:
> >>
> >> event cdns3_gadget_giveback has unsafe dereference of argument 11
> >> print_fmt: "%s: req: %p, req buff %p, length: %u/%u %s%s%s, status: %d, trb: [start:%d, end:%d: virt addr %pa], flags:%x SID: %u",
> >__get_str(name), REC->req, REC->buf,
> >>  REC->actual, REC->length, REC->zero ? "Z" : "z", REC->short_not_ok ? "S" : "s", REC->no_interrupt ? "I" : "i", REC->status, REC-
> >>start_trb, REC->end_trb, REC->start_trb_addr, REC->flags, RE
> >> C->stream_id
> >>
> >> (as the above is from a trace event class, it triggered for every event
> >> in that class).
> >>
> >> As it looks like it uses %pa which IIUC from the printk code, it
> >> dereferences the pointer to find it's virtual address. The event has
> >> this as the field:
> >>
> >>                 __field(struct cdns3_trb *, start_trb_addr)
> >>
> >> Assigns it with:
> >>
> >>                 __entry->start_trb_addr = req->trb;
> >>
> >> And prints that with %pa, which will dereference pointer at the time of
> >> reading, where the address in question may no longer be around. That
> >> looks to me as a potential bug.

Steven, thanks for reporting. Do you mind sending patch to fix it?
If you have no time to do it, I will do it later.

-- 

Thanks,
Peter Chen

