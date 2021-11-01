Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19409441B9A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 14:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbhKANVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 09:21:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:49596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230417AbhKANVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 09:21:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3859F60EE9;
        Mon,  1 Nov 2021 13:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635772739;
        bh=MRJJ65sLMFNXIIujuO4NjvdCus/lqQZG52E50gJmYb0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aV8RQBnIfNfBNgcXm+Px0Zvm5oHOsdzOa/rnXgLGFy+Iu5DJiookNA8ViwikTF6Ob
         a4x+IsWTrEtGn8JiBuFm6VydrIAuPDA3u88mTK4zGVwIdjKJdAp4ov/I9HgBAuuK6x
         neNS9EVyUubFDvBV42fOGBoir4XrMMIOs/SZnd3ZTlLV8Z6YjjOGxR2De4s4ZYsGkU
         /wqlCF/zo7LbPFHkN5qb/lITlk0B0JC5m7mVJIjlEKQlbuxPRol054QCgKrhMGFDVJ
         gerwtkFGgt+qy05JJM1JMRkLgSjWmgyK/KUYOXl2ugRilhxI0xX1uf+u0GLM2S51pl
         3eW/eDmN+bhSg==
Date:   Mon, 1 Nov 2021 21:18:49 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Qihang Hu <huqihang@oppo.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: composite: Fix null pointer exception
Message-ID: <20211101131849.GA4126@Peter>
References: <20211101015757.290350-1-huqihang@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211101015757.290350-1-huqihang@oppo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-11-01 09:57:57, Qihang Hu wrote:
> In the config_ep_by_speed_and_alt function, select the corresponding
> descriptor through g->speed, but the interface driver

function driver

> may not
> support the corresponding speed. So, we need to check whether the
> interface driver provides the corresponding speed descriptor when
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
>  drivers/usb/gadget/composite.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
> index 72a9797dbbae..443a65af98af 100644
> --- a/drivers/usb/gadget/composite.c
> +++ b/drivers/usb/gadget/composite.c
> @@ -166,21 +166,21 @@ int config_ep_by_speed_and_alt(struct usb_gadget *g,
>  	/* select desired speed */
>  	switch (g->speed) {
>  	case USB_SPEED_SUPER_PLUS:
> -		if (gadget_is_superspeed_plus(g)) {
> +		if (gadget_is_superspeed_plus(g) && f->ssp_descriptors) {
>  			speed_desc = f->ssp_descriptors;
>  			want_comp_desc = 1;
>  			break;
>  		}
>  		fallthrough;
>  	case USB_SPEED_SUPER:
> -		if (gadget_is_superspeed(g)) {
> +		if (gadget_is_superspeed(g) && f->ss_descriptors) {
>  			speed_desc = f->ss_descriptors;
>  			want_comp_desc = 1;
>  			break;
>  		}
>  		fallthrough;
>  	case USB_SPEED_HIGH:
> -		if (gadget_is_dualspeed(g)) {
> +		if (gadget_is_dualspeed(g) && f->hs_descriptors) {
>  			speed_desc = f->hs_descriptors;
>  			break;
>  		}
> -- 
> 2.25.1
> 

Besides your fix, you may show an warning that said "the function
doesn't hold the descriptors for supported speed, using the default (FS)
descriptors". See below kernel doc for detail.

/**
 * config_ep_by_speed_and_alt() - configures the given endpoint
 *
 * ....
 * Note: the supplied function should hold all the descriptors
 * for supported speeds
 */

What's more, you may fix android f_audio_source.c, and let it support
super speed and super speed plus.

-- 

Thanks,
Peter Chen

