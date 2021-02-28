Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36DA032713E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Feb 2021 07:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbhB1Gj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 01:39:59 -0500
Received: from mga09.intel.com ([134.134.136.24]:22647 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230462AbhB1Gjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 01:39:52 -0500
IronPort-SDR: 89cxGE+AL8eS7SpWoQmA2TTWPviOuX5RwqwEXy8FgMg/LovMXnCZffmGVa1Kpr7/d4RAmxQEng
 OtMYi2dTSzYw==
X-IronPort-AV: E=McAfee;i="6000,8403,9908"; a="186323902"
X-IronPort-AV: E=Sophos;i="5.81,211,1610438400"; 
   d="scan'208";a="186323902"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2021 22:33:09 -0800
IronPort-SDR: qchTLFgyX916CIPRGYrZ6Gz/jgLi7dnTlsnEaeI9+8aGkJZxtP0fLvsmT6I9TZRolKwIsN+KcZ
 K/62nW9dIV4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,211,1610438400"; 
   d="scan'208";a="517029725"
Received: from otc-wp-03.jf.intel.com ([10.54.39.79])
  by orsmga004.jf.intel.com with ESMTP; 27 Feb 2021 22:33:09 -0800
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
        Wu Hao <hao.wu@intel.com>, Dave Jiang <dave.jiang@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH V4 10/18] iommu/ioasid: Support mm token type ioasid_set notifications
Date:   Sat, 27 Feb 2021 14:01:18 -0800
Message-Id: <1614463286-97618-11-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a system-wide resource, IOASID is often shared by multiple kernel
subsystems that are independent of each other. However, at the
ioasid_set level, these kernel subsystems must communicate with each
other for ownership checking, event notifications, etc. For example, on
Intel Scalable IO Virtualization (SIOV) enabled platforms, KVM and VFIO
instances under the same process/guest must be aware of a shared IOASID
set.
IOASID_SET_TYPE_MM token type was introduced to explicitly mark an
IOASID set that belongs to a process, thus use the same mm_struct
pointer as a token. Users of the same process can then identify with
each other based on this token.

This patch introduces MM token specific event registration APIs. Event
subscribers such as KVM instances can register IOASID event handler
without the knowledge of its ioasid_set. Event handlers are registered
based on its mm_struct pointer as a token. In case when subscribers
register handler *prior* to the creation of the ioasid_set, the
handler’s notification block is stored in a pending list within IOASID
core. Once the ioasid_set of the MM token is created, the notification
block will be registered by the IOASID core.

Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/ioasid.c | 142 +++++++++++++++++++++++++++++++++++++++++
 include/linux/ioasid.h |  18 ++++++
 2 files changed, 160 insertions(+)

diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
index 56577e745c4b..96e941dfada7 100644
--- a/drivers/iommu/ioasid.c
+++ b/drivers/iommu/ioasid.c
@@ -21,6 +21,8 @@
  * keep local states in sync.
  */
 static ATOMIC_NOTIFIER_HEAD(ioasid_notifier);
+/* List to hold pending notification block registrations */
+static LIST_HEAD(ioasid_nb_pending_list);
 static DEFINE_SPINLOCK(ioasid_nb_lock);
 
 /* Default to PCIe standard 20 bit PASID */
@@ -574,6 +576,27 @@ static inline bool ioasid_set_is_valid(struct ioasid_set *set)
 	return xa_load(&ioasid_sets, set->id) == set;
 }
 
