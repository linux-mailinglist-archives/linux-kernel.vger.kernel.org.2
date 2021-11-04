Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51E2A444FAA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 08:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhKDH23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 03:28:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:37778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230119AbhKDH22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 03:28:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1E86B61108;
        Thu,  4 Nov 2021 07:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636010750;
        bh=jtwLvAVAz29Vwu2nF4zBO0gGHBnfHyZEXGHRp+OGjq0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CVqrwqMLP1RTg/gXPhTFHG598IW0Wcj/RmeMRePr0qksYJRFazmYb7ezVYuQ5Y2N6
         8tVLPItf/rd0m3jKw3nJsialkiau6PprLn/bO9zD7nuSt1wYGH0NqV65F7v4MKzcis
         40bguY4v8EExZCMWA+Qyp143T4r+sxbCmKYkmetQ=
Date:   Thu, 4 Nov 2021 08:25:47 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, reinette.chatre@intel.com,
        tony.luck@intel.com, nathaniel@profian.com,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org
Subject: Re: [PATCH v11 2/2] x86/sgx: Add an attribute for the amount of SGX
 memory in a NUMA node
Message-ID: <YYOK+7OREGsSDhEG@kroah.com>
References: <20211103012813.670195-1-jarkko@kernel.org>
 <20211103012813.670195-2-jarkko@kernel.org>
 <YYJGzgkLJs6819t8@kroah.com>
 <d3711ca7d612627bb891c10e20c3d569fa6f2bf3.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d3711ca7d612627bb891c10e20c3d569fa6f2bf3.camel@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2021 at 11:49:40PM +0200, Jarkko Sakkinen wrote:
> On Wed, 2021-11-03 at 09:22 +0100, Greg Kroah-Hartman wrote:
> > On Wed, Nov 03, 2021 at 03:28:13AM +0200, Jarkko Sakkinen wrote:
> > > The amount of SGX memory on the system is determined by the BIOS and it
> > > varies wildly between systems.� It can be from dozens of MB's on desktops
> > > or VM's, up to many GB's on servers.� Just like for regular memory, it is
> > > sometimes useful to know the amount of usable SGX memory in the system.
> > > 
> > > Introduce CONFIG_HAVE_ARCH_NODE_DEV_GROUP opt-in flag to expose an arch
> > > specific attribute group, and add an attribute for the amount of SGX
> > > memory in bytes to each NUMA node:
> > > 
> > > /sys/devices/system/node/nodeX/x86/sgx_total_bytes
> > > 
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > ---
> > > v11:
> > > * Fix documentation and the commit message.
> > > 
> > > v10:
> > > * Change DEVICE_ATTR_RO() to static (Greg K-H)
> > > * Change the attribute name as sgx_total_bytes, and attribute group
> > > � name as "x86" (Dave).
> > > * Add a new config flag HAVE_ARCH_NODE_DEV_GROUP to identify, whether
> > > � an arch exports arch specific attribute group for NUMA nodes.
> > > 
> > > v9:
> > > * Fix racy initialization of sysfs attributes:
> > > � https://lore.kernel.org/linux-sgx/YXOsx8SvFJV5R7lU@kroah.com/
> > > 
> > > v8:
> > > * Fix a bug in sgx_numa_init(): node->dev should be only set after
> > > � sysfe_create_group().� Otherwise, sysfs_remove_group() will issue a
> > > � warning in sgx_numa_exit(), when sgx_create_group() is unsuccessful,
> > > � because the group does not exist.
> > > 
> > > v7:
> > > * Shorten memory_size to size. The prefix makes the name only longer
> > > � but does not clarify things more than "size" would.
> > > * Use device_attribute instead of kobj_attribute.
> > > * Use named attribute group instead of creating raw kobject just for
> > > � the "sgx" subdirectory.
> > > 
> > > v6:
> > > * Initialize node->size to zero in sgx_setup_epc_section(), when the
> > > � node is first accessed.
> > > 
> > > v5
> > > * A new patch based on the discussion on
> > > � https://lore.kernel.org/linux-sgx/3a7cab4115b4f902f3509ad8652e616b91703e1d.camel@kernel.org/T/#t
> > > ---
> > > �Documentation/ABI/stable/sysfs-devices-node |� 6 ++++
> > > �arch/Kconfig������������������������������� |� 4 +++
> > > �arch/x86/Kconfig��������������������������� |� 1 +
> > > �arch/x86/kernel/cpu/sgx/main.c������������� | 31 +++++++++++++++++++++
> > > �arch/x86/kernel/cpu/sgx/sgx.h�������������� |� 2 ++
> > > �drivers/base/node.c������������������������ | 13 ++++++++-
> > > �include/linux/numa.h����������������������� |� 4 +++
> > > �7 files changed, 60 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/Documentation/ABI/stable/sysfs-devices-node b/Documentation/ABI/stable/sysfs-devices-node
> > > index 484fc04bcc25..8db67aa472f1 100644
> > > --- a/Documentation/ABI/stable/sysfs-devices-node
> > > +++ b/Documentation/ABI/stable/sysfs-devices-node
> > > @@ -176,3 +176,9 @@ Contact:����Keith Busch <keith.busch@intel.com>
> > > �Description:
> > > ����������������The cache write policy: 0 for write-back, 1 for write-through,
> > > ����������������other or unknown.
> > > +
> > > +What:����������/sys/devices/system/node/nodeX/x86/sgx_total_bytes
> > > +Date:����������November 2021
> > > +Contact:�������Jarkko Sakkinen <jarkko@kernel.org>
> > > +Description:
> > > +���������������The total amount of SGX physical memory in bytes.
> > > diff --git a/arch/Kconfig b/arch/Kconfig
> > > index 98db63496bab..ca5d75b5a427 100644
> > > --- a/arch/Kconfig
> > > +++ b/arch/Kconfig
> > > @@ -1285,6 +1285,10 @@ config ARCH_HAS_ELFCORE_COMPAT
> > > �config ARCH_HAS_PARANOID_L1D_FLUSH
> > > ��������bool
> > > �
> > > +# Select, if arch has a named attribute group bound to NUMA device nodes.
> > > +config HAVE_ARCH_NODE_DEV_GROUP
> > > +�������bool
> > > +
> > > �source "kernel/gcov/Kconfig"
> > > �
> > > �source "scripts/gcc-plugins/Kconfig"
> > > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > > index 421fa9e38c60..8503c3bdf63f 100644
> > > --- a/arch/x86/Kconfig
> > > +++ b/arch/x86/Kconfig
> > > @@ -266,6 +266,7 @@ config X86
> > > ��������select HAVE_ARCH_KCSAN������������������if X86_64
> > > ��������select X86_FEATURE_NAMES����������������if PROC_FS
> > > ��������select PROC_PID_ARCH_STATUS�������������if PROC_FS
> > > +�������select HAVE_ARCH_NODE_DEV_GROUP���������if X86_SGX
> > > ��������imply IMA_SECURE_AND_OR_TRUSTED_BOOT��� if EFI
> > > �
> > > �config INSTRUCTION_DECODER
> > > diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
> > > index a6e313f1a82d..02ebb233c511 100644
> > > --- a/arch/x86/kernel/cpu/sgx/main.c
> > > +++ b/arch/x86/kernel/cpu/sgx/main.c
> > > @@ -714,9 +714,12 @@ static bool __init sgx_page_cache_init(void)
> > > ������������������������spin_lock_init(&sgx_numa_nodes[nid].lock);
> > > ������������������������INIT_LIST_HEAD(&sgx_numa_nodes[nid].free_page_list);
> > > ������������������������node_set(nid, sgx_numa_mask);
> > > +�����������������������sgx_numa_nodes[nid].size = 0;
> > > ����������������}
> > > �
> > > ����������������sgx_epc_sections[i].node =� &sgx_numa_nodes[nid];
> > > +���������������sgx_numa_nodes[nid].dev = &node_devices[nid]->dev;
> > 
> > You are saving off a pointer to an object without incrementing the
> > reference count of it?� What prevents it from going away in the future?
> 
> Since the arch specific attribute group is part of the "groups" of that device,
> I'd presume that when sgx_total_bytes_show() is called the device has not gone
> away:
> 
> static const struct attribute_group *node_dev_groups[] = {
> 	&node_dev_group,
> #ifdef CONFIG_HAVE_ARCH_NODE_DEV_GROUP
> 	&arch_node_dev_group,
> #endif
> 	NULL,
> };

