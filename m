Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA953A88F4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 20:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbhFOS4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 14:56:51 -0400
Received: from mga04.intel.com ([192.55.52.120]:12125 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229749AbhFOS4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 14:56:50 -0400
IronPort-SDR: KHFzrL2R87RmK/5ddrXGDwQYykEKgZGozNrj2KosmhrCEvh9ZVeirX6LbVkQMR8imuM2qIWyg6
 a/ydJ5Pgdf2A==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="204221758"
X-IronPort-AV: E=Sophos;i="5.83,276,1616482800"; 
   d="scan'208";a="204221758"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 11:54:45 -0700
IronPort-SDR: jaJ2gvC1b1D5ieUsx0rvfTEKNKc/dFLZrDrCnZROHg04VNXJ9OU7pELTYuZTcyZiP/HW+l+og9
 hWBBbhg7Ar8g==
X-IronPort-AV: E=Sophos;i="5.83,276,1616482800"; 
   d="scan'208";a="554542454"
Received: from rchatre-mobl3.amr.corp.intel.com (HELO [10.212.184.247]) ([10.212.184.247])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 11:54:32 -0700
Subject: Re: [PATCH v3] x86/resctrl: Fix kernel-doc in pseudo_lock.c
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
References: <20210614150929.3151-1-fmdefrancesco@gmail.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <94862dff-afbe-10df-3f5c-e9d5c6c90afc@intel.com>
Date:   Tue, 15 Jun 2021 11:54:29 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210614150929.3151-1-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,

On 6/14/2021 8:09 AM, Fabio M. De Francesco wrote:
> Add undocumented parameters detected by scripts/kernel-doc.
> 
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---

...

> diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> index 05a89e33fde2..84b9bf4daa33 100644
> --- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> +++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> @@ -49,6 +49,7 @@ static struct class *pseudo_lock_class;
>   
>   /**
>    * get_prefetch_disable_bits - prefetch disable bits of supported platforms
> + * @void: It takes no parameters.
>    *
>    * Capture the list of platforms that have been validated to support
>    * pseudo-locking. This includes testing to ensure pseudo-locked regions
> @@ -162,8 +163,9 @@ static struct rdtgroup *region_find_by_minor(unsigned int minor)
>   }
>   
>   /**
> - * pseudo_lock_pm_req - A power management QoS request list entry
> - * @list:	Entry within the @pm_reqs list for a pseudo-locked region
> + * struct pseudo_lock_pm_req - A power management QoS request list entry
> + * @list:	Entry within the power management requests list for a
> + *		pseudo-locked region

Adding "struct" is surely needed.

Regarding the description of list I prefer the original text. Consider 
the scenario where somebody is trying to understand this code and using 
a source code browser ... the original description would enable a direct 
transition to where pm_reqs is defined with more descriptions and 
context to understand the code.


> @@ -184,6 +186,7 @@ static void pseudo_lock_cstates_relax(struct pseudo_lock_region *plr)
>   
>   /**
>    * pseudo_lock_cstates_constrain - Restrict cores from entering C6
> + * @plr: Pseudo-locked region
>    *
>    * To prevent the cache from being affected by power management entering
>    * C6 has to be avoided. This is accomplished by requesting a latency
> @@ -196,6 +199,8 @@ static void pseudo_lock_cstates_relax(struct pseudo_lock_region *plr)
>    * the ACPI latencies need to be considered while keeping in mind that C2
>    * may be set to map to deeper sleep states. In this case the latency
>    * requirement needs to prevent entering C2 also.
> + *
> + * Return: 0 on success, <0 on failure
>    */
>   static int pseudo_lock_cstates_constrain(struct pseudo_lock_region *plr)
>   {
> @@ -520,7 +525,7 @@ static int pseudo_lock_fn(void *_rdtgrp)
>   
>   /**
>    * rdtgroup_monitor_in_progress - Test if monitoring in progress
> - * @r: resource group being queried
> + * @rdtgrp: resource group being queried
>    *
>    * Return: 1 if monitor groups have been created for this resource
>    * group, 0 otherwise.
> @@ -1140,6 +1145,8 @@ static int measure_l3_residency(void *_plr)
>   
>   /**
>    * pseudo_lock_measure_cycles - Trigger latency measure to pseudo-locked region
> + * @rdtgrp: Resource group to which the pseudo-locked region belongs.
> + * @sel: Selector of which measurement to perform on a pseudo-locked region.
>    *
>    * The measurement of latency to access a pseudo-locked region should be
>    * done from a cpu that is associated with that pseudo-locked region.
> 

The rest looks good, thank you very much.

Reinette
