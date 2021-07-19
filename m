Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D490A3CEF4B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 00:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390004AbhGSVhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 17:37:33 -0400
Received: from mga11.intel.com ([192.55.52.93]:23999 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242885AbhGSVNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 17:13:11 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10050"; a="208020345"
X-IronPort-AV: E=Sophos;i="5.84,253,1620716400"; 
   d="scan'208";a="208020345"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 14:53:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,253,1620716400"; 
   d="scan'208";a="461760257"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 19 Jul 2021 14:53:45 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Mon, 19 Jul 2021 14:53:44 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Mon, 19 Jul 2021 14:53:44 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.42) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Mon, 19 Jul 2021 14:53:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aj5Y0Q1w3RI7gXfCxSbwma7/4jvQxRQw7NiQVnTxWqWoVOZLmhetxkDTO8y0ii/D2jlKTkz8DmOXO2GJS3cgr3Y5b1azv3iJ/09K0ImnKxXhx1/lgNnz8ahIBrRhDfEnUkRlPT+a12pivRcNJeeYG84AVqeZ1mBGCiM1DTizAHiMP/6/SIJS0SGieWulJd3IypS5lgIgKGbbwU9B0ZyXmtA3mFg1evG17cV6MvVDOF9VPeig4e/QW3cpQWyUdvZ+890S4yUw2edIatD7dM426BCr9ZBgMU67/accHt7/xUiTZ+gmWb+si1aiJBk5J6OH/IG+IW1+6ISx5uDjWmRdMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OYWVxAIc9gLuFA9Lw73PlAqft09bZ4QkHSiZ9FXBeq8=;
 b=RZEW99pA3v30ihstKS7jw8JZaPMKiN2dp8PUf+gb3JV74ug4EYbQ85a15ZD4BYHpPSJTO6rUoUS01luxtpTpkiBKwfskqXmMtAMuZSaNY1OUwdqkK1pPeLk2Nr4qdHqMDpk6SvmASbEi7a0YtTco2kf8NpBlbXUCAf4FPnuFWIF6K1JAzPVeIM41eBWBQTYTNdzXoFKoR+BkejWh7biUCMeTF1+Opj0ZJwcMLG299Te3LdfKipfCi5AuX0skhgQ2W587mi6ua26OX8BRAzy0h9PYxy2M1KXYoK5BDSbal6DJYiclVBcvj3oQdriEiJ6e7qIdTC3RFGDLJ/4+uQUZmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OYWVxAIc9gLuFA9Lw73PlAqft09bZ4QkHSiZ9FXBeq8=;
 b=WYIiPmmiI/bijCkuoOTbciPoCGwti06HbKs9Xt7+94UfDaArbHHZbgvsNGvAYPoKlIp+UDmd5hCMPIHTJfD1hcZzNgN/lL5BFUUznRbfxL0EGZQF40sNh26u/o9LL1jOBjOY7w1Z5lRbnn2eOPuj5j4kpfaDKKXFrBYZ1A5rSfw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN9PR11MB5385.namprd11.prod.outlook.com (2603:10b6:408:11a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Mon, 19 Jul
 2021 21:53:43 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::202f:e602:3983:e631]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::202f:e602:3983:e631%8]) with mapi id 15.20.4331.033; Mon, 19 Jul 2021
 21:53:43 +0000
