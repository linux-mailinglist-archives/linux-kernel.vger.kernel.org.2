Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0204332E48E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 10:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbhCEJQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 04:16:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:33568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229573AbhCEJQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 04:16:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 16E8864F45;
        Fri,  5 Mar 2021 09:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614935788;
        bh=KEwMRCIZF4N4qvSPoe3DClNVeplmH4EkZWy7fg+Ty8M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a8ksPqQVEmCqAb+LBFF6xySukXRl2l7PWsjWkgGEnQkcfvNoAAJR9DY8Y4erLja8o
         8jJ08I9P195p2aHynAEx+PlPZPgbn8S2g83bYnXGxOWy5vbzteVPvVOc+81YfsrDhY
         H2oeI/ngitJ8V5rEpt95rIJ5rX3lqMNP0MKHXuaI=
Date:   Fri, 5 Mar 2021 10:16:25 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Ikjoon Jang <ikjn@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: Re: [PATCH 03/17] usb: xhci-mtk: get the microframe boundary for ESIT
Message-ID: <YEH26UVlV/yWfk0S@kroah.com>
References: <1614934975-15188-1-git-send-email-chunfeng.yun@mediatek.com>
 <1614934975-15188-3-git-send-email-chunfeng.yun@mediatek.com>
 <cfa6dccb-d784-06fd-e5bc-0b53d105b7f6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfa6dccb-d784-06fd-e5bc-0b53d105b7f6@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2021 at 12:13:33PM +0300, Sergei Shtylyov wrote:
> Hello!
> 
> On 05.03.2021 12:02, Chunfeng Yun wrote:
> 
> > Tune the boundary for FS/LS ESIT due to CS:
> > For ISOC out-ep, the controller starts transfer data after
> > the first SS; for others, the data is already transfered
> 
>    Transferred.
> 
> > before the last CS.
> > 
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > ---
> >   drivers/usb/host/xhci-mtk-sch.c | 24 +++++++++++++++++++-----
> >   1 file changed, 19 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/usb/host/xhci-mtk-sch.c b/drivers/usb/host/xhci-mtk-sch.c
> > index 8950d1f10a7f..e3b18dfca874 100644
> > --- a/drivers/usb/host/xhci-mtk-sch.c
> > +++ b/drivers/usb/host/xhci-mtk-sch.c
> > @@ -513,22 +513,35 @@ static void update_sch_tt(struct usb_device *udev,
> >   		list_del(&sch_ep->tt_endpoint);
> >   }
> > +static u32 get_esit_boundary(struct mu3h_sch_ep_info *sch_ep)
> > +{
> > +	u32 boundary = sch_ep->esit;
> > +
> > +	if (sch_ep->sch_tt) { /* LS/FS with TT */
> > +		/* tune for CS */
> > +		if (sch_ep->ep_type != ISOC_OUT_EP)
> > +			boundary += 1;
> 
>    Why not:
> 
> 			boundary++;
> 
> > +		else if (boundary > 1) /* normally esit >= 8 for FS/LS */
> > +			boundary -= 1;
> 
> 			boundary--;

Doesn't matter either way, it's the author's choice.

greg k-h
