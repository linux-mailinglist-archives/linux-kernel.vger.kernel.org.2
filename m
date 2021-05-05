Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE61F373DBE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 16:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbhEEOgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 10:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhEEOgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 10:36:53 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BABC1C061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 07:35:55 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id y26so2323154eds.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 07:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=cjsgc6m4DTTLUyq1f0xInkAE2RsCp3svCa+ztyH86wA=;
        b=KB7tudvluCc3v4ediS8OaiTZUb7UYk8T83Q0YZKfyITJTDadtkHXTcb8NInQsih+8N
         X6dx7NiSP/dFdV8DXQsoUtzWT8Sb8wf5mHayRQKbsM+iIJs/USSgeBIJcDL63JThiv4s
         h8a7yNSefnweSfRkMLBoWzikMHQPSgEmRNeXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cjsgc6m4DTTLUyq1f0xInkAE2RsCp3svCa+ztyH86wA=;
        b=jU4CqivOKoorPLfA2CNVbT7KX6D5pgIBAwJBPEBBdVyYonjv3ct593/yDZv/d99J92
         K4DpiJkMt0OdEYEHId5/hrkwEtC7Q/tIQ923Fzgzz1Yp3Z2apZWCqu3iqKynSXuquhma
         ooPc+0cveyCg/ne8pjRr3HJpXwZP/YcrBswWXkcH4NPVmDxEZw3/8dioA0bpwqW9ht1z
         Ys8sgOeG5MG8/yajss+fgWC6111YnaHkFrhEHZy7fTIuW0mu0ItZUgpzagN/LS7yar2Q
         OmzwuXH86pHEjDCFGJ6wZcjzNLpNqCN7hXfyoT3b/5H/eIHy15Hsw2CHua8suP41o5nq
         p65g==
X-Gm-Message-State: AOAM530CNq/5alsndPzRqUfu0Xi/+rHDC8EG3utM2qhcbecoEP3QmeAn
        y5fJxho8P82wpIaSZcA4ASzo4V/mw/7iW+ep
X-Google-Smtp-Source: ABdhPJw0X888ElGOQcBn3FGBUTncozUSWWrTKksjm9JjT79jxLF+MiPVkMvKBSSCHePYRoL+aR7skA==
X-Received: by 2002:aa7:d685:: with SMTP id d5mr33217047edr.200.1620225354208;
        Wed, 05 May 2021 07:35:54 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id lr15sm2947607ejb.107.2021.05.05.07.35.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 May 2021 07:35:53 -0700 (PDT)
Subject: Re: [PATCH] vsscanf() in lib/vsprintf.c
To:     Stefan Kanthak <kanthak@arcor.de>, linux-kernel@vger.kernel.org
References: <6C7CD73845304CDE98F6DB165904B571@H270>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <91e60831-3f8b-a81d-1204-872b5ee79feb@rasmusvillemoes.dk>
Date:   Wed, 5 May 2021 16:35:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <6C7CD73845304CDE98F6DB165904B571@H270>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2021 21.19, Stefan Kanthak wrote:
> Hi @ll,
> 
> both <https://www.kernel.org/doc/htmldocs/kernel-api/API-sscanf.html>
> and <https://www.kernel.org/doc/htmldocs/kernel-api/API-vsscanf.html>
> are rather terse and fail to specify the supported arguments and their
> conversion specifiers/modifiers.
> 
> <https://www.kernel.org/doc/htmldocs/kernel-api/libc.html#id-1.4.3>
> tells OTOH:
> 
> | The behaviour of these functions may vary slightly from those
> | defined by ANSI, and these deviations are noted in the text.
> 
> There is but no text (see above) despite multiple deviations from
> ANSI C 
> 
> <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/lib/vsprintf.c?h=v5.12>
> 
> |  /* '%*[' not yet supported, invalid format */
> ...
> |  /*
> |   * Warning: This implementation of the '[' conversion specifier
> |   * deviates from its glibc counterpart in the following ways:
> ...
> 
> More deviations (just from reading the source):
> 
> 1. no support for %p

What on earth good would that do in the kernel?

> 2. no support for conversion modifiers j and t

Could be added, but do you have a user?

> 3. no support for multibyte characters and strings, i.e. %<width>c
>    and %<width>s may split UTF-8 codepoints

So what? The kernel doesn't do a lot of text processing and wchar_t stuff.

> 4. accepts %[<width>]<modifier>[c|s], but ignores all conversion
>    modifiers

Yeah, %ls is technically accepted and treated as %s, that's mostly for
ease of parsing it seems. Do you have a use case where you'd want wchar_ts?

> 5. treats %<width><modifier>% (and combinations) as %%

What would you expect it to do? Seems to be a non-issue, gcc flags that
nonsense just fine

vs.c: In function ‘v’:
vs.c:5:18: warning: conversion lacks type at end of format [-Wformat=]
    5 |  x = sscanf(s, "%l% %d", &y);
      |                  ^
vs.c:5:20: warning: unknown conversion type character ‘ ’ in format
[-Wformat=]
    5 |  x = sscanf(s, "%l% %d", &y);
      |                    ^

> 6. accepts %<width><modifier>n (and combinations)

Again, non-issue (warning: field width used with ‘%n’ gnu_scanf format)

> 7. doesn't scan the input for %[...]n

? What's that supposed to mean.

> 8. uses simple_strto[u]l for the conversion modifier z, i.e. assigns
>    uint32_t to size_t, resulting in truncation

Where do you see uint32_t? The code is

                       val.u = qualifier != 'L' ?
                                simple_strtoul(str, &next, base) :
                                simple_strtoull(str, &next, base);

                case 'z':
                        *va_arg(args, size_t *) = val.u;
                        break;

so the conversion is done with simple_strtoul which return "unsigned
long". And size_t is either a typedef for "unsigned long" or "unsigned
int", so yes, of course a truncation may happen, but if the value
actually fits in a size_t, it also fits in unsigned long (as returned
from simple_strtoul) and unsigned long long (as stored in val.u).

Rasmus
