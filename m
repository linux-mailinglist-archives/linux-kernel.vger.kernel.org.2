Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1B9F3F9673
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 10:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244543AbhH0Iuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 04:50:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:47950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244510AbhH0Iuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 04:50:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CB7A360187;
        Fri, 27 Aug 2021 08:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630054195;
        bh=ThnORpRaE0mJtWPcwRex34lKgCMWhsIl3VAZJuYDYBo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jckUYhR6Wcin3Z3zBhk0/H9dsl7cdEbNh+LzwYC+tbVzmhkopfgXIevxYG8NR+lwK
         ckTgap4nBOwbT9KZr7Y/T6kmPBUMWHrtq+QHqRyxoBnbP/X7+fMlq1Qitcp+9Wo4AG
         1eS1kx5gWo6vvGpzimjYfIxOH7DfUxeShTFLZtK4=
Date:   Fri, 27 Aug 2021 10:49:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Fei Li <fei1.li@intel.com>
Cc:     linux-kernel@vger.kernel.org, yu1.wang@intel.com,
        shuox.liu@gmail.com
Subject: Re: [PATCH v2 3/3] virt: acrn: Introduce interface to fetch platform
 info from the hypervisor
Message-ID: <YSinKyxJafvgatSM@kroah.com>
References: <20210825090142.4418-1-fei1.li@intel.com>
 <20210825090142.4418-4-fei1.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210825090142.4418-4-fei1.li@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 05:01:42PM +0800, Fei Li wrote:
