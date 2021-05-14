Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C667381100
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 21:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbhENTkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 15:40:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56080 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229981AbhENTkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 15:40:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621021136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n3eS6dFP/l+SjyRuIac1mzIE1FjrsSLw//aWNcd2Go8=;
        b=HLQJMxDYDJ2X6f3l4T+W6mqWFzY3Kx38hn55Gsr2Xb3OQ+9H4R6eeSQsKUMzcErjqcV4sw
        mUZmEtiIvnkNj+yMbywoUOgHbCScEkj4FbSShrlXzPGmzYMcAOW9TREfsExIB5ux072Y0B
        N4wrNgqK1F5AoAvZW9X6b64gnJX76Hw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-lMCXTeY2Mu6EsAJjASzt4A-1; Fri, 14 May 2021 15:38:55 -0400
X-MC-Unique: lMCXTeY2Mu6EsAJjASzt4A-1
Received: by mail-ed1-f70.google.com with SMTP id g17-20020aa7dd910000b029038843570b67so16899288edv.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 12:38:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n3eS6dFP/l+SjyRuIac1mzIE1FjrsSLw//aWNcd2Go8=;
        b=nitU1LRZLkQm3EIewMGRqfrfZxz/yINzyx0U7oETgioufZjqu+/at6JjGE7eFQPWsy
         EaBBQV/jKFVs1EMCfnf32thpKAFM5xOJlwgoaDWmlbr5l02DF1XNORIU41iN6xrK5zM1
         ycbFztzwl7JlN+TRLHS4f9l7nFPYcHS/G03aMVuHsLokkWZDjH5tsqc7p9E2LBCgqTmf
         seBw9idvins1Dy8hH2P56PNh9ALlmDzYK8wTt1mn3gYdAbLs4PYmkklFdWd4TZkSTttV
         CCDZoXen8wamjMzity/MndyRkrHuCnB2PQx6sCnkPL+VfwnApt/f6zqeMK6zP2AvGVtl
         O+Ng==
X-Gm-Message-State: AOAM533IZfONkQCXp9/E5l4kllpCtWXiWC0FyfTP2WXF8kqaiUjvblL0
        JNWmx3r/tixWmH5dKTfwmEzb7uk/B5PfiwG6uawR+isU3RUJZ0GsvrQoR6tHPW94f52QaQ8uIHc
        wrmlOGNM6/WVtpCf2DizvRris
X-Received: by 2002:a17:906:7ac9:: with SMTP id k9mr51242151ejo.229.1621021133743;
        Fri, 14 May 2021 12:38:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxD6+PF8PCet9IoVVRiBIa/RaBmB/f1bWaaoLZKoqAChY02NHQWFUFvyxPFOz1MP4ITlL3Brw==
X-Received: by 2002:a17:906:7ac9:: with SMTP id k9mr51242129ejo.229.1621021133536;
        Fri, 14 May 2021 12:38:53 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id r15sm4894271edp.62.2021.05.14.12.38.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 12:38:53 -0700 (PDT)
Subject: Re: [PATCH] platform/surface: aggregator: shut up clang
 -Wconstantn-conversion warning
To:     Maximilian Luz <luzmaximilian@gmail.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
References: <20210514140556.3492544-1-arnd@kernel.org>
 <219848ed-e0ce-634a-29c2-caca813b054c@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <42f70914-e46c-20b9-6b13-8e8d855112a9@redhat.com>
Date:   Fri, 14 May 2021 21:38:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <219848ed-e0ce-634a-29c2-caca813b054c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/14/21 4:21 PM, Maximilian Luz wrote:
> On 5/14/21 4:05 PM, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> Clang complains about the assignment of SSAM_ANY_IID to
>> ssam_device_uid->instance:
>>
>> drivers/platform/surface/surface_aggregator_registry.c:478:25: error: implicit conversion from 'int' to '__u8' (aka 'unsigned char') changes value from 65535 to 255 [-Werror,-Wconstant-conversion]
>>          { SSAM_VDEV(HUB, 0x02, SSAM_ANY_IID, 0x00) },
>>          ~                      ^~~~~~~~~~~~
>> include/linux/surface_aggregator/device.h:71:23: note: expanded from macro 'SSAM_ANY_IID'
>>   #define SSAM_ANY_IID            0xffff
>>                                  ^~~~~~
>> include/linux/surface_aggregator/device.h:126:63: note: expanded from macro 'SSAM_VDEV'
>>          SSAM_DEVICE(SSAM_DOMAIN_VIRTUAL, SSAM_VIRTUAL_TC_##cat, tid, iid, fun)
>>                                                                       ^~~
>> include/linux/surface_aggregator/device.h:102:41: note: expanded from macro 'SSAM_DEVICE'
>>          .instance = ((iid) != SSAM_ANY_IID) ? (iid) : 0,                        \
>>                                                 ^~~
>>
>> The assignment doesn't actually happen, but clang checks the type limits
>> before checking whether this assignment is reached. Shut up the warning
>> using an explicit type cast.
> 
> I'm not too happy about this fix as (I believe) it will also shut up any
> valid GCC error message in case those macros are used with non-u8 (and
> non-SSAM_ANY_xxx) values.

Since you're the maintainer of this code, I'll go with your judgement here,
esp. since as the commit msg states SSAM_ANY_IID is never actually
assigned to .instance, instead it gets set to 0.

So this is a false-positive compiler warning, which may be best fixed in
the compiler itself.

With that said I think this is the second time this comes up now, maybe
we should add a comment to the code about the clang warning ?

Regards,

Hans


> 
> I'll let others judge and decide what's preferred, however.
> 
> In case you're deciding to apply this, feel free to add:
> 
> Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>
> 
> Thanks,
> Max
> 
>> Fixes: eb0e90a82098 ("platform/surface: aggregator: Add dedicated bus and device type")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>   include/linux/surface_aggregator/device.h | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/surface_aggregator/device.h b/include/linux/surface_aggregator/device.h
>> index 4441ad667c3f..90df092ed565 100644
>> --- a/include/linux/surface_aggregator/device.h
>> +++ b/include/linux/surface_aggregator/device.h
>> @@ -98,9 +98,9 @@ struct ssam_device_uid {
>>                | (((fun) != SSAM_ANY_FUN) ? SSAM_MATCH_FUNCTION : 0),    \
>>       .domain   = d,                                \
>>       .category = cat,                            \
>> -    .target   = ((tid) != SSAM_ANY_TID) ? (tid) : 0,            \
>> -    .instance = ((iid) != SSAM_ANY_IID) ? (iid) : 0,            \
>> -    .function = ((fun) != SSAM_ANY_FUN) ? (fun) : 0                \
>> +    .target   = ((tid) != SSAM_ANY_TID) ? (u8)(tid) : 0,            \
>> +    .instance = ((iid) != SSAM_ANY_IID) ? (u8)(iid) : 0,            \
>> +    .function = ((fun) != SSAM_ANY_FUN) ? (u8)(fun) : 0            \
>>     /**
>>    * SSAM_VDEV() - Initialize a &struct ssam_device_id as virtual device with
>>
> 

