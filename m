Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6AB342A769
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 16:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237361AbhJLOke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 10:40:34 -0400
Received: from netrider.rowland.org ([192.131.102.5]:56923 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S237347AbhJLOkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 10:40:32 -0400
Received: (qmail 857016 invoked by uid 1000); 12 Oct 2021 10:38:30 -0400
Date:   Tue, 12 Oct 2021 10:38:30 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     zhuyinbo <zhuyinbo@loongson.cn>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <greg@kroah.com>,
        Patchwork Bot <patchwork-bot@kernel.org>
Subject: Re: [PATCH v5] usb: ohci: disable start-of-frame interrupt in
 ohci_rh_suspend
Message-ID: <20211012143830.GA855318@rowland.harvard.edu>
References: <1634027450-3358-1-git-send-email-zhuyinbo@loongson.cn>
 <c26e86a7-a24d-42f5-3d39-71c34f8c5e31@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c26e86a7-a24d-42f5-3d39-71c34f8c5e31@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 08:11:45PM +0800, zhuyinbo wrote:
> 
> 在 2021/10/12 下午4:30, Yinbo Zhu 写道:
> > The usb states of ohci controller include UsbOperational, UsbReset,
> > UsbSuspend and UsbResume. Among them, only the UsbOperational state
> > supports launching the start-of-frame for host controller according
> > the ohci protocol spec, but in S3 and S4 (suspend to memory/suspend
> > to disk) press test procedure, it may happen that the start-of-
> > frame was launched in UsbSuspend status and cause ohci works failed
> > that the phenomenon was hc will allways reproduce the SoF interrupt
> > and consider that hc doesn't deal with the ed/td/done list in non-
> > UsbOperational, and this patch was to disable SoF interrupt in ohci
> > _rh_suspend so that it can fix ohci SoF abnormally interrupt issue.
> > 
> > Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> > ---
> > Change in v5:
> > 		Move the key code change into ohci_rh_suspend.
> > 		Rework the commit log information.
> > 
> > 
> >   drivers/usb/host/ohci-hub.c | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/usb/host/ohci-hub.c b/drivers/usb/host/ohci-hub.c
> > index f474f2f..80a0094 100644
> > --- a/drivers/usb/host/ohci-hub.c
> > +++ b/drivers/usb/host/ohci-hub.c
> > @@ -88,6 +88,8 @@ static int ohci_rh_suspend (struct ohci_hcd *ohci, int autostop)
> >   		msleep (8);
> >   		spin_lock_irq (&ohci->lock);
> >   	}
> > +	/* All ED unlinks should be finished, no need for SOF interrupts */
> > +	ohci_writel(ohci, OHCI_INTR_SF, &ohci->regs->intrdisable);
> >   	update_done_list(ohci);
> >   	ohci_work(ohci);
> 
> Hi Alan Stern,
> 
>     I consider that autostop sometimes was '1' then and HC doesn't  stop
> deal with the ed/td/done list , then ohci_wok will called start_ed_unlink
> and
> 
>     start_ed_unlink will enable INTR_SF as follows, so I think add above two
> line code after ohci_work it is more appropriate, Do you think so?
> 
>       static void start_ed_unlink (struct ohci_hcd *ohci, struct ed *ed)
>        {
> 
>              ...
> 
>              494         /* enable SOF interrupt */
>              495         ohci_writel (ohci, OHCI_INTR_SF,
> &ohci->regs->intrstatus);
>              496         ohci_writel (ohci, OHCI_INTR_SF,
> &ohci->regs->intrenable);
> 
>               ...
> 
>         }

Yes, that's a good point.  Go ahead and make this change.  And be sure 
to put a blank line before the new comment line.

I also think the patch description should be rewritten.  It talks
about things that are not relevant to the patch.  For example, you
don't _know_ that your host controller is sending SOF packets in the
non-UsbOperational state; you only know that it is generating
interrupts with the INTR_SF flag set.

So you should change the description to something like this:


While going into S3 or S4 suspend, an OHCI host controller can
generate interrupt requests if the INTR_SF enable flag is set.  The
interrupt handler routine isn't prepared for this and it doesn't turn
off the flag, causing an interrupt storm.

To fix this problem, make ohci_rh_suspend() always disable INTR_SF
interrupts after processing the done list and the ED unlinks but
before the controller goes into the suspended (non-UsbOperational)
state.  There's no reason to leave the flag enabled, since a suspended
controller doesn't generate Start-of-Frame packets.


Alan Stern
