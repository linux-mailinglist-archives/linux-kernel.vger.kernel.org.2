Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F21263A4AE0
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 00:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbhFKWLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 18:11:49 -0400
Received: from mga09.intel.com ([134.134.136.24]:1508 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229777AbhFKWLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 18:11:48 -0400
IronPort-SDR: JddIbh68fJdhEpPny08htqubBmVmjI+By1vN4+EifzODBhMF0u3Q15NIEKu2OjRM6uU9U76jHY
 +mBTS21Y8Kyg==
X-IronPort-AV: E=McAfee;i="6200,9189,10012"; a="205581532"
X-IronPort-AV: E=Sophos;i="5.83,267,1616482800"; 
   d="scan'208";a="205581532"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 15:09:49 -0700
IronPort-SDR: 8KwIuLpi9igxNielJXKsWSS4Es76+UYEqicpXHmapJZS/sFBxFRnJBeodC8XLt4h+oesFOSkeO
 3w6ILEac+wHw==
X-IronPort-AV: E=Sophos;i="5.83,267,1616482800"; 
   d="scan'208";a="403344182"
Received: from rchatre-mobl3.amr.corp.intel.com (HELO [10.212.232.130]) ([10.212.232.130])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 15:09:48 -0700
Subject: Re: [PATCH v2] x86/resctrl: Fix kernel-doc in pseudo_lock.c
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20210608234902.9316-1-fmdefrancesco@gmail.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <4de714ab-47f4-97e3-c35f-184b1218e681@intel.com>
Date:   Fri, 11 Jun 2021 15:09:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210608234902.9316-1-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,

On 6/8/2021 4:49 PM, Fabio M. De Francesco wrote:
> Added undocumented parameters, rewrote some phrases, and fixed some
> formatting issues. Most of the warnings detected by scripts/kernel-doc.

Please write commit message in imperative tone ... eg, "Add undocumented 
parameters ..."

Also, please refrain from making changes that are not related to the 
goal. The goal according to the subject of the patch is to fix 
kernel-doc issues - the "rewrote some phrases" is not related to this goal.

The "rewrote some phrases" really is not clear to me ... you do not 
mention this in your commit message but you seem to also capitalize each 
kernel-doc description? This is not a kernel-doc warning but something 
you chose to do. Please be specific in your commit message about any 
things that are not kernel-doc warnings that you do to warrant it to be 
classified as "Fix kernel-doc". For example, if indeed one of your goals 
are to capitalize all kernel-doc descriptions, add that as a goal to the 
commit log to help reader understand the changes. I think this will also 
help you to consider what is actually an issue and what is your preference.

When you say "Most of the warnings detected ... " - which warnings did 
it miss? How were other issues detected?

This patch is unclear regarding its goal - the subject and commit 
message indicate that this is about fixing kernel-doc issue while the 
patch does much more.

> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
> 
> v1 -> v2: According to a first review by Reinette Chatre
> <reinette.chatre@intel.com>, modified the 'Subject' to conform to x86
> subsystem, modified a wrong description, and run 'scripts/kernel-doc'
> to find out more warnings that 'sparse' didn't notice.
> 
>   arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 74 ++++++++++++-----------
>   1 file changed, 39 insertions(+), 35 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> index 05a89e33fde2..7fb3998b1deb 100644
> --- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> +++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> @@ -48,7 +48,8 @@ static unsigned long pseudo_lock_minor_avail = GENMASK(MINORBITS, 0);
>   static struct class *pseudo_lock_class;
>   
>   /**
> - * get_prefetch_disable_bits - prefetch disable bits of supported platforms
> + * get_prefetch_disable_bits - Prefetch disable bits of supported platforms

Did kernel-doc really complain about prefetch not being capitalized?

> + * @void: It takes no parameters.

ok, if this makes kernel-doc happy

>    *
>    * Capture the list of platforms that have been validated to support
>    * pseudo-locking. This includes testing to ensure pseudo-locked regions
> @@ -61,11 +62,10 @@ static struct class *pseudo_lock_class;
>    * in the SDM.
>    *
>    * When adding a platform here also add support for its cache events to
> - * measure_cycles_perf_fn()
> + * measure_cycles_perf_fn().
>    *

What kernel-doc problem is being fixed?

> - * Return:
> - * If platform is supported, the bits to disable hardware prefetchers, 0
> - * if platform is not supported.
> + * Return: The bits to disable hardware prefetchers, if platform is
> + * supported; 0, if it is not.

Did kernel-doc complain about this?

>    */
>   static u64 get_prefetch_disable_bits(void)
>   {
> @@ -126,7 +126,7 @@ static int pseudo_lock_minor_get(unsigned int *minor)
>   }
>   
>   /**
> - * pseudo_lock_minor_release - Return minor number to available
> + * pseudo_lock_minor_release - Set minor number to available

no. You may now verbatim document what the code does but you removed 
what it means when the code does that.

>    * @minor: The minor number made available
>    */
>   static void pseudo_lock_minor_release(unsigned int minor)
> @@ -135,7 +135,7 @@ static void pseudo_lock_minor_release(unsigned int minor)
>   }
>   
>   /**
> - * region_find_by_minor - Locate a pseudo-lock region by inode minor number
> + * region_find_by_minor - Locate a pseudo-locked region by inode minor number

kernel-doc issue?

>    * @minor: The minor number of the device representing pseudo-locked region
>    *
>    * When the character device is accessed we need to determine which
> @@ -146,7 +146,7 @@ static void pseudo_lock_minor_release(unsigned int minor)
>    * with a cache instance.
>    *
>    * Return: On success return pointer to resource group owning the pseudo-locked
> - *         region, NULL on failure.
> + * region, NULL on failure.

Please keep the spacing as it is.

>    */
>   static struct rdtgroup *region_find_by_minor(unsigned int minor)
>   {
> @@ -162,9 +162,9 @@ static struct rdtgroup *region_find_by_minor(unsigned int minor)
>   }
>   
>   /**
> - * pseudo_lock_pm_req - A power management QoS request list entry
> - * @list:	Entry within the @pm_reqs list for a pseudo-locked region
> - * @req:	PM QoS request
> + * struct pseudo_lock_pm_req - A power management QoS request list entry
> + * @list: Entry within the @pm_reqs list for a pseudo-locked region
> + * @req: PM QoS request
>    */

