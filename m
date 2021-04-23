Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C03E0368E06
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 09:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241086AbhDWHko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 03:40:44 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:60876 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229993AbhDWHkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 03:40:41 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FRR5b1yHcz9typ8;
        Fri, 23 Apr 2021 09:40:03 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id ELss1ENvDDh3; Fri, 23 Apr 2021 09:40:03 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FRR5b14z2z9typ7;
        Fri, 23 Apr 2021 09:40:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 80B0A8B79D;
        Fri, 23 Apr 2021 09:40:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id KUSTaPnXfcX5; Fri, 23 Apr 2021 09:40:04 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D6ACA8B79A;
        Fri, 23 Apr 2021 09:40:03 +0200 (CEST)
Subject: Re: [PATCH 1/2] powerpc/vdso64: link vdso64 with linker
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Fangrui Song <maskray@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <20200901222523.1941988-1-ndesaulniers@google.com>
 <20200901222523.1941988-2-ndesaulniers@google.com>
 <87blio1ilu.fsf@mpe.ellerman.id.au>
 <CAKwvOd=ZeJU+vLUk2P7FpX35haj7AC50B9Yps4pyoGCpd7ueTw@mail.gmail.com>
 <3d837a36-a186-6789-7924-eaa97f056b68@csgroup.eu>
 <CAKwvOd=KP5CZ5wOrczC6qPAzN7DdFCJ_XvU6e=zvB3XpQrp_-g@mail.gmail.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <b73db2b3-16c5-caaf-acf4-9d22d45cba5d@csgroup.eu>
Date:   Fri, 23 Apr 2021 09:40:01 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <CAKwvOd=KP5CZ5wOrczC6qPAzN7DdFCJ_XvU6e=zvB3XpQrp_-g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 23/04/2021 à 00:44, Nick Desaulniers a écrit :
> On Wed, Sep 2, 2020 at 11:02 AM Christophe Leroy
> <christophe.leroy@csgroup.eu> wrote:
>>
>>
>>
>> Le 02/09/2020 à 19:41, Nick Desaulniers a écrit :
>>> On Wed, Sep 2, 2020 at 5:14 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>>>>
>>>> Nick Desaulniers <ndesaulniers@google.com> writes:
>>>>> Fixes: commit f2af201002a8 ("powerpc/build: vdso linker warning for orphan sections")
>>>>
>>>> I think I'll just revert that for v5.9 ?
>>>
>>> SGTM; you'll probably still want these changes with some modifications
>>> at some point; vdso32 did have at least one orphaned section, and will
>>> be important for hermetic builds.  Seeing crashes in supported
>>> versions of the tools ties our hands at the moment.
>>>
>>
>> Keeping the tool problem aside with binutils 2.26, do you have a way to
>> really link an elf32ppc object when  building vdso32 for PPC64 ?
> 
> Sorry, I'm doing a bug scrub and found
> https://github.com/ClangBuiltLinux/linux/issues/774 still open (and my
> reply to this thread still in Drafts; never sent). With my patches
> rebased:
> $ file arch/powerpc/kernel/vdso32/vdso32.so
> arch/powerpc/kernel/vdso32/vdso32.so: ELF 32-bit MSB shared object,
> PowerPC or cisco 4500, version 1 (SYSV), dynamically linked, stripped
> 
> Are you still using 2.26?

Yes, our production kernels and applications are built with gcc 5.5 and binutils 2.26

> 
> I'm not able to repro Nathan's reported issue from
> https://lore.kernel.org/lkml/20200902052123.GA2687902@ubuntu-n2-xlarge-x86/,
> so I'm curious if I should resend the rebased patches as v2?
> 

I can't remember what was all this discussion about.

I gave a try to your rebased patches.

Still an issue with binutils 2.26:

   VDSO32L arch/powerpc/kernel/vdso32/vdso32.so.dbg
ppc-linux-ld: warning: orphan section `.rela.got' from `arch/powerpc/kernel/vdso32/sigtramp.o' being 
placed in section `.rela.dyn'.
ppc-linux-ld: warning: orphan section `.rela.plt' from `arch/powerpc/kernel/vdso32/sigtramp.o' being 
placed in section `.rela.dyn'.
ppc-linux-ld: warning: orphan section `.glink' from `arch/powerpc/kernel/vdso32/sigtramp.o' being 
placed in section `.glink'.
ppc-linux-ld: warning: orphan section `.iplt' from `arch/powerpc/kernel/vdso32/sigtramp.o' being 
placed in section `.iplt'.
ppc-linux-ld: warning: orphan section `.rela.iplt' from `arch/powerpc/kernel/vdso32/sigtramp.o' 
being placed in section `.rela.dyn'.
ppc-linux-ld: warning: orphan section `.rela.text' from `arch/powerpc/kernel/vdso32/sigtramp.o' 
being placed in section `.rela.dyn'.
/bin/sh: line 1:  7850 Segmentation fault      (core dumped) ppc-linux-ld -EB -m elf32ppc -shared 
-soname linux-vdso32.so.1 --eh-frame-hdr --orphan-handling=warn -T 
arch/powerpc/kernel/vdso32/vdso32.lds arch/powerpc/kernel/vdso32/sigtramp.o 
arch/powerpc/kernel/vdso32/gettimeofday.o arch/powerpc/kernel/vdso32/datapage.o 
arch/powerpc/kernel/vdso32/cacheflush.o arch/powerpc/kernel/vdso32/note.o 
arch/powerpc/kernel/vdso32/getcpu.o arch/powerpc/kernel/vdso32/vgettimeofday.o -o 
arch/powerpc/kernel/vdso32/vdso32.so.dbg
make[2]: *** [arch/powerpc/kernel/vdso32/vdso32.so.dbg] Error 139
make[2]: *** Deleting file `arch/powerpc/kernel/vdso32/vdso32.so.dbg'



