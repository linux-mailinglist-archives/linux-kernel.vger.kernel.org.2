Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0CE93BF00C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 21:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbhGGTLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 15:11:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:56564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230130AbhGGTLJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 15:11:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1FF3D61CC2;
        Wed,  7 Jul 2021 19:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625684909;
        bh=SSp3ngjXzbec6gLt/26BipSnJyLhstyL+4rdwFqQMEk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jn0dMWnmOMjxjTufAvy40CfEs74Q+c0MY2mSynoLOMpLcB8LDiUOeWEmYFA8JkSD4
         ul/3vAsFbbgy0nqYjlUjcU269CzDcSmXKbTm9KdSyo4T//n23bwkbBcEsyE6oIXu8E
         ePVOu3qyBHvJZjRAzze3SEgDmNJQ8t+Ui6k/gocDb0wN5ZVuRaOpdGQTfi0QdshLxX
         5BVAD+bGEqLDt5rCMtqp5pIIMRBWOitANZ1ay3T4HhESV63/c56lTpaBcUujOYMDLD
         uw9u4L7MWt6HEBV/MEVbuPyio+u7HQrKd+dS9P4uz9YjOcT0ZmPQeUSgU0CPx0xlLj
         ARbeUnZe4fkKw==
Subject: Re: [PATCH] arm64: drop CROSS_COMPILE for LLVM=1 LLVM_IAS=1
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Fangrui Song <maskray@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
References: <20210701235505.1792711-1-ndesaulniers@google.com>
 <CAK8P3a1EfBNxaMbsp+s2BiYHGKPK4NeRR+ugM82jfY43Pq7-Uw@mail.gmail.com>
 <CAKwvOdkgEeQktLgEN7CAh7bTjTN+TQNE27aETgvbXep9=xb1DQ@mail.gmail.com>
 <YOEFGcTJC6AWFgs1@Ryzen-9-3900X.localdomain>
 <CAKwvOdnNWKDGOEqCg5g0GX=zPJce9gBoCLcYs8nayLA7ud2XPQ@mail.gmail.com>
