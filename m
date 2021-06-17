Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D98413AB4C5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 15:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbhFQNco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 09:32:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:33640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231176AbhFQNcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 09:32:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 986E861026;
        Thu, 17 Jun 2021 13:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623936634;
        bh=xlbIXi7JbyJzE3qSeyqhFbJJovuNN0NtZ7HgQ2zU/XM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nz1Tskep2no7gsD9oTzCWb379gPRG6tC7Ln7keaHrCj8kHTaiRCQci3gR02KSNZFM
         LDmI0S5T3SNlKaW9ClYtWh11chGBpuEGg7kXjjdiMVwnMVKyF7NaogYKv9AK0GW4cW
         ecuQoJSguLXS86WiFosQkfiiCifPT8Nz5HE4an5o=
Date:   Thu, 17 Jun 2021 15:30:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        balbi@kernel.org
Subject: Re: [PATCH -next] usb: gadget: hid: fix error return code
Message-ID: <YMtOd9qsL4D/glmZ@kroah.com>
References: <20210617065625.1206872-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617065625.1206872-1-yangyingliang@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 02:56:25PM +0800, Yang Yingliang wrote:
> Fix to return a negative error code from the error handling
> case instead of 0.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/usb/gadget/legacy/hid.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/gadget/legacy/hid.c b/drivers/usb/gadget/legacy/hid.c
> index c4eda7fe7ab4..3912cc805f3a 100644
> --- a/drivers/usb/gadget/legacy/hid.c
> +++ b/drivers/usb/gadget/legacy/hid.c
> @@ -99,8 +99,10 @@ static int do_config(struct usb_configuration *c)
>  
>  	list_for_each_entry(e, &hidg_func_list, node) {
>  		e->f = usb_get_function(e->fi);
> -		if (IS_ERR(e->f))
> +		if (IS_ERR(e->f)) {
> +			status = PTR_ERR(e->f);

Are you _SURE_ that you now want to return an error?  This code has
never done this, what is going to break now that it will?

>  			goto put;
> +		}
>  		status = usb_add_function(c, e->f);
>  		if (status < 0) {
>  			usb_put_function(e->f);
> @@ -171,8 +173,10 @@ static int hid_bind(struct usb_composite_dev *cdev)
>  		struct usb_descriptor_header *usb_desc;
>  
>  		usb_desc = usb_otg_descriptor_alloc(gadget);
> -		if (!usb_desc)
> +		if (!usb_desc) {
> +			status = -ENOMEM;

This looks correct, can you resend just this chunk, and then go test the
above change to verify it doesn't break things?

thanks,

greg k-h
