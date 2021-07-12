Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69A8D3C41A4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 05:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbhGLDXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 23:23:23 -0400
Received: from foss.arm.com ([217.140.110.172]:44506 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230006AbhGLDXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 23:23:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 873986D;
        Sun, 11 Jul 2021 20:20:32 -0700 (PDT)
Received: from [10.163.65.188] (unknown [10.163.65.188])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 93B653F694;
        Sun, 11 Jul 2021 20:20:29 -0700 (PDT)
Subject: Re: [PATCH] mm/debug_vm_pgtable: Fix corrupted PG_arch_1 by
 set_pmd_at()
To:     kernel test robot <lkp@intel.com>, Gavin Shan <gshan@redhat.com>,
        linux-mm@kvack.org
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, shan.gavin@gmail.com
References: <20210702103225.51448-1-gshan@redhat.com>
 <202107080820.IwV1NKBI-lkp@intel.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <0a232c69-ae9f-8431-22c7-74513f87c018@arm.com>
Date:   Mon, 12 Jul 2021 08:51:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <202107080820.IwV1NKBI-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/8/21 6:05 AM, kernel test robot wrote:
> Hi Gavin,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on linus/master]
> [cannot apply to hnaz-linux-mm/master linux/master v5.13 next-20210707]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Gavin-Shan/mm-debug_vm_pgtable-Fix-corrupted-PG_arch_1-by-set_pmd_at/20210702-183310
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 3dbdb38e286903ec220aaf1fb29a8d94297da246
> config: x86_64-allyesconfig (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=1 build):
>         # https://github.com/0day-ci/linux/commit/414db1c0feb54b545b3df56bc19ffff27580deb5
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Gavin-Shan/mm-debug_vm_pgtable-Fix-corrupted-PG_arch_1-by-set_pmd_at/20210702-183310
>         git checkout 414db1c0feb54b545b3df56bc19ffff27580deb5
>         # save the attached .config to linux build tree
>         make W=1 ARCH=x86_64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from arch/x86/include/asm/page.h:76,
>                     from arch/x86/include/asm/thread_info.h:12,
>                     from include/linux/thread_info.h:59,
>                     from arch/x86/include/asm/preempt.h:7,
>                     from include/linux/preempt.h:78,
>                     from include/linux/spinlock.h:51,
>                     from include/linux/mmzone.h:8,
>                     from include/linux/gfp.h:6,
>                     from mm/debug_vm_pgtable.c:13:
>    mm/debug_vm_pgtable.c: In function 'pud_advanced_tests':
>>> include/asm-generic/memory_model.h:25:37: error: invalid operands to binary + (have 'struct page *' and 'struct page *')

Hello Gavin,

So this problem has been fixed in the other series (which now
includes this patch) you have posted ?

- Anshuman

>       25 | #define __pfn_to_page(pfn) (vmemmap + (pfn))
>          |                                     ^
>    include/asm-generic/memory_model.h:53:21: note: in expansion of macro '__pfn_to_page'
>       53 | #define pfn_to_page __pfn_to_page
>          |                     ^~~~~~~~~~~~~
>    mm/debug_vm_pgtable.c:347:22: note: in expansion of macro 'pfn_to_page'
>      347 |  struct page *page = pfn_to_page(page);
>          |                      ^~~~~~~~~~~
> 
> Kconfig warnings: (for reference only)
>    WARNING: unmet direct dependencies detected for PHY_SPARX5_SERDES
>    Depends on (ARCH_SPARX5 || COMPILE_TEST && OF && HAS_IOMEM
>    Selected by
>    - SPARX5_SWITCH && NETDEVICES && ETHERNET && NET_VENDOR_MICROCHIP && NET_SWITCHDEV && HAS_IOMEM
> 
> 
> vim +25 include/asm-generic/memory_model.h
> 
> 8f6aac419bd590 Christoph Lameter  2007-10-16  23  
> af901ca181d92a André Goddard Rosa 2009-11-14  24  /* memmap is virtually contiguous.  */
> 8f6aac419bd590 Christoph Lameter  2007-10-16 @25  #define __pfn_to_page(pfn)	(vmemmap + (pfn))
> 32272a26974d20 Martin Schwidefsky 2008-12-25  26  #define __page_to_pfn(page)	(unsigned long)((page) - vmemmap)
> 8f6aac419bd590 Christoph Lameter  2007-10-16  27  
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
