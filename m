Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A82A3A2E7E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 16:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbhFJOqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 10:46:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:60852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230153AbhFJOqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 10:46:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 97E4060E08;
        Thu, 10 Jun 2021 14:44:40 +0000 (UTC)
Subject: Re: arch/m68k/68000/dragen2.c:73:16: error: 'screen_bits' undeclared
To:     kernel test robot <lkp@intel.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202106082234.K2ejj9O2-lkp@intel.com>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <b7d33ae8-24f5-cf5f-ba80-348b6c2e6853@linux-m68k.org>
Date:   Fri, 11 Jun 2021 00:44:38 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <202106082234.K2ejj9O2-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/6/21 12:01 am, kernel test robot wrote:
> Hi Arnd,
> 
> FYI, the error/warning still remains.

My fault. I have pushed the fix to the m68knommu git tree, for-next branch now.
See:

     https://lore.kernel.org/linux-m68k/fd18edff-ddaf-e10c-5649-da0ade22dafa@linux-m68k.org/T/#t

Regards
Greg

     
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   614124bea77e452aa6df7a8714e8bc820b489922
> commit: a734bbf694270dca8594a5c33375867dc31503f5 m68k: m68328: move platform code to separate files
> date:   6 months ago
> config: m68k-randconfig-r021-20210608 (attached as .config)
> compiler: m68k-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a734bbf694270dca8594a5c33375867dc31503f5
>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>          git fetch --no-tags linus master
>          git checkout a734bbf694270dca8594a5c33375867dc31503f5
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=m68k
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>     arch/m68k/68000/dragen2.c:38:13: warning: no previous prototype for 'init_dragen2' [-Wmissing-prototypes]
>        38 | void __init init_dragen2(char *command, int size)
>           |             ^~~~~~~~~~~~
>     arch/m68k/68000/dragen2.c: In function 'init_dragen2':
>>> arch/m68k/68000/dragen2.c:73:16: error: 'screen_bits' undeclared (first use in this function)
>        73 |  LSSA = (long) screen_bits;
>           |                ^~~~~~~~~~~
>     arch/m68k/68000/dragen2.c:73:16: note: each undeclared identifier is reported only once for each function it appears in
> 
> 
> vim +/screen_bits +73 arch/m68k/68000/dragen2.c
> 
>      45	
>      46		/* CSGB Init */
>      47		CSGBB = 0x4000;
>      48		CSB = 0x1a1;
>      49	
>      50		/* CS8900 init */
>      51		/* PK3: hardware sleep function pin, active low */
>      52		PKSEL |= PK(3);				/* select pin as I/O */
>      53		PKDIR |= PK(3);				/* select pin as output */
>      54		PKDATA |= PK(3);			/* set pin high */
>      55	
>      56		/* PF5: hardware reset function pin, active high */
>      57		PFSEL |= PF(5);				/* select pin as I/O */
>      58		PFDIR |= PF(5);				/* select pin as output */
>      59		PFDATA &= ~PF(5);			/* set pin low */
>      60	
>      61		/* cs8900 hardware reset */
>      62		PFDATA |= PF(5);
>      63		{ int i; for (i = 0; i < 32000; ++i); }
>      64		PFDATA &= ~PF(5);
>      65	
>      66		/* INT1 enable (cs8900 IRQ) */
>      67		PDPOL &= ~PD(1);			/* active high signal */
>      68		PDIQEG &= ~PD(1);
>      69		PDIRQEN |= PD(1);			/* IRQ enabled */
>      70	
>      71	#ifdef CONFIG_INIT_LCD
>      72		/* initialize LCD controller */
>    > 73		LSSA = (long) screen_bits;
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
