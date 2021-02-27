Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C679F326CB6
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Feb 2021 11:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhB0KcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Feb 2021 05:32:01 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:43071 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229795AbhB0Kb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Feb 2021 05:31:59 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DnjVW038rz9ty5v;
        Sat, 27 Feb 2021 11:31:15 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 4h_HczVVdAdx; Sat, 27 Feb 2021 11:31:14 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DnjVV54hBz9ty5t;
        Sat, 27 Feb 2021 11:31:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EC11A8B77A;
        Sat, 27 Feb 2021 11:31:15 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id W-ItOljZNSxg; Sat, 27 Feb 2021 11:31:15 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 186948B75B;
        Sat, 27 Feb 2021 11:31:15 +0100 (CET)
Subject: Re: [PATCH] powerpc/bug: Remove specific powerpc BUG_ON()
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <694c7195c81d1bcc781b3c14f452886683d6c524.1613029237.git.christophe.leroy@csgroup.eu>
 <20210211114910.GA28121@gate.crashing.org>
 <6126ca14-419a-9e15-7ffa-b295f26a552e@csgroup.eu>
 <20210211143059.GE28121@gate.crashing.org>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <f6f7ae76-c6d9-9a5e-043d-07f6d0270ceb@csgroup.eu>
Date:   Sat, 27 Feb 2021 11:31:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210211143059.GE28121@gate.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 11/02/2021 à 15:30, Segher Boessenkool a écrit :
> On Thu, Feb 11, 2021 at 03:09:43PM +0100, Christophe Leroy wrote:
>> Le 11/02/2021 à 12:49, Segher Boessenkool a écrit :
>>> On Thu, Feb 11, 2021 at 07:41:52AM +0000, Christophe Leroy wrote:
>>>> powerpc BUG_ON() is based on using twnei or tdnei instruction,
>>>> which obliges gcc to format the condition into a 0 or 1 value
>>>> in a register.
>>>
>>> Huh?  Why is that?
>>>
>>> Will it work better if this used __builtin_trap?  Or does the kernel only
>>> detect very specific forms of trap instructions?
>>
>> We already made a try with __builtin_trap() 1,5 year ago, see
>> https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20510ce03cc9463f1c9e743c1d93b939de501b53.1566219503.git.christophe.leroy@c-s.fr/
>>
>> The main problems encountered are:
>> - It is only possible to use it for BUG_ON, not for WARN_ON because GCC
>> considers it as noreturn. Is there any workaround ?
> 
> A trap is noreturn by definition:
> 
>   -- Built-in Function: void __builtin_trap (void)
>       This function causes the program to exit abnormally.
> 
>> - The kernel (With CONFIG_DEBUG_BUGVERBOSE) needs to be able to identify
>> the source file and line corresponding to the trap. How can that be done
>> with __builtin_trap() ?
> 
> The DWARF debug info should be sufficient.  Perhaps you can post-process
> some way?
> 
> You can create a trap that falls through yourself (by having a trap-on
> condition with a condition that is always true, but make the compiler
> not see that).  This isn't efficient though.
> 
> Could you file a feature request (in bugzilla)?  It is probably useful
> for generic code as well, but we could implement this for powerpc only
> if needed.
> 

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99299

Christophe
