Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB4245806B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 22:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235454AbhKTVLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 16:11:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234879AbhKTVLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 16:11:19 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE41AC061574;
        Sat, 20 Nov 2021 13:08:15 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id h16-20020a9d7990000000b0055c7ae44dd2so22404886otm.10;
        Sat, 20 Nov 2021 13:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EGzBIS8YcmZkggi1HZxJDBiWMaVvrZf9iB+lDd3ba20=;
        b=iNV3Foyh1pATT8jRoBtXQDaL9Id6zaD6t5esFATAn2qW4zzayYBF0wUQkbe0ySVLxd
         YpoiJaj9z5sLfbpYCFTTWJIfh7Nd72M0DbiVQ3Dm6ZlFpKeY7wR8ZxmxvkLEZpoRB7vL
         MLRHOA2Abt1JA43FVs/cLjrl5Slt2PqGzIJ3nXTKiIxirdMMkHmVBQ+C1vMKzBsNEMC0
         Xn3TSABY7CgQRGIcjxAF7lRLCOSYQQBJUJZ1+HUa+MO56XQFrwsmJ/0L2yA3FmK5pHSm
         IrR0Vkd7oqA/2/klAL9k1CFw7fK3KvBEDRNQOb2U/l9PKneA/iXFXkV+b5k42IChYTrx
         7/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EGzBIS8YcmZkggi1HZxJDBiWMaVvrZf9iB+lDd3ba20=;
        b=XfcE5qycOWXtDoyKqWbi3T4/YZiiH43UwKvvD7iHfQRwSaL9XPV0SWHi3lHTpzgqNz
         3+JHJP6b9wTcFdsbfqd8UdkWU1lwPg5cHHwgMrFHPWKR3btSoTDRhdVbBdafO7KWTdNz
         csDFhajjPo/oVix94Jy1U6y7R3ZAD7f4CSogZn/T+TVjtXs2woGe4KOS9qK2+Lge54Gp
         DJJxPaahh1uD50ARqp7xy/eC8eANAjhdjsmBjZ997sabsv077sboO0+BqBRQOGVz7ZvT
         7ETM+65uGpmLYoJ+OKnw4wayQLyRCTXyernbvjvpiO7qmvlrUaLJqZAiaRgWvIs3p+nU
         Ny5A==
X-Gm-Message-State: AOAM5300IzBdQ8snk8OVcKo+H8wKd1+HZvxRrYxhXtOIpo8MrVddfbTd
        HytVF2HGUpGQKvHYk9tbh+alYMJv/mw=
X-Google-Smtp-Source: ABdhPJwVaCQTmLtgCGgxYl7gzPMaUuWBz4EDxS7uVyJTRDfU5518V2cbqpUWxJ2fypO+XA7oNkBgqA==
X-Received: by 2002:a05:6830:1107:: with SMTP id w7mr13863789otq.20.1637442494846;
        Sat, 20 Nov 2021 13:08:14 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h6sm748264otb.60.2021.11.20.13.08.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Nov 2021 13:08:14 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v2 1/2] hwmon: (sht4x) Fix EREMOTEIO errors
To:     David Mosberger-Tang <davidm@egauge.net>,
        Navin Sankar Velliangiri <navin@linumiz.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211120204053.2299501-1-davidm@egauge.net>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <f25f8dce-2b65-e98a-349d-220f79473ee2@roeck-us.net>
Date:   Sat, 20 Nov 2021 13:08:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211120204053.2299501-1-davidm@egauge.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/21 12:40 PM, David Mosberger-Tang wrote:
> Per datasheet, SHT4x may need up to 8.2ms for a "high repeatability"
> measurement to complete.  Attempting to read the result too early
> triggers a NAK which then causes an EREMOTEIO error.
> 
> This behavior has been confirmed with a logic analyzer while running
> the I2C bus at only 40kHz.  The low frequency precludes any
> signal-integrity issues, which was also confirmed by the absence of
> any CRC8 errors.  In this configuration, a NAK occurred on any read
> that followed the measurement command within less than 8.2ms.
> 
> Signed-off-by: David Mosberger-Tang <davidm@egauge.net>

You sent v2 after 5 minutes, and there is no change log.
Please never do that, and always provide a change log.

Guenter

> ---
>   drivers/hwmon/sht4x.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/sht4x.c b/drivers/hwmon/sht4x.c
> index 09c2a0b06444..3415d7a0e0fc 100644
> --- a/drivers/hwmon/sht4x.c
> +++ b/drivers/hwmon/sht4x.c
> @@ -23,7 +23,7 @@
>   /*
>    * I2C command delays (in microseconds)
>    */
> -#define SHT4X_MEAS_DELAY	1000
> +#define SHT4X_MEAS_DELAY_HPM	8200	/* see t_MEAS,h in datasheet */
>   #define SHT4X_DELAY_EXTRA	10000
>   
>   /*
> @@ -90,7 +90,7 @@ static int sht4x_read_values(struct sht4x_data *data)
>   	if (ret < 0)
>   		goto unlock;
>   
> -	usleep_range(SHT4X_MEAS_DELAY, SHT4X_MEAS_DELAY + SHT4X_DELAY_EXTRA);
> +	usleep_range(SHT4X_MEAS_DELAY_HPM, SHT4X_MEAS_DELAY_HPM + SHT4X_DELAY_EXTRA);
>   
>   	ret = i2c_master_recv(client, raw_data, SHT4X_RESPONSE_LENGTH);
>   	if (ret != SHT4X_RESPONSE_LENGTH) {
> 

