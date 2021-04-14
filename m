Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1C6A35F426
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 14:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbhDNMnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 08:43:18 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:51148 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233225AbhDNMnQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 08:43:16 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FL2F84yKmz9txVV;
        Wed, 14 Apr 2021 14:42:52 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id nM2lXP3VZmSI; Wed, 14 Apr 2021 14:42:52 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FL2F83Ygfz9txVT;
        Wed, 14 Apr 2021 14:42:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5B6208B7C6;
        Wed, 14 Apr 2021 14:42:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id G6vVtpZps7WL; Wed, 14 Apr 2021 14:42:53 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4F3858B7C0;
        Wed, 14 Apr 2021 14:42:52 +0200 (CEST)
Subject: Re: [PATCH v1 1/2] powerpc/bitops: Use immediate operand when
 possible
To:     Segher Boessenkool <segher@kernel.crashing.org>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Paul Mackerras <paulus@samba.org>
References: <09da6fec57792d6559d1ea64e00be9870b02dab4.1617896018.git.christophe.leroy@csgroup.eu>
 <20210412215428.GM26583@gate.crashing.org>
 <ecb1b1a5-ae92-e8a3-6490-26341edfbccb@csgroup.eu>
 <20210413215803.GT26583@gate.crashing.org>
 <1618365589.67fxh7cot9.astroid@bobo.none>
 <20210414122409.GV26583@gate.crashing.org>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <daacce9f-1900-1034-980b-be5a58d6be09@csgroup.eu>
Date:   Wed, 14 Apr 2021 14:42:51 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210414122409.GV26583@gate.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 14/04/2021 à 14:24, Segher Boessenkool a écrit :
> On Wed, Apr 14, 2021 at 12:01:21PM +1000, Nicholas Piggin wrote:
>> Would be nice if we could let the compiler deal with it all...
>>
>> static inline unsigned long lr(unsigned long *mem)
>> {
>>          unsigned long val;
>>
>>          /*
>>           * This doesn't clobber memory but want to avoid memory operations
>>           * moving ahead of it
>>           */
>>          asm volatile("ldarx     %0, %y1" : "=r"(val) : "Z"(*mem) : "memory");
>>
>>          return val;
>> }
> 
> (etc.)
> 
> That can not work reliably: the compiler can put random instructions
> between the larx and stcx. this way, and you then do not have guaranteed
> forward progress anymore.  It can put the two in different routines
> (after inlining and other interprocedural optimisations), duplicate
> them, make a different number of copies of them, etc.
> 
> Nothing of that is okay if you want to guarantee forward progress on all
> implementations, and also not if you want to have good performance
> everywhere (or anywhere even).  Unfortunately you have to write all
> larx/stcx. loops as one block of assembler, so that you know exactly
> what instructions will end up in your binary.
> 
> If you don't, it will fail mysteriously after random recompilations, or
> have performance degradations, etc.  You don't want to go there :-)
> 

Could the kernel use GCC builtin atomic functions instead ?

https://gcc.gnu.org/onlinedocs/gcc/_005f_005fatomic-Builtins.html


