Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5C93FC2CD
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 08:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235108AbhHaGch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 02:32:37 -0400
Received: from mga18.intel.com ([134.134.136.126]:65382 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234975AbhHaGcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 02:32:36 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10092"; a="205542902"
X-IronPort-AV: E=Sophos;i="5.84,365,1620716400"; 
   d="scan'208";a="205542902"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2021 23:31:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,365,1620716400"; 
   d="scan'208";a="687551616"
Received: from louislifei-optiplex-7050.sh.intel.com (HELO louislifei-OptiPlex-7050) ([10.239.154.151])
  by fmsmga006.fm.intel.com with ESMTP; 30 Aug 2021 23:31:39 -0700
Date:   Tue, 31 Aug 2021 14:32:15 +0800
From:   Li Fei1 <fei1.li@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, yu1.wang@intel.com,
        shuox.liu@gmail.com, fei1.li@intel.com
Subject: Re: [PATCH v2 2/3] virt: acrn: Introduce interfaces for virtual
 device creating/destroying
Message-ID: <20210831063215.GB8717@louislifei-OptiPlex-7050>
References: <20210825090142.4418-1-fei1.li@intel.com>
 <20210825090142.4418-3-fei1.li@intel.com>
 <YSimrfWz+p7Wf/nC@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSimrfWz+p7Wf/nC@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2021 at 10:47:41AM +0200, Greg KH wrote:
> On Wed, Aug 25, 2021 at 05:01:41PM +0800, Fei Li wrote:
> > From: Shuo Liu <shuo.a.liu@intel.com>
> > 
> > The ACRN hypervisor can emulate a virtual device within hypervisor for a
> > Guest VM. The emulated virtual device can work without the ACRN
> > userspace after creation. The hypervisor do the emulation of that device.
> > 
> > To support the virtual device creating/destroying, HSM provides the
> > following ioctls:
> >   - ACRN_IOCTL_CREATE_VDEV
> >     Pass data struct acrn_vdev from userspace to the hypervisor, and inform
> >     the hypervisor to create a virtual device for a User VM.
> >   - ACRN_IOCTL_DESTROY_VDEV
> >     Pass data struct acrn_vdev from userspace to the hypervisor, and inform
> >     the hypervisor to destroy a virtual device of a User VM.
> > 
> > Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
> > Signed-off-by: Fei Li <fei1.li@intel.com>
> > ---
> >  drivers/virt/acrn/hsm.c       | 24 ++++++++++++++++++++
> >  drivers/virt/acrn/hypercall.h | 26 ++++++++++++++++++++++
> >  include/uapi/linux/acrn.h     | 42 +++++++++++++++++++++++++++++++++++
> >  3 files changed, 92 insertions(+)
> > 
> > diff --git a/drivers/virt/acrn/hsm.c b/drivers/virt/acrn/hsm.c
> > index f567ca59d7c2..5419794fccf1 100644
> > --- a/drivers/virt/acrn/hsm.c
> > +++ b/drivers/virt/acrn/hsm.c
> > @@ -118,6 +118,7 @@ static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
> >  	struct acrn_msi_entry *msi;
> >  	struct acrn_pcidev *pcidev;
> >  	struct acrn_irqfd irqfd;
> > +	struct acrn_vdev *vdev;
> >  	struct page *page;
> >  	u64 cstate_cmd;
> >  	int i, ret = 0;
> > @@ -266,6 +267,29 @@ static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
> >  				"Failed to deassign pci device!\n");
> >  		kfree(pcidev);
> >  		break;
> > +	case ACRN_IOCTL_CREATE_VDEV:
> > +		vdev = memdup_user((void __user *)ioctl_param,
> > +				   sizeof(struct acrn_vdev));
> > +		if (IS_ERR(vdev))
> > +			return PTR_ERR(vdev);
> > +
> > +		ret = hcall_create_vdev(vm->vmid, virt_to_phys(vdev));
Hi Greg

> 
> No validation of the structure fields?

Service VM knows nothing about how to create these vdevs, it only needs to
pass through this structure to ACRN Hypervisor to let ACRN Hypervisor check it.
> 
> 
> > +		if (ret < 0)
> > +			dev_dbg(acrn_dev.this_device,
> > +				"Failed to create virtual device!\n");
> > +		kfree(vdev);
> > +		break;
> > +	case ACRN_IOCTL_DESTROY_VDEV:
> > +		vdev = memdup_user((void __user *)ioctl_param,
> > +				   sizeof(struct acrn_vdev));
> > +		if (IS_ERR(vdev))
> > +			return PTR_ERR(vdev);
> > +		ret = hcall_destroy_vdev(vm->vmid, virt_to_phys(vdev));
> 
> Again, no validation?

Service VM knows nothing about how to destroy these vdevs, it only needs to
pass through this structure to ACRN Hypervisor to let ACRN Hypervisor check it.

