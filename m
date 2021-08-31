Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DABAF3FC2ED
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 08:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237059AbhHaGnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 02:43:49 -0400
Received: from mga18.intel.com ([134.134.136.126]:1573 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234268AbhHaGno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 02:43:44 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10092"; a="205544217"
X-IronPort-AV: E=Sophos;i="5.84,365,1620716400"; 
   d="scan'208";a="205544217"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2021 23:42:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,365,1620716400"; 
   d="scan'208";a="540891898"
Received: from louislifei-optiplex-7050.sh.intel.com (HELO louislifei-OptiPlex-7050) ([10.239.154.151])
  by fmsmga002.fm.intel.com with ESMTP; 30 Aug 2021 23:42:48 -0700
Date:   Tue, 31 Aug 2021 14:43:23 +0800
From:   Li Fei1 <fei1.li@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, yu1.wang@intel.com,
        shuox.liu@gmail.com
Subject: Re: [PATCH v2 3/3] virt: acrn: Introduce interface to fetch platform
 info from the hypervisor
Message-ID: <20210831064323.GA8869@louislifei-OptiPlex-7050>
References: <20210825090142.4418-1-fei1.li@intel.com>
 <20210825090142.4418-4-fei1.li@intel.com>
 <YSinKyxJafvgatSM@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSinKyxJafvgatSM@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2021 at 10:49:47AM +0200, Greg KH wrote:
> On Wed, Aug 25, 2021 at 05:01:42PM +0800, Fei Li wrote:
> > From: Shuo Liu <shuo.a.liu@intel.com>
> > 
> > The ACRN hypervisor configures the guest VMs information statically and
> > builds guest VM configurations within the hypervisor. There are also
> > some hardware information are stored in the hypervisor in boot stage.
> > The ACRN userspace needs platform information to do the orchestration.
> > 
> > The HSM provides the following interface for the ACRN userspace to fetch
> > platform info:
> >  - ACRN_IOCTL_GET_PLATFORM_INFO
> >    Exchange the basic information by a struct acrn_platform_info. If the
> >    ACRN userspace provides a userspace buffer (whose vma filled in
> >    vm_configs_addr), the HSM creates a bounce buffer (kmalloced for
> >    continuous memory region) to fetch VM configurations data from the
> >    hypervisor.
> > 
> > Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
> > Signed-off-by: Fei Li <fei1.li@intel.com>
> > ---
> >  drivers/virt/acrn/hsm.c       | 53 +++++++++++++++++++++++++++++++++++
> >  drivers/virt/acrn/hypercall.h | 12 ++++++++
> >  include/uapi/linux/acrn.h     | 44 +++++++++++++++++++++++++++++
> >  3 files changed, 109 insertions(+)
> > 
> > diff --git a/drivers/virt/acrn/hsm.c b/drivers/virt/acrn/hsm.c
> > index 5419794fccf1..eb824a1a86a0 100644
> > --- a/drivers/virt/acrn/hsm.c
> > +++ b/drivers/virt/acrn/hsm.c
> > @@ -108,6 +108,7 @@ static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
> >  			   unsigned long ioctl_param)
> >  {
> >  	struct acrn_vm *vm = filp->private_data;
> > +	struct acrn_platform_info *plat_info;
> >  	struct acrn_vm_creation *vm_param;
> >  	struct acrn_vcpu_regs *cpu_regs;
> >  	struct acrn_ioreq_notify notify;
> > @@ -115,9 +116,12 @@ static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
> >  	struct acrn_ioeventfd ioeventfd;
> >  	struct acrn_vm_memmap memmap;
> >  	struct acrn_mmiodev *mmiodev;
> > +	void __user *vm_configs_user;
> >  	struct acrn_msi_entry *msi;
> >  	struct acrn_pcidev *pcidev;
> >  	struct acrn_irqfd irqfd;
> > +	void *vm_configs = NULL;
> > +	size_t vm_configs_size;
> >  	struct acrn_vdev *vdev;
> >  	struct page *page;
> >  	u64 cstate_cmd;
> > @@ -130,6 +134,55 @@ static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
> >  	}
> >  
> >  	switch (cmd) {
> > +	case ACRN_IOCTL_GET_PLATFORM_INFO:
> > +		plat_info = memdup_user((void __user *)ioctl_param,
> > +					sizeof(struct acrn_platform_info));
> > +		if (IS_ERR(plat_info))
> > +			return PTR_ERR(plat_info);
> > +
> > +		for (i = 0; i < ARRAY_SIZE(plat_info->sw.reserved); i++)
> > +			if (plat_info->sw.reserved[i])
> > +				return -EINVAL;
> > +
> > +		for (i = 0; i < ARRAY_SIZE(plat_info->hw.reserved); i++)
> > +			if (plat_info->hw.reserved[i])
> > +				return -EINVAL;
> > +
> > +		vm_configs_size = plat_info->sw.vm_config_size *
> > +						plat_info->sw.max_vms;
> > +		if (plat_info->sw.vm_configs_addr && vm_configs_size) {
> > +			vm_configs_user = plat_info->sw.vm_configs_addr;
> > +			vm_configs = kzalloc(vm_configs_size, GFP_KERNEL);
> > +			if (IS_ERR(vm_configs)) {
> > +				kfree(plat_info);
> > +				return PTR_ERR(vm_configs);
> > +			}
> > +			plat_info->sw.vm_configs_addr =
> > +					(void __user *)virt_to_phys(vm_configs);
> > +		}
> > +
> > +		ret = hcall_get_platform_info(virt_to_phys(plat_info));
> > +		if (ret < 0) {
> > +			kfree(vm_configs);
> > +			kfree(plat_info);
> > +			dev_dbg(acrn_dev.this_device,
> > +				"Failed to get info of VM %u!\n", vm->vmid);
> > +			break;
> > +		}
> > +
> > +		if (vm_configs) {
> > +			if (copy_to_user(vm_configs_user, vm_configs,
> > +					 vm_configs_size))
> > +				ret = -EFAULT;
> > +			plat_info->sw.vm_configs_addr = vm_configs_user;
> > +		}
> > +		if (!ret && copy_to_user((void __user *)ioctl_param, plat_info,
> > +					 sizeof(*plat_info)))
> > +			ret = -EFAULT;
> > +
> > +		kfree(vm_configs);
> > +		kfree(plat_info);
> > +		break;
> >  	case ACRN_IOCTL_CREATE_VM:
> >  		vm_param = memdup_user((void __user *)ioctl_param,
> >  				       sizeof(struct acrn_vm_creation));
> > diff --git a/drivers/virt/acrn/hypercall.h b/drivers/virt/acrn/hypercall.h
> > index 71d300821a18..440e204d731a 100644
> > --- a/drivers/virt/acrn/hypercall.h
> > +++ b/drivers/virt/acrn/hypercall.h
> > @@ -15,6 +15,7 @@
> >  
> >  #define HC_ID_GEN_BASE			0x0UL
> >  #define HC_SOS_REMOVE_CPU		_HC_ID(HC_ID, HC_ID_GEN_BASE + 0x01)
> > +#define HC_GET_PLATFORM_INFO		_HC_ID(HC_ID, HC_ID_GEN_BASE + 0x03)
> >  
> >  #define HC_ID_VM_BASE			0x10UL
> >  #define HC_CREATE_VM			_HC_ID(HC_ID, HC_ID_VM_BASE + 0x00)
> > @@ -60,6 +61,17 @@ static inline long hcall_sos_remove_cpu(u64 cpu)
> >  	return acrn_hypercall1(HC_SOS_REMOVE_CPU, cpu);
> >  }
> >  
> > +/**
> > + * hcall_get_platform_info() - Get platform information from the hypervisor
> > + * @platform_info: Service VM GPA of the &struct acrn_platform_info
> > + *
> > + * Return: 0 on success, <0 on failure
> > + */
> > +static inline long hcall_get_platform_info(u64 platform_info)
> > +{
> > +	return acrn_hypercall1(HC_GET_PLATFORM_INFO, platform_info);
> > +}
> > +
> >  /**
> >   * hcall_create_vm() - Create a User VM
> >   * @vminfo:	Service VM GPA of info of User VM creation
> > diff --git a/include/uapi/linux/acrn.h b/include/uapi/linux/acrn.h
> > index 1408d1063339..2675d17bc803 100644
> > --- a/include/uapi/linux/acrn.h
> > +++ b/include/uapi/linux/acrn.h
> > @@ -580,12 +580,56 @@ struct acrn_irqfd {
> >  	struct acrn_msi_entry	msi;
> >  };
> >  
Hi Greg

> > +#define ACRN_PLATFORM_LAPIC_IDS_MAX	64
> > +/**
> > + * struct acrn_platform_info - Information of a platform from hypervisor
> > + * @hw.cpu_num:			Physical CPU number of the platform
> > + * @hw.version:			Version of this structure
> > + * @hw.l2_cat_shift:		Order of the number of threads sharing L2 cache
> > + * @hw.l3_cat_shift:		Order of the number of threads sharing L3 cache
> > + * @hw.lapic_ids:		IDs of LAPICs of all threads
> > + * @hw.reserved:		Reserved for alignment and should be 0
> 
> "must be"
Would change it.
> 
> > + * @sw.max_vcpus_per_vm:	Maximum number of vCPU of a VM
> > + * @sw.max_vms:			Maximum number of VM
> > + * @sw.vm_config_size:		Size of configuration of a VM
> > + * @sw.vm_configss_addr:	Memory address which user space provided to
> > + *				store the VM configurations
> > + * @sw.max_kata_containers:	Maximum number of VM for Kata containers
> > + * @sw.reserved:		Reserved for alignment and should be 0
> 
> "must be"
Would change it.
> 
> > + *
> > + * If vm_configs_addr is provided, the driver uses a bounce buffer (kmalloced
> > + * for continuous memory region) to fetch VM configurations data from the
> > + * hypervisor.
> > + */
> > +struct acrn_platform_info {
> > +	struct {
> > +		__u16	cpu_num;
> > +		__u16	version;
> > +		__u32	l2_cat_shift;
> > +		__u32	l3_cat_shift;
> > +		__u8	lapic_ids[ACRN_PLATFORM_LAPIC_IDS_MAX];
> > +		__u8	reserved[52];
> 
> These are huge buffer padding, why so large?

We hope the hw structure should by 128 Bytes aligned. Maybe enlarge length of
_lapic_ids field from 64 to 116 and remove reserved field ?

> 
> > +	} hw;
> > +
> > +	struct {
> > +		__u16	max_vcpus_per_vm;
> > +		__u16	max_vms;
> > +		__u32	vm_config_size;
> > +		void	__user *vm_configs_addr;
> 
> pointers do not work in ioctl structures, please fix.

Could I change it to "__u64 vm_configs_addr" then convert its type to
"void    __user *" just like  ioctl_param or define a large data here
__u8 vm_configs[0x8000] ?

thanks.

> 
> thanks,
> 
> greg k-h
