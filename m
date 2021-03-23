Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60C9D345B35
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 10:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbhCWJol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 05:44:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:55562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230071AbhCWJoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 05:44:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C6AC7619BD;
        Tue, 23 Mar 2021 09:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616492663;
        bh=64tJTSxHuc6tooAyIwYiJx5eFO4pEzXDxnqkEmHH570=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w/nSeRcNJHWrBA6xMlnlPTIHvIbDU4dgBEXP6fAJC3WKmoJl3+wNfl3Xu5JvUAhKD
         5/lC3WfxhODSPPLsMkh+K8NaCBC4VwM13g2qO/cf2bkMIFmchB2wqjb6uQa0stvlKr
         kG4NLo/b+ft1wE5WB/3wa9MYk583808aTNKf3Urk=
Date:   Tue, 23 Mar 2021 10:44:20 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lv Yunlong <lyl2019@mail.ustc.edu.cn>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: Add a lock when freeing data in usbtmc_disconnect
Message-ID: <YFm4dJcflEB6Sdwa@kroah.com>
References: <20210323092854.18911-1-lyl2019@mail.ustc.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323092854.18911-1-lyl2019@mail.ustc.edu.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 02:28:54AM -0700, Lv Yunlong wrote:
> In usbtmc_disconnect, data is got from intf with the initial reference.
> There is no refcount inc operation before usbmc_free_int(data). In
> usbmc_free_int(data), the data may be freed.
> 
> But later in usbtmc_disconnect, there is another put function of data.
> It could cause errors in race.
> 
> My patch adds a lock to protect kref from changing in race.
> 
> Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
> ---
>  drivers/usb/class/usbtmc.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/usb/class/usbtmc.c b/drivers/usb/class/usbtmc.c
> index 74d5a9c5238a..44f1fcabbb1e 100644
> --- a/drivers/usb/class/usbtmc.c
> +++ b/drivers/usb/class/usbtmc.c
> @@ -2493,8 +2493,13 @@ static void usbtmc_disconnect(struct usb_interface *intf)
>  		usb_scuttle_anchored_urbs(&file_data->in_anchor);
>  	}
>  	mutex_unlock(&data->io_mutex);
> +
> +	spinlock_t *dev_lock = &data->dev_lock;
> +
> +	spin_lock_irq(dev_lock);
>  	usbtmc_free_int(data);
>  	kref_put(&data->kref, usbtmc_delete);
> +	spin_unlock_irq(dev_lock);
>  }
>  
>  static void usbtmc_draw_down(struct usbtmc_file_data *file_data)
> -- 
> 2.25.1

You obviously did not even build this patch, let alone test it :(

Please do not waste maintainer's time by not doing the proper steps when
submitting patches.

thanks,

greg k-h
