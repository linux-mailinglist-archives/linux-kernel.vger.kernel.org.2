Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECA740C225
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 10:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236974AbhIOI57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 04:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbhIOI5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 04:57:54 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A4FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 01:56:35 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id x6so2586461wrv.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 01:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=BrOGHGt7cC0oT366jdb+W6ImeT82WbSz/76J3XwKsF8=;
        b=DL1iZmiMaXVusOOHpuKdsQXBCBI4VyrKd1zr+C9X/hN67XuYWfszjjCoA3b8STPyxf
         1KxdC7FY4WyAmNn2Kf7ux5WXthSHcuUHuZSUG2VWIjkXSUgSkTrCO1q/3WDdqEbj+gi+
         QDrwhr27v2YE5V+M0dyM5nFMKQqSH+YOWjp7D0WRzBbefmy2kCVI7UEwZfVH2uMbEnhF
         bqxFUy+bXbM2QChj1UGfWxKdizLLDe41hVkA00PEy80LaokVx/JG18jk7VAC2Jngfsi7
         SItcbUMqwoT19jfyHJsWbDBksNxhuN6wzLN+JZc1HVDeXk8nz6ZZIfDHCajMYo2q44GI
         0sgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BrOGHGt7cC0oT366jdb+W6ImeT82WbSz/76J3XwKsF8=;
        b=BX/oLxBPCj68dXVH9uCUcMwKo2gOnuqgph+aQUa+0nxDpYULG81k/PCkUp0nYMo0XJ
         pLSUQZ4kj1MicrxdBPQSCSU0WTyaJhWkiuqZ/XMngL2ZGIkVQFu1r5od1TsiFwJYC9rZ
         nins4LGxnW/9/gFq62+ra9aKYzm0jEmvfEXLRtS08Z4iPM37jLVcMVlATjpIsJLgzqsy
         3g3lae/iP+mEANLPNcuFrGgoYBpBsyoh1EVx6sLI6tFvLdo/d6vE6As8LFZvRqJutUQi
         7V7/79mjXrL9TfLCizZ3Zzm+5/YnQiYpbPFpTPBO4X8wZxxLjkPoLn53OqbEAti65ZhV
         yrFg==
X-Gm-Message-State: AOAM532yzoVgesTnKEFAo3H6kth4d+2ojyIBwUFg58OODGypdcj6ojz7
        IeWpIvSK1dU/8EhSh0sEB1I=
X-Google-Smtp-Source: ABdhPJxkmtWxZER2bPF5Y8q7uwbsEORrfxEp7wPIBWKWuYwEYaVw+XyWIHZcnzLCAKOrW0+FWYCAvg==
X-Received: by 2002:a5d:63d2:: with SMTP id c18mr3613545wrw.311.1631696193795;
        Wed, 15 Sep 2021 01:56:33 -0700 (PDT)
Received: from ?IPV6:2a02:8108:96c0:3b88::1db2? ([2a02:8108:96c0:3b88::1db2])
        by smtp.gmail.com with ESMTPSA id u8sm3812049wmq.45.2021.09.15.01.56.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 01:56:33 -0700 (PDT)
Message-ID: <70042ac9-b114-9447-e25a-b5f75496ee63@gmail.com>
Date:   Wed, 15 Sep 2021 10:56:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [PATCH 0/4] staging: r8188eu: remove unused fields from struct
 hal_data_8188e
Content-Language: en-US
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        martin@kaiser.cx, fmdefrancesco@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210914121352.26052-1-straube.linux@gmail.com>
 <YUEgoipiosdhiXdq@equinox>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <YUEgoipiosdhiXdq@equinox>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/21 00:22, Phillip Potter wrote:
> On Tue, Sep 14, 2021 at 02:13:48PM +0200, Michael Straube wrote:
>> This series removes some unused fields from struct hal_data_8188eu.
>>
>> Tested on x86_64 with Inter-Tech DMG-02.
>>
>> Michael Straube (4):
>>    staging: r8188eu: remove unused macros from rtl8188e_hal.h
>>    staging: r8188eu: remove write-only fields from struct hal_data_8188e
>>    staging: r8188eu: remove unused enums from rtl8288e_hal.h
>>    staging: r8188eu: remove unused field from struct hal_data_8188e
>>
>>   .../staging/r8188eu/hal/rtl8188e_hal_init.c   |  5 -----
>>   .../staging/r8188eu/include/rtl8188e_hal.h    | 22 -------------------
>>   2 files changed, 27 deletions(-)
>>
>> -- 
>> 2.33.0
>>
> 
> Dear Michael,
> 
> Looks good, built and tested here and working fine - as you say though
> these are removals of unused code/properties so I was expecting it to
> work anyway :-)
> 
> One small thing to change though: the subject line of PATCH 3/4 should
> refer to rtl8188e_hal.h, rather than rtl8288e_hal.h.

Thank you for reviewing and spotting the typo Phillip.
I'll send v2 soon.

Regards,
Michael

