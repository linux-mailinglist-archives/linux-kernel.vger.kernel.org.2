Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFCF316986
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 15:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhBJO43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 09:56:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:42384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230263AbhBJO41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 09:56:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C4A564EB4;
        Wed, 10 Feb 2021 14:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612968945;
        bh=D+I1p8kFl9V98gx/oh6Plr3WzbCSyGVrh7RCkNdJOSg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XN7u1YG3A+jYzRa8amvNC76Jaip3/lWern/bfYTAxCtfTL8zrgyCGD+ZjZ2qqUSsK
         VtME7XUg6AyN+2+7wNyyBmNhz04JgD2RNoFprlfLWch3e9K69TdbmMjzb9cxdTyRnK
         L6VnEb5VgOyEjwqTBRb4h3x4soE2UCRT7ac3IphU=
Date:   Wed, 10 Feb 2021 15:55:42 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Amey Narkhede <ameynarkhede03@gmail.com>
Cc:     dan.carpenter@oracle.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: gdm724x: Fix DMA from stack
Message-ID: <YCPz7jy6BLRzmvU3@kroah.com>
References: <20210210142512.23152-1-ameynarkhede03@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210142512.23152-1-ameynarkhede03@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 07:55:12PM +0530, Amey Narkhede wrote:
> Stack allocated buffers cannot be used for DMA
> on all architectures so allocate hci_packet buffer
> using kmalloc.
> 
> Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> ---
> Changes in v3:
> 	- Remove superfluous buf pointer
> 	- Reduce size of allocation of hci_packet to match number of
> 	bytes used for DMA
> 
>  drivers/staging/gdm724x/gdm_usb.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/gdm724x/gdm_usb.c b/drivers/staging/gdm724x/gdm_usb.c
> index dc4da66c3..80c58a3ef 100644
> --- a/drivers/staging/gdm724x/gdm_usb.c
> +++ b/drivers/staging/gdm724x/gdm_usb.c
> @@ -56,20 +56,24 @@ static int gdm_usb_recv(void *priv_dev,
> 
>  static int request_mac_address(struct lte_udev *udev)
>  {
> -	u8 buf[16] = {0,};
> -	struct hci_packet *hci = (struct hci_packet *)buf;
> +	struct hci_packet *hci;
>  	struct usb_device *usbdev = udev->usbdev;
>  	int actual;
>  	int ret = -1;
> 
> +	hci = kmalloc(5, GFP_KERNEL);

Why "5" and not:
	hci = kmalloc(sizeof(*hci), GFP_KERNEL);
?

thanks,

greg k-h
