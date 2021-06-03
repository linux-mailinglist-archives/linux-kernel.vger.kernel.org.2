Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9A4399F31
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 12:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbhFCKoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 06:44:54 -0400
Received: from mail-qv1-f44.google.com ([209.85.219.44]:34784 "EHLO
        mail-qv1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhFCKow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 06:44:52 -0400
Received: by mail-qv1-f44.google.com with SMTP id m6so2947053qvg.1;
        Thu, 03 Jun 2021 03:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qZA/yEU8XYY+hN6SkfwGwA9NjKTQyXMkIE8P1Ry807Y=;
        b=eHwGGucFkuiEOjQRRxZAiTycw385gqP3QoKjG9+58obVtjjbQX8ozQzfz+OmX2DLcP
         L2FfwYeb1U17WjRrzp7MXXqoAkFfXNHtueN7Xc4z83pAsK0lR4g8kT1vZhHqIppFbxvo
         7tRtG8+jNoTopLab+v1w3CNZi80fCO3qt+J/9j3M/hBLBjzLeojrkwfi/APO0hHGmM9n
         q51zNEcdjhgWGn2kh8aiMdsqYGfZBkZPNuFKk1mUYKBALwG3aJFAN4yVlr4hRsRBbANy
         cNpU55QIhR8O5Ac0IbryT4Jj3YnWhyMLw+7W+LP4MNjPGbro2RRsAodTOHtzK4/yrnRH
         tYww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=qZA/yEU8XYY+hN6SkfwGwA9NjKTQyXMkIE8P1Ry807Y=;
        b=Uowp0QLtFekw2hJQ+vmnkjoc6iwslKnm5su95XiVDDl/FUKuO7Bk6vGHlRaJyGGQRZ
         kB9AW1H+jUVDCZEbL2wZ0zJ+xNlrR7CdZeOynUuyPNG2/CGBuD2ImslERfQm+IvflmTI
         leXuKRzQE9QgaOcpxH5AJChrZr8w23ZLpV3xruYInHNgf8GNRhSdtMAC8fDg4d+wRY80
         71+MEo+2aul0EXvPaGHvp6YrJDJKjC1+THdty9IahVHeXzkW8CSGKtKaF3lAIpnvfxCR
         +g3Y7fnW3zuxW/aKQT/ybsUek2muBSR+ZbABo7Qr7fDilMWd+msbXODjc3AuCGCJu04j
         BLPA==
X-Gm-Message-State: AOAM532riJ4MZpwjqAKTHET/SX0FNBNwx63E2H+mtHZwbthhGNVYAeEc
        pgp06tg7BETBGZ4g6isZ3Bo=
X-Google-Smtp-Source: ABdhPJxZqk+yptHmw+sLaYiAWH+YXS/B25STaRyd3I/qk1UG7skSLS0F2MJ0SAQDm1IwD9Nf932zyw==
X-Received: by 2002:a05:6214:7f1:: with SMTP id bp17mr18194727qvb.29.1622716919599;
        Thu, 03 Jun 2021 03:41:59 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n4sm401581qkc.79.2021.06.03.03.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 03:41:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 3 Jun 2021 03:41:56 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] hwmon: corsair-psu: fix suspend behavior
Message-ID: <20210603104156.GA644104@roeck-us.net>
References: <YLhnWiI9mI3l5u/s@monster.powergraphx.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLhnWiI9mI3l5u/s@monster.powergraphx.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2021 at 05:23:38AM +0000, Wilken Gottwalt wrote:
> During standby some PSUs turn off the microcontroller. A re-init is
> required during resume or the microcontroller stays unresponsive.
> 
> Fixes: 726c945ab2eb ("hwmon: (corsair-psu) Remove unneeded semicolons")

That seems wrong. Removing semicolons doesn't typically introduce resume bugs.
This should fix the patch introducing the driver.

Guenter

> Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
> ---
>  drivers/hwmon/corsair-psu.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/hwmon/corsair-psu.c b/drivers/hwmon/corsair-psu.c
> index 02298b86b57b..731d5117f9f1 100644
> --- a/drivers/hwmon/corsair-psu.c
> +++ b/drivers/hwmon/corsair-psu.c
> @@ -771,6 +771,16 @@ static int corsairpsu_raw_event(struct hid_device *hdev, struct hid_report *repo
>  	return 0;
>  }
>  
> +#ifdef CONFIG_PM
> +static int corsairpsu_resume(struct hid_device *hdev)
> +{
> +	struct corsairpsu_data *priv = hid_get_drvdata(hdev);
> +
> +	/* some PSUs turn off the microcontroller during standby, so a reinit is required */
> +	return corsairpsu_init(priv);
> +}
> +#endif
> +
>  static const struct hid_device_id corsairpsu_idtable[] = {
>  	{ HID_USB_DEVICE(0x1b1c, 0x1c03) }, /* Corsair HX550i */
>  	{ HID_USB_DEVICE(0x1b1c, 0x1c04) }, /* Corsair HX650i */
> @@ -793,6 +803,10 @@ static struct hid_driver corsairpsu_driver = {
>  	.probe		= corsairpsu_probe,
>  	.remove		= corsairpsu_remove,
>  	.raw_event	= corsairpsu_raw_event,
> +#ifdef CONFIG_PM
> +	.resume		= corsairpsu_resume,
> +	.reset_resume	= corsairpsu_resume,
> +#endif
>  };
>  module_hid_driver(corsairpsu_driver);
>  
> -- 
> 2.31.1
> 
