Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7523DF3DE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 19:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238175AbhHCRYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 13:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231917AbhHCRWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 13:22:24 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A83C061757;
        Tue,  3 Aug 2021 10:22:11 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id c16so26103679wrp.13;
        Tue, 03 Aug 2021 10:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rh7kYX8JSIfHSU82GQGBlTx9jv9gtawtP+lEL1sk9Lo=;
        b=UKwpk6d0zQ4GYpCUvFzsnvz8OcwyYKVTVJUK+F56e6QQe/JGgR1A40vlRWTckct1tJ
         wOZg4SDNfMJxOLj7Dp0ruEkVr7lpavQG48V1bDzWhMj6L9epjYgRn5l/Wi6vdSM/JKjI
         dOT9CpQHqJZB+Z1Z2FlTbQ57r8lzQoW2UxaTv8Y7Sr9+Q32aTtbLbGQXPRcHCIL1P1cB
         faOCUVK8fQX9ibbbGhjcKgRIavpcT7TeJIqWccMp4CK/eo2LjPbifD/z+M2kh4dT0E/Y
         MVJO6Rmvnp9daNa9AVAygPLVdtWkOM6q13nn7JupcY5SGbuTzMnahDL6jUCaRIMSYy3k
         QoUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rh7kYX8JSIfHSU82GQGBlTx9jv9gtawtP+lEL1sk9Lo=;
        b=AhoPlmFhVSxGxgKBGwvyE6jODn1KsUJ6dD5b+1PWKO9+r7AByudVQsdQPe/MMEYaev
         2QaI9wICWBkZM8fjXiAs9nekCu8DP3Sfl/2TMeIR5I2hZa6D4o2vsmS2GheY4+at2Wtn
         Zkm202+T+4n6Eaq70vRGDHo1bkJ0pEwkNEUZq3+N7sCVu2n6DIQQhv0/n8VeyLEq1MXg
         PXAfOsjsKufipkR7rxqkyMSGYz9IEnA5XbMzQqEi+83YDPaLHUhaSVfNtQCOeCpwes8p
         o0f7bz2JLkgz8hdD32ACXOyrWCkrWHDNFFnL6naDAF78czpMKj/w2tMobZK1uv2/zsuD
         OqdQ==
X-Gm-Message-State: AOAM530q4s8nbkE1F21P/WD7OzImQH/aoTAPHE12A+ceTR5RzAlxdu1o
        52HtPw9M65vy0asey4D4ABN1xaRx6EM=
X-Google-Smtp-Source: ABdhPJwdQwBB0trNzwI4Yr5uF06664aYkaKsUEx3z6JHHv/7VxxtMNrvXhgKMOfYgIdzDKPLNIeZcA==
X-Received: by 2002:a5d:5381:: with SMTP id d1mr6359413wrv.418.1628011330383;
        Tue, 03 Aug 2021 10:22:10 -0700 (PDT)
Received: from [192.168.2.202] (pd9e5a13a.dip0.t-ipconnect.de. [217.229.161.58])
        by smtp.gmail.com with ESMTPSA id 9sm13741150wmf.34.2021.08.03.10.22.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Aug 2021 10:22:10 -0700 (PDT)
Subject: Re: [PATCH v1 1/1] platform/surface: surface3_power: Use
 i2c_acpi_get_i2c_resource() helper
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>
References: <20210803163252.60141-1-andriy.shevchenko@linux.intel.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <70acc714-ceda-47c2-523e-c58a814b0156@gmail.com>
Date:   Tue, 3 Aug 2021 19:22:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210803163252.60141-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/21 6:32 PM, Andy Shevchenko wrote:
> ACPI provides a generic helper to get I²C Serial Bus resources.
> Use it instead of open coded variant.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Looks good to me, thanks!

Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>

> ---
>   drivers/platform/surface/surface3_power.c | 8 +-------
>   1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/platform/surface/surface3_power.c b/drivers/platform/surface/surface3_power.c
> index dea82aa1abd4..90c1568ea4e0 100644
> --- a/drivers/platform/surface/surface3_power.c
> +++ b/drivers/platform/surface/surface3_power.c
> @@ -384,13 +384,7 @@ mshw0011_space_handler(u32 function, acpi_physical_address command,
>   	if (ACPI_FAILURE(ret))
>   		return ret;
>   
> -	if (!value64 || ares->type != ACPI_RESOURCE_TYPE_SERIAL_BUS) {
> -		ret = AE_BAD_PARAMETER;
> -		goto err;
> -	}
> -
> -	sb = &ares->data.i2c_serial_bus;
> -	if (sb->type != ACPI_RESOURCE_SERIAL_TYPE_I2C) {
> +	if (!value64 || !i2c_acpi_get_i2c_resource(ares, &sb)) {
>   		ret = AE_BAD_PARAMETER;
>   		goto err;
>   	}
> 
