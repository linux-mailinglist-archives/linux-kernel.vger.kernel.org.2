Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC1632714F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Feb 2021 07:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhB1GoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 01:44:09 -0500
Received: from mga09.intel.com ([134.134.136.24]:58906 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230466AbhB1Gn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 01:43:27 -0500
IronPort-SDR: iTx8qochyhzy5yrqN8wXYu2oisRICHtEv2TR+QA29ScyC4pH5iCMiKUPdRE9EfjT74JTWY2AsQ
 pudwX6FO6Z2g==
X-IronPort-AV: E=McAfee;i="6000,8403,9908"; a="186323920"
X-IronPort-AV: E=Sophos;i="5.81,211,1610438400"; 
   d="scan'208";a="186323920"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2021 22:33:10 -0800
IronPort-SDR: tbRZKK+vUMEdRufM6ZrxaDYyvvFN15WVuP4e9FL0GklsqCy35097fCgWmhpVEXYeITP4V1RJIj
 AHXAulb/mgQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,211,1610438400"; 
   d="scan'208";a="517029749"
Received: from otc-wp-03.jf.intel.com ([10.54.39.79])
  by orsmga004.jf.intel.com with ESMTP; 27 Feb 2021 22:33:10 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org, cgroups@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        Wu Hao <hao.wu@intel.com>, Dave Jiang <dave.jiang@intel.com>
Subject: [RFC PATCH 18/18] ioasid: Add /dev/ioasid for userspace
Date:   Sat, 27 Feb 2021 14:01:26 -0800
Message-Id: <1614463286-97618-19-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liu Yi L <yi.l.liu@intel.com>

I/O Address Space IDs (IOASIDs) is used to tag DMA requests to target
multiple DMA address spaces for physical devices. Its PCI terminology
is called PASID (Process Address Space ID). Platforms with PASID support
can provide PASID granularity DMA isolation, which is very useful for
efficient and secure device sharing (SVA, subdevice passthrough, etc.).

Today only kernel drivers are allowed to allocate IOASIDs [1]. This patch
aims to extend this capability to userspace as required in device pass-
through scenarios. For example, a userspace driver may want to create its
own DMA address spaces besides the default IOVA address space established
by the kernel on the assigned device (e.g. vDPA control vq [2] and guest
SVA [3]), thus need to get IOASIDs from the kernel IOASID allocator for
tagging. In concept, each device can have its own IOASID space, thus it's
also possible for userspace driver to manage a private IOASID space itself,
say, when PF/VF is assigned. However it doesn't work for subdevice pass-
through, as multiple subdevices under the same parent device share a single
IOASID space thus IOASIDs must be centrally managed by the kernel in such
case.

This patch introduces a /dev/ioasid interface for this purpose (per discussion
in [4]). An IOASID is just a number before it is tagged to a specific DMA
address space. The actual IOASID tagging (to DMA requests) and association
(with DMA address spaces) operations from userspace are scrutinized by specific
device passthrough frameworks, which must ensure that a malicious driver
cannot program arbitrary IOASIDs to its assigned device to access DMA address
spaces that don't belong to it, this is out of the scope of this patch (a
reference VFIO implementation will be posted soon).

Open:

PCIe PASID is 20bit implying a space with 1M IOASIDs. although it's plenty
there was an open [4] on whether this user interface is open to all processes
or only selective processes (e.g. with device assigned). In this patchseries,
a cgroup controller is introduced to manage IOASID quota that a process is
allowed to use. A cgroup-enabled system may by default set quota=0 to disallow
IOASID allocation for most processes, and then having the virt management
stack to adjust the quota for a process which gets device assigned. But yeah,
we are also willing to hear more suggestions.

