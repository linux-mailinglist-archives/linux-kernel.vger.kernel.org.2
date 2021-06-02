Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E67D397E4F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 03:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbhFBCAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 22:00:33 -0400
Received: from mga03.intel.com ([134.134.136.65]:9514 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229635AbhFBCAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 22:00:31 -0400
IronPort-SDR: Qgm1L+Mm0ccufXw6ilOniD3W2798pSlVRnNQF8gTNBNxEfpBX+vIX90LUM7f9T5WkPBPIaGTLu
 n18m+3DXC2pw==
X-IronPort-AV: E=McAfee;i="6200,9189,10002"; a="203713955"
X-IronPort-AV: E=Sophos;i="5.83,241,1616482800"; 
   d="gz'50?scan'50,208,50";a="203713955"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2021 18:58:45 -0700
IronPort-SDR: MlTVep2AbmLw8pkpwy307bUEuj0VVlu6tKF3iKLzbHOoIfYcqBJl1KkgDpxQnXlSlQREAlSVz3
 fLK55Vf7eJOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,241,1616482800"; 
   d="gz'50?scan'50,208,50";a="549252620"
Received: from lkp-server02.sh.intel.com (HELO 1ec8406c5392) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 01 Jun 2021 18:58:41 -0700
Received: from kbuild by 1ec8406c5392 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1loG9Z-0005SW-2o; Wed, 02 Jun 2021 01:58:41 +0000
Date:   Wed, 2 Jun 2021 09:58:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ming Lin-SSI <mlin@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Simon Ser <contact@emersion.fr>
Cc:     kbuild-all@lists.01.org, LKML <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, Ming Lin-SSI <mlin@kernel.org>
Subject: Re: [PATCH 1/2] mm: make "vm_flags" be an u64
Message-ID: <202106020917.iy6LHxmg-lkp@intel.com>
References: <1622589753-9206-2-git-send-email-mlin@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
In-Reply-To: <1622589753-9206-2-git-send-email-mlin@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ming,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linux/master]
[also build test WARNING on arm64/for-next/core powerpc/next asm-generic/master linus/master v5.13-rc4]
[cannot apply to hnaz-linux-mm/master tip/x86/core next-20210601]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Ming-Lin/mm-adds-MAP_NOSIGBUS-extension-for-shmem-read/20210602-072403
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git dd860052c99b1e088352bdd4fb7aef46f8d2ef47
config: x86_64-allyesconfig (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/0b6b8b44f566199698248899d0fef7466ba6b0f3
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Ming-Lin/mm-adds-MAP_NOSIGBUS-extension-for-shmem-read/20210602-072403
        git checkout 0b6b8b44f566199698248899d0fef7466ba6b0f3
        # save the attached .config to linux build tree
        make W=1 ARCH=x86_64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/infiniband/hw/hfi1/trace.h:57,
                    from drivers/infiniband/hw/hfi1/file_ops.c:61:
   drivers/infiniband/hw/hfi1/file_ops.c: In function 'hfi1_file_mmap':
>> drivers/infiniband/hw/hfi1/file_ops.c:572:5: warning: format '%lx' expects argument of type 'long unsigned int', but argument 11 has type 'vm_flags_t' {aka 'long long unsigned int'} [-Wformat=]
     572 |     "%u:%u type:%u io/vf:%d/%d, addr:0x%llx, len:%lu(%lu), flags:0x%lx\n",
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     573 |       ctxt, subctxt, type, mapio, vmf, memaddr, memlen,
     574 |       vma->vm_end - vma->vm_start, vma->vm_flags);
         |                                    ~~~~~~~~~~~~~
         |                                       |
         |                                       vm_flags_t {aka long long unsigned int}
   drivers/infiniband/hw/hfi1/trace_dbg.h:133:33: note: in definition of macro 'hfi1_cdbg'
     133 |  __hfi1_trace_##which(__func__, fmt, ##__VA_ARGS__)
         |                                 ^~~
   drivers/infiniband/hw/hfi1/file_ops.c:572:70: note: format string is defined here
     572 |     "%u:%u type:%u io/vf:%d/%d, addr:0x%llx, len:%lu(%lu), flags:0x%lx\n",
         |                                                                    ~~^
         |                                                                      |
         |                                                                      long unsigned int
         |                                                                    %llx
