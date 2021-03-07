Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9895132FE9E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 05:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhCGEC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 23:02:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:56416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229964AbhCGEBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 23:01:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 196FE64FEB;
        Sun,  7 Mar 2021 04:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615089713;
        bh=RVWHB8itdn+TcxVFpUu5BV0AuAsgQxOtiV96uubNodw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qPP0d8hSwaPHZcJmpohMDYr2ylW86uSMo5rzI9MoZd3jAzF+/rd2AQ+NMVqM1+r9i
         FRAQyOOJ9uN4O4ZI0TUag4SsgwmcftDWhis6qRvpbiPETe1G5+SHZvzocea724bYaT
         OLvzCkFfkiNzmnydowkad9xjdCogBN9Rn21vMAy+9ULI5QYg/QcbQIH+Tt28jMS17g
         tx04ynbk5BxdDsadfG1xmLc+mCgVm+eNcp5FK0sZXTdnAsDb2ry06OPFehToS2X6xl
         u4z8ToedUo5ahsSbDLUyUeoH2S30EWTqNlavpXnRSsua6X6Sjz2XdwVWe9Ni53cOi0
         +hvhDyAqPnbiw==
Date:   Sun, 7 Mar 2021 12:01:42 +0800
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
Message-ID: <20210307040142.GA2930@b29397-desktop>
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
> Thanks,
> 

Since the virtual address for req->trb is NULL before using it. It will
trigger below oops using your change. There is already index
(start_trb/end_trb) for which TRB it has handled, it is not necessary
to trace information for its physical address. I decide to delete this
trace entry, thanks for reporting it.

[   61.695160] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
[   61.704066] Mem abort info:
[   61.706910]   ESR = 0x96000006
[   61.710000]   EC = 0x25: DABT (current EL), IL = 32 bits
[   61.715339]   SET = 0, FnV = 0
[   61.718416]   EA = 0, S1PTW = 0
[   61.721575] Data abort info:
[   61.724482]   ISV = 0, ISS = 0x00000006
[   61.728323]   CM = 0, WnR = 0
[   61.731324] user pgtable: 4k pages, 48-bit VAs, pgdp=00000008856dd000
[   61.737816] [0000000000000000] pgd=000000088577a003, p4d=000000088577a003, pud=000000088477c003, pmd=0000000000000000
[   61.748532] Internal error: Oops: 96000006 [#1] PREEMPT SMP

[   61.754113] Modules linked in: fsl_jr_uio caam_jr caamkeyblob_desc caamhash_desc caamalg_desc crypto_engine rng_core authenc libdes crct10dif_ce mxc_jpeg_encdec imx8_media_dev(C) caam error
Message from syslogd@imx8qmmek at Fri Jul 10 06:52:44 2020 ...
imx8qmmek kernel: [   61.748532] Internal error: Oops: 96000006 [#1] PREEMPT SMP
[   61.784245] CPU: 3 PID: 188 Comm: 1-0050 Tainted: G         C        5.10.0-rc7-04451-gfcfe23a5424-dirty #3
[   61.793993] Hardware name: Freescale i.MX8QXP MEK (DT)
[   61.799139] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO BTYPE=--)
[   61.805162] pc : trace_event_raw_event_cdns3_log_request+0xf4/0x170
[   61.811440] lr : trace_event_raw_event_cdns3_log_request+0x94/0x170
[   61.817707] sp : ffff80001387ba40
[   61.821019] x29: ffff80001387ba40 x28: 0000000000000002 
[   61.826336] x27: ffff000801e20080 x26: ffff000800e5c8c8 
[   61.831652] x25: ffff0008044e0c00 x24: ffff000800505308 
[   61.836969] x23: ffff800012464000 x22: 0000000000040050 
[   61.842286] x21: ffff000801e0aa00 x20: ffff0008002e7f18 
[   61.847603] x19: ffff000805131300 x18: 0000000000000000 
[   61.852919] x17: 0000000000000000 x16: 0000000000000000 
[   61.858245] x15: ffff00080081ca78 x14: ffffffffffffffff 
[   61.863570] x13: ffff800012404778 x12: 0000000000000018 
[   61.868896] x11: 0101010101010101 x10: 7f7f7f7f7f7f7f7f 
[   61.874213] x9 : fefefefeff2f6f64 x8 : ffffffffffffffff 
[   61.879529] x7 : ffff8000122b05b8 x6 : 0000000000000001 
[   61.884846] x5 : 0000000000000020 x4 : 0000000000000000 
[   61.890163] x3 : 0000000000000000 x2 : 0000000000000004 
[   61.895479] x1 : 0000000000000000 x0 : ffff80001387ba70 
[   61.900806] Call trace:
[   61.903260]  trace_event_raw_event_cdns3_log_request+0xf4/0x170
[   61.909183]  __traceiter_cdns3_free_request+0x34/0x50
[   61.914241]  cdns3_gadget_ep_free_request+0xa8/0xd8
[   61.919123]  usb_ep_free_request+0x34/0xd8
[   61.923223]  composite_dev_cleanup+0xd0/0x170
[   61.927583]  configfs_composite_unbind+0x68/0xa0
[   61.932205]  usb_gadget_remove_driver+0x4c/0xd0
[   61.936737]  usb_del_gadget+0x6c/0xc8
[   61.940404]  cdns3_gadget_exit+0x4c/0x120
[   61.944420]  cdns3_role_stop+0x60/0x90
[   61.948174]  cdns3_role_set+0x64/0xe0
[   61.951841]  usb_role_switch_set_role.part.0+0x3c/0x90
[   61.956984]  usb_role_switch_set_role+0x20/0x30
[   61.961519]  tcpm_mux_set+0x60/0x80
[   61.965008]  tcpm_reset_port+0xa4/0x108
[   61.968851]  tcpm_detach+0x6c/0xa0
[   61.972256]  tcpm_state_machine_work+0x13e0/0x24a0
[   61.977052]  kthread_worker_fn+0x9c/0x168
[   61.981064]  kthread+0x148/0x168
[   61.984296]  ret_from_fork+0x10/0x18
[   61.987881] Code: b9003a81 b9407661 b9003e81 f9403661 (f9400021) 
[   61.993983] ---[ end trace c8f1af57d3c61281 ]---
[   61.998669] note: 1-0050[188] exited with preempt_count 2

-- 

Thanks,
Peter Chen

