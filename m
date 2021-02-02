Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A18EB30B422
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 01:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbhBBA3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 19:29:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbhBBA3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 19:29:03 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6250BC06174A;
        Mon,  1 Feb 2021 16:28:23 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id i30so18228014ota.6;
        Mon, 01 Feb 2021 16:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y0/tz3bwluGIB09Z585C0g+gvRIr+Sy9rNIwj+11+ZY=;
        b=A0WhcgThJ1Cu7w7f2hDPbF9aN9P5om8Sbq9vBKZ9XftkjgB0pWH7urvwQjLGCdkyUO
         HJyUnrseM+NaRH4+92biPnjG6YTUgXbkDRHahDJMJ+BI1RA7pFM0k5irgP3jEHMolRec
         5La70FzztmyHNnBiKMYjVBJjGgEPGZgbLb+qsmQfZr1HxuWpOoRVFNzBPsXWbmbOqRyN
         uo3tY6WnwCESjFLgQAcaH+xt59a5mVnGs2kAhxwNU69jTIQg/nV5UEzKXQmaHVMBq7b0
         MAG5hrlQwaWicUZblbGyWeaFMlSoiKLrxjjSMAnGFWeo18ptsOAZ/OEHf/r9/3Ffdcnf
         lzog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=y0/tz3bwluGIB09Z585C0g+gvRIr+Sy9rNIwj+11+ZY=;
        b=hcCDYnvXeXEtFIKw1lfb1OTgLBWW+wsa7S9FvuFbbYXjHENhrC7s73MtYXByS9lrW3
         MeI+P4eCD0pVvlODzGUBK1qblgtvJkc7kFR+++D7w1sr7hnj4xqTswigYOy0sTw7Jauv
         yDYMJQnZj6agQAFaev7pUWGuHr+/ur9YsAE0bSCeUPeO9rQpEjITRDWuMwEuA1dG90aJ
         vhcYlBGaoH9d5vxxohxabJuD2BxbaLCtXbno48V5x1pIBda2Sg+PfjObm1eOiBJlyA7y
         vnjiiESanI+dMXQobyDjDtpnNzvX0Hpnq8dNR1dFbIKN2KGUjQNIQYc1+4szfpZS1uW6
         p3/A==
X-Gm-Message-State: AOAM530Zq/0aIj8QAIntA1fmURcm6/jpFuulW5HCx93nbXWyPGKBSJ2F
        UJw8+nzIwk6PdQ+jfe85Aekho6i6K2I=
X-Google-Smtp-Source: ABdhPJxDQcpfkbmXfrCm9NbFTRMLheE/6Pw2pufYdw1Yo4HrrYCQWUDSHfDwVxeIXx1vKc/nfCHAxA==
X-Received: by 2002:a05:6830:1358:: with SMTP id r24mr13141370otq.320.1612225702857;
        Mon, 01 Feb 2021 16:28:22 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x31sm4257931otb.4.2021.02.01.16.28.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Feb 2021 16:28:22 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 1 Feb 2021 16:28:20 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Matthew Barth <msbarth@linux.ibm.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        jdelvare@suse.com, joel@jms.id.au, andrew@aj.id.au
Subject: Re: [PATCH v2] pmbus:max31785: Support revision "B"
Message-ID: <20210202002820.GA117769@roeck-us.net>
References: <20210201212217.73721-1-msbarth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201212217.73721-1-msbarth@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 03:22:17PM -0600, Matthew Barth wrote:
> There was an issue in how the tach feedbacks of dual rotor fans were
> reported during any change in fan speeds with revision "A" of the
> MAX31785. When the fan speeds would transition to a new target speed,
> the rotor not wired to the TACH input when TACHSEL = 0 would report a
> speed of 0 until the new target was reached. This has been fixed,
> resulting in a revision "B" update where the MFR_REVISION of "B" is
> 0x3061.
> 
> Signed-off-by: Matthew Barth <msbarth@linux.ibm.com>

Applied.

Thanks,
Guenter

> ---
> ChangeLog v1->v2:
> - Check for expected "max31785b" when MAX31785 single tach only found
> ---
>  drivers/hwmon/pmbus/max31785.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/max31785.c b/drivers/hwmon/pmbus/max31785.c
> index e5a9f4019cd5..30954c89e312 100644
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
> @@ -350,12 +351,14 @@ static int max31785_probe(struct i2c_client *client)
>  	if (ret < 0)
>  		return ret;
>  
> -	if (ret == MAX31785A) {
> +	if (ret == MAX31785A || ret == MAX31785B) {
>  		dual_tach = true;
>  	} else if (ret == MAX31785) {
> -		if (!strcmp("max31785a", client->name))
> -			dev_warn(dev, "Expected max3175a, found max31785: cannot provide secondary tachometer readings\n");
> +		if (!strcmp("max31785a", client->name) ||
> +		    !strcmp("max31785b", client->name))
> +			dev_warn(dev, "Expected max31785a/b, found max31785: cannot provide secondary tachometer readings\n");
>  	} else {
> +		dev_err(dev, "Unrecognized MAX31785 revision: %x\n", ret);
>  		return -ENODEV;
>  	}
>  
> @@ -371,6 +374,7 @@ static int max31785_probe(struct i2c_client *client)
>  static const struct i2c_device_id max31785_id[] = {
>  	{ "max31785", 0 },
>  	{ "max31785a", 0 },
> +	{ "max31785b", 0 },
>  	{ },
>  };
>  
> @@ -379,6 +383,7 @@ MODULE_DEVICE_TABLE(i2c, max31785_id);
>  static const struct of_device_id max31785_of_match[] = {
>  	{ .compatible = "maxim,max31785" },
>  	{ .compatible = "maxim,max31785a" },
> +	{ .compatible = "maxim,max31785b" },
>  	{ },
>  };
>  