From:   Nathan Chancellor <nathan@kernel.org>
Message-ID: <546f3d11-8580-7f23-875d-ef856913cb6d@kernel.org>
Date:   Wed, 7 Jul 2021 12:08:24 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAKwvOdnNWKDGOEqCg5g0GX=zPJce9gBoCLcYs8nayLA7ud2XPQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/2021 12:04 PM, Nick Desaulniers wrote:
> On Sat, Jul 3, 2021 at 5:47 PM Nathan Chancellor <nathan@kernel.org> wrote:
>>
>> On Fri, Jul 02, 2021 at 11:29:31AM -0700, Nick Desaulniers wrote:
>>> On Fri, Jul 2, 2021 at 4:59 AM Arnd Bergmann <arnd@kernel.org> wrote:
>>>>
>>>> On Fri, Jul 2, 2021 at 1:55 AM 'Nick Desaulniers' via Clang Built
>>>> Linux <clang-built-linux@googlegroups.com> wrote:
>>>>>
>>>>> +ifneq ($(LLVM),)
>>>>> +ifneq ($(LLVM_IAS),)
>>>>> +ifeq ($(CROSS_COMPILE),)
>>>>> +CLANG_TARGET   :=--target=aarch64-linux
>>>>> +CLANG_FLAGS    += $(CLANG_TARGET)
>>>>> +KBUILD_CFLAGS  += $(CLANG_TARGET)
>>>>> +KBUILD_AFLAGS  += $(CLANG_TARGET)
>>>>> +endif
>>>>> +endif
>>>>> +endif
>>>>
>>>> I think only the "CLANG_TARGET   :=--target=aarch64-linux" line should
>>>> go into the
>>>> per-architecture Makefile. It doesn't hurt to just set that
>>>> unconditionally here,
>>>> and then change the CLANG_FLAGS logic in the top-level Makefile to use this
>>>> in place of $(notdir $(CROSS_COMPILE:%-=%)).
>>>
>>> I don't think we can do that. Based on the order the arch/ specific
>>> Makefiles are included, if we don't eagerly add --target to the
>>> KBUILD_{C|A}FLAGS, then cc-option, as-option, and as-instr macros
>>> (defined in scripts/Makefile.compiler) checks in per arch/ Makefiles
>>> may fail erroneously because --target was not set for
>>> KBUILD_{C|A}FLAGS yet.
>>>
>>> Another issue is the order of operations between the top level
>>> Makefile and the per arch/ Makefiles.  The `notdir` block you
>>> reference occurs earlier than the per-arch includes:
>>>
>>>   609 TENTATIVE_CLANG_FLAGS += --target=$(notdir $(CROSS_COMPILE:%-=%))
>>> ...
>>>   648 include $(srctree)/arch/$(SRCARCH)/Makefile
>>>
>>> We would need the opposite order to do what you describe. Reordering
>>> these would effectively be a revert of
>>> commit ae6b289a3789 ("kbuild: Set KBUILD_CFLAGS before incl. arch Makefile")
>>> which I'm not sure we want to do.  But maybe there's another way I'm
>>> not seeing yet?
>>
>> Is there any reason we cannot just add this sort of logic to the main
>> Makefile?
>>
>> Such as (indentation to emphasis diff):
>>
>> ifeq ($(CROSS_COMPILE),)
>> ifneq ($(LLVM),)
>> ifeq ($(LLVM_IAS),1)
>>          ifeq ($(ARCH),arm64)
>>                  TENTATIVE_CLANG_FLAGS   += --target=aarch64-linux
>>          else ifeq ($(ARCH),s390)
>>                  TENTATIVE_CLANG_FLAGS   += --target=s390x-linux
>>          else ifeq ($(ARCH),x86_64)
>>                  TENTATIVE_CLANG_FLAGS   += --target=x86_64-linux
>>          else
>>                  $(error Specify CROSS_COMPILE or add '--target=' option to Makefile)
>>          endif
>> endif
>> endif
>> else
>> TENTATIVE_CLANG_FLAGS   += --target=$(notdir $(CROSS_COMPILE:%-=%))
>> ifeq ($(LLVM_IAS),1)
>> TENTATIVE_CLANG_FLAGS   += -integrated-as
>> else
>> TENTATIVE_CLANG_FLAGS   += -no-integrated-as
>> GCC_TOOLCHAIN_DIR := $(dir $(shell which $(CROSS_COMPILE)elfedit))
>> TENTATIVE_CLANG_FLAGS   += --prefix=$(GCC_TOOLCHAIN_DIR)$(notdir $(CROSS_COMPILE))
>> endif
>> endif
>>
>> I know this looks a little cumbersome but it does help us avoid
>> duplication across architecture Makefiles and ordering dependencies.
> 
> Yeah, ok.
> 
> I like the use of `include` to compartmentalize the top level Makefile
> further.  We can move this whole block of LLVM related flag handling
> into something under scripts, then add this block and it doesn't look
> too bad IMO.  Masahiro, are you ok with that?  If so, I'd break this
> into 2 patches:
> 1. moving this block of existing code into a new file.
> 2. adding the CROSS_COMPILE functionality.
> 
> See https://groups.google.com/g/clang-built-linux/c/s-voh6WQFxM for
> the gist of what I was thinking (though not broken into 2 patches yet,
> just testing that it works; it does).

Yeah, I think that looks okay. Not sure how I feel about the name since 
it is handling more than just the target triple but that is a bikeshed 
for another time :)

> This approach will collide with Miguel's series in -next.  Should I
> base the patches on mainline, or linux-kbuild, then have Miguel rebase
> his patches on that or what?

Yes, the patches should be based on mainline or linux-kbuild then Miguel 
will have to solve the conflicts and let Stephen Rothwell know about 
them so that -next keeps working.

Cheers,
Nathan
