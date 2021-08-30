Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A15F3FB0E0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 07:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbhH3FrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 01:47:13 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:48851 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232460AbhH3FrI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 01:47:08 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4GyfSk1d5gz9sS4;
        Mon, 30 Aug 2021 07:46:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zA3Iyf5HNa0c; Mon, 30 Aug 2021 07:46:14 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4GyfSk0fGSz9sS3;
        Mon, 30 Aug 2021 07:46:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id ED3FA8B772;
        Mon, 30 Aug 2021 07:46:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 22uqgGtz1eIP; Mon, 30 Aug 2021 07:46:13 +0200 (CEST)
Received: from [172.25.230.100] (po15451.idsi0.si.c-s.fr [172.25.230.100])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CD8998B763;
        Mon, 30 Aug 2021 07:46:13 +0200 (CEST)
Subject: Re: decompress.c:undefined reference to `__decompress'
To:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202105211642.tUeKonkw-lkp@intel.com>
 <daa93504-5d42-a5f1-ae7a-3b802fd661f7@infradead.org>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <331a1d60-360a-0ba4-cd01-65ae3121e943@csgroup.eu>
Date:   Mon, 30 Aug 2021 07:46:13 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <daa93504-5d42-a5f1-ae7a-3b802fd661f7@infradead.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 30/08/2021 à 04:30, Randy Dunlap a écrit :
> On 5/21/21 1:20 AM, kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   79a106fc6585979022012e65a1e45e3d2d28b77b
>> commit: 665d8d58761cba41147fe7e98e2ceed1cbf603a2 powerpc/akebono: Fix unmet dependency errors
>> date:   3 months ago
>> config: powerpc64-randconfig-r023-20210521 (attached as .config)
>> compiler: powerpc-linux-gcc (GCC) 9.3.0
>> reproduce (this is a W=1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O 
>> ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # 
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=665d8d58761cba41147fe7e98e2ceed1cbf603a2 
>>
>>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>          git fetch --no-tags linus master
>>          git checkout 665d8d58761cba41147fe7e98e2ceed1cbf603a2
>>          # save the attached .config to linux build tree
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=powerpc64
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>     powerpc-linux-ld: arch/powerpc/boot/wrapper.a(decompress.o): in function `partial_decompress':
>>>> decompress.c:(.text+0x1f0): undefined reference to `__decompress'
>>
>> ---
> 
> Hi Christophe,
> 
> Didn't you have a patch that adds boot support in Powerpc for
> LZMA and LZO?  What happened to that patch?
> 

Yes it is still there

https://patchwork.ozlabs.org/project/linuxppc-dev/patch/a74fce4dfc9fa32da6ce3470bbedcecf795de1ec.1591189069.git.christophe.leroy@csgroup.eu/

But as far as I remember it didn't pass CI build tests. Need to have a new look at it.


