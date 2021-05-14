Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A20F381108
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 21:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbhENTm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 15:42:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39823 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229932AbhENTmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 15:42:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621021272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OzBTlwulT81O7/ztY2Ct0OPTesVialDVF2p2RnNAlMc=;
        b=G0owN1xvGXLzUb6sd7L0tjYOe5uIpO8ZWgGLa5Ct3nE759nwo2Swt1ie7YccQgmJlQ/iEm
        V/XX/yMiOnMpUbXmvZzK1E0dR+oGRi1AkmGpNy8l/QWgBVU0ROBmyfL/wM8CYc04LgTDqp
        C/fCqstpW013uhcEqdDtc3OL1Hq4Guk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-i7cMXv9aMPO4WZ7e9sKFmA-1; Fri, 14 May 2021 15:41:09 -0400
X-MC-Unique: i7cMXv9aMPO4WZ7e9sKFmA-1
Received: by mail-ej1-f69.google.com with SMTP id bi3-20020a170906a243b02903933c4d9132so79530ejb.11
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 12:41:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OzBTlwulT81O7/ztY2Ct0OPTesVialDVF2p2RnNAlMc=;
        b=AW/+5gWO4hbpYbmz7CuJKjkm490h1acn7ojuLFmc+3EGNM9gypnEs9wlwgViOgSV+H
         l7d5MfOPuyJ98mOYa2JOBNqNwsOWAo4UF+/BOYQ/A/XUgjdYnFOi0nq/wlCk/MNAnwON
         MiYqjHJ1DVXNhzLOSh0ssQS1lKFpdqqOQxadMSKpsA2bQlR9FbcRT2pf2j2h9/Jmdkj7
         aT3SmoSThrnn6q+vnAtJbfpW8eSlEUyRm/K1yLW2dc+rdrLBP/VkmNmq3ePtzMdXuVj9
         /qRFyON1QQ3nElpC55FxgenQwHbeDBxJBa3HdnDiBdy4Vn+Tb8BfpYTNtnXrNTUjeNJx
         u3Rw==
X-Gm-Message-State: AOAM532C2iteaZp2hAiJKWzlEQZx7VJy0WiJD2SHwzVWzmXQ1EoXxlkT
        qRp90j55LCB5mSd9pYgdnwAflQdkZl1PS2uzeUkLB7YYfkeh5EW6HKLOM/RoUl5g1CcNLdKjWqV
        pP5o4pzPHVexVzjqQzDcNqzSa
X-Received: by 2002:a17:906:2546:: with SMTP id j6mr50105460ejb.51.1621021268104;
        Fri, 14 May 2021 12:41:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJ1sSOF3TrN9vzdPOoTb4Q22ubHTy0T474wG+XaM2MLrXboNUFRAq7ylaXd0pFzmJgMXk0hw==
X-Received: by 2002:a17:906:2546:: with SMTP id j6mr50105445ejb.51.1621021267928;
        Fri, 14 May 2021 12:41:07 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id k9sm4335048eje.102.2021.05.14.12.41.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 12:41:07 -0700 (PDT)
Subject: Re: [PATCH] platform/surface: aggregator: shut up clang
 -Wconstantn-conversion warning
From:   Hans de Goede <hdegoede@redhat.com>
To:     Maximilian Luz <luzmaximilian@gmail.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
References: <20210514140556.3492544-1-arnd@kernel.org>
 <219848ed-e0ce-634a-29c2-caca813b054c@gmail.com>
 <42f70914-e46c-20b9-6b13-8e8d855112a9@redhat.com>
