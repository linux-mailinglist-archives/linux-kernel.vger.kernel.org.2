Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D68514461D2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 11:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232960AbhKEKDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 06:03:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:50126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233025AbhKEKDN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 06:03:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 895036128E;
        Fri,  5 Nov 2021 10:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636106434;
        bh=9xqJCHW4+6GKO2Maqx5mkTpR7LQgTIZrxQah13VAIMs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yxnYLAnDk2gTATOymrSa55+AdtgOYT/VlFyCEs6MrTfmzlmZYopR+ch/sCYYaln1u
         nRbkGRBUJlVewUH01DbDxcfIH7z6Yascv+Y5Dg0hecevCALFYnIFJx0y5hs52EEblV
         OaSPuUwE6cEDc3SnAD9BUBFKOW9y0AxM6gzKEGmk=
Date:   Fri, 5 Nov 2021 11:00:31 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     "Walt Jr. Brake" <mr.yming81@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nishad Kamdar <nishadkamdar@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: Re: [PATCH v2] usb: core: reduce power-on-good delay time of root hub
Message-ID: <YYUAv5456iyuxaG6@kroah.com>
References: <1618017645-12259-1-git-send-email-chunfeng.yun@mediatek.com>
 <5e907ccd-40bb-2ece-fe05-1a65a74f3aa2@gmail.com>
 <20211101140613.GC1456700@rowland.harvard.edu>
 <3cf46eaf-5443-30df-6d72-b92a6a518afc@linux.intel.com>
 <62d0ac30-f2b9-f58c-cb1e-215ccb455753@gmail.com>
 <13d55059-9f66-8599-54fc-46698bae41d1@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <13d55059-9f66-8599-54fc-46698bae41d1@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2021 at 10:37:33PM +0200, Mathias Nyman wrote:
> On 2.11.2021 22.29, Walt Jr. Brake wrote:
> > On 2/11/2021 17:05, Mathias Nyman wrote:
> >> On 1.11.2021 16.06, Alan Stern wrote:
> >>> On Sat, Oct 30, 2021 at 12:49:37PM +0800, Walt Jr. Brake wrote:
> >>>> This patch make USB 3.1 device cannot be detected, and I report the bug [1]
> >>>> to archlinux three month ago. Yesterday I try to fix it myself, and after I
> >>>> revert this patch, compile the kernel and test, it works.
> >>>>
> >>>> [1] https://bugs.archlinux.org/task/71660?project=1&pagenum=2
> >>>>
> >>>>
> >>>> diff --git a/drivers/usb/core/hub.h b/drivers/usb/core/hub.h
> >>>> index 22ea1f4f2d66..73f4482d833a 100644
> >>>> --- a/drivers/usb/core/hub.h
> >>>> +++ b/drivers/usb/core/hub.h
> >>>> @@ -148,10 +148,8 @@ static inline unsigned hub_power_on_good_delay(struct
> >>>> usb_hub *hub)
> >>>>   {
> >>>>          unsigned delay = hub->descriptor->bPwrOn2PwrGood * 2;
> >>>>
> >>>> -       if (!hub->hdev->parent) /* root hub */
> >>>> -               return delay;
> >>>> -       else /* Wait at least 100 msec for power to become stable */
> >>>> -               return max(delay, 100U);
> >>>> +       /* Wait at least 100 msec for power to become stable */
> >>>> +       return max(delay, 100U);
> >>>>   }
> >>> Mathias:
> >>>
> >>> It looks like the bPwrOn2PwrGood value in xhci-hcd's hub descriptor is
> >>> too small for some USB 3.1 devices.
> >>>
> >>> Can you look into this?
> >>>
> >>> Alan Stern
> >>>
> >> At first glance the xhci roothub bPwrOn2PwrGood value looks ok.
> >> xhci spec 5.4.8 states software should wait 20ms after asserting PP, before
> >> attempting to change the state of the port.
> >>
> >> xhci driver sets desc->bPwrOn2PwrGood = 10; (2ms interval, so equals 20ms )
> >>
> >> We should probably get this working immediately, so maybe revert that patch
> >> while looking into the rootcause.
> >>
> >> Walt Jr. Brake, instead of reverting that patch, could you test if changing the
> >> xhci roothub bPwrOn2PwrGood value helps.
> >>
> >> diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
> >> index a3f875eea751..756231a55602 100644
> >> --- a/drivers/usb/host/xhci-hub.c
> >> +++ b/drivers/usb/host/xhci-hub.c
> >> @@ -257,7 +257,7 @@ static void xhci_common_hub_descriptor(struct xhci_hcd *xhci,
> >>   {
> >>          u16 temp;
> >>   -       desc->bPwrOn2PwrGood = 10;      /* xhci section 5.4.9 says 20ms max */
> >> +       desc->bPwrOn2PwrGood = 50;      /* The 20ms in xhci 5.4.8 isn't enough for USB 3.1 */
> >>          desc->bHubContrCurrent = 0;
> >>            desc->bNbrPorts = ports;
> >>
> >> Thanks
> >> -Mathias
> > 
> > Mathias:
> > 
> > Sorry to reply lately. I test with your patch, it works.
> > 
> > I also test with setting bPwrOn2PwrGood to 45, and it not work.
> > 
> > Seems that the minimal value should be 50 for this case.
> > 
> 
> Thanks for testing, and for checking that 90ms wait isn't enough

Can you send a "real" patch for this so I can get it into the tree soon
to resolve the regression?

thanks,

greg k-h
