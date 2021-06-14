Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB1B53A663D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 14:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233375AbhFNMI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 08:08:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:47182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232809AbhFNMI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 08:08:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A5B4C611BD;
        Mon, 14 Jun 2021 12:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623672414;
        bh=Q2MM4OE/VICRfAoB7Alej8C61pteU8OP3UNtKNHFWJk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=frBzwAnJ6zHGxnI4UWPXOTUCB87KxBhhiG+0T0rvQX/xBVgtn1hKgCdKqyEoLzk5M
         XX9/xSGDPSWzrgKQ1ZSbNYG45isW7jotLC1aK9yfzSD6qQM4+BRLJ9FrY7Q6pHoJyW
         v/DDpdcNgTMpleWD8rd65cPLspYigpANxiYJpxSaLHlMAIACHgdAAdwm0GiclVavEn
         QLXSFBd08OZmcN3ZerK5Ht9PUzcWuyegBjl5qQtia09yJ8v+fzLDFlDePrm5OoTgSQ
         x6hw30cowSi7PcR3kUpWt6oruoY9yvNzgAt3/JLh7P5h4x+oeVxvtlAH1rKkLrJPBH
         cAnxe0btDbjYw==
Date:   Mon, 14 Jun 2021 14:06:50 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v4 1/2] module: add elf_check_module_arch for module
 specific elf arch checks
Message-ID: <YMdGWjBOmcstBwOl@p200300cbcf109700df096d564fe976c3.dip0.t-ipconnect.de>
References: <20210611093959.821525-1-npiggin@gmail.com>
 <20210611093959.821525-2-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210611093959.821525-2-npiggin@gmail.com>
X-OS:   Linux p200300cbcf109700df096d564fe976c3.dip0.t-ipconnect.de
 5.12.9-1-default x86_64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Nicholas Piggin [11/06/21 19:39 +1000]:
>The elf_check_arch() function is used to test usermode binaries, but
>kernel modules may have more specific requirements. powerpc would like
>to test for ABI version compatibility.
>
>Add an arch-overridable function elf_check_module_arch() that defaults
>to elf_check_arch() and use it in elf_validity_check().
>
>Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>[np: split patch, added changelog]
>Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>---
> include/linux/moduleloader.h | 5 +++++
> kernel/module.c              | 2 +-
> 2 files changed, 6 insertions(+), 1 deletion(-)
>
>diff --git a/include/linux/moduleloader.h b/include/linux/moduleloader.h
>index 9e09d11ffe5b..fdc042a84562 100644
>--- a/include/linux/moduleloader.h
>+++ b/include/linux/moduleloader.h
>@@ -13,6 +13,11 @@
>  * must be implemented by each architecture.
>  */
>
>+// Allow arch to optionally do additional checking of module ELF header
>+#ifndef elf_check_module_arch
>+#define elf_check_module_arch elf_check_arch
>+#endif

Hi Nicholas,

Why not make elf_check_module_arch() consistent with the other
arch-specific functions? Please see module_frob_arch_sections(),
module_{init,exit}_section(), etc in moduleloader.h. That is, they are
all __weak functions that are overridable by arches. We can maybe make
elf_check_module_arch() a weak symbol, available for arches to
override if they want to perform additional elf checks. Then we don't
have to have this one-off #define.

Thanks,

Jessica

>+
> /* Adjust arch-specific sections.  Return 0 on success.  */
> int module_frob_arch_sections(Elf_Ehdr *hdr,
> 			      Elf_Shdr *sechdrs,
>diff --git a/kernel/module.c b/kernel/module.c
>index 7e78dfabca97..7c3f9b7478dc 100644
>--- a/kernel/module.c
>+++ b/kernel/module.c
>@@ -2946,7 +2946,7 @@ static int elf_validity_check(struct load_info *info)
>
> 	if (memcmp(info->hdr->e_ident, ELFMAG, SELFMAG) != 0
> 	    || info->hdr->e_type != ET_REL
>-	    || !elf_check_arch(info->hdr)
>+	    || !elf_check_module_arch(info->hdr)
> 	    || info->hdr->e_shentsize != sizeof(Elf_Shdr))
> 		return -ENOEXEC;
>
>-- 
>2.23.0
>