--
   In file included from include/linux/device.h:15,
                    from include/linux/pci.h:37,
                    from drivers/infiniband/hw/qib/qib_file_ops.c:35:
   drivers/infiniband/hw/qib/qib_file_ops.c: In function 'mmap_rcvegrbufs':
>> drivers/infiniband/hw/qib/qib_file_ops.c:849:4: warning: format '%lx' expects argument of type 'long unsigned int', but argument 3 has type 'vm_flags_t' {aka 'long long unsigned int'} [-Wformat=]
     849 |    "Can't map eager buffers as writable (flags=%lx)\n",
         |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:19:22: note: in definition of macro 'dev_fmt'
      19 | #define dev_fmt(fmt) fmt
         |                      ^~~
   drivers/infiniband/hw/qib/qib.h:1472:2: note: in expansion of macro 'dev_info'
    1472 |  dev_info(&(pcidev)->dev, fmt, ##__VA_ARGS__)
         |  ^~~~~~~~
   drivers/infiniband/hw/qib/qib_file_ops.c:848:3: note: in expansion of macro 'qib_devinfo'
     848 |   qib_devinfo(dd->pcidev,
         |   ^~~~~~~~~~~
   drivers/infiniband/hw/qib/qib_file_ops.c:849:50: note: format string is defined here
     849 |    "Can't map eager buffers as writable (flags=%lx)\n",
         |                                                ~~^
         |                                                  |
         |                                                  long unsigned int
         |                                                %llx
   In file included from include/linux/device.h:15,
                    from include/linux/pci.h:37,
                    from drivers/infiniband/hw/qib/qib_file_ops.c:35:
   drivers/infiniband/hw/qib/qib_file_ops.c: In function 'mmap_kvaddr':
   drivers/infiniband/hw/qib/qib_file_ops.c:938:6: warning: format '%lx' expects argument of type 'long unsigned int', but argument 3 has type 'vm_flags_t' {aka 'long long unsigned int'} [-Wformat=]
     938 |      "Can't map eager buffers as writable (flags=%lx)\n",
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:19:22: note: in definition of macro 'dev_fmt'
      19 | #define dev_fmt(fmt) fmt
         |                      ^~~
   drivers/infiniband/hw/qib/qib.h:1472:2: note: in expansion of macro 'dev_info'
    1472 |  dev_info(&(pcidev)->dev, fmt, ##__VA_ARGS__)
         |  ^~~~~~~~
   drivers/infiniband/hw/qib/qib_file_ops.c:937:4: note: in expansion of macro 'qib_devinfo'
     937 |    qib_devinfo(dd->pcidev,
         |    ^~~~~~~~~~~
   drivers/infiniband/hw/qib/qib_file_ops.c:938:52: note: format string is defined here
     938 |      "Can't map eager buffers as writable (flags=%lx)\n",
         |                                                  ~~^
         |                                                    |
         |                                                    long unsigned int
         |                                                  %llx
--
   In file included from drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_priv.h:48,
                    from drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_chardev.c:38:
   drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_chardev.c: In function 'kfd_mmio_mmap':
>> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h:35:21: warning: format '%lX' expects argument of type 'long unsigned int', but argument 6 has type 'vm_flags_t' {aka 'long long unsigned int'} [-Wformat=]
      35 | #define pr_fmt(fmt) "amdgpu: " fmt
         |                     ^~~~~~~~~~
   include/linux/dynamic_debug.h:129:15: note: in expansion of macro 'pr_fmt'
     129 |   func(&id, ##__VA_ARGS__);  \
         |               ^~~~~~~~~~~
   include/linux/dynamic_debug.h:147:2: note: in expansion of macro '__dynamic_func_call'
     147 |  __dynamic_func_call(__UNIQUE_ID(ddebug), fmt, func, ##__VA_ARGS__)
         |  ^~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:157:2: note: in expansion of macro '_dynamic_func_call'
     157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
         |  ^~~~~~~~~~~~~~~~~~
   include/linux/printk.h:424:2: note: in expansion of macro 'dynamic_pr_debug'
     424 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
         |  ^~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_chardev.c:1957:2: note: in expansion of macro 'pr_debug'
    1957 |  pr_debug("pasid 0x%x mapping mmio page\n"
         |  ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_chardev.c:1960:39: note: format string is defined here
    1960 |    "     vm_flags            == 0x%04lX\n"
         |                                   ~~~~^
         |                                       |
         |                                       long unsigned int
         |                                   %04llX


vim +572 drivers/infiniband/hw/hfi1/file_ops.c

7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  347  
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  348  static int hfi1_file_mmap(struct file *fp, struct vm_area_struct *vma)
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  349  {
9e10af4787ac51 drivers/staging/rdma/hfi1/file_ops.c  Ira Weiny          2015-10-30  350  	struct hfi1_filedata *fd = fp->private_data;
9e10af4787ac51 drivers/staging/rdma/hfi1/file_ops.c  Ira Weiny          2015-10-30  351  	struct hfi1_ctxtdata *uctxt = fd->uctxt;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  352  	struct hfi1_devdata *dd;
60368186fd8538 drivers/infiniband/hw/hfi1/file_ops.c Tymoteusz Kielan   2016-09-06  353  	unsigned long flags;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  354  	u64 token = vma->vm_pgoff << PAGE_SHIFT,
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  355  		memaddr = 0;
60368186fd8538 drivers/infiniband/hw/hfi1/file_ops.c Tymoteusz Kielan   2016-09-06  356  	void *memvirt = NULL;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  357  	u8 subctxt, mapio = 0, vmf = 0, type;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  358  	ssize_t memlen = 0;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  359  	int ret = 0;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  360  	u16 ctxt;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  361  
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  362  	if (!is_valid_mmap(token) || !uctxt ||
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  363  	    !(vma->vm_flags & VM_SHARED)) {
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  364  		ret = -EINVAL;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  365  		goto done;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  366  	}
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  367  	dd = uctxt->dd;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  368  	ctxt = HFI1_MMAP_TOKEN_GET(CTXT, token);
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  369  	subctxt = HFI1_MMAP_TOKEN_GET(SUBCTXT, token);
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  370  	type = HFI1_MMAP_TOKEN_GET(TYPE, token);
9e10af4787ac51 drivers/staging/rdma/hfi1/file_ops.c  Ira Weiny          2015-10-30  371  	if (ctxt != uctxt->ctxt || subctxt != fd->subctxt) {
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  372  		ret = -EINVAL;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  373  		goto done;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  374  	}
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  375  
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  376  	flags = vma->vm_flags;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  377  
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  378  	switch (type) {
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  379  	case PIO_BUFS:
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  380  	case PIO_BUFS_SOP:
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  381  		memaddr = ((dd->physaddr + TXE_PIO_SEND) +
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  382  				/* chip pio base */
d32cf44a62716d drivers/staging/rdma/hfi1/file_ops.c  Amitoj Kaur Chawla 2015-10-16  383  			   (uctxt->sc->hw_context * BIT(16))) +
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  384  				/* 64K PIO space / ctxt */
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  385  			(type == PIO_BUFS_SOP ?
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  386  				(TXE_PIO_SIZE / 2) : 0); /* sop? */
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  387  		/*
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  388  		 * Map only the amount allocated to the context, not the
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  389  		 * entire available context's PIO space.
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  390  		 */
437b29d1159af1 drivers/staging/rdma/hfi1/file_ops.c  Amitoj Kaur Chawla 2016-03-04  391  		memlen = PAGE_ALIGN(uctxt->sc->credits * PIO_BLOCK_SIZE);
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  392  		flags &= ~VM_MAYREAD;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  393  		flags |= VM_DONTCOPY | VM_DONTEXPAND;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  394  		vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  395  		mapio = 1;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  396  		break;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  397  	case PIO_CRED:
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  398  		if (flags & VM_WRITE) {
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  399  			ret = -EPERM;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  400  			goto done;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  401  		}
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  402  		/*
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  403  		 * The credit return location for this context could be on the
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  404  		 * second or third page allocated for credit returns (if number
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  405  		 * of enabled contexts > 64 and 128 respectively).
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  406  		 */
60368186fd8538 drivers/infiniband/hw/hfi1/file_ops.c Tymoteusz Kielan   2016-09-06  407  		memvirt = dd->cr_base[uctxt->numa_id].va;
60368186fd8538 drivers/infiniband/hw/hfi1/file_ops.c Tymoteusz Kielan   2016-09-06  408  		memaddr = virt_to_phys(memvirt) +
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  409  			(((u64)uctxt->sc->hw_free -
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  410  			  (u64)dd->cr_base[uctxt->numa_id].va) & PAGE_MASK);
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  411  		memlen = PAGE_SIZE;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  412  		flags &= ~VM_MAYWRITE;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  413  		flags |= VM_DONTCOPY | VM_DONTEXPAND;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  414  		/*
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  415  		 * The driver has already allocated memory for credit
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  416  		 * returns and programmed it into the chip. Has that
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  417  		 * memory been flagged as non-cached?
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  418  		 */
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  419  		/* vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot); */
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  420  		mapio = 1;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  421  		break;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  422  	case RCV_HDRQ:
b25784312840bc drivers/infiniband/hw/hfi1/file_ops.c Mike Marciniszyn   2018-06-20  423  		memlen = rcvhdrq_size(uctxt);
60368186fd8538 drivers/infiniband/hw/hfi1/file_ops.c Tymoteusz Kielan   2016-09-06  424  		memvirt = uctxt->rcvhdrq;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  425  		break;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  426  	case RCV_EGRBUF: {
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  427  		unsigned long addr;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  428  		int i;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  429  		/*
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  430  		 * The RcvEgr buffer need to be handled differently
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  431  		 * as multiple non-contiguous pages need to be mapped
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  432  		 * into the user process.
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  433  		 */
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  434  		memlen = uctxt->egrbufs.size;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  435  		if ((vma->vm_end - vma->vm_start) != memlen) {
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  436  			dd_dev_err(dd, "Eager buffer map size invalid (%lu != %lu)\n",
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  437  				   (vma->vm_end - vma->vm_start), memlen);
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  438  			ret = -EINVAL;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  439  			goto done;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  440  		}
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  441  		if (vma->vm_flags & VM_WRITE) {
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  442  			ret = -EPERM;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  443  			goto done;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  444  		}
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  445  		vma->vm_flags &= ~VM_MAYWRITE;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  446  		addr = vma->vm_start;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  447  		for (i = 0 ; i < uctxt->egrbufs.numbufs; i++) {
60368186fd8538 drivers/infiniband/hw/hfi1/file_ops.c Tymoteusz Kielan   2016-09-06  448  			memlen = uctxt->egrbufs.buffers[i].len;
60368186fd8538 drivers/infiniband/hw/hfi1/file_ops.c Tymoteusz Kielan   2016-09-06  449  			memvirt = uctxt->egrbufs.buffers[i].addr;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  450  			ret = remap_pfn_range(
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  451  				vma, addr,
60368186fd8538 drivers/infiniband/hw/hfi1/file_ops.c Tymoteusz Kielan   2016-09-06  452  				/*
60368186fd8538 drivers/infiniband/hw/hfi1/file_ops.c Tymoteusz Kielan   2016-09-06  453  				 * virt_to_pfn() does the same, but
60368186fd8538 drivers/infiniband/hw/hfi1/file_ops.c Tymoteusz Kielan   2016-09-06  454  				 * it's not available on x86_64
60368186fd8538 drivers/infiniband/hw/hfi1/file_ops.c Tymoteusz Kielan   2016-09-06  455  				 * when CONFIG_MMU is enabled.
60368186fd8538 drivers/infiniband/hw/hfi1/file_ops.c Tymoteusz Kielan   2016-09-06  456  				 */
60368186fd8538 drivers/infiniband/hw/hfi1/file_ops.c Tymoteusz Kielan   2016-09-06  457  				PFN_DOWN(__pa(memvirt)),
60368186fd8538 drivers/infiniband/hw/hfi1/file_ops.c Tymoteusz Kielan   2016-09-06  458  				memlen,
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  459  				vma->vm_page_prot);
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  460  			if (ret < 0)
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  461  				goto done;
60368186fd8538 drivers/infiniband/hw/hfi1/file_ops.c Tymoteusz Kielan   2016-09-06  462  			addr += memlen;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  463  		}
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  464  		ret = 0;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  465  		goto done;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  466  	}
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  467  	case UREGS:
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  468  		/*
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  469  		 * Map only the page that contains this context's user
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  470  		 * registers.
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  471  		 */
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  472  		memaddr = (unsigned long)
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  473  			(dd->physaddr + RXE_PER_CONTEXT_USER)
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  474  			+ (uctxt->ctxt * RXE_PER_CONTEXT_SIZE);
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  475  		/*
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  476  		 * TidFlow table is on the same page as the rest of the
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  477  		 * user registers.
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  478  		 */
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  479  		memlen = PAGE_SIZE;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  480  		flags |= VM_DONTCOPY | VM_DONTEXPAND;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  481  		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  482  		mapio = 1;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  483  		break;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  484  	case EVENTS:
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  485  		/*
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  486  		 * Use the page where this context's flags are. User level
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  487  		 * knows where it's own bitmap is within the page.
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  488  		 */
21e5acc06403f6 drivers/infiniband/hw/hfi1/file_ops.c Michael J. Ruhl    2017-09-26  489  		memaddr = (unsigned long)
21e5acc06403f6 drivers/infiniband/hw/hfi1/file_ops.c Michael J. Ruhl    2017-09-26  490  			(dd->events + uctxt_offset(uctxt)) & PAGE_MASK;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  491  		memlen = PAGE_SIZE;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  492  		/*
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  493  		 * v3.7 removes VM_RESERVED but the effect is kept by
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  494  		 * using VM_IO.
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  495  		 */
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  496  		flags |= VM_IO | VM_DONTEXPAND;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  497  		vmf = 1;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  498  		break;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  499  	case STATUS:
7709b0dc265f28 drivers/infiniband/hw/hfi1/file_ops.c Michael J. Ruhl    2019-01-17  500  		if (flags & VM_WRITE) {
12220267645cb7 drivers/infiniband/hw/hfi1/file_ops.c Ira Weiny          2017-04-09  501  			ret = -EPERM;
12220267645cb7 drivers/infiniband/hw/hfi1/file_ops.c Ira Weiny          2017-04-09  502  			goto done;
12220267645cb7 drivers/infiniband/hw/hfi1/file_ops.c Ira Weiny          2017-04-09  503  		}
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  504  		memaddr = kvirt_to_phys((void *)dd->status);
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  505  		memlen = PAGE_SIZE;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  506  		flags |= VM_IO | VM_DONTEXPAND;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  507  		break;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  508  	case RTAIL:
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  509  		if (!HFI1_CAP_IS_USET(DMA_RTAIL)) {
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  510  			/*
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  511  			 * If the memory allocation failed, the context alloc
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  512  			 * also would have failed, so we would never get here
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  513  			 */
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  514  			ret = -EINVAL;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  515  			goto done;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  516  		}
2fb3b5ae1ca771 drivers/infiniband/hw/hfi1/file_ops.c Mike Marciniszyn   2019-12-19  517  		if ((flags & VM_WRITE) || !hfi1_rcvhdrtail_kvaddr(uctxt)) {
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  518  			ret = -EPERM;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  519  			goto done;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  520  		}
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  521  		memlen = PAGE_SIZE;
2fb3b5ae1ca771 drivers/infiniband/hw/hfi1/file_ops.c Mike Marciniszyn   2019-12-19  522  		memvirt = (void *)hfi1_rcvhdrtail_kvaddr(uctxt);
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  523  		flags &= ~VM_MAYWRITE;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  524  		break;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  525  	case SUBCTXT_UREGS:
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  526  		memaddr = (u64)uctxt->subctxt_uregbase;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  527  		memlen = PAGE_SIZE;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  528  		flags |= VM_IO | VM_DONTEXPAND;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  529  		vmf = 1;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  530  		break;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  531  	case SUBCTXT_RCV_HDRQ:
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  532  		memaddr = (u64)uctxt->subctxt_rcvhdr_base;
b25784312840bc drivers/infiniband/hw/hfi1/file_ops.c Mike Marciniszyn   2018-06-20  533  		memlen = rcvhdrq_size(uctxt) * uctxt->subctxt_cnt;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  534  		flags |= VM_IO | VM_DONTEXPAND;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  535  		vmf = 1;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  536  		break;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  537  	case SUBCTXT_EGRBUF:
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  538  		memaddr = (u64)uctxt->subctxt_rcvegrbuf;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  539  		memlen = uctxt->egrbufs.size * uctxt->subctxt_cnt;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  540  		flags |= VM_IO | VM_DONTEXPAND;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  541  		flags &= ~VM_MAYWRITE;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  542  		vmf = 1;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  543  		break;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  544  	case SDMA_COMP: {
9e10af4787ac51 drivers/staging/rdma/hfi1/file_ops.c  Ira Weiny          2015-10-30  545  		struct hfi1_user_sdma_comp_q *cq = fd->cq;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  546  
9e10af4787ac51 drivers/staging/rdma/hfi1/file_ops.c  Ira Weiny          2015-10-30  547  		if (!cq) {
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  548  			ret = -EFAULT;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  549  			goto done;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  550  		}
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  551  		memaddr = (u64)cq->comps;
437b29d1159af1 drivers/staging/rdma/hfi1/file_ops.c  Amitoj Kaur Chawla 2016-03-04  552  		memlen = PAGE_ALIGN(sizeof(*cq->comps) * cq->nentries);
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  553  		flags |= VM_IO | VM_DONTEXPAND;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  554  		vmf = 1;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  555  		break;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  556  	}
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  557  	default:
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  558  		ret = -EINVAL;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  559  		break;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  560  	}
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  561  
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  562  	if ((vma->vm_end - vma->vm_start) != memlen) {
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  563  		hfi1_cdbg(PROC, "%u:%u Memory size mismatch %lu:%lu",
9e10af4787ac51 drivers/staging/rdma/hfi1/file_ops.c  Ira Weiny          2015-10-30  564  			  uctxt->ctxt, fd->subctxt,
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  565  			  (vma->vm_end - vma->vm_start), memlen);
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  566  		ret = -EINVAL;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  567  		goto done;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  568  	}
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  569  
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  570  	vma->vm_flags = flags;
6c63e4238acad0 drivers/staging/rdma/hfi1/file_ops.c  Sebastian Sanchez  2015-11-06  571  	hfi1_cdbg(PROC,
6c63e4238acad0 drivers/staging/rdma/hfi1/file_ops.c  Sebastian Sanchez  2015-11-06 @572  		  "%u:%u type:%u io/vf:%d/%d, addr:0x%llx, len:%lu(%lu), flags:0x%lx\n",
6c63e4238acad0 drivers/staging/rdma/hfi1/file_ops.c  Sebastian Sanchez  2015-11-06  573  		    ctxt, subctxt, type, mapio, vmf, memaddr, memlen,
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  574  		    vma->vm_end - vma->vm_start, vma->vm_flags);
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  575  	if (vmf) {
60368186fd8538 drivers/infiniband/hw/hfi1/file_ops.c Tymoteusz Kielan   2016-09-06  576  		vma->vm_pgoff = PFN_DOWN(memaddr);
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  577  		vma->vm_ops = &vm_ops;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  578  		ret = 0;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  579  	} else if (mapio) {
60368186fd8538 drivers/infiniband/hw/hfi1/file_ops.c Tymoteusz Kielan   2016-09-06  580  		ret = io_remap_pfn_range(vma, vma->vm_start,
60368186fd8538 drivers/infiniband/hw/hfi1/file_ops.c Tymoteusz Kielan   2016-09-06  581  					 PFN_DOWN(memaddr),
60368186fd8538 drivers/infiniband/hw/hfi1/file_ops.c Tymoteusz Kielan   2016-09-06  582  					 memlen,
60368186fd8538 drivers/infiniband/hw/hfi1/file_ops.c Tymoteusz Kielan   2016-09-06  583  					 vma->vm_page_prot);
60368186fd8538 drivers/infiniband/hw/hfi1/file_ops.c Tymoteusz Kielan   2016-09-06  584  	} else if (memvirt) {
60368186fd8538 drivers/infiniband/hw/hfi1/file_ops.c Tymoteusz Kielan   2016-09-06  585  		ret = remap_pfn_range(vma, vma->vm_start,
60368186fd8538 drivers/infiniband/hw/hfi1/file_ops.c Tymoteusz Kielan   2016-09-06  586  				      PFN_DOWN(__pa(memvirt)),
60368186fd8538 drivers/infiniband/hw/hfi1/file_ops.c Tymoteusz Kielan   2016-09-06  587  				      memlen,
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  588  				      vma->vm_page_prot);
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  589  	} else {
60368186fd8538 drivers/infiniband/hw/hfi1/file_ops.c Tymoteusz Kielan   2016-09-06  590  		ret = remap_pfn_range(vma, vma->vm_start,
60368186fd8538 drivers/infiniband/hw/hfi1/file_ops.c Tymoteusz Kielan   2016-09-06  591  				      PFN_DOWN(memaddr),
60368186fd8538 drivers/infiniband/hw/hfi1/file_ops.c Tymoteusz Kielan   2016-09-06  592  				      memlen,
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  593  				      vma->vm_page_prot);
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  594  	}
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  595  done:
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  596  	return ret;
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  597  }
7724105686e718 drivers/staging/rdma/hfi1/file_ops.c  Mike Marciniszyn   2015-07-30  598  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--Qxx1br4bt0+wmkIi
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--Qxx1br4bt0+wmkIi--
