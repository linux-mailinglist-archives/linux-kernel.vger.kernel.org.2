Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3E53A7DFB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 14:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbhFOMTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 08:19:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:41098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229557AbhFOMTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 08:19:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8BB3161461;
        Tue, 15 Jun 2021 12:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623759467;
        bh=ZOobHo2nepnalPKzwxZMCxNgrD2fbEDO02BZri0udFo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LecsFWuG/QSB8cQA0wl+VtK1EGygYbmMTtzqDUeEE37KPZtK38sFXD9PQbD65I5g7
         wSmKMZp5yG5ePcmD1DEqvYWQgX1Q7zUk4plzIuIhGYiYzGSPe6skB2tA2mbwKbzkjl
         cZTL1s1a6LCZvIcU9PivwcMwCA3eIWnuFoj4I7Yo8dX6nXjTP4xFVvhrSMRH0Wz6FR
         r59G5AG1Iyk4ts5fjH+U63rq3im7DeIPA9HhuSFswSHEWUuvP/t3mtSnoz0LCvA0VF
         V+KIHZsJEutgw8TjPRMf8BuKslPS4Cm+eBMIkkQZWE4z3LEbqHwaxqsBPIpmKYQZE3
         pYOqLQpnq7ukQ==
Date:   Tue, 15 Jun 2021 14:17:40 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Subject: Re: [PATCH v4 1/2] module: add elf_check_module_arch for module
 specific elf arch checks
Message-ID: <YMiaZOqhHck9iy0n@p200300cbcf109700df096d564fe976c3.dip0.t-ipconnect.de>
References: <20210611093959.821525-1-npiggin@gmail.com>
 <20210611093959.821525-2-npiggin@gmail.com>
 <YMdGWjBOmcstBwOl@p200300cbcf109700df096d564fe976c3.dip0.t-ipconnect.de>
 <1623722110.amu32mwaqs.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1623722110.amu32mwaqs.astroid@bobo.none>
X-OS:   Linux p200300cbcf109700df096d564fe976c3.dip0.t-ipconnect.de
 5.12.9-1-default x86_64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Nicholas Piggin [15/06/21 12:05 +1000]:
>Excerpts from Jessica Yu's message of June 14, 2021 10:06 pm:
>> +++ Nicholas Piggin [11/06/21 19:39 +1000]:
>>>The elf_check_arch() function is used to test usermode binaries, but
>>>kernel modules may have more specific requirements. powerpc would like
>>>to test for ABI version compatibility.
>>>
>>>Add an arch-overridable function elf_check_module_arch() that defaults
>>>to elf_check_arch() and use it in elf_validity_check().
>>>
>>>Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>>>[np: split patch, added changelog]
>>>Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>>---
>>> include/linux/moduleloader.h | 5 +++++
>>> kernel/module.c              | 2 +-
>>> 2 files changed, 6 insertions(+), 1 deletion(-)
>>>
>>>diff --git a/include/linux/moduleloader.h b/include/linux/moduleloader.h
>>>index 9e09d11ffe5b..fdc042a84562 100644
>>>--- a/include/linux/moduleloader.h
>>>+++ b/include/linux/moduleloader.h
>>>@@ -13,6 +13,11 @@
>>>  * must be implemented by each architecture.
>>>  */
>>>
>>>+// Allow arch to optionally do additional checking of module ELF header
>>>+#ifndef elf_check_module_arch
>>>+#define elf_check_module_arch elf_check_arch
>>>+#endif
>>
>> Hi Nicholas,
>>
>> Why not make elf_check_module_arch() consistent with the other
>> arch-specific functions? Please see module_frob_arch_sections(),
>> module_{init,exit}_section(), etc in moduleloader.h. That is, they are
>> all __weak functions that are overridable by arches. We can maybe make
>> elf_check_module_arch() a weak symbol, available for arches to
>> override if they want to perform additional elf checks. Then we don't
>> have to have this one-off #define.
>
>
>Like this? I like it. Good idea.

Yeah! Also, maybe we can alternatively make elf_check_module_arch() a
separate check entirely so that the powerpc implementation doesn't
have to include that extra elf_check_arch() call. Something like this maybe?

diff --git a/include/linux/moduleloader.h b/include/linux/moduleloader.h
index 9e09d11ffe5b..2f9ebd593b4f 100644
--- a/include/linux/moduleloader.h
+++ b/include/linux/moduleloader.h
@@ -39,6 +39,9 @@ bool module_init_section(const char *name);
   */
  bool module_exit_section(const char *name);

+/* Arch may override to do additional checking of ELF header architecture */
+int elf_check_module_arch(Elf_Ehdr *hdr);
+
  /*
   * Apply the given relocation to the (simplified) ELF.  Return -error
   * or 0.
diff --git a/kernel/module.c b/kernel/module.c
index fdd6047728df..9963a979ed54 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2923,6 +2923,11 @@ static int validate_section_offset(struct load_info *info, Elf_Shdr *shdr)
         return 0;
  }

+int __weak elf_check_module_arch(Elf_Ehdr *hdr)
+{
+       return 1;
+}
+
  /*
   * Sanity checks against invalid binaries, wrong arch, weird elf version.
   *
@@ -2941,6 +2946,7 @@ static int elf_validity_check(struct load_info *info)
         if (memcmp(info->hdr->e_ident, ELFMAG, SELFMAG) != 0
             || info->hdr->e_type != ET_REL
             || !elf_check_arch(info->hdr)
+           || !elf_check_module_arch(info->hdr)
             || info->hdr->e_shentsize != sizeof(Elf_Shdr))
                 return -ENOEXEC;
  

