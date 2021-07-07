Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8AF3BF139
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 23:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbhGGVME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 17:12:04 -0400
Received: from mga03.intel.com ([134.134.136.65]:4170 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230185AbhGGVMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 17:12:02 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10037"; a="209428445"
X-IronPort-AV: E=Sophos;i="5.84,221,1620716400"; 
   d="gz'50?scan'50,208,50";a="209428445"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2021 14:09:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,221,1620716400"; 
   d="gz'50?scan'50,208,50";a="410676387"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 07 Jul 2021 14:09:19 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m1EnG-000Dnu-IM; Wed, 07 Jul 2021 21:09:18 +0000
Date:   Thu, 8 Jul 2021 05:09:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [hch-misc:m68k-set_fs 5/6] mm/maccess.c:31:9: sparse: sparse:
 incorrect type in initializer (different address spaces)
Message-ID: <202107080554.aesBSBYX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   git://git.infradead.org/users/hch/misc.git m68k-set_fs
head:   dc7590aca76df8c1ead0ebf59e3787d5555779d6
commit: bd01d8a7268b406331c39707183b2c42626eff8e [5/6] m68k: provide __{get,put}_kernel_nofault
config: m68k-randconfig-s031-20210707 (attached as .config)
compiler: m68k-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-341-g8af24329-dirty
        git remote add hch-misc git://git.infradead.org/users/hch/misc.git
        git fetch --no-tags hch-misc m68k-set_fs
        git checkout bd01d8a7268b406331c39707183b2c42626eff8e
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=m68k 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> mm/maccess.c:31:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __user *__gu_ptr @@     got unsigned long long [usertype] *__gk_src @@
   mm/maccess.c:31:9: sparse:     expected void const [noderef] __user *__gu_ptr
   mm/maccess.c:31:9: sparse:     got unsigned long long [usertype] *__gk_src
>> mm/maccess.c:32:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __user *__gu_ptr @@     got unsigned int [usertype] *__gk_src @@
   mm/maccess.c:32:9: sparse:     expected void const [noderef] __user *__gu_ptr
   mm/maccess.c:32:9: sparse:     got unsigned int [usertype] *__gk_src
>> mm/maccess.c:33:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __user *__gu_ptr @@     got unsigned short [usertype] *__gk_src @@
   mm/maccess.c:33:9: sparse:     expected void const [noderef] __user *__gu_ptr
   mm/maccess.c:33:9: sparse:     got unsigned short [usertype] *__gk_src
>> mm/maccess.c:34:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __user *__gu_ptr @@     got unsigned char [usertype] *__gk_src @@
   mm/maccess.c:34:9: sparse:     expected void const [noderef] __user *__gu_ptr
   mm/maccess.c:34:9: sparse:     got unsigned char [usertype] *__gk_src
>> mm/maccess.c:54:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __user *__pu_ptr @@     got unsigned long long [usertype] *__pk_dst @@
   mm/maccess.c:54:9: sparse:     expected void const [noderef] __user *__pu_ptr
   mm/maccess.c:54:9: sparse:     got unsigned long long [usertype] *__pk_dst
>> mm/maccess.c:55:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __user *__pu_ptr @@     got unsigned int [usertype] *__pk_dst @@
   mm/maccess.c:55:9: sparse:     expected void const [noderef] __user *__pu_ptr
   mm/maccess.c:55:9: sparse:     got unsigned int [usertype] *__pk_dst
>> mm/maccess.c:56:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __user *__pu_ptr @@     got unsigned short [usertype] *__pk_dst @@
   mm/maccess.c:56:9: sparse:     expected void const [noderef] __user *__pu_ptr
   mm/maccess.c:56:9: sparse:     got unsigned short [usertype] *__pk_dst
>> mm/maccess.c:57:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __user *__pu_ptr @@     got unsigned char [usertype] *__pk_dst @@
   mm/maccess.c:57:9: sparse:     expected void const [noderef] __user *__pu_ptr
   mm/maccess.c:57:9: sparse:     got unsigned char [usertype] *__pk_dst
   mm/maccess.c:76:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __user *__gu_ptr @@     got unsigned char [usertype] *__gk_src @@
   mm/maccess.c:76:17: sparse:     expected void const [noderef] __user *__gu_ptr
   mm/maccess.c:76:17: sparse:     got unsigned char [usertype] *__gk_src

vim +31 mm/maccess.c

b58294ead14cde Christoph Hellwig 2020-06-08  16  
fe557319aa06c2 Christoph Hellwig 2020-06-17  17  #define copy_from_kernel_nofault_loop(dst, src, len, type, err_label)	\
b58294ead14cde Christoph Hellwig 2020-06-08  18  	while (len >= sizeof(type)) {					\
b58294ead14cde Christoph Hellwig 2020-06-08  19  		__get_kernel_nofault(dst, src, type, err_label);		\
b58294ead14cde Christoph Hellwig 2020-06-08  20  		dst += sizeof(type);					\
b58294ead14cde Christoph Hellwig 2020-06-08  21  		src += sizeof(type);					\
b58294ead14cde Christoph Hellwig 2020-06-08  22  		len -= sizeof(type);					\
b58294ead14cde Christoph Hellwig 2020-06-08  23  	}
b58294ead14cde Christoph Hellwig 2020-06-08  24  
fe557319aa06c2 Christoph Hellwig 2020-06-17  25  long copy_from_kernel_nofault(void *dst, const void *src, size_t size)
b58294ead14cde Christoph Hellwig 2020-06-08  26  {
fe557319aa06c2 Christoph Hellwig 2020-06-17  27  	if (!copy_from_kernel_nofault_allowed(src, size))
2a71e81d321987 Christoph Hellwig 2020-06-08  28  		return -ERANGE;
b58294ead14cde Christoph Hellwig 2020-06-08  29  
b58294ead14cde Christoph Hellwig 2020-06-08  30  	pagefault_disable();
fe557319aa06c2 Christoph Hellwig 2020-06-17 @31  	copy_from_kernel_nofault_loop(dst, src, size, u64, Efault);
fe557319aa06c2 Christoph Hellwig 2020-06-17 @32  	copy_from_kernel_nofault_loop(dst, src, size, u32, Efault);
fe557319aa06c2 Christoph Hellwig 2020-06-17 @33  	copy_from_kernel_nofault_loop(dst, src, size, u16, Efault);
fe557319aa06c2 Christoph Hellwig 2020-06-17 @34  	copy_from_kernel_nofault_loop(dst, src, size, u8, Efault);
b58294ead14cde Christoph Hellwig 2020-06-08  35  	pagefault_enable();
b58294ead14cde Christoph Hellwig 2020-06-08  36  	return 0;
b58294ead14cde Christoph Hellwig 2020-06-08  37  Efault:
b58294ead14cde Christoph Hellwig 2020-06-08  38  	pagefault_enable();
b58294ead14cde Christoph Hellwig 2020-06-08  39  	return -EFAULT;
b58294ead14cde Christoph Hellwig 2020-06-08  40  }
fe557319aa06c2 Christoph Hellwig 2020-06-17  41  EXPORT_SYMBOL_GPL(copy_from_kernel_nofault);
b58294ead14cde Christoph Hellwig 2020-06-08  42  
fe557319aa06c2 Christoph Hellwig 2020-06-17  43  #define copy_to_kernel_nofault_loop(dst, src, len, type, err_label)	\
b58294ead14cde Christoph Hellwig 2020-06-08  44  	while (len >= sizeof(type)) {					\
b58294ead14cde Christoph Hellwig 2020-06-08  45  		__put_kernel_nofault(dst, src, type, err_label);		\
b58294ead14cde Christoph Hellwig 2020-06-08  46  		dst += sizeof(type);					\
b58294ead14cde Christoph Hellwig 2020-06-08  47  		src += sizeof(type);					\
b58294ead14cde Christoph Hellwig 2020-06-08  48  		len -= sizeof(type);					\
b58294ead14cde Christoph Hellwig 2020-06-08  49  	}
b58294ead14cde Christoph Hellwig 2020-06-08  50  
fe557319aa06c2 Christoph Hellwig 2020-06-17  51  long copy_to_kernel_nofault(void *dst, const void *src, size_t size)
b58294ead14cde Christoph Hellwig 2020-06-08  52  {
b58294ead14cde Christoph Hellwig 2020-06-08  53  	pagefault_disable();
fe557319aa06c2 Christoph Hellwig 2020-06-17 @54  	copy_to_kernel_nofault_loop(dst, src, size, u64, Efault);
fe557319aa06c2 Christoph Hellwig 2020-06-17 @55  	copy_to_kernel_nofault_loop(dst, src, size, u32, Efault);
fe557319aa06c2 Christoph Hellwig 2020-06-17 @56  	copy_to_kernel_nofault_loop(dst, src, size, u16, Efault);
fe557319aa06c2 Christoph Hellwig 2020-06-17 @57  	copy_to_kernel_nofault_loop(dst, src, size, u8, Efault);
b58294ead14cde Christoph Hellwig 2020-06-08  58  	pagefault_enable();
b58294ead14cde Christoph Hellwig 2020-06-08  59  	return 0;
b58294ead14cde Christoph Hellwig 2020-06-08  60  Efault:
b58294ead14cde Christoph Hellwig 2020-06-08  61  	pagefault_enable();
b58294ead14cde Christoph Hellwig 2020-06-08  62  	return -EFAULT;
b58294ead14cde Christoph Hellwig 2020-06-08  63  }
b58294ead14cde Christoph Hellwig 2020-06-08  64  

:::::: The code at line 31 was first introduced by commit
:::::: fe557319aa06c23cffc9346000f119547e0f289a maccess: rename probe_kernel_{read,write} to copy_{from,to}_kernel_nofault

:::::: TO: Christoph Hellwig <hch@lst.de>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--ibTvN161/egqYuK8
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
TLfM9fR/1U26AcRWAQA=

--ibTvN161/egqYuK8--
