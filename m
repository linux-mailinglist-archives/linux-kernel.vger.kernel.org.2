Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B566D34586F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 08:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbhCWHRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 03:17:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:35710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229508AbhCWHQ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 03:16:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 29844619AB;
        Tue, 23 Mar 2021 07:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616483818;
        bh=Oic7tXm20WEsRdiZO4uFQdTa8PHRKYmlCZBotfy/kM8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WNLMIXyfpsn6i5n4uheEFpoQTbJdwKHYngGdRmpUtlTs2m+l14nGGmshxKfUdUKyF
         cyyNcABTHgsmyYl1faQ96y9kwZey9iAp13CgRJyaOGXCrYwFB21RI0uTpr86KxE4CW
         PTNaVdkJU7Pav/ORYP/3GivYQPHspRfaCePXJQZs=
Date:   Tue, 23 Mar 2021 08:16:55 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lv Yunlong <lyl2019@mail.ustc.edu.cn>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: Add data checks in usbtmc_disconnect
Message-ID: <YFmV51MPhKu/Kq6p@kroah.com>
References: <20210323034717.12818-1-lyl2019@mail.ustc.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323034717.12818-1-lyl2019@mail.ustc.edu.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 08:47:17PM -0700, Lv Yunlong wrote:
> In usbtmc_disconnect, data is got from intf with the
> initial reference. There is no refcount inc operation
> before usbmc_free_int(data). In usbmc_free_int(data),
> the data may be freed.
> 
> But later in usbtmc_disconnect, there is another put
> function of data. I think it is better to add necessary
> checks to avoid the data being put twice. It could cause
> errors in race.
> 
> Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
> ---
>  drivers/usb/class/usbtmc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/class/usbtmc.c b/drivers/usb/class/usbtmc.c
> index 74d5a9c5238a..e0438cb46386 100644
> --- a/drivers/usb/class/usbtmc.c
> +++ b/drivers/usb/class/usbtmc.c
> @@ -2494,7 +2494,9 @@ static void usbtmc_disconnect(struct usb_interface *intf)
>  	}
>  	mutex_unlock(&data->io_mutex);
>  	usbtmc_free_int(data);
> -	kref_put(&data->kref, usbtmc_delete);
> +
> +	if (data->iin_ep_present && data->iin_urb)
> +		kref_put(&data->kref, usbtmc_delete);

What protects the data from changing right after the check and right
before the kref_put() call?

krefs need a lock somewhere to protect from races like this, please fix
that logic instead.

thanks,

greg k-h
