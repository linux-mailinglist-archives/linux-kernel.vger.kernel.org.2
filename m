Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCFD394054
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 11:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235999AbhE1JxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 05:53:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:39392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234926AbhE1JxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 05:53:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5E60C61002;
        Fri, 28 May 2021 09:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622195493;
        bh=XaB5AX18bByRqGZPzJ3+XBe9og2SQnswnlcy2VrCxyg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vM+/XWC7Q28YeFLh/B34kE4JKA0ZKuGxd7IKx1NpG0RPTweuUV4BGKriJj/jwVoPr
         XWpzgEW9ZTIWqf11xl0blqewjKVVjINazbZPGVSAW4oGKrD/yvYBJaA53+1TNPHE7F
         W55B3f6AXWmFFquKXg3eLnX+Xhbq+M3l07rba0EM=
Date:   Fri, 28 May 2021 11:51:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Phil Elwell <phil@raspberrypi.com>
Cc:     Minas Harutyunyan <hminas@synopsys.com>,
        Sasha Levin <sashal@kernel.org>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: dwc2: Fix build in periphal-only mode
Message-ID: <YLC9I6vKh9z7LTke@kroah.com>
References: <20210528091349.2602410-1-phil@raspberrypi.com>
 <YLC2iPPEOCJuElIR@kroah.com>
 <e2595559-d14f-973d-732c-2c91be57cc4b@raspberrypi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2595559-d14f-973d-732c-2c91be57cc4b@raspberrypi.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2021 at 10:37:48AM +0100, Phil Elwell wrote:
> Hi Greg,
> 
> On 28/05/2021 10:23, Greg Kroah-Hartman wrote:
> > On Fri, May 28, 2021 at 10:13:50AM +0100, Phil Elwell wrote:
> > > The bus_suspended member of struct dwc2_hsotg is only present in builds
> > > that support host-mode.
> > > 
> > > Fixes: 24d209dba5a3 ("usb: dwc2: Fix hibernation between host and device modes.")
> > > Signed-off-by: Phil Elwell <phil@raspberrypi.com>
> > > ---
> > >   drivers/usb/dwc2/core_intr.c | 4 ++++
> > >   1 file changed, 4 insertions(+)
> > > 
> > > v2: Correct commit hash used in the Fixes line.
> > > 
> > > diff --git a/drivers/usb/dwc2/core_intr.c b/drivers/usb/dwc2/core_intr.c
> > > index a5ab03808da6..03d0c034cf57 100644
> > > --- a/drivers/usb/dwc2/core_intr.c
> > > +++ b/drivers/usb/dwc2/core_intr.c
> > > @@ -725,7 +725,11 @@ static inline void dwc_handle_gpwrdn_disc_det(struct dwc2_hsotg *hsotg,
> > >   	dwc2_writel(hsotg, gpwrdn_tmp, GPWRDN);
> > >   	hsotg->hibernated = 0;
> > > +
> > > +#if IS_ENABLED(CONFIG_USB_DWC2_HOST) ||	\
> > > +	IS_ENABLED(CONFIG_USB_DWC2_DUAL_ROLE)
> > >   	hsotg->bus_suspended = 0;
> > > +#endif
> > >   	if (gpwrdn & GPWRDN_IDSTS) {
> > >   		hsotg->op_state = OTG_STATE_B_PERIPHERAL;
> > > -- 
> > > 2.25.1
> > > 
> > 
> > I do not understand, the field in the structure is present for all, why
> > is this crazy #if needed here?
> > 
> > I see that the commit you reference here did add the new line to set
> > bus_suspended, which seemed to be the point here.  Why will the #if
> > values matter here?
> 
> Sorry to waste your brain cycles on this. There is a problem, but it only
> exists in branches where the blamed commit (24d209dba5a3) has been
> back-ported as a Fix, because it depends on commit 012466fc8ccc which isn't
> a Fix and therefore
> hasn't been back-ported. Sadly 012466fc8ccc doesn't back-port cleanly on its
> own - either more cherry-picks or a temporary patch like mine will be
> needed.

So should we revert this commit from the stable releases where it showed
up?  Which ones specifically?

If so, please let me and stable@vger.kernel.org know and we can take
care of it there.

thanks,

greg k-h
