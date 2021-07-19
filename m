Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 224A73CD3EA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 13:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236693AbhGSKtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 06:49:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60583 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236531AbhGSKtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 06:49:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626694201;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ESnH2S6yBdJz7yr94lSisLVqQUkwCAoXoLcXG4GRyLI=;
        b=VnA5wtoeaEfCl8yAoFNdPi75f21E2u0bhsrUZW1UjkwrqS2dSyN0b8wavdT4z4FcgB9y6F
        Lrd3KgDhn2a0IObZgj1Q8Zu4+4Mn+WOVY0Gu29bBhoEF2166XCuWPCxm45dBa7UwaTrd7o
        /TAOS3uIjycSyeer40w69E3jp8u1vgQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-QLcfgylOPmWWZVhyrvl0fA-1; Mon, 19 Jul 2021 07:30:00 -0400
X-MC-Unique: QLcfgylOPmWWZVhyrvl0fA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 78E5D100C660;
        Mon, 19 Jul 2021 11:29:58 +0000 (UTC)
Received: from [10.64.54.195] (vpn2-54-195.bne.redhat.com [10.64.54.195])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B86E620DE;
        Mon, 19 Jul 2021 11:29:54 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v2 09/12] mm/vm_debug_pgtable: Use struct
 pgtable_debug_args in PUD modifying tests
To:     kernel test robot <lkp@intel.com>, linux-mm@kvack.org
Cc:     clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, chuhu@redhat.com, shan.gavin@gmail.com
References: <20210719054138.198373-10-gshan@redhat.com>
 <202107191750.5uS1cDBz-lkp@intel.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <e3f41155-817e-01f5-91d2-596a89d2004c@redhat.com>
Date:   Mon, 19 Jul 2021 21:30:10 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <202107191750.5uS1cDBz-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/21 7:13 PM, kernel test robot wrote:
> Hi Gavin,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on linus/master]
> [also build test WARNING on v5.14-rc2]
> [cannot apply to hnaz-linux-mm/master linux/master next-20210716]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Gavin-Shan/mm-debug_vm_pgtable-Enhancements/20210719-134236
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 2734d6c1b1a089fb593ef6a23d4b70903526fe0c
> config: arm64-randconfig-r005-20210719 (attached as .config)
> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project 5d5b08761f944d5b9822d582378333cc4b36a0a7)
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # install arm64 cross compiling tool for clang build
>          # apt-get install binutils-aarch64-linux-gnu
>          # https://github.com/0day-ci/linux/commit/69db26024e6bd48423ebc83b0f83b7b52217b624
>          git remote add linux-review https://github.com/0day-ci/linux
>          git fetch --no-tags linux-review Gavin-Shan/mm-debug_vm_pgtable-Enhancements/20210719-134236
>          git checkout 69db26024e6bd48423ebc83b0f83b7b52217b624
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm64
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 

Thanks for reporting the build warnings. I will fix it in v3.

> All warnings (new ones prefixed by >>):
> 
>>> mm/debug_vm_pgtable.c:445:8: warning: variable 'pud' set but not used [-Wunused-but-set-variable]
>             pud_t pud;
>  

A "WARN_ON(!pud_none(pud)) is missed from PATCH[9/12].

                  ^
>     mm/debug_vm_pgtable.c:1140:17: warning: variable 'protnone' set but not used [-Wunused-but-set-variable]
>             pgprot_t prot, protnone;
>                            ^
>     mm/debug_vm_pgtable.c:1142:36: warning: variable 'pmd_aligned' set but not used [-Wunused-but-set-variable]
>             unsigned long vaddr, pte_aligned, pmd_aligned;
>                                               ^
>     mm/debug_vm_pgtable.c:1143:42: warning: variable 'pgd_aligned' set but not used [-Wunused-but-set-variable]
>             unsigned long pud_aligned, p4d_aligned, pgd_aligned;
>                                                     ^
>     mm/debug_vm_pgtable.c:1143:29: warning: variable 'p4d_aligned' set but not used [-Wunused-but-set-variable]
>             unsigned long pud_aligned, p4d_aligned, pgd_aligned;
>                                        ^
>     mm/debug_vm_pgtable.c:1143:16: warning: variable 'pud_aligned' set but not used [-Wunused-but-set-variable]
>             unsigned long pud_aligned, p4d_aligned, pgd_aligned;
>                           ^
>     mm/debug_vm_pgtable.c:1140:11: warning: variable 'prot' set but not used [-Wunused-but-set-variable]
>             pgprot_t prot, protnone;
>                      ^
>     7 warnings generated.
> 

There are more build warnings introduced by other patches. I need to drop the unused
variables in debug_vm_pgtable(). So I need to drop the unused variables in separate
patches in v3, instead of dropping all of them in PATCH[v2 11/12].

Thanks,
Gavin

> 
> vim +/pud +445 mm/debug_vm_pgtable.c
> 
> 5fe77be6bf14bf Shixin Liu        2021-06-30  442
> 69db26024e6bd4 Gavin Shan        2021-07-19  443  static void __init pud_huge_tests(struct pgtable_debug_args *args)
> a5c3b9ffb0f404 Anshuman Khandual 2020-08-06  444  {
> 5fe77be6bf14bf Shixin Liu        2021-06-30 @445  	pud_t pud;
> 5fe77be6bf14bf Shixin Liu        2021-06-30  446
> 69db26024e6bd4 Gavin Shan        2021-07-19  447  	if (!arch_vmap_pud_supported(args->page_prot))
> 5fe77be6bf14bf Shixin Liu        2021-06-30  448  		return;
> 5fe77be6bf14bf Shixin Liu        2021-06-30  449
> 5fe77be6bf14bf Shixin Liu        2021-06-30  450  	pr_debug("Validating PUD huge\n");
> 5fe77be6bf14bf Shixin Liu        2021-06-30  451  	/*
> 5fe77be6bf14bf Shixin Liu        2021-06-30  452  	 * X86 defined pud_set_huge() verifies that the given
> 5fe77be6bf14bf Shixin Liu        2021-06-30  453  	 * PUD is not a populated non-leaf entry.
> 5fe77be6bf14bf Shixin Liu        2021-06-30  454  	 */
> 69db26024e6bd4 Gavin Shan        2021-07-19  455  	WRITE_ONCE(*(args->pudp), __pud(0));
> 69db26024e6bd4 Gavin Shan        2021-07-19  456  	WARN_ON(!pud_set_huge(args->pudp, __pfn_to_phys(args->fixed_pud_pfn),
> 69db26024e6bd4 Gavin Shan        2021-07-19  457  			      args->page_prot));
> 69db26024e6bd4 Gavin Shan        2021-07-19  458  	WARN_ON(!pud_clear_huge(args->pudp));
> 69db26024e6bd4 Gavin Shan        2021-07-19  459  	pud = READ_ONCE(*(args->pudp));
> a5c3b9ffb0f404 Anshuman Khandual 2020-08-06  460  }
> 5fe77be6bf14bf Shixin Liu        2021-06-30  461  #else /* !CONFIG_HAVE_ARCH_HUGE_VMAP */
> 54b1f4b50ddb0f Gavin Shan        2021-07-19  462  static void __init pmd_huge_tests(struct pgtable_debug_args *args) { }
> 69db26024e6bd4 Gavin Shan        2021-07-19  463  static void __init pud_huge_tests(struct pgtable_debug_args *args) { }
> 5fe77be6bf14bf Shixin Liu        2021-06-30  464  #endif /* CONFIG_HAVE_ARCH_HUGE_VMAP */
> 399145f9eb6c67 Anshuman Khandual 2020-06-04  465
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 

