Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24B183B2D46
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 13:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbhFXLMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 07:12:07 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:5976 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232346AbhFXLMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 07:12:06 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4G9cpx3dSFzBDTt;
        Thu, 24 Jun 2021 13:09:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id k-tcnJDoux7Z; Thu, 24 Jun 2021 13:09:45 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4G9cpw4Y8dzBDTJ;
        Thu, 24 Jun 2021 13:09:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7D0A98B7E7;
        Thu, 24 Jun 2021 13:09:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 0xfF4S_8GNu9; Thu, 24 Jun 2021 13:09:44 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E65E88B764;
        Thu, 24 Jun 2021 13:09:43 +0200 (CEST)
Subject: Re: [PATCH v2] powerpc/kprobes: Fix Oops by passing ppc_inst as a
 pointer to emulate_step() on ppc32
To:     "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <5bdc8cbc9a95d0779e27c9ddbf42b40f51f883c0.1624425798.git.christophe.leroy@csgroup.eu>
 <1624531892.3vdz8ibfty.naveen@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <b44b66f4-3e46-425b-3c8e-d5a7a180494a@csgroup.eu>
Date:   Thu, 24 Jun 2021 13:09:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1624531892.3vdz8ibfty.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 24/06/2021 à 12:59, Naveen N. Rao a écrit :
> Christophe Leroy wrote:
>> From: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
>>
>> Trying to use a kprobe on ppc32 results in the below splat:
>>     BUG: Unable to handle kernel data access on read at 0x7c0802a6
>>     Faulting instruction address: 0xc002e9f0
>>     Oops: Kernel access of bad area, sig: 11 [#1]
>>     BE PAGE_SIZE=4K PowerPC 44x Platform
>>     Modules linked in:
>>     CPU: 0 PID: 89 Comm: sh Not tainted 5.13.0-rc1-01824-g3a81c0495fdb #7
>>     NIP:  c002e9f0 LR: c0011858 CTR: 00008a47
>>     REGS: c292fd50 TRAP: 0300   Not tainted  (5.13.0-rc1-01824-g3a81c0495fdb)
>>     MSR:  00009000 <EE,ME>  CR: 24002002  XER: 20000000
>>     DEAR: 7c0802a6 ESR: 00000000
>>     <snip>
>>     NIP [c002e9f0] emulate_step+0x28/0x324
>>     LR [c0011858] optinsn_slot+0x128/0x10000
>>     Call Trace:
>>      opt_pre_handler+0x7c/0xb4 (unreliable)
>>      optinsn_slot+0x128/0x10000
>>      ret_from_syscall+0x0/0x28
>>
>> The offending instruction is:
>>     81 24 00 00     lwz     r9,0(r4)
>>
>> Here, we are trying to load the second argument to emulate_step():
>> struct ppc_inst, which is the instruction to be emulated. On ppc64,
>> structures are passed in registers when passed by value. However, per
>> the ppc32 ABI, structures are always passed to functions as pointers.
>> This isn't being adhered to when setting up the call to emulate_step()
>> in the optprobe trampoline. Fix the same.
>>
>> Fixes: eacf4c0202654a ("powerpc: Enable OPTPROBES on PPC32")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
>> ---
>> v2: Rebased on powerpc/merge 7f030e9d57b8
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> 
> Thanks for rebasing this!
> 
> I think git am drops everything after three dashes, so applying this patch will drop your SOB. The 
> recommended style (*) for adding a changelog is to include it within [] before the second SOB.
> 

Yes, I saw that after sending the mail. Usually I add a signed-off-by with 'git --amend -s' when I 
add the history, so it goes before the '---' I'm adding.

This time I must have forgotten the '-s' so it was added by the 'git format-patch -s' which is in my 
submit script, and so it was added at the end.

It's not really a big deal, up to Michael to either move it at the right place or discard it, I 
don't really mind. Do the easiest for you.

Thanks
Christophe
