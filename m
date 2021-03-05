Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84C3032E5F9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 11:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbhCEKQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 05:16:21 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:17969 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229589AbhCEKQC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 05:16:02 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DsNt244RQz9twsc;
        Fri,  5 Mar 2021 11:15:54 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id mlEySaZLrn-b; Fri,  5 Mar 2021 11:15:54 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DsNt22mhpz9twsb;
        Fri,  5 Mar 2021 11:15:54 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8FDC48B81C;
        Fri,  5 Mar 2021 11:15:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id pOWTMQOUWC-4; Fri,  5 Mar 2021 11:15:55 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1053A8B78B;
        Fri,  5 Mar 2021 11:15:55 +0100 (CET)
Subject: Re: [PATCH v3] powerpc/32: remove bogus ppc_select syscall
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <f08ef2b6f339ba19987cfef4307a4dd26b2faf97.1614933479.git.christophe.leroy@csgroup.eu>
 <CAK8P3a2b+u+8smkKWB-V2Non+nnZmNG4dNi6cGpM8weYuY5j6A@mail.gmail.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <5811950d-ef14-d416-35e6-d694ef920a7d@csgroup.eu>
Date:   Fri, 5 Mar 2021 11:15:52 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2b+u+8smkKWB-V2Non+nnZmNG4dNi6cGpM8weYuY5j6A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 05/03/2021 à 11:06, Arnd Bergmann a écrit :
> On Fri, Mar 5, 2021 at 9:40 AM Christophe Leroy
> <christophe.leroy@csgroup.eu> wrote:
>>
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> The ppc_select function was introduced in linux-2.3.48 in order to support
>> code confusing the legacy select() calling convention with the standard one.
>> Even 24 years ago, all correctly built code should not have done this and
>> could have easily been phased out. Nothing that was compiled later should
>> actually try to use the old_select interface, and it would have been broken
>> already on all ppc64 kernels with the syscall emulation layer.
>>
>> This patch brings the 32 bit compat ABI and the native 32 bit ABI for
>> powerpc into a consistent state, by removing support for both the
>> old_select system call number and the handler for it.
> 
> The description still seems wrong, please drop all the nonsense I wrote
> back then and explain what is actually going on.
> 
> This is what I can see from the linux-history tree:
> 
> - The original ppc32 port (linux-1.3.45) had a regular '__NR_select/sys_select'
>    syscall at #82 and an unusable '__NR__newselect/sys_panic' syscall at #142,
>    while i386 had the indirect '__NR_select/sys_oldselect' syscall at #82
>    and the regular '__NR__newselect/sys_select' version at #142. This was
>    rather confusing.
> 
> - linux-2.1.48 changed both #82 and #142 to the ppc_select() version that
>    tries to guess whether the x86 __NR_select/sys_oldselect() behavior or
>    the regular __NR__newselect/sys_select() behavior is used.
> 
> - linux-2.5.5 added ppc64 support, with a compat version of ppc_select()
>    on both #82 and #142 that would either use the __NR__newselect/sys_select
>    semantics or panic() when passed an invalud 'n'. The native ppc64
>    port started out with just __NR__newselect/sys_select() on #142
> 
> - linux-2.5.19 changed ppc64 compat mode to no longer panic(), making
>    both #82 and #142 behave like __NR__newselect/sys_select().
> 
> - glibc support for ppc32 gets merged during the linux-2.5 days, supporting
>    only #142 with the new behavior.
> 
> - linux-2.5.41 dropped support for #82 on ppc64 in compat mode but not
>    native ppc32.
> 
> - linux-2.6.14 merged the two architecture ports but kept the behavior
>    unchanged for both.
> 
> - linux-2.6.32 changed the native ppc32 #142 __NR__newselect to
>    behave the same as compat mode and no longer emulate the
>    x86 oldselect, but #82 remained unchanged.
> 
> So we have changed behavior multiple times in the past, and the
> current state still theoretically allows running non-glibc binaries that
> ran on kernels before 2.1.48 that used either the original powerpc
> select or the i386 compatible oldselect semantics. Chances are that
> those binaries are broken for some other reason now.
> 


Whaou, nice archeology, thanks. Do you mind if I copy the history you established ?

In your commit, you said 2.3.48. Here in the history you say 2.1.48. Which one is correct ?

Regardless of whethere binaries are broken or not for other reason, is that worth expecting an 
almost 25 yr old binary to run on future kernels ? If one is able to put the necessary effort to 
port you hardware to the latest kernel, can't he really port the binary as well ?

Thanks
Christophe
