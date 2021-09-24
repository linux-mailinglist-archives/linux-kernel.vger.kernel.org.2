Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5224169F6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 04:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243902AbhIXCXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 22:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbhIXCXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 22:23:16 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEACCC061574;
        Thu, 23 Sep 2021 19:21:43 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id w19so12464382oik.10;
        Thu, 23 Sep 2021 19:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Xd0enZ3Dz+wfy6N9+0u4kY6hIhtW0ddl520CyNutYtI=;
        b=nqx94ncBicifrSF5SJgQs/cXzBRfz24KlL2QKVTad+VNnTsYahe1PZZiMm1esVHb1O
         LjtDud97U0yJMgARTX5Ns76SVuHjNp9D5t2wmeKR3xOlYl3v5tj7655EEMp+and/iBSe
         jyC729MVK39zEqtZ3C1tu4ahPfHg0uqI59xfIjnM2YkN8enKGEcJyIvhAy42RBGXtZAG
         Kgb97q79SuDEbGUApikuT/37WLFKxJl7mnlKZbg5XoC71FyB8dJFJmznBAVVpKkAhx2E
         B9OWwOWOcjAl5x5uYIkNW74HCFgDEzN3GH92wmyuBN7hMVIYL5pBAc8VRC5wddC15Jua
         YJng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Xd0enZ3Dz+wfy6N9+0u4kY6hIhtW0ddl520CyNutYtI=;
        b=wx7CjvOBhQEr6MwGFWmqYEU9Y4fb/H6ZQz52moB/fVv5o+7n/NN2oxGlsKFCAiRbHM
         88T424u9o224G5UeUa1K19q/nPssuyU6z5iy//ScoFkYk0t0kSgZ2AQeU+9Gn8IQs4gh
         6t+tcIAgPv5d1mHj/X0Vtmeap0dkWs/qpUZQwwIUi8jaHA60GiWhRcUQsTq/YgOD+w9H
         CiNx8dKIfeOVH41g4G9jSQOn5I+yqPmfCHDjaNFc0f0HichwhhasPgww2qR5HvsKEkp1
         IVHe1+TMFqVgXEdTe+I2pKS5fZrHvegQ9g6O5VLzxiMiB2RoWL2HwP5WiiqXfHtwJx9X
         l2OQ==
X-Gm-Message-State: AOAM5338bqq4f5OnBVmCrXn9iXHleSB6Ky3ShWeR7sjKJr9KukBVEEif
        5LGbhhITZJcwMBS+z3auTqY=
X-Google-Smtp-Source: ABdhPJwg65svFgKrwPo5wBb217+AtT/0tRzoqCUOoTYF8eE2FOw24pamctyU/Zo3jftjWu5/4sQQ8A==
X-Received: by 2002:a54:4e84:: with SMTP id c4mr15604525oiy.106.1632450103335;
        Thu, 23 Sep 2021 19:21:43 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u12sm1776980otq.20.2021.09.23.19.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 19:21:42 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 23 Sep 2021 19:21:41 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Paul Fertser <fercerpav@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] hwmon: tmp421: fix rounding for negative values
Message-ID: <20210924022141.GA3032469@roeck-us.net>
References: <20210922155323.GA3205709@roeck-us.net>
 <20210923094801.23332-1-fercerpav@gmail.com>
 <20210923094801.23332-3-fercerpav@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210923094801.23332-3-fercerpav@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 12:48:01PM +0300, Paul Fertser wrote:
> Current code produces -24999 for 0b1110011100000000 input in standard
> format due to always rounding up rather than "away from zero". Use the
> common macro for division, unify and simplify the conversion code along
> the way.
> 
> Signed-off-by: Paul Fertser <fercerpav@gmail.com>

This patch should probably have a Fixes: tag.

Guenter

> ---
> 
> Changes from v1:
>  - Trivial rebase
> 
>  drivers/hwmon/tmp421.c | 24 ++++++++----------------
>  1 file changed, 8 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/hwmon/tmp421.c b/drivers/hwmon/tmp421.c
> index 9f0a4db695db..c77c9f3bbd21 100644
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
