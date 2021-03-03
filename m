Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 898BC32BA78
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 21:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357642AbhCCLXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 06:23:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:34024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346927AbhCCCHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 21:07:09 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D069161606;
        Wed,  3 Mar 2021 01:54:57 +0000 (UTC)
Date:   Tue, 2 Mar 2021 20:54:56 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Chen <peter.chen@kernel.org>
Cc:     Pawel Laszczak <pawell@cadence.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jacob Wen <jian.w.wen@oracle.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/2] tracing: Detect unsafe dereferencing of pointers
 from trace events
Message-ID: <20210302205456.391a14a8@gandalf.local.home>
In-Reply-To: <20210303012139.GA11703@nchen>
References: <20210226185909.100032746@goodmis.org>
        <CAHk-=wiWF=ah_q1HBVUth2vuBx2TieN8U331y5FhXiehX-+=TQ@mail.gmail.com>
        <20210227141802.5c9aca91@oasis.local.home>
        <20210227190831.56956c80@oasis.local.home>
        <BYAPR07MB5381637CFA12C3988CA06550DD9A9@BYAPR07MB5381.namprd07.prod.outlook.com>
        <20210302082355.GA8633@nchen>
        <20210302095605.7b2881cd@gandalf.local.home>
        <20210303012139.GA11703@nchen>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Mar 2021 09:21:39 +0800
Peter Chen <peter.chen@kernel.org> wrote:

> On 21-03-02 09:56:05, Steven Rostedt wrote:
> > On Tue, 2 Mar 2021 16:23:55 +0800
> > Peter Chen <peter.chen@kernel.org> wrote:
> > 
> > s it looks like it uses %pa which IIUC from the printk code, it  
> > > > >> dereferences the pointer to find it's virtual address. The event has
> > > > >> this as the field:
> > > > >>
> > > > >>                 __field(struct cdns3_trb *, start_trb_addr)
> > > > >>
> > > > >> Assigns it with:
> > > > >>
> > > > >>                 __entry->start_trb_addr = req->trb;
> > > > >>
> > > > >> And prints that with %pa, which will dereference pointer at the time of
> > > > >> reading, where the address in question may no longer be around. That
> > > > >> looks to me as a potential bug.    
> > > 
> > > Steven, thanks for reporting. Do you mind sending patch to fix it?
> > > If you have no time to do it, I will do it later.
> > >   
> > 
> > I would have already fixed it, but I wasn't exactly sure how this is used.
> > 
> > In Documentation/core-api/printk-formats.rst we have:
> > 
> >    Physical address types phys_addr_t
> >    ----------------------------------
> > 
> >    ::
> > 
> >            %pa[p]  0x01234567 or 0x0123456789abcdef
> > 
> >    For printing a phys_addr_t type (and its derivatives, such as
> >    resource_size_t) which can vary based on build options, regardless of the
> >    width of the CPU data path.
> > 
> > So it only looks like it is used to for the size of the pointer.
> > 
> > I guess something like this might work:
> > 
> > diff --git a/drivers/usb/cdns3/cdns3-trace.h b/drivers/usb/cdns3/cdns3-trace.h
> > index 8648c7a7a9dd..d3b8624fc427 100644
> > --- a/drivers/usb/cdns3/cdns3-trace.h
> > +++ b/drivers/usb/cdns3/cdns3-trace.h
> > @@ -214,7 +214,7 @@ DECLARE_EVENT_CLASS(cdns3_log_request,
> >  		__field(int, no_interrupt)
> >  		__field(int, start_trb)
> >  		__field(int, end_trb)
> > -		__field(struct cdns3_trb *, start_trb_addr)
> > +		__field(phys_addr_t, start_trb_addr)
> >  		__field(int, flags)
> >  		__field(unsigned int, stream_id)
> >  	),
> > @@ -230,7 +230,7 @@ DECLARE_EVENT_CLASS(cdns3_log_request,
> >  		__entry->no_interrupt = req->request.no_interrupt;
> >  		__entry->start_trb = req->start_trb;
> >  		__entry->end_trb = req->end_trb;
> > -		__entry->start_trb_addr = req->trb;
> > +		__entry->start_trb_addr = *(const phys_addr_t *)req->trb;
> >  		__entry->flags = req->flags;
> >  		__entry->stream_id = req->request.stream_id;
> >  	),
> > @@ -244,7 +244,7 @@ DECLARE_EVENT_CLASS(cdns3_log_request,
> >  		__entry->status,
> >  		__entry->start_trb,
> >  		__entry->end_trb,
> > -		__entry->start_trb_addr,
> > +		/* %pa dereferences */ &__entry->start_trb_addr,
> >  		__entry->flags,
> >  		__entry->stream_id
> >  	)
> > 
> > 
> > Can you please test it? I don't have the hardware, but I also want to make
> > sure I don't break anything.
> >   
> 
> Hi Steve,
> 
> Regarding this issue, I have one question:
> - If the virtual address is got from dma_alloc_coherent, can't we print
> this address using %pa to get its physical address (the same with DMA address),
> or its DMA address using %pad? req->trb is the virtual address got from

I'm not sure. I just looked at the vsprintf code, which simply does:

> static noinline_for_stack
> char *address_val(char *buf, char *end, const void *addr,
> 		  struct printf_spec spec, const char *fmt)
> {
> 	unsigned long long num;
> 	int size;
> 
> 	if (check_pointer(&buf, end, addr, spec))
> 		return buf;
> 
> 	switch (fmt[1]) {
> 	case 'd':
> 		num = *(const dma_addr_t *)addr;
> 		size = sizeof(dma_addr_t);

The above is what is called, which dereferences addr and places it into num.

> 		break;
> 	case 'p':
> 	default:
> 		num = *(const phys_addr_t *)addr;
> 		size = sizeof(phys_addr_t);
> 		break;
> 	}
> 
> 	return special_hex_number(buf, end, num, size);

This just prints the hex number defined by num. There's no physical address
calculations done via vsprintf that I'm aware of.

> }



> dma_alloc_coherent. And what's the logic for this "unsafe dereference" warning?

The actions done in TP_fast_assign() are executed at the time of the trace
event (i.e. when trace_cdns3_ep_queue() is called), but the actions of
TP_printk() are executed when the user reads the trace file (minutes,
hours, days later!). Thus, when you have a TP_printk("... %pa ...", and a
__entry->start_trb_addr referenced, that start_trb_addr may be pointing to
something that is long gone, and when you use a kernel vsnprintf()
dereferencing pointer like %pa (or %pU, %pM, etc), it may read something
that no longer exists, and is obviously unsafe.

So I created this patch series (in this thread, you can use lore to see it)
that analyzes the trace events as they get register, parses the TP_printk()
for any dereferencing pointers, and makes sure that what it is dereferencing
lives on the ring buffer. Otherwise it is likely referencing something that
may no longer be around when it gets dereferenced.

I booted an allyesconfig with this logic and your event triggered the
warning, and it was the only event in the kernel to do so. Thus, I've been
pretty good at policing trace events from doing such things (I've stopped a
lot of them from getting into the kernel by manually reviewing every trace
event that is Cc'd to me).

I hope that answers your question.

-- Steve


