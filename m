Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2CF13484C3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 23:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238869AbhCXWmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 18:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238860AbhCXWmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 18:42:15 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74EDC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 15:42:14 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id b83so34400324lfd.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 15:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yweKdnG+O3iqYbcal7imGQG/EFv/H1MS2KenKhFkvcs=;
        b=nzkSJ6AOc9GKeMM90U83xVTrOngQX29A1z5GreadU+KF2BcL9oN2GQafpgWwRZ451f
         pNQ3r6oIba58iYn/um5QysEL2nnxJL+xufZVIJX15lAzP6IPTxLKVscg/hHTVtGsRE84
         UrTa27aE+puVsE1dRHbI4qICSHq52p7vP+vrzaEuKHm2qiX3S6OJWC/BChcHxfuv6Wbl
         k2bgyXQjNVWhFjlFYH85eYrzzXs0nWmeuYYCBMj5+Rucdjx03n8pCshp7sHo95mp4lDN
         kh+1Kk4dwjPMTrBJieDyX9EqyOj4OibS8BDuLa6ZXvI9zXLJR9GyrcSrSsnrfWN89VUl
         OJ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yweKdnG+O3iqYbcal7imGQG/EFv/H1MS2KenKhFkvcs=;
        b=TwAa808DcXPE93+OMEoFQwsSpfTFVs7Db9uzGAhiRG9PVMEC2FKRcDmkP1yaAgU1Dp
         PDv3y7l03BjYSz4voJpMxnXXHO0Brdjh7DIwDKNoKTV3xgX4vKNW9gNBy157Cu+KHJY0
         S52E1mB+2ChuT/wi0u4TEyiOYvMIux06TP4iw7QIhRtNxtecFLIZGtt5NvPe3VWRVHMT
         nlSpONoWMoteplohmWV9W3Ka0SOSZHfULY0ZlcNyam/BlnDGyyGiPh+dIwLnaKGy7axs
         Je/S3cBn93ULGl5jgeztlPJ5GKRUgezJKjXeC5qFQaNzEFIdGsAfAlDT5GlAOlWqbQY/
         0I0A==
X-Gm-Message-State: AOAM533jyN9D83eu3yCLYGZkhsiMWC8Y8Ii2MpbicYKKo5fM/2MydFtD
        IuhkPI4FqmMVYrtaNjnO0ik=
X-Google-Smtp-Source: ABdhPJyObCrS0yAzGTGTEhc80JUy5MBkQFTtW7SfVKwCjRfXa2tkvDDvhXJUpdQmB2jUPpHaVeXMKg==
X-Received: by 2002:ac2:4896:: with SMTP id x22mr3162483lfc.565.1616625733329;
        Wed, 24 Mar 2021 15:42:13 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-60.dynamic.spd-mgts.ru. [109.252.193.60])
        by smtp.googlemail.com with ESMTPSA id y1sm351003lfy.75.2021.03.24.15.42.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Mar 2021 15:42:12 -0700 (PDT)
Subject: Re: [PATCH v7] mm: cma: support sysfs
To:     John Hubbard <jhubbard@nvidia.com>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        gregkh@linuxfoundation.org, surenb@google.com, joaodias@google.com,
        willy@infradead.org, Colin Ian King <colin.king@canonical.com>
References: <20210324205503.2132082-1-minchan@kernel.org>
 <65840bfd-4471-7c8d-ce71-c4705baf3bfe@gmail.com>
 <0ac4d495-eece-fb71-d334-a46e069b0c35@nvidia.com>
 <0396987d-1331-51a0-83f4-0c49dd3e150c@gmail.com>
 <b5607405-d794-0035-e8db-5525aee29e28@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <8f147942-9a94-1e36-b608-4dd883af29b1@gmail.com>
Date:   Thu, 25 Mar 2021 01:42:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <b5607405-d794-0035-e8db-5525aee29e28@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

25.03.2021 01:23, John Hubbard пишет:
> On 3/24/21 3:11 PM, Dmitry Osipenko wrote:
>> 25.03.2021 01:01, John Hubbard пишет:
>>> On 3/24/21 2:31 PM, Dmitry Osipenko wrote:
>>>> ...
>>>>> +#include <linux/kobject.h>
>>>>> +
>>>>> +struct cma_kobject {
>>>>> +    struct cma *cma;
>>>>> +    struct kobject kobj;
>>>>
>>>> If you'll place the kobj as the first member of the struct, then
>>>> container_of will be a no-op.
>>>>
>>>
>>> However, *this does not matter*. Let's not get carried away. If
>>> container_of() ends up as a compile-time addition of +8, instead
>>> of +0, there is not going to be a visible effect in the world.
>>> Or do you have some perf data to the contrary?
>>>
>>> Sometimes these kinds of things matter. But other times, they are
>>> just pointless to fret about, and this is once such case.
>>
>> Performance is out of question here, my main point is about maintaining
> 
> In that case, there is even less reason to harass people about the order
> of members of a struct.
> 
>> a good coding style. Otherwise there is no point in not embedding kobj
>> into cma struct as well, IMO.
> 
> 
> We really don't need to worry about the order of members in a struct,
> from a "coding style" point of view. It is a solid step too far.
> 
> Sorry if that sounds a little too direct. But this review has tended to
> go quite too far into nitpicks that are normally left as-is, and I've
> merely picked one that is particularly questionable. I realize that other
> coding communities have their own standards. Here, I'm explaining what
> I have observed about linux-mm and linux-kernel, which needs to be
> respected.

I tried to help as much as I could, sorry if this felt annoying to you
or anyone else.

I assume that linux-mm maintainers, like any other maintainers, should
skip all suggestions that are deemed as inappropriate to them.
