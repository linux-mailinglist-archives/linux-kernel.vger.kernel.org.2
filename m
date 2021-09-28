Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11E6A41AE19
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 13:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240430AbhI1Luf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 07:50:35 -0400
Received: from mga14.intel.com ([192.55.52.115]:57309 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240425AbhI1Lue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 07:50:34 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10120"; a="224327925"
X-IronPort-AV: E=Sophos;i="5.85,329,1624345200"; 
   d="gz'50?scan'50,208,50";a="224327925"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2021 04:48:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,329,1624345200"; 
   d="gz'50?scan'50,208,50";a="538171150"
Received: from lkp-server02.sh.intel.com (HELO f7acefbbae94) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 28 Sep 2021 04:48:52 -0700
Received: from kbuild by f7acefbbae94 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mVBbQ-00016o-7B; Tue, 28 Sep 2021 11:48:52 +0000
Date:   Tue, 28 Sep 2021 19:48:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: [intel-tdx:guest 69/127] kernel/dma/direct.c:121:20: warning: shift
 count >= width of type
Message-ID: <202109281918.dCsekcIa-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://github.com/intel/tdx.git guest
head:   10b6ec254ee65ec602a7c3efde66ac0ca545b4bc
commit: b0040b6252b9f83c00f70d3b975238cb47381270 [69/127] x86/tdx: Add device filter support for x86 TDX guest platform
config: x86_64-randconfig-a002-20210928 (attached as .config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project dc6e8dfdfe7efecfda318d43a06fae18b40eb498)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel/tdx/commit/b0040b6252b9f83c00f70d3b975238cb47381270
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest
        git checkout b0040b6252b9f83c00f70d3b975238cb47381270
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=x86_64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from kernel/dma/direct.c:7:
   In file included from include/linux/memblock.h:14:
   In file included from arch/x86/include/asm/dma.h:13:
   In file included from arch/x86/include/asm/io.h:45:
   arch/x86/include/asm/tdx.h:175:12: error: incomplete definition of type 'struct device'
           return dev->authorized;
                  ~~~^
   include/linux/dynamic_debug.h:70:8: note: forward declaration of 'struct device'
   struct device;
          ^
>> kernel/dma/direct.c:121:20: warning: shift count >= width of type [-Wshift-count-overflow]
                       phys_limit < DMA_BIT_MASK(64) &&
                                    ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:76:54: note: expanded from macro 'DMA_BIT_MASK'
   #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
                                                        ^ ~~~
   1 warning and 1 error generated.
--
   In file included from security/security.c:22:
   In file included from include/linux/ima.h:13:
   In file included from include/linux/kexec.h:19:
   In file included from arch/x86/include/asm/io.h:45:
   arch/x86/include/asm/tdx.h:175:12: error: incomplete definition of type 'struct device'
           return dev->authorized;
                  ~~~^
   include/linux/dynamic_debug.h:70:8: note: forward declaration of 'struct device'
   struct device;
          ^
   In file included from security/security.c:25:
>> include/linux/mman.h:158:9: warning: division by zero is undefined [-Wdivision-by-zero]
                  _calc_vm_trans(flags, MAP_SYNC,       VM_SYNC      ) |
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/mman.h:136:21: note: expanded from macro '_calc_vm_trans'
      : ((x) & (bit1)) / ((bit1) / (bit2))))
                       ^ ~~~~~~~~~~~~~~~~~
   1 warning and 1 error generated.
--
   In file included from drivers/rapidio/devices/tsi721.c:10:
   In file included from include/linux/io.h:13:
   In file included from arch/x86/include/asm/io.h:45:
   arch/x86/include/asm/tdx.h:175:12: error: incomplete definition of type 'struct device'
           return dev->authorized;
                  ~~~^
   include/linux/dynamic_debug.h:70:8: note: forward declaration of 'struct device'
   struct device;
          ^
