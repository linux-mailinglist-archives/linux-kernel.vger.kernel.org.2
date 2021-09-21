Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE81B412E7A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 08:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhIUGF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 02:05:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:35318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229619AbhIUGF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 02:05:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ED2C3610A0;
        Tue, 21 Sep 2021 06:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632204270;
        bh=yUn7VbMV/nDfCUZF16+QoogAsnHLlu7+5u4gsnAss+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zTGrMR4CdjPledb803YHybZNrlcL+pYVBGTQk2vKNptWviLW4sxhrVovQ52KNj5VR
         W23+qBGpFrGq3up+ZB+dW8ZV3gTD4PgSG13Npkn0/dQGIdN1yNor3ioghO8nEsX2EK
         VIVqySmldeRmhj9n0UHqSEZx5byitdR8vwyMfYw0=
Date:   Tue, 21 Sep 2021 08:04:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Update min() to min_t()
Message-ID: <YUl1067kvLA5KkGC@kroah.com>
References: <20210921055246.GA11535@matrix-ESPRIMO-P710>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210921055246.GA11535@matrix-ESPRIMO-P710>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 07:52:46AM +0200, Philipp Hortmann wrote:
> This patch fixes the checkpatch.pl warning:
> WARNING: min() should probably be min_t(size_t, count, MAX_TRANSFER)
> +	size_t writesize = min(count, (size_t)MAX_TRANSFER);
> 
> Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
> ---
>  drivers/usb/usb-skeleton.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Please resend with the subject line adding the subsystem and driver name
so that we can better know what you are modifying here.

> diff --git a/drivers/usb/usb-skeleton.c b/drivers/usb/usb-skeleton.c
> index 2dc58766273a..d87deee3e26e 100644
> --- a/drivers/usb/usb-skeleton.c
> +++ b/drivers/usb/usb-skeleton.c
> @@ -363,7 +363,7 @@ static ssize_t skel_write(struct file *file, const char *user_buffer,
>  	int retval = 0;
>  	struct urb *urb = NULL;
>  	char *buf = NULL;
> -	size_t writesize = min(count, (size_t)MAX_TRANSFER);
> +	size_t writesize = min_t(size_t, count, MAX_TRANSFER);
>  
>  	dev = file->private_data;
>  
> -- 
> 2.25.1
> 

Has anyone actually built this driver in a while?

thanks,

greg k-h
