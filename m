Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E06C415A50
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 10:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240059AbhIWIxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 04:53:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:36718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239985AbhIWIxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 04:53:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 49AA761267;
        Thu, 23 Sep 2021 08:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632387105;
        bh=+PeMsGtcKn3a5+WcSxs6RkWSPiSeI1qrFwXZR9/jOjw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oA1d8BDbNLFTfuSYo8qZmgPhY3ucWteA14imo4JbBGuOKQmiBv/p7iic7CywzoF38
         wPJmDyOrP+cBxY0je90oc+D+JTYjAkMYel4FE6udlmoKf/B7O1vZPKbmOfs3lnnNj8
         byPbRpmARn/bso6K8xFf1BFc2NS9EKDKs06RxO2o=
Date:   Thu, 23 Sep 2021 10:51:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Fei Li <fei1.li@intel.com>
Cc:     linux-kernel@vger.kernel.org, yu1.wang@intel.com,
        shuox.liu@gmail.com
Subject: Re: [PATCH v5 2/2] virt: acrn: Introduce interfaces for virtual
 device creating/destroying
Message-ID: <YUxAHtGrYZ0n1Foa@kroah.com>
References: <20210923084128.18902-1-fei1.li@intel.com>
 <20210923084128.18902-3-fei1.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210923084128.18902-3-fei1.li@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 04:41:28PM +0800, Fei Li wrote:
