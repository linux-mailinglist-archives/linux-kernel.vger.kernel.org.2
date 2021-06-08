Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86DDD3A0809
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 01:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbhFHXwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 19:52:05 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:37714 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbhFHXwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 19:52:03 -0400
Received: by mail-wr1-f53.google.com with SMTP id i94so18314299wri.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 16:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FJUc6rGS3Gi3tV8QCtjpSu4+IWNFa4pZsZ1lraxjNlg=;
        b=T0V6yKCUty1gS3uXTqynEcEPvLEd0FtO5sguzORVo9QowW3erCGfGM+kJ4U8aQWG+K
         An7/hoqOciYbigOVka7uqCgh3wIrTyLz6cn7K6vbT6dYz+u4cVYZV66+IOsLFOERY6gY
         TxzTQng35TSS1o0wmww7pApco+9AOrbNNrCtWeVRcX2KS7VBdNCypzM6VBIlz6L/e1dB
         WSJdBnGvCEjz501ksmSU8j01NzGwuW2wzttwukg0JqQKsGhbb0PZ1KRzEVN4hf+vvJI4
         zUxm4UyazpdTbTi74VVL+c6dF/JnfSIo20rn+fEBMMARS92e90ufv23s07/kH+HNx7aJ
         mTNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FJUc6rGS3Gi3tV8QCtjpSu4+IWNFa4pZsZ1lraxjNlg=;
        b=JUemIINrOklPTkEJFwrYsL3Dx6kkpMWzwZgbaxg+JDXDHiT5n3qU3UXVMjn5ej4jaR
         9Ki3snTBkGe7XIjqsKfcZJpLMdLW8Y0US6a2JErUSIOUcWCREqm5ydk79QuitsKGEW3a
         +3DA/4OEUc11WjD2SllKX4rmOLNHw17G5bpR1RaL5mLaIJhYgKvQURHG9m8cMFfIfQP+
         fh4Q+HS+y/nE/QPhRP/al8z4hDrhWnMlZCXxc/u/INmrguv5cmA8ceyIGqqXLDl1nQ3H
         nqswNs/EoMO7yAKNyJ+Zh91VXq/4MeajaP87FYAD1iAcWiujfDS+R5UjwhCKkf3GG2dB
         xN1w==
X-Gm-Message-State: AOAM533/1vhuEMJ+ILOdQfJKj+s2Xwi6sfIr0AEFTfaWCsRUPC2tJ8js
        Q/cDod6dnPsmIlNblheX11c=
X-Google-Smtp-Source: ABdhPJwi9RGBMYbyMwCvcFqXYSa3C6iHtfaJMMeoxYUba7S23E383pb7WlpyIjgB+thpoKcPf8wwTQ==
X-Received: by 2002:a05:6000:154e:: with SMTP id 14mr18466791wry.305.1623196148564;
        Tue, 08 Jun 2021 16:49:08 -0700 (PDT)
Received: from linux.local (host-82-59-55-132.retail.telecomitalia.it. [82.59.55.132])
        by smtp.gmail.com with ESMTPSA id f12sm6886133wru.81.2021.06.08.16.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 16:49:08 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v2] x86/resctrl: Fix kernel-doc in pseudo_lock.c
Date:   Wed,  9 Jun 2021 01:49:02 +0200
Message-Id: <20210608234902.9316-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added undocumented parameters, rewrote some phrases, and fixed some
formatting issues. Most of the warnings detected by scripts/kernel-doc.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

v1 -> v2: According to a first review by Reinette Chatre
<reinette.chatre@intel.com>, modified the 'Subject' to conform to x86
subsystem, modified a wrong description, and run 'scripts/kernel-doc'
to find out more warnings that 'sparse' didn't notice.

 arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 74 ++++++++++++-----------
 1 file changed, 39 insertions(+), 35 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index 05a89e33fde2..7fb3998b1deb 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -48,7 +48,8 @@ static unsigned long pseudo_lock_minor_avail = GENMASK(MINORBITS, 0);
 static struct class *pseudo_lock_class;
 
 /**
- * get_prefetch_disable_bits - prefetch disable bits of supported platforms
+ * get_prefetch_disable_bits - Prefetch disable bits of supported platforms
+ * @void: It takes no parameters.
  *
  * Capture the list of platforms that have been validated to support
  * pseudo-locking. This includes testing to ensure pseudo-locked regions
@@ -61,11 +62,10 @@ static struct class *pseudo_lock_class;
  * in the SDM.
  *
  * When adding a platform here also add support for its cache events to
- * measure_cycles_perf_fn()
+ * measure_cycles_perf_fn().
  *
- * Return:
- * If platform is supported, the bits to disable hardware prefetchers, 0
- * if platform is not supported.
+ * Return: The bits to disable hardware prefetchers, if platform is
+ * supported; 0, if it is not.
  */
 static u64 get_prefetch_disable_bits(void)
 {
@@ -126,7 +126,7 @@ static int pseudo_lock_minor_get(unsigned int *minor)
 }
 
 /**
- * pseudo_lock_minor_release - Return minor number to available
+ * pseudo_lock_minor_release - Set minor number to available
  * @minor: The minor number made available
  */
 static void pseudo_lock_minor_release(unsigned int minor)
