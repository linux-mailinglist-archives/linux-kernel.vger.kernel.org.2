Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2157341D55C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 10:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349084AbhI3IZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 04:25:35 -0400
Received: from mga01.intel.com ([192.55.52.88]:12520 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348984AbhI3IZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 04:25:34 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10122"; a="247670126"
X-IronPort-AV: E=Sophos;i="5.85,335,1624345200"; 
   d="scan'208";a="247670126"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2021 01:23:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,335,1624345200"; 
   d="scan'208";a="520262214"
Received: from louislifei-optiplex-7050.sh.intel.com (HELO louislifei-OptiPlex-7050) ([10.239.154.151])
  by fmsmga008.fm.intel.com with ESMTP; 30 Sep 2021 01:23:50 -0700
Date:   Thu, 30 Sep 2021 16:24:29 +0800
From:   Li Fei1 <fei1.li@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, yu1.wang@intel.com,
        shuox.liu@gmail.com, fei1.li@intel.com
Subject: Re: [PATCH v5 2/2] virt: acrn: Introduce interfaces for virtual
 device creating/destroying
Message-ID: <20210930082429.GA6460@louislifei-OptiPlex-7050>
References: <20210923084128.18902-1-fei1.li@intel.com>
 <20210923084128.18902-3-fei1.li@intel.com>
 <YUxAHtGrYZ0n1Foa@kroah.com>
 <20210923091637.GA19102@louislifei-OptiPlex-7050>
 <YUx8GCInYRP9DcZS@kroah.com>
 <20210923152636.GA19873@louislifei-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210923152636.GA19873@louislifei-OptiPlex-7050>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 11:26:36PM +0800, Li, Fei1 wrote:
> On Thu, Sep 23, 2021 at 03:07:36PM +0200, Greg KH wrote:
> > On Thu, Sep 23, 2021 at 05:16:37PM +0800, Li Fei1 wrote:
> > > On Thu, Sep 23, 2021 at 10:51:42AM +0200, Greg KH wrote:
> > > > On Thu, Sep 23, 2021 at 04:41:28PM +0800, Fei Li wrote:
> > > > > From: Shuo Liu <shuo.a.liu@intel.com>
> > > > >
> > > > > The ACRN hypervisor can emulate a virtual device within hypervisor for a
> > > > > Guest VM. The emulated virtual device can work without the ACRN
> > > > > userspace after creation. The hypervisor do the emulation of that device.
> > > > >
> > > > > To support the virtual device creating/destroying, HSM provides the
> > > > > following ioctls:
> > > > >   - ACRN_IOCTL_CREATE_VDEV
> > > > >     Pass data struct acrn_vdev from userspace to the hypervisor, and inform
> > > > >     the hypervisor to create a virtual device for a User VM.
> > > > >   - ACRN_IOCTL_DESTROY_VDEV
> > > > >     Pass data struct acrn_vdev from userspace to the hypervisor, and inform
> > > > >     the hypervisor to destroy a virtual device of a User VM.
> > > > >
> > > > > These new APIs will be used by user space code vm_add_hv_vdev and
> > > > > vm_remove_hv_vdev in
> > > > > https://github.com/projectacrn/acrn-hypervisor/blob/master/devicemodel/core/vmmapi.c
> > > > >
> > > > > Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
> > > > > Signed-off-by: Fei Li <fei1.li@intel.com>
> > > > > ---
> > > > >  drivers/virt/acrn/hsm.c       | 24 ++++++++++++++++++++
> > > > >  drivers/virt/acrn/hypercall.h | 26 ++++++++++++++++++++++
> > > > >  include/uapi/linux/acrn.h     | 42 +++++++++++++++++++++++++++++++++++
> > > > >  3 files changed, 92 insertions(+)
> > > > >

Hi Greg

Any comments about my explanation ?

thanks a lot.

> > > > > diff --git a/drivers/virt/acrn/hsm.c b/drivers/virt/acrn/hsm.c
> > > > > index f567ca59d7c2..5419794fccf1 100644
> > > > > --- a/drivers/virt/acrn/hsm.c
> > > > > +++ b/drivers/virt/acrn/hsm.c
> > > > > @@ -118,6 +118,7 @@ static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
> > > > >  struct acrn_msi_entry *msi;
> > > > >  struct acrn_pcidev *pcidev;
> > > > >  struct acrn_irqfd irqfd;
> > > > > +struct acrn_vdev *vdev;
> > > > >  struct page *page;
> > > > >  u64 cstate_cmd;
> > > > >  int i, ret = 0;
> > > > > @@ -266,6 +267,29 @@ static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
> > > > >  "Failed to deassign pci device!\n");
> > > > >  kfree(pcidev);
> > > > >  break;
> > > > > +case ACRN_IOCTL_CREATE_VDEV:
> > > > > +vdev = memdup_user((void __user *)ioctl_param,
> > > > > +   sizeof(struct acrn_vdev));
> > > > > +if (IS_ERR(vdev))
> > > > > +return PTR_ERR(vdev);
> > > > > +
> > > > > +ret = hcall_create_vdev(vm->vmid, virt_to_phys(vdev));
> > > > > +if (ret < 0)
> > > > > +dev_dbg(acrn_dev.this_device,
> > > > > +"Failed to create virtual device!\n");
> > > > > +kfree(vdev);
> > > > > +break;
> > > > > +case ACRN_IOCTL_DESTROY_VDEV:
> > > > > +vdev = memdup_user((void __user *)ioctl_param,
> > > > > +   sizeof(struct acrn_vdev));
> > > > > +if (IS_ERR(vdev))
> > > > > +return PTR_ERR(vdev);
> > > > > +ret = hcall_destroy_vdev(vm->vmid, virt_to_phys(vdev));
> > > > > +if (ret < 0)
> > > > > +dev_dbg(acrn_dev.this_device,
> > > > > +"Failed to destroy virtual device!\n");
> > > > > +kfree(vdev);
> > > > > +break;
> > > > >  case ACRN_IOCTL_SET_PTDEV_INTR:
> > > > >  irq_info = memdup_user((void __user *)ioctl_param,
> > > > >         sizeof(struct acrn_ptdev_irq));
> > > > > diff --git a/drivers/virt/acrn/hypercall.h b/drivers/virt/acrn/hypercall.h
> > > > > index f0c78e52cebb..71d300821a18 100644
> > > > > --- a/drivers/virt/acrn/hypercall.h
> > > > > +++ b/drivers/virt/acrn/hypercall.h
> > > > > @@ -43,6 +43,8 @@
> > > > >  #define HC_DEASSIGN_PCIDEV_HC_ID(HC_ID, HC_ID_PCI_BASE + 0x06)
> > > > >  #define HC_ASSIGN_MMIODEV_HC_ID(HC_ID, HC_ID_PCI_BASE + 0x07)
> > > > >  #define HC_DEASSIGN_MMIODEV_HC_ID(HC_ID, HC_ID_PCI_BASE + 0x08)
> > > > > +#define HC_CREATE_VDEV_HC_ID(HC_ID, HC_ID_PCI_BASE + 0x09)
> > > > > +#define HC_DESTROY_VDEV_HC_ID(HC_ID, HC_ID_PCI_BASE + 0x0A)
> > > > >
> > > > >  #define HC_ID_PM_BASE0x80UL
> > > > >  #define HC_PM_GET_CPU_STATE_HC_ID(HC_ID, HC_ID_PM_BASE + 0x00)
> > > > > @@ -196,6 +198,30 @@ static inline long hcall_set_memory_regions(u64 regions_pa)
> > > > >  return acrn_hypercall1(HC_VM_SET_MEMORY_REGIONS, regions_pa);
> > > > >  }
> > > > >
> > > > > +/**
> > > > > + * hcall_create_vdev() - Create a virtual device for a User VM
> > > > > + * @vmid:User VM ID
> > > > > + * @addr:Service VM GPA of the &struct acrn_vdev
> > > > > + *
> > > > > + * Return: 0 on success, <0 on failure
> > > > > + */
> > > > > +static inline long hcall_create_vdev(u64 vmid, u64 addr)
> > > > > +{
> > > > > +return acrn_hypercall2(HC_CREATE_VDEV, vmid, addr);
> > > > > +}
> > > > > +
> > > > > +/**
> > > > > + * hcall_destroy_vdev() - Destroy a virtual device of a User VM
> > > > > + * @vmid:User VM ID
> > > > > + * @addr:Service VM GPA of the &struct acrn_vdev
> > > > > + *
> > > > > + * Return: 0 on success, <0 on failure
> > > > > + */
> > > > > +static inline long hcall_destroy_vdev(u64 vmid, u64 addr)
> > > > > +{
> > > > > +return acrn_hypercall2(HC_DESTROY_VDEV, vmid, addr);
> > > > > +}
> > > > > +
> > > > >  /**
> > > > >   * hcall_assign_mmiodev() - Assign a MMIO device to a User VM
> > > > >   * @vmid:User VM ID
> > > > > diff --git a/include/uapi/linux/acrn.h b/include/uapi/linux/acrn.h
> > > > > index 470036d6b1ac..ccf47ed92500 100644
> > > > > --- a/include/uapi/linux/acrn.h
> > > > > +++ b/include/uapi/linux/acrn.h
> > > > > @@ -441,6 +441,44 @@ struct acrn_mmiodev {
> > > > >  } res[ACRN_MMIODEV_RES_NUM];
> > > > >  };
> > > > >
> > > > > +/**
> > > > > + * struct acrn_vdev - Info for creating or destroying a virtual device
> > > > > + * @id:Union of identifier of the virtual device
> > > > > + * @id.value:Raw data of the identifier
> > > > > + * @id.fields.vendor:Vendor id of the virtual PCI device
> > > > > + * @id.fields.device:Device id of the virtual PCI device
> > > > > + * @id.fields.legacy_id:ID of the virtual device if not a PCI device
> > > > > + * @slot:Virtual Bus/Device/Function of the virtual
> > > > > + *device
> > > > > + * @io_base:IO resource base address of the virtual device
> > > > > + * @io_size:IO resource size of the virtual device
> > > > > + * @args:Arguments for the virtual device creation
> > > > > + *
> > > > > + * The created virtual device can be a PCI device or a legacy device (e.g.
> > > > > + * a virtual UART controller) and it is emulated by the hypervisor. This
> > > > > + * structure will be passed to hypervisor directly.
> > > > > + */
> > > > > +struct acrn_vdev {
> > > > > +/*
> > > > > + * the identifier of the device, the low 32 bits represent the vendor
> > > > > + * id and device id of PCI device and the high 32 bits represent the
> > > > > + * device number of the legacy device
> > > > > + */
> > > > > +union {
> > > > > +__u64 value;
> > > > > +struct {
> > > > > +__le16 vendor;
> > > > > +__le16 device;
> > > > > +__le32 legacy_id;
> > > > > +} fields;
> > > > > +} id;
> > > > > +
> > > > > +__u64slot;
> > > > > +__u32io_addr[ACRN_PCI_NUM_BARS];
> > > >
> > >
> > > Hi Greg
> > >
> > > > Why is an io address only 32 bits?
> > > >
> > >
> > > A PCI device could have six (ACRN_PCI_NUM_BARS) Base Address Registers,
> > > Base Address registers that map into Memory Space can be 32 bits or 64
> > > bits wide. Here doesn't mean this io address only is 32 bits.
> > > Two io_addr could be a 64 bits io_addr which depends on the
> > > Base Address Register Bits 3:0 Encoding.
> >
> > Where does that encoding show up and how is that expressed that you need
> > to merge multiple 32bit values into one 64bit value?
> 
> Hi Greg
> 
> For a virtual PCI device which used to communicate between VMs, you could refer to
> init_ivshmem_bar in
> https://github.com/lifeix/acrn-hypervisor/blob/master/hypervisor/dm/vpci/ivshmem.c#L287
> 
> For a PCI device, if the bit 0 of BAR is zero, it means this BAR is a MMIO BAR.
> And in this case, if the bit[2-1] is 10b, it means this BAR is a 64 bits MMIO BAR.
> This current BAR (assume its index is X) and the next BAR (which index is X+1) form
> a 64 bits MMIO BAR. You may refer to Chap 7.5.1.2.1 Base Address Registers, PCI Express® Base
> Specification Revision 5.0 Version 1.0 for detail.
> 
> >
> > > > And what endian is this?
> > >
> > > It's just an array which would be initialzied for index 0 to (ACRN_PCI_NUM_BARS - 1).
> > > So I think what's the endian of it doesn't matter.
> >
> > It's a 32bit number in some endian format :)
> >
> > I know you all are dealing with "little endian only", but this is a
> > user/kernel api that should be defined properly, right?
> Yes, but I'm confused when should I add the endian. IMHO, if I add the endian for this field,
> I need to add endian for each field of each data structure, right ?
> 
> >
> > > > > +__u32io_size[ACRN_PCI_NUM_BARS];
> > > >
> > > > Again, why only 32 bits?
> > >
> > > Here also doesn't mean the io_size is 32 bits. a 64 bits PCI BAR (Base Address Register)
> > > could use two io_size element.
> >
> > How?
> 
> If the current BAR is a 64 bits MMIO BAR, we need to combine two io_size into one io_size.
> Also, you may refer to Chap 7.5.1.2.1 Base Address Registers, PCI Express® Base Specification
> Revision 5.0 Version 1.0 for detail.
> 
> >
> > > > > +__u8args[128];
> > > >
> > > > Where are args defined?
> > >
> > > For different kinds of vdevs, it represents differently.
> > > For current usages, it may be:
> > > a) a vdev's name of a virtual PCI device which used to communicate between VMs
> > > b) an index of virtual Uart
> > > c) a structure to represent a virtual Root Port.
> >
> > So you are multiplexing this single structure into multiple ones
> > somehow?  Why not break these up and be explicit about the individual
> yes
> > commands happening here?  Is userspace supposed to create these bit
> just as you said, the linux kernel doesn't need to handle this data.
> it just needs to pass this data to hypervisor and the hypervisor to
> check whether this data is valid according to the id field in this data structure.
> > fields and somehow just pass them to the hypervisor properly?
> the userspace code only needs to copy this kind of data into args fields.
> Here is an example,
> https://github.com/lifeix/acrn-hypervisor/blob/master/devicemodel/hw/pci/ivshmem.c#L169
> >
> > I know you all are just treating the kernel as a dumb pipe here, and
> > that's fine, but you are adding new functions that have specific
> > formats, so why not break this up into the individual formats as well?
> ACRN hypervisor would do this work. The Linux kernel doesn't need to know
> what the data is and what does this data use for. And it doesn't need to
> know how to check this data. This also reduces the Linux kernel's workload
> and saves a lot of code. :-)
> 
> thanks.
> > Otherwise, why break any of them up?  :)
> >
> > thanks,
> >
> > greg k-h
