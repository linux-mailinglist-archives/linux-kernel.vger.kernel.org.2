Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 591BA40D3BA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 09:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234777AbhIPHZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 03:25:27 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:46403 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234671AbhIPHZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 03:25:22 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4H97qh40qXz9sVF;
        Thu, 16 Sep 2021 09:24:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wKKfxh6TCdGx; Thu, 16 Sep 2021 09:24:00 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4H97qf313Xz9sVD;
        Thu, 16 Sep 2021 09:23:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 521AF8B763;
        Thu, 16 Sep 2021 09:23:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id pa4JKxB2Kswe; Thu, 16 Sep 2021 09:23:58 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.202.5])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A6F368B77E;
        Thu, 16 Sep 2021 09:23:57 +0200 (CEST)
Subject: Re: [PATCH] powerpc: warn on emulation of dcbz instruction
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Stan Johnson <userm57@yahoo.com>,
        Finn Thain <fthain@linux-m68k.org>
References: <62b33ca839f3d1d7d4b64b6f56af0bbe4d2c9057.1631716292.git.christophe.leroy@csgroup.eu>
 <2c0fd775625c76c4dd09b3e923da4405a003f3bd.camel@kernel.crashing.org>
 <eb1a39368401bf46e805ca64256604cc649f771e.camel@kernel.crashing.org>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <43f736d4-8625-2848-786f-79b902d5c753@csgroup.eu>
Date:   Thu, 16 Sep 2021 09:23:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <eb1a39368401bf46e805ca64256604cc649f771e.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 16/09/2021 à 09:16, Benjamin Herrenschmidt a écrit :
> On Thu, 2021-09-16 at 17:15 +1000, Benjamin Herrenschmidt wrote:
>> On Wed, 2021-09-15 at 16:31 +0200, Christophe Leroy wrote:
>>> dcbz instruction shouldn't be used on non-cached memory. Using
>>> it on non-cached memory can result in alignment exception and
>>> implies a heavy handling.
>>>
>>> Instead of silentely emulating the instruction and resulting in
>>> high
>>> performance degradation, warn whenever an alignment exception is
>>> taken due to dcbz, so that the user is made aware that dcbz
>>> instruction has been used unexpectedly.
>>>
>>> Reported-by: Stan Johnson <userm57@yahoo.com>
>>> Cc: Finn Thain <fthain@linux-m68k.org>
>>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>>> ---
>>>   arch/powerpc/kernel/align.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/arch/powerpc/kernel/align.c
>>> b/arch/powerpc/kernel/align.c
>>> index bbb4181621dd..adc3a4a9c6e4 100644
>>> --- a/arch/powerpc/kernel/align.c
>>> +++ b/arch/powerpc/kernel/align.c
>>> @@ -349,6 +349,7 @@ int fix_alignment(struct pt_regs *regs)
>>>   		if (op.type != CACHEOP + DCBZ)
>>>   			return -EINVAL;
>>>   		PPC_WARN_ALIGNMENT(dcbz, regs);
>>> +		WARN_ON_ONCE(1);
>>
>> This is heavy handed ... It will be treated as an oops by various
>> things uselessly spit out a kernel backtrace. Isn't
>> PPC_WARN_ALIGNMENT
>> enough ?


PPC_WARN_ALIGNMENT() only warns if explicitely activated, I want to 
catch uses on 'dcbz' on non-cached memory all the time as they are most 
often the result of using memset() instead of memset_io().

> 
> Ah I saw your other one about fbdev...  Ok what about you do that in a
> if (!user_mode(regs)) ?

Yes I can do WARN_ON_ONCE(!user_mode(regs)); instead.

> 
> Indeed the kernel should not do that.


Does userspace accesses non-cached memory directly ?

Christophe
