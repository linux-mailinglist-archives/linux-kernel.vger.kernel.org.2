Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B62C39A00E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 13:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbhFCLrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 07:47:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:39322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229736AbhFCLrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 07:47:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 18BBD613E3;
        Thu,  3 Jun 2021 11:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622720708;
        bh=zyubrDY6PgAJro5tE3EZoArdhuv1Wnp1dBHHVd5rV5Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lBOy6uhLHT5dd8gfGWKdDHeB9iQVObwB5de9/luN/ATpIJ+d6g1Q0ugQMAmN5Afnv
         1I+ASzQPBGuhzP4YE85HEp8LwT/5Il+Q8N4F9CsrbPPH1hN1WqxsTKONbfjJuk3GVC
         PAFhyNeP/IYJqBoLRfM+8yevVrkG+uiL3McW+Oos=
Date:   Thu, 3 Jun 2021 13:45:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tong Tiangen <tongtiangen@huawei.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] usb: isp1760: Fix meaningless check in
 isp1763_run()
Message-ID: <YLjAweuyJXzDn9pe@kroah.com>
References: <20210601100311.70200-1-tongtiangen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601100311.70200-1-tongtiangen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2021 at 06:03:11PM +0800, Tong Tiangen wrote:
> There's a meaningless check in isp1763_run. According to the
> similar implement in isp1760_run, the proper check should remove
> retval = 0;
> 
> Fixes: 60d789f3bfbb ("usb: isp1760: add support for isp1763")
> Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
> ---
>  drivers/usb/isp1760/isp1760-hcd.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/usb/isp1760/isp1760-hcd.c b/drivers/usb/isp1760/isp1760-hcd.c
> index 016a54ea76f4..27168b4a4ef2 100644
> --- a/drivers/usb/isp1760/isp1760-hcd.c
> +++ b/drivers/usb/isp1760/isp1760-hcd.c
> @@ -1648,7 +1648,6 @@ static int isp1763_run(struct usb_hcd *hcd)
>  	down_write(&ehci_cf_port_reset_rwsem);
>  	retval = isp1760_hcd_set_and_wait(hcd, FLAG_CF, 250 * 1000);
>  	up_write(&ehci_cf_port_reset_rwsem);
> -	retval = 0;
>  	if (retval)
>  		return retval;
>  
> -- 
> 2.18.0.huawei.25
> 

Did you test this change to verify that the driver still works properly?
You are now checking something that never was checked before...

thanks,

greg k-h