Yes, that is true for the dev pointer passed to your callback, but what
about the dev pointers in this random array you are looping over?

> I mean the "dev" parameter in sgx_total_bytes_show() is probably valid, when
> sysfs framework calls it, right?

Yes.

> > > +���������������sgx_numa_nodes[nid].size += size;
> > > �
> > > ����������������sgx_nr_epc_sections++;
> > > ��������}
> > > @@ -790,6 +793,34 @@ int sgx_set_attribute(unsigned long *allowed_attributes,
> > > �}
> > > �EXPORT_SYMBOL_GPL(sgx_set_attribute);
> > > �
> > > +#ifdef CONFIG_NUMA
> > > +static ssize_t sgx_total_bytes_show(struct device *dev, struct device_attribute *attr, char *buf)
> > > +{
> > > +�������unsigned long size = 0;
> > > +�������int nid;
> > > +
> > > +�������for (nid = 0; nid < num_possible_nodes(); nid++) {
> > > +���������������if (dev == sgx_numa_nodes[nid].dev) {
> > 
> > Why aren't these values all just part of the device that is being used
> > here?� You are walking some odd array, with no locking, and no reference
> > counting on the objects you are looking at, just to find the same object
> > that you started out with???
> 
> This code looks up the struct sgx_numa_node instance, and the array is
> indexed with NUMA node ID. "dev" is only used as lookup key.

And why isn't that pointer/key properly reference counted?

What happens when the memory numa node id goes away?  Who removes that
item from the list?

> > That's not the proper thing to do here at all, these values should be
> > part of the device structure that this attribute lives on, in order to
> > properly handle all of these reference counting and locking issues
> > automatically.
> 
> The attribute group is part of the device structure, so in that sense
> it is already like this. And I think that all NUMA node specific data
> (most of which is unrelated to device sysfs) is best kept in the private
> struct.

No, the data associated with a specific numa node needs to be IN the
structure that it belongs to, not in a random other data structure that
is not locked or reference counted at all.  That is not ok.

> > Please fix the design of this code first, _before_ adding new
> > attributes.
> 
> I sincerely think it is correct now.

I disagree.  Where is the locking and reference count logic that keeps
these different structures in sync properly?  Why are there different
structures at all?

Yes, you are just working with what you have now, but you have exposed
that what we have now is incorrect, and trying to use it in the manner
you are wanting to here is also incorrect.

thanks,

greg k-h
