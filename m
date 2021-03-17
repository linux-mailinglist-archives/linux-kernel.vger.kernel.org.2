Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D38AE33F99B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 20:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbhCQT6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 15:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232738AbhCQT6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 15:58:08 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04132C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 12:58:07 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id b7so277687ejv.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 12:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x4IGcsHfRHycoSHLPZQ+NuslKEl3l2YvsWJ1PFXzklk=;
        b=JqxN+CFe/NaS/NzFERcRLLKPg0TfFvh8Fz5nf9sL33Ck2ghJ4rk5zvve728WVXGwd4
         3ZX/jpSaOU656oLPHszQN2j7Splt5awsSBLMH9OPyZ254djlW64zTdNNVPAZ2aawpw0+
         swaKQpDJiXYmM158b7CJczbK8uKQ4xwZuTZz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x4IGcsHfRHycoSHLPZQ+NuslKEl3l2YvsWJ1PFXzklk=;
        b=dZSO/VHz+OlMhaCnCdtgGdGBb+OEncS7vbBbLQjgVrRth7KLsG3E6IWOP0mXZ1OoF1
         zj4BLgfV90zbNGgmsFtiurLA8wHoQT+KwHqoAcSTx9S+msRRsfTe2wglpu6jFWrzpAma
         4H9fKiyFsc4kAdbBuiDpE3jidpSwO/8XYRDlk2R0VtHJXiEE5CEzt3+IyKGDFjI5gheo
         XKutolqTooduW9XFRsjjMKt/7VJttSjiTt80afFzOyy6t8CSm8bgc4ntBqq0USNsFY51
         Ur1chgq/R3XzcrjJKRonlJCzTz+kZ46K6cHzNzgaOpTJ8EFkkBz8ZgFs/oXp2yapfJ3x
         682w==
X-Gm-Message-State: AOAM532RZ102gmCgkNjUCrpeRbM5y70oqqRq3aSe3B9Z45ckYAr2DIMd
        FJk/b1N+k8pszN1F6BKwjqgOiQ==
X-Google-Smtp-Source: ABdhPJz3x0Kx2IcUjecWgHYdTHTJSzGTzvplsxljz1MpSf63wyaqqdylSKRC8kjeIJypJsGKxgxOZQ==
X-Received: by 2002:a17:907:628a:: with SMTP id nd10mr34493570ejc.326.1616011086544;
        Wed, 17 Mar 2021 12:58:06 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id j14sm13504206eds.78.2021.03.17.12.58.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Mar 2021 12:58:05 -0700 (PDT)
Subject: Re: [PATCH 04/13] lib: introduce BITS_{FIRST,LAST} macro
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-arch@vger.kernel.org, linux-sh@vger.kernel.org,
        Alexey Klimov <aklimov@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, David Sterba <dsterba@suse.com>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jianpeng Ma <jianpeng.ma@intel.com>,
        Joe Perches <joe@perches.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Rich Felker <dalias@libc.org>,
        Stefano Brivio <sbrivio@redhat.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
References: <20210316015424.1999082-1-yury.norov@gmail.com>
 <20210316015424.1999082-5-yury.norov@gmail.com>
 <8021faab-e592-9587-329b-817ae007b89a@rasmusvillemoes.dk>
 <YFCZtUuMYVNeNlUO@smile.fi.intel.com>
 <20210317054057.GC2114775@yury-ThinkPad>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <8bcffb72-f9cb-7ca0-950d-527dda6545ac@rasmusvillemoes.dk>
Date:   Wed, 17 Mar 2021 20:58:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210317054057.GC2114775@yury-ThinkPad>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/03/2021 06.40, Yury Norov wrote:
> On Tue, Mar 16, 2021 at 01:42:45PM +0200, Andy Shevchenko wrote:

>>> It would also be much easier to review if you just redefined the
>>> BITMAP_LAST_WORD_MASK macros etc. in terms of these new things, so you
>>> wouldn't have to do a lot of mechanical changes at the same time as
>>> introducing the new ones - especially when those mechanical changes
>>> involve adding a "minus 1" everywhere.
>>
>> I tend to agree with Rasmus here.
> 
> OK. All this plus terrible GENMASK(high, low) design, when high goes
> first, makes me feel like we need to deprecate GENMASK and propose a
> new interface.
> 
> What do you think about this:
> BITS_FIRST(bitnum)      -> [0, bitnum)
> BITS_LAST(bitnum)       -> [bitnum, BITS_PER_LONG)
> BITS_RANGE(begin, end)  -> [begin, end)

Better, though I'm not too happy about BITS_LAST(n) not producing a word
with the n highest bits set. I dunno, I don't have better names.
BITS_FROM/BITS_UPTO perhaps, but not really (and upto sounds like it is
inclusive). BITS_LOW/BITS_HIGH have the same problem as BITS_LAST.

Also, be careful to document what one can expect from the boundary
values 0/BITS_PER_LONG. Is BITS_FIRST(0) a valid invocation? Does it
yield 0UL? How about BITS_FIRST(BITS_PER_LONG), does that give ~0UL?
Note that BITMAP_{FIRST,LAST}_WORD_MASK never produce 0, they're never
used except with a word we know to be part of the bitmap.

> We can pick BITS_{LAST,FIRST} implementation from existing BITMAP_*_WORD_MASK
> analogues, and make the BITS_RANGE like:
>         #define BITS_RANGE(begin, end) BITS_FIRST(end) & BITS_LAST(begin)
> 
> Regarding BITMAP_*_WORD_MASK, I can save them in bitmap.h as aliases
> to BITS_{LAST,FIRST} to avoid massive renaming. (Should I?)

Yes, now that I read these again, I definitely think the
BITMAP_{FIRST,LAST}_WORD_MASK should stay (whether their implementation
change I don't care). Their names document what they do much better than
if you replace them with their potential new implementations:
BITMAP_FIRST_WORD_MASK(start) is obviously about having to mask off some
low bits of the first word we're looking at because we're looking at an
offset into the bitmap, and similarly BITMAP_LAST_WORD_MASK(nbits)
explains itself: nbits is such that the last word needs some masking.
But their replacements would be BITS_LAST(start) and BITS_FIRST(nbits)
respectively (possibly with those arguments reduced mod N), which is
quite confusing.

> Would this all work for you?

Maybe, I think I'd have to see the implementation and how those new
macros get used.

Thanks,
Rasmus
