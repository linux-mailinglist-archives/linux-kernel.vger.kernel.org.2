Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6E323DE63E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 07:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233853AbhHCFiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 01:38:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:44492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233758AbhHCFiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 01:38:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5027860F48;
        Tue,  3 Aug 2021 05:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627969079;
        bh=Ltgf7DXL7b3uGZYtty/Mz9MOCbuhMBWzEGcCTBprpBw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IeKW5kOx2QbCoWxjX7jjFg4Xn0+d0LRdsCyvaarNHdM8Aklixj6hj/MMj9mPH40Iz
         ojU7lfA4k2fi5mFO/wiWCqt1x3ZLOutjzu5R03xi9OWaN7/QB6Av8YibfX/EtTvizL
         ySWM6F1mVof9wwozdzONcXHZWCxtKEkBq/Cc3OGY=
Date:   Tue, 3 Aug 2021 07:37:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Salah Triki <salah.triki@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: bluetooth: get lock before calling
 usb_[disable|enable]_autosuspend()
Message-ID: <YQjWNUgFWU2UO0RR@kroah.com>
References: <20210802221429.GA1370657@pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210802221429.GA1370657@pc>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2021 at 11:14:29PM +0100, Salah Triki wrote:
> Based on the documentation of usb_[disable|enable]_autosuspend(), the
> caller must hold udev's device lock.
> 
> Signed-off-by: Salah Triki <salah.triki@gmail.com>
> ---
>  drivers/bluetooth/btusb.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index a9855a2dd561..2ceb48164b6d 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -1939,8 +1939,11 @@ static int btusb_setup_csr(struct hci_dev *hdev)
>  
>  			device_set_wakeup_capable(&data->udev->dev, false);
>  			/* Re-enable autosuspend if this was requested */
> -			if (enable_autosuspend)
> +			if (enable_autosuspend) {
> +				usb_lock_device(data->udev);
>  				usb_enable_autosuspend(data->udev);
> +				usb_unlock_device(data->udev);
> +			}
>  		}
>  	}
>  
> -- 
> 2.25.1
> 

As was pointed out elsewhere, this is not correct.

thanks,

greg k-h