@@ -135,7 +135,7 @@ static void pseudo_lock_minor_release(unsigned int minor)
 }
 
 /**
- * region_find_by_minor - Locate a pseudo-lock region by inode minor number
+ * region_find_by_minor - Locate a pseudo-locked region by inode minor number
  * @minor: The minor number of the device representing pseudo-locked region
  *
  * When the character device is accessed we need to determine which
@@ -146,7 +146,7 @@ static void pseudo_lock_minor_release(unsigned int minor)
  * with a cache instance.
  *
  * Return: On success return pointer to resource group owning the pseudo-locked
- *         region, NULL on failure.
+ * region, NULL on failure.
  */
 static struct rdtgroup *region_find_by_minor(unsigned int minor)
 {
@@ -162,9 +162,9 @@ static struct rdtgroup *region_find_by_minor(unsigned int minor)
 }
 
 /**
- * pseudo_lock_pm_req - A power management QoS request list entry
- * @list:	Entry within the @pm_reqs list for a pseudo-locked region
- * @req:	PM QoS request
+ * struct pseudo_lock_pm_req - A power management QoS request list entry
+ * @list: Entry within the @pm_reqs list for a pseudo-locked region
+ * @req: PM QoS request
  */
 struct pseudo_lock_pm_req {
 	struct list_head list;
@@ -184,6 +184,7 @@ static void pseudo_lock_cstates_relax(struct pseudo_lock_region *plr)
 
 /**
  * pseudo_lock_cstates_constrain - Restrict cores from entering C6
+ * @plr: Pseudo-locked region
  *
  * To prevent the cache from being affected by power management entering
  * C6 has to be avoided. This is accomplished by requesting a latency
@@ -196,6 +197,9 @@ static void pseudo_lock_cstates_relax(struct pseudo_lock_region *plr)
  * the ACPI latencies need to be considered while keeping in mind that C2
  * may be set to map to deeper sleep states. In this case the latency
  * requirement needs to prevent entering C2 also.
+ *
+ * Return: 0 on success, -ENOMEM if there's not enough memory for data
+ * structure, otherwise -ENODEV or -EINVAL
  */
 static int pseudo_lock_cstates_constrain(struct pseudo_lock_region *plr)
 {
@@ -232,8 +236,8 @@ static int pseudo_lock_cstates_constrain(struct pseudo_lock_region *plr)
 }
 
 /**
- * pseudo_lock_region_clear - Reset pseudo-lock region data
- * @plr: pseudo-lock region
+ * pseudo_lock_region_clear - Reset pseudo-locked region data
+ * @plr: Pseudo-locked region
  *
  * All content of the pseudo-locked region is reset - any memory allocated
  * freed.
@@ -255,19 +259,19 @@ static void pseudo_lock_region_clear(struct pseudo_lock_region *plr)
 }
 
 /**
- * pseudo_lock_region_init - Initialize pseudo-lock region information
- * @plr: pseudo-lock region
+ * pseudo_lock_region_init - Initialize pseudo-locked region information
+ * @plr: Pseudo-locked region
  *
  * Called after user provided a schemata to be pseudo-locked. From the
  * schemata the &struct pseudo_lock_region is on entry already initialized
  * with the resource, domain, and capacity bitmask. Here the information
  * required for pseudo-locking is deduced from this data and &struct
  * pseudo_lock_region initialized further. This information includes:
- * - size in bytes of the region to be pseudo-locked
+ * - size in bytes of the region to be pseudo-locked;
  * - cache line size to know the stride with which data needs to be accessed
- *   to be pseudo-locked
+ *   to be pseudo-locked;
  * - a cpu associated with the cache instance on which the pseudo-locking
- *   flow can be executed
+ *   flow can be executed.
  *
  * Return: 0 on success, <0 on failure. Descriptive error will be written
  * to last_cmd_status buffer.
@@ -307,8 +311,8 @@ static int pseudo_lock_region_init(struct pseudo_lock_region *plr)
 }
 
 /**
- * pseudo_lock_init - Initialize a pseudo-lock region
- * @rdtgrp: resource group to which new pseudo-locked region will belong
+ * pseudo_lock_init - Initialize a pseudo-locked region
+ * @rdtgrp: Resource group to which a new pseudo-locked region will belong
  *
  * A pseudo-locked region is associated with a resource group. When this
  * association is created the pseudo-locked region is initialized. The
@@ -333,12 +337,12 @@ static int pseudo_lock_init(struct rdtgroup *rdtgrp)
 
 /**
  * pseudo_lock_region_alloc - Allocate kernel memory that will be pseudo-locked
- * @plr: pseudo-lock region
+ * @plr: Pseudo-locked region
  *
  * Initialize the details required to set up the pseudo-locked region and
  * allocate the contiguous memory that will be pseudo-locked to the cache.
  *
- * Return: 0 on success, <0 on failure.  Descriptive error will be written
+ * Return: 0 on success, <0 on failure. Descriptive error will be written
  * to last_cmd_status buffer.
  */
 static int pseudo_lock_region_alloc(struct pseudo_lock_region *plr)
@@ -376,13 +380,11 @@ static int pseudo_lock_region_alloc(struct pseudo_lock_region *plr)
 
 /**
  * pseudo_lock_free - Free a pseudo-locked region
- * @rdtgrp: resource group to which pseudo-locked region belonged
+ * @rdtgrp: Resource group to which pseudo-locked region belonged
  *
  * The pseudo-locked region's resources have already been released, or not
  * yet created at this point. Now it can be freed and disassociated from the
  * resource group.
- *
- * Return: void
  */
 static void pseudo_lock_free(struct rdtgroup *rdtgrp)
 {
@@ -393,7 +395,7 @@ static void pseudo_lock_free(struct rdtgroup *rdtgrp)
 
 /**
  * pseudo_lock_fn - Load kernel memory into cache
- * @_rdtgrp: resource group to which pseudo-lock region belongs
+ * @_rdtgrp: Resource group to which pseudo-locked region belongs
  *
  * This is the core pseudo-locking flow.
  *
@@ -401,7 +403,7 @@ static void pseudo_lock_free(struct rdtgroup *rdtgrp)
  * Then, while taking care that there will be as little interference as
  * possible, the memory to be loaded is accessed while core is running
  * with class of service set to the bitmask of the pseudo-locked region.
- * After this is complete no future CAT allocations will be allowed to
+ * After this is complete, no future CAT allocations will be allowed to
  * overlap with this bitmask.
  *
  * Local register variables are utilized to ensure that the memory region
@@ -520,7 +522,7 @@ static int pseudo_lock_fn(void *_rdtgrp)
 
 /**
  * rdtgroup_monitor_in_progress - Test if monitoring in progress
- * @r: resource group being queried
+ * @rdtgrp: Resource group being queried
  *
  * Return: 1 if monitor groups have been created for this resource
  * group, 0 otherwise.
@@ -532,7 +534,7 @@ static int rdtgroup_monitor_in_progress(struct rdtgroup *rdtgrp)
 
 /**
  * rdtgroup_locksetup_user_restrict - Restrict user access to group
- * @rdtgrp: resource group needing access restricted
+ * @rdtgrp: Resource group needing access restricted
  *
  * A resource group used for cache pseudo-locking cannot have cpus or tasks
  * assigned to it. This is communicated to the user by restricting access
@@ -582,7 +584,7 @@ static int rdtgroup_locksetup_user_restrict(struct rdtgroup *rdtgrp)
 
 /**
  * rdtgroup_locksetup_user_restore - Restore user access to group
- * @rdtgrp: resource group needing access restored
+ * @rdtgrp: Resource group needing access restored
  *
  * Restore all file access previously removed using
  * rdtgroup_locksetup_user_restrict()
@@ -629,7 +631,7 @@ static int rdtgroup_locksetup_user_restore(struct rdtgroup *rdtgrp)
 
 /**
  * rdtgroup_locksetup_enter - Resource group enters locksetup mode
- * @rdtgrp: resource group requested to enter locksetup mode
+ * @rdtgrp: Resource group requested to enter locksetup mode
  *
  * A resource group enters locksetup mode to reflect that it would be used
  * to represent a pseudo-locked region and is in the process of being set
@@ -744,8 +746,8 @@ int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp)
 }
 
 /**
- * rdtgroup_locksetup_exit - resource group exist locksetup mode
- * @rdtgrp: resource group
+ * rdtgroup_locksetup_exit - Resource group exits locksetup mode
+ * @rdtgrp: Resource group
  *
  * When a resource group exits locksetup mode the earlier restrictions are
  * lifted.
@@ -1140,6 +1142,8 @@ static int measure_l3_residency(void *_plr)
 
 /**
  * pseudo_lock_measure_cycles - Trigger latency measure to pseudo-locked region
+ * @rdtgrp: Resource group to which the pseudo-locked region belongs
+ * @sel: Selector of which measurement to perform on a pseudo-locked region
  *
  * The measurement of latency to access a pseudo-locked region should be
  * done from a cpu that is associated with that pseudo-locked region.
@@ -1254,7 +1258,7 @@ static const struct file_operations pseudo_measure_fops = {
 
 /**
  * rdtgroup_pseudo_lock_create - Create a pseudo-locked region
- * @rdtgrp: resource group to which pseudo-lock region belongs
+ * @rdtgrp: Resource group to which pseudo-locked region belongs
  *
  * Called when a resource group in the pseudo-locksetup mode receives a
  * valid schemata that should be pseudo-locked. Since the resource group is
@@ -1385,7 +1389,7 @@ int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp)
 
 /**
  * rdtgroup_pseudo_lock_remove - Remove a pseudo-locked region
- * @rdtgrp: resource group to which the pseudo-locked region belongs
+ * @rdtgrp: Resource group to which the pseudo-locked region belongs
  *
  * The removal of a pseudo-locked region can be initiated when the resource
  * group is removed from user space via a "rmdir" from userspace or the
-- 
2.31.1

