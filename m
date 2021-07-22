Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 026B43D2B28
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 19:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbhGVQu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 12:50:27 -0400
Received: from foss.arm.com ([217.140.110.172]:57558 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229456AbhGVQu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 12:50:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B231106F;
        Thu, 22 Jul 2021 10:31:01 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C18053F694;
        Thu, 22 Jul 2021 10:30:59 -0700 (PDT)
Subject: Re: [PATCH 17/23] iommu/vt-d: Prepare for multiple DMA domain types
To:     kernel test robot <lkp@intel.com>, joro@8bytes.org, will@kernel.org
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org
References: <11efdfa4ee223d12769d17459fcf789c626d7b82.1626888445.git.robin.murphy@arm.com>
 <202107230049.1VfUKZOX-lkp@intel.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <df1377fc-ac09-6f76-f224-1d58e94473c5@arm.com>
Date:   Thu, 22 Jul 2021 18:30:54 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <202107230049.1VfUKZOX-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-07-22 17:44, kernel test robot wrote:
> Hi Robin,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on iommu/next]
> [also build test ERROR on rockchip/for-next linus/master v5.14-rc2 next-20210722]
> [cannot apply to sunxi/sunxi/for-next]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Robin-Murphy/iommu-Refactor-DMA-domain-strictness/20210722-022514
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git next
> config: ia64-allmodconfig (attached as .config)
> compiler: ia64-linux-gcc (GCC) 10.3.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://github.com/0day-ci/linux/commit/c05e0e1856b394eff1167c00f7bbd6ac7cc9dea6
>          git remote add linux-review https://github.com/0day-ci/linux
>          git fetch --no-tags linux-review Robin-Murphy/iommu-Refactor-DMA-domain-strictness/20210722-022514
>          git checkout c05e0e1856b394eff1167c00f7bbd6ac7cc9dea6
>          # save the attached .config to linux build tree
>          mkdir build_dir
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-10.3.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>     In file included from arch/ia64/include/asm/bug.h:17,
>                      from include/linux/bug.h:5,
>                      from include/linux/thread_info.h:13,
>                      from include/asm-generic/preempt.h:5,
>                      from ./arch/ia64/include/generated/asm/preempt.h:1,
>                      from include/linux/preempt.h:78,
>                      from include/linux/spinlock.h:51,
>                      from include/linux/wait.h:9,
>                      from include/linux/wait_bit.h:8,
>                      from include/linux/fs.h:6,
>                      from include/linux/debugfs.h:15,
>                      from drivers/iommu/intel/iommu.c:18:
>     drivers/iommu/intel/iommu.c: In function 'domain_get_iommu':
>>> drivers/iommu/intel/iommu.c:604:38: error: '__IOMMU_DOMAIN_DMA' undeclared (first use in this function); did you mean 'IOMMU_DOMAIN_DMA'?
>       604 |  if (WARN_ON(!(domain->domain.type & __IOMMU_DOMAIN_DMA)))
>           |                                      ^~~~~~~~~~~~~~~~~~
>     include/asm-generic/bug.h:121:25: note: in definition of macro 'WARN_ON'
>       121 |  int __ret_warn_on = !!(condition);    \
>           |                         ^~~~~~~~~
>     drivers/iommu/intel/iommu.c:604:38: note: each undeclared identifier is reported only once for each function it appears in
>       604 |  if (WARN_ON(!(domain->domain.type & __IOMMU_DOMAIN_DMA)))
>           |                                      ^~~~~~~~~~~~~~~~~~
>     include/asm-generic/bug.h:121:25: note: in definition of macro 'WARN_ON'
>       121 |  int __ret_warn_on = !!(condition);    \
>           |                         ^~~~~~~~~
> 
> 
> vim +604 drivers/iommu/intel/iommu.c
> 
>     597	
>     598	/* This functionin only returns single iommu in a domain */
>     599	struct intel_iommu *domain_get_iommu(struct dmar_domain *domain)
>     600	{
>     601		int iommu_id;
>     602	
>     603		/* si_domain and vm domain should not get here. */
>   > 604		if (WARN_ON(!(domain->domain.type & __IOMMU_DOMAIN_DMA)))

Bleh, of course that should be __IOMMU_DOMAIN_DMA_API like the other two 
instances. I'll fix this locally ready for v2.

Thanks,
Robin.

>     605			return NULL;
>     606	
>     607		for_each_domain_iommu(iommu_id, domain)
>     608			break;
>     609	
>     610		if (iommu_id < 0 || iommu_id >= g_num_of_iommus)
>     611			return NULL;
>     612	
>     613		return g_iommus[iommu_id];
>     614	}
>     615	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
