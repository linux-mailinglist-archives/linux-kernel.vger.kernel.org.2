Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED8A8315569
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 18:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbhBIRvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 12:51:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:60042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233365AbhBIRmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 12:42:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CA35864EC2;
        Tue,  9 Feb 2021 17:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612892447;
        bh=3FqKB+k3RfOfv2X1i7iR67+j0FQVQ8+RruM8LxXLsvw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I5AP7v2VNsVgS/qju4gDvVBnYtI9mQXeTQanUHIEvN1JD8Z6OCEDer4t3+NYktWia
         qtnhM2eX8k7TpH+I67PHgI2LajOWhc/6pVFNlF8LIVslIlts8/OEbLZKRn+0lfxIVX
         yPGHtMQNeLxJ0m493QUx4/0sNXij4z+e9ME1AgOk=
Date:   Tue, 9 Feb 2021 18:40:44 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     ameynarkhede03@gmail.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: gdm724x: Fix DMA from stack
Message-ID: <YCLJHNvKhiMJmTP8@kroah.com>
References: <20210209145415.29609-1-ameynarkhede03@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209145415.29609-1-ameynarkhede03@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 08:24:15PM +0530, ameynarkhede03@gmail.com wrote:
> From: Amey Narkhede <ameynarkhede03@gmail.com>
> 
> Stack allocated buffers cannot be used for DMA
> on all architectures so allocate usbdev buffer
> using kmalloc().
> 
> Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> ---
>  drivers/staging/gdm724x/gdm_usb.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/gdm724x/gdm_usb.c b/drivers/staging/gdm724x/gdm_usb.c
> index dc4da66c3..50dc463d4 100644
> --- a/drivers/staging/gdm724x/gdm_usb.c
> +++ b/drivers/staging/gdm724x/gdm_usb.c
> @@ -56,7 +56,7 @@ static int gdm_usb_recv(void *priv_dev,
> 
>  static int request_mac_address(struct lte_udev *udev)
>  {
> -	u8 buf[16] = {0,};
> +	u8 *buf;
>  	struct hci_packet *hci = (struct hci_packet *)buf;
>  	struct usb_device *usbdev = udev->usbdev;
>  	int actual;
> @@ -66,6 +66,10 @@ static int request_mac_address(struct lte_udev *udev)
>  	hci->len = gdm_cpu_to_dev16(udev->gdm_ed, 1);
>  	hci->data[0] = MAC_ADDRESS;
> 
> +	buf = kmalloc(16, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +

This is great, but you just added a build warning, which implies that
the patch is incorrect.

You also have a memory leak here, which is not acceptable :(

thanks,

greg k-h