>> drivers/rapidio/devices/tsi721.c:2839:29: warning: shift count >= width of type [-Wshift-count-overflow]
           if (pci_set_dma_mask(pdev, DMA_BIT_MASK(64))) {
                                      ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:76:54: note: expanded from macro 'DMA_BIT_MASK'
   #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
                                                        ^ ~~~
   drivers/rapidio/devices/tsi721.c:2849:43: warning: shift count >= width of type [-Wshift-count-overflow]
                   err = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
                                                           ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:76:54: note: expanded from macro 'DMA_BIT_MASK'
   #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
                                                        ^ ~~~
   2 warnings and 1 error generated.
--
   In file included from drivers/gpu/drm/vgem/vgem_drv.c:33:
   In file included from include/linux/dma-buf.h:16:
   In file included from include/linux/dma-buf-map.h:9:
   In file included from include/linux/io.h:13:
   In file included from arch/x86/include/asm/io.h:45:
   arch/x86/include/asm/tdx.h:175:12: error: incomplete definition of type 'struct device'
           return dev->authorized;
                  ~~~^
   include/linux/dynamic_debug.h:70:8: note: forward declaration of 'struct device'
   struct device;
          ^
>> drivers/gpu/drm/vgem/vgem_drv.c:460:10: warning: shift count >= width of type [-Wshift-count-overflow]
                                        DMA_BIT_MASK(64));
                                        ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:76:54: note: expanded from macro 'DMA_BIT_MASK'
   #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
                                                        ^ ~~~
   1 warning and 1 error generated.


vim +121 kernel/dma/direct.c