+static void ioasid_add_pending_nb(struct ioasid_set *set)
+{
+	struct ioasid_set_nb *curr;
+
+	if (set->type != IOASID_SET_TYPE_MM)
+		return;
+	/*
+	 * Check if there are any pending nb requests for the given token, if so
+	 * add them to the notifier chain.
+	 */
+	spin_lock(&ioasid_nb_lock);
+	list_for_each_entry(curr, &ioasid_nb_pending_list, list) {
+		if (curr->token == set->token && !curr->active) {
+			atomic_notifier_chain_register(&set->nh, curr->nb);
+			curr->set = set;
+			curr->active = true;
+		}
+	}
+	spin_unlock(&ioasid_nb_lock);
+}
+
 /**
  * ioasid_set_alloc - Allocate a new IOASID set for a given token
  *
@@ -658,6 +681,11 @@ struct ioasid_set *ioasid_set_alloc(void *token, ioasid_t quota, int type)
 	atomic_set(&set->nr_ioasids, 0);
 	ATOMIC_INIT_NOTIFIER_HEAD(&set->nh);
 
+	/*
+	 * Check if there are any pending nb requests for the given token, if so
+	 * add them to the notifier chain.
+	 */
+	ioasid_add_pending_nb(set);
 	/*
 	 * Per set XA is used to store private IDs within the set, get ready
 	 * for ioasid_set private ID and system-wide IOASID allocation
@@ -675,6 +703,7 @@ EXPORT_SYMBOL_GPL(ioasid_set_alloc);
 
 static int ioasid_set_free_locked(struct ioasid_set *set)
 {
+	struct ioasid_set_nb *curr;
 	int ret = 0;
 
 	if (!ioasid_set_is_valid(set)) {
@@ -688,6 +717,16 @@ static int ioasid_set_free_locked(struct ioasid_set *set)
 	}
 
 	WARN_ON(!xa_empty(&set->xa));
+	/* Restore pending status of the set NBs */
+	list_for_each_entry(curr, &ioasid_nb_pending_list, list) {
+		if (curr->token == set->token) {
+			if (curr->active)
+				curr->active = false;
+			else
+				pr_warn("Set token exists but not active!\n");
+		}
+	}
+
 	/*
 	 * Token got released right away after the ioasid_set is freed.
 	 * If a new set is created immediately with the newly released token,
@@ -1117,6 +1156,22 @@ EXPORT_SYMBOL_GPL(ioasid_register_notifier);
 void ioasid_unregister_notifier(struct ioasid_set *set,
 				struct notifier_block *nb)
 {
+	struct ioasid_set_nb *curr;
+
+	spin_lock(&ioasid_nb_lock);
+	/*
+	 * Pending list is registered with a token without an ioasid_set,
+	 * therefore should not be unregistered directly.
+	 */
+	list_for_each_entry(curr, &ioasid_nb_pending_list, list) {
+		if (curr->nb == nb) {
+			pr_warn("Cannot unregister NB from pending list\n");
+			spin_unlock(&ioasid_nb_lock);
+			return;
+		}
+	}
+	spin_unlock(&ioasid_nb_lock);
+
 	if (set)
 		atomic_notifier_chain_unregister(&set->nh, nb);
 	else
@@ -1124,6 +1179,93 @@ void ioasid_unregister_notifier(struct ioasid_set *set,
 }
 EXPORT_SYMBOL_GPL(ioasid_unregister_notifier);
 
