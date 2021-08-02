Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFB93DE2AE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 00:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbhHBWwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 18:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbhHBWwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 18:52:04 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494C5C06175F;
        Mon,  2 Aug 2021 15:51:53 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id o185so25940619oih.13;
        Mon, 02 Aug 2021 15:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Gc7O31W9o/ImGg2xRSYFF5T9hdypGeqEYgTYqohoq0k=;
        b=Oyd8OU0NqfFZPvv6vbZ/1gCZ06byBJNjjqj5k6R0A1LC0tTLUAJRGbxdId+r10d/L4
         wFGsOTihTxkItKcPc/gVv4mTCPnB6yqk+JKtKYbKGIdsng6rdPHt1kfdRwe3rxa2CD2S
         Q4YQUJyPVni0r/jVOaDjaIQRWHFf08N7+BUwM3eHXJJm/k9txsgeitsuLUvCpS2iKOj4
         V0J6wbS8I8RYAPNrt1Me+TiVHmk1r0tji7pRj+eK5vzUgsznn4tfLGwampV19VW+OxB7
         qRmiLu7MOCC5tpPQ4Exi3egcJ64WAO5yFq9gIZ3hcWuStjFEzgIOG14WwQ/0Zyi1eP8v
         /rYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=Gc7O31W9o/ImGg2xRSYFF5T9hdypGeqEYgTYqohoq0k=;
        b=oYIVIv0P0myU71XBXdB7zAUX2YAnmOM6FR2WbCWJbt6gGuKc15JhPaBdZePgtvx+Sg
         LVXnqdFuq4IEA5aGz5jgUyffCAg3epL8tu9oY+QsnS1V7cJ7i5f0d+HAwSc6MoUWFix1
         2Qq1//3V1Z0SKPiDo7pS3GfqQmIXYzCSmB2UiNclK/lya9g6kzT0QJ6GXNzQ7INQq3Gu
         tKp64qViHQAxswe5+14kEUb7DxaomZ8pFjJLTV787Xgi8g7p3RajSmtmzkBxh8w/MKMi
         5Y0/9q1wF5QwmMaeABRsx1qv5hC02JbrWiqUeG4FfJ5YFIscKWzKLIAblBeROwUM5f8w
         oVLw==
X-Gm-Message-State: AOAM5317PAXCJd+4w/ptm3aNs+P4QgoC0tmc3wnX/zX+u26Q9Fr76vcW
        bUstn9OU2CEIJgXXku/LBiQ=
X-Google-Smtp-Source: ABdhPJzaeWHyE8wIYgnLy1P8X5cZdb9wecQgbe2joW39eEe7VB9o+YQTblkontFfbwYs7qBBfPYclQ==
X-Received: by 2002:a54:4806:: with SMTP id j6mr12526276oij.66.1627944712738;
        Mon, 02 Aug 2021 15:51:52 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r1sm1967921ooc.16.2021.08.02.15.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 15:51:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 2 Aug 2021 15:51:50 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Carlos Alberto Lopez Perez <clopez@igalia.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>, Pali Rohar <pali@kernel.org>
Subject: Re: [PATCH] hwmon: (dell-smm) Add Dell Precision 7510 to fan control
 whitelist
Message-ID: <20210802225150.GA2134522@roeck-us.net>
References: <20210802131538.8660-1-clopez@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210802131538.8660-1-clopez@igalia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2021 at 02:15:38PM +0100, Carlos Alberto Lopez Perez wrote:
> This allows manual PWM control without the BIOS fighting back on Dell
> Precision 7510. Meanwhile at it, also sort alphabetically the entries
> of the i8k_whitelist_fan_control struct.
> 
> Signed-off-by: Carlos Alberto Lopez Perez <clopez@igalia.com>
> Acked-by: Pali Rohár <pali@kernel.org>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/dell-smm-hwmon.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
> index f2221ca0aa7b..a677c8a4ef29 100644
> --- a/drivers/hwmon/dell-smm-hwmon.c
> +++ b/drivers/hwmon/dell-smm-hwmon.c
> @@ -1186,14 +1186,6 @@ static const struct i8k_fan_control_data i8k_fan_control_data[] = {
>  };
>  
>  static struct dmi_system_id i8k_whitelist_fan_control[] __initdata = {
> -	{
> -		.ident = "Dell Precision 5530",
> -		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> -			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Precision 5530"),
> -		},
> -		.driver_data = (void *)&i8k_fan_control_data[I8K_FAN_34A3_35A3],
> -	},
>  	{
>  		.ident = "Dell Latitude 5480",
>  		.matches = {
> @@ -1218,6 +1210,22 @@ static struct dmi_system_id i8k_whitelist_fan_control[] __initdata = {
>  		},
>  		.driver_data = (void *)&i8k_fan_control_data[I8K_FAN_34A3_35A3],
>  	},
> +	{
> +		.ident = "Dell Precision 5530",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Precision 5530"),
> +		},
> +		.driver_data = (void *)&i8k_fan_control_data[I8K_FAN_34A3_35A3],
> +	},
> +	{
> +		.ident = "Dell Precision 7510",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Precision 7510"),
> +		},
> +		.driver_data = (void *)&i8k_fan_control_data[I8K_FAN_34A3_35A3],
> +	},
>  	{ }
>  };
>  
