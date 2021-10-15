Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD6E742FDBF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 00:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238764AbhJOWDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 18:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbhJOWDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 18:03:10 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16675C061570;
        Fri, 15 Oct 2021 15:01:03 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id q129so15088906oib.0;
        Fri, 15 Oct 2021 15:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9bQx+RJz2MXi6DBbWzAZJMniAgxrAjk9YsVhNq5+Guw=;
        b=ba/M8abj4sG3KTmYKoHuhyUXRyXLnqC/NCOqu5YLgw5XIGZ7P/BSheyBQfq8h8HHGV
         n4AMCokPq96nP1hoAQvMmjMDNrYGry2RMByCfonJmM0R5e1rFr3c6sWP9SvN4G786KG6
         dmNHVyPHYL/pAbSd0g3OU0r6RGfqa+HZswpi2cMogabQ+rLfbLvuSgV/BjVGhQzIvpKE
         9koJtuESPngUyRnttoPREPe4trsxoxbC0iqMkFQ9Znb0giERFJgLBL+UQNrZ4s5gVkrw
         Wd1IEdly12q3zpfJpCv/bNv+kO9OjCi/HI6X+MMhFgFOQVlk4c6TixlXU5/dD7jyhouG
         /5pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9bQx+RJz2MXi6DBbWzAZJMniAgxrAjk9YsVhNq5+Guw=;
        b=tDYW8aKE/is+kVWcgzk72xatK77vFXa9k+u+bZ2PMcKyJ0zU2dZOt+bKQabzxnKjeo
         jjfVcXpXjBJTenTSpasGc8pPsz4ATWjuEMjRa7DGLo+Ei1QCaYdoUgBysq47O7hZxTIm
         E+Vo0QskSyJlrTeIbCdcg4bqyfU+Thl4TA2m7ZaY6JaLfW0DYKjWTs7e+xgoKUQgh5G8
         eTyy2zx3GYEx3LHD25UYau5Ut7nZQR9SSnNtyP0cx6oB+Y7JZ/PwmLHkr2dK1im8MGxn
         R/1ToWB6/dTsBo55Am5G/tXUTecuv40y6nFQ2hQHbyQkOKliZYgRMLjvM1puQAf/c2RU
         RvKQ==
X-Gm-Message-State: AOAM5335HDtr6weGGc4OPx3VuROfteDWujejSG43y/v/J805XhUlb3a6
        sUOQLb9FuKmjd8Gu6r97DmLYU8KYvCw=
X-Google-Smtp-Source: ABdhPJx0xjbSPlShlBM2QaX3vyPI0HbSm2JvxsovM/9G5367Wr9jauqTUyUGe+lMh+Y8W26iZuff0w==
X-Received: by 2002:a05:6808:1487:: with SMTP id e7mr10637466oiw.126.1634335262138;
        Fri, 15 Oct 2021 15:01:02 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bg16sm1651837oib.30.2021.10.15.15.01.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Oct 2021 15:01:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] hwmon: replace snprintf in show functions with sysfs_emit
To:     Qing Wang <wangqing@vivo.com>, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1634280525-4532-1-git-send-email-wangqing@vivo.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <96c3c93c-f959-a401-3c91-df58e2643a39@roeck-us.net>
Date:   Fri, 15 Oct 2021 15:00:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1634280525-4532-1-git-send-email-wangqing@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/21 11:48 PM, Qing Wang wrote:
> show() must not use snprintf() when formatting the value to be
> returned to user space.
> 
> Fix the following coccicheck warning:
> drivers/hwmon/smm665.c:378: WARNING: use scnprintf or sprintf.
> 
> Use sysfs_emit instead of scnprintf or sprintf makes more sense.
> 
> Signed-off-by: Qing Wang <wangqing@vivo.com>

Please refrain from such cleanup patches unless you also
make functional changes to a driver.

Guenter

> ---
>   drivers/hwmon/smm665.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/smm665.c b/drivers/hwmon/smm665.c
> index 62906d9..122031e 100644
> --- a/drivers/hwmon/smm665.c
> +++ b/drivers/hwmon/smm665.c
> @@ -375,7 +375,7 @@ static ssize_t smm665_show_##what(struct device *dev, \
>   { \
>   	struct sensor_device_attribute *attr = to_sensor_dev_attr(da); \
>   	const int val = smm665_get_##what(dev, attr->index); \
> -	return snprintf(buf, PAGE_SIZE, "%d\n", val); \
> +	return sysfs_emit(buf, "%d\n", val); \
>   }
>   
>   SMM665_SHOW(min);
> 

