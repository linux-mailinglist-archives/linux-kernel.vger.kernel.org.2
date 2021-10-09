Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBC9427D27
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 21:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbhJITlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 15:41:00 -0400
Received: from netrider.rowland.org ([192.131.102.5]:54311 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S229783AbhJITk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 15:40:59 -0400
Received: (qmail 754485 invoked by uid 1000); 9 Oct 2021 15:39:01 -0400
Date:   Sat, 9 Oct 2021 15:39:01 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     zhuyinbo <zhuyinbo@loongson.cn>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <greg@kroah.com>,
        Patchwork Bot <patchwork-bot@kernel.org>
Subject: Re: [PATCH v3] usb: ohci: add check for host controller functional
 states
Message-ID: <20211009193901.GA753830@rowland.harvard.edu>
References: <1633677970-10619-1-git-send-email-zhuyinbo@loongson.cn>
 <20211008142639.GA721194@rowland.harvard.edu>
 <7a505fc4-ec47-ac83-633f-7a5251bd5f82@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7a505fc4-ec47-ac83-633f-7a5251bd5f82@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 09, 2021 at 10:01:25AM +0800, zhuyinbo wrote:
> 
> 在 2021/10/8 下午10:26, Alan Stern 写道:
> > On Fri, Oct 08, 2021 at 03:26:10PM +0800, Yinbo Zhu wrote:
> > > The usb states of ohci controller include UsbOperational, UsbReset,
> > > UsbSuspend and UsbResume. Among them, only the UsbOperational state
> > > supports launching the start of frame for host controller according
> > > the ohci protocol spec, but in S3/S4 press test procedure, it may
> > Nobody reading this will know what "S3/S4 press test procedure" means.
> > You have to explain it, or use a different name that people will
> > understand.
> okay, I got it.
> > > happen that the start of frame was launched in other usb states and
> > > cause ohci works abnormally then kernel will allways report rcu
> > > call trace. This patch was to add check for host controller
> > > functional states and if it is not UsbOperational state that need
> > > set INTR_SF in intrdisable register to ensure SOF Token generation
> > > was been disabled.
> > This doesn't make sense.  You already mentioned that only the
> > UsbOperational state supports sending start-of-frame packets.  So if the
> > controller is in a different state then it won't send these packets,
> > whether INTR_SF is enabled or not.
> > 
> > What problem are you really trying to solve?
> 
> Only UsbOperational state supports sending start-of-frame packets, but in
> fact, in S3/S4 press test procedure,
> 
> usb in non-UsbOperational state that send start-of-frame packets but hc
> driver doesn't deal with this frame. and hc will
> 
> allways lauched the SOF for finishing the frame, the cpu will hand this sof
> interrupt and doesn't deal with time interrupt
> 
> that will cause rcu call trace then system doesn't suspend to memory/disk.

I still don't understand.

Are you saying that your OHCI controller behaves badly because it sends 
SOF packets even when the state is different from UsbOperational?

> Hi Alan Stern,
> 
>     even though ed_rm_list is non-NULL, if hc in non-UsbOperation state set
> SoF status in usbsts register that is illegal,
> 
> at this time hcd doesn't need care URB whether finished,  because hc had
> into a wrong state. even thoug it doesn't has this patch,
> 
> URB was not be able to finish when hc in above worng state. except software
> can intervence this wrong state. but the SoF bit of usbsts
> 
> register was set by HC, and this action will happen always !!! software
> clear SoF state I think it isn't make sense. software only disable SoF
> 
> interrupt to fix HC wrong state.

This problem happens when you go into S3 or S4 suspend, right?  So you 
should fix the problem by disabling INTR_SF when the root hub is 
suspended.  Try adding

	/* All ED unlinks should be finished, no need for SOF interrupts */
	ohci_writel(ohci, OHCI_INTR_SF, &ohci->regs->intrdisable);

into ohci_rh_suspend(), just before the update_done_list() call.  If you 
add this then INTR_SF will not be enabled during S3 or S4 suspend, so 
the problem shouldn't occur.  Does that work for you?

>       In additon, when kernel include my patch, that it does't happen about
> what you descriped that driver will not be able to finish unlinging URBs.
> 
> Because above issue happen in S3/S4(Suspend to disk/Suspend to mem) test
> procedure, if ed_rm_lis is no-NULL but my patch disable SoF interrupt.
> 
> then when S3/S4 recovery to cpu idle state that usb resume will be called,
> reume function has following logic, URB will continue to be processed.
> 
>       static int ohci_rh_resume (struct ohci_hcd *ohci)
> 
>      {
> 
>         ...
> 
>         242         if (ohci->ed_rm_list)
>         243                 ohci_writel (ohci, OHCI_INTR_SF,
> &ohci->regs->intrenable);
> 
>        ...
> 
>       }

I'm worried that your patch may disable INTR_SF even when the controller 
has not gone into S3 or S4 suspend.  Maybe this won't cause problems, 
but it's better to be safe and do the disable _only_ when a suspend 
occurs.

Alan Stern
