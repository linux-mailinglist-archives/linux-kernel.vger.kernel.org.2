Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3AA3A9B30
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 14:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbhFPM4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 08:56:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:57194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232550AbhFPM4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 08:56:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7A58460FE9;
        Wed, 16 Jun 2021 12:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623848054;
        bh=SqkEVoL/d0paKQjW7Uqto37QLMKGYT2IKLk8/Zjy4Js=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UujjwgmD8hulbFX+3zvH5Iq198GGUn/7ynYUCfOOXILyDtcCT5S1uezjxP2XJId3l
         XN1Yd9AyHKcqM9NP6K2GLGk0ulScCjZJqbzQ4hAP5vBGnerdFRU9IpW9u7e64rUQ2M
         UWmFlhZMIFcz2pfBNagTNGcNofffiA0Ttm0RAMt+OOcTH07cvbND1ohX7jgBcrglGR
         zMy4+Ih2wt+qNpRY1q08yXhpB2YzFEpRe4wOAreiNaGM9ILAAepiuKYpegji22dETk
         EpVcXeG9vPjYIIszJx+nDuDydnAa1lvZ4mPJ0/WVK6ESm82+aTdEYvYYJWD/CrurnV
         S3QhlV8iEa0xw==
Date:   Wed, 16 Jun 2021 14:54:10 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Subject: Re: [PATCH v4 1/2] module: add elf_check_module_arch for module
 specific elf arch checks
Message-ID: <YMn0cvhTyRtsE7xu@linux.fritz.box>
References: <20210611093959.821525-1-npiggin@gmail.com>
 <20210611093959.821525-2-npiggin@gmail.com>
 <YMdGWjBOmcstBwOl@p200300cbcf109700df096d564fe976c3.dip0.t-ipconnect.de>
 <1623722110.amu32mwaqs.astroid@bobo.none>
 <YMiaZOqhHck9iy0n@p200300cbcf109700df096d564fe976c3.dip0.t-ipconnect.de>
 <1623805495.qdikm5ks8v.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1623805495.qdikm5ks8v.astroid@bobo.none>
X-OS:   Linux linux.fritz.box 5.12.9-1-default x86_64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Nicholas Piggin [16/06/21 11:18 +1000]:
>Excerpts from Jessica Yu's message of June 15, 2021 10:17 pm:
>> +++ Nicholas Piggin [15/06/21 12:05 +1000]:
>>>Excerpts from Jessica Yu's message of June 14, 2021 10:06 pm:
>>>> +++ Nicholas Piggin [11/06/21 19:39 +1000]:
>>>>>The elf_check_arch() function is used to test usermode binaries, but
>>>>>kernel modules may have more specific requirements. powerpc would like
>>>>>to test for ABI version compatibility.
>>>>>
>>>>>Add an arch-overridable function elf_check_module_arch() that defaults
>>>>>to elf_check_arch() and use it in elf_validity_check().
>>>>>
>>>>>Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>>>>>[np: split patch, added changelog]
>>>>>Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>>>>---
>>>>> include/linux/moduleloader.h | 5 +++++
>>>>> kernel/module.c              | 2 +-
>>>>> 2 files changed, 6 insertions(+), 1 deletion(-)
>>>>>
>>>>>diff --git a/include/linux/moduleloader.h b/include/linux/moduleloader.h
>>>>>index 9e09d11ffe5b..fdc042a84562 100644
>>>>>--- a/include/linux/moduleloader.h
>>>>>+++ b/include/linux/moduleloader.h
>>>>>@@ -13,6 +13,11 @@
>>>>>  * must be implemented by each architecture.
>>>>>  */
>>>>>
>>>>>+// Allow arch to optionally do additional checking of module ELF header
>>>>>+#ifndef elf_check_module_arch
>>>>>+#define elf_check_module_arch elf_check_arch
>>>>>+#endif
>>>>
>>>> Hi Nicholas,
>>>>
>>>> Why not make elf_check_module_arch() consistent with the other
>>>> arch-specific functions? Please see module_frob_arch_sections(),
>>>> module_{init,exit}_section(), etc in moduleloader.h. That is, they are
>>>> all __weak functions that are overridable by arches. We can maybe make
>>>> elf_check_module_arch() a weak symbol, available for arches to
>>>> override if they want to perform additional elf checks. Then we don't
>>>> have to have this one-off #define.
>>>
>>>
>>>Like this? I like it. Good idea.
>>
>> Yeah! Also, maybe we can alternatively make elf_check_module_arch() a
>> separate check entirely so that the powerpc implementation doesn't
>> have to include that extra elf_check_arch() call. Something like this maybe?
>
>Yeah we can do that. Would you be okay if it goes via powerpc tree? If
>yes, then we should get your Ack (or SOB because it seems to be entirely
>your patch now :D)

This can go through the powerpc tree. Will you do another respin
of this patch? And yes, feel free to take my SOB for this one -

     Signed-off-by: Jessica Yu <jeyu@kernel.org>

Thanks!

Jessica
