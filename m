Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD5B93FE9A8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 09:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242911AbhIBHE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 03:04:26 -0400
Received: from mga11.intel.com ([192.55.52.93]:9069 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242875AbhIBHEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 03:04:24 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10094"; a="215861972"
X-IronPort-AV: E=Sophos;i="5.84,371,1620716400"; 
   d="gz'50?scan'50,208,50";a="215861972"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2021 00:03:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,371,1620716400"; 
   d="gz'50?scan'50,208,50";a="461457309"
Received: from lkp-server01.sh.intel.com (HELO 4fbc2b3ce5aa) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 02 Sep 2021 00:03:24 -0700
Received: from kbuild by 4fbc2b3ce5aa with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mLgkt-0008hu-MQ; Thu, 02 Sep 2021 07:03:23 +0000
Date:   Thu, 2 Sep 2021 15:03:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [intel-tdx:guest 19/127] arch/x86/include/asm/kvm_para.h:39:10:
 error: implicit declaration of function 'tdx_kvm_hypercall'; did you mean
 'kvm_hypercall0'?
Message-ID: <202109021559.ZDqcMMHo-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://github.com/intel/tdx.git guest
head:   c748712bd17bbd7f8a75553911a5557f3d7d32b2
commit: b050815868ea9723b6b08badd2bbb887fdbc454c [19/127] x86/tdx: Wire up KVM hypercalls
config: i386-tinyconfig (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/b050815868ea9723b6b08badd2bbb887fdbc454c
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest
        git checkout b050815868ea9723b6b08badd2bbb887fdbc454c
        # save the attached .config to linux build tree
        make W=1 ARCH=i386 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/x86/mm/fault.c:33:
   arch/x86/include/asm/kvm_para.h: In function 'kvm_hypercall0':
>> arch/x86/include/asm/kvm_para.h:39:10: error: implicit declaration of function 'tdx_kvm_hypercall'; did you mean 'kvm_hypercall0'? [-Werror=implicit-function-declaration]
      39 |   return tdx_kvm_hypercall(nr, 0, 0, 0, 0);
         |          ^~~~~~~~~~~~~~~~~
         |          kvm_hypercall0
   cc1: some warnings being treated as errors


vim +39 arch/x86/include/asm/kvm_para.h

    20	
    21	#define KVM_HYPERCALL \
    22	        ALTERNATIVE("vmcall", "vmmcall", X86_FEATURE_VMMCALL)
    23	
    24	/* For KVM hypercalls, a three-byte sequence of either the vmcall or the vmmcall
    25	 * instruction.  The hypervisor may replace it with something else but only the
    26	 * instructions are guaranteed to be supported.
    27	 *
    28	 * Up to four arguments may be passed in rbx, rcx, rdx, and rsi respectively.
    29	 * The hypercall number should be placed in rax and the return value will be
    30	 * placed in rax.  No other registers will be clobbered unless explicitly
    31	 * noted by the particular hypercall.
    32	 */
    33	
    34	static inline long kvm_hypercall0(unsigned int nr)
    35	{
    36		long ret;
    37	
    38		if (prot_guest_has(PATTR_GUEST_TDX))
  > 39			return tdx_kvm_hypercall(nr, 0, 0, 0, 0);
    40	
    41		asm volatile(KVM_HYPERCALL
    42			     : "=a"(ret)
    43			     : "a"(nr)
    44			     : "memory");
    45		return ret;
    46	}
    47	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--opJtzjQTFsWo+cga
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--opJtzjQTFsWo+cga--
