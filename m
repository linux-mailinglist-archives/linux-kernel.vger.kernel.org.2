Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAF4449CAC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 20:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237815AbhKHTvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 14:51:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:60190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237645AbhKHTvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 14:51:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E68CC61074;
        Mon,  8 Nov 2021 19:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636400896;
        bh=Xy6ERyO9VjI/NLdRp8FAcG8mXjwDb9dKMByPj5Ztw6M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PUAb3ROJN2WP1Lsvst6dN6twK86GEuXSzzVMztMD5QQsQ4E4B/Y/oK/0H78jEWF1p
         /9W2kyhfZJ+7pz4bbjeeyOmV4iMN5C9QTmh2gBxIT+k8k3TjvamHrqTP5IDC5fPQqt
         Vn9RIFxOWnAFM90FNm+Qt+l8TN22x//fHf6tf3D/19DnAJTV2EGJeGv6696SRqmHHd
         y/C4hAqVUH+skc2LX0x0fhfzL2ON1idw6ctv0hbSIiwGitkCvJWDYQj9KI458TK1El
         ZmJRX5lPXKgs27NY4fX2IL4HeaPAv4HvIETRgS2M4uGGBmgv7XhOqsRWWNuujuaibv
         1tWF8j+Pigsdg==
Date:   Mon, 8 Nov 2021 11:48:14 -0800
From:   Mark Gross <markgross@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     eric.piel@tremplin-utc.net, hdegoede@redhat.com,
        markgross@kernel.org, dmitry.torokhov@gmail.com,
        giedriuswork@gmail.com, dvhart@linux.intel.com,
        akpm@linux-foundation.org, pavel@suse.cz,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] platform/x86: hp_accel: Fix an error handling path in
 'lis3lv02d_probe()'
Message-ID: <20211108194814.GI61200@T470>
References: <5a4f218f8f16d2e3a7906b7ca3654ffa946895f8.1636314074.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a4f218f8f16d2e3a7906b7ca3654ffa946895f8.1636314074.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 07, 2021 at 08:57:07PM +0100, Christophe JAILLET wrote:
> If 'led_classdev_register()' fails, some additional resources should be
> released.
> 
> Add the missing 'i8042_remove_filter()' and 'lis3lv02d_remove_fs()' calls
> that are already in the remove function but are missing here.
> 
> Fixes: a4c724d0723b ("platform: hp_accel: add a i8042 filter to remove HPQ6000 data from kb bus stream")
> Fixes: 9e0c79782143 ("lis3lv02d: merge with leds hp disk")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/platform/x86/hp_accel.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/platform/x86/hp_accel.c b/drivers/platform/x86/hp_accel.c
> index b183967ecfb7..435a91fe2568 100644
> --- a/drivers/platform/x86/hp_accel.c
> +++ b/drivers/platform/x86/hp_accel.c
> @@ -331,9 +331,11 @@ static int lis3lv02d_probe(struct platform_device *device)
adding some lines of context:

326         /* filter to remove HPQ6000 accelerometer data                          
327          * from keyboard bus stream */                                          
328         if (strstr(dev_name(&device->dev), "HPQ6000"))                          
329                 i8042_install_filter(hp_accel_i8042_filter);                    
330                                                          
>  	INIT_WORK(&hpled_led.work, delayed_set_status_worker);
>  	ret = led_classdev_register(NULL, &hpled_led.led_classdev);
>  	if (ret) {
> +		i8042_remove_filter(hp_accel_i8042_filter);
This filter was added under a conditional.  Should it not be removed under a
similar conditional?
>  		lis3lv02d_joystick_disable(&lis3_dev);
>  		lis3lv02d_poweroff(&lis3_dev);
>  		flush_work(&hpled_led.work);
> +		lis3lv02d_remove_fs(&lis3_dev);
where was the fs ever added?

--mark

>  		return ret;
>  	}
>  
> -- 
> 2.30.2
> 
