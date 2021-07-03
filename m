Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9433E3BA9D0
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jul 2021 19:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhGCR2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jul 2021 13:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhGCR2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jul 2021 13:28:44 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8E8C061762
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jul 2021 10:26:10 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id u11so15561097oiv.1
        for <linux-kernel@vger.kernel.org>; Sat, 03 Jul 2021 10:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ntrdXoUnRsaJbvopMZjndYtHLvb7fmdkPnczq42fWHQ=;
        b=L9PNt0QIYb09GdqPpUNIgRTIBn8uUQX6k7NVA3DE1XT1xsbtgd/WVMIARyS9HpAtnS
         30d3LndMMnzXUWepD+5YsiEIyktXWwgnIcEsVqRyt79CFw3wp+ejkhECwD+rdUU1zBz9
         3dF7GmZyfJVbh8TiNiAFwVxZp16mwkS+lCutORJ/KOTY2StSHFawBynJxWqx4HH6G2x8
         +jsPix+uZ6ORnfd+xZcs/wfwHEHO3jM+Xgrgx+09wjcrOk2XUsWO8u1g7zqIo2BHRxgG
         q55+0lenZRxVfKTNyT4FebXDfhExkqptoIEKHCDGjEz/mU2nEHtWYVWHB1afDfaajlAD
         11Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ntrdXoUnRsaJbvopMZjndYtHLvb7fmdkPnczq42fWHQ=;
        b=Hx71sxCfKf2pxZ4uGAMsfiMQ3WN7KjRTtdyJI7aFW4wnp9iZx1ta0e5YToUlbsA8Wc
         oWpjZD+r+0pBOlbZTOF5V6GYdJDfYVsGas/szVvzKOIstQjMP6uT2+s2aXOWTPht1zc8
         CF8YTSltIIKLwlSBR8M3D/1Y7JWAf/iGkFszKo+fR/4nNJ/9Z0iXbKfKE7LnrPMOSPwj
         nxdzOw6uReFcPKLKk6z4zXWsBLxzta39XPJEcGxp+AWOxyzOmQcAeqbcGY2et2wlE6DV
         usVQKF7jFx8gtEHKJRF5xC2Vx6LMd90wrJtqQTUdQ9Lt26uCFOdClAWBM1hHGyG4Qo/+
         CVdw==
X-Gm-Message-State: AOAM530+FmIrk1Dm4ELeYa01dMH77MaIEpCO8nVm20xr2VLyt170Uun3
        18iDW/pHA4G3VGOku81lquo=
X-Google-Smtp-Source: ABdhPJwgzhlOdZO7WyJ7Mjyp5s6uc9BM0e6v3VNydi2hmunRH4+jI4CS7fwofWQ3VVqdEww4+19erw==
X-Received: by 2002:a05:6808:8a:: with SMTP id s10mr4453972oic.70.1625333169468;
        Sat, 03 Jul 2021 10:26:09 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o45sm1350377ota.59.2021.07.03.10.26.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Jul 2021 10:26:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] mtd: core: handle flashes without OTP gracefully
To:     Tudor.Ambarus@microchip.com, michael@walle.cc,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
References: <20210702093841.32307-1-michael@walle.cc>
 <9bb2acac-aeb8-d2b2-8df0-9acfd972ec5d@microchip.com>
 <9F46D75C-D00D-4577-A337-7411049EC7D9@walle.cc>
 <8da3d84e-dfbf-2030-98b4-148362d22f52@microchip.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <2716acf0-fcf1-d2ef-83be-152d0300d687@roeck-us.net>
Date:   Sat, 3 Jul 2021 10:26:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <8da3d84e-dfbf-2030-98b4-148362d22f52@microchip.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/3/21 9:42 AM, Tudor.Ambarus@microchip.com wrote:
> On 7/3/21 7:08 PM, Michael Walle wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> Am 3. Juli 2021 11:56:14 MESZ schrieb Tudor.Ambarus@microchip.com:
>>> On 7/2/21 12:38 PM, Michael Walle wrote:
>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you
>>> know the content is safe
>>>>
>>>> There are flash drivers which registers the OTP callbacks although
>>> the
>>>> flash doesn't support OTP regions and return -ENODATA for these
>>>> callbacks if there is no OTP. If this happens, the probe of the whole
>>>
>>> why do they register the OTP callback if they don't support OTP?
>>
>> I don't know. But I certainly won't touch that code :p
> 
> why? :D
> 
>>
>>
>>>> flash will fail. Fix it by handling the ENODATA return code and skip
>>>> the OTP region nvmem setup.
>>>>
>>>> Fixes: 4b361cfa8624 ("mtd: core: add OTP nvmem provider support")
>>>> Reported-by: Guenter Roeck <linux@roeck-us.net>
>>>> Signed-off-by: Michael Walle <michael@walle.cc>
>>>> ---
>>>>   drivers/mtd/mtdcore.c | 10 ++++++++--
>>>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
>>>> index b5ccd3037788..6881d1423dd6 100644
>>>> --- a/drivers/mtd/mtdcore.c
>>>> +++ b/drivers/mtd/mtdcore.c
>>>> @@ -880,7 +880,10 @@ static int mtd_otp_nvmem_add(struct mtd_info
>>> *mtd)
>>>>
>>>>          if (mtd->_get_user_prot_info && mtd->_read_user_prot_reg) {
>>>>                  size = mtd_otp_size(mtd, true);
>>>> -               if (size < 0)
>>>> +               /* ENODATA means there is no OTP region */
>>>> +               if (size == -ENODATA)
>>>
>>> If no OTP data, maybe it's more appropriate for the clients to just
>>> return a retlen of 0.
>>
>> you mean already checking ENODATA in mtd_otp_size() and return 0. That would also make the hunk below unnecessary. I'll change it.
> 
> I've thought about:
> 
> diff --git a/drivers/mtd/chips/cfi_cmdset_0001.c b/drivers/mtd/chips/cfi_cmdset_0001.c
> index 54f92d09d9cf..9419b33d7238 100644
> --- a/drivers/mtd/chips/cfi_cmdset_0001.c
> +++ b/drivers/mtd/chips/cfi_cmdset_0001.c
> @@ -2314,7 +2314,7 @@ static int cfi_intelext_otp_walk(struct mtd_info *mtd, loff_t from, size_t len,
>   
>          /* Check that we actually have some OTP registers */
>          if (!extp || !(extp->FeatureSupport & 64) || !extp->NumProtectionFields)
> -               return -ENODATA;
> +               return 0;
> 

There are various places where this is called, including code returning information
to userspace. That means you'd be changing the ABI to userspace which would now suddenly
return 0 instead of -ENODATA.

Guenter
