Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 938643A2A5E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 13:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbhFJLiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 07:38:10 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:36675 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230269AbhFJLiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 07:38:09 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4G123v3DB9zBC5V;
        Thu, 10 Jun 2021 13:36:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wSoijWmDdUVV; Thu, 10 Jun 2021 13:36:11 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4G123v2F7dzBC5R;
        Thu, 10 Jun 2021 13:36:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 391C38B80F;
        Thu, 10 Jun 2021 13:36:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 6_f0uI08IMWG; Thu, 10 Jun 2021 13:36:11 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id ACD238B815;
        Thu, 10 Jun 2021 13:36:10 +0200 (CEST)
Subject: Re: [PATCH] powerpc/vdso: Fix multiple issues with sys_call_table
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Anton Blanchard <anton@ozlabs.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, christophe.leroy@c-s.fr,
        benh@kernel.crashing.org, paulus@ozlabs.org
References: <20200306135705.7f80fcad@kryten.localdomain>
 <87pnd9duac.fsf@mpe.ellerman.id.au>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <bd19e9b8-a96b-90f8-5a0a-2643a1d860e4@csgroup.eu>
Date:   Thu, 10 Jun 2021 13:36:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87pnd9duac.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 19/03/2020 à 02:10, Michael Ellerman a écrit :
> Anton Blanchard <anton@ozlabs.org> writes:
>> The VDSO exports a bitmap of valid syscalls. vdso_setup_syscall_map()
>> sets this up, but there are both little and big endian bugs. The issue
>> is with:
>>
>>         if (sys_call_table[i] != sys_ni_syscall)
>>
>> On little endian, instead of comparing pointers to the two functions,
>> we compare the first two instructions of each function. If a function
>> happens to have the same first two instructions as sys_ni_syscall, then
>> we have a spurious match and mark the instruction as not implemented.
>> Fix this by removing the inline declarations.
>>
>> On big endian we have a further issue where sys_ni_syscall is a function
>> descriptor and sys_call_table[] holds pointers to the instruction text.
>> Fix this by using dereference_kernel_function_descriptor().
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Anton Blanchard <anton@ozlabs.org>
> 
> That's some pretty epic breakage.
> 
> Is it even worth keeping, or should we just rip it out and declare that
> the syscall map is junk? Userspace can hardly rely on it given it's been
> this broken for so long.
> 
> If not it would be really nice to have a selftest of this stuff so we
> can verify it works and not break it again in future.
> 

The problem on little endian is fixed by https://github.com/linuxppc/linux/commit/bc9d5bfc4 I think.

On big endian, I can't see any problem. Looks like sys_call_table in a vmlinux generated with 
ppc64_defconfig contains addresses of items in the opd. So it should be ok, shoudln't it ?

[root@po9473vm linux-powerpc]# powerpc64-linux-objdump -x vmlinux | grep -e " sys_call_table" -e 
ni_syscall
c000000000fc0748 g       .rodata	0000000000000000 sys_call_table
c00000000019fd90 g     F .text	0000000000000028 .sys_ni_syscall
c000000001cc3678 g     F .opd	0000000000000018 sys_ni_syscall

[root@po9473vm linux-powerpc]# powerpc64-linux-objdump -s -j .rodata vmlinux
Contents of section .rodata:
...
  c000000000fc0740 a610e9ee a3f43156 c0000000 01cc0888  ......1V........
  c000000000fc0750 c0000000 01cbf5c8 c0000000 01cbe788  ................
  c000000000fc0760 c0000000 01cf6768 c0000000 01cf6798  ......gh......g.
  c000000000fc0770 c0000000 01cf6240 c0000000 01cf5dd8  ......b@......].
  c000000000fc0780 c0000000 01cbf670 c0000000 01cf61e0  .......p......a.
  c000000000fc0790 c0000000 01cf8490 c0000000 01cf8580  ................
  c000000000fc07a0 c0000000 01cf7890 c0000000 01cf5e50  ......x.......^P
  c000000000fc07b0 c0000000 01ccf120 c0000000 01cf8358  ....... .......X
  c000000000fc07c0 c0000000 01cf6060 c0000000 01cf6108  ......``......a.
  c000000000fc07d0 c0000000 01cc3678 c0000000 01cc3678  ......6x......6x
  c000000000fc07e0 c0000000 01cf63a8 c0000000 01cc1680  ......c.........
  c000000000fc07f0 c0000000 01cfac50 c0000000 01cc3678  .......P......6x
...


Do you agree ?

Christophe
