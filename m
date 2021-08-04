Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5DEB3DFB68
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 08:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235602AbhHDGVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 02:21:44 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:45069 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235581AbhHDGVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 02:21:41 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4GfhTN2kJgz9sWH;
        Wed,  4 Aug 2021 08:21:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id p4tzhmeMpm41; Wed,  4 Aug 2021 08:21:28 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4GfhTN1jp0z9sWG;
        Wed,  4 Aug 2021 08:21:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1C2408B79A;
        Wed,  4 Aug 2021 08:21:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 5WYofiaNHTmR; Wed,  4 Aug 2021 08:21:28 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 640D48B764;
        Wed,  4 Aug 2021 08:21:27 +0200 (CEST)
Subject: Re: [PATCH] powerpc/32s: Fix napping restore in data storage
 interrupt (DSI)
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, userm57@yahoo.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Finn Thain <fthain@linux-m68k.org>
References: <731694e0885271f6ee9ffc179eb4bcee78313682.1628003562.git.christophe.leroy@csgroup.eu>
 <ce20d16c-b0b2-94c-3e22-794d95c376b@linux-m68k.org>
 <b04a90a9-9d62-2192-f896-ea99be911604@csgroup.eu>
Message-ID: <8fb08f68-ed01-65f9-fb9e-66abf2b18a00@csgroup.eu>
Date:   Wed, 4 Aug 2021 08:21:26 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <b04a90a9-9d62-2192-f896-ea99be911604@csgroup.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nic,

I think I'll need your help on that one.

Le 04/08/2021 à 08:07, Christophe Leroy a écrit :
> 
> 
> Le 04/08/2021 à 06:04, Finn Thain a écrit :
>> On Tue, 3 Aug 2021, Christophe Leroy wrote:
>>
...
>>
>> ------------[ cut here ]------------
>> kernel BUG at arch/powerpc/kernel/interrupt.c:49!
>> Oops: Exception in kernel mode, sig: 5 [#1]
>> BE PAGE_SIZE=4K MMU=Hash SMP NR_CPUS=2 PowerMac
>> Modules linked in:
>> CPU: 0 PID: 1859 Comm: xfce4-session Not tainted 5.13.0-pmac-VMAP #10
>> NIP:  c0011474 LR: c0011464 CTR: 00000000
>> REGS: e2f75e40 TRAP: 0700   Not tainted  (5.13.0-pmac-VMAP)
>> MSR:  00021032 <ME,IR,DR,RI>  CR: 2400446c  XER: 20000000
>>
>> GPR00: c001604c e2f75f00 ca284a60 00000000 00000000 a5205eb0 00000008 00000020
>> GPR08: ffffffc0 00000001 501200d9 ce030005 ca285010 00c1f778 00000000 00000000
>> GPR16: 00945b20 009402f8 00000001 a6b87550 a51fd000 afb73220 a6b22c78 a6a6aecc
>> GPR24: 00000000 ffffffc0 00000020 00000008 a5205eb0 00000000 e2f75f40 000000ae
>> NIP [c0011474] system_call_exception+0x60/0x164
>> LR [c0011464] system_call_exception+0x50/0x164
>> Call Trace:
>> [e2f75f00] [00009000] 0x9000 (unreliable)
>> [e2f75f30] [c001604c] ret_from_syscall+0x0/0x28
>> --- interrupt: c00 at 0xa69d6cb0
>> NIP:  a69d6cb0 LR: a69d6c3c CTR: 00000000
>> REGS: e2f75f40 TRAP: 0c00   Not tainted  (5.13.0-pmac-VMAP)
>> MSR:  0000d032 <EE,PR,ME,IR,DR,RI>  CR: 2400446c  XER: 20000000
>>
>> GPR00: 000000ae a5205de0 a5687ca0 00000000 00000000 a5205eb0 00000008 00000020
>> GPR08: ffffffc0 401201ea 401200d9 ffffffff c158f230 00c1f778 00000000 00000000
>> GPR16: 00945b20 009402f8 00000001 a6b87550 a51fd000 afb73220 a6b22c78 a6a6aecc
>> GPR24: afb72fc8 00000000 00000001 a5205f30 afb733dc 00000000 a6b85ff4 a5205eb0
>> NIP [a69d6cb0] 0xa69d6cb0
>> LR [a69d6c3c] 0xa69d6c3c
>> --- interrupt: c00
>> Instruction dump:
>> 7cdb3378 93810020 7cbc2b78 93a10024 7c9d2378 93e1002c 7d3f4b78 4800d629
>> 817e0084 931e0088 69690002 5529fffe <0f090000> 69694000 552997fe 0f090000
>> ---[ end trace c66c6c3c44806276 ]---
>>

Getting a BUG at arch/powerpc/kernel/interrupt.c:49 meaning MSR_RI is not set, but the c00 interrupt 
frame shows MSR_RI properly set, so what ?

Thanks
Christophe
