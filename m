Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE114452DE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 13:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbhKDMVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 08:21:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:42912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229843AbhKDMVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 08:21:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E404161183;
        Thu,  4 Nov 2021 12:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636028334;
        bh=M9dSFx/TFuKBKZ2iXdYlhQhCXq3MndO0MeNawTEsIko=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k8ShUtu0Mth/UJOpWwPS+5mRkdfTtZLhZ1S9rNiaC8fUqmXOyB2smFXtf7SCbzcaw
         NUKBo4vFTcv/l8hMUQQh7IIgl38KiZVALdXQOaaRLFbflqOqTB+YGkcEEZNcwrQrtL
         crWDMwqwu+11N+iQ6V35KuxpTECFUJ7Hwy/B8ix6SEeRO6017IMZixxLJ9d5ybLhdM
         IYwmKHaiGeeBsx+qACN5U2N0nhHp3r9DSssLuGXXptOky/vrQd7vqG5EQDyofNxDxt
         G4oQ/LTlcwYO2Y204+4APW5F16fwJdMjXFNYNLgI4T+fWPNEsSBBVz22SMRpTmoD9u
         zZ9Pa90pFJA8g==
Date:   Thu, 4 Nov 2021 20:18:01 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     =?utf-8?B?6IOh5ZCv6IiqKE5pY2sgSHUp?= <huqihang@oppo.com>
Cc:     "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: gadget: composite: Fix null pointer exception
Message-ID: <20211104121801.GA4386@Peter>
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

On 21-11-02 03:59:16, 胡启航(Nick Hu) wrote:
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
> 
> diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
> index 72a9797dbbae..4f0d81f561ae 100644
> --- a/drivers/usb/gadget/composite.c
> +++ b/drivers/usb/gadget/composite.c
> @@ -151,9 +151,11 @@ int config_ep_by_speed_and_alt(struct usb_gadget *g,
>  				struct usb_ep *_ep,
>  				u8 alt)
>  {
> +	struct usb_composite_dev *cdev;

For newly added variable definition, you could add it at the last existing
variable definition, see position "..." below.

>  	struct usb_endpoint_descriptor *chosen_desc = NULL;
>  	struct usb_interface_descriptor *int_desc = NULL;
>  	struct usb_descriptor_header **speed_desc = NULL;
...
> +	int incomplete_desc = 0;
>  
>  	struct usb_ss_ep_comp_descriptor *comp_desc = NULL;
>  	int want_comp_desc = 0;
> @@ -167,28 +169,43 @@ int config_ep_by_speed_and_alt(struct usb_gadget *g,
>  	switch (g->speed) {
>  	case USB_SPEED_SUPER_PLUS:
>  		if (gadget_is_superspeed_plus(g)) {
> -			speed_desc = f->ssp_descriptors;
> -			want_comp_desc = 1;
> -			break;
> +			if (f->ssp_descriptors) {
> +				speed_desc = f->ssp_descriptors;
> +				want_comp_desc = 1;
> +				break;
> +			}
> +			incomplete_desc = 1;
>  		}
>  		fallthrough;
>  	case USB_SPEED_SUPER:
>  		if (gadget_is_superspeed(g)) {
> -			speed_desc = f->ss_descriptors;
> -			want_comp_desc = 1;
> -			break;
> +			if (f->ss_descriptors) {
> +				speed_desc = f->ss_descriptors;
> +				want_comp_desc = 1;
> +				break;
> +			}
> +			incomplete_desc = 1;
>  		}
>  		fallthrough;
>  	case USB_SPEED_HIGH:
>  		if (gadget_is_dualspeed(g)) {
> -			speed_desc = f->hs_descriptors;
> -			break;
> +			if (f->hs_descriptors) {
> +				speed_desc = f->hs_descriptors;
> +				break;
> +			}
> +			incomplete_desc = 1;
>  		}
>  		fallthrough;
>  	default:
>  		speed_desc = f->fs_descriptors;
>  	}
>  
> +	cdev = get_gadget_data(g);
> +	if (incomplete_desc != 0)
> +		WARNING(cdev,
> +			"%s function doesn't hold all the descriptors for supported speep\n",

"%s doesn't hold the descriptors for current speed"

> +			f->name);
> +
>  	/* find correct alternate setting descriptor */
>  	for_each_desc(speed_desc, d_spd, USB_DT_INTERFACE) {
>  		int_desc = (struct usb_interface_descriptor *)*d_spd;
> @@ -244,12 +261,8 @@ int config_ep_by_speed_and_alt(struct usb_gadget *g,
>  			_ep->maxburst = comp_desc->bMaxBurst + 1;
>  			break;
>  		default:
> -			if (comp_desc->bMaxBurst != 0) {
> -				struct usb_composite_dev *cdev;
> -
> -				cdev = get_gadget_data(g);
> +			if (comp_desc->bMaxBurst != 0)
>  				ERROR(cdev, "ep0 bMaxBurst must be 0\n");
> -			}
>  			_ep->maxburst = 1;
>  			break;
>  		}
> -- 
> 2.25.1
> 
> 
> Thanks for your suggestion, this is my revised patch.
> Of course, I will continue to fix android f_audio_source.c to solve the problem fundamentally.
> 
> Thanks

Other things are ok for me. You could send v2 version after addressing my comments.

-- 

Thanks,
Peter Chen

