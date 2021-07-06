Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C81FF3BDD13
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 20:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbhGFSZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 14:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbhGFSZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 14:25:19 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6E4C061574
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jul 2021 11:22:40 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id l17-20020a9d6a910000b029048a51f0bc3cso10749470otq.13
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 11:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OK8/u6FR6IpmADEYbANCYO9TQlI0qE21fTDfkShK+ww=;
        b=i2uwcoMcfmddzZeAHZK1nfTlzTrcH3Xa0nFzzRahmaAfnFbZ68H1NXl7/68l7dEhM3
         RL8FkYrZANRxwovACIlM2R3e1/MjAAIMfE9j8tCNZk7dABUspRv6crMr60ddwmIPY8is
         Q2DruqlbI4mA+yQxIGeRMloOxy3Y8SbM3f8rm9UflLj3/nFp724kbXxYscvaX166X8hC
         Xcvdf/qNTBIXFRlu8+Nof/UF6+rFu/j1Xdv4hyiduIjZVtdd1UBSgaTCw6lCn1hvkQA5
         DEEYYhnOaKQz9hTKpSbIQOnesyFVkzOreospuF8amsijc1r3K/9HmpKT9baHkWXl8qz5
         tBXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OK8/u6FR6IpmADEYbANCYO9TQlI0qE21fTDfkShK+ww=;
        b=ucI2jOgwift84y5T1PInxwrr/a9X7NWMog/detl69zn+bSH4HdovwUZ7iBuTGN2Gh0
         ZGpDO2AnQL8iIj8j25WJcETYV92nTxDMJMLkPORsokQfqtzJx9aMexuPUec/UBDySpOv
         xsgX5+Snom1c2W7OTG672BRVn87vCG19ZGYzSEC2RNez8QVg7CYIrCyoBWnZ/WmEGOHW
         Eycl4Se5BbageSpQk6oPQ8hNh69Vv/I1zoLa43l/uYg2GBNqFplsz6SshWXlkISjRqAF
         NI058k0BZihmrsYe5Jt28Lr+SP9FCorbTEKEi9BNs7ohm+nwwU9cKh406b4vNBdAmzjk
         euzA==
X-Gm-Message-State: AOAM531lvY/KYPGnjOp+/562r19p7kZWYPd50MHfaXFcD3HKnj+nDYQG
        GhkwLhnHNVffXtT9oYoPpDo=
X-Google-Smtp-Source: ABdhPJy1ILFMoHId2malZq/x/NjqLyJnNQQy1RJyU1KDpdtikVIydjlZPxQ8diM4yNY23veWaMIYMw==
X-Received: by 2002:a9d:73c1:: with SMTP id m1mr13047814otk.162.1625595759545;
        Tue, 06 Jul 2021 11:22:39 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p26sm1640176otp.59.2021.07.06.11.22.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jul 2021 11:22:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] mtd: core: handle flashes without OTP gracefully
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Tudor.Ambarus@microchip.com, michael@walle.cc,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        richard@nod.at, vigneshr@ti.com
References: <20210702093841.32307-1-michael@walle.cc>
 <9bb2acac-aeb8-d2b2-8df0-9acfd972ec5d@microchip.com>
 <9F46D75C-D00D-4577-A337-7411049EC7D9@walle.cc>
 <8da3d84e-dfbf-2030-98b4-148362d22f52@microchip.com>
 <2716acf0-fcf1-d2ef-83be-152d0300d687@roeck-us.net>
 <20210706182908.3cf82669@xps13>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <d35a1f0d-5a26-82d5-c051-3d9094449602@roeck-us.net>
Date:   Tue, 6 Jul 2021 11:22:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210706182908.3cf82669@xps13>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/21 9:29 AM, Miquel Raynal wrote:
> Hi Guenter,
> 
> Guenter Roeck <linux@roeck-us.net> wrote on Sat, 3 Jul 2021 10:26:06
> -0700:
> 
>> On 7/3/21 9:42 AM, Tudor.Ambarus@microchip.com wrote:
>>> On 7/3/21 7:08 PM, Michael Walle wrote:
>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>>>
>>>> Am 3. Juli 2021 11:56:14 MESZ schrieb Tudor.Ambarus@microchip.com:
>>>>> On 7/2/21 12:38 PM, Michael Walle wrote:
>>>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you
>>>>> know the content is safe
>>>>>>
>>>>>> There are flash drivers which registers the OTP callbacks although
>>>>> the
>>>>>> flash doesn't support OTP regions and return -ENODATA for these
>>>>>> callbacks if there is no OTP. If this happens, the probe of the whole
>>>>>
>>>>> why do they register the OTP callback if they don't support OTP?
>>>>
>>>> I don't know. But I certainly won't touch that code :p
>>>
>>> why? :D
>>>    
>>>>
>>>>   
>>>>>> flash will fail. Fix it by handling the ENODATA return code and skip
>>>>>> the OTP region nvmem setup.
>>>>>>
>>>>>> Fixes: 4b361cfa8624 ("mtd: core: add OTP nvmem provider support")
>>>>>> Reported-by: Guenter Roeck <linux@roeck-us.net>
>>>>>> Signed-off-by: Michael Walle <michael@walle.cc>
>>>>>> ---
>>>>>>    drivers/mtd/mtdcore.c | 10 ++++++++--
>>>>>>    1 file changed, 8 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
>>>>>> index b5ccd3037788..6881d1423dd6 100644
>>>>>> --- a/drivers/mtd/mtdcore.c
>>>>>> +++ b/drivers/mtd/mtdcore.c
>>>>>> @@ -880,7 +880,10 @@ static int mtd_otp_nvmem_add(struct mtd_info
>>>>> *mtd)
>>>>>>
>>>>>>           if (mtd->_get_user_prot_info && mtd->_read_user_prot_reg) {
>>>>>>                   size = mtd_otp_size(mtd, true);
>>>>>> -               if (size < 0)
>>>>>> +               /* ENODATA means there is no OTP region */
>>>>>> +               if (size == -ENODATA)
>>>>>
>>>>> If no OTP data, maybe it's more appropriate for the clients to just
>>>>> return a retlen of 0.
>>>>
>>>> you mean already checking ENODATA in mtd_otp_size() and return 0. That would also make the hunk below unnecessary. I'll change it.
>>>
>>> I've thought about:
>>>
>>> diff --git a/drivers/mtd/chips/cfi_cmdset_0001.c b/drivers/mtd/chips/cfi_cmdset_0001.c
>>> index 54f92d09d9cf..9419b33d7238 100644
>>> --- a/drivers/mtd/chips/cfi_cmdset_0001.c
>>> +++ b/drivers/mtd/chips/cfi_cmdset_0001.c
>>> @@ -2314,7 +2314,7 @@ static int cfi_intelext_otp_walk(struct mtd_info *mtd, loff_t from, size_t len,
>>>    >          /* Check that we actually have some OTP registers */
>>>           if (!extp || !(extp->FeatureSupport & 64) || !extp->NumProtectionFields)
>>> -               return -ENODATA;
>>> +               return 0;
>>>    
>>
>> There are various places where this is called, including code returning information
>> to userspace. That means you'd be changing the ABI to userspace which would now suddenly
>> return 0 instead of -ENODATA.
> 
> Yeah let's avoid this if possible, even though I liked Tudor's approach.
> 
> Would Michael proposal of checking it in mtd_otp_size() still affect
> userspace? If not, having a single check over the -ENODATA return code
> seems attractive.
> 

The check in mtd_otp_nvmem_add() does not affect userspace.

Guenter
