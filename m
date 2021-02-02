Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 230AC30B41F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 01:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbhBBA1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 19:27:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbhBBA1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 19:27:24 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6239BC06174A;
        Mon,  1 Feb 2021 16:26:44 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id v1so18216724ott.10;
        Mon, 01 Feb 2021 16:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i6JkiAwSb3HBncqwTBbNhVXvsBhU0XSQ0XjjnMxZCrA=;
        b=vXfnVQJ/4p12PigbXVY/AFuTQ4Za4g4X9UFiFxW4ilPDmmLLWKxmwdB4IyPD6svi9I
         lGAIdtjEMP0FDFMzWTs1/I2xW6NmoOZ1rqz0fUZ6Aedb8hqPPJs4GVn3LmXWHl1hY6r1
         xIzVJgWvDHucseriQkfKRHhTylT8n8W10/1VukAQpamc1GslIym+JCmZte8PoYRZZRXM
         nut2utaq4P7e7sUZktm3YsVsHqYAW2CsCRwRQgncJdx8v4AzZAoMkiH42ifB1NnrAyEU
         Y0AUDbW6PKz3jTo+9WEoU8DaXfqFNdcItsuQ8IT75PJfESVzlf4EMOHwS/vJzuf99lav
         E1Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=i6JkiAwSb3HBncqwTBbNhVXvsBhU0XSQ0XjjnMxZCrA=;
        b=RqoGPEGbqahvMp4O9E/M4MdqmaCLm5bygzxgzFQLqS7+TVJ2wtbuFOU9G6sWHO0AVU
         0yBz5sH/abE8H3lAtXwE34gIS1Ssa5Q7+EUxs2cvPQhepeIBND3GuTIoC3p3KuoY2/Dp
         n0LILyzeSWKAYz3Vn/AFwKSU0LKY1LYqZIq9n7COYDxgpfGSNVjfn9wlOpb6o0/yq3PM
         0zTOhLTgf8HcJYbbdRumd7c/nmYNGZ9MsSdoPxkO0M1xdKdE4VXRqaO5p+QeuNcqZ72b
         wJeRwLeAI2suF9PHbkGkby8q3eLqZ474oBoHPzLEt97sSnctPv+kBWXs4RrOpZZVXb1S
         98sQ==
X-Gm-Message-State: AOAM5310BWcvq5MXHBbL8hN6VJgmDI7ohT/1pMGrnXdjwmifiClUcyXK
        4bn5TgSoAOAY45l1YSikVBWnt0frZtQ=
X-Google-Smtp-Source: ABdhPJzgev/QUJjMekZCovxlgS+zHHkw+ZzLuDKpXS8T/aAy17+vzrcEXZtfoP51NI4Lt/vNDX1TeA==
X-Received: by 2002:a9d:21ca:: with SMTP id s68mr9207777otb.164.1612225603782;
        Mon, 01 Feb 2021 16:26:43 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a28sm4555729ook.24.2021.02.01.16.26.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Feb 2021 16:26:43 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 1 Feb 2021 16:26:41 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Erik Rosen <erik.rosen@metormote.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>
Subject: Re: [PATCH 2/2] Remove unnecessary pmbus_clear_cache function call
Message-ID: <20210202002641.GA117591@roeck-us.net>
References: <20210201195929.1200-1-erik.rosen@metormote.com>
 <20210201195929.1200-3-erik.rosen@metormote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201195929.1200-3-erik.rosen@metormote.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 08:59:29PM +0100, Erik Rosen wrote:
> It is no longer necessary to clear the cache to update the sensor value
> from the chip.
> 
> Signed-off-by: Erik Rosen <erik.rosen@metormote.com>

Applied, after prepending subject with "hwmon: (pmbus/lm25066)".

Thanks,
Guenter

> ---
>  drivers/hwmon/pmbus/lm25066.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/lm25066.c b/drivers/hwmon/pmbus/lm25066.c
> index c75a6bf39641..e9a66fd9e144 100644
> --- a/drivers/hwmon/pmbus/lm25066.c
> +++ b/drivers/hwmon/pmbus/lm25066.c
> @@ -371,21 +371,18 @@ static int lm25066_write_word_data(struct i2c_client *client, int page, int reg,
>  	case PMBUS_VIN_OV_WARN_LIMIT:
>  		word = ((s16)word < 0) ? 0 : clamp_val(word, 0, data->rlimit);
>  		ret = pmbus_write_word_data(client, 0, reg, word);
> -		pmbus_clear_cache(client);
>  		break;
>  	case PMBUS_IIN_OC_WARN_LIMIT:
>  		word = ((s16)word < 0) ? 0 : clamp_val(word, 0, data->rlimit);
>  		ret = pmbus_write_word_data(client, 0,
>  					    LM25066_MFR_IIN_OC_WARN_LIMIT,
>  					    word);
> -		pmbus_clear_cache(client);
>  		break;
>  	case PMBUS_PIN_OP_WARN_LIMIT:
>  		word = ((s16)word < 0) ? 0 : clamp_val(word, 0, data->rlimit);
>  		ret = pmbus_write_word_data(client, 0,
>  					    LM25066_MFR_PIN_OP_WARN_LIMIT,
>  					    word);
> -		pmbus_clear_cache(client);
>  		break;
>  	case PMBUS_VIRT_VMON_UV_WARN_LIMIT:
>  		/* Adjust from VIN coefficients (for LM25056) */
> @@ -393,7 +390,6 @@ static int lm25066_write_word_data(struct i2c_client *client, int page, int reg,
>  		word = ((s16)word < 0) ? 0 : clamp_val(word, 0, data->rlimit);
>  		ret = pmbus_write_word_data(client, 0,
>  					    LM25056_VAUX_UV_WARN_LIMIT, word);
> -		pmbus_clear_cache(client);
>  		break;
>  	case PMBUS_VIRT_VMON_OV_WARN_LIMIT:
>  		/* Adjust from VIN coefficients (for LM25056) */
> @@ -401,7 +397,6 @@ static int lm25066_write_word_data(struct i2c_client *client, int page, int reg,
>  		word = ((s16)word < 0) ? 0 : clamp_val(word, 0, data->rlimit);
>  		ret = pmbus_write_word_data(client, 0,
>  					    LM25056_VAUX_OV_WARN_LIMIT, word);
> -		pmbus_clear_cache(client);
>  		break;
>  	case PMBUS_VIRT_RESET_PIN_HISTORY:
>  		ret = pmbus_write_byte(client, 0, LM25066_CLEAR_PIN_PEAK);
