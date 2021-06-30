Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B60813B7E49
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 09:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbhF3HnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 03:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232573AbhF3HnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 03:43:19 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71BA0C061766;
        Wed, 30 Jun 2021 00:40:50 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id a5-20020a7bc1c50000b02901e3bbe0939bso833509wmj.0;
        Wed, 30 Jun 2021 00:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ESnsglEXUA/oJjny6ysW39DXZqWa0zaOszI34gO6+Xw=;
        b=BZlmzT+xB4JIRTvah0usPFHMmSJcAwGpRUEE8yNnFHadXBng8BHWDGe5NiHn3I/pkk
         b+mGUsQp1WgvWv7pNgLX3YWOrORvkrubrWsFPZ+SMC1WcjTq5vihnoId53id9aWpXGEt
         cfUW8ILkisSYzEqTZ0YfCEimVggW6/PD/Oq4x+5gjF23O1oz3cc8LKU0wZZtMUFlcsuQ
         bbRWnWIouTnYM7RJB3jEqEeUbIUTpvakZ8HBZ1AaY/k2XcywN0iZEXLm9xPz6/mtLL7B
         OqMfZxxTUAjW6KHfhrM4GcVwsNg3Sem4MfILH9q0mJbakEYRrLX40grsNAzDq/PdgO3q
         PiVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ESnsglEXUA/oJjny6ysW39DXZqWa0zaOszI34gO6+Xw=;
        b=gnqOH9qCRhtTnfUfSukjnLyzHo7ZD69fNPqhn4gh5wutmJKqNXEzWTK24r1LRtTeet
         asGbdPclc1XUZ2yL+BTKpwI/bmhCWwXlMKSAEtfC0i+n3h82Q5zu3MlFaGtwHEuEsn1P
         Pi3/LOFm6YlZ25vYPlBUQfx8WYay8trLxoYVBzXFcgPnYld2CKe/i3YcMl1hPRuE1cmu
         b+sxnhhcvQYmLFNElHANp8iAoF9XiXTT77/WlLZy0guPqID4bMAq7uOQzo+Q3rGCO2zr
         oHFKFUqmbHrZcAnnZk9pKXJvg0KkaC/pR+9KTMZ+DpLapyAt840MfNqM2R3PyBssH82c
         qArQ==
X-Gm-Message-State: AOAM531XVbOj5iPcFv6iK1dXsgslPO250M019KZwQOOoyk58wSUdC+Mx
        kfDSGzTY1E0WasTYDdTpmz4=
X-Google-Smtp-Source: ABdhPJzEHpvyW7L35YzdPCMfy3750B4ApNGNOi4nwfJuKIL34GnQ57OlGDecCLVHBqBhmzoTebMLlg==
X-Received: by 2002:a1c:2985:: with SMTP id p127mr37133724wmp.165.1625038849067;
        Wed, 30 Jun 2021 00:40:49 -0700 (PDT)
Received: from ziggy.stardust (static-55-132-6-89.ipcom.comunitel.net. [89.6.132.55])
        by smtp.gmail.com with ESMTPSA id s5sm21282739wrn.38.2021.06.30.00.40.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jun 2021 00:40:48 -0700 (PDT)
Subject: Re: [RESEND PATCH v2 3/4] soc: mediatek: pm-domains: Add support for
 mt8195
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20210616000659.28347-1-chun-jie.chen@mediatek.com>
 <20210616000659.28347-4-chun-jie.chen@mediatek.com>
 <3c7695d9-f7aa-0cb0-871a-f53daee0362d@collabora.com>
 <526fc951eaf6c44f04c7a84786ca3c7ddf63a9d6.camel@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <4062efe7-b327-b33b-42d3-28570cae2c6e@gmail.com>
Date:   Wed, 30 Jun 2021 09:40:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <526fc951eaf6c44f04c7a84786ca3c7ddf63a9d6.camel@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/06/2021 15:15, Chun-Jie Chen wrote:
> On Fri, 2021-06-25 at 11:07 +0200, Enric Balletbo i Serra wrote:
>> Hi Chun-Jie Chen,
>>
>> Thank you for your patch.
>>
>> On 16/6/21 2:06, Chun-Jie Chen wrote:
>>> Add domain control data including bus protection data size
>>> change due to more protection steps in mt8195 and wakeup flag
>>> in power domain for wakeup control in suspend.
>>>
>>
>> The wakeup flag is used for different SoCs apart from mt8195, isn't
>> it? I'd add
>> this on a separate patch so it is not dependent on the mt8195
>> changes. This will
>> also make more clear that is not really a mt8195 thing and can help
>> in case at
>> some point we need to run a bisection because something is broken on
>> another SoC.
>>
>> Thanks,
>>   Enric
>>
>>
> 
> Yes, this wakeup flag also is used by other SoC like MT8173, but
> missing this flag in new power domain driver(mtk-pm-domain.c).
> I will separate this modification of wakeup flag from this patch but
> put it in same series. 
> 

Sounds perfect.

Regards,
Matthias
