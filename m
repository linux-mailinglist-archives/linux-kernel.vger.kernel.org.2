Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16B993CE958
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 19:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358834AbhGSQx1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 19 Jul 2021 12:53:27 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:27948 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346789AbhGSPaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 11:30:09 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4GT6Jl233DzB5LN;
        Mon, 19 Jul 2021 18:10:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SatrIHxHtDdN; Mon, 19 Jul 2021 18:10:47 +0200 (CEST)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4GT6Jl15MKzB5LJ;
        Mon, 19 Jul 2021 18:10:47 +0200 (CEST)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
        id 57179688; Mon, 19 Jul 2021 18:15:59 +0200 (CEST)
Received: from 37.172.104.68 ([37.172.104.68]) by messagerie.c-s.fr (Horde
 Framework) with HTTP; Mon, 19 Jul 2021 18:15:59 +0200
Date:   Mon, 19 Jul 2021 18:15:59 +0200
Message-ID: <20210719181559.Horde.qwhVC8Uechv72gvR3QHrow1@messagerie.c-s.fr>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: mm/pgtable: add stubs for {pmd/pub}_{set/clear}_huge
References: <git-mailbomb-linux-master-c742199a014de23ee92055c2473d91fe5561ffdf@kernel.org>
 <CAMuHMdXShORDox-xxaeUfDW3wx2PeggFSqhVSHVZNKCGK-y_vQ@mail.gmail.com>
In-Reply-To: <CAMuHMdXShORDox-xxaeUfDW3wx2PeggFSqhVSHVZNKCGK-y_vQ@mail.gmail.com>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> a écrit :

> Hi Christophe,

Hi Geert, I'm currently on holidays, I'll have a look when I'm back  
first week of August. Sorry for the inconvenience