[1] https://lore.kernel.org/linux-iommu/1565900005-62508-8-git-send-email-jacob.jun.pan@linux.intel.com/
[2] https://lore.kernel.org/kvm/20201216064818.48239-1-jasowang@redhat.com/
[3] https://lore.kernel.org/linux-iommu/1599734733-6431-1-git-send-email-yi.l.liu@intel.com/
[4] https://lore.kernel.org/kvm/20201014171055.328a52f4@w520.home/

Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
---
 Documentation/userspace-api/index.rst  |   1 +
 Documentation/userspace-api/ioasid.rst |  49 ++++
 drivers/iommu/Kconfig                  |   5 +
 drivers/iommu/Makefile                 |   1 +
 drivers/iommu/intel/Kconfig            |   1 +
 drivers/iommu/ioasid_user.c            | 297 +++++++++++++++++++++++++
 include/linux/ioasid.h                 |  26 +++
 include/linux/miscdevice.h             |   1 +
 include/uapi/linux/ioasid.h            |  98 ++++++++
 9 files changed, 479 insertions(+)
 create mode 100644 Documentation/userspace-api/ioasid.rst
 create mode 100644 drivers/iommu/ioasid_user.c
 create mode 100644 include/uapi/linux/ioasid.h

diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
index acd2cc2a538d..69e1be7c67ee 100644
--- a/Documentation/userspace-api/index.rst
+++ b/Documentation/userspace-api/index.rst
@@ -24,6 +24,7 @@ place where this information is gathered.
    ioctl/index
    iommu
    media/index
+   ioasid
 
 .. only::  subproject and html
 
diff --git a/Documentation/userspace-api/ioasid.rst b/Documentation/userspace-api/ioasid.rst
new file mode 100644
index 000000000000..879d6cbae858
--- /dev/null
+++ b/Documentation/userspace-api/ioasid.rst
@@ -0,0 +1,49 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. ioasid:
+
+=====================================
+IOASID Userspace API
+=====================================
+
+The IOASID UAPI is used for userspace IOASID allocation/free requests,
+thus IOASID management is centralized in the IOASID core[1] in the kernel. The
+primary use case is guest Shared Virtual Address (SVA) today.
+
+Requests such as allocation/free can be issued by the users and managed
+on a per-process basis through the ioasid core. Upon opening ("/dev/ioasid"),
+a process obtains a unique handle associated with the process's mm_struct.
+This handle is mapped to an FD in the userspace. Only a single open is
+allowed per process.
+
+File descriptors can be transferred across processes by employing fork() or
+UNIX domain socket. FDs obtained by transfer cannot be used to perform
+IOASID requests. The following behaviors are recommended for the
+applications:
+
+ - forked children close the parent's IOASID FDs immediately, open new
+   /dev/ioasid FDs if IOASID allocation is desired
+
+ - do not share FDs via UNIX domain socket, e.g. via sendmsg
+
+================
+Userspace APIs
+================
+
+/dev/ioasid provides below ioctls:
+
+*) IOASID_GET_API_VERSION: returns the API version, userspace should check
+   the API version first with the one it has embedded.
+*) IOASID_GET_INFO: returns the information on the /dev/ioasid.
+   - ioasid_bits: the ioasid bit width supported by this uAPI, userspace
+     should check the ioasid_bits returned by this ioctl with the ioasid
+     bits it wants and should fail if it's smaller than the one that
+     userspace wants, otherwise, allocation will be failed.
+*) IOASID_REQUEST_ALLOC: returns an IOASID which is allocated in kernel within
+   the specified ioasid range.
+*) IOASID_REQUEST_FREE: free an IOASID per userspace's request.
+
+For detailed definition, please see include/uapi/linux/ioasid.h.
+
+.. contents:: :local:
+
+[1] Documentation/driver-api/ioasid.rst
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 192ef8f61310..830f4ec28a16 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -7,6 +7,11 @@ config IOMMU_IOVA
 config IOASID
 	tristate
 
+config IOASID_USER
+	tristate
+	depends on IOASID
+	default n
+
 # IOMMU_API always gets selected by whoever wants it.
 config IOMMU_API
 	bool
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 61bd30cd8369..305dd019ff49 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_IOMMU_IO_PGTABLE) += io-pgtable.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_ARMV7S) += io-pgtable-arm-v7s.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE) += io-pgtable-arm.o
 obj-$(CONFIG_IOASID) += ioasid.o
