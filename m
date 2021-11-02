Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E53DE442DBD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 13:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbhKBMZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 08:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhKBMZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 08:25:32 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7253DC061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 05:22:57 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id r8so20170596wra.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 05:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PPrVvkKpDShrC2goi1J/Uno+TTdyeE7cxJPzYCbMSPg=;
        b=jxU04U0MA10e7Y9U6CN0a4OFuXLVChKzFdX2BjfJHLmAeI8hJ1qIVqZRMXuo1qTWJJ
         cVBoleFGmLtwyZh9rJDn75yqDgsZYr6c3qDRg9+tzXmS0nKqg3r/iJGblkGBkICrZKcc
         HZHjvOuCGu6J+o5WZ0qcYYidKMyhW0ow1egcdY0EBDTbkco3CzcO1fV0Gam4qcd6+NhQ
         g5c4D5HbGdriLR3dD94mKdWrQ76lxel8gklujAv1GprHxc4TlQBceogA43e6BtZZWzKv
         IVVDJRjA7rzJKa8NetTDVdXGdYt32YEoyK2FvVFb1OX99fxZsP+XX7jFJv39Z/YMqC/r
         UPsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PPrVvkKpDShrC2goi1J/Uno+TTdyeE7cxJPzYCbMSPg=;
        b=duuzdMetlh5U5JAGiMuag4L3RmdDOfJsP5usZJuIC+3fncPPRygD+9kASEjWT8p8vL
         1fDS7EVv/YzBd1+mE4Lc2XDan+fGtPRrmu9BIJR7XQ9cNdEwZRFeVRG3YPsMgsTkQcPr
         dFXmBvchrqPG+GuhshP/jUYTQ25yiAO27uuryxqmEaKaOli3RYSo6F/E3cy2p8erEsZH
         4+i1iplF83gfbolVOvMNhygj6xuiQKJOieSnljm42euY/q7aFLTEymsD3bxAJpCrBIEh
         6QbumbmjPBHTUmnMvMISm9t317RzzBVMwdCpiqpsf8ODuBE53Md+73Kr2sqSZFqVaw3c
         SQoQ==
X-Gm-Message-State: AOAM531+rJq1+HVkcBDtYOoCO6KinT9Z/reHYleIuq7AD2qaXKboTINt
        0VhWtCAclqj82he8DawqBVFD5w==
X-Google-Smtp-Source: ABdhPJw2cKX4hOFi9O3gYybeogMRGL3fiRW5uZVJYAl/ga+gA0jafphuJrk6wM5hf/6vINnLKSD2uA==
X-Received: by 2002:a5d:6e04:: with SMTP id h4mr22288639wrz.127.1635855775993;
        Tue, 02 Nov 2021 05:22:55 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id m20sm2634572wmq.5.2021.11.02.05.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 05:22:55 -0700 (PDT)
Date:   Tue, 2 Nov 2021 12:22:53 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] backlight: lp855x: Add support ACPI enumeration
Message-ID: <20211102122253.s4oc2p7hmy7w2qgn@maple.lan>
References: <20211101185518.306728-1-hdegoede@redhat.com>
 <20211101185518.306728-3-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211101185518.306728-3-hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 01, 2021 at 07:55:17PM +0100, Hans de Goede wrote:
> The Xiaomi Mi Pad 2 tablet uses an ACPI enumerated LP8556 backlight
> controller for its LCD-panel, with a Xiaomi specific ACPI HID of
> "XMCC0001", add support for this.
> 
> Note the new "if (id)" check also fixes a NULL pointer deref when a user
> tries to manually bind the driver from sysfs.
> 
> When CONFIG_ACPI is disabled acpi_match_device() will always return NULL,
> so the lp855x_parse_acpi() call will get optimized away.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/video/backlight/lp855x_bl.c | 70 ++++++++++++++++++++++++-----
>  1 file changed, 60 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/video/backlight/lp855x_bl.c b/drivers/video/backlight/lp855x_bl.c
> index d1d27d5eb0f2..f075ec84acfb 100644
> --- a/drivers/video/backlight/lp855x_bl.c
> +++ b/drivers/video/backlight/lp855x_bl.c
> @@ -338,10 +339,6 @@ static int lp855x_parse_dt(struct lp855x *lp)
>  		return -EINVAL;
>  	}
>  
> -	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> -	if (!pdata)
> -		return -ENOMEM;
> -
>  	of_property_read_string(node, "bl-name", &pdata->name);
>  	of_property_read_u8(node, "dev-ctrl", &pdata->device_control);
>  	of_property_read_u8(node, "init-brt", &pdata->initial_brightness);

Shouldn't there be a removal of an `lp->pdata = pdata` from somewhere in
this function?


> @@ -379,8 +376,31 @@ static int lp855x_parse_dt(struct lp855x *lp)
>  }
>  #endif
>  
> +static int lp855x_parse_acpi(struct lp855x *lp)
> +{
> +	int ret;
> +
> +	/*
> +	 * On ACPI the device has already been initialized by the firmware

Perhaps nitpicking but ideally I'd like "and is in register mode" here 
since I presume it can also be assumed that everything with this HID
has adopted that).

Other than these, LGTM.


Daniel.
