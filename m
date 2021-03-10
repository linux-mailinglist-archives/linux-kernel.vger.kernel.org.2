Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A21353334A2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 05:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbhCJE7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 23:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhCJE7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 23:59:12 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095C5C06174A;
        Tue,  9 Mar 2021 20:59:12 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id r24so7087128otp.12;
        Tue, 09 Mar 2021 20:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/A04zYDVrvZKAdwk2TviXEHfLp2svSYTpqBzbd7KuIg=;
        b=Rzh6PGQGo/EeLXQGVtFlqMDTWunadvOQSO+hEZgUPfZnyAOf5Z7GMhegkG0+6ed+Ek
         NMotNGYh0HEZXX+9vVceb+AsJiR1038phGifgLzcQF6Nc7YMdiD69Iwm1oHqPGkc+qea
         0b2J22wfXqYJLoNjj4ENE6/RfxBYU+1khiSUsOCF03o/TglRnK8MjpqGCr38Qxu9ppVN
         6QFiibU6u1HrtWZIJz4nXolp1c6/F7aeOvnM1UdljCmXdJZh20DFlnstcFPVZLMFFjbl
         YmozlFc+VDj3CktnYmcABy43fs/y3dv2k0/dH+J5rqxzAxD/cUNJ375Rnp8YtZgqhYYs
         aE7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=/A04zYDVrvZKAdwk2TviXEHfLp2svSYTpqBzbd7KuIg=;
        b=UtlwySTIO+Y0ZAw6sLccgrNFRsgrF9oTMbsdTSBJYXiCYEHpOy1S7dLfszxE7FYp8/
         6/OTC9B+ao04zoTz+ucGnhsw2aOX/mdVJYWdWPEdNxR49O7tq52y/XP+GoDjXUkdoaHR
         F0mri845Ep4CSXDuRUHD6/3iP4Y3ss7SpGZ3QmuKQG4F6BlAdSwc2BYoE7mZv9RJLK1z
         E+2NQUd9RyYaeRohBD0102aDt8yt+z/E4REHZ2ul04eq7bC7neKxIo8WOdBqDCASlUWB
         ci8XISjFo33YQHu4Moul21D7o2AC1LU8Zwe+4AuDgIhzg7KbqyYaopi6ppX7bwGRs1S9
         h7SA==
X-Gm-Message-State: AOAM530r0+gTo4WwByO/t3KMAFjUuWq8PD5+AwRipdg7CaLJFgXPPiji
        BX4RTbXWadkeoeqaSNTsnFRkxfFBdbg=
X-Google-Smtp-Source: ABdhPJx69h3F4vyivy9c5yBM2VZwX+OrCP1UrLoj24/qONdFJ8MS+/fuPdJOTxOeD1XcyEcyNm7YQg==
X-Received: by 2002:a9d:6013:: with SMTP id h19mr1335450otj.72.1615352351113;
        Tue, 09 Mar 2021 20:59:11 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n22sm1169984oie.32.2021.03.09.20.59.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 20:59:09 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] hwmon: (adm9240): Don't re-read config/limits
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        jdelvare@suse.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210310033618.29354-1-chris.packham@alliedtelesis.co.nz>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <7b90ff0c-6772-6ecf-d15d-ff5ff09c5628@roeck-us.net>
Date:   Tue, 9 Mar 2021 20:59:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210310033618.29354-1-chris.packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/21 7:36 PM, Chris Packham wrote:
> The hwmon chip is configured either via sysfs or by an earlier boot
> stage (e.g. bootloader/bios). In the sysfs case we already store the
> configuration values before it's written to the device. Reading in the
> configuration only needs to be done once at probe time to cover the
> second case.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> 
> This doesn't resolve my ongoing i2c issues[0] but avoiding unnecessary
> i2c reads will help a bit (it'll certainly avoid errors where the
> threshold spontaneously changes).
> 
> [0] - https://lore.kernel.org/lkml/8e0a88ba-01e9-9bc1-c78b-20f26ce27d12@alliedtelesis.co.nz/
> 
>  drivers/hwmon/adm9240.c | 25 +++++++++++--------------
>  1 file changed, 11 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/hwmon/adm9240.c b/drivers/hwmon/adm9240.c
> index cc3e0184e720..7e1258b20b35 100644
> --- a/drivers/hwmon/adm9240.c
> +++ b/drivers/hwmon/adm9240.c
> @@ -128,7 +128,6 @@ struct adm9240_data {
>  	struct mutex update_lock;
>  	char valid;
>  	unsigned long last_updated_measure;
> -	unsigned long last_updated_config;
>  
>  	u8 in[6];		/* ro	in0_input */
>  	u8 in_max[6];		/* rw	in0_max */
> @@ -282,21 +281,11 @@ static struct adm9240_data *adm9240_update_device(struct device *dev)
>  			return ERR_PTR(err);
>  		}
>  		data->last_updated_measure = jiffies;
> -	}
> -
> -	/* minimum config reading cycle: 300 seconds */
> -	if (time_after(jiffies, data->last_updated_config + (HZ * 300))
> -			|| !data->valid) {

This is a bit more invasive than desirable. Problem is that
it takes away the "!data->valid" part of the code as well,
and there may be valid reasons to re-read the limits after
an error.

I'd suggest to just drop the time_after and last_updated_config
and just check for data->valid. This also makes the change
in the probe function unnecessary.

I you _really_ want to make a difference, you could drop
caching from the driver entirely and let regmap handle it
(ie tell regmap which registers are hot). Caching isn't
really that valuable, and is often more expensive than
worth it.

Even better, of course, would be to convert the driver to
use devm_hwmon_device_register_with_info and drop all the
sysfs code from it. Or, rather, almost all of it, since we'd
have that non-standard aout_output attribute. Unfortunately,
neither of those changes would solve your problem.

> -		err = adm9240_update_config(data);
> -		if (err < 0) {
> -			data->valid = 0;
> -			mutex_unlock(&data->update_lock);
> -			return ERR_PTR(err);
> -		}
> -		data->last_updated_config = jiffies;
>  		data->valid = 1;
>  	}
> +
>  	mutex_unlock(&data->update_lock);
> +

Please refrain from making whitespace changes. You may prefer
the code that way, but next week I'll get someone else
submitting a different patch and removing the added empty lines.

>  	return data;
>  }
>  
> @@ -855,7 +844,15 @@ static int adm9240_probe(struct i2c_client *new_client)
>  							   new_client->name,
>  							   data,
>  							   adm9240_groups);
> -	return PTR_ERR_OR_ZERO(hwmon_dev);
> +	if (IS_ERR(hwmon_dev))
> +		return PTR_ERR(hwmon_dev);
> +
> +	/* pull in configuration from an earlier boot stage */
> +	err = adm9240_update_config(data);
> +	if (err < 0)
> +		return err;
> +
> +	return 0;

If at all, this call should be made before registering the hwmon device.

>  }
>  
>  static const struct i2c_device_id adm9240_id[] = {
> 