+/**
+ * ioasid_register_notifier_mm - Register a notifier block on the IOASID set
+ *                               created by the mm_struct pointer as the token
+ *
+ * @mm: the mm_struct token of the ioasid_set
+ * @nb: notfier block to be registered on the ioasid_set
+ *
+ * This a variant of ioasid_register_notifier() where the caller intends to
+ * listen to IOASID events belong the ioasid_set created under the same
+ * process. Caller is not aware of the ioasid_set, no need to hold reference
+ * of the ioasid_set.
+ */
+int ioasid_register_notifier_mm(struct mm_struct *mm, struct notifier_block *nb)
+{
+	struct ioasid_set_nb *curr;
+	struct ioasid_set *set;
+	int ret = 0;
+
+	spin_lock(&ioasid_nb_lock);
+	/* Check for duplicates, nb is unique per set */
+	list_for_each_entry(curr, &ioasid_nb_pending_list, list) {
+		if (curr->token == mm && curr->nb == nb) {
+			ret = -EBUSY;
+			goto exit_unlock;
+		}
+	}
+	curr = kzalloc(sizeof(*curr), GFP_ATOMIC);
+	if (!curr) {
+		ret = -ENOMEM;
+		goto exit_unlock;
+	}
+	/* Check if the token has an existing set */
+	set = ioasid_find_mm_set(mm);
+	if (!set) {
+		/* Add to the rsvd list as inactive */
+		curr->active = false;
+	} else {
+		/* REVISIT: Only register empty set for now. Can add an option
+		 * in the future to playback existing PASIDs.
+		 */
+		if (atomic_read(&set->nr_ioasids)) {
+			pr_warn("IOASID set %d not empty %d\n", set->id,
+				atomic_read(&set->nr_ioasids));
+			ret = -EBUSY;
+			goto exit_free;
+		}
+		curr->token = mm;
+		curr->nb = nb;
+		curr->active = true;
+		curr->set = set;
+
+		/* Set already created, add to the notifier chain */
+		atomic_notifier_chain_register(&set->nh, nb);
+	}
+
+	list_add(&curr->list, &ioasid_nb_pending_list);
+	goto exit_unlock;
+exit_free:
+	kfree(curr);
+exit_unlock:
+	spin_unlock(&ioasid_nb_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ioasid_register_notifier_mm);
+
+void ioasid_unregister_notifier_mm(struct mm_struct *mm, struct notifier_block *nb)
+{
+	struct ioasid_set_nb *curr;
+
+	spin_lock(&ioasid_nb_lock);
+	list_for_each_entry(curr, &ioasid_nb_pending_list, list) {
+		if (curr->token == mm && curr->nb == nb) {
+			list_del(&curr->list);
+			spin_unlock(&ioasid_nb_lock);
+			if (curr->active) {
+				atomic_notifier_chain_unregister(&curr->set->nh,
+								 nb);
+			}
+			kfree(curr);
+			return;
+		}
+	}
+	pr_warn("No ioasid set found for mm token %llx\n",  (u64)mm);
+	spin_unlock(&ioasid_nb_lock);
+}
+EXPORT_SYMBOL_GPL(ioasid_unregister_notifier_mm);
+
 MODULE_AUTHOR("Jean-Philippe Brucker <jean-philippe.brucker@arm.com>");
 MODULE_AUTHOR("Jacob Pan <jacob.jun.pan@linux.intel.com>");
 MODULE_DESCRIPTION("IO Address Space ID (IOASID) allocator");
diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
index d8b85a04214f..c97e80ff65cc 100644
--- a/include/linux/ioasid.h
+++ b/include/linux/ioasid.h
@@ -132,6 +132,8 @@ void ioasid_unregister_notifier(struct ioasid_set *set,
 void ioasid_set_for_each_ioasid(struct ioasid_set *sdata,
 				void (*fn)(ioasid_t id, void *data),
 				void *data);
+int ioasid_register_notifier_mm(struct mm_struct *mm, struct notifier_block *nb);
+void ioasid_unregister_notifier_mm(struct mm_struct *mm, struct notifier_block *nb);
 #else /* !CONFIG_IOASID */
 static inline void ioasid_install_capacity(ioasid_t total)
 {
@@ -250,5 +252,21 @@ static inline void ioasid_set_for_each_ioasid(struct ioasid_set *sdata,
 					      void *data)
 {
 }
+
+static inline int ioasid_register_notifier_mm(struct mm_struct *mm,
+					      struct notifier_block *nb)
+{
+	return -ENOTSUPP;
+}
+
+static inline void ioasid_unregister_notifier_mm(struct mm_struct *mm,
+						 struct notifier_block *nb)
+{
+}
+
+static inline bool ioasid_queue_work(struct work_struct *work)
+{
+	return false;
+}
 #endif /* CONFIG_IOASID */
 #endif /* __LINUX_IOASID_H */
-- 
2.25.1

