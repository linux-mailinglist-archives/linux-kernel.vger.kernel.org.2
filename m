Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6534639B79F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 13:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbhFDLLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 07:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbhFDLLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 07:11:12 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45304C06174A;
        Fri,  4 Jun 2021 04:09:14 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id x2so4058642qvo.8;
        Fri, 04 Jun 2021 04:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q0r+GRAph5bUpYFzQZXDQRLPLpUfbf4qIs/RQtBMij8=;
        b=e8NJuAqElhWfOEuoNNRyav2xf1xrJtYq686taPh1fhF9kJj4Dk04la6vG6vzdarkoE
         HbmwtftAXFR8hEyCbRK06CfnZb3T8+9cJxD9xwBf8kEWeYjg1zyPd9f0e+lIZfJs4pId
         qKa9X1N5fh9Rch8TQrsULVUEvqGwy1yuCHnj6PUXEcpCAsYLD0VZ7enmnGiDNASQu3sK
         2+ZVWQvm0jE9rHRsgp+SGSLU0ekDgxZCynWbHXqBx05Z4XbKKg973Vk7fcXvDwmw4F3Z
         bEpBf6H+aRmtpMmR8dAkSAEi7ByMlBH8HdNROml30ZvrmYlTKC5Qdk6MTkPOMoAH/OSc
         nCRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Q0r+GRAph5bUpYFzQZXDQRLPLpUfbf4qIs/RQtBMij8=;
        b=KIVT2/9M7y/K22lAiN11ya13AXZRBaBgScmqOoCxIfbiQv0yLcgR2X5zR5ceNx2iWx
         ezoF0JGeqsrSSns3WLJs5UqmlDhJIkHx66mllSIMNC7JmPVjnMr5OgLuQBfqugFpRnF+
         tQYZmmfEL1o28ucQ/lnXh03zdq+alRD35eL5I3hdutu5ojp5CAC+qsoBXGMMPJypc5Iu
         qC3vYintCLoQpVs9k2wFV8/79OvSezBwlLQftz7AtDrpq6b2O19zUy6Izo6HxB+cedh0
         zkLsDgcKZs4gfsdV1aLBEek3NZRZfPpwWxMCT/tgGyRt9bP2D2lZ4XYa/ZtJvVv1OOjw
         8wjQ==
X-Gm-Message-State: AOAM530LO8qxZXPOCZ9UusNCofPi18pGRiQ4dgj8z8nRTP9wP2YBYx6F
        TdAcedOn0n/1tt8X/WsEFwg73H3yfW0=
X-Google-Smtp-Source: ABdhPJzmJO3LNJ969qbIz1eL5wExY27FreZIAZMfzw8RNzkD6sFyLhigqw9twR3/ra2xgevX+IZf4Q==
X-Received: by 2002:a0c:9c0f:: with SMTP id v15mr4231435qve.24.1622804952598;
        Fri, 04 Jun 2021 04:09:12 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m10sm3390312qtq.62.2021.06.04.04.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 04:09:12 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 4 Jun 2021 04:09:10 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Riwen Lu <luriwen@kylinos.cn>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xin Chen <chenxin@kylinos.cn>
Subject: Re: [PATCH v3] hwmon: (scpi-hwmon) shows the negative temperature
 properly
Message-ID: <20210604110910.GA1446504@roeck-us.net>
References: <20210604030959.736379-1-luriwen@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604030959.736379-1-luriwen@kylinos.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2021 at 11:09:59AM +0800, Riwen Lu wrote:
> The scpi hwmon shows the sub-zero temperature in an unsigned integer,
> which would confuse the users when the machine works in low temperature
> environment. This shows the sub-zero temperature in an signed value and
> users can get it properly from sensors.
> 
> Signed-off-by: Riwen Lu <luriwen@kylinos.cn>
> Tested-by: Xin Chen <chenxin@kylinos.cn>

Applied.

Thanks,
Guenter

> ---
> Changes since v1:
> - Add judgment for sensor->info.class. If it is TEMPERATURE situation,
>   return the sensor value as a signed value, otherwise return it as a
>   unsigned value.
> 
> Changes since v2:
> - Add a typecast u64 to s64 when it is a temperature value.
> - Add a comment ahead of the if statement.
> - Remove the unnecessary 'else' statement.
> ---
>  drivers/hwmon/scpi-hwmon.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/hwmon/scpi-hwmon.c b/drivers/hwmon/scpi-hwmon.c
> index 25aac40f2764..919877970ae3 100644
> --- a/drivers/hwmon/scpi-hwmon.c
> +++ b/drivers/hwmon/scpi-hwmon.c
> @@ -99,6 +99,15 @@ scpi_show_sensor(struct device *dev, struct device_attribute *attr, char *buf)
>  
>  	scpi_scale_reading(&value, sensor);
>  
> +	/*
> +	 * Temperature sensor values are treated as signed values based on
> +	 * observation even though that is not explicitly specified, and
> +	 * because an unsigned u64 temperature does not really make practical
> +	 * sense especially when the temperature is below zero degrees Celsius.
> +	 */
> +	if (sensor->info.class == TEMPERATURE)
> +		return sprintf(buf, "%lld\n", (s64)value);
> +
>  	return sprintf(buf, "%llu\n", value);
>  }
>  
