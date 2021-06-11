Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF9AB3A3E98
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 11:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbhFKJIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 05:08:40 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:37839 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbhFKJIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 05:08:39 -0400
Received: by mail-wr1-f51.google.com with SMTP id i94so5234574wri.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 02:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=USdvPqPdKMHnM9voVkVpQvN+g27UzfJI7tmweKL8dvQ=;
        b=eumoaK0UzpCH5tI2m9/C0BZx06PAZyL8HwTJYBW3TruFD4nl9+Cg5TV4Kz9XxYcth0
         z4lylODb2OMIUd+kvXj4WPwC9hJ+kLsEGamYLSzEBN2y2d+/fOSlll5Ij4LEAVp2tY3V
         DbMwQvxUFno/0z3vWeW8XwSz7U7twAb4NSkpG7zUgd68TBwYBHsMzw15Ten5/lOaWYkE
         iaahEa6C9//u8v7sB64D3yLixjwhTcqz3fnNeUci5e9G96Ryd6paJMHf4Gnp8nx6bB+u
         5lyHkAYgrRpBrXlnB95rxPFm2eBzG85NlauIwrpwM7vUTzHx04wIn7dbrNhpq26JjFnS
         bJ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=USdvPqPdKMHnM9voVkVpQvN+g27UzfJI7tmweKL8dvQ=;
        b=coiJOXsRcT7vKwo3ChV3LnIRQU64JvpOY/xSX+MGB7osh8Jz8SiyJwaYdqEUqj8YZw
         Th5aer5CQ9tcJE4Pc+VpUGS9H/kIetM6LhKXbyxpVqT9NogK6qvvjKBqNupyMNar2PlN
         aBLTK4N1/RiI6wXxewN1bvAZ/c0YhxB3m4UUmevLxEa7hiKYQRtt98OIE82l2o5OLIPi
         xcOxTRw8onQmr5RbHFL7fsmLXAG8Olv5y5QDvY2WnHLDKZaoB7jZbDsEGd0LGs/ND3Ll
         FAitQeFCsSkVV5UVJtGJq+K4P4PGgZI2wmteXxwvOVk3O8kAn0kRZYhVP4h00HjLdHFZ
         h28g==
X-Gm-Message-State: AOAM531hxG66q2IfYfYszsvwGHCgCL2TZdWUFKzFHLvM9RsMGQP+ibjJ
        r+PbeTtHSmjGKV5dUa87xIM/BA==
X-Google-Smtp-Source: ABdhPJzBAuEbq5uThLVdVuH4rfbvc61dMQEMXlSef+wYrZgtdIwK6Exu3/1IzJuiz7UjNHrbDYlS3w==
X-Received: by 2002:a5d:664c:: with SMTP id f12mr2804630wrw.206.1623402341614;
        Fri, 11 Jun 2021 02:05:41 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id l10sm6024862wrs.11.2021.06.11.02.05.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jun 2021 02:05:41 -0700 (PDT)
Subject: Re: [PATCH 4/9] nvmem: sprd: Fix an error message
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Chunyan Zhang <zhang.lyra@gmail.com>
References: <20210611083348.20170-1-srinivas.kandagatla@linaro.org>
 <20210611083348.20170-5-srinivas.kandagatla@linaro.org>
 <YMMlRq250A53CDaM@kroah.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <a34f8a9d-c9e7-5c2d-521f-13677cfd7ccb@linaro.org>
Date:   Fri, 11 Jun 2021 10:05:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YMMlRq250A53CDaM@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/06/2021 09:56, Greg KH wrote:
> On Fri, Jun 11, 2021 at 09:33:43AM +0100, Srinivas Kandagatla wrote:
>> From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>>
>> 'ret' is known to be 0 here.
>> The expected error status is stored in 'status', so use it instead.
>>
>> Also change %d in %u, because status is an u32, not a int.
>>
>> Fixes: 096030e7f449 ("nvmem: sprd: Add Spreadtrum SoCs eFuse support")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> Acked-by: Chunyan Zhang <zhang.lyra@gmail.com>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   drivers/nvmem/sprd-efuse.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/nvmem/sprd-efuse.c b/drivers/nvmem/sprd-efuse.c
>> index 5d394559edf2..e3e721d4c205 100644
>> --- a/drivers/nvmem/sprd-efuse.c
>> +++ b/drivers/nvmem/sprd-efuse.c
>> @@ -234,7 +234,7 @@ static int sprd_efuse_raw_prog(struct sprd_efuse *efuse, u32 blk, bool doub,
>>   	status = readl(efuse->base + SPRD_EFUSE_ERR_FLAG);
>>   	if (status) {
>>   		dev_err(efuse->dev,
>> -			"write error status %d of block %d\n", ret, blk);
>> +			"write error status %u of block %d\n", status, blk);
> 
> Shouldn't this be %pe and not %u?

This is not error pointer its status value read back from a register.

I think %u should be good here.

--srini
> 
> thanks,
> 
> greg k-h
> 
