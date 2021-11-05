Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32D474461C7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 10:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbhKEKBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 06:01:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:49696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230075AbhKEKBa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 06:01:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9BD2761265;
        Fri,  5 Nov 2021 09:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636106331;
        bh=itU9oZT9iw2NSls+sL79AK1kE9CLjWxwYCiODRJjY2c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xXgiba1LIL9eTpZjdJrSbt1Ebg/pto5N+ZR+WBcgGN8BUFi9I5N7jkEvIX2WrkuLK
         hBj6jTXEjmj334dnj/eoLjr7vOH7fHSq79YXNvBzwTWnTgUH5W1ydkaf1uNxLyjs6E
         SknTyJxLYEuvfgtbjiLwv/65/ufb3UPx3Q1INzao=
Date:   Fri, 5 Nov 2021 10:58:48 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     =?utf-8?B?6IOh5ZCv6IiqKE5pY2sgSHUp?= <huqihang@oppo.com>
Cc:     Peter Chen <peter.chen@kernel.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: gadget: composite: Fix null pointer exception
Message-ID: <YYUAWD1AbxUIuU30@kroah.com>
References: <20211101015757.290350-1-huqihang@oppo.com>
 <20211101131849.GA4126@Peter>
 <KU1PR02MB25366C0D39F8A21319A36CC5B08B9@KU1PR02MB2536.apcprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <KU1PR02MB25366C0D39F8A21319A36CC5B08B9@KU1PR02MB2536.apcprd02.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2021 at 03:59:16AM +0000, 胡启航(Nick Hu) wrote:
