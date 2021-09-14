Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFD2B40B419
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 18:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234864AbhINQGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 12:06:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:58174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232916AbhINQGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 12:06:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F87B61151;
        Tue, 14 Sep 2021 16:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631635485;
        bh=ebhcQ4hUXkMW4qIBZ9SKW8WREnfyFPdJTHRQdASpbhM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=BtPCcFnN+Tn1BATjo5zVC6sM2/8MAKG6FsKLHlOMu0kSqQaejBBJe8KW9coliJXuP
         WMSmmkkhlffDhY1HcKm+gx6p7lxGLgW9/fm5zd3tJ99W9KaXVCMUStE+nXpn4jbUf4
         kOXAK7f3Gu2OJgS9g00y6jSn9zCkuQ2yCCeroBqd9eV4C8A45PtO8v7gyJV2LO5lHt
         RspeO7j8OCvZoa9slEfXSxkToLHkZ2S/CGKVMdwng2IXnbQNP2DMQ9KKqVUxkEbR4t
         /ygdFRtiP6TfWvpNQGZhFssICaw1bwg+5hl7oYSvLPyfclBFvzvTcxFq5SByEWJFaw
         vZT9wwBA5aSnw==
Subject: Re: [PATCH 02/10] compiler.h: drop fallback overflow checkers
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20210910234047.1019925-1-ndesaulniers@google.com>
 <20210910234047.1019925-3-ndesaulniers@google.com>
 <YTvyiv6M05Zk/C70@archlinux-ax161>
 <CAKwvOdn==O+yJHLbxSEyx=xwpKbOsXY9_YkyU2m7+kiEwtPMrA@mail.gmail.com>
From:   Nathan Chancellor <nathan@kernel.org>
Message-ID: <8d1f262c-77fb-c40c-ac96-1c2c4eb36011@kernel.org>
Date:   Tue, 14 Sep 2021 09:04:43 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAKwvOdn==O+yJHLbxSEyx=xwpKbOsXY9_YkyU2m7+kiEwtPMrA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/2021 8:33 AM, Nick Desaulniers wrote:
> On Fri, Sep 10, 2021 at 5:04 PM Nathan Chancellor <nathan@kernel.org> wrote:
>>
>> On Fri, Sep 10, 2021 at 04:40:39PM -0700, Nick Desaulniers wrote:
>>> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
>>> index 0f12345c21fb..4669632bd72b 100644
>>> --- a/include/linux/overflow.h
>>> +++ b/include/linux/overflow.h
>>> @@ -6,12 +6,9 @@
>>>   #include <linux/limits.h>
>>>
>>>   /*
>>> - * In the fallback code below, we need to compute the minimum and
>>> - * maximum values representable in a given type. These macros may also
>>> - * be useful elsewhere, so we provide them outside the
>>> - * COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW block.
>>> - *
>>> - * It would seem more obvious to do something like
>>> + * We need to compute the minimum and maximum values representable in a given
>>> + * type. These macros may also be useful elsewhere. It would seem more obvious
>>> + * to do something like:
>>>    *
>>>    * #define type_min(T) (T)(is_signed_type(T) ? (T)1 << (8*sizeof(T)-1) : 0)
>>>    * #define type_max(T) (T)(is_signed_type(T) ? ((T)1 << (8*sizeof(T)-1)) - 1 : ~(T)0)
>>
>> The signed and type macros right below this comment can be removed as
>> they were only used in the !COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW case.
> 
> Did you check for users outside of this header?
> 
> I see:
> type_min ->
> lib/test_scanf.c:189
> include/rdma/uverbs_ioctl.h:951
> include/rdma/uverbs_ioctl.h:973
> 
> type_max ->
> lib/test_scanf.c:189
> lib/test_scanf.c:190
> include/rdma/uverbs_ioctl.h:952
> include/rdma/uverbs_ioctl.h:962
> include/rdma/uverbs_ioctl.h:974
> include/rdma/uverbs_ioctl.h:985
> 
> is_signed_type has many many users throughout the kernel.
> 
> Or were you referring to other defines?

Ah, I did not even think to look outside this file, I figured they were 
intended to only be used here :/ good catch.

>>
>> Also applies to the tools/ version.
> 
> The version in tools/ should probably be "refreshed" ie. copy+pasted
> over.  Why there is a separate copy under tools/...
> 

Yes, they probably should, as I noted in commit d0ee23f9d78b ("tools: 
compiler-gcc.h: Guard error attribute use with __has_attribute"). At the 
same time, I don't really want to do it :)

Cheers,
Nathan
