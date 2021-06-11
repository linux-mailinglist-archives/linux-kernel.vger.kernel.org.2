Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F37BE3A4B1F
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 01:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbhFKXTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 19:19:12 -0400
Received: from mga02.intel.com ([134.134.136.20]:8431 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229976AbhFKXTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 19:19:10 -0400
IronPort-SDR: YPse3osgHfrphpgrbt7OQW/CaWKeW7dhE10dySQOCTVRmZZtC5t/wOvgM/NL4i2KKCYnNvcfAl
 3YcfN7HByCpg==
X-IronPort-AV: E=McAfee;i="6200,9189,10012"; a="192738455"
X-IronPort-AV: E=Sophos;i="5.83,267,1616482800"; 
   d="scan'208";a="192738455"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 16:17:11 -0700
IronPort-SDR: dxuZh7dIRje1lEef5OpscOfpbaegiQpAP7Fgq9ui2qZXltgye2qh2Jy2/EAtToSuvbqblzU6eQ
 /XitDKWDRSjQ==
X-IronPort-AV: E=Sophos;i="5.83,267,1616482800"; 
   d="scan'208";a="403363262"
Received: from rchatre-mobl3.amr.corp.intel.com (HELO [10.212.232.130]) ([10.212.232.130])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 16:17:11 -0700
Subject: Re: [PATCH] x86/resctrl: Fix kernel-doc in internal.h
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20210609005415.6993-1-fmdefrancesco@gmail.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <4d5608bf-668a-a500-bad9-ab49e3d1c505@intel.com>
Date:   Fri, 11 Jun 2021 16:17:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210609005415.6993-1-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,

Please also consider my comments regarding the goal of this patch 
similar to what I mentioned in my response to your changes to the 
pseudo_lock.c file. I updated a few descriptions to improve accuracy and 
noted some formatting issues. Apart from these small issues it is 
looking good, thank you.

On 6/8/2021 5:54 PM, Fabio M. De Francesco wrote:
> Added description of undocumented parameters. Fixed some minor
> kernel-doc grammar issues. Issues largely detected by
> scripts/kernel-doc.
> 
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>   arch/x86/kernel/cpu/resctrl/internal.h | 28 ++++++++++++++++----------
>   1 file changed, 17 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index c4d320d02fd5..f360944a7ae1 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -68,8 +68,9 @@ DECLARE_STATIC_KEY_FALSE(rdt_mon_enable_key);
>   
>   /**
>    * struct mon_evt - Entry in the event list of a resource
> - * @evtid:		event id
> - * @name:		name of the event
> + * @evtid:		Event id
> + * @name:		Name of the event
> + * @list:		List head

The only kernel-doc issue here is the missing @list. To just fix the 
issue while remaining consistent with the existing formatting you could 
continue by describing @list with lower case even if other areas do so 
with upper case.

For that description could you please use more descriptive language - 
writing something like "List head" does not help the reader. Something like:

"@list: list entry in &rdt_resource->evt_list"

>    */
>   struct mon_evt {
>   	u32			evtid;
> @@ -78,10 +79,12 @@ struct mon_evt {
>   };
>   
>   /**
> - * struct mon_data_bits - Monitoring details for each event file
> - * @rid:               Resource id associated with the event file.
> + * union mon_data_bits - Monitoring details for each event file
> + * @priv:	       Private data for the union	
> + * @rid:               Resource id associated with the event file
>    * @evtid:             Event id associated with the event file
>    * @domid:             The domain to which the event file belongs
> + * @u:		       Name of the bit fields struct
>    */

Spacing got broken here with some unintended tabs added as well as 
trailing space.

This is a union where @priv and @u refers to the same storage. More 
detail can be added to help the reader:
"@priv: used to store monitoring event data in @u as kernfs private data"

>   union mon_data_bits {
>   	void *priv;
> @@ -119,6 +122,7 @@ enum rdt_group_type {
>    * @RDT_MODE_PSEUDO_LOCKSETUP: Resource group will be used for Pseudo-Locking
>    * @RDT_MODE_PSEUDO_LOCKED: No sharing of this resource group's allocations
>    *                          allowed AND the allocations are Cache Pseudo-Locked
> + * @RDT_NUM_MODES: Total number of modes
>    *
>    * The mode of a resource group enables control over the allowed overlap
>    * between allocations associated with different resource groups (classes
> @@ -142,7 +146,7 @@ enum rdtgrp_mode {
>   
>   /**
>    * struct mongroup - store mon group's data in resctrl fs.
> - * @mon_data_kn		kernlfs node for the mon_data directory
> + * @mon_data_kn:		kernlfs node for the mon_data directory
>    * @parent:			parent rdtgrp
>    * @crdtgrp_list:		child rdtgroup node list
>    * @rmid:			rmid for this rdtgroup
> @@ -282,11 +286,11 @@ struct rftype {
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

Above changes look good, thanks.

> @@ -450,18 +454,20 @@ struct rdt_parse_data {
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
> - * @fflags:		flags to choose base and info files
> + * @mbm_width:		Width of memory bandwidth monitoring counter
> + * @fflags:		Flags to choose base and info files
>    */
>   struct rdt_resource {
>   	int			rid;
> 

I think one small addition would be helpful to the reader:
"@mbm_width: Width of memory bandwidth monitoring hardware counter"

Thank you!

Reinette

