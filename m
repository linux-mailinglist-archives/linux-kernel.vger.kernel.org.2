Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E33D837F940
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 15:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234265AbhEMOA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 10:00:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:34930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234125AbhEMOAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 10:00:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D8093613CB;
        Thu, 13 May 2021 13:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620914345;
        bh=9HPOfeqNsiShUm9j8FOh3mdJ/VHgroUuF5wEuIfb1mU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EQifcfF3NHO5xPsMTxCcdylPC9aa8VQ0MRzkik3maWbQ/p/TzHaYRDx5zV2UMU+hB
         7M/L6D7u0uZ/sob6Ve+gQvKn0g2YgKmt782/5m3Nhx4tDyxRz/337kiI9Wi3ZgXZxJ
         QAX8Tm87DSMt5pxgT/XTVF+2ewJDLjsnFZp2DXHo=
Date:   Thu, 13 May 2021 15:59:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zou Wei <zou_wei@huawei.com>
Cc:     stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] USB: EHCI: ehci-mv: add missing MODULE_DEVICE_TABLE
Message-ID: <YJ0wp8GSBUFXZbdC@kroah.com>
References: <1620801369-18642-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620801369-18642-1-git-send-email-zou_wei@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021 at 02:36:09PM +0800, Zou Wei wrote:
> This patch adds missing MODULE_DEVICE_TABLE definition which generates
> correct modalias for automatic loading of this driver when it is built
> as an external module.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> ---
>  drivers/usb/host/ehci-mv.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/host/ehci-mv.c b/drivers/usb/host/ehci-mv.c
> index cffdc8d..beb478c 100644
> --- a/drivers/usb/host/ehci-mv.c
> +++ b/drivers/usb/host/ehci-mv.c
> @@ -266,6 +266,7 @@ static const struct platform_device_id ehci_id_table[] = {
>  	{"pxa-sph", 0},
>  	{},
>  };
> +MODULE_DEVICE_TABLE(platform, ehci_id_table);

As I said elsewhere, I'm not taking these unless you can show a reason
why they are needed.

thanks,

greg k-h
