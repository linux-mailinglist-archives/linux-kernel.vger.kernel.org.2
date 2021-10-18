Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD824321FD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 17:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbhJRPJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 11:09:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:49016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232957AbhJRPJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 11:09:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3E3F160EE9;
        Mon, 18 Oct 2021 15:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634569638;
        bh=Md59R3ONCqA6DyDyeTDd7ISrl7eVjopr9ACmL5mS5tk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1ZZaMCSaxdA/CIeNTvKesceOkoRJZ87xNoKPvQoF8AveNgeVspamgtqXWe1yCMreq
         I3Dq7US8r58YjLqbew9KPUtpligOiMeuMby3n7CY5KW/XzxRMjZBj6q1MjMfn0wwd/
         uNrQUjj7rpMLfURLpLjV4OiboBqfd3geSPV/i+DU=
Date:   Mon, 18 Oct 2021 17:07:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        balbi@kernel.org
Subject: Re: [PATCH] usb: phy: isp1301: add release func to dev to avoid
 memory leak
Message-ID: <YW2NpDG6hGJk4UR9@kroah.com>
References: <20211015051624.1655193-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015051624.1655193-1-yangyingliang@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 01:16:24PM +0800, Yang Yingliang wrote:
> After calling usb_add_phy_dev(), client->dev.type will be changed
> to 'usb_pyh_dev_type', the release() func is null, it cause the
> following WARNING:
> 
> Device '1-001c' does not have a release() function, it is broken and must be fixed. See Documentation/core-api/kobject.rst.
> WARNING: CPU: 1 PID: 405 at device_release+0x1b7/0x240
> Call Trace:
>  kobject_put+0x1e5/0x540
>  device_unregister+0x35/0xc0
>  i2c_unregister_device+0x114/0x1f0
> 
> It cause 'client' leaked which is allocated in i2c_new_client_device():
> 
> unreferenced object 0xffff88800670b000 (size 2048):
>   comm "xrun", pid 429, jiffies 4294946742 (age 235.248s)
>   hex dump (first 32 bytes):
>     00 00 1c 00 69 73 70 31 33 30 31 00 00 00 00 00  ....isp1301.....
>     00 00 00 00 00 00 00 00 c0 e4 17 c1 ff ff ff ff  ................
>   backtrace:
>     [<00000000a4641100>] kmem_cache_alloc_trace+0x186/0x2b0
>     [<00000000d9d933e7>] i2c_new_client_device+0x56/0xb40
>     [<000000007255bed2>] new_device_store+0x1f4/0x410
> 
> So add release func to dev to avoid this memory leak.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 790d3a5ab6e36 ("usb: phy: isp1301: give it a context structure")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/usb/phy/phy-isp1301.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/phy/phy-isp1301.c b/drivers/usb/phy/phy-isp1301.c
> index ad3d57f1c273..04f005572484 100644
> --- a/drivers/usb/phy/phy-isp1301.c
> +++ b/drivers/usb/phy/phy-isp1301.c
> @@ -111,6 +111,7 @@ static int isp1301_probe(struct i2c_client *client,
>  	phy->init = isp1301_phy_init;
>  	phy->set_vbus = isp1301_phy_set_vbus;
>  	phy->type = USB_PHY_TYPE_USB2;
> +	client->dev.release = client->dev.type->release;

messing with a release pointer is almost never a good idea, and a sign
that something is really wrong.

Why is the type not set properly here so as to get the correct release
callback when the device is created?  Why do you have to manually change
this now after the fact?

thanks,

greg k-h
