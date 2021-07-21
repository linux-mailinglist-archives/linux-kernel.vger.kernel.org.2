Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A74BB3D1833
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 22:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbhGUTyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 15:54:35 -0400
Received: from mga03.intel.com ([134.134.136.65]:59212 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229803AbhGUTyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 15:54:33 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10052"; a="211572527"
X-IronPort-AV: E=Sophos;i="5.84,258,1620716400"; 
   d="scan'208";a="211572527"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2021 13:35:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,258,1620716400"; 
   d="scan'208";a="496710070"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga001.jf.intel.com with ESMTP; 21 Jul 2021 13:35:08 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Wed, 21 Jul 2021 13:35:08 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Wed, 21 Jul 2021 13:35:07 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Wed, 21 Jul 2021 13:35:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kZ60ZM+i1xLhtz7PV7VdvWxAXIq2j2ePxp9eLpEZXAIahL/v0NQYuLjuEnrs43UQaEBWkSmMyrViw5CRf533ss38gOBju0tsDomRYTopjrH8IsCuVXkWKLUeezdSM+vcFffnyEukcYvrPasuwI7EI28+6wZ1xw9qXZKI2RTN2+KddNB937mWgZbm8xXZ/fAgjfthf9xMByjmAb63dDBY40GPhR2ZHYz24W8HjZrkhETOR4Pw8NA/in1ZmY7G/+S5mWW6hI/uR9rY/73Ptv/v6nHlC97udrxzjCIhCa1RasdQ3iHkq3hBMpBYjYttgkK6E3E3A9PhqgDhkatuxSpBzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/wWZ2Eqv074m8hw4sgHz6CSCIG0/nx2om3kfKalH28=;
 b=FvMgW0v/VwBOs+U3QnIM6QX5Hr6Fa6NMGloWPGNwstcSyXByJzhtK4rCYupbScC8z4YcNJWf5SX/60lU+B+FU5kmoyQqVEPHnxAx7Qoq7tYLOPsYSADiQXhxzUlFVhn0pJD+A1dD37ePpaeujR7w7TYRfdYIgdKEdK4aV+e0/Ld10h6sKXzzsA8MEHe03Urz9gWUVyVj+B0ixuSKpqu1jScd2dCTDL/bDqaJxrZrmayQhtYscgX+VLsWzxoLDdoWTJA/7RehbL1MLK8Gy7Mq1x/VUJDc7q3Nq/ll21oh35mSLQGEKwJ+IqTTBM5UcBCjP2ldq/KwPBmaCDvgAEEwgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/wWZ2Eqv074m8hw4sgHz6CSCIG0/nx2om3kfKalH28=;
 b=nklaAwdMeAcRegtvdfHtqzCiBgotnbtEY+bWB72AS6/M+wCXkeRprfW+9DaQt6tqnrlhzv1qOzE7SNcMeBGeHAubiAXJL1LPCsDrpk/CL4WzaKUnuZnqNrU7QU/Ljz2zhubro18L3tTG0OM5xuHiEXTZHUBIg/jYChw9K1k5fYQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
Received: from CH0PR11MB5740.namprd11.prod.outlook.com (2603:10b6:610:101::7)
 by CH0PR11MB5298.namprd11.prod.outlook.com (2603:10b6:610:bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22; Wed, 21 Jul
 2021 20:35:03 +0000
Received: from CH0PR11MB5740.namprd11.prod.outlook.com
 ([fe80::18b4:f645:1e96:1c3c]) by CH0PR11MB5740.namprd11.prod.outlook.com
 ([fe80::18b4:f645:1e96:1c3c%5]) with mapi id 15.20.4331.034; Wed, 21 Jul 2021
 20:35:03 +0000
Subject: Re: [PATCH v2] x86/resctrl: Fix kernel-doc in rdtgroup.c
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>
References: <20210721181519.6620-1-fmdefrancesco@gmail.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <3d022ce8-95b2-7465-eb51-e89daf0504ac@intel.com>
Date:   Wed, 21 Jul 2021 13:34:59 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
In-Reply-To: <20210721181519.6620-1-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR2101CA0020.namprd21.prod.outlook.com
 (2603:10b6:302:1::33) To CH0PR11MB5740.namprd11.prod.outlook.com
 (2603:10b6:610:101::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.219] (71.238.111.198) by MW2PR2101CA0020.namprd21.prod.outlook.com (2603:10b6:302:1::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.0 via Frontend Transport; Wed, 21 Jul 2021 20:35:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b7735a5-89b1-4ed5-36f0-08d94c8704cb
X-MS-TrafficTypeDiagnostic: CH0PR11MB5298:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR11MB5298CD6A9FBE4EE33B7A1402F8E39@CH0PR11MB5298.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2qvSoTQoIK5IdTPs/NjWf2m+wu5a2QtohvgMsdzEsRR3nGU5Z4wSsZyD5yIzDTiTZ9oG0KBcas6AOAFBA57AOeFdNVUkuM3nMFpjc4vlekIlzT7pSD+QzglAXHaN9Y90MIheObFxwxjS9l/9lU1Bt93M2eeIPxjkSmi1M7toc3YflcecR0vUZeaKB6NyjyJo4UEZYMWCnFvVCYjgbD9booXrKxiNviUYkC2DPQHjCaPK1vP934MQAxV49YmXliPpDJoAwXiJQP23dPueLkSfKnD3dmZXZAaBQYRIAvvwDHJGu2QawO1UySeEj1yafaErHRJ7OAEA+tGIuZbw30ze96UhU75qSCQd6wiFxQlK52rEts/L4JENXfjRN5gLo3Gd2MnGSVZNLh2t0y9qdOXQ90HVQElIDadi5owX1X8gplIkd3FYP0CHqIEw5LQVNomBaIjVzZ5N6heJd1WCbRgLVeBike+X2b7EfmYU3RmPvwUxmFd7xhv05Uj/2zsmenLm6swPy+KsJsIsahTr6aNFp+8AInkiCp27tYLUsLN3WZJClytF2D5zRnUGY6UvjFb1BlNrIfUAJebgcl/jRbW1TY6Zd3u8vPdvy+pGJ6qyWADXIh2xjF8lUab/ezNRF1oUGa7tGiXRzinrFE6TZogpWGYuUNWwIritpJaaRmj/0qoz84nNCAMowLm5ZqUoSQnBy00OPbZcStq6GIEvX0tgumZbi42hTRwTVR6COWp1GvU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5740.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(478600001)(6486002)(66556008)(2906002)(53546011)(26005)(38100700002)(31686004)(31696002)(316002)(16576012)(110136005)(2616005)(86362001)(66476007)(186003)(8936002)(66946007)(6666004)(8676002)(36756003)(44832011)(5660300002)(956004)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGxDZStqNFdrMTdwSWlNTmtWTUNiVkFLM09TS1I5YnZPUGpXTXpXZUN4UVlW?=
 =?utf-8?B?ZWZ1clBxYlRmaDNqL0lhbEJZMUE2aWpRNG9Ud1ZKZFE0TWNaUlNFTE05bzN6?=
 =?utf-8?B?eXh3MnMyRlF5aDJ6STRwTkRXOXlHbDNoZHZXL3c3YVdLNm9oOEtWQW5IZk9J?=
 =?utf-8?B?TlVCWkZkdm5vVWNLbWNST0pWenV6WTRnVUExdzFCeWZVUXFHaitwWFlGayt6?=
 =?utf-8?B?MFcyalRBdmtPdzNTOEt6U1kvYTJBbnprVFMrNWdwbC9ES2N6Sm1OQWtZaENl?=
 =?utf-8?B?aDQ0MWozTTlUbkdFb2JURTBkbUNSN0J2ZHJZZFFVWlJ3UzdUaVlFK29ZQ1dL?=
 =?utf-8?B?V0VQQ1JXV08vZFQybE9HSVVXL2FwWE9obnJ4UXNrUXl0ZFc1emY1Mk1OaGhI?=
 =?utf-8?B?Vm01Yit3NS9IVDA0UjEwRmVud0lpazR3b2xvclFyYk9uWmx0ZG03MHBLTjli?=
 =?utf-8?B?RWdwZmNPN2FNZ2xNaE9uS2lyTjBHcExNT2FlbldoRkVJVUF6TldvQmd3dlJm?=
 =?utf-8?B?M0l0bStvUXpXdWNUTjRxSkZqdkhjeGtvV1ZZbUI1ejVmUVdJeVZ4OUdOSVNs?=
 =?utf-8?B?aWpoRHdqZUJNRVZBUVdUQ29xY1B4ekFmcnp2LzZyeFpJZkRGY0plb1dhMmpE?=
 =?utf-8?B?RzUzNy9pd2lDNVUwZ2N0bmFSNFFGQVJVd0hNWG8ySy9tTUdoZklqanBtN2xB?=
 =?utf-8?B?em5YNXE4MnNNSlZmU0MyNXVnNjJzVFowcTFnRE5wRWpxTEdEMDNoeStuZzQw?=
 =?utf-8?B?cEVIZ2NESGcxNkhybEYybUplTEtRblFWekNwSVZxejUzSkZNZXZoVmVLTmg1?=
 =?utf-8?B?ZXpGdjVFa3FLSGRFcm92RFk5dWs5ckpPLytHT2dYN0h3dlJHb21DRERqdUIx?=
 =?utf-8?B?bFFhRlMyM2F3QlEzSDdKQVlFUUhqMWdDRTlVVkhxVTc1Yld6bTR6M3B2OW1O?=
 =?utf-8?B?TXF3eVBEWWFyNlF5bGk1SENZNDZOZDVyUXQyTFhFRWVJSTAwK0VwRGdveEEy?=
 =?utf-8?B?OVFTMnZqZVhaQjVQNWVuRk9QdnliQ2srQm5SSU9raFFPNmJ1a2VuN3M5a2pp?=
 =?utf-8?B?djUrKzBKWlZOTzZFWWkyamxOUmxYSmZtQUM1d0pvL2RlQVJaYThZK29CYjJG?=
 =?utf-8?B?RGlSbTgybytIQUUrR1FEWTh3TTNidFhMVDdEcnF0bTByOE14MmZ3MkFDTVcr?=
 =?utf-8?B?YUI2WGlqeUhrTjRiS25xYVIvWThGTURHc3Rsd0ZjeXdkcFFsYURIczIxa2Jv?=
 =?utf-8?B?bkJnZVZLR2JKR3FOdmJrWWE4SzRLMlpXK0k0bXE0QWk3SVhEdmliM1pCYkxr?=
 =?utf-8?B?UWxpUE9aUzlKbXFRTms4TnZzUEVmdktWRmQ1azFxNjZlWFgycUFFTDJmM0xB?=
 =?utf-8?B?ZjBTckVDSGczNFlaTy96L3o1UzFKbHJ3eitnL3BUcC9uejJ2TWt5MlZCalNw?=
 =?utf-8?B?dWxIUHJJVUNtRXlYdEdmWllzZDdkYnJxZnNxTDdTelFHek5FWUJuNFNNMVFN?=
 =?utf-8?B?dVdVNXYyQUEwdE9XZVAvbEdYYy9kS2NUWG9nOU91b29uRWI3RVRReUYwSlRL?=
 =?utf-8?B?NnNYZmxKdHRaS3QyQTB2Mkplb0ZxaFlicmc1Q0dUZk9OaG9idTlEMUc4VEFX?=
 =?utf-8?B?eHZBVWVLM1N5d1hvNU0wcHhlNVIyZkJtd2lPcU96WlVGTTZkYnNHdlRZdlRZ?=
 =?utf-8?B?c0hNQWxhbnQ2UDNCRVVqZzV5WVhlYmdOY2d0Y2FZalppdi9zTUp6b1NiMnY1?=
 =?utf-8?Q?dn4w2M2yp2iIm96QHy2nvQ1nYlGKe7OFNZVYE2x?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b7735a5-89b1-4ed5-36f0-08d94c8704cb
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5740.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2021 20:35:03.6389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xwDPFOAF61yhryHGXYY/OtiZ6375lNmZKvivKH7TNoeqpEXW2j+kwtZQ79syuRs51VRog9qaHbPIeTo1hS1llnbnSX/qCsolxo5yjyEtuMM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5298
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,

On 7/21/2021 11:15 AM, Fabio M. De Francesco wrote:
> Add description of undocumented parameters. Issues detected by
> scripts/kernel-doc.
> 
> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>

This tag is used when somebody suggested that this work be done in the 
first place - to recognize the original idea. It is not used to 
recognize review feedback. In this case the kerneldoc cleanup is your 
work initiated by you so you should remove this tag.

> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
> 
> v1 --> v2:
> Change some parameter descriptions according to the suggestions of
> Reinette Chatre.
> 
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 01fd30e7829d..b51513661469 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -877,6 +877,9 @@ static int rdt_shareable_bits_show(struct kernfs_open_file *of,
>   
>   /**
>    * rdt_bit_usage_show - Display current usage of resources
> + * @of: pointer to opened "bit_usage" info file
> + * @seq: seq_file used to format output to "bit_usage"
> + * @v: unused pointer to void
>    *
>    * A domain is a shared resource that can now be allocated differently. Here
>    * we display the current regions of the domain as an annotated bitmask.
> @@ -888,6 +891,8 @@ static int rdt_shareable_bits_show(struct kernfs_open_file *of,
>    *   S - currently used and shareable by software only
>    *   E - currently used exclusively by one resource group
>    *   P - currently pseudo-locked by one resource group
> + *
> + * Return: 0
>    */
>   static int rdt_bit_usage_show(struct kernfs_open_file *of,
>   			      struct seq_file *seq, void *v)
> @@ -1243,6 +1248,7 @@ bool rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d,
>   
>   /**
>    * rdtgroup_mode_test_exclusive - Test if this resource group can be exclusive
> + * @rdtgrp: resource group
>    *
>    * An exclusive resource group implies that there should be no sharing of
>    * its allocated resources. At the time this group is considered to be
> @@ -1283,7 +1289,12 @@ static bool rdtgroup_mode_test_exclusive(struct rdtgroup *rdtgrp)
>   
>   /**
>    * rdtgroup_mode_write - Modify the resource group's mode
> + * @of: pointer to opened "mode" file of a resource group
> + * @buf: data from user-space
> + * @nbytes: length of input data buffer
> + * @off: unsupported offset to input
>    *
> + * Return: @nbytes on success, <0 on failure
>    */
>   static ssize_t rdtgroup_mode_write(struct kernfs_open_file *of,
>   				   char *buf, size_t nbytes, loff_t off)
> @@ -1367,6 +1378,8 @@ static ssize_t rdtgroup_mode_write(struct kernfs_open_file *of,
>    *
>    * @cbm is unsigned long, even if only 32 bits are used to make the
>    * bitmap functions work correctly.
> + *
> + * Return: how many bytes of the cache are represented by @cbm.
>    */
>   unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r,
>   				  struct rdt_domain *d, unsigned long cbm)
> @@ -1389,10 +1402,14 @@ unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r,
>   
>   /**
>    * rdtgroup_size_show - Display size in bytes of allocated regions
> + * @of: pointer to opened "size" file of a resource group
> + * @s: seq_file used to format output to "size"
> + * @v: unused pointer to void
>    *
>    * The "size" file mirrors the layout of the "schemata" file, printing the
>    * size in bytes of each region instead of the capacity bitmask.
>    *
> + * Return: 0 on success, <0 on failure
>    */
>   static int rdtgroup_size_show(struct kernfs_open_file *of,
>   			      struct seq_file *s, void *v)
> @@ -2618,6 +2635,8 @@ static int mkdir_mondata_all(struct kernfs_node *parent_kn,
>    * resource group is initialized. The user can follow this with a
>    * modification to the CBM if the default does not satisfy the
>    * requirements.
> + *
> + * Return: A valid CBM, 0 if @_val is only 0 filled
>    */
>   static u32 cbm_ensure_valid(u32 _val, struct rdt_resource *r)
>   {
> 

Before these fixes:

$ scripts/kernel-doc -none arch/x86/kernel/cpu/resctrl/rdtgroup.c
arch/x86/kernel/cpu/resctrl/rdtgroup.c:894: warning: Function parameter 
or member 'of' not described in 'rdt_bit_usage_show'
arch/x86/kernel/cpu/resctrl/rdtgroup.c:894: warning: Function parameter 
or member 'seq' not described in 'rdt_bit_usage_show'
arch/x86/kernel/cpu/resctrl/rdtgroup.c:894: warning: Function parameter 
or member 'v' not described in 'rdt_bit_usage_show'
arch/x86/kernel/cpu/resctrl/rdtgroup.c:1257: warning: Function parameter 
or member 'rdtgrp' not described in 'rdtgroup_mode_test_exclusive'
arch/x86/kernel/cpu/resctrl/rdtgroup.c:1290: warning: Function parameter 
or member 'of' not described in 'rdtgroup_mode_write'
arch/x86/kernel/cpu/resctrl/rdtgroup.c:1290: warning: Function parameter 
or member 'buf' not described in 'rdtgroup_mode_write'
arch/x86/kernel/cpu/resctrl/rdtgroup.c:1290: warning: Function parameter 
or member 'nbytes' not described in 'rdtgroup_mode_write'
arch/x86/kernel/cpu/resctrl/rdtgroup.c:1290: warning: Function parameter 
or member 'off' not described in 'rdtgroup_mode_write'
arch/x86/kernel/cpu/resctrl/rdtgroup.c:1399: warning: Function parameter 
or member 'of' not described in 'rdtgroup_size_show'
arch/x86/kernel/cpu/resctrl/rdtgroup.c:1399: warning: Function parameter 
or member 's' not described in 'rdtgroup_size_show'
arch/x86/kernel/cpu/resctrl/rdtgroup.c:1399: warning: Function parameter 
or member 'v' not described in 'rdtgroup_size_show'
$

After these fixes:

$ scripts/kernel-doc -none arch/x86/kernel/cpu/resctrl/rdtgroup.c
$

Thank you very much for these fixes.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