+obj-$(CONFIG_IOASID_USER) += ioasid_user.o
 obj-$(CONFIG_IOMMU_IOVA) += iova.o
 obj-$(CONFIG_OF_IOMMU)	+= of_iommu.o
 obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o
diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
index 28a3d1596c76..a6d9dea61d58 100644
--- a/drivers/iommu/intel/Kconfig
+++ b/drivers/iommu/intel/Kconfig
@@ -13,6 +13,7 @@ config INTEL_IOMMU
 	select DMAR_TABLE
 	select SWIOTLB
 	select IOASID
+	select IOASID_USER
 	select IOMMU_DMA
 	help
 	  DMA remapping (DMAR) devices support enables independent address
diff --git a/drivers/iommu/ioasid_user.c b/drivers/iommu/ioasid_user.c
new file mode 100644
index 000000000000..2f8957cd055a
--- /dev/null
+++ b/drivers/iommu/ioasid_user.c
@@ -0,0 +1,297 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Support IOASID allocation/free from user space.
+ *
+ * Copyright (C) 2021 Intel Corporation.
+ *     Author: Liu Yi L <yi.l.liu@intel.com>
+ *
+ */
+
+#include <linux/ioasid.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/sched/mm.h>
+#include <linux/miscdevice.h>
+
+#define DRIVER_VERSION  "0.1"
+#define DRIVER_AUTHOR   "Liu Yi L <yi.l.liu@intel.com>"
+#define DRIVER_DESC     "IOASID management for user space"
+
+/* Current user ioasid uapi supports 31 bits */
+#define IOASID_BITS	31
+
+struct ioasid_user_token {
+	unsigned long long val;
+};
+
+struct ioasid_user {
+	struct kref		kref;
+	struct ioasid_set	*ioasid_set;
+	struct mutex		lock;
+	struct list_head	next;
+	struct ioasid_user_token	token;
+};
+
+static struct mutex		ioasid_user_lock;
+static struct list_head		ioasid_user_list;
+
+/* called with ioasid_user_lock held */
+static void ioasid_user_release(struct kref *kref)
+{
+	struct ioasid_user *iuser = container_of(kref, struct ioasid_user, kref);
+
+	ioasid_free_all_in_set(iuser->ioasid_set);
+	list_del(&iuser->next);
+	mutex_unlock(&ioasid_user_lock);
+	ioasid_set_free(iuser->ioasid_set);
+	kfree(iuser);
+}
+
+void ioasid_user_put(struct ioasid_user *iuser)
+{
+	kref_put_mutex(&iuser->kref, ioasid_user_release, &ioasid_user_lock);
+}
+EXPORT_SYMBOL_GPL(ioasid_user_put);
+
+static void ioasid_user_get(struct ioasid_user *iuser)
+{
+	kref_get(&iuser->kref);
+}
+
+struct ioasid_user *ioasid_user_get_from_task(struct task_struct *task)
+{
+	struct mm_struct *mm = get_task_mm(task);
+	unsigned long long val = (unsigned long long)mm;
+	struct ioasid_user *iuser;
+	bool found = false;
+
+	if (!mm)
+		return NULL;
+
+	mutex_lock(&ioasid_user_lock);
+	/* Search existing ioasid_user with current mm pointer */
+	list_for_each_entry(iuser, &ioasid_user_list, next) {
+		if (iuser->token.val == val) {
+			ioasid_user_get(iuser);
+			found = true;
+			break;
+		}
+	}
+
+	mmput(mm);
+
+	mutex_unlock(&ioasid_user_lock);
+	return found ? iuser : NULL;
+}
+EXPORT_SYMBOL_GPL(ioasid_user_get_from_task);
+
+void ioasid_user_for_each_id(struct ioasid_user *iuser, void *data,
+			    void (*fn)(ioasid_t id, void *data))
+{
+	mutex_lock(&iuser->lock);
+	ioasid_set_for_each_ioasid(iuser->ioasid_set, fn, data);
+	mutex_unlock(&iuser->lock);
+}
+EXPORT_SYMBOL_GPL(ioasid_user_for_each_id);
+
+static int ioasid_fops_open(struct inode *inode, struct file *filep)
+{
+	struct mm_struct *mm = get_task_mm(current);
+	unsigned long long val = (unsigned long long)mm;
+	struct ioasid_set *iset;
+	struct ioasid_user *iuser;
+	int ret = 0;
+
+	mutex_lock(&ioasid_user_lock);
+	/* Only allow one single open per process */
+	list_for_each_entry(iuser, &ioasid_user_list, next) {
+		if (iuser->token.val == val) {
+			ret = -EBUSY;
+			goto out;
+		}
+	}
+
+	iuser = kzalloc(sizeof(*iuser), GFP_KERNEL);
+	if (!iuser) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	/*
+	 * IOASID core provides a 'IOASID set' concept to track all
+	 * IOASIDs associated with a token. Here we use mm_struct as
+	 * the token and create a IOASID set per mm_struct. All the
+	 * containers of the process share the same IOASID set.
+	 */
+	iset = ioasid_set_alloc(mm, 0, IOASID_SET_TYPE_MM);
+	if (IS_ERR(iset)) {
+		kfree(iuser);
+		ret = PTR_ERR(iset);
+		goto out;
+	}
+
+	iuser->ioasid_set = iset;
+	kref_init(&iuser->kref);
+	iuser->token.val = val;
+	mutex_init(&iuser->lock);
+	filep->private_data = iuser;
+
+	list_add(&iuser->next, &ioasid_user_list);
+out:
+	mutex_unlock(&ioasid_user_lock);
+	mmput(mm);
+	return ret;
+}
+
+static int ioasid_fops_release(struct inode *inode, struct file *filep)
+{
+	struct ioasid_user *iuser = filep->private_data;
+
+	filep->private_data = NULL;
+
+	ioasid_user_put(iuser);
+
+	return 0;
+}
+
+static int ioasid_get_info(struct ioasid_user *iuser, unsigned long arg)
+{
+	struct ioasid_info info;
+	unsigned long minsz;
+
+	minsz = offsetofend(struct ioasid_info, ioasid_bits);
+
+	if (copy_from_user(&info, (void __user *)arg, minsz))
+		return -EFAULT;
+
+	if (info.argsz < minsz || info.flags)
+		return -EINVAL;
+
+	info.ioasid_bits = IOASID_BITS;
+
+	return copy_to_user((void __user *)arg, &info, minsz) ? -EFAULT : 0;
+}
+
+static int ioasid_alloc_request(struct ioasid_user *iuser, unsigned long arg)
+{
+	struct ioasid_alloc_request req;
+	unsigned long minsz;
+	ioasid_t ioasid;
+
+	minsz = offsetofend(struct ioasid_alloc_request, range);
+
+	if (copy_from_user(&req, (void __user *)arg, minsz))
+		return -EFAULT;
+
+	if (req.argsz < minsz || req.flags)
+		return -EINVAL;
+
+	if (req.range.min > req.range.max ||
+	    req.range.min >= (1 << IOASID_BITS) ||
+	    req.range.max >= (1 << IOASID_BITS))
+		return -EINVAL;
+
+	ioasid = ioasid_alloc(iuser->ioasid_set, req.range.min,
+			    req.range.max, NULL);
+
+	if (ioasid == INVALID_IOASID)
+		return -EINVAL;
+
+	return ioasid;
+
+}
+
+static int ioasid_free_request(struct ioasid_user *iuser, unsigned long arg)
+{
+	int ioasid;
+
+	if (copy_from_user(&ioasid, (void __user *)arg, sizeof(ioasid)))
+		return -EFAULT;
+
+	if (ioasid < 0)
+		return -EINVAL;
+
+	ioasid_free(iuser->ioasid_set, ioasid);
+
+	return 0;
+}
+
+static long ioasid_fops_unl_ioctl(struct file *filep,
+				  unsigned int cmd, unsigned long arg)
+{
+	struct ioasid_user *iuser = filep->private_data;
+	long ret = -EINVAL;
+
+	if (!iuser)
+		return ret;
+
+	mutex_lock(&iuser->lock);
+
+	switch (cmd) {
+	case IOASID_GET_API_VERSION:
+		ret = IOASID_API_VERSION;
+		break;
+	case IOASID_GET_INFO:
+		ret = ioasid_get_info(iuser, arg);
+		break;
+	case IOASID_REQUEST_ALLOC:
+		ret = ioasid_alloc_request(iuser, arg);
+		break;
+	case IOASID_REQUEST_FREE:
+		ret = ioasid_free_request(iuser, arg);
+		break;
+	default:
+		pr_err("Unsupported cmd %u\n", cmd);
+		break;
+	}
+
+	mutex_unlock(&iuser->lock);
+	return ret;
+}
+
+static const struct file_operations ioasid_user_fops = {
+	.owner		= THIS_MODULE,
+	.open		= ioasid_fops_open,
+	.release	= ioasid_fops_release,
+	.unlocked_ioctl	= ioasid_fops_unl_ioctl,
+};
+
+static struct miscdevice ioasid_user = {
+	.minor = IOASID_MINOR,
+	.name = "ioasid_user",
+	.fops = &ioasid_user_fops,
+	.nodename = "ioasid",
+	.mode = S_IRUGO | S_IWUGO,
+};
+
+
+static int __init ioasid_user_init(void)
+{
+	int ret;
+
+	ret = misc_register(&ioasid_user);
+	if (ret) {
+		pr_err("ioasid_user: misc device register failed\n");
+		return ret;
+	}
+
+	mutex_init(&ioasid_user_lock);
+	INIT_LIST_HEAD(&ioasid_user_list);
+	return 0;
+}
+
+static void __exit ioasid_user_exit(void)
+{
+	WARN_ON(!list_empty(&ioasid_user_list));
+	misc_deregister(&ioasid_user);
+}
+
+module_init(ioasid_user_init);
+module_exit(ioasid_user_exit);
+
+MODULE_VERSION(DRIVER_VERSION);
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR(DRIVER_AUTHOR);
+MODULE_DESCRIPTION(DRIVER_DESC);
diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
index 5ea4710efb02..b82abe6325f7 100644
--- a/include/linux/ioasid.h
+++ b/include/linux/ioasid.h
@@ -6,6 +6,7 @@
 #include <linux/errno.h>
 #include <linux/xarray.h>
 #include <linux/refcount.h>
