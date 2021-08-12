Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 594A13E9DAD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 06:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234083AbhHLElx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 00:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234071AbhHLElw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 00:41:52 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBEAC061765;
        Wed, 11 Aug 2021 21:41:27 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id m3so2492373qvu.0;
        Wed, 11 Aug 2021 21:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L2WUXypp3nlP8x49Ux9nvTBKdVLK4zFUzSNBN9p7OHc=;
        b=K7unFVZjsDn1JHY53snVIm96s6eJbVnY1VKuV20XkT7A3orqKtzMXW7iuBGKYm1CDC
         8gNLgMMWK6TGi2wAjcsW6MTZHg5CnTHvJX12b/Ic2GhpIZouPC2VKwsl43ODFeCNLEnp
         ISfpxEx3inO1WnfvY7vtBmx+RJ72lDkBt4FCpWIYjI0YsJt9ew9WhaiU994UuJj3LjW1
         B7PlbTRZoBHdsrLXbcR4YO+SFNBwDR4cSpj9PL6WnxCQhbc8kmwQw5HSGXgdul51oTm4
         EVFoe39G84kGOZ6ZkeYFUQIBayukCwUqacWsUCwgIjTf9upd0tdVJoO9NX8zXVZtd8Vj
         fXeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=L2WUXypp3nlP8x49Ux9nvTBKdVLK4zFUzSNBN9p7OHc=;
        b=ca8HxZE5sIF/+D+ah2aSomZcAzTaLeGPdNRlx9qsWFS2vvq5469crXZn9U0up9QNmc
         +Z2XF1VXOmV5SwCoscGvK651srVo1jwDcfYl5LO/U4Wpdqff/pF8RW6GNc18XfYMAcem
         J5lJK8KNComLlRQZmg9oMm22/oED7E5L9ksaLXZEtZzH975I6h1i15qgVKQzuq2V32UR
         L0nK4TKkew1AlR0E4/u7robanoLPMI9l2xdwtjSB18+LcFBr94yIxyFwwHMR1BWS9f/k
         goBli3rHWoq8sj9KGmRnpc4krvHsQgvEAqFS9IBQzhUW/Xr2ib3FdRULmtWQjmJPX7YI
         Sjdw==
X-Gm-Message-State: AOAM530/RZgZbM01/FqckyjExNafz8mTEdM1ys2Eg61bPuKO0OgbCrYd
        xUt+igGQnd7z1GCcSfib51vFKH+DZKQ=
X-Google-Smtp-Source: ABdhPJyP9DKox6AzxVD0Zivf0x1cDzrcSfqb0Ua6zzDd8U3COEBEWjqVnVvcfrDrk89C5Ezsq2xwMw==
X-Received: by 2002:a05:6214:2609:: with SMTP id gu9mr2115303qvb.35.1628743286692;
        Wed, 11 Aug 2021 21:41:26 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f15sm596301qte.5.2021.08.11.21.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 21:41:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 11 Aug 2021 21:41:24 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] hwmon: (pmbus/bpa-rs600) Add workaround for
 incorrect Pin max
Message-ID: <20210812044124.GA1116027@roeck-us.net>
References: <20210812014000.26293-1-chris.packham@alliedtelesis.co.nz>
 <20210812014000.26293-3-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210812014000.26293-3-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2021 at 01:40:00PM +1200, Chris Packham wrote:
> BPD-RS600 modules running firmware v5.70 misreport the MFR_PIN_MAX.
> The indicate a maximum of 1640W instead of 700W. Detect the invalid
> reading and return a sensible value instead.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Applied.

Thanks,
Guenter

> ---
> 
> Notes:
>     Changes in v2:
>     - Add comments for magic values
> 
>  drivers/hwmon/pmbus/bpa-rs600.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/hwmon/pmbus/bpa-rs600.c b/drivers/hwmon/pmbus/bpa-rs600.c
> index 84dee86399cb..f2d4e378a775 100644
> --- a/drivers/hwmon/pmbus/bpa-rs600.c
> +++ b/drivers/hwmon/pmbus/bpa-rs600.c
> @@ -65,6 +65,26 @@ static int bpa_rs600_read_vin(struct i2c_client *client)
>  	return ret;
>  }
>  
> +/*
> + * Firmware V5.70 incorrectly reports 1640W for MFR_PIN_MAX.
> + * Deal with this by returning a sensible value.
> + */
> +static int bpa_rs600_read_pin_max(struct i2c_client *client)
> +{
> +	int ret;
> +
> +	ret = pmbus_read_word_data(client, 0, 0xff, PMBUS_MFR_PIN_MAX);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Detect invalid 1640W (linear encoding) */
> +	if (ret == 0x0b34)
> +		/* Report 700W (linear encoding) */
> +		return 0x095e;
> +
> +	return ret;
> +}
> +
>  static int bpa_rs600_read_word_data(struct i2c_client *client, int page, int phase, int reg)
>  {
>  	int ret;
> @@ -91,6 +111,9 @@ static int bpa_rs600_read_word_data(struct i2c_client *client, int page, int pha
>  	case PMBUS_READ_VIN:
>  		ret = bpa_rs600_read_vin(client);
>  		break;
> +	case PMBUS_MFR_PIN_MAX:
> +		ret = bpa_rs600_read_pin_max(client);
> +		break;
>  	default:
>  		if (reg >= PMBUS_VIRT_BASE)
>  			ret = -ENXIO;