> From: Shuo Liu <shuo.a.liu@intel.com>
> 
> The ACRN hypervisor can emulate a virtual device within hypervisor for a
> Guest VM. The emulated virtual device can work without the ACRN
> userspace after creation. The hypervisor do the emulation of that device.
> 
> To support the virtual device creating/destroying, HSM provides the
> following ioctls:
>   - ACRN_IOCTL_CREATE_VDEV
>     Pass data struct acrn_vdev from userspace to the hypervisor, and inform
>     the hypervisor to create a virtual device for a User VM.
>   - ACRN_IOCTL_DESTROY_VDEV
>     Pass data struct acrn_vdev from userspace to the hypervisor, and inform
>     the hypervisor to destroy a virtual device of a User VM.
> 
> These new APIs will be used by user space code vm_add_hv_vdev and
> vm_remove_hv_vdev in
> https://github.com/projectacrn/acrn-hypervisor/blob/master/devicemodel/core/vmmapi.c
> 
> Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
> Signed-off-by: Fei Li <fei1.li@intel.com>
> ---
>  drivers/virt/acrn/hsm.c       | 24 ++++++++++++++++++++
>  drivers/virt/acrn/hypercall.h | 26 ++++++++++++++++++++++
>  include/uapi/linux/acrn.h     | 42 +++++++++++++++++++++++++++++++++++
>  3 files changed, 92 insertions(+)
> 
> diff --git a/drivers/virt/acrn/hsm.c b/drivers/virt/acrn/hsm.c
> index f567ca59d7c2..5419794fccf1 100644
> --- a/drivers/virt/acrn/hsm.c
> +++ b/drivers/virt/acrn/hsm.c
> @@ -118,6 +118,7 @@ static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
>  	struct acrn_msi_entry *msi;
>  	struct acrn_pcidev *pcidev;
>  	struct acrn_irqfd irqfd;
> +	struct acrn_vdev *vdev;
>  	struct page *page;
>  	u64 cstate_cmd;
>  	int i, ret = 0;
> @@ -266,6 +267,29 @@ static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
>  				"Failed to deassign pci device!\n");
>  		kfree(pcidev);
>  		break;
> +	case ACRN_IOCTL_CREATE_VDEV:
> +		vdev = memdup_user((void __user *)ioctl_param,
> +				   sizeof(struct acrn_vdev));
> +		if (IS_ERR(vdev))
> +			return PTR_ERR(vdev);
> +
> +		ret = hcall_create_vdev(vm->vmid, virt_to_phys(vdev));
> +		if (ret < 0)
> +			dev_dbg(acrn_dev.this_device,
> +				"Failed to create virtual device!\n");
> +		kfree(vdev);
> +		break;
> +	case ACRN_IOCTL_DESTROY_VDEV:
> +		vdev = memdup_user((void __user *)ioctl_param,
> +				   sizeof(struct acrn_vdev));
> +		if (IS_ERR(vdev))
> +			return PTR_ERR(vdev);
> +		ret = hcall_destroy_vdev(vm->vmid, virt_to_phys(vdev));
> +		if (ret < 0)
> +			dev_dbg(acrn_dev.this_device,
> +				"Failed to destroy virtual device!\n");
> +		kfree(vdev);
> +		break;
>  	case ACRN_IOCTL_SET_PTDEV_INTR:
>  		irq_info = memdup_user((void __user *)ioctl_param,
>  				       sizeof(struct acrn_ptdev_irq));
> diff --git a/drivers/virt/acrn/hypercall.h b/drivers/virt/acrn/hypercall.h
> index f0c78e52cebb..71d300821a18 100644
> --- a/drivers/virt/acrn/hypercall.h
> +++ b/drivers/virt/acrn/hypercall.h
> @@ -43,6 +43,8 @@
>  #define HC_DEASSIGN_PCIDEV		_HC_ID(HC_ID, HC_ID_PCI_BASE + 0x06)
>  #define HC_ASSIGN_MMIODEV		_HC_ID(HC_ID, HC_ID_PCI_BASE + 0x07)
>  #define HC_DEASSIGN_MMIODEV		_HC_ID(HC_ID, HC_ID_PCI_BASE + 0x08)
> +#define HC_CREATE_VDEV			_HC_ID(HC_ID, HC_ID_PCI_BASE + 0x09)
> +#define HC_DESTROY_VDEV			_HC_ID(HC_ID, HC_ID_PCI_BASE + 0x0A)
>  
>  #define HC_ID_PM_BASE			0x80UL
>  #define HC_PM_GET_CPU_STATE		_HC_ID(HC_ID, HC_ID_PM_BASE + 0x00)
> @@ -196,6 +198,30 @@ static inline long hcall_set_memory_regions(u64 regions_pa)
>  	return acrn_hypercall1(HC_VM_SET_MEMORY_REGIONS, regions_pa);
>  }
>  
> +/**
> + * hcall_create_vdev() - Create a virtual device for a User VM
> + * @vmid:	User VM ID
> + * @addr:	Service VM GPA of the &struct acrn_vdev
> + *
> + * Return: 0 on success, <0 on failure
> + */
> +static inline long hcall_create_vdev(u64 vmid, u64 addr)
> +{
> +	return acrn_hypercall2(HC_CREATE_VDEV, vmid, addr);
> +}
> +
> +/**
> + * hcall_destroy_vdev() - Destroy a virtual device of a User VM
> + * @vmid:	User VM ID
> + * @addr:	Service VM GPA of the &struct acrn_vdev
> + *
> + * Return: 0 on success, <0 on failure
> + */
> +static inline long hcall_destroy_vdev(u64 vmid, u64 addr)
> +{
> +	return acrn_hypercall2(HC_DESTROY_VDEV, vmid, addr);
> +}
> +
>  /**
>   * hcall_assign_mmiodev() - Assign a MMIO device to a User VM
>   * @vmid:	User VM ID
> diff --git a/include/uapi/linux/acrn.h b/include/uapi/linux/acrn.h
> index 470036d6b1ac..ccf47ed92500 100644
> --- a/include/uapi/linux/acrn.h
> +++ b/include/uapi/linux/acrn.h
> @@ -441,6 +441,44 @@ struct acrn_mmiodev {
>  	} res[ACRN_MMIODEV_RES_NUM];
>  };
>  
> +/**
> + * struct acrn_vdev - Info for creating or destroying a virtual device
> + * @id:				Union of identifier of the virtual device
> + * @id.value:			Raw data of the identifier
> + * @id.fields.vendor:		Vendor id of the virtual PCI device
> + * @id.fields.device:		Device id of the virtual PCI device
> + * @id.fields.legacy_id:	ID of the virtual device if not a PCI device
> + * @slot:			Virtual Bus/Device/Function of the virtual
> + *				device
> + * @io_base:			IO resource base address of the virtual device
> + * @io_size:			IO resource size of the virtual device
> + * @args:			Arguments for the virtual device creation
> + *
> + * The created virtual device can be a PCI device or a legacy device (e.g.
> + * a virtual UART controller) and it is emulated by the hypervisor. This
> + * structure will be passed to hypervisor directly.
> + */
> +struct acrn_vdev {
> +	/*
> +	 * the identifier of the device, the low 32 bits represent the vendor
> +	 * id and device id of PCI device and the high 32 bits represent the
> +	 * device number of the legacy device
> +	 */
> +	union {
> +		__u64 value;
> +		struct {
> +			__le16 vendor;
> +			__le16 device;
> +			__le32 legacy_id;
> +		} fields;
> +	} id;
> +
> +	__u64	slot;
> +	__u32	io_addr[ACRN_PCI_NUM_BARS];

Why is an io address only 32 bits?

And what endian is this?

> +	__u32	io_size[ACRN_PCI_NUM_BARS];

Again, why only 32 bits?

> +	__u8	args[128];

Where are args defined?

thanks,

greg k-h
