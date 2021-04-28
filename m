Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7922036D367
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 09:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236453AbhD1HsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 03:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236343AbhD1HsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 03:48:00 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E033C061574
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 00:47:15 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id d14so9189486edc.12
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 00:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KOCyJSQV5kMAmV9TYK2EqXDU19Gw1lG5UFQZk0GWY84=;
        b=HZXxQcXBhoZ+o2j2/Gt/KuazAmjL+DqNUvH+asyETkEvik0FUmuBryFWb7rqriBi0x
         pbJOuwxKahPshTjr/auivHmfKcegKQR2GTFgnhs6aMCW8cSFCjbabfJzHq8gDap3f6jC
         3Kz8gkYguvJNiG2tt/CqZTaoaCpyVKulbfkS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KOCyJSQV5kMAmV9TYK2EqXDU19Gw1lG5UFQZk0GWY84=;
        b=t2Ix5UsM1qEk9ujoYdKzat6FT2KVPXm0dpSm56U47mvLLijfmN1Q7YYe5nE0mzYyRP
         z8WQv8F1pCrUYPjWKROfmekowPWkko62WY0PGTTri30U6X2djFt50l3zz/qQXUhIREcA
         pMmceKPR7n0VS4ZHPw8II28TD+VZYyuqvQVr4F9ZxgvDIssQsB3yLD7Kgnom2L6bqU3w
         Z/9vnVjIb8a8muvFPxVL8WU3lysNI9E8FQtNS8Xpl+eBmR6OUfKRCE0fKNU2fKByqqGd
         SnSPWPoU1gavEYlK7HLVmdwHRtoWfvxDcOsBcbw9Guafy4Z4ifP+DgssxpBiWHEtADDm
         Lcsg==
X-Gm-Message-State: AOAM531viok7NsGgC+4c8cgQrYWFsmYuklhNdSRnNj1FokIij6qYTslB
        hGccarwSlXyWkgafnxvYuNgfMg==
X-Google-Smtp-Source: ABdhPJx9YYoIZez/CWS94miMKMQKvKpLSPkYyhptXhg9RS69mkpUa/NETKoupSCmFmkUghL5IngI3A==
X-Received: by 2002:aa7:d9ce:: with SMTP id v14mr9408291eds.110.1619596034109;
        Wed, 28 Apr 2021 00:47:14 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id v14sm2564951eds.34.2021.04.28.00.47.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Apr 2021 00:47:13 -0700 (PDT)
Subject: Re: [PATCH] lib/string: sysfs_streq works case insensitively
To:     Gioh Kim <gi-oh.kim@ionos.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20210412113315.91700-1-gi-oh.kim@ionos.com>
 <CAJX1YtbXnPVbkpddXQf4MZ3sopoidr0fZ8OkrQegoLoCevaNwQ@mail.gmail.com>
 <CAHp75Vf2yJ5=zdxRcPKmKGCKeF8As=Nv2S9fm0ciVXL5HGbWDg@mail.gmail.com>
 <CAJX1YtYRK=_X8+mvva2S35-K4kpwXSAGctUJ01TEDFRhS0y5LA@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <650dc1b8-d801-2263-2e5c-eb833f2c4534@rasmusvillemoes.dk>
Date:   Wed, 28 Apr 2021 09:47:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAJX1YtYRK=_X8+mvva2S35-K4kpwXSAGctUJ01TEDFRhS0y5LA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/04/2021 09.31, Gioh Kim wrote:
> On Wed, Apr 28, 2021 at 8:42 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>>

>>
>> Are you sure it’s good change? Sysfs is used for an ABI and you are opening a can of worms. From me NAK to this change without a very good background description that tells why it is safe to do.
> 
> https://www.spinics.net/lists/kernel/msg3898123.html
> My initial idea was making a new function: sysfs_streqcase.
> Andrew and Greg suggested making sysfs_streq to be case-insensitive.
> I would like to have a discussion about it.

1. That information should be in the commit log, not some random
babbling about case sensitivity of file systems.

2. So as Andy says, this is changing ABI for a whole lot of users in one
go. While it's _probably_ true that nobody would care (because it just
ends up accepting more strings, not fewer), your motivation seems to be
to replace uses of strncasecmp() to prevent "disableGARBAGE@#$@#@" to be
accepted as equivalent to "disable". I.e., those potential new users of
sysfs_streq() would have their ABI changed towards being less
permissive. That's a bigger change, with a higher chance of breaking
something. Do you even know if the maintainers of those drivers would
accept a switch to a case-insensitive sysfs_streq()?

Sorry, I really think you need a lot stronger motivation for introducing
either this change or a sysfs_strcaseeq().

Rasmus
