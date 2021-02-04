Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43B5830B0AA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 20:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbhBAToi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 14:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbhBATn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 14:43:58 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144F7C061573;
        Mon,  1 Feb 2021 11:43:19 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id i20so17502362otl.7;
        Mon, 01 Feb 2021 11:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y//+Qjk7U+nxxH4pJH8VI7/PMh8BGaRDNtokq/e5Kz0=;
        b=ZyLPLUMSt7/6Mo/z08L3a+dzekGsdW+mIE8DrrlJ/30SvDY85NcZs25x7X7RjE2lDW
         HZE63pxMU2NnfQC6ech76z4leK2ipFcXFj4VIKbCTuxTJjScEaTkqgU6aopYvgZMgUJw
         EH2YsjVPHDFV2pi/ZYsf3yCHg4K+AC1lTaTThKIOucNtCWqFbZfE3NKThMWXZYdpsOJv
         r7pM87wr+WpvYzQXxFn0TkjD1QJL8Xxb/wN0v0askePUoPOjKEfFJNl88FN69KglyzQE
         eEEunLp3oa/+20WG1YhX9ssZHWiNngPMh0d4V1qd5VoioCHaqOI8riV+Fuc4GUliUqWv
         Z27w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=y//+Qjk7U+nxxH4pJH8VI7/PMh8BGaRDNtokq/e5Kz0=;
        b=kSf9Fx8+L6yPY06kgINp5GiN1gIQxiFoev1G7kPE2XNaUfpYRCPeng2CiECFwvo1jK
         +XGsHKnNR32PZYUuniniNaiYaTtBXSpo992up+hvXUT3+JjawYsCD2Ly/rGO3h2yF/st
         g1bPPSM8+v/GOywm8Q3t65GzWq2o4IE6yE3EDu7UQd5Z0U0twNHFr1hS0Lb6FpxJRBBM
         7TV3TgQWWEtB6v7Ybcx1vBWvUlC3gkKsLAjtH2I7NRDjTWWvOsxY17rO46t2uyKx04+j
         qaOEE2qDEgZNUPXJLmuJMuChy5vLdR/aYMlBohDE+MZhqxX+L4oth4c7CCwdeeD1xA7+
         NdQw==
X-Gm-Message-State: AOAM533JwV9fpMjQFn/6d2mRhaYZ7JZYvIghThy1XOQbqTaqbvknNN/v
        8OIEIcuQUlbkRcOXYYAdxc5bcEHE5VM=
X-Google-Smtp-Source: ABdhPJwqnA0Tv/pGzc7UWdSSggRrgTsvhAqPHbGjW8enxN1PbsmhFbuOOkmkFdwWHONBAI+HqTBSaA==
X-Received: by 2002:a9d:4786:: with SMTP id b6mr12554196otf.269.1612208598490;
        Mon, 01 Feb 2021 11:43:18 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l11sm4092957otf.59.2021.02.01.11.43.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Feb 2021 11:43:17 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] pmbus:max31785: Support revision "B"
To:     Matthew Barth <msbarth@linux.ibm.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, jdelvare@suse.com
Cc:     joel@jms.id.au, andrew@aj.id.au
References: <20210201165043.36751-1-msbarth@linux.ibm.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <96fd0466-13be-dea1-985c-19cccbd3d321@roeck-us.net>
Date:   Mon, 1 Feb 2021 11:43:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210201165043.36751-1-msbarth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/21 8:50 AM, Matthew Barth wrote:
> There was an issue in how the tach feedbacks of dual rotor fans were
> reported during any change in fan speeds with revision "A" of the
> MAX31785. When the fan speeds would transition to a new target speed,
> the rotor not wired to the TACH input when TACHSEL = 0 would report a
> speed of 0 until the new target was reached. This has been fixed,
> resulting in a revision "B" update where the MFR_REVISION of "B" is
> 0x3061.
> 

Is that published somewhere ?

> Signed-off-by: Matthew Barth <msbarth@linux.ibm.com>
> ---
>  drivers/hwmon/pmbus/max31785.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/pmbus/max31785.c b/drivers/hwmon/pmbus/max31785.c
> index e5a9f4019cd5..e636a65061df 100644
> --- a/drivers/hwmon/pmbus/max31785.c
> +++ b/drivers/hwmon/pmbus/max31785.c
> @@ -17,6 +17,7 @@ enum max31785_regs {
>  
>  #define MAX31785			0x3030
>  #define MAX31785A			0x3040
> +#define MAX31785B			0x3061
>  
>  #define MFR_FAN_CONFIG_DUAL_TACH	BIT(12)
>  
> @@ -350,12 +351,13 @@ static int max31785_probe(struct i2c_client *client)
>  	if (ret < 0)
>  		return ret;
>  
> -	if (ret == MAX31785A) {
> +	if (ret == MAX31785A || ret == MAX31785B) {
>  		dual_tach = true;
>  	} else if (ret == MAX31785) {
>  		if (!strcmp("max31785a", client->name))

Probably also wants to check for max31785b,

>  			dev_warn(dev, "Expected max3175a, found max31785: cannot provide secondary tachometer readings\n");

and say something like "Expected max3175a/b, ..."

Thanks,
Guenter

>  	} else {
> +		dev_err(dev, "Unrecognized MAX31785 revision: %x\n", ret);
>  		return -ENODEV;
>  	}
>  
> @@ -371,6 +373,7 @@ static int max31785_probe(struct i2c_client *client)
>  static const struct i2c_device_id max31785_id[] = {
>  	{ "max31785", 0 },
>  	{ "max31785a", 0 },
> +	{ "max31785b", 0 },
>  	{ },
>  };
>  
> @@ -379,6 +382,7 @@ MODULE_DEVICE_TABLE(i2c, max31785_id);
>  static const struct of_device_id max31785_of_match[] = {
>  	{ .compatible = "maxim,max31785" },
>  	{ .compatible = "maxim,max31785a" },
> +	{ .compatible = "maxim,max31785b" },
>  	{ },
>  };
>  
> 

