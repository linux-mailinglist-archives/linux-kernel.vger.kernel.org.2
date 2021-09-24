Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1ED4417170
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 14:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245652AbhIXMC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 08:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244439AbhIXMC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 08:02:58 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3A3C061574;
        Fri, 24 Sep 2021 05:01:25 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id s36-20020a05683043a400b0054d4c88353dso1932311otv.0;
        Fri, 24 Sep 2021 05:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xe8hbcCe7Il2R3uT9h3I/mQYjYvm30reKshUti4lTYU=;
        b=HhsXDQ+Enaw+Ox6jaivp+qkBNL3jZBeVYJtkeOBUVX6ZI33Uk7bQlP8JuCKOE8M1cK
         Zqfqf5H6mofkXgAhhaxtv69r/jBZBXSO9fen+scZLl1euVLoXEZ1z0hQeuR1CeHYPnMa
         8gyCJyz6U9SpXtdb6BVVC0CknxeBtKroEB2XTgV98OYCP0ymuJYY1NwmgHKllRKVtC9q
         pQt2RZYD9BLBDE0OXZX3qfwG12DBXxTunRbxFhHAWgFB54+nc4txs6IrzJilYmuPaXlN
         jdAsLLN4j6F916fXKaFfiKmUdDV3mW2c5IJ4MZwSKhIJinOKlFtM0gcO6vDCMskGRtHq
         98iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=xe8hbcCe7Il2R3uT9h3I/mQYjYvm30reKshUti4lTYU=;
        b=1PyUR/mz+QTY47KDn2KAQEzUBblZKITdMaOpWWU/aboX8FBfvLSSx9hnNvlR/78aHv
         enCk+qlNvfu7ZAiUXGyubqJW4aLd+L0FD4cXJD/7/1v2ih6VYSLd4i4uztnCr9C+huRs
         d744nhpf6ocZO5p5JrZgPG4pG9K4gYXcQlAhx82L6IyQBHTXfkF3hvMAjlgKpYlWM3JP
         TGVVt76d+lckjOlcDcS+JJ/sm5dnjh6bOaJrB369tZH9Nzce3sdFdaQVZvsqP+9qeBuJ
         5PQclqkzp1gSTWvG3DiBIzBWW+XNtrZ3zZoYsLfqaNOmVNpvlrimtLlGXNj6Botgl/I4
         d7uw==
X-Gm-Message-State: AOAM533cJAmBM6Luwf+V6kLoKDoB/5k15F50yMZawi1WUKbPzMnqWpE0
        LKarKLjBlBaqwADFrA3ziRb0sj9yvTY=
X-Google-Smtp-Source: ABdhPJzqemAsZhe3Xlw35FomqbI3ZogJ8e3kDKO7YG67NzCTQWwsGzEbLicdKN+qR12OzZb7sm4H0g==
X-Received: by 2002:a05:6830:79c:: with SMTP id w28mr3490244ots.332.1632484883173;
        Fri, 24 Sep 2021 05:01:23 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i25sm2028562oto.26.2021.09.24.05.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 05:01:22 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 24 Sep 2021 05:01:20 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Paul Fertser <fercerpav@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] hwmon: tmp421: fix rounding for negative values
Message-ID: <20210924120120.GA2695828@roeck-us.net>
References: <20210924022020.GA3032273@roeck-us.net>
 <20210924093011.26083-1-fercerpav@gmail.com>
 <20210924093011.26083-3-fercerpav@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210924093011.26083-3-fercerpav@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2021 at 12:30:11PM +0300, Paul Fertser wrote:
> Old code produces -24999 for 0b1110011100000000 input in standard format due to
> always rounding up rather than "away from zero".
> 
> Use the common macro for division, unify and simplify the conversion code along
> the way.
> 
> Fixes: 9410700b881f ("hwmon: Add driver for Texas Instruments TMP421/422/423 sensor chips")
> Signed-off-by: Paul Fertser <fercerpav@gmail.com>

Applied.

Thanks,
Guenter

> ---
> 
> Changes from v2:
>  - Add Fixes: tag
> 
> Changes from v1:
>  - Trivial rebase
> 
>  drivers/hwmon/tmp421.c | 24 ++++++++----------------
>  1 file changed, 8 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/hwmon/tmp421.c b/drivers/hwmon/tmp421.c
> index 3a789f21188c..85f5f0eb3d2e 100644
> --- a/drivers/hwmon/tmp421.c
> +++ b/drivers/hwmon/tmp421.c
> @@ -100,23 +100,17 @@ struct tmp421_data {
>  	s16 temp[4];
>  };
>  
> -static int temp_from_s16(s16 reg)
> +static int temp_from_raw(u16 reg, bool extended)
>  {
>  	/* Mask out status bits */
>  	int temp = reg & ~0xf;
>  
> -	return (temp * 1000 + 128) / 256;
> -}
> -
> -static int temp_from_u16(u16 reg)
> -{
> -	/* Mask out status bits */
> -	int temp = reg & ~0xf;
> -
> -	/* Add offset for extended temperature range. */
> -	temp -= 64 * 256;
> +	if (extended)
> +		temp = temp - 64 * 256;
> +	else
> +		temp = (s16)temp;
>  
> -	return (temp * 1000 + 128) / 256;
> +	return DIV_ROUND_CLOSEST(temp * 1000, 256);
>  }
>  
>  static int tmp421_update_device(struct tmp421_data *data)
> @@ -175,10 +169,8 @@ static int tmp421_read(struct device *dev, enum hwmon_sensor_types type,
>  
>  	switch (attr) {
>  	case hwmon_temp_input:
> -		if (tmp421->config & TMP421_CONFIG_RANGE)
> -			*val = temp_from_u16(tmp421->temp[channel]);
> -		else
> -			*val = temp_from_s16(tmp421->temp[channel]);
> +		*val = temp_from_raw(tmp421->temp[channel],
> +				     tmp421->config & TMP421_CONFIG_RANGE);
>  		return 0;
>  	case hwmon_temp_fault:
>  		/*
