Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1831836D498
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 11:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237931AbhD1JNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 05:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbhD1JNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 05:13:54 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0775C061574
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 02:13:08 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id g10so5352570edb.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 02:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zuJ82puTHqZvGhCMj8B6h5SzrRJTy69WAZAQZBqxSiQ=;
        b=BmZFgYYLnjEt40CB2BFRTh2ATwa715HVEkdsPnOYQ8yMm6wh6xy4tyMFStm+7c/BGh
         +yMeapcMlv7njQjAcuO+OJ8StqaOzyThoqO1tHYaQRlxKqiYvmYjemp7v6w0LeJilVMM
         HUOPsw7eqNSU7qD9WNsnkZPrQDtxojfcZFdnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zuJ82puTHqZvGhCMj8B6h5SzrRJTy69WAZAQZBqxSiQ=;
        b=MsPQUPgKMarlcgD+5EIq5Zrd4fjynEyvAS/Vhm9ZnRQqBQzKWXMVvmHEF9+pdg8etf
         JqYxl/RjZYTNZ4ibddfnfI6OW67uvYT+mj6CeyERCeDwRK7QjzN4W8lNMhEcPzJNVhkm
         PP10uqhVReR03G8bckR+RhJRjvD7HOrpwDtXFgzItNL5FM8LuiMA2YOQfmKtpxuYqZPq
         cweW2nXAo6kbIBY/oGLTI5Gm1nd/jw3GWCnXoAkFqcpWKAa7UxelHGkK8ur4BToR4Y/2
         VVIpq8b2LJxJEtojqp2KIvwwJQVRNG+7cLM/Tq6tB5NTigvIsfn9w51MH5xVJwod5EbA
         oe6w==
X-Gm-Message-State: AOAM533j6jM52jU2prQSuKDRIjxbscv9fEvXm8maDt6S+9Z5qDKuA4ZC
        TPku1HSx+O95mmfDGepDevMmdw==
X-Google-Smtp-Source: ABdhPJzaOEGKbDD45sYI1dUDHD8YTTiiAB142e2QgrObP9pXVb0ZOjD3lWFGKvpypv0uGEO+Wsq+VA==
X-Received: by 2002:a50:f28e:: with SMTP id f14mr10001002edm.371.1619601187486;
        Wed, 28 Apr 2021 02:13:07 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id h23sm1555273ejx.90.2021.04.28.02.13.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Apr 2021 02:13:07 -0700 (PDT)
Subject: Re: [PATCH] lib/string: sysfs_streq works case insensitively
To:     Gioh Kim <gi-oh.kim@ionos.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20210412113315.91700-1-gi-oh.kim@ionos.com>
 <CAJX1YtbXnPVbkpddXQf4MZ3sopoidr0fZ8OkrQegoLoCevaNwQ@mail.gmail.com>
 <CAHp75Vf2yJ5=zdxRcPKmKGCKeF8As=Nv2S9fm0ciVXL5HGbWDg@mail.gmail.com>
 <CAJX1YtYRK=_X8+mvva2S35-K4kpwXSAGctUJ01TEDFRhS0y5LA@mail.gmail.com>
 <650dc1b8-d801-2263-2e5c-eb833f2c4534@rasmusvillemoes.dk>
 <CAJX1YtaRAgg3oZ6X2cDtj0yASQ27XujDys97vbB0MWnN9vXakQ@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <64dc3e52-2146-3da4-3d04-d5c074723aba@rasmusvillemoes.dk>
Date:   Wed, 28 Apr 2021 11:13:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAJX1YtaRAgg3oZ6X2cDtj0yASQ27XujDys97vbB0MWnN9vXakQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/04/2021 10.31, Gioh Kim wrote:
> On Wed, Apr 28, 2021 at 9:47 AM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
>>
>> On 28/04/2021 09.31, Gioh Kim wrote:
>>> On Wed, Apr 28, 2021 at 8:42 AM Andy Shevchenko
>>> <andy.shevchenko@gmail.com> wrote:
>>>>
>>
>>>>
>>>> Are you sure it’s good change? Sysfs is used for an ABI and you are opening a can of worms. From me NAK to this change without a very good background description that tells why it is safe to do.
>>>
>>> https://www.spinics.net/lists/kernel/msg3898123.html
>>> My initial idea was making a new function: sysfs_streqcase.
>>> Andrew and Greg suggested making sysfs_streq to be case-insensitive.
>>> I would like to have a discussion about it.
>>
>> 1. That information should be in the commit log, not some random
>> babbling about case sensitivity of file systems.
> 
> I don't think it is a good idea to write who suggested the concept of the patch.

Sorry if it wasn't clear. I was referring to the information in that
link (i.e., your commit log for the first suggested patch).

>> Sorry, I really think you need a lot stronger motivation for introducing
>> either this change or a sysfs_strcaseeq().
> 
> I found out a problem of sysfs_streq when I tried to use it for
> modules I am working on (RTRS/RNBD).

Again, this is the kind of motivation that would need to be in the
commit log. What problem are you solving in those modules that warrants
changing the semantics of sysfs_streq()? Why does that module's sysfs
interface need case-insensitive string comparison?

> Then I thought it would be better if there is something like sysfs_streqcase.
> That's why I sent the path.
> If nobody needs the change, it is ok for me to ignore the patch.

It's a lot easier to assess the merits of this new functionality
(whether in the form of a new separate function, or changed semantics of
sysfs_streq()) if we also see a few use cases. New functions are not
added without users. Bells and whistles are not added without users.

> Maybe I misunderstand when I can send a patch to Linux kernel community.
> But the only motivation of me is sharing my idea just in case there is
> someone who also needs it.

That's fine, but you need to include proper information on why a new
function is added or semantics of an existing one is changed (and for
the latter, some words on why you believe all existing callers would be
ok with that).

Rasmus