> 
> > +		if (ret < 0)
> > +			dev_dbg(acrn_dev.this_device,
> > +				"Failed to destroy virtual device!\n");
> > +		kfree(vdev);
> > +		break;
> >  	case ACRN_IOCTL_SET_PTDEV_INTR:
> >  		irq_info = memdup_user((void __user *)ioctl_param,
> >  				       sizeof(struct acrn_ptdev_irq));
> > diff --git a/drivers/virt/acrn/hypercall.h b/drivers/virt/acrn/hypercall.h
> > index f0c78e52cebb..71d300821a18 100644
> > --- a/drivers/virt/acrn/hypercall.h
> > +++ b/drivers/virt/acrn/hypercall.h
> > @@ -43,6 +43,8 @@
> >  #define HC_DEASSIGN_PCIDEV		_HC_ID(HC_ID, HC_ID_PCI_BASE + 0x06)
> >  #define HC_ASSIGN_MMIODEV		_HC_ID(HC_ID, HC_ID_PCI_BASE + 0x07)
> >  #define HC_DEASSIGN_MMIODEV		_HC_ID(HC_ID, HC_ID_PCI_BASE + 0x08)
> > +#define HC_CREATE_VDEV			_HC_ID(HC_ID, HC_ID_PCI_BASE + 0x09)
> > +#define HC_DESTROY_VDEV			_HC_ID(HC_ID, HC_ID_PCI_BASE + 0x0A)
> >  
> >  #define HC_ID_PM_BASE			0x80UL
> >  #define HC_PM_GET_CPU_STATE		_HC_ID(HC_ID, HC_ID_PM_BASE + 0x00)
> > @@ -196,6 +198,30 @@ static inline long hcall_set_memory_regions(u64 regions_pa)
> >  	return acrn_hypercall1(HC_VM_SET_MEMORY_REGIONS, regions_pa);
> >  }
> >  
> > +/**
> > + * hcall_create_vdev() - Create a virtual device for a User VM
> > + * @vmid:	User VM ID
> > + * @addr:	Service VM GPA of the &struct acrn_vdev
> > + *
> > + * Return: 0 on success, <0 on failure
> > + */
> > +static inline long hcall_create_vdev(u64 vmid, u64 addr)
> > +{
> > +	return acrn_hypercall2(HC_CREATE_VDEV, vmid, addr);
> > +}
> > +
> > +/**
> > + * hcall_destroy_vdev() - Destroy a virtual device of a User VM
> > + * @vmid:	User VM ID
> > + * @addr:	Service VM GPA of the &struct acrn_vdev
> > + *
> > + * Return: 0 on success, <0 on failure
> > + */
> > +static inline long hcall_destroy_vdev(u64 vmid, u64 addr)
> > +{
> > +	return acrn_hypercall2(HC_DESTROY_VDEV, vmid, addr);
> > +}
> > +
> >  /**
> >   * hcall_assign_mmiodev() - Assign a MMIO device to a User VM
> >   * @vmid:	User VM ID
> > diff --git a/include/uapi/linux/acrn.h b/include/uapi/linux/acrn.h
> > index 470036d6b1ac..1408d1063339 100644
> > --- a/include/uapi/linux/acrn.h
> > +++ b/include/uapi/linux/acrn.h
> > @@ -441,6 +441,44 @@ struct acrn_mmiodev {
> >  	} res[ACRN_MMIODEV_RES_NUM];
> >  };
> >  
> > +/**
> > + * struct acrn_vdev - Info for creating or destroying a virtual device
> > + * @id:				Union of identifier of the virtual device
> > + * @id.value:			Raw data of the identifier
> > + * @id.fields.vendor:		Vendor id of the virtual PCI device
> > + * @id.fields.device:		Device id of the virtual PCI device
> > + * @id.fields.legacy_id:	ID of the virtual device if not a PCI device
> > + * @slot:			Virtual Bus/Device/Function of the virtual
> > + *				device
> > + * @io_base:			IO resource base address of the virtual device
> > + * @io_size:			IO resource size of the virtual device
> > + * @args:			Arguments for the virtual device creation
> > + *
> > + * The created virtual device can be a PCI device or a legacy device (e.g.
> > + * a virtual UART controller) and it is emulated by the hypervisor. This
> > + * structure will be passed to hypervisor directly.
> > + */
> > +struct acrn_vdev {
> > +	/*
> > +	 * the identifier of the device, the low 32 bits represent the vendor
> > +	 * id and device id of PCI device and the high 32 bits represent the
> > +	 * device number of the legacy device
> > +	 */
> > +	union {
> > +		__u64 value;
> > +		struct {
> > +			__u16 vendor;
> > +			__u16 device;
> 
> Endian of these values?

little-endian or big-endian ?


> 
> > +			__u32 legacy_id;
> 
> What is "legacy"?  What types of devices?

A PCI device which under a PCI bridge.
> 
> 
> > +		} fields;
> > +	} id;
> > +
> > +	__u64	slot;
> > +	__u32	io_addr[ACRN_PCI_NUM_BARS];
> > +	__u32	io_size[ACRN_PCI_NUM_BARS];
> > +	__u8	args[128];
> 
> What are these args for exactly?
For different kinds of vdevs, it represents differently.
For current usages, it may be:
a) a vdev's name of a virtual PCI device which used to communicate between VMs
b) an index of virtual Uart
c) a structure to represent a virtual Root Port.


> 
> > +};
> > +
> >  /**
> >   * struct acrn_msi_entry - Info for injecting a MSI interrupt to a VM
> >   * @msi_addr:	MSI addr[19:12] with dest vCPU ID
> > @@ -596,6 +634,10 @@ struct acrn_irqfd {
> >  	_IOW(ACRN_IOCTL_TYPE, 0x57, struct acrn_mmiodev)
> >  #define ACRN_IOCTL_DEASSIGN_MMIODEV	\
> >  	_IOW(ACRN_IOCTL_TYPE, 0x58, struct acrn_mmiodev)
> > +#define ACRN_IOCTL_CREATE_VDEV	\
> > +	_IOW(ACRN_IOCTL_TYPE, 0x59, struct acrn_vdev)
> > +#define ACRN_IOCTL_DESTROY_VDEV	\
> > +	_IOW(ACRN_IOCTL_TYPE, 0x5A, struct acrn_vdev)
> 
> Why do you need the full structure to destroy the device?
We need the id field + other fields (optional, the slot or the args) to identify a vdev.

thanks.
> 
> thanks,
> 
> greg k-h
