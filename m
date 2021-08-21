Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5DEC3F3AC0
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 15:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbhHUNTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 09:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbhHUNTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 09:19:08 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C336BC061575;
        Sat, 21 Aug 2021 06:18:28 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id d15so3231874vko.3;
        Sat, 21 Aug 2021 06:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=uFRmRO4bx547JQZk7zfcmX9Gg3inUL3DdB+b66UoXCI=;
        b=us3iTR4CLxM0+GA8QA3f6a3mlRRsF3Q2Ld+SlE2F2gzTxZDtQNQNggdpO+ZZWTFYBd
         j2T9h8TYuqX7YyLgOb1P5OGKJ3uYvwKoyuNBHI7o8vMErWqo1Ac1p9Mt5y/HggCI4jVj
         6t5sIh1bI7uyrDeHgiA9Z57PQFedHu1vGe3LeMjH8sdMIhk4EnA6kjSS9nTJ6UzKOLaa
         pNtIAGVF0m55aKV1eSvngbWAooLgJtLcomptNnmzA4X0RMHAyZnNP0LGj0zM1Dvyo5Pc
         g/yEGtVWtNCPkKTer+kwyqv9e29ft9gc99+2usOG2UooNYw83BJNlG+G3gnrhc+GLbBH
         EyXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=uFRmRO4bx547JQZk7zfcmX9Gg3inUL3DdB+b66UoXCI=;
        b=jWxecsYb9bUeKuX1Q+jCw1Uo7ZtOevAvEKfqftkLe0AYM4p7AJq54Tqw0eYCBbfV9n
         P38Elsg48e9uaeWy4xFoov/qo5/Kzxg/RSew6hoJr5NpQ6t47bQ2QsZHOoyQp38hCnXG
         pcKEK2XMVkZHVM6cj6h1NVIES7EDrCquczMdPUMoMm0P2u/v6fP3nzLj9JL8qtV7JluZ
         tlBECBKdddLNAZVLE2dzUh6n1dRDcjYkor/ypWD3eQZy0LKjewJHdrqNjMUtezMKvNM6
         SwRT+UIwHnWw2xI5BCm4JIZF7DnzCy//QD9TDw1Uvko4YRGiOrcwuJRdBSRQonT6B24v
         7ygw==
X-Gm-Message-State: AOAM532BELD6mdah/J/PUyZAwrWf6TG4JLGWsEYjYA1V7Hcnt8FSfh8p
        MHmaHvRynjB/NpdXN2lTFLv3v4Zq97FNG3p2e/k=
X-Google-Smtp-Source: ABdhPJzmp2SOuNpw1ADlYvu3NOsjaBxJHjR8nwQHCkWAiIPQw4YRT4Ny75/C8BbP6O5RqhkQgbdax/sutzEu5T/PKMY=
X-Received: by 2002:a1f:a10f:: with SMTP id k15mr18827961vke.3.1629551907793;
 Sat, 21 Aug 2021 06:18:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:55cf:0:0:0:0:0 with HTTP; Sat, 21 Aug 2021 06:18:27
 -0700 (PDT)
In-Reply-To: <87zgtbpvgq.fsf@meer.lwn.net>
References: <20210820222152.971174-1-henrybear327@gmail.com> <87zgtbpvgq.fsf@meer.lwn.net>
From:   Henry Tseng <henrybear327@gmail.com>
Date:   Sat, 21 Aug 2021 15:18:27 +0200
Message-ID: <CAA5xa-mewxNmr9HJvWQVXRgTkG_1us90E76CHgd9gz1Jr1FK-A@mail.gmail.com>
Subject: Re: [PATCH v3] Documentation: Update details of The Linux Kernel
 Module Programming Guide
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     jmseyas@dit.upm.es, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/21, Jonathan Corbet <corbet@lwn.net> wrote:
> Chun-Hung Tseng <henrybear327@gmail.com> writes:
>
>> Recently, the content and examples of the book "The Linux Kernel Module
>> Programming Guide" are being actively maintained and added on Github[1].
>> Currently, the book is being regularly built into webpage and pdf
>> file using Github static page[2].
>>
>> [1]: https://github.com/sysprog21/lkmpg
>> [2]: https://sysprog21.github.io/lkmpg/
>>
>> Signed-off-by: Chun-Hung Tseng <henrybear327@gmail.com>
>> ---
>>  Documentation/process/kernel-docs.rst | 14 ++++++++------
>>  1 file changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/process/kernel-docs.rst
>> b/Documentation/process/kernel-docs.rst
>> index 22d9ace5df2a..dd911cf09b55 100644
>> --- a/Documentation/process/kernel-docs.rst
>> +++ b/Documentation/process/kernel-docs.rst
>> @@ -126,15 +126,17 @@ On-line docs
>>          describes how to write user-mode utilities for communicating
>> with
>>          Card Services.
>>
>> -    * Title: **Linux Kernel Module Programming Guide**
>> +    * Title: **The Linux Kernel Module Programming Guide**
>>
>> -      :Author: Ori Pomerantz.
>> -      :URL: https://tldp.org/LDP/lkmpg/2.6/html/index.html
>> -      :Date: 2001
>> +      :Author: Peter Jay Salzman, Michael Burian, Ori Pomerantz, Bob
>> Mottram,
>> +      Jim Huang.
>> +      :URL: https://sysprog21.github.io/lkmpg/
>> +      :Date: 2021
>>        :Keywords: modules, GPL book, /proc, ioctls, system calls,
>>          interrupt handlers .
>> -      :Description: Very nice 92 pages GPL book on the topic of modules
>> -        programming. Lots of examples.
>> +      :Description: A very nice GPL book on the topic of modules
>> +        programming. Lots of examples. Currently the new version is
>> being
>> +        actively maintained at https://github.com/sysprog21/lkmpg.
>
> I have applied this, thanks.
>
> That said, this change introduced a set of build warnings:
>
>     Documentation/process/kernel-docs.rst:132: WARNING: Field list ends
> without a blank line; unexpected unindent.
>     Documentation/process/kernel-docs.rst:136: WARNING: Unexpected
> indentation.
>     Documentation/process/kernel-docs.rst:137: WARNING: Block quote ends
> without a blank line; unexpected unindent.
>
> To fix that, I had to do this:
>
> diff --git a/Documentation/process/kernel-docs.rst
> b/Documentation/process/kernel-docs.rst
> index dd911cf09b55..da9527502ef0 100644
> --- a/Documentation/process/kernel-docs.rst
> +++ b/Documentation/process/kernel-docs.rst
> @@ -129,7 +129,7 @@ On-line docs
>      * Title: **The Linux Kernel Module Programming Guide**
>
>        :Author: Peter Jay Salzman, Michael Burian, Ori Pomerantz, Bob
> Mottram,
> -      Jim Huang.
> +        Jim Huang.
>        :URL: https://sysprog21.github.io/lkmpg/
>        :Date: 2021
>        :Keywords: modules, GPL book, /proc, ioctls, system calls,
>
> Please, be sure to test the docs build before sending patches.
>

Hi Jon,

Thank you for applying the patch and giving me feedback!

I will be more careful in the future.

Thank you!

Best wishes,
Henry


> Thanks,
>
> jon
>
