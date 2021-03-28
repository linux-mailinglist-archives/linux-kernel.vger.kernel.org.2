Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 575B034BE5E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 20:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbhC1SuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 14:50:04 -0400
Received: from mga02.intel.com ([134.134.136.20]:32988 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231492AbhC1Stc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 14:49:32 -0400
IronPort-SDR: AArBHc4Rf0W4Ui1B1AdyS9vfqiwpO314zJ5ulYkFODzETrd/vKkjxThx7UAhIKfdF2rKoWQBcM
 bfQjQaufMrZw==
X-IronPort-AV: E=McAfee;i="6000,8403,9937"; a="178563007"
X-IronPort-AV: E=Sophos;i="5.81,285,1610438400"; 
   d="gz'50?scan'50,208,50";a="178563007"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2021 11:49:23 -0700
IronPort-SDR: 6CLoX4/5o7JoJnaxqSxt8hIFeWo7J9He9Te+cRGlf0DlMdEBlE97BnffbcMf+7vAuRptUAtZVX
 /4+Ae9xIUDyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,285,1610438400"; 
   d="gz'50?scan'50,208,50";a="392901977"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 28 Mar 2021 11:49:21 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lQaTQ-00047e-Gd; Sun, 28 Mar 2021 18:49:20 +0000
Date:   Mon, 29 Mar 2021 02:49:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>
Subject: drivers/vfio/pci/vfio_pci_nvlink2.c:101:10: error: implicit
 declaration of function 'mm_iommu_put'; did you mean 'mm_iommu_init'?
Message-ID: <202103290251.Bk0oGD9I-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jason,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0f4498cef9f5cd18d7c6639a2a902ec1edc5be4e
commit: 179209fa12709a3df8888c323b37315da2683c24 vfio: IOMMU_API should be selected
date:   12 days ago
config: powerpc64-randconfig-r014-20210328 (attached as .config)
compiler: powerpc64le-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=179209fa12709a3df8888c323b37315da2683c24
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 179209fa12709a3df8888c323b37315da2683c24
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=powerpc64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/vfio/pci/vfio_pci_nvlink2.c: In function 'vfio_pci_nvgpu_release':
>> drivers/vfio/pci/vfio_pci_nvlink2.c:101:10: error: implicit declaration of function 'mm_iommu_put'; did you mean 'mm_iommu_init'? [-Werror=implicit-function-declaration]
     101 |    ret = mm_iommu_put(data->mm, data->mem);
         |          ^~~~~~~~~~~~
         |          mm_iommu_init
   drivers/vfio/pci/vfio_pci_nvlink2.c: In function 'vfio_pci_nvgpu_mmap':
>> drivers/vfio/pci/vfio_pci_nvlink2.c:165:14: error: implicit declaration of function 'mm_iommu_newdev' [-Werror=implicit-function-declaration]
     165 |  ret = (int) mm_iommu_newdev(data->mm, data->useraddr,
         |              ^~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +101 drivers/vfio/pci/vfio_pci_nvlink2.c

7f92891778dff6 Alexey Kardashevskiy 2018-12-20   91  
7f92891778dff6 Alexey Kardashevskiy 2018-12-20   92  static void vfio_pci_nvgpu_release(struct vfio_pci_device *vdev,
7f92891778dff6 Alexey Kardashevskiy 2018-12-20   93  		struct vfio_pci_region *region)
7f92891778dff6 Alexey Kardashevskiy 2018-12-20   94  {
7f92891778dff6 Alexey Kardashevskiy 2018-12-20   95  	struct vfio_pci_nvgpu_data *data = region->data;
7f92891778dff6 Alexey Kardashevskiy 2018-12-20   96  	long ret;
7f92891778dff6 Alexey Kardashevskiy 2018-12-20   97  
7f92891778dff6 Alexey Kardashevskiy 2018-12-20   98  	/* If there were any mappings at all... */
7f92891778dff6 Alexey Kardashevskiy 2018-12-20   99  	if (data->mm) {
338b4e10f939a7 Alexey Kardashevskiy 2019-12-23  100  		if (data->mem) {
7f92891778dff6 Alexey Kardashevskiy 2018-12-20 @101  			ret = mm_iommu_put(data->mm, data->mem);
7f92891778dff6 Alexey Kardashevskiy 2018-12-20  102  			WARN_ON(ret);
338b4e10f939a7 Alexey Kardashevskiy 2019-12-23  103  		}
7f92891778dff6 Alexey Kardashevskiy 2018-12-20  104  
7f92891778dff6 Alexey Kardashevskiy 2018-12-20  105  		mmdrop(data->mm);
7f92891778dff6 Alexey Kardashevskiy 2018-12-20  106  	}
7f92891778dff6 Alexey Kardashevskiy 2018-12-20  107  
7f92891778dff6 Alexey Kardashevskiy 2018-12-20  108  	vfio_unregister_notifier(&data->gpdev->dev, VFIO_GROUP_NOTIFY,
7f92891778dff6 Alexey Kardashevskiy 2018-12-20  109  			&data->group_notifier);
7f92891778dff6 Alexey Kardashevskiy 2018-12-20  110  
7f92891778dff6 Alexey Kardashevskiy 2018-12-20  111  	pnv_npu2_unmap_lpar_dev(data->gpdev);
7f92891778dff6 Alexey Kardashevskiy 2018-12-20  112  
7f92891778dff6 Alexey Kardashevskiy 2018-12-20  113  	kfree(data);
7f92891778dff6 Alexey Kardashevskiy 2018-12-20  114  }
7f92891778dff6 Alexey Kardashevskiy 2018-12-20  115  
7f92891778dff6 Alexey Kardashevskiy 2018-12-20  116  static vm_fault_t vfio_pci_nvgpu_mmap_fault(struct vm_fault *vmf)
7f92891778dff6 Alexey Kardashevskiy 2018-12-20  117  {
7f92891778dff6 Alexey Kardashevskiy 2018-12-20  118  	vm_fault_t ret;
7f92891778dff6 Alexey Kardashevskiy 2018-12-20  119  	struct vm_area_struct *vma = vmf->vma;
7f92891778dff6 Alexey Kardashevskiy 2018-12-20  120  	struct vfio_pci_region *region = vma->vm_private_data;
7f92891778dff6 Alexey Kardashevskiy 2018-12-20  121  	struct vfio_pci_nvgpu_data *data = region->data;
7f92891778dff6 Alexey Kardashevskiy 2018-12-20  122  	unsigned long vmf_off = (vmf->address - vma->vm_start) >> PAGE_SHIFT;
7f92891778dff6 Alexey Kardashevskiy 2018-12-20  123  	unsigned long nv2pg = data->gpu_hpa >> PAGE_SHIFT;
7f92891778dff6 Alexey Kardashevskiy 2018-12-20  124  	unsigned long vm_pgoff = vma->vm_pgoff &
7f92891778dff6 Alexey Kardashevskiy 2018-12-20  125  		((1U << (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT)) - 1);
7f92891778dff6 Alexey Kardashevskiy 2018-12-20  126  	unsigned long pfn = nv2pg + vm_pgoff + vmf_off;
7f92891778dff6 Alexey Kardashevskiy 2018-12-20  127  
7f92891778dff6 Alexey Kardashevskiy 2018-12-20  128  	ret = vmf_insert_pfn(vma, vmf->address, pfn);
7f92891778dff6 Alexey Kardashevskiy 2018-12-20  129  	trace_vfio_pci_nvgpu_mmap_fault(data->gpdev, pfn << PAGE_SHIFT,
7f92891778dff6 Alexey Kardashevskiy 2018-12-20  130  			vmf->address, ret);
7f92891778dff6 Alexey Kardashevskiy 2018-12-20  131  
7f92891778dff6 Alexey Kardashevskiy 2018-12-20  132  	return ret;
7f92891778dff6 Alexey Kardashevskiy 2018-12-20  133  }
7f92891778dff6 Alexey Kardashevskiy 2018-12-20  134  
7f92891778dff6 Alexey Kardashevskiy 2018-12-20  135  static const struct vm_operations_struct vfio_pci_nvgpu_mmap_vmops = {
7f92891778dff6 Alexey Kardashevskiy 2018-12-20  136  	.fault = vfio_pci_nvgpu_mmap_fault,
7f92891778dff6 Alexey Kardashevskiy 2018-12-20  137  };
7f92891778dff6 Alexey Kardashevskiy 2018-12-20  138  
7f92891778dff6 Alexey Kardashevskiy 2018-12-20  139  static int vfio_pci_nvgpu_mmap(struct vfio_pci_device *vdev,
7f92891778dff6 Alexey Kardashevskiy 2018-12-20  140  		struct vfio_pci_region *region, struct vm_area_struct *vma)
7f92891778dff6 Alexey Kardashevskiy 2018-12-20  141  {
7f92891778dff6 Alexey Kardashevskiy 2018-12-20  142  	int ret;
7f92891778dff6 Alexey Kardashevskiy 2018-12-20  143  	struct vfio_pci_nvgpu_data *data = region->data;
7f92891778dff6 Alexey Kardashevskiy 2018-12-20  144  
7f92891778dff6 Alexey Kardashevskiy 2018-12-20  145  	if (data->useraddr)
7f92891778dff6 Alexey Kardashevskiy 2018-12-20  146  		return -EPERM;
7f92891778dff6 Alexey Kardashevskiy 2018-12-20  147  
7f92891778dff6 Alexey Kardashevskiy 2018-12-20  148  	if (vma->vm_end - vma->vm_start > data->size)
7f92891778dff6 Alexey Kardashevskiy 2018-12-20  149  		return -EINVAL;
7f92891778dff6 Alexey Kardashevskiy 2018-12-20  150  
7f92891778dff6 Alexey Kardashevskiy 2018-12-20  151  	vma->vm_private_data = region;
7f92891778dff6 Alexey Kardashevskiy 2018-12-20  152  	vma->vm_flags |= VM_PFNMAP;
7f92891778dff6 Alexey Kardashevskiy 2018-12-20  153  	vma->vm_ops = &vfio_pci_nvgpu_mmap_vmops;
7f92891778dff6 Alexey Kardashevskiy 2018-12-20  154  
7f92891778dff6 Alexey Kardashevskiy 2018-12-20  155  	/*
7f92891778dff6 Alexey Kardashevskiy 2018-12-20  156  	 * Calling mm_iommu_newdev() here once as the region is not
7f92891778dff6 Alexey Kardashevskiy 2018-12-20  157  	 * registered yet and therefore right initialization will happen now.
7f92891778dff6 Alexey Kardashevskiy 2018-12-20  158  	 * Other places will use mm_iommu_find() which returns
7f92891778dff6 Alexey Kardashevskiy 2018-12-20  159  	 * registered @mem and does not go gup().
7f92891778dff6 Alexey Kardashevskiy 2018-12-20  160  	 */
7f92891778dff6 Alexey Kardashevskiy 2018-12-20  161  	data->useraddr = vma->vm_start;
7f92891778dff6 Alexey Kardashevskiy 2018-12-20  162  	data->mm = current->mm;
7f92891778dff6 Alexey Kardashevskiy 2018-12-20  163  
bb3d3cf928d4cc Julia Lawall         2019-12-29  164  	mmgrab(data->mm);
7f92891778dff6 Alexey Kardashevskiy 2018-12-20 @165  	ret = (int) mm_iommu_newdev(data->mm, data->useraddr,
e66e02c4d96d33 Peng Hao             2019-07-02  166  			vma_pages(vma), data->gpu_hpa, &data->mem);
7f92891778dff6 Alexey Kardashevskiy 2018-12-20  167  
7f92891778dff6 Alexey Kardashevskiy 2018-12-20  168  	trace_vfio_pci_nvgpu_mmap(vdev->pdev, data->gpu_hpa, data->useraddr,
7f92891778dff6 Alexey Kardashevskiy 2018-12-20  169  			vma->vm_end - vma->vm_start, ret);
7f92891778dff6 Alexey Kardashevskiy 2018-12-20  170  
7f92891778dff6 Alexey Kardashevskiy 2018-12-20  171  	return ret;
7f92891778dff6 Alexey Kardashevskiy 2018-12-20  172  }
7f92891778dff6 Alexey Kardashevskiy 2018-12-20  173  

:::::: The code at line 101 was first introduced by commit
:::::: 7f92891778dff62303c070ac81de7b7d80de331a vfio_pci: Add NVIDIA GV100GL [Tesla V100 SXM2] subdriver

:::::: TO: Alexey Kardashevskiy <aik@ozlabs.ru>
:::::: CC: Michael Ellerman <mpe@ellerman.id.au>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--k+w/mQv8wyuph6w0
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
MJSSE6gW09Wom1iwl/UYO10g0x8AwAgbeEl1AQA=

--k+w/mQv8wyuph6w0--
