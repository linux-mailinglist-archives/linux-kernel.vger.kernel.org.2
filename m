Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE55644F927
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 17:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234584AbhKNQzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 11:55:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbhKNQzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 11:55:01 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BCBC061746;
        Sun, 14 Nov 2021 08:52:06 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id bf8so29605239oib.6;
        Sun, 14 Nov 2021 08:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Z4tGP427GAXY3GhIqfJ2FaqzEZ1Whewjd01eu201mkU=;
        b=e5SDhrM6s+I2z8m9AUS9fGdQCnnpmaTZXIXa/ysbQj+PfYC5Iy3ZDzVbYf/1L5XpkW
         /tpvrlh52ZIBYWYdcNeEwcaJiWUr2K5V8Bj0aQ+RSe89p2RNrJPqNxBdKfHU90kK2J9N
         C81bz+7NThd6hrpK615m5s/HIJ5uaqMKRimw/pVyZFD9NOzo9eCnwqQ801M+amHMazX+
         mJttkFMPDM2bC+QS8Cb0U2/qjyVVRUdV3wZbcnNMoI697s5AkqznMfZlDTrZ0wl1xRVE
         9gWpxygY/c6HZSis6AcqzZDGOlVdAMlNTi0GIVh7PT3OU2zJBYL458t0GHNFlQYW409B
         uVnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Z4tGP427GAXY3GhIqfJ2FaqzEZ1Whewjd01eu201mkU=;
        b=ko/6MEmZypWghaKjEGkHJS1KXVi1S1H6AnxeDa5jJXnQgDihwClTzEpF7jr6jFuM2u
         KBgQlUklZ7fG9QRaDLz4DR8w3hbMtTrq/buZf4UV/clC/MNQbl+rAxkhlnkfvhJKOkVD
         6EwgS/T1j18yID0kpkXgg60i84c9YzoD2q8mgcje2/nO7s5WKAGBqfrBLTrhZOuvSg/2
         SyZVJyZYj4EvcAtooXHofpctMBL0ERGa7TtB8rO0bb5Q4iQF7aL182FyDQ9q8VKbnAXt
         KqPgQ2PlTvRdiE0DEWuFEiPKRa2LKo7Kjpu1Yu6lJccPAVRpk8FAg+ggrUNlrISXSZLW
         Yutg==
X-Gm-Message-State: AOAM532H6ccgi6U5Hwro4mZKvptarD8pnVuGoKWkq8BW3+GeRBYDhECy
        BpE3ycUdW2CoRVcHWk0DZV2xcJoM3VM=
X-Google-Smtp-Source: ABdhPJz6ZDW88cZnuaA6OHLH8V2t6lr/POihODQ88Dy6et4rbUTa7FM9EH9TA6Nx0pE7gCp0x/wfjQ==
X-Received: by 2002:aca:2408:: with SMTP id n8mr40023631oic.124.1636908726095;
        Sun, 14 Nov 2021 08:52:06 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bb39sm2822205oib.28.2021.11.14.08.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 08:52:05 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 14 Nov 2021 08:52:04 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] hwmon: corsair-psu: fix plain integer used as NULL
 pointer
Message-ID: <20211114165204.GA1956012@roeck-us.net>
References: <YY9hAL8MZEQYLYPf@monster.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YY9hAL8MZEQYLYPf@monster.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 13, 2021 at 06:53:52AM +0000, Wilken Gottwalt wrote:
> sparse warnings: (new ones prefixed by >>)
> >> drivers/hwmon/corsair-psu.c:536:82: sparse: sparse: Using plain
>    integer as NULL pointer
> 
> Fixes: d115b51e0e56 ("hwmon: add Corsair PSU HID controller driver")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/corsair-psu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/corsair-psu.c b/drivers/hwmon/corsair-psu.c
> index 731d5117f9f1..14389fd7afb8 100644
> --- a/drivers/hwmon/corsair-psu.c
> +++ b/drivers/hwmon/corsair-psu.c
> @@ -729,7 +729,7 @@ static int corsairpsu_probe(struct hid_device *hdev, const struct hid_device_id
>  	corsairpsu_check_cmd_support(priv);
>  
>  	priv->hwmon_dev = hwmon_device_register_with_info(&hdev->dev, "corsairpsu", priv,
> -							  &corsairpsu_chip_info, 0);
> +							  &corsairpsu_chip_info, NULL);
>  
>  	if (IS_ERR(priv->hwmon_dev)) {
>  		ret = PTR_ERR(priv->hwmon_dev);
