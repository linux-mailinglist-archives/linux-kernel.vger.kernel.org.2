Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06B183EB278
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 10:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239817AbhHMISR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 04:18:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:52154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239805AbhHMISQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 04:18:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7B33460FC3;
        Fri, 13 Aug 2021 08:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628842670;
        bh=NRuGJFIVb0gRcxgVN5cRG5v5o7NpkC9m78LebAd0vnI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xvOARDDRrMfRGSOrCde5K0qyQOpUl16xE0EqkK47jMffgTlJ2xzbcdjLp4PCHPPe3
         JzKGDpEjQ/RafuU4bDYm42FxIf0DeESj7LDgjSYsJyfc/rljkb7VkySJMLNyW9zolr
         YTEJTKGkCfWOIFUWPsdA32Vy0LqN7XGGKJz1UfcM=
Date:   Fri, 13 Aug 2021 10:17:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bing Fan <hptsfb@gmail.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] arm pl011 serial: support multi-irq request
Message-ID: <YRYqq5Cgqy3975e1@kroah.com>
References: <1628825490-18937-1-git-send-email-hptsfb@gmail.com>
 <YRYc9nCcpGOs4SaJ@kroah.com>
 <9c3a4336-b6c4-d96e-9a9d-8001dddcee20@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9c3a4336-b6c4-d96e-9a9d-8001dddcee20@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2021 at 03:56:01PM +0800, Bing Fan wrote:
> 
> 在 8/13/2021 15:19, Greg KH 写道:
> > On Fri, Aug 13, 2021 at 11:31:30AM +0800, Bing Fan wrote:
> > > From: Bing Fan <tombinfan@tencent.com>
> > > 
> > > In order to make pl011 work better, multiple interrupts are
> > > required, such as TXIM, RXIM, RTIM, error interrupt(FE/PE/BE/OE);
> > > at the same time, pl011 to GIC does not merge the interrupt
> > > lines(each serial-interrupt corresponding to different GIC hardware
> > > interrupt), so need to enable and request multiple gic interrupt
> > > numbers in the driver.
> > > 
> > > Signed-off-by: Bing Fan <tombinfan@tencent.com>
> > > ---
> > >   drivers/tty/serial/amba-pl011.c | 39 +++++++++++++++++++++++++++++++--
> > >   1 file changed, 37 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> > > index e14f3378b8a0..eaac3431459c 100644
> > > --- a/drivers/tty/serial/amba-pl011.c
> > > +++ b/drivers/tty/serial/amba-pl011.c
> > > @@ -1701,6 +1701,41 @@ static void pl011_write_lcr_h(struct uart_amba_port *uap, unsigned int lcr_h)
> > >   	}
> > >   }
> > > +static void pl011_release_multi_irqs(struct uart_amba_port *uap, unsigned int max_cnt)
> > > +{
> > > +	struct amba_device *amba_dev = container_of(uap->port.dev, struct amba_device, dev);
> > > +	int i;
> > > +
> > > +	for (i = 0; i < max_cnt; i++)
> > > +		if (amba_dev->irq[i])
> > > +			free_irq(amba_dev->irq[i], uap);
> > > +}
> > > +
> > > +static int pl011_allocate_multi_irqs(struct uart_amba_port *uap)
> > > +{
> > > +	int ret = 0;
> > > +	int i;
> > > +	unsigned int virq;
> > > +	struct amba_device *amba_dev = container_of(uap->port.dev, struct amba_device, dev);
> > > +
> > > +	pl011_write(uap->im, uap, REG_IMSC);
> > > +
> > > +	for (i = 0; i < AMBA_NR_IRQS; i++) {
> > > +		virq = amba_dev->irq[i];
> > > +		if (virq == 0)
> > > +			break;
> > > +
> > > +		ret = request_irq(virq, pl011_int, IRQF_SHARED, dev_name(&amba_dev->dev), uap);
> > > +		if (ret) {
> > > +			dev_err(uap->port.dev, "request %u interrupt failed\n", virq);
> > > +			pl011_release_multi_irqs(uap, i - 1);
> > > +			break;
> > > +		}
> > > +	}
> > > +
> > > +	return ret;
> > > +}
> > This function looks identical to pl011_allocate_irq(), so what is the
> > difference here?  Why is this still needed at all?  What does it do that
> > is different from pl011_allocate_irq()?
> 
> The v6-patch is based on master of
> git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git, not tty-next.

Always submit patches based on tty-next if you want them accepted into
that tree.

> As below, the pl011_allocate_irq function supports single irq request only,
> which different from pl011_allocate_multi_irqs.
> 
> static int pl011_allocate_irq(struct uart_amba_port *uap)
> {
>     pl011_write(uap->im, uap, REG_IMSC);
> 
>     return request_irq(uap->port.irq, pl011_int, IRQF_SHARED, "uart-pl011",
> uap);
> }

Ok, but that does not reflect what is in my tree to be merged for
5.15-rc1.  What is wrong with the code in there that is incorrect and
needs to be changed?

thanks,

greg k-h
