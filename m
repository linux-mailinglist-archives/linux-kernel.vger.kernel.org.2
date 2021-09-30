Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91E8141D17A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 04:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347845AbhI3Cdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 22:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347759AbhI3Cdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 22:33:51 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C2AC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 19:32:10 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id i62so5690986ioa.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 19:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=C3icfHV8rziphpmZsPVo5VvYUU+r4uhS/fnY11daDVU=;
        b=BsTyfe3MEXlmmuEqY2A0DBWVcv0KQjH3UQvRb8ylvQxdS36BVtLsKP0cgaKrxAidUp
         DlMFioCBU5rx+XarWdBaMaDbdQNQ+ory9j1MY1WTUqtUfzI+hAX2JqKgATC3HqLy8eIe
         565U9RN9A5bOj+Jxy+QoPe8STtb0kcULmBDw+Nxi64SivK9o6Os3cEUQZEUnJUq3Nef5
         kstwOVz7C1xHXkJjnnydbcySksgU1F11XpF3l/P0YDgVoC/dNFh+ZRdhk6JnP5gm9dwA
         GLC+SmvjYAXoNlpFnBm3p5D1xIu1Ei9qoaJEHAT0H7AMGrlQEiOa0G+/bjDdQ5VS79Fu
         WBuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C3icfHV8rziphpmZsPVo5VvYUU+r4uhS/fnY11daDVU=;
        b=jz45oVsP5kqznhSs/DcqKiwjD8cNys+LoEzTeW8jBlGPOaAtxnpBQfvYOP5i23iF5/
         GOtcHrNw/ezmNJ+E2p/umggiiluRcBgD5RMLl2+Ps7ZPKzJy0bYWJQxi/xl/129hjakp
         ui7V82ufS4HNhzR4p9+lDWrfWroRAsaPKq2E1IIBf8MFjn3u9XNbVXRCU5dtct3XhXSE
         a5U3NdZ5vsGbGsZ+kHCFIitAFQu4ysyNnC2UznjfB+sJLYr/5SKk51I0oTYDiyZRY8+V
         rgUixRnhBy4LaR+SBD/SqSj0oNgFam0q72D5TZidpaSmmK8P1aQ5uciGeM+6mGjOr0N4
         uQVw==
X-Gm-Message-State: AOAM533GFVtnYHjMasOpJFvCrhg5TmobmxUSMjJbSwKCyjy0g3mvlDC9
        sqIjdJctgQPA6gVg7lxZo7SFkw==
X-Google-Smtp-Source: ABdhPJx7uIPZ0aG5uMZD/IxkKfTuN1Jq6tEKtnFoS3QqqydDwNaNUdWON4uuqSHW5fx72tzKsMax+g==
X-Received: by 2002:a02:cd17:: with SMTP id g23mr2644168jaq.29.1632969129295;
        Wed, 29 Sep 2021 19:32:09 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id o9sm876691iob.15.2021.09.29.19.32.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Sep 2021 19:32:08 -0700 (PDT)
Subject: Re: [PATCH] nbd: use shifts rather than multiplies
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Pavel Machek <pavel@ucw.cz>, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
References: <20210920232533.4092046-1-ndesaulniers@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <afad9679-79f2-7a18-0574-28e53b9d7aa3@kernel.dk>
Date:   Wed, 29 Sep 2021 20:32:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210920232533.4092046-1-ndesaulniers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/21 5:25 PM, Nick Desaulniers wrote:
> commit fad7cd3310db ("nbd: add the check to prevent overflow in
> __nbd_ioctl()") raised an issue from the fallback helpers added in
> commit f0907827a8a9 ("compiler.h: enable builtin overflow checkers and
> add fallback code")
> 
> ERROR: modpost: "__divdi3" [drivers/block/nbd.ko] undefined!
> 
> As Stephen Rothwell notes:
>   The added check_mul_overflow() call is being passed 64 bit values.
>   COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW is not set for this build (see
>   include/linux/overflow.h).
> 
> Specifically, the helpers for checking whether the results of a
> multiplication overflowed (__unsigned_mul_overflow,
> __signed_add_overflow) use the division operator when
> !COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW.  This is problematic for 64b
> operands on 32b hosts.
> 
> This was fixed upstream by
> commit 76ae847497bc ("Documentation: raise minimum supported version of
> GCC to 5.1")
> which is not suitable to be backported to stable.
> 
> Further, __builtin_mul_overflow() would emit a libcall to a
> compiler-rt-only symbol when compiling with clang < 14 for 32b targets.
> 
> ld.lld: error: undefined symbol: __mulodi4
> 
> In order to keep stable buildable with GCC 4.9 and clang < 14, modify
> struct nbd_config to instead track the number of bits of the block size;
> reconstructing the block size using runtime checked shifts that are not
> problematic for those compilers and in a ways that can be backported to
> stable.
> 
> In nbd_set_size, we do validate that the value of blksize must be a
> power of two (POT) and is in the range of [512, PAGE_SIZE] (both
> inclusive).
> 
> This does modify the debugfs interface.

Applied, thanks.

-- 
Jens Axboe

