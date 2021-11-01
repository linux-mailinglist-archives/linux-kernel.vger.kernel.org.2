Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9EF441C37
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 15:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbhKAOIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 10:08:50 -0400
Received: from netrider.rowland.org ([192.131.102.5]:57455 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S229826AbhKAOIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 10:08:48 -0400
Received: (qmail 1457560 invoked by uid 1000); 1 Nov 2021 10:06:13 -0400
Date:   Mon, 1 Nov 2021 10:06:13 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        "Walt Jr. Brake" <mr.yming81@gmail.com>
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nishad Kamdar <nishadkamdar@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: Re: [PATCH v2] usb: core: reduce power-on-good delay time of root hub
Message-ID: <20211101140613.GC1456700@rowland.harvard.edu>
References: <1618017645-12259-1-git-send-email-chunfeng.yun@mediatek.com>
 <5e907ccd-40bb-2ece-fe05-1a65a74f3aa2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5e907ccd-40bb-2ece-fe05-1a65a74f3aa2@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 30, 2021 at 12:49:37PM +0800, Walt Jr. Brake wrote:
> This patch make USB 3.1 device cannot be detected, and I report the bug [1]
> to archlinux three month ago. Yesterday I try to fix it myself, and after I
> revert this patch, compile the kernel and test, it works.
> 
> [1] https://bugs.archlinux.org/task/71660?project=1&pagenum=2
> 
> 
> diff --git a/drivers/usb/core/hub.h b/drivers/usb/core/hub.h
> index 22ea1f4f2d66..73f4482d833a 100644
> --- a/drivers/usb/core/hub.h
> +++ b/drivers/usb/core/hub.h
> @@ -148,10 +148,8 @@ static inline unsigned hub_power_on_good_delay(struct
> usb_hub *hub)
>  {
>         unsigned delay = hub->descriptor->bPwrOn2PwrGood * 2;
> 
> -       if (!hub->hdev->parent) /* root hub */
> -               return delay;
> -       else /* Wait at least 100 msec for power to become stable */
> -               return max(delay, 100U);
> +       /* Wait at least 100 msec for power to become stable */
> +       return max(delay, 100U);
>  }

Mathias:

It looks like the bPwrOn2PwrGood value in xhci-hcd's hub descriptor is 
too small for some USB 3.1 devices.

Can you look into this?

Alan Stern

> On 10/4/2021 09:20, Chunfeng Yun wrote:
> > Return the exactly delay time given by root hub descriptor,
> > this helps to reduce resume time etc.
> > 
> > Due to the root hub descriptor is usually provided by the host
> > controller driver, if there is compatibility for a root hub,
> > we can fix it easily without affect other root hub
> > 
> > Acked-by: Alan Stern<stern@rowland.harvard.edu>
> > Signed-off-by: Chunfeng Yun<chunfeng.yun@mediatek.com>
> > ---
> > v2: remove RFC tag, and add acked-by Alan
> > ---
> >   drivers/usb/core/hub.h | 6 ++++--
> >   1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/usb/core/hub.h b/drivers/usb/core/hub.h
> > index 73f4482d833a..22ea1f4f2d66 100644
> > --- a/drivers/usb/core/hub.h
> > +++ b/drivers/usb/core/hub.h
> > @@ -148,8 +148,10 @@ static inline unsigned hub_power_on_good_delay(struct usb_hub *hub)
> >   {
> >   	unsigned delay = hub->descriptor->bPwrOn2PwrGood * 2;
> > -	/* Wait at least 100 msec for power to become stable */
> > -	return max(delay, 100U);
> > +	if (!hub->hdev->parent)	/* root hub */
> > +		return delay;
> > +	else /* Wait at least 100 msec for power to become stable */
> > +		return max(delay, 100U);
> >   }
> >   static inline int hub_port_debounce_be_connected(struct usb_hub *hub,
