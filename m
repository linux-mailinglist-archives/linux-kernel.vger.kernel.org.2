Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06C3A3A91C5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 08:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbhFPGUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 02:20:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:47026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230084AbhFPGUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 02:20:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1AFF4613BF;
        Wed, 16 Jun 2021 06:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623824274;
        bh=EXYRE2oJ+WkglJIpcA7lcOwkVY7NQV5974kPwoSDUvE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S+6DWrxDs8xoeYg5tLILYRZGfVjN29IFDcIzlFcb1yXjSgNZomlFqZahNsJrEW8hs
         FsWu2fyNPBX08s8Ea96NBmF7esJLyiYnfEqw3tXOGiZD/eSQCDV9nZszNeFttxgOX8
         IWLYOSAkbku+/R7Fua8ZY4PuvuuPr3RO9nK/+pmg=
Date:   Wed, 16 Jun 2021 08:17:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yu Jiahua <yujiahua1@huawei.com>
Cc:     alcooperx@gmail.com, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] drivers: usb: add missing MODULE_DEVICE_TABLE
 definition in brcmstb-usb-pinmap.c
Message-ID: <YMmXj3TQBYwQkxbC@kroah.com>
References: <20210616035003.38149-1-yujiahua1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616035003.38149-1-yujiahua1@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 07:50:03PM -0800, Yu Jiahua wrote:
> This patch adds missing MODULE_DEVICE_TABLE definition which generates
> correct modalias for automatic loading of this driver when it is built
> as an external module.
> 
> Signed-off-by: Yu Jiahua <yujiahua1@huawei.com>
> ---
>  drivers/usb/misc/brcmstb-usb-pinmap.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/misc/brcmstb-usb-pinmap.c b/drivers/usb/misc/brcmstb-usb-pinmap.c
> index b3cfe8666ea7..cbc958355359 100644
> --- a/drivers/usb/misc/brcmstb-usb-pinmap.c
> +++ b/drivers/usb/misc/brcmstb-usb-pinmap.c
> @@ -331,6 +331,7 @@ static const struct of_device_id brcmstb_usb_pinmap_of_match[] = {
>  	{ .compatible = "brcm,usb-pinmap" },
>  	{ },
>  };
> +MODULE_DEVICE_TABLE(of, brcmstb_usb_pinmap_of_match);

I have asked you all to stop sending these types of patches until you
can prove that they are actually needed.

Is this change really needed?  Does the presence of a of table determine
if this module should be loaded or not?

How did you find this problem?

thanks,

greg k-h
