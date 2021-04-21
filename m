Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5CA366D88
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 16:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243300AbhDUOEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 10:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243293AbhDUOES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 10:04:18 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6103BC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 07:03:45 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id c84-20020a4a4f570000b02901e9af00ac1bso3015068oob.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 07:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GD1hnsmKZVRHQ+AQoMqWi5eZfQBbXkPHnE2kAvpqSwY=;
        b=qi0BOBEMXoBBbghxFqYrT3AWG+wj/g3oaWA5k3/9R+xR+S5cKYBe6iRLWQlBOlBBdk
         pTRUsPQqA8YemRbG9xLFgjBKRB+4StmNqgti3K0UQevbV46pscsm6x8BoIt6h07c8mc3
         RYIF+0jt67fynHE4e0JniDvmRfz1a/DWXzYHgJG0yMB7Z7VxnPhLfCRcaPqIq9FLGF0x
         eLvp8NEIuCL+f1WbwQUejNSJWWGObixjBOuC3RPjuqFRxBBUavWYSdtXYh3DRARtC603
         7yttWbHsKzLSTn1k69cTQEWzHO0DNhBBiPMvbKg61Plby9xMwEG1vWw6986/k9IDbGYd
         onOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=GD1hnsmKZVRHQ+AQoMqWi5eZfQBbXkPHnE2kAvpqSwY=;
        b=swpjnL1Q7QszTrdp/DQnRbDkR0fJq3F6u+38VB5NPJriILtqbm43NYG14kwyRUO1IZ
         FixeVubx0Ou8T1qdtFRrhEqhfGlH+6JwmnWSzQK/hEtlwkDAVaPEEkn7LT5ip44Ms9o1
         FnqsAg5fhax45NnPWInaYinxpHgGZAYpg5IDPPFeAYNaLOERzfHi0WG3kVoQikeoQ09v
         XfNscUuWuBWrqseYtI4Z8QMAsd7nn8ao5z07xS9Tnk0CFu9KahDsOHN2ytfkcNv14Rnn
         KusYyRmFGEJx5PgYPNopUZFObz8gGbVE0okT6OfQRRxHD0rj3SvuwdwOoZiPngdTr3cx
         ctkA==
X-Gm-Message-State: AOAM5329DZxq3v6KKBriPdZSWRT5nXlNkmlnoN/unV/BaLIngpZGL/5g
        qjP0DbWy79qCwZ/+6XTLG38=
X-Google-Smtp-Source: ABdhPJxm986HsR2Q8rIM7gU/oC+S4QBD5U8W8juCeGz3KZ/Da6lBMIpJ3+xZ7JW62nToSpFH80UybA==
X-Received: by 2002:a05:6820:167:: with SMTP id k7mr2717493ood.31.1619013824747;
        Wed, 21 Apr 2021 07:03:44 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d17sm526393oth.19.2021.04.21.07.03.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Apr 2021 07:03:44 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 177/190] Revert "hwmon: (lm80) fix a missing check of bus
 read in lm80 probe"
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-178-gregkh@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <78ac6ee8-8e7c-bd4c-a3a7-5a90c7ccb399@roeck-us.net>
Date:   Wed, 21 Apr 2021 07:03:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210421130105.1226686-178-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/21 6:00 AM, Greg Kroah-Hartman wrote:
> This reverts commit 9aa3aa15f4c2f74f47afd6c5db4b420fadf3f315.
> 
> Commits from @umn.edu addresses have been found to be submitted in "bad
> faith" to try to test the kernel community's ability to review "known
> malicious" changes.  The result of these submissions can be found in a
> paper published at the 42nd IEEE Symposium on Security and Privacy
> entitled, "Open Source Insecurity: Stealthily Introducing
> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> of Minnesota) and Kangjie Lu (University of Minnesota).
> 
> Because of this, all submissions from this group must be reverted from
> the kernel tree and will need to be re-reviewed again to determine if
> they actually are a valid fix.  Until that work is complete, remove this
> change to ensure that no problems are being introduced into the
> codebase.
> 
> Cc: Kangjie Lu <kjlu@umn.edu>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Guenter Roeck <linux@roeck-us.net>

I don't immediately see a problem with this patch, but the other patch
introduced at the same time by the same author was indeed malicious,
and the bug it introduced was easy to overlook, so I agree that
this patch should be reverted.

[ When introducing error handling into this probe function, errors
  in lm80_init_client() should be addressed as well. This patch did
  not do that and thus had limited value anyway. ]

Thanks,
Guenter

> ---
>  drivers/hwmon/lm80.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/hwmon/lm80.c b/drivers/hwmon/lm80.c
> index ac4adb44b224..97ab491d2922 100644
> --- a/drivers/hwmon/lm80.c
> +++ b/drivers/hwmon/lm80.c
> @@ -596,7 +596,6 @@ static int lm80_probe(struct i2c_client *client)
>  	struct device *dev = &client->dev;
>  	struct device *hwmon_dev;
>  	struct lm80_data *data;
> -	int rv;
>  
>  	data = devm_kzalloc(dev, sizeof(struct lm80_data), GFP_KERNEL);
>  	if (!data)
> @@ -609,14 +608,8 @@ static int lm80_probe(struct i2c_client *client)
>  	lm80_init_client(client);
>  
>  	/* A few vars need to be filled upon startup */
> -	rv = lm80_read_value(client, LM80_REG_FAN_MIN(1));
> -	if (rv < 0)
> -		return rv;
> -	data->fan[f_min][0] = rv;
> -	rv = lm80_read_value(client, LM80_REG_FAN_MIN(2));
> -	if (rv < 0)
> -		return rv;
> -	data->fan[f_min][1] = rv;
> +	data->fan[f_min][0] = lm80_read_value(client, LM80_REG_FAN_MIN(1));
> +	data->fan[f_min][1] = lm80_read_value(client, LM80_REG_FAN_MIN(2));
>  
>  	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
>  							   data, lm80_groups);
> 

