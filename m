Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6682E358579
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 16:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbhDHOBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 10:01:30 -0400
Received: from mga09.intel.com ([134.134.136.24]:39081 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229803AbhDHOB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 10:01:28 -0400
IronPort-SDR: KvDnZCnrtaiJNh2lkt5zFAEKr7JXHY+LxyJ6lE/9u4N5AwG+OF4HSKI24OUW2z/o13OYuJCSsI
 KAkm/jb9HHkQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9948"; a="193660032"
X-IronPort-AV: E=Sophos;i="5.82,206,1613462400"; 
   d="gz'50?scan'50,208,50";a="193660032"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 07:01:16 -0700
IronPort-SDR: V8knEECiKaBxNR7FJ0C7oA1we34cwgnutJIBpyqpW996+R7KPjgoYn3Nu4uKmX7pPAn8zB9AKf
 dibFqrU/A0Kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,206,1613462400"; 
   d="gz'50?scan'50,208,50";a="441765282"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 08 Apr 2021 07:01:11 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lUVDa-000F5i-Ct; Thu, 08 Apr 2021 14:01:10 +0000
Date:   Thu, 8 Apr 2021 22:00:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gioh Kim <gi-oh.kim@ionos.com>, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, ndesaulniers@google.com,
        dan.j.williams@intel.com, laniel_francis@privacyrequired.com,
        keescook@chromium.org, dja@axtens.net, akpm@linux-foundation.org,
        haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: Re: [PATCH v3] lib/string: Introduce sysfs_streqcase
Message-ID: <202104082115.hUC8wcWs-lkp@intel.com>
References: <20210408093354.509810-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
In-Reply-To: <20210408093354.509810-1-gi-oh.kim@ionos.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Gioh,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linux/master]
[also build test ERROR on kees/for-next/pstore linus/master v5.12-rc6 next-20210408]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Gioh-Kim/lib-string-Introduce-sysfs_streqcase/20210408-173449
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 5e46d1b78a03d52306f21f77a4e4a144b6d31486
config: s390-randconfig-r036-20210408 (attached as .config)
compiler: s390-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/7de114025f207fa41a9cffdf91c28e9b914e09f4
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Gioh-Kim/lib-string-Introduce-sysfs_streqcase/20210408-173449
        git checkout 7de114025f207fa41a9cffdf91c28e9b914e09f4
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=s390 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   s390-linux-ld: drivers/dma/altera-msgdma.o: in function `request_and_map':
   altera-msgdma.c:(.text+0x408): undefined reference to `devm_ioremap'
   s390-linux-ld: drivers/dma/idma64.o: in function `idma64_platform_probe':
   idma64.c:(.text+0x1c0a): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/dma/sf-pdma/sf-pdma.o: in function `sf_pdma_probe':
   sf-pdma.c:(.text+0xc64): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/dma/qcom/hidma.o: in function `hidma_probe':
   hidma.c:(.text+0xd64): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: hidma.c:(.text+0xdc8): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/dma/xilinx/xilinx_dpdma.o: in function `xilinx_dpdma_probe':
   xilinx_dpdma.c:(.text+0x20be): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/base/core.o: in function `device_find_child_by_name':
   core.c:(.text+0xb38e): undefined reference to `sysfs_streq'
   s390-linux-ld: drivers/base/core.o: in function `device_match_name':
   core.c:(.text+0x11a22): undefined reference to `sysfs_streq'
   s390-linux-ld: drivers/base/memory.o: in function `auto_online_blocks_store':
>> memory.c:(.text+0x184): undefined reference to `sysfs_streq'
   s390-linux-ld: drivers/base/memory.o: in function `state_store':
   memory.c:(.text+0x368): undefined reference to `sysfs_streq'
   s390-linux-ld: drivers/base/memory.o: in function `mhp_online_type_from_str':
   memory.c:(.text+0xc20): undefined reference to `sysfs_streq'
   s390-linux-ld: lib/string.o:string.c:(.text+0xab6): more undefined references to `sysfs_streq' follow

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--bp/iNruPH9dso1Pn
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--bp/iNruPH9dso1Pn--