Message-ID: <29d069f2-a1c8-eb43-02ec-69c86b3cb107@redhat.com>
Date:   Fri, 14 May 2021 21:41:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <42f70914-e46c-20b9-6b13-8e8d855112a9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/14/21 9:38 PM, Hans de Goede wrote:
> Hi,
> 
> On 5/14/21 4:21 PM, Maximilian Luz wrote:
>> On 5/14/21 4:05 PM, Arnd Bergmann wrote:
>>> From: Arnd Bergmann <arnd@arndb.de>
>>>
>>> Clang complains about the assignment of SSAM_ANY_IID to
>>> ssam_device_uid->instance:
>>>
>>> drivers/platform/surface/surface_aggregator_registry.c:478:25: error: implicit conversion from 'int' to '__u8' (aka 'unsigned char') changes value from 65535 to 255 [-Werror,-Wconstant-conversion]
>>>          { SSAM_VDEV(HUB, 0x02, SSAM_ANY_IID, 0x00) },
>>>          ~                      ^~~~~~~~~~~~
>>> include/linux/surface_aggregator/device.h:71:23: note: expanded from macro 'SSAM_ANY_IID'
>>>   #define SSAM_ANY_IID            0xffff
>>>                                  ^~~~~~
>>> include/linux/surface_aggregator/device.h:126:63: note: expanded from macro 'SSAM_VDEV'
>>>          SSAM_DEVICE(SSAM_DOMAIN_VIRTUAL, SSAM_VIRTUAL_TC_##cat, tid, iid, fun)
>>>                                                                       ^~~
>>> include/linux/surface_aggregator/device.h:102:41: note: expanded from macro 'SSAM_DEVICE'
>>>          .instance = ((iid) != SSAM_ANY_IID) ? (iid) : 0,                        \
>>>                                                 ^~~
>>>
>>> The assignment doesn't actually happen, but clang checks the type limits
>>> before checking whether this assignment is reached. Shut up the warning
>>> using an explicit type cast.
>>
>> I'm not too happy about this fix as (I believe) it will also shut up any
>> valid GCC error message in case those macros are used with non-u8 (and
>> non-SSAM_ANY_xxx) values.
> 
> Since you're the maintainer of this code, I'll go with your judgement here,

p.s.

I just went to patchwork to drop this patch from the queue:

https://patchwork.kernel.org/projecat/platform-driver-x86/list/

But it never got added there because platform-driver-x86@vger.kernel.org
was missing from the Cc even though get_maintainer.pl lists it.

Regards,

Hans




>> I'll let others judge and decide what's preferred, however.
>>
>> In case you're deciding to apply this, feel free to add:
>>
>> Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>
>>
>> Thanks,
>> Max
>>
>>> Fixes: eb0e90a82098 ("platform/surface: aggregator: Add dedicated bus and device type")
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>> ---
>>>   include/linux/surface_aggregator/device.h | 6 +++---
>>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/include/linux/surface_aggregator/device.h b/include/linux/surface_aggregator/device.h
>>> index 4441ad667c3f..90df092ed565 100644
>>> --- a/include/linux/surface_aggregator/device.h
>>> +++ b/include/linux/surface_aggregator/device.h
>>> @@ -98,9 +98,9 @@ struct ssam_device_uid {
>>>                | (((fun) != SSAM_ANY_FUN) ? SSAM_MATCH_FUNCTION : 0),    \
>>>       .domain   = d,                                \
>>>       .category = cat,                            \
>>> -    .target   = ((tid) != SSAM_ANY_TID) ? (tid) : 0,            \
>>> -    .instance = ((iid) != SSAM_ANY_IID) ? (iid) : 0,            \
>>> -    .function = ((fun) != SSAM_ANY_FUN) ? (fun) : 0                \
>>> +    .target   = ((tid) != SSAM_ANY_TID) ? (u8)(tid) : 0,            \
>>> +    .instance = ((iid) != SSAM_ANY_IID) ? (u8)(iid) : 0,            \
>>> +    .function = ((fun) != SSAM_ANY_FUN) ? (u8)(fun) : 0            \
>>>     /**
>>>    * SSAM_VDEV() - Initialize a &struct ssam_device_id as virtual device with
>>>
>>

