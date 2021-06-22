Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80E933B0291
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 13:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbhFVLRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 07:17:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53574 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230137AbhFVLRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 07:17:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624360504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=002w5D0lwhYSH2t/vQFvpXDZXSTcT1c6YHrb39gLjf4=;
        b=fJ1ySI0/9RsGr7GJwBhRUMDRAnxsbJ0aFQvTfzrjgP0qguyNcWcYsUIIn1a9+1JaXfiBvq
        rGZ2CAym19IfKOfdUYyYjFS9YCRNHxSScZ+N6h3fhCnQ9ANncQtWRA5qdPJi7aN9E8F/lV
        Rh6aEd62OKVBr9D+aB3y70FWh2f6ECY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-FFzaRjQEON601thF3ACaYQ-1; Tue, 22 Jun 2021 07:15:03 -0400
X-MC-Unique: FFzaRjQEON601thF3ACaYQ-1
Received: by mail-ej1-f72.google.com with SMTP id de48-20020a1709069bf0b029048ae3ebecabso3889419ejc.16
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 04:15:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=002w5D0lwhYSH2t/vQFvpXDZXSTcT1c6YHrb39gLjf4=;
        b=D9H+59m6d2XKtq2JviuHSgMRK/AJiT6YXPk1xwqe5yspEyOAAOPYkAbkienam01k9A
         NrmH0yH4Kf0PxdN9KfB4XFXpo41JeubHOz9o9B8JhHJKDf2vsXoqqE9HguOl4A6/kyJy
         bUIbu2M+IYi8CrekqEI2MB+nW3h5WKDAd0H0Xr7TfBfx1ghXaZoArbfqvGsUOvhRcSJf
         C8pAd9ibdGZdhuTy0IN9z1hnLYm9Nm/MuU+kB0RRBMYmVHwrC7/z3s9f/Xy2L54jT8He
         5LY88IGvmu31sThJisWxLiH2Jbq82bNFy3r4R5BzM1MGgva0V6f6UvUi9caOXjEBO05q
         36Pw==
X-Gm-Message-State: AOAM531VQGbkAgZBM6caMP/OVlzI/+ALfoWuifdLkUb/N0K7nKbF2VOi
        3syY+bQTICRq4urWn3m1+rGYF8CUKc78O6iljvJl6Iyf18q7rV9YNryUfF6VTV+0MT9uPmV54gL
        g/HdVSOZc4NLY9AuraL3wA4Bh41OZorAMWDUMoNJ7d5AlImhxLeyVGXGROzVom2JCd0BlN0HkpD
        Ea
X-Received: by 2002:a17:906:1792:: with SMTP id t18mr3411006eje.38.1624360501831;
        Tue, 22 Jun 2021 04:15:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxtAR7cvER8LBqam9WJT7jBKdk4usUVYQ34KS15ZoaF7GfNIbLUHWC94RV9siHCe0nNJqWolg==
X-Received: by 2002:a17:906:1792:: with SMTP id t18mr3410983eje.38.1624360501611;
        Tue, 22 Jun 2021 04:15:01 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id jx17sm2837266ejc.60.2021.06.22.04.15.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 04:15:01 -0700 (PDT)
Subject: Re: [PATCH 12/18] staging: rtl8723bs: remove VHT dead code
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1624099125.git.fabioaiuto83@gmail.com>
 <d3f79570088ad339bd80fe9d6b24604ac91ea8d3.1624099126.git.fabioaiuto83@gmail.com>
 <dd0332d7-5d9f-49e5-3fc6-8ae3e623f29c@redhat.com>
 <20210622091602.GA1426@agape.jhs>
 <4f128bd2-b84b-132e-c75f-0030701a8a9b@redhat.com>
 <20210622095757.GB1426@agape.jhs>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <d80cf1a5-d70c-97c2-a6a2-af2f4209715d@redhat.com>
Date:   Tue, 22 Jun 2021 13:15:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210622095757.GB1426@agape.jhs>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,

On 6/22/21 11:57 AM, Fabio Aiuto wrote:
> On Tue, Jun 22, 2021 at 11:19:36AM +0200, Hans de Goede wrote:
> 
> Hi Hans,
> 
>> Hi Fabio,
>>
>>> Moreover I have been quite conservative, for I left untouched HT indexes above
>>> 7 which rtl8723bs doesn't support.
>>>
>>> So IMO I think this patch is fine as is...
>>>> Perhaps this entire block can never be executed ?
>>>
>>> the block is executed but there's no register write happening. Just
>>> updating of values which will never be fetched.
>>
>> Ack, my bad I was under the impression that phy_SetTxPowerByRateBase()
>> would actually do a register write, but I checked and it just updates
>> some unused table values, so dropping this code is fine and you can
>> keep this patch for v2 of the patch set.
>>
>> Regards,
>>
>> Hans
>>
> 
> thank you, what do you think about what I replied about patch 1,

I somehow did not receive your reply, so I've just read it on the archives.

> shall
> I remove the '> 14 if block' or leave it as is?

I think it would be best to keep the '> 14 if block' for now and
remove all of them in a later patch-series (I assume there will
be more of them).

> Do you think is necessary
> to keep the conditions inside the block and pack them?

You could also remove the condition and just set
the band to WIRELESS_INVALID unconditionally as you
suggest, that is fine.

But if you keep the condition, like you did in v1 of the
patch, then you must pack the 2 masks together.

Regards,

Hans