+#include <uapi/linux/ioasid.h>
 
 #define INVALID_IOASID ((ioasid_t)-1)
 typedef unsigned int ioasid_t;
@@ -152,6 +153,31 @@ static inline int ioasid_cg_uncharge(struct ioasid_set *set)
 #endif /* CGROUP_IOASIDS */
 bool ioasid_queue_work(struct work_struct *work);
 
+/* IOASID userspace support */
+struct ioasid_user;
+#if IS_ENABLED(CONFIG_IOASID_USER)
+extern struct ioasid_user *ioasid_user_get_from_task(struct task_struct *task);
+extern void ioasid_user_put(struct ioasid_user *iuser);
+extern void ioasid_user_for_each_id(struct ioasid_user *iuser, void *data,
+				   void (*fn)(ioasid_t id, void *data));
+
+#else /* CONFIG_IOASID_USER */
+static inline struct ioasid_user *
+ioasid_user_get_from_task(struct task_struct *task)
+{
+	return ERR_PTR(-ENOTTY);
+}
+
+static inline void ioasid_user_put(struct ioasid_user *iuser)
+{
+}
+
+static inline void ioasid_user_for_each_id(struct ioasid_user *iuser, void *data,
+					  void (*fn)(ioasid_t id, void *data))
+{
+}
+#endif /* CONFIG_IOASID_USER */
+
 #else /* !CONFIG_IOASID */
 
 static inline void ioasid_install_capacity(ioasid_t total)
