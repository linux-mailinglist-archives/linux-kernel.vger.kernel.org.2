Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A377837442D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 19:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235597AbhEEQzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 12:55:44 -0400
Received: from smtpout2.vodafonemail.de ([145.253.239.133]:55892 "EHLO
        smtpout2.vodafonemail.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236229AbhEEQr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 12:47:59 -0400
Received: from smtp.vodafone.de (smtpa07.fra-mediabeam.com [10.2.0.38])
        by smtpout2.vodafonemail.de (Postfix) with ESMTP id ACF4A120A4C;
        Wed,  5 May 2021 18:47:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arcor.de;
        s=vfde-smtpout-mb-15sep; t=1620233220;
        bh=hSsWZO88tXF3BwJSxFyOa2HrT9AGLMOotWsm79XkQrE=;
        h=From:To:References:In-Reply-To:Subject:Date;
        b=XhYFyx1UrcLqUOTTZn4PaihYlEg1J88bf5GyAtNrOUO/bHf5u4dEQqcFnJbBymUyp
         BCcQFQwztbC2+8DHxES4+g2C7KXx2az2/aWd3SevSIQih7IkSxXvM6kfDk4damJ4q5
         BARFF1xQUrDJLMA1asu56W8jigJEOPF3v4Svg8Os=
Received: from H270 (p5b38f6a1.dip0.t-ipconnect.de [91.56.246.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.vodafone.de (Postfix) with ESMTPSA id E20E9140271;
        Wed,  5 May 2021 16:46:59 +0000 (UTC)
Message-ID: <0B0CF00BA2FA4A039427A213640378A2@H270>
From:   "Stefan Kanthak" <kanthak@arcor.de>
To:     <linux-kernel@vger.kernel.org>,
        "Rasmus Villemoes" <linux@rasmusvillemoes.dk>
References: <6C7CD73845304CDE98F6DB165904B571@H270> <91e60831-3f8b-a81d-1204-872b5ee79feb@rasmusvillemoes.dk>
In-Reply-To: <91e60831-3f8b-a81d-1204-872b5ee79feb@rasmusvillemoes.dk>
Subject: Re: [PATCH] vsscanf() in lib/vsprintf.c
Date:   Wed, 5 May 2021 18:41:24 +0200
Organization: Me, myself & IT
MIME-Version: 1.0
Content-Type: text/plain;
        charset="Windows-1252"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Windows Mail 6.0.6002.18197
X-MimeOLE: Produced By Microsoft MimeOLE V6.1.7601.24158
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 3106
X-purgate-ID: 155817::1620233220-0000067D-080AAAAC/0/0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:
> On 04/05/2021 21.19, Stefan Kanthak wrote:
>> Hi @ll,
>>
>> both <https://www.kernel.org/doc/htmldocs/kernel-api/API-sscanf.html>
>> and <https://www.kernel.org/doc/htmldocs/kernel-api/API-vsscanf.html>
>> are rather terse and fail to specify the supported arguments and their
>> conversion specifiers/modifiers.
>>
>> <https://www.kernel.org/doc/htmldocs/kernel-api/libc.html#id-1.4.3>
>> tells OTOH:
>>
>> | The behaviour of these functions may vary slightly from those
>> | defined by ANSI, and these deviations are noted in the text.
>>
>> There is but no text (see above) despite multiple deviations from
>> ANSI C
>>
>> <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/lib/vsprintf.c?h=v5.12>
>>
>> |  /* '%*[' not yet supported, invalid format */
>> ...
>> |  /*
>> |   * Warning: This implementation of the '[' conversion specifier
>> |   * deviates from its glibc counterpart in the following ways:
>> ...
>>
>> More deviations (just from reading the source):
>>
>> 1. no support for %p
>
> What on earth good would that do in the kernel?

| The behaviour of these functions may vary slightly from those
| defined by ANSI, and these deviations are noted in the text.
                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> 2. no support for conversion modifiers j and t
>
> Could be added, but do you have a user?

Just fix your documentation.

>> 3. no support for multibyte characters and strings, i.e. %<width>c
>>    and %<width>s may split UTF-8 codepoints
>
> So what?

It's a BUG!

> The kernel doesn't do a lot of text processing and wchar_t stuff.

Nobody will ever feed a UTF-8 string to the kernel?

>> 4. accepts %[<width>]<modifier>[c|s], but ignores all conversion
>>    modifiers
>
> Yeah, %ls is technically accepted and treated as %s,

just like %Ls and %Hs and %hhs and %zs ... what the documentation
but fails to tell: just fix it.

> that's mostly for ease of parsing it seems. Do you have a use
> case where you'd want wchar_ts?

>> 5. treats %<width><modifier>% (and combinations) as %%
>
> What would you expect it to do?

See the patch: stop and return the number of converted items, like
an ANSI/ISO conformant scanf()

> Seems to be a non-issue, gcc flags that nonsense just fine

Nobody will ever feed a non-constant format string to [v]sscanf()?

>> 6. accepts %<width><modifier>n (and combinations)
>
> Again, non-issue (warning: field width used with ‘%n’ gnu_scanf format)

How does gnu_scanf() handle %0Ln etc.?
Does a warning stop compilation of the kernel?

See above: it's undocumented, and it's not flagged in calls with
non-constant format string.

>> 7. doesn't scan the input for %[...]n
>
> ? What's that supposed to mean.

Argh, my fault: should have been %*

>> 8. uses simple_strto[u]l for the conversion modifier z, i.e. assigns
>>    uint32_t to size_t, resulting in truncation
>
> Where do you see uint32_t?

LLP64 vs. LP64, so my last point is invalid.

Stefan

