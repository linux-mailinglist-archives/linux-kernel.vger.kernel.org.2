Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B965B35DC76
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 12:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245120AbhDMK0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 06:26:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:44372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230088AbhDMK0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 06:26:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DAB08613BC;
        Tue, 13 Apr 2021 10:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618309574;
        bh=eEvo19Vw5I5M464tlOBT1pZyU/kCLCVp40Q85+C3i3U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jJO+ZfUtXwYQgnUibEaGqWMTQzuiEDzZDpG2TAs0WLm7O9mgP94RXjnrm/lnxXJMU
         viKXDaOMlWFKmyCSPYCl/Cttk6sLFKJbAsJenCag7MQxONIftmwSIKznBk6NoyUM4V
         sJDl0wXhFSDi/JF14ix3Qt6+TpLXdlWvwPKObmj4=
Date:   Tue, 13 Apr 2021 12:26:11 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        John Youn <John.Youn@synopsys.com>
Subject: Re: [PATCH v2 00/12] usb: dwc2: Add clock gating support.
Message-ID: <YHVxw26V2SPzpoQy@kroah.com>
References: <cover.1618297800.git.Arthur.Petrosyan@synopsys.com>
 <20210413073600.57846A0094@mailhost.synopsys.com>
 <9b21e84b-817d-df04-1eb1-78c7ca1c931e@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b21e84b-817d-df04-1eb1-78c7ca1c931e@synopsys.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 08:03:23AM +0000, Artur Petrosyan wrote:
> Hi Greg,
> 
> On 4/13/2021 11:35, Artur Petrosyan wrote:
> > This patch set adds clock gating power saving support for
> > dwc2 core.
> > It adds support for the following cases described by programming guide.
> >    1. Enter to clock gating from USB_SUSPEND interrupt.
> >    2. Clock gating entering flow by system suspend.
> >    3. Clock gating exiting flow by system resume.
> >    4. Exit clock gating from wakeup interrupt.
> >    5. Exit clock gating from session request interrupt.
> >    6. Exit clock gating when port reset is asserted.
> > 
> > Additional cases to exit form clock gating were needed which are not
> > described in clock gating programming guide.
> >    1. Added clock gating exit flow before removing driver
> >    2. Exit clock gating in urb enqueue.
> > 
> > It updates the implementation of dwc2 entering and exiting clock
> > gating when a port is suspended or resumed.
> > 
> > The patch set also adds the implementation of function handlers
> > for entering and exiting host or device clock gating.
> > 
> > NOTE: This is the third patch set in the power saving mode fixes
> > series.
> > This patch set is part of multiple series and is continuation
> > of the "usb: dwc2: Fix and improve power saving modes" patch set.
> > (Patch set link: https://marc.info/?l=linux-usb&m=160379622403975&w=2).
> > The patches that were included in the "usb: dwc2:
> > Fix and improve power saving modes" which was submitted
> > earlier was too large and needed to be split up into
> > smaller patch sets.
> > 
> > Changes since V1:
> > Re sending the patch set as v1 because vger.kernel.org rejected
> > the cover letter. With error code "550 5.7.1 Content-Policy"
> > No changes in the patches or the source code.
> > 
> > 
> > Artur Petrosyan (12):
> >    usb: dwc2: Add device clock gating support functions
> >    usb: dwc2: Add host clock gating support functions
> >    usb: dwc2: Allow entering clock gating from USB_SUSPEND interrupt
> >    usb: dwc2: Add exit clock gating from wakeup interrupt
> >    usb: dwc2: Add exit clock gating from session request interrupt
> >    usb: dwc2: Add exit clock gating when port reset is asserted
> >    usb: dwc2: Update enter clock gating when port is suspended
> >    usb: dwc2: Update exit clock gating when port is resumed
> >    usb: dwc2: Allow exit clock gating in urb enqueue
> >    usb: dwc2: Add clock gating entering flow by system suspend
> >    usb: dwc2: Add clock gating exiting flow by system resume
> >    usb: dwc2: Add exit clock gating before removing driver
> > 
> >   drivers/usb/dwc2/core.h      |  15 ++-
> >   drivers/usb/dwc2/core_intr.c |  62 ++++++++----
> >   drivers/usb/dwc2/gadget.c    |  71 ++++++++++++++
> >   drivers/usb/dwc2/hcd.c       | 177 +++++++++++++++++++++++++++--------
> >   drivers/usb/dwc2/platform.c  |   9 ++
> >   5 files changed, 272 insertions(+), 62 deletions(-)
> > 
> > 
> > base-commit: 9bc46a12c53d8268392774172742aa9e5dd6953d
> > 
> This cover letter for the clock gating patches is being rejected by 
> "vger.kernel.org". I have tried to send one more time as v2 but again it 
> is rejected.
> The error message is "vger.kernel.org
> Remote Server returned '554 5.7.1 <vger.kernel.org #5.7.1 smtp; 550 
> 5.7.1 Content-Policy accept-into-freezer-1"
> 
> Could you please suggest any solution to this?

No idea, sorry, vger is fickle when it comes to odd rules it has for
things it has to deal with.  Looks like your patches came through just
fine, so all is good.

thanks,

greg k-h