>
> On Fri, Jul 2, 2021 at 10:16 PM Linux Kernel Mailing List
> <linux-kernel@vger.kernel.org> wrote:
>> Commit:     c742199a014de23ee92055c2473d91fe5561ffdf
>> Parent:     79c1c594f49a88fba9744cb5c85978c6b1b365ec
>> Refname:    refs/heads/master
>> Web:         
>> https://git.kernel.org/torvalds/c/c742199a014de23ee92055c2473d91fe5561ffdf
>> Author:     Christophe Leroy <christophe.leroy@csgroup.eu>
>> AuthorDate: Wed Jun 30 18:48:03 2021 -0700
>> Committer:  Linus Torvalds <torvalds@linux-foundation.org>
>> CommitDate: Wed Jun 30 20:47:26 2021 -0700
>>
>>     mm/pgtable: add stubs for {pmd/pub}_{set/clear}_huge
>>
>>     For architectures with no PMD and/or no PUD, add stubs similar  
>> to what we
>>     have for architectures without P4D.
>>
>>     [christophe.leroy@csgroup.eu: arm64: define only  
>> {pud/pmd}_{set/clear}_huge when useful]
>>       Link:  
>> https://lkml.kernel.org/r/73ec95f40cafbbb69bdfb43a7f53876fd845b0ce.1620990479.git.christophe.leroy@csgroup.eu
>>     [christophe.leroy@csgroup.eu: x86: define only  
>> {pud/pmd}_{set/clear}_huge when useful]
>>       Link:  
>> https://lkml.kernel.org/r/7fbf1b6bc3e15c07c24fa45278d57064f14c896b.1620930415.git.christophe.leroy@csgroup.eu
>>
>>     Link:  
>> https://lkml.kernel.org/r/5ac5976419350e8e048d463a64cae449eb3ba4b0.1620795204.git.christophe.leroy@csgroup.eu
>>     Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>>     Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>     Cc: Michael Ellerman <mpe@ellerman.id.au>
>>     Cc: Mike Kravetz <mike.kravetz@oracle.com>
>>     Cc: Mike Rapoport <rppt@kernel.org>
>>     Cc: Nicholas Piggin <npiggin@gmail.com>
>>     Cc: Paul Mackerras <paulus@samba.org>
>>     Cc: Uladzislau Rezki <uladzislau.rezki@sony.com>
>>     Cc: Naresh Kamboju <naresh.kamboju@linaro.org>
>>     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>>     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
>
> Since this commit, both WARN_ON() tests in pud_huge_tests() are
> triggering on arm64 if CONFIG_ARM64_VA_BITS_39=y and
> CONFIG_PGTABLE_LEVELS=3:
>
>     ------------[ cut here ]------------
>     WARNING: CPU: 0 PID: 1 at mm/debug_vm_pgtable.c:438
> debug_vm_pgtable+0x6d0/0x7c4
>     Modules linked in:
>     CPU: 0 PID: 1 Comm: swapper/0 Not tainted
> 5.13.0-salvator-x-00209-gc742199a014d #1068
>     Hardware name: Renesas Salvator-X 2nd version board based on  
> r8a77951 (DT)
>     pstate: a0400005 (NzCv daif +PAN -UAO -TCO BTYPE=--)
>     pc : debug_vm_pgtable+0x6d0/0x7c4
>     lr : debug_vm_pgtable+0x6cc/0x7c4
>     sp : ffffffc0124cbd00
>     x29: ffffffc0124cbd00 x28: 0000000000000c30 x27: ffffff84c5e465a0
>     x26: ffffff84c5e46000 x25: ffffff84c5e42000 x24: 00000000000005a0
>     x23: ffffffc010c41000 x22: 0020000050cb0fc3 x21: ffffff84c5e45ed0
>     x20: ffffff84c27470a8 x19: ffffff84c2747040 x18: 0000000000000cc0
>     x17: 00000000b2491cf5 x16: 0000000000000014 x15: 0000000000000000
>     x14: 0000000000000002 x13: 00000000000b56dd x12: 0000000000000901
>     x11: ffffffc01116d040 x10: 00000000000038e4 x9 : 00000000ffffffff
>     x8 : 0000000000000000 x7 : ffffffc010cc4cd0 x6 : 0000000000000000
>     x5 : 000000000004028e x4 : 0000000000000000 x3 : 0000000000000000
>     x2 : 0000000000000001 x1 : 0000000000000000 x0 : ffffff84c08bc040
>     Call trace:
>      debug_vm_pgtable+0x6d0/0x7c4
>      do_one_initcall+0xec/0x278
>      kernel_init_freeable+0x220/0x224
>      kernel_init+0x10/0x108
>      ret_from_fork+0x10/0x18
>     irq event stamp: 1062694
>     hardirqs last  enabled at (1062693): [<ffffffc0101bb030>]
> free_unref_page+0x120/0x138
>     hardirqs last disabled at (1062694): [<ffffffc01085f31c>]  
> el1_dbg+0x24/0x4c
>     softirqs last  enabled at (1062636): [<ffffffc0100101c8>]  
> _stext+0x1c8/0x43c
>     softirqs last disabled at (1062627): [<ffffffc010080020>]
> __irq_exit_rcu+0xdc/0x124
>     ---[ end trace 864024bcea12ea00 ]---
>     ------------[ cut here ]------------
>     WARNING: CPU: 0 PID: 1 at mm/debug_vm_pgtable.c:439
> debug_vm_pgtable+0x6d4/0x7c4
>     Modules linked in:
>     CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W
> 5.13.0-salvator-x-00209-gc742199a014d #1068
>     Hardware name: Renesas Salvator-X 2nd version board based on  
> r8a77951 (DT)
>     pstate: a0400005 (NzCv daif +PAN -UAO -TCO BTYPE=--)
>     pc : debug_vm_pgtable+0x6d4/0x7c4
>     lr : debug_vm_pgtable+0x6cc/0x7c4
>     sp : ffffffc0124cbd00
>     x29: ffffffc0124cbd00 x28: 0000000000000c30 x27: ffffff84c5e465a0
>     x26: ffffff84c5e46000 x25: ffffff84c5e42000 x24: 00000000000005a0
>     x23: ffffffc010c41000 x22: 0020000050cb0fc3 x21: ffffff84c5e45ed0
>     x20: ffffff84c27470a8 x19: ffffff84c2747040 x18: 0000000000000cc0
>     x17: 00000000b2491cf5 x16: 0000000000000014 x15: 0000000000000000
>     x14: 0000000000000002 x13: 00000000000b56dd x12: 0000000000000901
>     x11: ffffffc01116d040 x10: 00000000000038e4 x9 : 00000000ffffffff
>     x8 : 0000000000000000 x7 : ffffffc010cc4cd0 x6 : 0000000000000000
>     x5 : 000000000004028e x4 : 0000000000000000 x3 : 0000000000000000
>     x2 : 0000000000000001 x1 : 0000000000000000 x0 : ffffff84c08bc040
>     Call trace:
>      debug_vm_pgtable+0x6d4/0x7c4
>      do_one_initcall+0xec/0x278
>      kernel_init_freeable+0x220/0x224
>      kernel_init+0x10/0x108
>      ret_from_fork+0x10/0x18
>     irq event stamp: 1062706
>     hardirqs last  enabled at (1062705): [<ffffffc01085ef80>]
> exit_to_kernel_mode+0xf0/0x100
>     hardirqs last disabled at (1062706): [<ffffffc01085f31c>]  
> el1_dbg+0x24/0x4c
>     softirqs last  enabled at (1062704): [<ffffffc0100101c8>]  
> _stext+0x1c8/0x43c
>     softirqs last disabled at (1062697): [<ffffffc010080020>]
> __irq_exit_rcu+0xdc/0x124
>     ---[ end trace 864024bcea12ea01 ]---
>
> Switching to CONFIG_ARM64_VA_BITS_48=y and CONFIG_PGTABLE_LEVELS=4
> makes the warning disappear.
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 --  
> geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something  
> like that.
>                                 -- Linus Torvalds


