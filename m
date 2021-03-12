Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59BD633900E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 15:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbhCLOat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 09:30:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:33606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229959AbhCLOak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 09:30:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 812F864FD6;
        Fri, 12 Mar 2021 14:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615559440;
        bh=RLoJPBHkPRJOJbwxoSVQh2GJ5vCNj2ZFWVNZnj/3erY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GXJlYP09bBg42nP8uZuWROFha3lSNtSAeLY5CtlrfB+pfG6VaAyjLXyfQWYS3m2br
         7p4/Vu39DhOQ82QJfmTOkoumhIbGefrokCDw3ZXJZNuqCBgM9sfrbvzRpgsr8Q0vd1
         GUQbTf8s0Tgq6hzzRO4aFrStUV1s849JE2uo6xXs=
Date:   Fri, 12 Mar 2021 15:30:37 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lv Yunlong <lyl2019@mail.ustc.edu.cn>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb/usbtmc: Remove a redundant kref_put in
 usbtmc_disconnect
Message-ID: <YEt7DR4/7/ZLpUZA@kroah.com>
References: <20210311150354.8723-1-lyl2019@mail.ustc.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311150354.8723-1-lyl2019@mail.ustc.edu.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 07:03:54AM -0800, Lv Yunlong wrote:
> In the implementation of usbtmc_free_int(), it already calls
> kref_put() to free the data as shown below. So, in
> usbtmc_disconnect, call an extra kref_put() is redundant.
> 
> """
> static void usbtmc_free_int(struct usbtmc_device_data *data)
> {
> 	if (!data->iin_ep_present || !data->iin_urb)
> 		return;
> 	usb_kill_urb(data->iin_urb);
> 	kfree(data->iin_buffer);
> 	data->iin_buffer = NULL;
> 	usb_free_urb(data->iin_urb);
> 	data->iin_urb = NULL;
> 	kref_put(&data->kref, usbtmc_delete);
> }
> """
> 
> Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
> ---
>  drivers/usb/class/usbtmc.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/usb/class/usbtmc.c b/drivers/usb/class/usbtmc.c
> index 74d5a9c5238a..adcdd2df1949 100644
> --- a/drivers/usb/class/usbtmc.c
> +++ b/drivers/usb/class/usbtmc.c
> @@ -2494,7 +2494,6 @@ static void usbtmc_disconnect(struct usb_interface *intf)
>  	}
>  	mutex_unlock(&data->io_mutex);
>  	usbtmc_free_int(data);
> -	kref_put(&data->kref, usbtmc_delete);

Did you test this change?

If not, please do so, I think the code is fine as-is.

thanks,

greg k-h
