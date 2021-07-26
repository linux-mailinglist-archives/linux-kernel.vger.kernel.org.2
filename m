Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2733D688B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 23:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbhGZUj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 16:39:57 -0400
Received: from mga01.intel.com ([192.55.52.88]:19593 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232788AbhGZUjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 16:39:53 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10057"; a="234180441"
X-IronPort-AV: E=Sophos;i="5.84,272,1620716400"; 
   d="scan'208";a="234180441"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2021 14:20:21 -0700
X-IronPort-AV: E=Sophos;i="5.84,272,1620716400"; 
   d="scan'208";a="464063759"
Received: from tchuang-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.3.19])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2021 14:20:20 -0700
Subject: Re: [intel-tdx:guest 37/107] lib/pci_iomap.c:30:9: error: implicit
 declaration of function 'ioremap_shared'; did you mean 'map_ioremap_shared'?
To:     kernel test robot <lkp@intel.com>, Andi Kleen <ak@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202107270426.vfFGcr89-lkp@intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <75d49ee6-5731-a877-a0d4-5148fc0c2418@linux.intel.com>
Date:   Mon, 26 Jul 2021 14:20:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <202107270426.vfFGcr89-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andi, Any comments on this issue? it looks like ioremap_shared is not redefined as ioremp
in some archs.

On 7/26/21 1:30 PM, kernel test robot wrote:
> tree:   https://github.com/intel/tdx.git guest
> head:   a81fb28d2e12ec7ee9667fbd8b08c7128d352f10
> commit: 9627c7de2c9fd39517b723ef9759e9579f25800c [37/107] pci: Add pci_iomap_shared{,_range}
> config: parisc-randconfig-r026-20210726 (attached as .config)
> compiler: hppa64-linux-gcc (GCC) 10.3.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://github.com/intel/tdx/commit/9627c7de2c9fd39517b723ef9759e9579f25800c
>          git remote add intel-tdx https://github.com/intel/tdx.git
>          git fetch --no-tags intel-tdx guest
>          git checkout 9627c7de2c9fd39517b723ef9759e9579f25800c
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-10.3.0 make.cross ARCH=parisc
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All error/warnings (new ones prefixed by >>):
> 
>     lib/pci_iomap.c: In function 'map_ioremap_shared':
>>> lib/pci_iomap.c:30:9: error: implicit declaration of function 'ioremap_shared'; did you mean 'map_ioremap_shared'? [-Werror=implicit-function-declaration]
>        30 |  return ioremap_shared(addr, size);
>           |         ^~~~~~~~~~~~~~
>           |         map_ioremap_shared
>>> lib/pci_iomap.c:30:9: warning: returning 'int' from a function with return type 'void *' makes pointer from integer without a cast [-Wint-conversion]
>        30 |  return ioremap_shared(addr, size);
>           |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
>     cc1: some warnings being treated as errors
> 
> 
> vim +30 lib/pci_iomap.c
> 
>      27	
>      28	static void __iomem *map_ioremap_shared(phys_addr_t addr, size_t size)
>      29	{
>    > 30		return ioremap_shared(addr, size);
>      31	}
>      32	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
