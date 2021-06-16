Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9F3E3A9C9A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 15:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbhFPNwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 09:52:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:45726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233635AbhFPNwE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 09:52:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2007961356;
        Wed, 16 Jun 2021 13:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623851398;
        bh=F+0AD/z32n3IQAOZXMGGWEtpwRyURijw8GdpAQNt9m0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BWjCeUb525061FgtkOt8wAR3RbNoQldRkdI/xLeNzVqQvHjBrWawgoiajz3wAQamB
         BupbE5wm/JDrDZvgxYELl+BrOrA3celdzG7Z+Px4+Hl0GkkyReyjaNQsAfGZaLMDqG
         mNIbUowbXBxrkE2NDVK/B3dN/OxVKxqbZ9lOnjytdMpeWZ/8xantSlUinrEtCVkxnI
         EyMhUKEAkIumc5AeiaeoenQSHtxqNsQxN7rHqm//i29Ql9bxQMuzXwoMW7nWYB0hCc
         7QRLLUVGQkcRYFhmEXgzjGkQHrBN7aODomv6gzXuiCEvv2S9GmfyS5KEp9sdHhB5mm
         9BFySz9jHmLeA==
Date:   Wed, 16 Jun 2021 15:49:54 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Subject: Re: [PATCH v4 1/2] module: add elf_check_module_arch for module
 specific elf arch checks
Message-ID: <YMoBgsVPMkzEAQxV@linux.fritz.box>
References: <20210611093959.821525-1-npiggin@gmail.com>
 <20210611093959.821525-2-npiggin@gmail.com>
 <YMdGWjBOmcstBwOl@p200300cbcf109700df096d564fe976c3.dip0.t-ipconnect.de>
 <1623722110.amu32mwaqs.astroid@bobo.none>
 <YMiaZOqhHck9iy0n@p200300cbcf109700df096d564fe976c3.dip0.t-ipconnect.de>
 <87v96esffr.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87v96esffr.fsf@mpe.ellerman.id.au>
X-OS:   Linux linux.fritz.box 5.12.9-1-default x86_64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Michael Ellerman [16/06/21 12:37 +1000]:
>Jessica Yu <jeyu@kernel.org> writes:
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
>
>>>Like this? I like it. Good idea.
>>
>> Yeah! Also, maybe we can alternatively make elf_check_module_arch() a
>> separate check entirely so that the powerpc implementation doesn't
>> have to include that extra elf_check_arch() call. Something like this maybe?
>
>My thinking for making elf_check_module_arch() the only hook was that
>conceivably you might not want/need to call elf_check_arch() from
>elf_check_module_arch().
>
>So having a single module specific hook allows arch code to decide
>how to implement the check, which may or may not involve calling
>elf_check_arch(), but that becomes an arch implementation detail.

Thanks for the feedback! Yeah, that's fair too. Well, I ended up doing
it this way mostly to create less churn/change of behavior, since in
its current state elf_check_arch() is already being called for each
arch. Additionally I wanted to save the powerpc implementation of
elf_check_module_arch() an extra elf_check_arch() call. In any case I
have a slight preference for having a second hook to allow arches add
any extra checks in addition to elf_check_arch(). Thanks!
