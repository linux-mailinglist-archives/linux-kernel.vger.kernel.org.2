Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDD353AADB4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 09:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhFQHhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 03:37:12 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:44603 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229666AbhFQHhJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 03:37:09 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4G5DNN3BPjzBBMR;
        Thu, 17 Jun 2021 09:35:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Wwi-Sb9-gVs9; Thu, 17 Jun 2021 09:35:00 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4G5DNN2CdMzB9jd;
        Thu, 17 Jun 2021 09:35:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 38BB98B804;
        Thu, 17 Jun 2021 09:35:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 7J6GAaFtRhUL; Thu, 17 Jun 2021 09:35:00 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 112FB8B801;
        Thu, 17 Jun 2021 09:34:59 +0200 (CEST)
Subject: Re: [PATCH v3 22/23] powerpc/vdso: Migrate native signals to generic
 vdso_base
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
References: <20210611180242.711399-1-dima@arista.com>
 <20210611180242.711399-23-dima@arista.com>
 <1678c131-98e3-2d5c-7cf1-0dcb985d67bb@csgroup.eu>
Message-ID: <fe44b73c-b2ca-4719-26f9-76f085d4d330@csgroup.eu>
Date:   Thu, 17 Jun 2021 09:34:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1678c131-98e3-2d5c-7cf1-0dcb985d67bb@csgroup.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 17/06/2021 à 08:36, Christophe Leroy a écrit :
> 
> 
> Le 11/06/2021 à 20:02, Dmitry Safonov a écrit :
>> Generic way to track the land vma area.
>> Stat speaks for itself.
>>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Signed-off-by: Dmitry Safonov <dima@arista.com>
> 
> 
> Build failure:
> 
>    CC      arch/powerpc/kernel/asm-offsets.s
> In file included from ./include/linux/mmzone.h:21,
>                   from ./include/linux/gfp.h:6,
>                   from ./include/linux/xarray.h:14,
>                   from ./include/linux/radix-tree.h:19,
>                   from ./include/linux/fs.h:15,
>                   from ./include/linux/compat.h:17,
>                   from arch/powerpc/kernel/asm-offsets.c:14:
> ./include/linux/mm_types.h: In function 'init_vdso_base':
> ./include/linux/mm_types.h:522:28: error: 'TASK_SIZE_MAX' undeclared (first use in this function); 
> did you mean 'XATTR_SIZE_MAX'?
>    522 | #define UNMAPPED_VDSO_BASE TASK_SIZE_MAX
>        |                            ^~~~~~~~~~~~~
> ./include/linux/mm_types.h:627:40: note: in expansion of macro 'UNMAPPED_VDSO_BASE'
>    627 |         mm->vdso_base = (void __user *)UNMAPPED_VDSO_BASE;
>        |                                        ^~~~~~~~~~~~~~~~~~
> ./include/linux/mm_types.h:522:28: note: each undeclared identifier is reported only once for each 
> function it appears in
>    522 | #define UNMAPPED_VDSO_BASE TASK_SIZE_MAX
>        |                            ^~~~~~~~~~~~~
> ./include/linux/mm_types.h:627:40: note: in expansion of macro 'UNMAPPED_VDSO_BASE'
>    627 |         mm->vdso_base = (void __user *)UNMAPPED_VDSO_BASE;
>        |                                        ^~~~~~~~~~~~~~~~~~
> make[2]: *** [arch/powerpc/kernel/asm-offsets.s] Error 1
> make[1]: *** [prepare0] Error 2
> make: *** [__sub-make] Error 2
> 

Fixed by moving TASK_SIZE_MAX into asm/task_size_32.h and asm/task_size_64.h

diff --git a/arch/powerpc/include/asm/task_size_32.h b/arch/powerpc/include/asm/task_size_32.h
index de7290ee770f..03af9e6bb5cd 100644
--- a/arch/powerpc/include/asm/task_size_32.h
+++ b/arch/powerpc/include/asm/task_size_32.h
@@ -7,6 +7,7 @@
  #endif

  #define TASK_SIZE (CONFIG_TASK_SIZE)
+#define TASK_SIZE_MAX		TASK_SIZE

  /*
   * This decides where the kernel will search for a free chunk of vm space during
diff --git a/arch/powerpc/include/asm/task_size_64.h b/arch/powerpc/include/asm/task_size_64.h
index c993482237ed..bfdb98c0ef43 100644
--- a/arch/powerpc/include/asm/task_size_64.h
+++ b/arch/powerpc/include/asm/task_size_64.h
@@ -49,6 +49,7 @@
  						TASK_SIZE_USER64)

  #define TASK_SIZE TASK_SIZE_OF(current)
+#define TASK_SIZE_MAX		TASK_SIZE_USER64

  #define TASK_UNMAPPED_BASE_USER32 (PAGE_ALIGN(TASK_SIZE_USER32 / 4))
  #define TASK_UNMAPPED_BASE_USER64 (PAGE_ALIGN(DEFAULT_MAP_WINDOW_USER64 / 4))
diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 22c79ab40006..5823140d39f1 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -8,13 +8,6 @@
  #include <asm/extable.h>
  #include <asm/kup.h>

-#ifdef __powerpc64__
-/* We use TASK_SIZE_USER64 as TASK_SIZE is not constant */
-#define TASK_SIZE_MAX		TASK_SIZE_USER64
-#else
-#define TASK_SIZE_MAX		TASK_SIZE
-#endif
-
  static inline bool __access_ok(unsigned long addr, unsigned long size)
  {
  	return addr < TASK_SIZE_MAX && size <= TASK_SIZE_MAX - addr;
