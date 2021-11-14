Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47BB644F92B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 17:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236135AbhKNQ4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 11:56:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236154AbhKNQ42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 11:56:28 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED330C061766;
        Sun, 14 Nov 2021 08:53:32 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id h16-20020a9d7990000000b0055c7ae44dd2so23133735otm.10;
        Sun, 14 Nov 2021 08:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=E37wA/hsCJDRq+8BgTkaMhMSDrqI4fJzKISSqHgvjSw=;
        b=bkpiLjIF3wmuP7g2DrDDP4SYjv8SVAB0TuAsk5bXm6X0JitJ/f6WbMsfBry1OkQWJR
         BoMSIrtS/W4k3ivq2jgE+Gv+a8b/AVvaFSnAjEkVVuvtKOHzs1iGa/XwH+/I8VSefz5Y
         xMAnuX23zMK2Az8WBtdxJeyM4lsy4sSZp/tLIxpioedm8jyJvYqV/JLpC0lKIAuIaLob
         58TfpBfOejN06ADESxgkLZXnbY6vin91YNq5ZMSgFSWzYufOLJBdhwSWuOWzyvb3Atb/
         4OUMUVVJhSvqRI7YSuMh5q47Fs2OnhP4UXLnu74t+ioLykugR5r5VkQ/1WQp39NPWZkW
         VG1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=E37wA/hsCJDRq+8BgTkaMhMSDrqI4fJzKISSqHgvjSw=;
        b=uKjRMuVArxMO/rw+Ii4xr41r3h3IB35jr27fYtsQk4TJtP0/yx7kUmFWyw9G/WG6B9
         WJpiyzTUkIWvskmAlKygPNCumy1hnzLU+TUaAFut+6dZMmwzzNxFoGmU0zTw2aZzLRSQ
         686WcgZBrXCu3lGqjszr+S97FQFz2Rm+6cYwJ9TUdpxRVX0toKL8rdL3PMfGMAjd5FaR
         Zjt9IlZGIPDPyGGd27J3uDbJfmZfXkFTM7IJWurKV5+xfKx7ezSnmTEAuxQ3K/txNw09
         +m9POXaRKYrUiKVXiaA5M9KXSNLkw6xZEh+sJWw9LxCe2glfdDNtbOnwAsempTc2oc30
         uUOA==
X-Gm-Message-State: AOAM531znuC7fM3wouCzggJwZ94hRaSlyQxv0MTLw4GUbfZUKhZ0bT6A
        /PB6diG4p+HHr0FQUoG1VI+lGt6ZnoE=
X-Google-Smtp-Source: ABdhPJzi8tFnscb6qa3jYCSqGWIEQWML1S+GORaBIDBn9NUrrMUIkuFrVLCdboPOdQdMRL6PnkoqiQ==
X-Received: by 2002:a9d:4d8b:: with SMTP id u11mr25495018otk.144.1636908812395;
        Sun, 14 Nov 2021 08:53:32 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s26sm531688oiw.19.2021.11.14.08.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 08:53:31 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 14 Nov 2021 08:53:30 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Denis Pauk <pauk.denis@gmail.com>,
        Bernhard Seibold <mail@bernhard-seibold.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (nct6775) mask out bank number in
 nct6775_wmi_read_value()
Message-ID: <20211114165330.GA1983567@roeck-us.net>
References: <20211111025339.27520-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211111025339.27520-1-zev@bewilderbeest.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 06:53:38PM -0800, Zev Weiss wrote:
> The first call to nct6775_asuswmi_read() in nct6775_wmi_read_value()
> had been passing the full bank+register number instead of just the
> lower 8 bits.  It didn't end up actually causing problems because the
> second argument of that function is a u8 anyway, but it seems
> preferable to be explicit about it at the call site (and consistent
> with the rest of the code).
> 
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> Fixes: 3fbbfc27f955 ("hwmon: (nct6775) Support access via Asus WMI")
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/nct6775.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
> index 93dca471972e..57ce8633a725 100644
> --- a/drivers/hwmon/nct6775.c
> +++ b/drivers/hwmon/nct6775.c
> @@ -1527,7 +1527,7 @@ static u16 nct6775_wmi_read_value(struct nct6775_data *data, u16 reg)
>  
>  	nct6775_wmi_set_bank(data, reg);
>  
> -	err = nct6775_asuswmi_read(data->bank, reg, &tmp);
> +	err = nct6775_asuswmi_read(data->bank, reg & 0xff, &tmp);
>  	if (err)
>  		return 0;
>  