f4111e39a52aa5 kernel/dma/direct.c Claire Chang           2021-06-19   86  
26749b3201ab05 kernel/dma/direct.c Christoph Hellwig      2020-06-15   87  static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
3773dfe6ea4d22 kernel/dma/direct.c Christoph Hellwig      2020-08-17   88  		gfp_t gfp)
a8463d4b0e47d1 lib/dma-noop.c      Christian Borntraeger  2016-02-02   89  {
90ae409f9eb3bc kernel/dma/direct.c Christoph Hellwig      2019-08-20   90  	int node = dev_to_node(dev);
080321d3b3139b lib/dma-direct.c    Christoph Hellwig      2017-12-22   91  	struct page *page = NULL;
a7ba70f1787f97 kernel/dma/direct.c Nicolas Saenz Julienne 2019-11-21   92  	u64 phys_limit;
a8463d4b0e47d1 lib/dma-noop.c      Christian Borntraeger  2016-02-02   93  
633d5fce78a61e kernel/dma/direct.c David Rientjes         2020-06-11   94  	WARN_ON_ONCE(!PAGE_ALIGNED(size));
633d5fce78a61e kernel/dma/direct.c David Rientjes         2020-06-11   95  
c84dc6e68a1d24 kernel/dma/direct.c David Rientjes         2020-04-14   96  	gfp |= dma_direct_optimal_gfp_mask(dev, dev->coherent_dma_mask,
a7ba70f1787f97 kernel/dma/direct.c Nicolas Saenz Julienne 2019-11-21   97  					   &phys_limit);
f4111e39a52aa5 kernel/dma/direct.c Claire Chang           2021-06-19   98  	if (IS_ENABLED(CONFIG_DMA_RESTRICTED_POOL) &&
f4111e39a52aa5 kernel/dma/direct.c Claire Chang           2021-06-19   99  	    is_swiotlb_for_alloc(dev)) {
f4111e39a52aa5 kernel/dma/direct.c Claire Chang           2021-06-19  100  		page = swiotlb_alloc(dev, size);
f4111e39a52aa5 kernel/dma/direct.c Claire Chang           2021-06-19  101  		if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
f4111e39a52aa5 kernel/dma/direct.c Claire Chang           2021-06-19  102  			__dma_direct_free_pages(dev, page, size);
f4111e39a52aa5 kernel/dma/direct.c Claire Chang           2021-06-19  103  			return NULL;
f4111e39a52aa5 kernel/dma/direct.c Claire Chang           2021-06-19  104  		}
f4111e39a52aa5 kernel/dma/direct.c Claire Chang           2021-06-19  105  		return page;
f4111e39a52aa5 kernel/dma/direct.c Claire Chang           2021-06-19  106  	}
f4111e39a52aa5 kernel/dma/direct.c Claire Chang           2021-06-19  107  
633d5fce78a61e kernel/dma/direct.c David Rientjes         2020-06-11  108  	page = dma_alloc_contiguous(dev, size, gfp);
90ae409f9eb3bc kernel/dma/direct.c Christoph Hellwig      2019-08-20  109  	if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
633d5fce78a61e kernel/dma/direct.c David Rientjes         2020-06-11  110  		dma_free_contiguous(dev, page, size);
90ae409f9eb3bc kernel/dma/direct.c Christoph Hellwig      2019-08-20  111  		page = NULL;
90ae409f9eb3bc kernel/dma/direct.c Christoph Hellwig      2019-08-20  112  	}
95f183916d4b0b lib/dma-direct.c    Christoph Hellwig      2018-01-09  113  again:
90ae409f9eb3bc kernel/dma/direct.c Christoph Hellwig      2019-08-20  114  	if (!page)
633d5fce78a61e kernel/dma/direct.c David Rientjes         2020-06-11  115  		page = alloc_pages_node(node, gfp, get_order(size));
95f183916d4b0b lib/dma-direct.c    Christoph Hellwig      2018-01-09  116  	if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
b1d2dc009dece4 kernel/dma/direct.c Nicolin Chen           2019-05-23  117  		dma_free_contiguous(dev, page, size);
95f183916d4b0b lib/dma-direct.c    Christoph Hellwig      2018-01-09  118  		page = NULL;
95f183916d4b0b lib/dma-direct.c    Christoph Hellwig      2018-01-09  119  
de7eab301de788 lib/dma-direct.c    Takashi Iwai           2018-04-16  120  		if (IS_ENABLED(CONFIG_ZONE_DMA32) &&
a7ba70f1787f97 kernel/dma/direct.c Nicolas Saenz Julienne 2019-11-21 @121  		    phys_limit < DMA_BIT_MASK(64) &&
de7eab301de788 lib/dma-direct.c    Takashi Iwai           2018-04-16  122  		    !(gfp & (GFP_DMA32 | GFP_DMA))) {
de7eab301de788 lib/dma-direct.c    Takashi Iwai           2018-04-16  123  			gfp |= GFP_DMA32;
de7eab301de788 lib/dma-direct.c    Takashi Iwai           2018-04-16  124  			goto again;
de7eab301de788 lib/dma-direct.c    Takashi Iwai           2018-04-16  125  		}
de7eab301de788 lib/dma-direct.c    Takashi Iwai           2018-04-16  126  
fbce251baa6e35 kernel/dma/direct.c Christoph Hellwig      2019-02-13  127  		if (IS_ENABLED(CONFIG_ZONE_DMA) && !(gfp & GFP_DMA)) {
95f183916d4b0b lib/dma-direct.c    Christoph Hellwig      2018-01-09  128  			gfp = (gfp & ~GFP_DMA32) | GFP_DMA;
95f183916d4b0b lib/dma-direct.c    Christoph Hellwig      2018-01-09  129  			goto again;
95f183916d4b0b lib/dma-direct.c    Christoph Hellwig      2018-01-09  130  		}
95f183916d4b0b lib/dma-direct.c    Christoph Hellwig      2018-01-09  131  	}
95f183916d4b0b lib/dma-direct.c    Christoph Hellwig      2018-01-09  132  
b18814e767a445 kernel/dma/direct.c Christoph Hellwig      2018-11-04  133  	return page;
b18814e767a445 kernel/dma/direct.c Christoph Hellwig      2018-11-04  134  }
b18814e767a445 kernel/dma/direct.c Christoph Hellwig      2018-11-04  135  

:::::: The code at line 121 was first introduced by commit
:::::: a7ba70f1787f977f970cd116076c6fce4b9e01cc dma-mapping: treat dev->bus_dma_mask as a DMA limit

:::::: TO: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
:::::: CC: Christoph Hellwig <hch@lst.de>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--PNTmBPCT7hxwcZjr
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--PNTmBPCT7hxwcZjr--
