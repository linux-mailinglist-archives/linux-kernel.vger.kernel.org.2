Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B396A3159FE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 00:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234744AbhBIXXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 18:23:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:33170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233798AbhBITyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 14:54:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7FFF764E7C;
        Tue,  9 Feb 2021 19:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612900345;
        bh=dbd5zXuf2tAOK3nMwJXXBkMx5zGP7piyCLS8ORXFt2o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DzkpWRpLdUkjK9cWF6rjSftsMfVhYEcr3Z2NG5pGjFCANHBvgrZkYRVlZ1mggMoIF
         ntZvNZWKLzJbYUOHOExhowcDA80gQgzub5t/r90r5oP2f+FAkToGkJFIXfyNKlUPfW
         t429lzoDtxYkSnPLrSXdKPBZ3urvac0Xxnbx9Edk=
Date:   Tue, 9 Feb 2021 20:52:22 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     ameynarkhede03@gmail.com
Cc:     dan.carpenter@oracle.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: gdm724x: Fix DMA from stack
Message-ID: <YCLn9j60wD2/RG9K@kroah.com>
References: <20210209193147.558514-1-ameynarkhede03@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209193147.558514-1-ameynarkhede03@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 01:01:47AM +0530, ameynarkhede03@gmail.com wrote:
> From: Amey Narkhede <ameynarkhede03@gmail.com>
> 
> Stack allocated buffers cannot be used for DMA
> on all architectures so allocate hci_packet buffer
> using kzalloc().
> 
> Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> ---
>  drivers/staging/gdm724x/gdm_usb.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/gdm724x/gdm_usb.c b/drivers/staging/gdm724x/gdm_usb.c
> index dc4da66c3..c4a9b90c5 100644
> --- a/drivers/staging/gdm724x/gdm_usb.c
> +++ b/drivers/staging/gdm724x/gdm_usb.c
> @@ -56,11 +56,15 @@ static int gdm_usb_recv(void *priv_dev,
> 
>  static int request_mac_address(struct lte_udev *udev)
>  {
> -	u8 buf[16] = {0,};
> -	struct hci_packet *hci = (struct hci_packet *)buf;
> +	u8 *buf;
> +	struct hci_packet *hci;
>  	struct usb_device *usbdev = udev->usbdev;
>  	int actual;
>  	int ret = -1;
> +	buf = kzalloc(16, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +	hci = (struct hci_packet *)buf;
> 
>  	hci->cmd_evt = gdm_cpu_to_dev16(udev->gdm_ed, LTE_GET_INFORMATION);
>  	hci->len = gdm_cpu_to_dev16(udev->gdm_ed, 1);
> @@ -70,6 +74,7 @@ static int request_mac_address(struct lte_udev *udev)
>  			   &actual, 1000);
> 
>  	udev->request_mac_addr = 1;
> +	kfree(buf);
> 
>  	return ret;
>  }
> --
> 2.30.0
> _______________________________________________
> devel mailing list
> devel@linuxdriverproject.org
> http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch contains warnings and/or errors noticed by the
  scripts/checkpatch.pl tool.

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
