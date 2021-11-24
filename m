Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC5345C543
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 14:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243666AbhKXNzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 08:55:50 -0500
Received: from pegase2.c-s.fr ([93.17.235.10]:50177 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352179AbhKXNwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 08:52:25 -0500
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4Hzj6H3Yd2z9sSc;
        Wed, 24 Nov 2021 14:49:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LeLWf_gu2Rtj; Wed, 24 Nov 2021 14:49:11 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4Hzj6F3xTPz9sSt;
        Wed, 24 Nov 2021 14:49:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 714138B774;
        Wed, 24 Nov 2021 14:49:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 2zx_RAzlbcMG; Wed, 24 Nov 2021 14:49:09 +0100 (CET)
Received: from [172.25.230.108] (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1D85B8B763;
        Wed, 24 Nov 2021 14:49:09 +0100 (CET)
Message-ID: <da5038fd-611a-a0b3-10b7-35dac6817e6a@csgroup.eu>
Date:   Wed, 24 Nov 2021 14:49:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 1/8] powerpc/mm: Make slice specific to book3s/64
Content-Language: fr-FR
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     kernel test robot <lkp@intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, alex@ghiti.fr
Cc:     linux-mm@kvack.org, kbuild-all@lists.01.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <14e2c0b0d4fff49c1cb30166f54ce8e445e17b16.1637570556.git.christophe.leroy@csgroup.eu>
 <202111222218.RhruLp7S-lkp@intel.com>
 <adefca8d-5fd4-b9ad-dfb8-0cf334440935@csgroup.eu>
In-Reply-To: <adefca8d-5fd4-b9ad-dfb8-0cf334440935@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 24/11/2021 à 13:10, Christophe Leroy a écrit :
> 
> 
> Le 22/11/2021 à 15:48, kernel test robot a écrit :
>> Hi Christophe,
>>
>> I love your patch! Perhaps something to improve:
>>
>> [auto build test WARNING on powerpc/next]
>> [also build test WARNING on hnaz-mm/master linus/master v5.16-rc2 
>> next-20211118]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch]
>>
>> url:    
>> https://github.com/0day-ci/linux/commits/Christophe-Leroy/Convert-powerpc-to-default-topdown-mmap-layout/20211122-165115 
>>
>> base:   
>> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
>> config: powerpc64-randconfig-s031-20211122 (attached as .config)
>> compiler: powerpc64-linux-gcc (GCC) 11.2.0
>> reproduce:
>>          wget 
>> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross 
>> -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # apt-get install sparse
>>          # sparse version: v0.6.4-dirty
>>          # 
>> https://github.com/0day-ci/linux/commit/1d0b7cc86d08f25f595b52d8c39ba9ca1d29a30a 
>>
>>          git remote add linux-review https://github.com/0day-ci/linux
>>          git fetch --no-tags linux-review 
>> Christophe-Leroy/Convert-powerpc-to-default-topdown-mmap-layout/20211122-165115 
>>
>>          git checkout 1d0b7cc86d08f25f595b52d8c39ba9ca1d29a30a
>>          # save the attached .config to linux build tree
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 
>> make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=powerpc64
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All warnings (new ones prefixed by >>):
>>
>>     arch/powerpc/mm/book3s64/slice.c: In function 
>> 'slice_get_unmapped_area':
>>>> arch/powerpc/mm/book3s64/slice.c:639:1: warning: the frame size of 
>>>> 1040 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>>       639 | }
>>           | ^
> 
> 
> The problem was already existing when slice.c was in arch/powerpc/mm/
> 
> This patch doesn't introduce the problem.
> 

In fact the problem is really added by yourself mister 'kernel test robot'.

CONFIG_FRAME_WARN is supposed to be 2048 on 64 bit architectures.

It the robot starts to reduce that value, it is on its own ....


config FRAME_WARN
	int "Warn for stack frames larger than"
	range 0 8192
	default 2048 if GCC_PLUGIN_LATENT_ENTROPY
	default 1536 if (!64BIT && (PARISC || XTENSA))
	default 1024 if (!64BIT && !PARISC)
	default 2048 if 64BIT
	help
	  Tell gcc to warn at build time for stack frames larger than this.
	  Setting this too low will cause a lot of warnings.
	  Setting it to 0 disables the warning.

