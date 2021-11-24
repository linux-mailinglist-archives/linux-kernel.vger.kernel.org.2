Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8537145BB06
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 13:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243018AbhKXMPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 07:15:45 -0500
Received: from pegase2.c-s.fr ([93.17.235.10]:55519 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243230AbhKXMNi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 07:13:38 -0500
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HzfwK47XZz9sSc;
        Wed, 24 Nov 2021 13:10:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id sWkc7PQHeBeD; Wed, 24 Nov 2021 13:10:25 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HzfwK357Rz9sSD;
        Wed, 24 Nov 2021 13:10:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 56AC48B774;
        Wed, 24 Nov 2021 13:10:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id HKLJqKu2q3SB; Wed, 24 Nov 2021 13:10:25 +0100 (CET)
Received: from [172.25.230.108] (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1DBA78B763;
        Wed, 24 Nov 2021 13:10:25 +0100 (CET)
Message-ID: <adefca8d-5fd4-b9ad-dfb8-0cf334440935@csgroup.eu>
Date:   Wed, 24 Nov 2021 13:10:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 1/8] powerpc/mm: Make slice specific to book3s/64
Content-Language: fr-FR
To:     kernel test robot <lkp@intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, alex@ghiti.fr
Cc:     kbuild-all@lists.01.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <14e2c0b0d4fff49c1cb30166f54ce8e445e17b16.1637570556.git.christophe.leroy@csgroup.eu>
 <202111222218.RhruLp7S-lkp@intel.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <202111222218.RhruLp7S-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 22/11/2021 à 15:48, kernel test robot a écrit :
> Hi Christophe,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on powerpc/next]
> [also build test WARNING on hnaz-mm/master linus/master v5.16-rc2 next-20211118]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Christophe-Leroy/Convert-powerpc-to-default-topdown-mmap-layout/20211122-165115
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
> config: powerpc64-randconfig-s031-20211122 (attached as .config)
> compiler: powerpc64-linux-gcc (GCC) 11.2.0
> reproduce:
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # apt-get install sparse
>          # sparse version: v0.6.4-dirty
>          # https://github.com/0day-ci/linux/commit/1d0b7cc86d08f25f595b52d8c39ba9ca1d29a30a
>          git remote add linux-review https://github.com/0day-ci/linux
>          git fetch --no-tags linux-review Christophe-Leroy/Convert-powerpc-to-default-topdown-mmap-layout/20211122-165115
>          git checkout 1d0b7cc86d08f25f595b52d8c39ba9ca1d29a30a
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=powerpc64
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>     arch/powerpc/mm/book3s64/slice.c: In function 'slice_get_unmapped_area':
>>> arch/powerpc/mm/book3s64/slice.c:639:1: warning: the frame size of 1040 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>       639 | }
>           | ^


The problem was already existing when slice.c was in arch/powerpc/mm/

This patch doesn't introduce the problem.

Christophe
