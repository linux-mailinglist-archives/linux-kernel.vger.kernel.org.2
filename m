Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8A18415F31
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 15:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241181AbhIWNJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 09:09:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:33188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241041AbhIWNJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 09:09:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8078C60F39;
        Thu, 23 Sep 2021 13:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632402459;
        bh=3nR3vmKNQS/ilWEWtvfr3rwGwD+o/tS/1KpCTDGtyhY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0H9aJbHvO8dfCcB0kpkNrua3SjhL8hnpU6Csw8ilFsal1qe72akfSDl3xbDlwWBNs
         zWtj00ftL/ru0/iLLZkIcKXQM6Y3bBQfjbigoFqLZrQtkDc1iGsKKeOW79I3nVlwLD
         abmVRVSP5XppbtMTuUQdQ7JfgI6fKPZiKKTtxDwM=
Date:   Thu, 23 Sep 2021 15:07:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Li Fei1 <fei1.li@intel.com>
Cc:     linux-kernel@vger.kernel.org, yu1.wang@intel.com,
        shuox.liu@gmail.com
Subject: Re: [PATCH v5 2/2] virt: acrn: Introduce interfaces for virtual
 device creating/destroying
Message-ID: <YUx8GCInYRP9DcZS@kroah.com>
References: <20210923084128.18902-1-fei1.li@intel.com>
 <20210923084128.18902-3-fei1.li@intel.com>
 <YUxAHtGrYZ0n1Foa@kroah.com>
 <20210923091637.GA19102@louislifei-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210923091637.GA19102@louislifei-OptiPlex-7050>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 05:16:37PM +0800, Li Fei1 wrote:
> On Thu, Sep 23, 2021 at 10:51:42AM +0200, Greg KH wrote:
> > On Thu, Sep 23, 2021 at 04:41:28PM +0800, Fei Li wrote:
> > > From: Shuo Liu <shuo.a.liu@intel.com>
> > > 
> > > The ACRN hypervisor can emulate a virtual device within hypervisor for a
> > > Guest VM. The emulated virtual device can work without the ACRN
> > > userspace after creation. The hypervisor do the emulation of that device.
> > > 
> > > To support the virtual device creating/destroying, HSM provides the
> > > following ioctls:
> > >   - ACRN_IOCTL_CREATE_VDEV
> > >     Pass data struct acrn_vdev from userspace to the hypervisor, and inform
> > >     the hypervisor to create a virtual device for a User VM.
> > >   - ACRN_IOCTL_DESTROY_VDEV
> > >     Pass data struct acrn_vdev from userspace to the hypervisor, and inform
> > >     the hypervisor to destroy a virtual device of a User VM.
> > > 
> > > These new APIs will be used by user space code vm_add_hv_vdev and
> > > vm_remove_hv_vdev in
> > > https://github.com/projectacrn/acrn-hypervisor/blob/master/devicemodel/core/vmmapi.c
> > > 
> > > Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
> > > Signed-off-by: Fei Li <fei1.li@intel.com>
> > > ---
> > >  drivers/virt/acrn/hsm.c       | 24 ++++++++++++++++++++
> > >  drivers/virt/acrn/hypercall.h | 26 ++++++++++++++++++++++
> > >  include/uapi/linux/acrn.h     | 42 +++++++++++++++++++++++++++++++++++
> > >  3 files changed, 92 insertions(+)
> > > 
> > > diff --git a/drivers/virt/acrn/hsm.c b/drivers/virt/acrn/hsm.c
> > > index f567ca59d7c2..5419794fccf1 100644
> > > --- a/drivers/virt/acrn/hsm.c
> > > +++ b/drivers/virt/acrn/hsm.c
> > > @@ -118,6 +118,7 @@ static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
> > >  	struct acrn_msi_entry *msi;
> > >  	struct acrn_pcidev *pcidev;
> > >  	struct acrn_irqfd irqfd;
> > > +	struct acrn_vdev *vdev;
> > >  	struct page *page;
> > >  	u64 cstate_cmd;
> > >  	int i, ret = 0;
> > > @@ -266,6 +267,29 @@ static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
> > >  				"Failed to deassign pci device!\n");
> > >  		kfree(pcidev);
> > >  		break;
> > > +	case ACRN_IOCTL_CREATE_VDEV:
> > > +		vdev = memdup_user((void __user *)ioctl_param,
> > > +				   sizeof(struct acrn_vdev));
> > > +		if (IS_ERR(vdev))
> > > +			return PTR_ERR(vdev);
> > > +
> > > +		ret = hcall_create_vdev(vm->vmid, virt_to_phys(vdev));
> > > +		if (ret < 0)
> > > +			dev_dbg(acrn_dev.this_device,
> > > +				"Failed to create virtual device!\n");
> > > +		kfree(vdev);
> > > +		break;
> > > +	case ACRN_IOCTL_DESTROY_VDEV:
> > > +		vdev = memdup_user((void __user *)ioctl_param,
> > > +				   sizeof(struct acrn_vdev));
> > > +		if (IS_ERR(vdev))
> > > +			return PTR_ERR(vdev);
> > > +		ret = hcall_destroy_vdev(vm->vmid, virt_to_phys(vdev));
> > > +		if (ret < 0)
> > > +			dev_dbg(acrn_dev.this_device,
> > > +				"Failed to destroy virtual device!\n");
> > > +		kfree(vdev);
> > > +		break;
> > >  	case ACRN_IOCTL_SET_PTDEV_INTR:
> > >  		irq_info = memdup_user((void __user *)ioctl_param,
> > >  				       sizeof(struct acrn_ptdev_irq));
> > > diff --git a/drivers/virt/acrn/hypercall.h b/drivers/virt/acrn/hypercall.h
> > > index f0c78e52cebb..71d300821a18 100644
> > > --- a/drivers/virt/acrn/hypercall.h
> > > +++ b/drivers/virt/acrn/hypercall.h
> > > @@ -43,6 +43,8 @@
> > >  #define HC_DEASSIGN_PCIDEV		_HC_ID(HC_ID, HC_ID_PCI_BASE + 0x06)
> > >  #define HC_ASSIGN_MMIODEV		_HC_ID(HC_ID, HC_ID_PCI_BASE + 0x07)
> > >  #define HC_DEASSIGN_MMIODEV		_HC_ID(HC_ID, HC_ID_PCI_BASE + 0x08)
> > > +#define HC_CREATE_VDEV			_HC_ID(HC_ID, HC_ID_PCI_BASE + 0x09)
> > > +#define HC_DESTROY_VDEV			_HC_ID(HC_ID, HC_ID_PCI_BASE + 0x0A)
> > >  
> > >  #define HC_ID_PM_BASE			0x80UL
> > >  #define HC_PM_GET_CPU_STATE		_HC_ID(HC_ID, HC_ID_PM_BASE + 0x00)
> > > @@ -196,6 +198,30 @@ static inline long hcall_set_memory_regions(u64 regions_pa)
> > >  	return acrn_hypercall1(HC_VM_SET_MEMORY_REGIONS, regions_pa);
> > >  }
> > >  
> > > +/**
> > > + * hcall_create_vdev() - Create a virtual device for a User VM
> > > + * @vmid:	User VM ID
> > > + * @addr:	Service VM GPA of the &struct acrn_vdev
> > > + *
> > > + * Return: 0 on success, <0 on failure
> > > + */
> > > +static inline long hcall_create_vdev(u64 vmid, u64 addr)
> > > +{
> > > +	return acrn_hypercall2(HC_CREATE_VDEV, vmid, addr);
> > > +}
> > > +
> > > +/**
> > > + * hcall_destroy_vdev() - Destroy a virtual device of a User VM
> > > + * @vmid:	User VM ID
> > > + * @addr:	Service VM GPA of the &struct acrn_vdev
> > > + *
> > > + * Return: 0 on success, <0 on failure
> > > + */
> > > +static inline long hcall_destroy_vdev(u64 vmid, u64 addr)
> > > +{
> > > +	return acrn_hypercall2(HC_DESTROY_VDEV, vmid, addr);
> > > +}
> > > +
> > >  /**
> > >   * hcall_assign_mmiodev() - Assign a MMIO device to a User VM
> > >   * @vmid:	User VM ID
> > > diff --git a/include/uapi/linux/acrn.h b/include/uapi/linux/acrn.h
> > > index 470036d6b1ac..ccf47ed92500 100644
> > > --- a/include/uapi/linux/acrn.h
> > > +++ b/include/uapi/linux/acrn.h
> > > @@ -441,6 +441,44 @@ struct acrn_mmiodev {
> > >  	} res[ACRN_MMIODEV_RES_NUM];
> > >  };
> > >  
> > > +/**
> > > + * struct acrn_vdev - Info for creating or destroying a virtual device
> > > + * @id:				Union of identifier of the virtual device
> > > + * @id.value:			Raw data of the identifier
> > > + * @id.fields.vendor:		Vendor id of the virtual PCI device
> > > + * @id.fields.device:		Device id of the virtual PCI device
> > > + * @id.fields.legacy_id:	ID of the virtual device if not a PCI device
> > > + * @slot:			Virtual Bus/Device/Function of the virtual
> > > + *				device
> > > + * @io_base:			IO resource base address of the virtual device
> > > + * @io_size:			IO resource size of the virtual device
> > > + * @args:			Arguments for the virtual device creation
> > > + *
> > > + * The created virtual device can be a PCI device or a legacy device (e.g.
> > > + * a virtual UART controller) and it is emulated by the hypervisor. This
> > > + * structure will be passed to hypervisor directly.
> > > + */
> > > +struct acrn_vdev {
> > > +	/*
> > > +	 * the identifier of the device, the low 32 bits represent the vendor
> > > +	 * id and device id of PCI device and the high 32 bits represent the
> > > +	 * device number of the legacy device
> > > +	 */
> > > +	union {
> > > +		__u64 value;
> > > +		struct {
> > > +			__le16 vendor;
> > > +			__le16 device;
> > > +			__le32 legacy_id;
> > > +		} fields;
> > > +	} id;
> > > +
> > > +	__u64	slot;
> > > +	__u32	io_addr[ACRN_PCI_NUM_BARS];
> > 
> 
> Hi Greg
> 
> > Why is an io address only 32 bits?
> > 
> 
> A PCI device could have six (ACRN_PCI_NUM_BARS) Base Address Registers,
> Base Address registers that map into Memory Space can be 32 bits or 64
> bits wide. Here doesn't mean this io address only is 32 bits.
> Two io_addr could be a 64 bits io_addr which depends on the
> Base Address Register Bits 3:0 Encoding.

Where does that encoding show up and how is that expressed that you need
to merge multiple 32bit values into one 64bit value?

> > And what endian is this?
> 
> It's just an array which would be initialzied for index 0 to (ACRN_PCI_NUM_BARS - 1).
> So I think what's the endian of it doesn't matter.

It's a 32bit number in some endian format :)

I know you all are dealing with "little endian only", but this is a
user/kernel api that should be defined properly, right?

> > > +	__u32	io_size[ACRN_PCI_NUM_BARS];
> > 
> > Again, why only 32 bits?
> 
> Here also doesn't mean the io_size is 32 bits. a 64 bits PCI BAR (Base Address Register)
> could use two io_size element.

How?

> > > +	__u8	args[128];
> > 
> > Where are args defined?
> 
> For different kinds of vdevs, it represents differently.
> For current usages, it may be:
> a) a vdev's name of a virtual PCI device which used to communicate between VMs
> b) an index of virtual Uart
> c) a structure to represent a virtual Root Port.

So you are multiplexing this single structure into multiple ones
somehow?  Why not break these up and be explicit about the individual
commands happening here?  Is userspace supposed to create these bit
fields and somehow just pass them to the hypervisor properly?

I know you all are just treating the kernel as a dumb pipe here, and
that's fine, but you are adding new functions that have specific
formats, so why not break this up into the individual formats as well?
Otherwise, why break any of them up?  :)

thanks,

greg k-h
