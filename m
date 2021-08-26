Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E858A3F8289
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 08:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239542AbhHZGiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 02:38:00 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:53543 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234415AbhHZGh7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 02:37:59 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4GwCnM01ljz9sVt;
        Thu, 26 Aug 2021 08:37:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QY9Ef38fe3qr; Thu, 26 Aug 2021 08:37:10 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4GwCnL67z6z9sVc;
        Thu, 26 Aug 2021 08:37:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B3E068B881;
        Thu, 26 Aug 2021 08:37:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 574dur1TrPVG; Thu, 26 Aug 2021 08:37:10 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 43D718B877;
        Thu, 26 Aug 2021 08:37:10 +0200 (CEST)
Subject: Re: [PATCH v2 2/2] powerpc/bug: Provide better flexibility to
 WARN_ON/__WARN_FLAGS() with asm goto
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nathan Chancellor <nathan@kernel.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        clang-built-linux@googlegroups.com, llvm@lists.linux.dev
References: <b286e07fb771a664b631cd07a40b09c06f26e64b.1618331881.git.christophe.leroy@csgroup.eu>
 <389962b1b702e3c78d169e59bcfac56282889173.1618331882.git.christophe.leroy@csgroup.eu>
 <YSa1O4fcX1nNKqN/@Ryzen-9-3900X.localdomain>
 <87h7fcc2m4.fsf@mpe.ellerman.id.au>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <3fad8702-278a-d9f9-1882-6958ce570bcc@csgroup.eu>
Date:   Thu, 26 Aug 2021 08:37:09 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <87h7fcc2m4.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 26/08/2021 à 05:21, Michael Ellerman a écrit :
> Nathan Chancellor <nathan@kernel.org> writes:
>> On Tue, Apr 13, 2021 at 04:38:10PM +0000, Christophe Leroy wrote:
>>> Using asm goto in __WARN_FLAGS() and WARN_ON() allows more
>>> flexibility to GCC.
> ...
>>
>> This patch as commit 1e688dd2a3d6 ("powerpc/bug: Provide better
>> flexibility to WARN_ON/__WARN_FLAGS() with asm goto") cause a WARN_ON in
>> klist_add_tail to trigger over and over on boot when compiling with
>> clang:

...

> 
> This patch seems to fix it. Not sure if that's just papering over it though.
> 
> diff --git a/arch/powerpc/include/asm/bug.h b/arch/powerpc/include/asm/bug.h
> index 1ee0f22313ee..75fcb4370d96 100644
> --- a/arch/powerpc/include/asm/bug.h
> +++ b/arch/powerpc/include/asm/bug.h
> @@ -119,7 +119,7 @@ __label_warn_on:						\
>   								\
>   			WARN_ENTRY(PPC_TLNEI " %4, 0",		\
>   				   BUGFLAG_WARNING | BUGFLAG_TAINT(TAINT_WARN),	\
> -				   __label_warn_on, "r" (x));	\
> +				   __label_warn_on, "r" (!!(x))); \
>   			break;					\
>   __label_warn_on:						\
>   			__ret_warn_on = true;			\
> 
> 

But for a simple WARN_ON() call:

void test(unsigned long b)
{
	WARN_ON(b);
}

Without your change with GCC you get:

00000000000012d0 <.test>:
     12d0:	0b 03 00 00 	tdnei   r3,0
     12d4:	4e 80 00 20 	blr


With the !! change you get:

00000000000012d0 <.test>:
     12d0:	31 23 ff ff 	addic   r9,r3,-1
     12d4:	7d 29 19 10 	subfe   r9,r9,r3
     12d8:	0b 09 00 00 	tdnei   r9,0
     12dc:	4e 80 00 20 	blr

Christophe
