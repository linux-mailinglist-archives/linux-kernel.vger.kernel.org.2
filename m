Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 079A3446397
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 13:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbhKEMrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 08:47:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:57076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233162AbhKEMrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 08:47:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CC5B760F21;
        Fri,  5 Nov 2021 12:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636116278;
        bh=QULd5jTaKPgk0P83tqgiYaMLPitgfw/aqw0mVkDXD4k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=troD8ckkdjN2MqGlbeqVuw+0+Czok8Px8SxZixN4Vg8dvwXRRnySSHJyF/nMFJaF2
         VdziixhtPAOUOHXQFmitF70Uwpww9+z+n8x1I/RjbAnMXjcCQkOAzfQ0V4JTA4fvMk
         WBvVveQFZ4WQwhJIk1LWGKc9hEq1PeXpCn7/v8pw=
Date:   Fri, 5 Nov 2021 13:44:35 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Qihang Hu <huqihang@oppo.com>
Cc:     balbi@kernel.org, peter.chen@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: gadget: composite: Fix null pointer exception
Message-ID: <YYUnM0/82FwS5OUE@kroah.com>
References: <20211105104840.159533-1-huqihang@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211105104840.159533-1-huqihang@oppo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2021 at 06:48:40PM +0800, Qihang Hu wrote:
> In the config_ep_by_speed_and_alt function, select the corresponding
> descriptor through g->speed, but the function driver may not
> support the corresponding speed. So, we need to check whether the
> function driver provides the corresponding speed descriptor when
> selecting the descriptor.
> 
> [  237.708146]  android_work: sent uevent USB_STATE=CONNECTED
> [  237.712464]  kconfigfs-gadget gadget: super-speed config #1: b
> [  237.712487]  kUnable to handle kernel NULL pointer dereference at virtual address 0000000000000000

So this is an invalid driver causing this problem?  Or can this be
triggered by userspace?

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

What commit id does this fix?

> ---
> Changes in v2:
> -Add warning message
> ---
>  drivers/usb/gadget/composite.c | 40 +++++++++++++++++++++++-----------
>  1 file changed, 27 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
> index 72a9797dbbae..746b34cf0310 100644
> --- a/drivers/usb/gadget/composite.c
> +++ b/drivers/usb/gadget/composite.c
> @@ -160,6 +160,9 @@ int config_ep_by_speed_and_alt(struct usb_gadget *g,
>  
>  	struct usb_descriptor_header **d_spd; /* cursor for speed desc */
>  

Why the blank line here?

> +	struct usb_composite_dev *cdev;
> +	int incomplete_desc = 0;

Shouldn't this be a bool?


thanks,

greg k-h