With gcc 10.1 and binutils 2.34 I get:

PPC32 build:

   VDSO32L arch/powerpc/kernel/vdso32/vdso32.so.dbg
powerpc64-linux-ld: warning: orphan section `.rela.got' from `arch/powerpc/kernel/vdso32/sigtramp.o' 
being placed in section `.rela.dyn'
powerpc64-linux-ld: warning: orphan section `.rela.plt' from `arch/powerpc/kernel/vdso32/sigtramp.o' 
being placed in section `.rela.dyn'
powerpc64-linux-ld: warning: orphan section `.glink' from `arch/powerpc/kernel/vdso32/sigtramp.o' 
being placed in section `.glink'
powerpc64-linux-ld: warning: orphan section `.iplt' from `arch/powerpc/kernel/vdso32/sigtramp.o' 
being placed in section `.iplt'
powerpc64-linux-ld: warning: orphan section `.rela.iplt' from 
`arch/powerpc/kernel/vdso32/sigtramp.o' being placed in section `.rela.dyn'
powerpc64-linux-ld: warning: orphan section `.rela.branch_lt' from 
`arch/powerpc/kernel/vdso32/sigtramp.o' being placed in section `.rela.dyn'
powerpc64-linux-ld: warning: orphan section `.rela.text' from 
`arch/powerpc/kernel/vdso32/sigtramp.o' being placed in section `.rela.dyn'


PPC64 build:

   VDSO32L arch/powerpc/kernel/vdso32/vdso32.so.dbg
powerpc64-linux-ld: warning: orphan section `.rela.got' from `arch/powerpc/kernel/vdso32/sigtramp.o' 
being placed in section `.rela.dyn'
powerpc64-linux-ld: warning: orphan section `.rela.plt' from `arch/powerpc/kernel/vdso32/sigtramp.o' 
being placed in section `.rela.dyn'
powerpc64-linux-ld: warning: orphan section `.glink' from `arch/powerpc/kernel/vdso32/sigtramp.o' 
being placed in section `.glink'
powerpc64-linux-ld: warning: orphan section `.iplt' from `arch/powerpc/kernel/vdso32/sigtramp.o' 
being placed in section `.iplt'
powerpc64-linux-ld: warning: orphan section `.rela.iplt' from 
`arch/powerpc/kernel/vdso32/sigtramp.o' being placed in section `.rela.dyn'
powerpc64-linux-ld: warning: orphan section `.rela.branch_lt' from 
`arch/powerpc/kernel/vdso32/sigtramp.o' being placed in section `.rela.dyn'
powerpc64-linux-ld: warning: orphan section `.rela.text' from 
`arch/powerpc/kernel/vdso32/sigtramp.o' being placed in section `.rela.dyn'
   VDSOSYM include/generated/vdso32-offsets.h
   VDSO64L arch/powerpc/kernel/vdso64/vdso64.so.dbg
powerpc64-linux-ld: warning: orphan section `.iplt' from `linker stubs' being placed in section `.iplt'
powerpc64-linux-ld: warning: orphan section `.rela.iplt' from `linker stubs' being placed in section 
`.rela.dyn'
powerpc64-linux-ld: warning: orphan section `.rela.branch_lt' from `linker stubs' being placed in 
section `.rela.dyn'
powerpc64-linux-ld: warning: orphan section `.rela.branch_lt' from `linker stubs' being placed in 
section `.rela.dyn'
powerpc64-linux-ld: warning: orphan section `.plt' from `linker stubs' being placed in section `.plt'
powerpc64-linux-ld: warning: orphan section `.rela.plt' from `linker stubs' being placed in section 
`.rela.dyn'
powerpc64-linux-ld: warning: orphan section `.rela.got' from `linker stubs' being placed in section 
`.rela.dyn'
powerpc64-linux-ld: warning: orphan section `.rela.opd' from `linker stubs' being placed in section 
`.rela.dyn'


Christophe
