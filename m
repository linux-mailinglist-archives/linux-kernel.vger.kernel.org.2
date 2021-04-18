Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9253634AA
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Apr 2021 12:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhDRKou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 06:44:50 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:53883 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229564AbhDRKod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 06:44:33 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FNRQ86t5cz9vBmS;
        Sun, 18 Apr 2021 12:44:00 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id d54YPj4tRfSP; Sun, 18 Apr 2021 12:44:00 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FNRQ85vyTz9vBmQ;
        Sun, 18 Apr 2021 12:44:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DB7918B79B;
        Sun, 18 Apr 2021 12:44:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Dh9WCAivhXwx; Sun, 18 Apr 2021 12:44:03 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7A5CC8B799;
        Sun, 18 Apr 2021 12:44:03 +0200 (CEST)
Subject: Re: mmu.c:undefined reference to `patch__hash_page_A0'
To:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>
References: <202102271820.WlZCxtzY-lkp@intel.com>
 <06227600-c5c5-3da7-a495-ae0b0849b62d@infradead.org>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <ab9d4f9e-add6-900b-9fa7-83d5f7d1108b@csgroup.eu>
Date:   Sun, 18 Apr 2021 12:43:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <06227600-c5c5-3da7-a495-ae0b0849b62d@infradead.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 18/04/2021 � 02:02, Randy Dunlap a �crit�:
> HI--
> 
> I no longer see this build error.

Fixed by https://github.com/torvalds/linux/commit/acdad8fb4a1574323db88f98a38b630691574e16

> However:
> 
> On 2/27/21 2:24 AM, kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   3fb6d0e00efc958d01c2f109c8453033a2d96796
>> commit: 259149cf7c3c6195e6199e045ca988c31d081cab powerpc/32s: Only build hash code when CONFIG_PPC_BOOK3S_604 is selected
>> date:   4 weeks ago
>> config: powerpc64-randconfig-r013-20210227 (attached as .config)
> 
> ktr/lkp, this is a PPC32 .config file that is attached, not PPC64.
> 
> Also:
> 
>> compiler: powerpc-linux-gcc (GCC) 9.3.0

...

> 
> I do see this build error:
> 
> powerpc-linux-ld: arch/powerpc/boot/wrapper.a(decompress.o): in function `partial_decompress':
> decompress.c:(.text+0x1f0): undefined reference to `__decompress'
> 
> when either
> CONFIG_KERNEL_LZO=y
> or
> CONFIG_KERNEL_LZMA=y
> 
> but the build succeeds when either
> CONFIG_KERNEL_GZIP=y
> or
> CONFIG_KERNEL_XZ=y
> 
> I guess that is due to arch/powerpc/boot/decompress.c doing this:
> 
> #ifdef CONFIG_KERNEL_GZIP
> #	include "decompress_inflate.c"
> #endif
> 
> #ifdef CONFIG_KERNEL_XZ
> #	include "xz_config.h"
> #	include "../../../lib/decompress_unxz.c"
> #endif
> 
> 
> It would be nice to require one of KERNEL_GZIP or KERNEL_XZ
> to be set/enabled (maybe unless a uImage is being built?).


Can you test by 
https://patchwork.ozlabs.org/project/linuxppc-dev/patch/a74fce4dfc9fa32da6ce3470bbedcecf795de1ec.1591189069.git.christophe.leroy@csgroup.eu/ 
?

Thanks
Christophe
