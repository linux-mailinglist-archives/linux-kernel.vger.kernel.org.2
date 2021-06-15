Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 113613A8A57
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 22:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbhFOUnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 16:43:40 -0400
Received: from mga07.intel.com ([134.134.136.100]:49406 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229965AbhFOUnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 16:43:39 -0400
IronPort-SDR: 0HWDmH40JguQDCUTzJ+uAz7Iqzdy1OfNTEmraX8pEe5twsGNVsSj2WXWVobGn2qnxpZo3LfsPH
 GrPWF4ejX7Cg==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="269914818"
X-IronPort-AV: E=Sophos;i="5.83,276,1616482800"; 
   d="scan'208";a="269914818"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 13:41:33 -0700
IronPort-SDR: /hSkReECSqWv/rCkZp2GbefM6oQT3192AOk7kOVrkfvIP2z2UaChDBjHzwhEjXL4+w0CDZiUPk
 koqubvrfOvwg==
X-IronPort-AV: E=Sophos;i="5.83,276,1616482800"; 
   d="scan'208";a="554565107"
Received: from rchatre-mobl3.amr.corp.intel.com (HELO [10.212.184.247]) ([10.212.184.247])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 13:41:24 -0700
Subject: Re: [PATCH v2] x86/resctrl: Fix kernel-doc in internal.h
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
References: <20210614154438.17075-1-fmdefrancesco@gmail.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <4f1825cc-5d80-c1b1-b56b-7f2535e406f7@intel.com>
Date:   Tue, 15 Jun 2021 13:41:08 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210614154438.17075-1-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,

On 6/14/2021 8:44 AM, Fabio M. De Francesco wrote:
> Add description of undocumented parameters. Issues detected by
> scripts/kernel-doc.
> 
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
> 
> v1->v2: According to a first review by Reinette Chartre, remove changes
> unrelated to the subject of this patch and modify the descriptions of
> two parameters.
>   
>   arch/x86/kernel/cpu/resctrl/internal.h | 23 +++++++++++++++--------
>   1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index c4d320d02fd5..ac691af0174b 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -70,6 +70,7 @@ DECLARE_STATIC_KEY_FALSE(rdt_mon_enable_key);
>    * struct mon_evt - Entry in the event list of a resource
>    * @evtid:		event id
>    * @name:		name of the event
> + * @list:		entry in &rdt_resource->evt_list
>    */
>   struct mon_evt {
>   	u32			evtid;
> @@ -78,10 +79,13 @@ struct mon_evt {
>   };
>   
>   /**
> - * struct mon_data_bits - Monitoring details for each event file
> - * @rid:               Resource id associated with the event file.
> + * union mon_data_bits - Monitoring details for each event file
> + * @priv:	       Used to store monitoring event data in @u
> + * 		       as kernfs private data
> + * @rid:               Resource id associated with the event file
>    * @evtid:             Event id associated with the event file
>    * @domid:             The domain to which the event file belongs
> + * @u:		       Name of the bit fields struct
>    */

This snippet is whitespace damaged. Your changes add tabs as well as 
spaces while the existing code uses just spaces. Please follow existing 
style of this area and just use spaces. As a note for any future 
changes, in one line you add spaces before tabs, that is generally not 
the right formatting in kernel-doc - running scripts/checkpatch.pl on 
this patch would also warn about this.

>   union mon_data_bits {
>   	void *priv;
> @@ -119,6 +123,7 @@ enum rdt_group_type {
>    * @RDT_MODE_PSEUDO_LOCKSETUP: Resource group will be used for Pseudo-Locking
>    * @RDT_MODE_PSEUDO_LOCKED: No sharing of this resource group's allocations
>    *                          allowed AND the allocations are Cache Pseudo-Locked
> + * @RDT_NUM_MODES: Total number of modes
>    *
>    * The mode of a resource group enables control over the allowed overlap
>    * between allocations associated with different resource groups (classes
> @@ -142,7 +147,7 @@ enum rdtgrp_mode {
>   
>   /**
>    * struct mongroup - store mon group's data in resctrl fs.
> - * @mon_data_kn		kernlfs node for the mon_data directory
> + * @mon_data_kn:		kernlfs node for the mon_data directory

Sorry I did not notice this before, could you please also fix the typo 
kernlfs -> kernfs ?

>    * @parent:			parent rdtgrp
>    * @crdtgrp_list:		child rdtgroup node list
>    * @rmid:			rmid for this rdtgroup
> @@ -282,11 +287,11 @@ struct rftype {
>   /**
>    * struct mbm_state - status for each MBM counter in each domain
>    * @chunks:	Total data moved (multiply by rdt_group.mon_scale to get bytes)
> - * @prev_msr	Value of IA32_QM_CTR for this RMID last time we read it
> + * @prev_msr:	Value of IA32_QM_CTR for this RMID last time we read it
>    * @prev_bw_msr:Value of previous IA32_QM_CTR for bandwidth counting
> - * @prev_bw	The most recent bandwidth in MBps
> - * @delta_bw	Difference between the current and previous bandwidth
> - * @delta_comp	Indicates whether to compute the delta_bw
> + * @prev_bw:	The most recent bandwidth in MBps
> + * @delta_bw:	Difference between the current and previous bandwidth
> + * @delta_comp:	Indicates whether to compute the delta_bw
>    */
>   struct mbm_state {
>   	u64	chunks;
> @@ -450,17 +455,19 @@ struct rdt_parse_data {
>    * @name:		Name to use in "schemata" file
>    * @num_closid:		Number of CLOSIDs available
>    * @cache_level:	Which cache level defines scope of this resource
> - * @default_ctrl:	Specifies default cache cbm or memory B/W percent.
> + * @default_ctrl:	Specifies default cache cbm or memory B/W percent
>    * @msr_base:		Base MSR address for CBMs
>    * @msr_update:		Function pointer to update QOS MSRs
>    * @data_width:		Character width of data when displaying
>    * @domains:		All domains for this resource
>    * @cache:		Cache allocation related data
> + * @membw:		Memory bandwidth allocation related data
>    * @format_str:		Per resource format string to show domain value
>    * @parse_ctrlval:	Per resource function pointer to parse control values
>    * @evt_list:		List of monitoring events
>    * @num_rmid:		Number of RMIDs available
>    * @mon_scale:		cqm counter * mon_scale = occupancy in bytes
> + * @mbm_width:		Width of memory bandwidth monitoring hardware counter
>    * @fflags:		flags to choose base and info files
>    */

Fixes to membw and mbm_width are also arriving via another patch series 
(see commit 
https://lore.kernel.org/lkml/20210614200941.12383-2-james.morse@arm.com/).
To make it easier to merge that patch and yours could you please inherit 
the descriptions from there?

@mbm_width: Monitor width, to detect and correct for overflow.
@membw: If the component has bandwidth controls, their properties.

Thank you

Reinette
