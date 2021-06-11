Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F97B3A4004
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 12:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbhFKKT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 06:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhFKKT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 06:19:28 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60506C061574
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 03:17:22 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id c5so5450198wrq.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 03:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I5tKlQRifKHe2gTRaDd3qimWqkGR/5Q+9YE8hRfMOFE=;
        b=x71CK+AWs8dBYH4/oH8dY8Z3xpmlOkUVNy4TXzSv4euJ3AmJmGAB26bbUtngVNHqnn
         GQyWclnY0NyEWUTxAr6GKE7rpelXeFsT3niaTzNuGXC/DShBT5iZ/vo6p1qJ6toflHxr
         uUKPyPcGx873ePEQCH0slgFPoxPy1Qgh2QJzhv2QSZ6RYsqbzpzLlA7BazHWSTI1xJva
         KPuekCWeLWWI+eYpQ015qQ1OW8OBzl9mlaveRta+Fm9V2Lhmt3mjQW6wQMq0V9H+g3LB
         zAqgbiO/J52YKHakEtqF/No8pGELTQB6W3BO4j6trM+a5HtwoU1FOTZMe3798//WJDx/
         yboA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I5tKlQRifKHe2gTRaDd3qimWqkGR/5Q+9YE8hRfMOFE=;
        b=Qgiwb4euNGwN6bfWE9DG+VuncgwmBhUAZjW31RTUOFKf6eXKDjxTi0cb4HoI3motL8
         ZsAvowEe7O8flU+opjGipDsjlRgvAzIGwJQgIFpg7Q0Pnl3bNX2uM6eQvHYX25w8UHIB
         3z5Y+8KBIF9vTm7elcDQeSB0tiQUbNOm50zFQlU5ukhvPOW5bDgnu+vNe4dkaqu0dOy+
         5uwnXwY02+W9Uhsts265v/KAFj9LBn+ffVFzJnuNYdT6llFtHXvrtkYqs5Rg/wqxVTQf
         X3R4pppexlMMFz0NpZj0g1qyo9aBYq1JQ8NCuE3CIKIelAhZ3+BDSKZmokJUUNxuMrKc
         yQxA==
X-Gm-Message-State: AOAM531eKOv/bqEzDzC/Rt0uoQ6XFkAFK6RpooCCg/2sgMK4C2afSnt+
        B1AWIf9zhYVxHKQid1I2JFVUgA==
X-Google-Smtp-Source: ABdhPJypcf6Z6Gvwg4C0r7rXpd7oDghk0GBffhYcniRydvzWIEB0tPvn6x7AEagg9pfTpLjdEjl+YQ==
X-Received: by 2002:adf:f207:: with SMTP id p7mr3085756wro.275.1623406641036;
        Fri, 11 Jun 2021 03:17:21 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id k5sm6838745wrv.85.2021.06.11.03.17.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jun 2021 03:17:20 -0700 (PDT)
Subject: Re: [PATCH 4/9] nvmem: sprd: Fix an error message
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Chunyan Zhang <zhang.lyra@gmail.com>
References: <20210611083348.20170-1-srinivas.kandagatla@linaro.org>
 <20210611083348.20170-5-srinivas.kandagatla@linaro.org>
 <YMMlRq250A53CDaM@kroah.com>
 <a34f8a9d-c9e7-5c2d-521f-13677cfd7ccb@linaro.org>
 <YMMqPlknDF+k466x@kroah.com> <YMMwteJ5XvDST+zH@kroah.com>
 <YMMxc4UrmMN2AUef@kroah.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <2e81821d-5b4d-925d-9d15-7a7ebd6d649d@linaro.org>
Date:   Fri, 11 Jun 2021 11:17:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YMMxc4UrmMN2AUef@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/06/2021 10:48, Greg KH wrote:
> On Fri, Jun 11, 2021 at 11:45:25AM +0200, Greg KH wrote:
>> On Fri, Jun 11, 2021 at 11:17:50AM +0200, Greg KH wrote:
>>> On Fri, Jun 11, 2021 at 10:05:40AM +0100, Srinivas Kandagatla wrote:
>>>>
>>>>
>>>> On 11/06/2021 09:56, Greg KH wrote:
>>>>> On Fri, Jun 11, 2021 at 09:33:43AM +0100, Srinivas Kandagatla wrote:
>>>>>> From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>>>>>>
>>>>>> 'ret' is known to be 0 here.
>>>>>> The expected error status is stored in 'status', so use it instead.
>>>>>>
>>>>>> Also change %d in %u, because status is an u32, not a int.
>>>>>>
>>>>>> Fixes: 096030e7f449 ("nvmem: sprd: Add Spreadtrum SoCs eFuse support")
>>>>>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>>>>>> Acked-by: Chunyan Zhang <zhang.lyra@gmail.com>
>>>>>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>>>>> ---
>>>>>>    drivers/nvmem/sprd-efuse.c | 2 +-
>>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/nvmem/sprd-efuse.c b/drivers/nvmem/sprd-efuse.c
>>>>>> index 5d394559edf2..e3e721d4c205 100644
>>>>>> --- a/drivers/nvmem/sprd-efuse.c
>>>>>> +++ b/drivers/nvmem/sprd-efuse.c
>>>>>> @@ -234,7 +234,7 @@ static int sprd_efuse_raw_prog(struct sprd_efuse *efuse, u32 blk, bool doub,
>>>>>>    	status = readl(efuse->base + SPRD_EFUSE_ERR_FLAG);
>>>>>>    	if (status) {
>>>>>>    		dev_err(efuse->dev,
>>>>>> -			"write error status %d of block %d\n", ret, blk);
>>>>>> +			"write error status %u of block %d\n", status, blk);
>>>>>
>>>>> Shouldn't this be %pe and not %u?
>>>>
>>>> This is not error pointer its status value read back from a register.
>>>>
>>>> I think %u should be good here.
>>>
>>> Argh, you are right, my fault.  For some reason I thought this worked
>>> for integers as well.  Don't we have such a printk modifier somewhere to
>>> turn error values into strings?  Let me dig...
>>
>> Ah, errname() will do it.
>>
>> Looks like no one uses it, so nevermind, sorry for the noise.  I'll go
>> apply this one now.
> 
> Does not apply to my tree :(

Looks like its already in your tree since May 7th.

--srini
> 
