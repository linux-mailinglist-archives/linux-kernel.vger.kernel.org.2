Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3109238CDA2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 20:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbhEUSlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 14:41:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:45742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229554AbhEUSlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 14:41:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3CC6461175;
        Fri, 21 May 2021 18:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621622398;
        bh=cKlhK4oF+JIPygA7+E3iHHJ+pDcFtN/HU+w+6N04Jo8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ozG5QQLzvsBiSf10UCDjLEXwLfGQM5OrjG07smaQ8tDTRf6iggrxrYP14499ITq+V
         vYWZDEvUZwrIFVosCJsjT8BzzeuRFqDK7uKwNOPxYy5iw2gNjWvFJn79sWdd1XZC92
         HcrG46/ScQ+UMAt3fwXtVlEQKK7gDDM9VRHO6gQc=
Date:   Fri, 21 May 2021 20:39:56 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] misc: xilinx-sdfec: Check if file->private_data is
 NULL
Message-ID: <YKf+fJBXXyvIFrZF@kroah.com>
References: <20210520170150.1615956-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520170150.1615956-1-linux@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 10:01:50AM -0700, Guenter Roeck wrote:
> container_of() only returns NULL if the passed pointer is NULL _and_
> the embedded element is the first element of the structure. Even if that
> is the case, testing against it is misleading and possibly dangerous
> because the position of the embedded element may change. Explicitly
> check if the parameter is NULL and bail out if so instead of checking
> the result of container_of().
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> RFC:
> 
> The NULL check in the poll function is likely unnecessary. Interestingly,
> there is no NULL check in the ioctl function, even though there is a
> similar container_of() in that function. However, I do not feel
> comfortable enough to change the functionality of this code and drop
> the check entirely.
> 
>  drivers/misc/xilinx_sdfec.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/misc/xilinx_sdfec.c b/drivers/misc/xilinx_sdfec.c
> index 23c8448a9c3b..0a3721d31dea 100644
> --- a/drivers/misc/xilinx_sdfec.c
> +++ b/drivers/misc/xilinx_sdfec.c
> @@ -1011,11 +1011,11 @@ static __poll_t xsdfec_poll(struct file *file, poll_table *wait)
>  	__poll_t mask = 0;
>  	struct xsdfec_dev *xsdfec;
>  
> -	xsdfec = container_of(file->private_data, struct xsdfec_dev, miscdev);
> -
> -	if (!xsdfec)
> +	if (!file->private_data)
>  		return EPOLLNVAL | EPOLLHUP;
>  
> +	xsdfec = container_of(file->private_data, struct xsdfec_dev, miscdev);
> +
>  	poll_wait(file, &xsdfec->waitq, wait);
>  
>  	/* XSDFEC ISR detected an error */
> -- 
> 2.25.1
> 


It should be safe not to check this for NULL as the misc device sets the
pointer in the open, and removes it in release.  poll or ioctl can not
be called if release has already happened.

So feel free to drop the check here, xsdfec_dev_ioctl() looks correct.

thanks,

greg k-h