diff --git a/include/linux/miscdevice.h b/include/linux/miscdevice.h
index 0676f18093f9..9823901f11a4 100644
--- a/include/linux/miscdevice.h
+++ b/include/linux/miscdevice.h
@@ -21,6 +21,7 @@
 #define APOLLO_MOUSE_MINOR	7	/* unused */
 #define PC110PAD_MINOR		9	/* unused */
 /*#define ADB_MOUSE_MINOR	10	FIXME OBSOLETE */
+#define IOASID_MINOR		129     /* /dev/ioasid     */
 #define WATCHDOG_MINOR		130	/* Watchdog timer     */
 #define TEMP_MINOR		131	/* Temperature Sensor */
 #define APM_MINOR_DEV		134
diff --git a/include/uapi/linux/ioasid.h b/include/uapi/linux/ioasid.h
new file mode 100644
index 000000000000..1529070c0317
--- /dev/null
+++ b/include/uapi/linux/ioasid.h
@@ -0,0 +1,98 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * PASID (Processor Address Space ID) is a PCIe concept for tagging
+ * address spaces in DMA requests. When system-wide PASID allocation
+ * is required by the underlying iommu driver (e.g. Intel VT-d), this
+ * provides an interface for userspace to request ioasid alloc/free
+ * for its assigned devices.
+ *
+ * Copyright (C) 2021 Intel Corporation.  All rights reserved.
+ *     Author: Liu Yi L <yi.l.liu@intel.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef _UAPI_IOASID_H
+#define _UAPI_IOASID_H
+
+#include <linux/types.h>
+#include <linux/ioctl.h>
+#include <linux/ioasid.h>
+
+#define IOASID_API_VERSION	0
+
+
+/* Kernel & User level defines for IOASID IOCTLs. */
+
+#define IOASID_TYPE	('i')
+#define IOASID_BASE	100
+
+/* -------- IOCTLs for IOASID file descriptor (/dev/ioasid) -------- */
+
+/**
+ * IOASID_GET_API_VERSION - _IO(IOASID_TYPE, IOASID_BASE + 0)
+ *
+ * Report the version of the IOASID API.  This allows us to bump the entire
+ * API version should we later need to add or change features in incompatible
+ * ways.
+ * Return: IOASID_API_VERSION
+ * Availability: Always
+ */
+#define IOASID_GET_API_VERSION		_IO(IOASID_TYPE, IOASID_BASE + 0)
+
+/**
+ * IOASID_GET_INFO - _IOR(IOASID_TYPE, IOASID_BASE + 1, struct ioasid_info)
+ *
+ * Retrieve information about the IOASID object. Fills in provided
+ * struct ioasid_info. Caller sets argsz.
+ *
+ * @argsz:	 user filled size of this data.
+ * @flags:	 currently reserved for future extension. must set to 0.
+ * @ioasid_bits: maximum supported PASID bits, 0 represents no PASID
+ *		 support.
+
+ * Availability: Always
+ */
+struct ioasid_info {
+	__u32	argsz;
+	__u32	flags;
+	__u32	ioasid_bits;
+};
+#define IOASID_GET_INFO _IO(IOASID_TYPE, IOASID_BASE + 1)
+
+/**
+ * IOASID_REQUEST_ALLOC - _IOWR(IOASID_TYPE, IOASID_BASE + 2,
+ *					struct ioasid_request)
+ *
+ * Alloc a PASID within @range. @range is [min, max], which means both
+ * @min and @max are inclusive.
+ * User space should provide min, max no more than the ioasid bits reports
+ * in ioasid_info via IOASID_GET_INFO.
+ *
+ * @argsz: user filled size of this data.
+ * @flags: currently reserved for future extension. must set to 0.
+ * @range: allocated ioasid is expected in the range.
+ *
+ * returns: allocated ID on success, -errno on failure
+ */
+struct ioasid_alloc_request {
+	__u32	argsz;
+	__u32	flags;
+	struct {
+		__u32	min;
+		__u32	max;
+	} range;
+};
+#define IOASID_REQUEST_ALLOC	_IO(IOASID_TYPE, IOASID_BASE + 2)
+
+/**
+ * IOASID_REQUEST_FREE - _IOWR(IOASID_TYPE, IOASID_BASE + 3, int)
+ *
+ * Free a PASID.
+ *
+ * returns: 0 on success, -errno on failure
+ */
+#define IOASID_REQUEST_FREE	_IO(IOASID_TYPE, IOASID_BASE + 3)
+
+#endif /* _UAPI_IOASID_H */
-- 
2.25.1

