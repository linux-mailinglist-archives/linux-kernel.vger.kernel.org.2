Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59B573C3AC5
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 07:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbhGKFsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 01:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhGKFse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 01:48:34 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B47C0613DD;
        Sat, 10 Jul 2021 22:45:47 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id w127so19019831oig.12;
        Sat, 10 Jul 2021 22:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UAnw0/Jyzqqe15b46xjMdEc+DPZ+UP7ibwKXPwtIgwE=;
        b=i0+2CgLS2IftH7NWL9KfNMAf5L6/zYKaddNV3VvlPGYXpqvAqlbZpTdMjVXHayrzPb
         TyEQZxVIyz/N0BpXWSWbcysvgdk7TG+sycUrkeRdSJkN+jItfIQshH/IduPf3//j8rLr
         ev3Mucqoy6ekZTzwQXWLh+aCAf6/iA0ueKgGJSyGt8uiFNIubAn6KSZd8pSaIE1LypST
         q1sFCAcvitDwR+yV99HDlqQcK8gSMT9em1V6iw9411ct6v2ZXZQxBqByHTP5wUqGtyB8
         0MIcJEeC44QOXFAeYe0ZqnF39cXRPHPTGS2Nfw8wGBC3KsTZHAo7mMt6/Iugio6Q5MtU
         EnVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UAnw0/Jyzqqe15b46xjMdEc+DPZ+UP7ibwKXPwtIgwE=;
        b=Xl/2Wkx9OvXZLb182TUr7XaOXXEXVDicjFZ6zhvZfdurGcm6nrlyUfKDixuPYrN0QN
         3UduXyhHC2Im1vKUQlazsGxAdybJC/VUXDgLuFSvWVTJF2NN7cbrENZ3jUxVyabeJsGe
         4wOtcwEF5VXvlmN6SgRuHUKWLojcg87pvFpW1mlBRwqYVOxdrbGXp69Is8u2le2wfivZ
         COwQLwVw43n8fSc4uZDf4T3NSG4ljNI46kFdx9eTN/kP/+ntJwF18I8dLfM5SParIvKF
         20wD1S3Y5cxzsMaBFKvvA387CVlm2F9ZXuCklrnoBUIDumLVxw14kjq7fbN1jy1eI5uz
         AzNg==
X-Gm-Message-State: AOAM533/Tk62KsZXEgfocfYRmf9tqCvT3G94DnKzzmxYr7RwdMyDVHn9
        amrZi8SouPvGHYL6BgKFjAk=
X-Google-Smtp-Source: ABdhPJzGHdW708JcIhZIEuB1w5BDMbVP96lTiqf3TQbjoULwjFneC/iV3xATf0Ao/6jx3V/V/zGWmA==
X-Received: by 2002:a05:6808:1406:: with SMTP id w6mr1401117oiv.123.1625982346562;
        Sat, 10 Jul 2021 22:45:46 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n9sm554207otn.54.2021.07.10.22.45.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jul 2021 22:45:45 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Vincent Pelletier <plr.vincent@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
References: <c06db13bb5076a8ee48e38a74caf3b81e4a2d1f8.1625662290.git.plr.vincent@gmail.com>
 <2c24ef5953401e80d92c907704bffeff1d024de0.1625662290.git.plr.vincent@gmail.com>
 <20210710160813.GA3560663@roeck-us.net> <20210711025502.347af8ff@gmail.com>
 <20210711044419.7b1c00f8@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v3 2/3] hwmon: da9063: HWMON driver
Message-ID: <3a2f0b72-f790-435b-ebae-6b1afd19f707@roeck-us.net>
Date:   Sat, 10 Jul 2021 22:45:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210711044419.7b1c00f8@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/21 9:44 PM, Vincent Pelletier wrote:
> On Sun, 11 Jul 2021 02:55:02 +0000, Vincent Pelletier <plr.vincent@gmail.com> wrote:
>> On Sat, 10 Jul 2021 09:08:13 -0700, Guenter Roeck <linux@roeck-us.net> wrote:
>>> Unnecessary include.
>> [...]
>>> I don't immediately see where this include is needed. Is this a
>>> leftover ?
>> [...]
>>> Same here.
>>
>> Are there ways to systematically tell which includes are useless
>> besides commenting them out all and uncommenting until it compiles ?
>> (if that is even a good idea)
> 
> I tried this, just to get a baseline: the module compiles with just
>    linux/hwmon.h
>    linux/mfd/da9063/core.h
>    linux/module.h
>    linux/platform_device.h
>    linux/regmap.h
> 
> Beyond what you suggested this also gets rid of:
> - seems reasonable:
>    - linux/delay.h
>    - linux/init.h
>    - linux/slab.h

... except that slab.h was probably originally included for kzalloc().
The driver now uses devm_kzalloc() which is defined in linux/device.h,
so you'll need to include that instead.

> - looks suspicious to me:
>    - linux/err.h, which means the error constants are indirectly
>      imported. Removing it feels brittle.

It also defines PTR_ERR_OR_ZERO(), so it is definitely needed.

Guenter

>    - linux/kernel.h, although to my surprise a lot of c files do not
>      include it.
> 
> By default I'll drop the former and keep the latter in the
> next version, please let me know if another combination is preferred.
> 

