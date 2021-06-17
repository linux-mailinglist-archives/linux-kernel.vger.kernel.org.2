Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9D743AAC7B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 08:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbhFQGjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 02:39:02 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:53105 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229560AbhFQGjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 02:39:01 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4G5C5K3Zd7zBDq3;
        Thu, 17 Jun 2021 08:36:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9GhqvrGtbyo0; Thu, 17 Jun 2021 08:36:53 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4G5C5K2Yf0zBDpw;
        Thu, 17 Jun 2021 08:36:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 349AE8B801;
        Thu, 17 Jun 2021 08:36:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id dT7JWp3q-t0n; Thu, 17 Jun 2021 08:36:53 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1E5138B770;
        Thu, 17 Jun 2021 08:36:52 +0200 (CEST)
Subject: Re: [PATCH v3 22/23] powerpc/vdso: Migrate native signals to generic
 vdso_base
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
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <1678c131-98e3-2d5c-7cf1-0dcb985d67bb@csgroup.eu>
Date:   Thu, 17 Jun 2021 08:36:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210611180242.711399-23-dima@arista.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 11/06/2021 à 20:02, Dmitry Safonov a écrit :
> Generic way to track the land vma area.
> Stat speaks for itself.
> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Paul Mackerras <paulus@samba.org>
> Signed-off-by: Dmitry Safonov <dima@arista.com>


Build failure:

   CC      arch/powerpc/kernel/asm-offsets.s
In file included from ./include/linux/mmzone.h:21,
                  from ./include/linux/gfp.h:6,
                  from ./include/linux/xarray.h:14,
                  from ./include/linux/radix-tree.h:19,
                  from ./include/linux/fs.h:15,
                  from ./include/linux/compat.h:17,
                  from arch/powerpc/kernel/asm-offsets.c:14:
./include/linux/mm_types.h: In function 'init_vdso_base':
./include/linux/mm_types.h:522:28: error: 'TASK_SIZE_MAX' undeclared (first use in this function); 
did you mean 'XATTR_SIZE_MAX'?
   522 | #define UNMAPPED_VDSO_BASE TASK_SIZE_MAX
       |                            ^~~~~~~~~~~~~
./include/linux/mm_types.h:627:40: note: in expansion of macro 'UNMAPPED_VDSO_BASE'
   627 |         mm->vdso_base = (void __user *)UNMAPPED_VDSO_BASE;
       |                                        ^~~~~~~~~~~~~~~~~~
./include/linux/mm_types.h:522:28: note: each undeclared identifier is reported only once for each 
function it appears in
   522 | #define UNMAPPED_VDSO_BASE TASK_SIZE_MAX
       |                            ^~~~~~~~~~~~~
./include/linux/mm_types.h:627:40: note: in expansion of macro 'UNMAPPED_VDSO_BASE'
   627 |         mm->vdso_base = (void __user *)UNMAPPED_VDSO_BASE;
       |                                        ^~~~~~~~~~~~~~~~~~
make[2]: *** [arch/powerpc/kernel/asm-offsets.s] Error 1
make[1]: *** [prepare0] Error 2
make: *** [__sub-make] Error 2