Subject: Re: [PATCH] x86/resctrl: Fix kernel-doc in rdtgroup.c
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>
References: <20210707112906.9971-1-fmdefrancesco@gmail.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <5cb32691-6e63-ad52-66df-15517f50a2ab@intel.com>
Date:   Mon, 19 Jul 2021 14:53:39 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
In-Reply-To: <20210707112906.9971-1-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0023.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::36) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.219] (71.238.111.198) by BY5PR17CA0023.namprd17.prod.outlook.com (2603:10b6:a03:1b8::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Mon, 19 Jul 2021 21:53:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f31f518a-07e8-4e82-e578-08d94affacee
X-MS-TrafficTypeDiagnostic: BN9PR11MB5385:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR11MB5385E0393B84EAD63B90087BF8E19@BN9PR11MB5385.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s5OKevb46PGgFX6ARQogHIwILy3NrE/IsCPi0WGtw6nwZEF0ntjCUyZYkc00dNwJp5NT18dwz77sDgG8THgaIycua8Izkhklc3G+6a6kFyF9eV4iLIT5pv2VFAq2s9NtpHuKrzrAI6cDnKDSOEi6c12i2K6xOsqdLPfzM99tJzcUpGSNt3aCWTQACOm3zcYprX5d///C8t5QBhSb/gw1Fh01YOA02cm6DPi2KG6ZcgrndFH3PvaygrSSNCma0RlmOjCknxaZ5t55LJzqy+7wMRCUlkgjIUAh7Yot6hCJMnWQFB00NfVOUP/1MJM2bLnkIiYDvJ6jU7p2yXuNksLXmUTYYutYvBcGOeTGPEsbHskBYpoiR1UBDC7T9PueT3hjlRk5VLL6S6yuLvsou/HATq39zRvg2oPLnxszEDdg9AZlLUrsgHeTwdi0SlIkFj/2D3ufbl1brZ1M1DjkSThiwloHSPqHFLmqfT2mQ0KL5qbU+WCpvjO5Ezn7jvmGBvksWGoTJFVXVTtbjktxtOGagrjcKd45O9tEU+qERGpsTjHnIJVBfSPx2OAPom0Td4RC1JWz/YJ6h93wrGv09fEg+eREsq+akxoTdOvSA3hPkAULNpTpYBm/0TjIjlKhRyxdUb5mrgfagoPUAMVPDFr2yaAI58ok9wQg4o8bzE/wm5ozAtm7Hu456lAREsK1+BDgE8FHGUAwznrdwFGWeMVOQtzAdUCHXVpPk3UhxWcUEU4jjF7TAO/n3fyBT3zMT0h3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(366004)(136003)(346002)(31686004)(110136005)(36756003)(6486002)(53546011)(186003)(44832011)(8936002)(2616005)(66476007)(66946007)(66556008)(956004)(2906002)(8676002)(26005)(478600001)(31696002)(16576012)(38100700002)(316002)(83380400001)(86362001)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFlVUFphS3BIVWkvZzZVbXFvTmRFQ3FtZWhmWW5PY2JpQlhlTlJRVnNWQTIw?=
 =?utf-8?B?ZzBzY3lyVHVBbW5QNUI5OGh2Smo2eVU4RDFOMmhtZEVaSkc3S3B1ZnZzVlVD?=
 =?utf-8?B?VUpBbkt2cThBN3FROHFTOHhraVg3aUgzL0pHZzAxL21NUUc5Zy9MK01zV0Vu?=
 =?utf-8?B?dktBOTJYV2RIYk5KMDhCR2o0WE1DamkvRWRsWWQ2TWVaaFhma2R3dWJodms4?=
 =?utf-8?B?aXFrcG5qWU0yengxN3BOeE5ieWtqZVJiMTB4L1l0V0N2R2JtYzdRU2RIY25S?=
 =?utf-8?B?RjRQamlYVkxUTnVJNEtmd0Qxd044dEhMYWtEbC81YmN1OWpWR0JzUmswaEY5?=
 =?utf-8?B?S0YwcTF6VTU2UHZXcXRpV1NwMmVpOGpjc2pvdUZrY1czM05wTmJ4Q2REWjVp?=
 =?utf-8?B?WXJlWHZYRnVTRlY4N2pEVnV4bTJIWG9qdzJpRFhDeG9tVXFZUUFMNHk5Qlox?=
 =?utf-8?B?L1R2VUhORmpvVnh6SUJKbUxkbDlERW43ZWpNaTVJN0d3NzNETFBPWUVyRkcx?=
 =?utf-8?B?ZmJuYmZrOU1McHhqNFBkS0pQVzNEOG9sUTROMWdTbWV3SmVvYXVwakhpcGRH?=
 =?utf-8?B?djlMRGxqZFdxUXlCUmMvQlpxcFpHdEF3eUhEL3FiclhHMDlpdEpZMmZzRmVB?=
 =?utf-8?B?SXhndm1vWGhxZ2lRL25MdFJxUEFzWmVUNkF5V1BFVExjRktWQTV4QVJQRmJs?=
 =?utf-8?B?bWMybGFMVC9yalN3OWFwL2RSWnhNcExhcERCdHRrNmRIMXBocXUrRnJXQVRQ?=
 =?utf-8?B?Z2IyMi9EZTR2ZUNVcVVNdWEvM29KdGxJS1NvWU5jN3duQjEvWGxCWUZOSmJJ?=
 =?utf-8?B?dE85MWJtSHVuZ0JxRTFQbEZwSW05VEhSNlV3NXFSQTdFdUYzdWFWWXc2dGZm?=
 =?utf-8?B?a2h6SFJUajArNUZXazBPaERzUlVjVGpTcmpHRS9CZnZQNnM5SHlnSGViV1ZF?=
 =?utf-8?B?a09FSklSdS9BKy9ra2dNYS9LYXIrTk1wSzFSS3RQQjRSWlVLeXYvdzNBN3ZY?=
 =?utf-8?B?bFFCd0dYano3dk5sV1lMVzg5ejg3S04vL2hUVDBsZHNxN0wxOUJFVFNyeE9m?=
 =?utf-8?B?UGE0akVJMEVveWVCQjB5NnZvb0JaS1QyUVdBV3R4VzhtemFJaC9Ka3ZoQ2J1?=
 =?utf-8?B?WVAwRXlRRTJBUys3R2NoM2lvMEttUTF6UnBVdjd2VXJ3bzBvMnVaV1lBTi8z?=
 =?utf-8?B?YzlQczIveUw2VzVKT0JiL3VJTG5nTUF3MjlNU3E2TmtHMHlQVmtVSXRSVU9s?=
 =?utf-8?B?VE02MTdiNUM1VGdOam56WlFkTTZHc3FKS0NzOFp3MThxWXVkRGJnQmtoTFFR?=
 =?utf-8?B?MFFEaTBUbEw1R2djYUQ0UEMyUkt6SEZCTURsZ0o0bW5xa0ExbjJYMnM3ekpt?=
 =?utf-8?B?RXcraFRacVlSeWNPRFllQVdWY0ZsQ1RPclNYR2k0SXFQUm0vc0RtczRySU94?=
 =?utf-8?B?U2R1NHZnZllXcGJ2WnNTOVRSTHZQNUdaa3dEZDRDOTFuUzBnSXJLNGQxdEJI?=
 =?utf-8?B?empySTRTL2ZFenZwZm13SUN0OVdnaiszR0hOeG5UN3hOZWRsalg4K3YrQWk3?=
 =?utf-8?B?MXZLRVJFbUdSWkJDNzlBeU8rcXlCZXZETlh3NTBoa3pWdmc1NUllN0U3K2V1?=
 =?utf-8?B?TUxvZFJKQXp3U0Ezc3ZwSkVYZEN6aHl4a2RFeXFNR2s5VFZhMkRFdjNHSWdD?=
 =?utf-8?B?eHFDQ1ZtbFRKNHQyUm5WRTZZbllLYUpCZSt1M0hrUkZtVTFrSmY2b2pWYW1M?=
 =?utf-8?Q?4VzWJO7ivFDEG9RIMzOTq+qg3e36o/OvGmhfzRT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f31f518a-07e8-4e82-e578-08d94affacee
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 21:53:43.0727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J7LPPl762l49Tr3ciHIkqu+G3Ly1FemCDQplX3rrAmenOUUsLU6iBp21ZMENAsQ4PwL0c9dI1U69tEjQI9gKxzj1pBGqKooDx03Y8cT+wWo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5385
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,

Thank you very much for continuing these fixes.

On 7/7/2021 4:29 AM, Fabio M. De Francesco wrote:
> Add description of undocumented parameters. Issues detected by
> scripts/kernel-doc.
> 
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 01fd30e7829d..b5a30e57ce5f 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -877,6 +877,9 @@ static int rdt_shareable_bits_show(struct kernfs_open_file *of,
>   
>   /**
>    * rdt_bit_usage_show - Display current usage of resources
> + * @of: kernfs open file

This description just seems like a rewrite of the type. How about:
@of: pointer to opened "bit_usage" info file

> + * @seq: seq_file for kernfs

@seq: seq_file used to format output to "bit_usage"

> + * @v: unused pointer to void
>    *
>    * A domain is a shared resource that can now be allocated differently. Here
>    * we display the current regions of the domain as an annotated bitmask.
> @@ -888,6 +891,8 @@ static int rdt_shareable_bits_show(struct kernfs_open_file *of,
>    *   S - currently used and shareable by software only
>    *   E - currently used exclusively by one resource group
>    *   P - currently pseudo-locked by one resource group
> + *
> + * Return: 0 on success

This function always returns 0. It can just be:
Return: 0

>    */
>   static int rdt_bit_usage_show(struct kernfs_open_file *of,
>   			      struct seq_file *seq, void *v)
> @@ -1243,6 +1248,7 @@ bool rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d,
>   
>   /**
>    * rdtgroup_mode_test_exclusive - Test if this resource group can be exclusive
> + * @rdtgrp: resource director technology group

Just "resource group" please.

>    *
>    * An exclusive resource group implies that there should be no sharing of
>    * its allocated resources. At the time this group is considered to be
> @@ -1283,7 +1289,12 @@ static bool rdtgroup_mode_test_exclusive(struct rdtgroup *rdtgrp)
>   
>   /**
>    * rdtgroup_mode_write - Modify the resource group's mode
> + * @of: open file in kernfs

@of: pointer to opened "mode" file of a resource group

> + * @buf: input data buffer

@buf: data from user space

> + * @nbytes: lenght of input data buffer

lenght -> length

> + * @off: offset

Just writing "offset" is quite cryptic. While an offset to a write may 
be intuitive I think it would be valuable to add that this is not 
used/supported.

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
> + * Return: how many bytes are represented by the bitmask associated with the RDT domain.
>    */

Could you please change to "how many bytes of the cache are represented 
by @cbm"?

>   unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r,
>   				  struct rdt_domain *d, unsigned long cbm)
> @@ -1389,10 +1402,14 @@ unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r,
>   
>   /**
>    * rdtgroup_size_show - Display size in bytes of allocated regions
> + * @of: open file in kernfs

@of: pointer to opened "size" file of a resource group

> + * @s: seq_file

@seq: seq_file used to format output to "size"

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
> + * Return: A bitmap representing a valid contiguous CBM, 0 if @_val is only 0 filled
>    */

A valid CBM is one that consists out of contiguous 1s. So perhaps this 
could be simplified as: "Return: A valid CBM, ..."

>   static u32 cbm_ensure_valid(u32 _val, struct rdt_resource *r)
>   {
> 

Thank you very much

Reinette