> From: Shuo Liu <shuo.a.liu@intel.com>
> 
> The ACRN hypervisor configures the guest VMs information statically and
> builds guest VM configurations within the hypervisor. There are also
> some hardware information are stored in the hypervisor in boot stage.
> The ACRN userspace needs platform information to do the orchestration.
> 
> The HSM provides the following interface for the ACRN userspace to fetch
> platform info:
>  - ACRN_IOCTL_GET_PLATFORM_INFO
>    Exchange the basic information by a struct acrn_platform_info. If the
>    ACRN userspace provides a userspace buffer (whose vma filled in
>    vm_configs_addr), the HSM creates a bounce buffer (kmalloced for
>    continuous memory region) to fetch VM configurations data from the
>    hypervisor.
> 
> Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
> Signed-off-by: Fei Li <fei1.li@intel.com>
> ---
>  drivers/virt/acrn/hsm.c       | 53 +++++++++++++++++++++++++++++++++++
>  drivers/virt/acrn/hypercall.h | 12 ++++++++
>  include/uapi/linux/acrn.h     | 44 +++++++++++++++++++++++++++++
>  3 files changed, 109 insertions(+)
> 
> diff --git a/drivers/virt/acrn/hsm.c b/drivers/virt/acrn/hsm.c
> index 5419794fccf1..eb824a1a86a0 100644
> --- a/drivers/virt/acrn/hsm.c
> +++ b/drivers/virt/acrn/hsm.c
> @@ -108,6 +108,7 @@ static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
>  			   unsigned long ioctl_param)
>  {
>  	struct acrn_vm *vm = filp->private_data;
> +	struct acrn_platform_info *plat_info;
>  	struct acrn_vm_creation *vm_param;
>  	struct acrn_vcpu_regs *cpu_regs;
>  	struct acrn_ioreq_notify notify;
> @@ -115,9 +116,12 @@ static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
>  	struct acrn_ioeventfd ioeventfd;
>  	struct acrn_vm_memmap memmap;
>  	struct acrn_mmiodev *mmiodev;
> +	void __user *vm_configs_user;
>  	struct acrn_msi_entry *msi;
>  	struct acrn_pcidev *pcidev;
>  	struct acrn_irqfd irqfd;
> +	void *vm_configs = NULL;
> +	size_t vm_configs_size;
>  	struct acrn_vdev *vdev;
>  	struct page *page;
>  	u64 cstate_cmd;
> @@ -130,6 +134,55 @@ static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
>  	}
>  
>  	switch (cmd) {
> +	case ACRN_IOCTL_GET_PLATFORM_INFO:
> +		plat_info = memdup_user((void __user *)ioctl_param,
> +					sizeof(struct acrn_platform_info));
> +		if (IS_ERR(plat_info))
> +			return PTR_ERR(plat_info);
> +
> +		for (i = 0; i < ARRAY_SIZE(plat_info->sw.reserved); i++)
> +			if (plat_info->sw.reserved[i])
> +				return -EINVAL;
> +
> +		for (i = 0; i < ARRAY_SIZE(plat_info->hw.reserved); i++)
> +			if (plat_info->hw.reserved[i])
> +				return -EINVAL;
> +
> +		vm_configs_size = plat_info->sw.vm_config_size *
> +						plat_info->sw.max_vms;
> +		if (plat_info->sw.vm_configs_addr && vm_configs_size) {
> +			vm_configs_user = plat_info->sw.vm_configs_addr;
> +			vm_configs = kzalloc(vm_configs_size, GFP_KERNEL);
> +			if (IS_ERR(vm_configs)) {
> +				kfree(plat_info);
> +				return PTR_ERR(vm_configs);
> +			}
> +			plat_info->sw.vm_configs_addr =
> +					(void __user *)virt_to_phys(vm_configs);
> +		}
> +
> +		ret = hcall_get_platform_info(virt_to_phys(plat_info));
> +		if (ret < 0) {
> +			kfree(vm_configs);
> +			kfree(plat_info);
> +			dev_dbg(acrn_dev.this_device,
> +				"Failed to get info of VM %u!\n", vm->vmid);
> +			break;
> +		}
> +
> +		if (vm_configs) {
> +			if (copy_to_user(vm_configs_user, vm_configs,
> +					 vm_configs_size))
> +				ret = -EFAULT;
> +			plat_info->sw.vm_configs_addr = vm_configs_user;
> +		}
> +		if (!ret && copy_to_user((void __user *)ioctl_param, plat_info,
> +					 sizeof(*plat_info)))
> +			ret = -EFAULT;
> +
> +		kfree(vm_configs);
> +		kfree(plat_info);
> +		break;
>  	case ACRN_IOCTL_CREATE_VM:
>  		vm_param = memdup_user((void __user *)ioctl_param,
>  				       sizeof(struct acrn_vm_creation));
> diff --git a/drivers/virt/acrn/hypercall.h b/drivers/virt/acrn/hypercall.h
> index 71d300821a18..440e204d731a 100644
> --- a/drivers/virt/acrn/hypercall.h
> +++ b/drivers/virt/acrn/hypercall.h
> @@ -15,6 +15,7 @@
>  
>  #define HC_ID_GEN_BASE			0x0UL
>  #define HC_SOS_REMOVE_CPU		_HC_ID(HC_ID, HC_ID_GEN_BASE + 0x01)
> +#define HC_GET_PLATFORM_INFO		_HC_ID(HC_ID, HC_ID_GEN_BASE + 0x03)
>  
>  #define HC_ID_VM_BASE			0x10UL
>  #define HC_CREATE_VM			_HC_ID(HC_ID, HC_ID_VM_BASE + 0x00)
> @@ -60,6 +61,17 @@ static inline long hcall_sos_remove_cpu(u64 cpu)
>  	return acrn_hypercall1(HC_SOS_REMOVE_CPU, cpu);
>  }
>  
> +/**
> + * hcall_get_platform_info() - Get platform information from the hypervisor
> + * @platform_info: Service VM GPA of the &struct acrn_platform_info
> + *
> + * Return: 0 on success, <0 on failure
> + */
> +static inline long hcall_get_platform_info(u64 platform_info)
> +{
> +	return acrn_hypercall1(HC_GET_PLATFORM_INFO, platform_info);
> +}
> +
>  /**
>   * hcall_create_vm() - Create a User VM
>   * @vminfo:	Service VM GPA of info of User VM creation
> diff --git a/include/uapi/linux/acrn.h b/include/uapi/linux/acrn.h
> index 1408d1063339..2675d17bc803 100644
> --- a/include/uapi/linux/acrn.h
> +++ b/include/uapi/linux/acrn.h
> @@ -580,12 +580,56 @@ struct acrn_irqfd {
>  	struct acrn_msi_entry	msi;
>  };
>  
> +#define ACRN_PLATFORM_LAPIC_IDS_MAX	64
> +/**
> + * struct acrn_platform_info - Information of a platform from hypervisor
> + * @hw.cpu_num:			Physical CPU number of the platform
> + * @hw.version:			Version of this structure
> + * @hw.l2_cat_shift:		Order of the number of threads sharing L2 cache
> + * @hw.l3_cat_shift:		Order of the number of threads sharing L3 cache
> + * @hw.lapic_ids:		IDs of LAPICs of all threads
> + * @hw.reserved:		Reserved for alignment and should be 0

"must be"

> + * @sw.max_vcpus_per_vm:	Maximum number of vCPU of a VM
> + * @sw.max_vms:			Maximum number of VM
> + * @sw.vm_config_size:		Size of configuration of a VM
> + * @sw.vm_configss_addr:	Memory address which user space provided to
> + *				store the VM configurations
> + * @sw.max_kata_containers:	Maximum number of VM for Kata containers
> + * @sw.reserved:		Reserved for alignment and should be 0

"must be"

> + *
> + * If vm_configs_addr is provided, the driver uses a bounce buffer (kmalloced
> + * for continuous memory region) to fetch VM configurations data from the
> + * hypervisor.
> + */
> +struct acrn_platform_info {
> +	struct {
> +		__u16	cpu_num;
> +		__u16	version;
> +		__u32	l2_cat_shift;
> +		__u32	l3_cat_shift;
> +		__u8	lapic_ids[ACRN_PLATFORM_LAPIC_IDS_MAX];
> +		__u8	reserved[52];

These are huge buffer padding, why so large?

> +	} hw;
> +
> +	struct {
> +		__u16	max_vcpus_per_vm;
> +		__u16	max_vms;
> +		__u32	vm_config_size;
> +		void	__user *vm_configs_addr;

pointers do not work in ioctl structures, please fix.

thanks,

greg k-h