Only the missing "struct" is a kernel-doc issue?

>   struct pseudo_lock_pm_req {
>   	struct list_head list;
> @@ -184,6 +184,7 @@ static void pseudo_lock_cstates_relax(struct pseudo_lock_region *plr)
>   
>   /**
>    * pseudo_lock_cstates_constrain - Restrict cores from entering C6
> + * @plr: Pseudo-locked region
>    *

ok

>    * To prevent the cache from being affected by power management entering
>    * C6 has to be avoided. This is accomplished by requesting a latency
> @@ -196,6 +197,9 @@ static void pseudo_lock_cstates_relax(struct pseudo_lock_region *plr)
>    * the ACPI latencies need to be considered while keeping in mind that C2
>    * may be set to map to deeper sleep states. In this case the latency
>    * requirement needs to prevent entering C2 also.
> + *
> + * Return: 0 on success, -ENOMEM if there's not enough memory for data
> + * structure, otherwise -ENODEV or -EINVAL

This function passes some error codes through so being too specific may 
not be accurate when those functions change. You can follow the pattern 
in other functions like:

"Return: 0 on success, <0 on failure"

>    */
>   static int pseudo_lock_cstates_constrain(struct pseudo_lock_region *plr)
>   {
> @@ -232,8 +236,8 @@ static int pseudo_lock_cstates_constrain(struct pseudo_lock_region *plr)
>   }
>   
>   /**
> - * pseudo_lock_region_clear - Reset pseudo-lock region data
> - * @plr: pseudo-lock region
> + * pseudo_lock_region_clear - Reset pseudo-locked region data
> + * @plr: Pseudo-locked region
>    *

No kernel-doc issue here?

>    * All content of the pseudo-locked region is reset - any memory allocated
>    * freed.
> @@ -255,19 +259,19 @@ static void pseudo_lock_region_clear(struct pseudo_lock_region *plr)
>   }
>   
>   /**
> - * pseudo_lock_region_init - Initialize pseudo-lock region information
> - * @plr: pseudo-lock region
> + * pseudo_lock_region_init - Initialize pseudo-locked region information
> + * @plr: Pseudo-locked region
>    *
>    * Called after user provided a schemata to be pseudo-locked. From the
>    * schemata the &struct pseudo_lock_region is on entry already initialized
>    * with the resource, domain, and capacity bitmask. Here the information
>    * required for pseudo-locking is deduced from this data and &struct
>    * pseudo_lock_region initialized further. This information includes:
> - * - size in bytes of the region to be pseudo-locked
> + * - size in bytes of the region to be pseudo-locked;
>    * - cache line size to know the stride with which data needs to be accessed
> - *   to be pseudo-locked
> + *   to be pseudo-locked;
>    * - a cpu associated with the cache instance on which the pseudo-locking
> - *   flow can be executed
> + *   flow can be executed.
>    *
>    * Return: 0 on success, <0 on failure. Descriptive error will be written
>    * to last_cmd_status buffer.

What kernel-doc issue is fixed in this snippet?

> @@ -307,8 +311,8 @@ static int pseudo_lock_region_init(struct pseudo_lock_region *plr)
>   }
>   
>   /**
> - * pseudo_lock_init - Initialize a pseudo-lock region
> - * @rdtgrp: resource group to which new pseudo-locked region will belong
> + * pseudo_lock_init - Initialize a pseudo-locked region
> + * @rdtgrp: Resource group to which a new pseudo-locked region will belong
>    *
>    * A pseudo-locked region is associated with a resource group. When this
>    * association is created the pseudo-locked region is initialized. The

same

> @@ -333,12 +337,12 @@ static int pseudo_lock_init(struct rdtgroup *rdtgrp)
>   
>   /**
>    * pseudo_lock_region_alloc - Allocate kernel memory that will be pseudo-locked
> - * @plr: pseudo-lock region
> + * @plr: Pseudo-locked region
>    *
>    * Initialize the details required to set up the pseudo-locked region and
>    * allocate the contiguous memory that will be pseudo-locked to the cache.
>    *
> - * Return: 0 on success, <0 on failure.  Descriptive error will be written
> + * Return: 0 on success, <0 on failure. Descriptive error will be written
>    * to last_cmd_status buffer.
>    */
>   static int pseudo_lock_region_alloc(struct pseudo_lock_region *plr)

same

> @@ -376,13 +380,11 @@ static int pseudo_lock_region_alloc(struct pseudo_lock_region *plr)
>   
>   /**
>    * pseudo_lock_free - Free a pseudo-locked region
> - * @rdtgrp: resource group to which pseudo-locked region belonged
> + * @rdtgrp: Resource group to which pseudo-locked region belonged
>    *
>    * The pseudo-locked region's resources have already been released, or not
>    * yet created at this point. Now it can be freed and disassociated from the
>    * resource group.
> - *
> - * Return: void
>    */
>   static void pseudo_lock_free(struct rdtgroup *rdtgrp)
>   {

same

> @@ -393,7 +395,7 @@ static void pseudo_lock_free(struct rdtgroup *rdtgrp)
>   
>   /**
>    * pseudo_lock_fn - Load kernel memory into cache
> - * @_rdtgrp: resource group to which pseudo-lock region belongs
> + * @_rdtgrp: Resource group to which pseudo-locked region belongs
>    *
>    * This is the core pseudo-locking flow.
>    *
> @@ -401,7 +403,7 @@ static void pseudo_lock_free(struct rdtgroup *rdtgrp)
>    * Then, while taking care that there will be as little interference as
>    * possible, the memory to be loaded is accessed while core is running
>    * with class of service set to the bitmask of the pseudo-locked region.
> - * After this is complete no future CAT allocations will be allowed to
> + * After this is complete, no future CAT allocations will be allowed to
>    * overlap with this bitmask.
>    *
>    * Local register variables are utilized to ensure that the memory region

same

> @@ -520,7 +522,7 @@ static int pseudo_lock_fn(void *_rdtgrp)
>   
>   /**
>    * rdtgroup_monitor_in_progress - Test if monitoring in progress
> - * @r: resource group being queried
> + * @rdtgrp: Resource group being queried
>    *
>    * Return: 1 if monitor groups have been created for this resource
>    * group, 0 otherwise.

ok

> @@ -532,7 +534,7 @@ static int rdtgroup_monitor_in_progress(struct rdtgroup *rdtgrp)
>   
>   /**
>    * rdtgroup_locksetup_user_restrict - Restrict user access to group
> - * @rdtgrp: resource group needing access restricted
> + * @rdtgrp: Resource group needing access restricted
>    *
>    * A resource group used for cache pseudo-locking cannot have cpus or tasks
>    * assigned to it. This is communicated to the user by restricting access
same

> @@ -582,7 +584,7 @@ static int rdtgroup_locksetup_user_restrict(struct rdtgroup *rdtgrp)
>   
>   /**
>    * rdtgroup_locksetup_user_restore - Restore user access to group
> - * @rdtgrp: resource group needing access restored
> + * @rdtgrp: Resource group needing access restored
>    *
>    * Restore all file access previously removed using
>    * rdtgroup_locksetup_user_restrict()
> @@ -629,7 +631,7 @@ static int rdtgroup_locksetup_user_restore(struct rdtgroup *rdtgrp)
>   
>   /**
>    * rdtgroup_locksetup_enter - Resource group enters locksetup mode
> - * @rdtgrp: resource group requested to enter locksetup mode
> + * @rdtgrp: Resource group requested to enter locksetup mode
>    *
>    * A resource group enters locksetup mode to reflect that it would be used
>    * to represent a pseudo-locked region and is in the process of being set
> @@ -744,8 +746,8 @@ int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp)
>   }
>   
>   /**
> - * rdtgroup_locksetup_exit - resource group exist locksetup mode
> - * @rdtgrp: resource group
> + * rdtgroup_locksetup_exit - Resource group exits locksetup mode
> + * @rdtgrp: Resource group
>    *
>    * When a resource group exits locksetup mode the earlier restrictions are
>    * lifted.

same

> @@ -1140,6 +1142,8 @@ static int measure_l3_residency(void *_plr)
>   
>   /**
>    * pseudo_lock_measure_cycles - Trigger latency measure to pseudo-locked region
> + * @rdtgrp: Resource group to which the pseudo-locked region belongs
> + * @sel: Selector of which measurement to perform on a pseudo-locked region
>    *
>    * The measurement of latency to access a pseudo-locked region should be
>    * done from a cpu that is associated with that pseudo-locked region.

ok

> @@ -1254,7 +1258,7 @@ static const struct file_operations pseudo_measure_fops = {
>   
>   /**
>    * rdtgroup_pseudo_lock_create - Create a pseudo-locked region
> - * @rdtgrp: resource group to which pseudo-lock region belongs
> + * @rdtgrp: Resource group to which pseudo-locked region belongs
>    *
>    * Called when a resource group in the pseudo-locksetup mode receives a
>    * valid schemata that should be pseudo-locked. Since the resource group is
> @@ -1385,7 +1389,7 @@ int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp)
>   
>   /**
>    * rdtgroup_pseudo_lock_remove - Remove a pseudo-locked region
> - * @rdtgrp: resource group to which the pseudo-locked region belongs
> + * @rdtgrp: Resource group to which the pseudo-locked region belongs
>    *
>    * The removal of a pseudo-locked region can be initiated when the resource
>    * group is removed from user space via a "rmdir" from userspace or the
> 

same

Reinette
