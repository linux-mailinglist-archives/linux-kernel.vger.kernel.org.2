Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 181613653DA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 10:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbhDTITR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 04:19:17 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:24138 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229593AbhDTITP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 04:19:15 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FPc5Y6dKDz9v4gt;
        Tue, 20 Apr 2021 10:18:41 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id MBgtPNusX1Ra; Tue, 20 Apr 2021 10:18:41 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FPc5Y5rCXz9v4gs;
        Tue, 20 Apr 2021 10:18:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B22AA8B7F9;
        Tue, 20 Apr 2021 10:18:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id gCRjozVZBxHJ; Tue, 20 Apr 2021 10:18:42 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 22A0B8B7ED;
        Tue, 20 Apr 2021 10:18:42 +0200 (CEST)
Subject: Re: [PATCH] powerpc/legacy_serial: Use early_ioremap()
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hamish Martin <Hamish.Martin@alliedtelesis.co.nz>
References: <3df15946ed0c29663dc7928b31ca07576e1444f6.1580904214.git.christophe.leroy@c-s.fr>
 <d94f74c57112e002959143bb5ccdcd9be80ed8d2.camel@alliedtelesis.co.nz>
 <32c16eef-f426-4f7e-14aa-b9fbbbec59b8@alliedtelesis.co.nz>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <1b7cc535-7a6c-364c-11e5-11f9eef3e5d3@csgroup.eu>
Date:   Tue, 20 Apr 2021 10:18:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <32c16eef-f426-4f7e-14aa-b9fbbbec59b8@alliedtelesis.co.nz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

Le 10/08/2020 à 04:01, Chris Packham a écrit :
> 
> On 24/03/20 10:54 am, Chris Packham wrote:
>> Hi Christophe,
>>
>> On Wed, 2020-02-05 at 12:03 +0000, Christophe Leroy wrote:
>>> [    0.000000] ioremap() called early from
>>> find_legacy_serial_ports+0x3cc/0x474. Use early_ioremap() instead
>>>
>> I was just about to dig into this error message and found you patch. I
>> applied it to a v5.5 base.
>>
>>> find_legacy_serial_ports() is called early from setup_arch(), before
>>> paging_init(). vmalloc is not available yet, ioremap shouldn't be
>>> used that early.
>>>
>>> Use early_ioremap() and switch to a regular ioremap() later.
>>>
>>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> On my system (Freescale T2080 SOC) this seems to cause a crash/hang in
>> early boot. Unfortunately because this is affecting the boot console I
>> don't get any earlyprintk output.
> 
> I've been doing a bit more digging into why Christophe's patch didn't
> work for me. I noticed the powerpc specific early_ioremap_range()
> returns addresses around ioremap_bot. Yet the generic early_ioremap()
> uses addresses around FIXADDR_TOP. If I try the following hack I can
> make Christophe's patch work
> 
> diff --git a/arch/powerpc/include/asm/fixmap.h
> b/arch/powerpc/include/asm/fixmap.h
> index 2ef155a3c821..7bc2f3f73c8b 100644
> --- a/arch/powerpc/include/asm/fixmap.h
> +++ b/arch/powerpc/include/asm/fixmap.h
> @@ -27,7 +27,7 @@
>    #include <asm/kasan.h>
>    #define FIXADDR_TOP    (KASAN_SHADOW_START - PAGE_SIZE)
>    #else
> -#define FIXADDR_TOP    ((unsigned long)(-PAGE_SIZE))
> +#define FIXADDR_TOP    (IOREMAP_END - PAGE_SIZE)
>    #endif
> 
>    /*
> 
> I'll admit to being out of my depth. It seems that the generic
> early_ioremap() is not quite correctly plumbed in for powerpc.

Yes that's probably true for PPC64.

I see that on PPC32 I had to implement the following changes in order to enable earlier use of 
early_ioremap()

https://github.com/torvalds/linux/commit/925ac141d106b55acbe112a9272f970631a3c082


I have the problem with QEMU with the ppce500 machine. It will allow me to investigate it a bit further.
