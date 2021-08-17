Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 977EA3EF1DB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 20:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbhHQSbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 14:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhHQSbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 14:31:49 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050::465:102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1948EC061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 11:31:15 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Gq03Q3PP7zQk03;
        Tue, 17 Aug 2021 20:31:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailbox.org; h=
        content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:date:date:message-id:from
        :from:references:subject:subject:received; s=mail20150812; t=
        1629225068; bh=7VxjSoHJkvzrrAv//AjZAigu8MD+F9vA/ZsmFNGY2Cs=; b=c
        6g/bf7akJPcHI4Rw+B811SY89BsKpsrpS9y9tMn8aNbH9NP2uSe4Yu0baYwaER12
        +bUEyvxfmP5n6pNpR5NhlcO0XA/10LaWkCfPwQLwMK+eHNKMIjHZTQ29Nn4tiEJE
        ys5ZrVs47dCTuvmMkHbq34/OWFm2z0eUJv3KZjfNmSJJD6U0Z4XWcI6WTPV42Xyr
        R0pxrSviTDwVVrU9DDVXAk4iyyhGOX3zh4H3EXWidpAXlyiXj/sCxHCxi+zncCSe
        GBIIyj6C/NbZPnHjZfwNWmDUMwWPFsguGCyc9kDzzXh9xcHRX5/a9/mB0GwEVs5m
        NqJhCfQrZHHNyldmOafHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1629225072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eBpIX9+4h+iTtsDgTrJiVn6hmmLt8ME01UUjZ+g11QU=;
        b=D/mUoOPVLW3W0FOeDoFo5xWWyExAuUxI5fjLqXTM7q74d2yW8TtGulBYtrQ1sBe6EphbOD
        8v+1gTGPFwPqzBU2TmgHV0JMHqBSFHVEdSB78wtb/FqHTijhBZ9EjRbKqQ7f643wJ70SlK
        4EXsrjZAbmp8/Wz85n88ccLJjM8oJCeA/OuMLVfMWEUpvZW0Cga5coi1EpmM39FCkuOHuN
        AJvoWIU3lWXLpex/9FHeoX/QmIixLaSt9puvyyXLvNkdzCFmATJgRHeYyVNRIH6Qxqi9Uk
        4YZa+Oe8Q6LLpjCG+jufpYFMuDSoFsEYPnq0r4CWHnGnWnYjwzBStweaXylvfg==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id P015znEdfxzk; Tue, 17 Aug 2021 20:31:08 +0200 (CEST)
Subject: Re: [PATCH 2/2] x86, Makefile: Add new generic x86-64 settings
 v2/v3/v4
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        "graysky@archlinux.us" <graysky@archlinux.us>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Masahiro Yamada <masahiroy@kernel.org>
References: <269701460.117528.1629210189833@office.mailbox.org>
 <796036867.117557.1629210288168@office.mailbox.org>
 <CAKwvOdkYgC4pU0Ta+vS-UkyAYFTkg8MaLuR+OAsSX63_BY+1vA@mail.gmail.com>
 <CAKwvOdk+fwHQDe23Ttva46tyB9yGGxB73zXzNPkcMCggSRWUdQ@mail.gmail.com>
From:   Tor Vic <torvic9@mailbox.org>
Message-ID: <ec0f00b1-04c7-9972-d28b-122964a127dd@mailbox.org>
Date:   Tue, 17 Aug 2021 18:31:06 +0000
MIME-Version: 1.0
In-Reply-To: <CAKwvOdk+fwHQDe23Ttva46tyB9yGGxB73zXzNPkcMCggSRWUdQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 2341618C1
X-Rspamd-UID: ca6434
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17.08.21 18:22, Nick Desaulniers wrote:
> On Tue, Aug 17, 2021 at 11:17 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
>>
>> On Tue, Aug 17, 2021 at 7:24 AM torvic9 via Clang Built Linux
>> <clang-built-linux@googlegroups.com> wrote:
>>>
>>> Add new generic x86-64 CPU tunings introduced with recent versions of
>>> gcc and clang, as documented in x86-64-psABI [1].
>>>
>>> This is taken straight from graysky's CPU optimization patch with minor
>>> modifications [2].
>>>
>>> [1] https://gitlab.com/x86-psABIs/x86-64-ABI/-/commit/77566eb03bc6a326811cb7e9a6b9396884b67c7c
>>> [2] https://github.com/graysky2/kernel_compiler_patch
>>>
>>> Signed-off-by: Tor Vic <torvic9@mailbox.org>
>>> ---
>>>  arch/x86/Kconfig.cpu  | 26 +++++++++++++++++++++++++-
>>>  arch/x86/Makefile.cpu |  6 ++++++
>>>  2 files changed, 31 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
>>> index 814fe0d349b0..a2c872aa5a0b 100644
>>> --- a/arch/x86/Kconfig.cpu
>>> +++ b/arch/x86/Kconfig.cpu
>>> @@ -294,6 +294,30 @@ config GENERIC_CPU
>>>           Generic x86-64 CPU.
>>>           Run equally well on all x86-64 CPUs.
>>>
>>> +config GENERIC_CPU_V2
>>> +       bool "Generic-x86-64-v2"
>>> +       depends on ( CC_IS_GCC && GCC_VERSION > 110000 ) || ( CC_IS_CLANG && CLANG_VERSION >= 120000 )
>>
>> Can we stick with either > or >=, but at least be consistent? Also,
>> there's unnecessary whitespace inside the parens that could be
>> removed.
> 
> Ah, cc-option can be used from Kconfig. Perhaps a cc-option call to
> -march=x86-64-vX with a comment about which compiler versions first
> supported these (so that we can remove the feature test when the
> minimum supported toolchains are advanced) would be better?
> 