> > -----Original Message-----
> > From: Peter Chen <peter.chen@kernel.org>
> > Sent: Monday, November 1, 2021 9:19 PM
> > To: 胡启航(Nick Hu) <huqihang@oppo.com>
> > Cc: balbi@kernel.org; gregkh@linuxfoundation.org; linux-usb@vger.kernel.org;
> > linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH] usb: gadget: composite: Fix null pointer exception
> > 
> > On 21-11-01 09:57:57, Qihang Hu wrote:
> > > In the config_ep_by_speed_and_alt function, select the corresponding
> > > descriptor through g->speed, but the interface driver
> > 
> > function driver
> > 
> > > may not
> > > support the corresponding speed. So, we need to check whether the
> > > interface driver provides the corresponding speed descriptor when
> > > selecting the descriptor.
> > >
> > > [  237.708146]  android_work: sent uevent USB_STATE=CONNECTED
> > > [  237.712464]  kconfigfs-gadget gadget: super-speed config #1: b
> > > [  237.712487]  kUnable to handle kernel NULL pointer dereference at
> > virtual address 0000000000000000
> > > [  237.712493]  kMem abort info:
> > > [  237.712498]  k  ESR = 0x96000006
> > > [  237.712504]  k  EC = 0x25: DABT (current EL), IL = 32 bits
> > > [  237.712510]  k  SET = 0, FnV = 0
> > > [  237.712515]  k  EA = 0, S1PTW = 0
> > > [  237.712520]  kData abort info:
> > > [  237.712525]  k  ISV = 0, ISS = 0x00000006
> > > [  237.712530]  k  CM = 0, WnR = 0
> > > [  237.712536]  kuser pgtable: 4k pages, 39-bit VAs,
> > pgdp=000000020ef29000
> > > [  237.712541]  k[0000000000000000] pgd=000000020ef2a003,
> > pud=000000020ef2a003, pmd=0000000000000000
> > > [  237.712554]  kInternal error: Oops: 96000006 [#1] PREEMPT SMP
> > > [  237.722067]  kSkip md ftrace buffer dump for: 0x1609e0
> > > [  237.787037]  kWorkqueue: dwc_wq dwc3_bh_work.cfi_jt
> > > [  237.854922]  kpstate: 60c00085 (nZCv daIf +PAN +UAO)
> > > [  237.863165]  kpc : config_ep_by_speed_and_alt+0x90/0x308
> > > [  237.871766]  klr : audio_set_alt+0x54/0x78
> > > [  237.879108]  ksp : ffffffc0104839e0
> > >
> > > Signed-off-by: Qihang Hu <huqihang@oppo.com>
> > > ---
> > >  drivers/usb/gadget/composite.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
> > > index 72a9797dbbae..443a65af98af 100644
> > > --- a/drivers/usb/gadget/composite.c
> > > +++ b/drivers/usb/gadget/composite.c
> > > @@ -166,21 +166,21 @@ int config_ep_by_speed_and_alt(struct usb_gadget
> > *g,
> > >  	/* select desired speed */
> > >  	switch (g->speed) {
> > >  	case USB_SPEED_SUPER_PLUS:
> > > -		if (gadget_is_superspeed_plus(g)) {
> > > +		if (gadget_is_superspeed_plus(g) && f->ssp_descriptors) {
> > >  			speed_desc = f->ssp_descriptors;
> > >  			want_comp_desc = 1;
> > >  			break;
> > >  		}
> > >  		fallthrough;
> > >  	case USB_SPEED_SUPER:
> > > -		if (gadget_is_superspeed(g)) {
> > > +		if (gadget_is_superspeed(g) && f->ss_descriptors) {
> > >  			speed_desc = f->ss_descriptors;
> > >  			want_comp_desc = 1;
> > >  			break;
> > >  		}
> > >  		fallthrough;
> > >  	case USB_SPEED_HIGH:
> > > -		if (gadget_is_dualspeed(g)) {
> > > +		if (gadget_is_dualspeed(g) && f->hs_descriptors) {
> > >  			speed_desc = f->hs_descriptors;
> > >  			break;
> > >  		}
> > > --
> > > 2.25.1
> > >
> > 
> > Besides your fix, you may show an warning that said "the function
> > doesn't hold the descriptors for supported speed, using the default (FS)
> > descriptors". See below kernel doc for detail.
> > 
> > /**
> >  * config_ep_by_speed_and_alt() - configures the given endpoint
> >  *
> >  * ....
> >  * Note: the supplied function should hold all the descriptors
> >  * for supported speeds
> >  */
> > 
> > What's more, you may fix android f_audio_source.c, and let it support
> > super speed and super speed plus.
> > 
> > --
> > 
> > Thanks,
> > Peter Chen
> 
> 
> 
> From 9b8262792b6e85e6060601dbfc651b1e75b649f0 Mon Sep 17 00:00:00 2001
> From: Qihang Hu <huqihang@oppo.com>
> Date: Sat, 30 Oct 2021 16:11:38 +0800
> Subject: [PATCH] usb: gadget: composite: Fix null pointer exception
> 
> In the config_ep_by_speed_and_alt function, select the corresponding
> descriptor through g->speed, but the function driver may not
> support the corresponding speed. So, we need to check whether the
> function driver provides the corresponding speed descriptor when
> selecting the descriptor.
> 
> [  237.708146]  android_work: sent uevent USB_STATE=CONNECTED
> [  237.712464]  kconfigfs-gadget gadget: super-speed config #1: b
> [  237.712487]  kUnable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> [  237.712493]  kMem abort info:
> [  237.712498]  k  ESR = 0x96000006
> [  237.712504]  k  EC = 0x25: DABT (current EL), IL = 32 bits
> [  237.712510]  k  SET = 0, FnV = 0
> [  237.712515]  k  EA = 0, S1PTW = 0
> [  237.712520]  kData abort info:
> [  237.712525]  k  ISV = 0, ISS = 0x00000006
> [  237.712530]  k  CM = 0, WnR = 0
> [  237.712536]  kuser pgtable: 4k pages, 39-bit VAs, pgdp=000000020ef29000
> [  237.712541]  k[0000000000000000] pgd=000000020ef2a003, pud=000000020ef2a003, pmd=0000000000000000
> [  237.712554]  kInternal error: Oops: 96000006 [#1] PREEMPT SMP
> [  237.722067]  kSkip md ftrace buffer dump for: 0x1609e0
> [  237.787037]  kWorkqueue: dwc_wq dwc3_bh_work.cfi_jt
> [  237.854922]  kpstate: 60c00085 (nZCv daIf +PAN +UAO)
> [  237.863165]  kpc : config_ep_by_speed_and_alt+0x90/0x308
> [  237.871766]  klr : audio_set_alt+0x54/0x78
> [  237.879108]  ksp : ffffffc0104839e0
> 
> Signed-off-by: Qihang Hu <huqihang@oppo.com>
> ---
>  drivers/usb/gadget/composite.c | 39 ++++++++++++++++++++++------------
>  1 file changed, 26 insertions(+), 13 deletions(-)

I can not take patches at the end of other email messages.

Please send this properly as a v2 patch, as the documentation asks for.

thanks,

greg k-h
