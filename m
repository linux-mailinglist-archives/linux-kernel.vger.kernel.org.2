Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 920F332B778
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 12:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351537AbhCCLKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 06:10:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:37644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237428AbhCCBXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 20:23:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6182864FAB;
        Wed,  3 Mar 2021 01:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614734505;
        bh=VUBb0VvNaMz+gL0iRQlrXVk6Yf5iiLcf60PqNijW8+8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o/3nSsQFkf5tA0HiZrE4wsjnRDwnHOBA3//vfm69LtlfEh3jJpDpozNvJ9R6jzssJ
         MGoFaKt7otLsAOfPWlOudE/OAQJX/gpxRhOaZaM0d4ZjnAZ/wRMNaMKHkPV3HrJD7s
         KdGxXltmojwBCUs5rRpZANOr2I9onF7LZtaPrkjoAMNBCfE2945XxXSm/W68AH10tk
         CZrGg2UeFD6Vlt8OOE/ksF2kScckuEDsHvzXJ75gDdMx+90ypYHkk8HXZ0Lj/bZDrt
         3PxZdS1VN/N83N1tC0Oy/BiZicSO1z8c8K+YYO5NQcMdqxlqe6GCjF4UA5Hh4f7Ffh
         HDVS6nsFTcAqA==
Date:   Wed, 3 Mar 2021 09:21:39 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
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
Message-ID: <20210303012139.GA11703@nchen>
References: <20210226185909.100032746@goodmis.org>
 <CAHk-=wiWF=ah_q1HBVUth2vuBx2TieN8U331y5FhXiehX-+=TQ@mail.gmail.com>
 <20210227141802.5c9aca91@oasis.local.home>
 <20210227190831.56956c80@oasis.local.home>
 <BYAPR07MB5381637CFA12C3988CA06550DD9A9@BYAPR07MB5381.namprd07.prod.outlook.com>
 <20210302082355.GA8633@nchen>
 <20210302095605.7b2881cd@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302095605.7b2881cd@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-03-02 09:56:05, Steven Rostedt wrote:
> On Tue, 2 Mar 2021 16:23:55 +0800
> Peter Chen <peter.chen@kernel.org> wrote:
> 
> s it looks like it uses %pa which IIUC from the printk code, it
> > > >> dereferences the pointer to find it's virtual address. The event has
> > > >> this as the field:
> > > >>
> > > >>                 __field(struct cdns3_trb *, start_trb_addr)
> > > >>
> > > >> Assigns it with:
> > > >>
> > > >>                 __entry->start_trb_addr = req->trb;
> > > >>
> > > >> And prints that with %pa, which will dereference pointer at the time of
> > > >> reading, where the address in question may no longer be around. That
> > > >> looks to me as a potential bug.  
> > 
> > Steven, thanks for reporting. Do you mind sending patch to fix it?
> > If you have no time to do it, I will do it later.
> > 
> 
> I would have already fixed it, but I wasn't exactly sure how this is used.
> 
> In Documentation/core-api/printk-formats.rst we have:
> 
>    Physical address types phys_addr_t
>    ----------------------------------
> 
>    ::
> 
>            %pa[p]  0x01234567 or 0x0123456789abcdef
> 
>    For printing a phys_addr_t type (and its derivatives, such as
>    resource_size_t) which can vary based on build options, regardless of the
>    width of the CPU data path.
> 
> So it only looks like it is used to for the size of the pointer.
> 
> I guess something like this might work:
> 
> diff --git a/drivers/usb/cdns3/cdns3-trace.h b/drivers/usb/cdns3/cdns3-trace.h
> index 8648c7a7a9dd..d3b8624fc427 100644
> --- a/drivers/usb/cdns3/cdns3-trace.h
> +++ b/drivers/usb/cdns3/cdns3-trace.h
> @@ -214,7 +214,7 @@ DECLARE_EVENT_CLASS(cdns3_log_request,
>  		__field(int, no_interrupt)
>  		__field(int, start_trb)
>  		__field(int, end_trb)
> -		__field(struct cdns3_trb *, start_trb_addr)
> +		__field(phys_addr_t, start_trb_addr)
>  		__field(int, flags)
>  		__field(unsigned int, stream_id)
>  	),
> @@ -230,7 +230,7 @@ DECLARE_EVENT_CLASS(cdns3_log_request,
>  		__entry->no_interrupt = req->request.no_interrupt;
>  		__entry->start_trb = req->start_trb;
>  		__entry->end_trb = req->end_trb;
> -		__entry->start_trb_addr = req->trb;
> +		__entry->start_trb_addr = *(const phys_addr_t *)req->trb;
>  		__entry->flags = req->flags;
>  		__entry->stream_id = req->request.stream_id;
>  	),
> @@ -244,7 +244,7 @@ DECLARE_EVENT_CLASS(cdns3_log_request,
>  		__entry->status,
>  		__entry->start_trb,
>  		__entry->end_trb,
> -		__entry->start_trb_addr,
> +		/* %pa dereferences */ &__entry->start_trb_addr,
>  		__entry->flags,
>  		__entry->stream_id
>  	)
> 
> 
> Can you please test it? I don't have the hardware, but I also want to make
> sure I don't break anything.
> 

Hi Steve,

Regarding this issue, I have one question:
- If the virtual address is got from dma_alloc_coherent, can't we print
this address using %pa to get its physical address (the same with DMA address),
or its DMA address using %pad? req->trb is the virtual address got from
dma_alloc_coherent. And what's the logic for this "unsafe dereference" warning?
Thanks.

-- 

Thanks,
Peter Chen