That makes sense. Will do a v2.
Which of these possibilities is more "expensive"?
I remember a recent patch where some of these calls were removed.

>>
>>> +       depends on X86_64
>>> +       help
>>> +         Generic x86-64 CPU.
>>> +         Run equally well on all x86-64 CPUs with min support of x86-64-v2.
>>> +
>>> +config GENERIC_CPU_V3
>>> +       bool "Generic-x86-64-v3"
>>> +       depends on ( CC_IS_GCC && GCC_VERSION > 110000 ) || ( CC_IS_CLANG && CLANG_VERSION >= 120000 )
>>> +       depends on X86_64
>>> +       help
>>> +         Generic x86-64-v3 CPU with v3 instructions.
>>> +         Run equally well on all x86-64 CPUs with min support of x86-64-v3.
>>> +
>>> +config GENERIC_CPU_V4
>>> +       bool "Generic-x86-64-v4"
>>> +       depends on ( CC_IS_GCC && GCC_VERSION > 110000 ) || ( CC_IS_CLANG && CLANG_VERSION >= 120000 )
>>> +       depends on X86_64
>>> +       help
>>> +         Generic x86-64 CPU with v4 instructions.
>>> +         Run equally well on all x86-64 CPUs with min support of x86-64-v4.
>>> +
>>>  endchoice
>>>
>>>  config X86_GENERIC
>>> @@ -318,7 +342,7 @@ config X86_INTERNODE_CACHE_SHIFT
>>>  config X86_L1_CACHE_SHIFT
>>>         int
>>>         default "7" if MPENTIUM4 || MPSC
>>> -       default "6" if MK7 || MK8 || MPENTIUMM || MCORE2 || MATOM || MVIAC7 || X86_GENERIC || GENERIC_CPU
>>> +       default "6" if MK7 || MK8 || MPENTIUMM || MCORE2 || MATOM || MVIAC7 || X86_GENERIC || GENERIC_CPU || GENERIC_CPU_V2 || GENERIC_CPU_V3 || GENERIC_CPU_V4
>>>         default "4" if MELAN || M486SX || M486 || MGEODEGX1
>>>         default "5" if MWINCHIP3D || MWINCHIPC6 || MCRUSOE || MEFFICEON || MCYRIXIII || MK6 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || M586 || MVIAC3_2 || MGEODE_LX
>>>
>>> diff --git a/arch/x86/Makefile.cpu b/arch/x86/Makefile.cpu
>>> index fb407ae94d90..f190feefe964 100644
>>> --- a/arch/x86/Makefile.cpu
>>> +++ b/arch/x86/Makefile.cpu
>>> @@ -10,3 +10,9 @@ cflags-$(CONFIG_MCORE2) += \
>>>  cflags-$(CONFIG_MATOM) += $(call cc-option,-march=atom) \
>>>         $(call cc-option,-mtune=atom,$(call cc-option,-mtune=generic))
>>>  cflags-$(CONFIG_GENERIC_CPU) += $(call cc-option,-mtune=generic)
>>> +
>>> +# New generic x86-64 CPU options.
>>> +# Don't call the compiler, we have Kconfig compiler checks for these.
>>
>> You'd be surprised how quickly using time-relative words like "New"
>> bitrot. My copy of "Modern C++" already doesn't feel very "modern" for
>> example.  I'd just drop the comment block here; we don't need a
>> comment every time we skip cc-option checks.  Thanks for the patches!
>>
>>> +cflags-$(CONFIG_GENERIC_CPU_V2) += -march=x86-64-v2
>>> +cflags-$(CONFIG_GENERIC_CPU_V3) += -march=x86-64-v3
>>> +cflags-$(CONFIG_GENERIC_CPU_V4) += -march=x86-64-v4
>>> --
>> --
>> Thanks,
>> ~Nick Desaulniers
> 
> 
> 
