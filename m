Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B78D53FE4E8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 23:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245467AbhIAV1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 17:27:46 -0400
Received: from mga03.intel.com ([134.134.136.65]:26686 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231970AbhIAV1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 17:27:44 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10094"; a="218927416"
X-IronPort-AV: E=Sophos;i="5.84,370,1620716400"; 
   d="scan'208";a="218927416"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2021 14:26:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,370,1620716400"; 
   d="scan'208";a="446758045"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 01 Sep 2021 14:26:46 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 1 Sep 2021 14:26:45 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Wed, 1 Sep 2021 14:26:45 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Wed, 1 Sep 2021 14:26:45 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Wed, 1 Sep 2021 14:26:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JvWXo4Q6d4nkxGPJTjTWOA2EtKArkMtzOkvNYR0dsFpqRzhDF3SpojxnUofx9QYkUbk/UtSrqlTBmPciWQu4uMRZ5mk7zVu1Ddti1EJ5AZ/865hg55ldVtfei0oGPftCJ1bRAVBppo7RFcsq0ppJahwvm1KSjp+NnIq9Pu60nxgOs+2zcc8WurFOt9QGH8vkpsrvZtefjH7m8pzAom1vaPRR1jkd+d9Xwzr/lY2uyawmmV6K86g/HEHPnYIGhmAbuWM1rTyKc7Z8tS2H7yiz/YTYfLhE3x+BlGLrfUDWT0Yp0+N9l324XwYkK3yEtcoAZDE4I6v+xOhWEcetC1jgdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=BvUQbRnvnkiQlubRVi5tqMep9GwSgW6n+0XjB2FJJbg=;
 b=VGeZecCiVNCBzrd4THKAohNDPYTlWnfTh0gLwqTDbf1Jw9PhTPVy7b9tQdiDXCLw29zDUOSV8uOWGuxEHmkj9HUzapMKXoTsL32rFBHEpP1JGpK8tgafw8L0Xl9iY815JhstSWSUi3w6sfPuBMG46ICLjZrAQ/oXGvNP+usep3MrI1f0gBhgMQ5Z+HCbA0KD43jaYAdSjZ42fRIpGFfDT+AZoV0+dIFkpr7GS8fT+J4GcRJblfTqUolQlV4ZNpG+HnUSIGfpkU6lOjCGYCnaX1FAJu+KxjRfkaXZ3VpKPVGvvNzRRdfvZ/1twn+X6deR5mVVxSJnobpJRsnG2oUsYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BvUQbRnvnkiQlubRVi5tqMep9GwSgW6n+0XjB2FJJbg=;
 b=uYe9xH+Wwi689CmGs40pP+HA9nTj9oce7eKS4ElnhJrJ56RGu45qWpH/9AitAnzbtzxLOix6HqZ1iW4hlBgf5xrsEXQw7Lm5YOxnbqz39rW9JtBXQU4kCnF5Wv8fhIyEErLlVLGD6mwJbJXfnFUiYDy0JHLxDbf6lImm6S6m7iQ=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN6PR1101MB2115.namprd11.prod.outlook.com (2603:10b6:405:50::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Wed, 1 Sep
 2021 21:26:42 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::d47c:525:2aef:f6a]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::d47c:525:2aef:f6a%3]) with mapi id 15.20.4478.019; Wed, 1 Sep 2021
 21:26:42 +0000
Subject: Re: [PATCH v1 07/20] x86/resctrl: Remove architecture copy of
 mbps_val
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        Jamie Iles <jamie@nuviainc.com>,
        "D Scott Phillips OS" <scott@os.amperecomputing.com>,
        <lcherian@marvell.com>, <bobo.shaobowang@huawei.com>
References: <20210729223610.29373-1-james.morse@arm.com>
 <20210729223610.29373-8-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <d52bee12-5c6c-04da-3044-7121a2c15f12@intel.com>
Date:   Wed, 1 Sep 2021 14:26:38 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
In-Reply-To: <20210729223610.29373-8-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR2101CA0007.namprd21.prod.outlook.com
 (2603:10b6:302:1::20) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
Received: from [192.168.1.217] (71.238.111.198) by MW2PR2101CA0007.namprd21.prod.outlook.com (2603:10b6:302:1::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.1 via Frontend Transport; Wed, 1 Sep 2021 21:26:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84b9e831-03d9-486d-0ca9-08d96d8f3174
X-MS-TrafficTypeDiagnostic: BN6PR1101MB2115:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1101MB21150FF8DB2BDCA4C3DA8CE7F8CD9@BN6PR1101MB2115.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xxpoyTHYB9rEKvmaQdlTgI6+3hDasr5K3hb/bqP0DTMlTpfSvcU7C2DaOvapnaEoZBZqROI/wQAqe8HSIBHsQec2J4pFlprC8ZX6HNCEgYCp79kvA+FymxDb0f24ryUrQx44+1ND9fijt/wWwt3RXsX/LnLWMlE1YasJ6OsPQvxXd8/gPzJ/koWtXGdTK0l9H04WuyUgaJhWTDenjj/POQIl+0W+RERfBONDBKgDygxRGeMzB9/HIhpKhluCRW3/9QggocvTHh4wUlHMunfQ6sSKyGIbopvUYhc8IwKx5nsuVqStSwf2kElqXpE5PZAeu7gHU7/lyYzazr4OY66KROT3biyx02QNGhosUvI8jRJFr2VB2XdzhLRD9qlBZ6q6yETIxzIT9amD2dts7iwdvcPu5G9yW9KFuz6cFuYhDtpqvoB4McbwtR3jDg7dRKCewSq0vvH93YTrNa5RNVq0MlCyTAbKSMZiUIdc5bnsE+qHa4jec52g+4SpGON75j06hEg+oJbxCdx//a/aGt/9zCMtXxPfBEYofJSbbqrQ34HIdO7ulgXe3yQe8r3RF8hHIdogZ8HF+6qnX15lD9FNyLfXONbutDu40YpquSv7GHauk63c6xKOEmk1x3w64jsH3WY6if3MinoBtavrBTQzs/qNcwvVervJfWfZHa200DCnN8WxbhiOmRRpoB3acQhHF4TpqmpezY1T/tn6rU+gAaLvjPnxflmB8Tx4sa/qftM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(31696002)(2906002)(86362001)(36756003)(44832011)(2616005)(53546011)(8936002)(8676002)(6486002)(186003)(26005)(16576012)(316002)(6666004)(66476007)(66556008)(4326008)(54906003)(478600001)(5660300002)(956004)(7416002)(66946007)(83380400001)(31686004)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WURWUVBvS2JMSXdJazlEUXVjbWZFK3UyamtBWjhBWjBWaTE1ZEJwb3QrR0E5?=
 =?utf-8?B?ZDFpdVhtVzVjTWRrYlZEUnRYWGRkaWlJeThtKzdaZVIxaURmRTZqTFN2Tjlm?=
 =?utf-8?B?RldjMTY1MXVlTU5JaTRwYmFpcjJERGJQdDFOWnZjaHFUN1JOMk9ZeHMzdnlu?=
 =?utf-8?B?dGpFODRKdW5lTzN2V3ZYK3BVWTdCdklwekZPaXpaeWVRTmtKdGxNY1ZHRTBZ?=
 =?utf-8?B?S2c3OWVSc1pRcGhZbG5NQXBveDZ3dXdRRkJRWng5SVZxaklEenVEWmo4Zlh2?=
 =?utf-8?B?SUFJRDBWZzFGMDVuWm5yRm50RGlheHlmOXZEN2Z2OEtEU3lUNWlJWmZjaloz?=
 =?utf-8?B?bUlObHMxZGNZMTI4bndMYjJHckh1NGsyTVpWVXRqa1lEVCtyRmFTMWRFUnpX?=
 =?utf-8?B?OWdHOVhUSk03Ri8zbGdveUxSdHI0ZFpsTHBneFV3eWRzYzJRWkQ0MG9pNlQ1?=
 =?utf-8?B?dEMxSyswTnpOM2duZm8raWJIVW1PaHgwNXNUU3BBK1lySzdlT2Z4K0xNMjlm?=
 =?utf-8?B?TmlYcFlUcU04cXFEdkMxb0dTMWxDZ2JZMWlyMlV0a0NYV0lnZGlsS2FKRTNu?=
 =?utf-8?B?T3ZsTnEvb2JhMGp4bHlpUVQ4UXU1cy85Q21oTzVyNFNaTWNOT1VyMWRZNnl3?=
 =?utf-8?B?NU5KTmdFaTR4cTU3N25ScmdkZHA0WXdYOVczck5vS3NZK0tReTVQZkl6TlZP?=
 =?utf-8?B?dnZ6K0daKzEwUUI0NjJrbFpSRDdkSGU5MUIvNmZ4SWRVZG5BNXFUOFpnelFZ?=
 =?utf-8?B?ZDNXOUZpcDBFU1Niek12WVFTZlpqQ1VqZW00RTZrNnVUNGxRbjMxNUlSdlBv?=
 =?utf-8?B?ZDVzdERwbFhZaHZWcXBaOUg5MzlqOHA5dTJRK3h3OXRZV1lUcVgxMGt5ZnhH?=
 =?utf-8?B?N09BaUdNMmpCYkVyNnZTWHFaRFdXSFRWZEt6STF5UjRmSU9peGpidmYwcFhx?=
 =?utf-8?B?Q0tjbkxqWHFyTkM4aUR0b1pCRm5nQklPaVRNaFRRLzh6Y3VYWGV3S1lvYUJk?=
 =?utf-8?B?OThHOWhSQlVYTjdRTk9OTDJqdkdObXdyOG9UVldhVDZvUTFoZnRjbkdKZENT?=
 =?utf-8?B?WXVqRHphbGg2dVhwQXpFd1FrdHorcXZpTFI1U253NTV2UEg5cE1vL00zL0Vi?=
 =?utf-8?B?c2FlRzZsVHpOZ2dHcE5Md3BsTDJ6TWxjQWxKdDdaK2FTcDBUSkRNczJXVWlT?=
 =?utf-8?B?YmwvV2M3eTU4aXRyQXRMQkhmNjZXUVJabjQ5SXBQRS9DUmc4ZFZ5ZXRjS0Zz?=
 =?utf-8?B?UWUzelUvSHJtRlJzampLZXdxS2t5VHNONmlOQTRmam1KVkRkV0FtRzY5cFB6?=
 =?utf-8?B?eFVvMGJwazAxUGp1U1hqYldjcHBubnI4UjVsT0ljTjhXUDhwQ0RHRTFDYmo0?=
 =?utf-8?B?Vm5CODhSdSsrZlo3QlJ4TXduUGpoWmxDNUtQb2Nib0lnYnBheHJ3T0VYTmoz?=
 =?utf-8?B?eUNta3JCNkRaVWZPS3hKWjVGdWdhbmNDTmRlTXBLcytWVGVLSWd4REw3dk5q?=
 =?utf-8?B?dkdQcG05bHZHYkVXd2xyODRPcm10Q1JIckZ1ZnE2WHJIRWl6YUNEeW41RGhv?=
 =?utf-8?B?dWdTMGQrSjc2N2Q5aTRhZ215NHQvd2NHTUx1aEhxcSszRXZpSVJmMG52Y29y?=
 =?utf-8?B?ek41REtDOGdFL05iNnRLRGpWUit2NE9nZGw1VVJtTkphejNVbktHUEdIWlpE?=
 =?utf-8?B?ZUZtaVc2N0xha2M3U2V2d1V5ajdTdHBXZGluSUlUZncwaTVSU3E3aEhDNVpj?=
 =?utf-8?Q?fE8tf9v+9H3hcWG6f8u814Xw00i6LSO253VOhlS?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 84b9e831-03d9-486d-0ca9-08d96d8f3174
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 21:26:42.8021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D/mbD9HBUrCtuyu8lqt6dcNhxyMn/T+F8WEDq/0+Fvo6Y+NLQembVp4b/KkRabpLBgRKd4NT9IooxQePl38l2MmGJep1wvz5YElh3JMOSL4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2115
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 7/29/2021 3:35 PM, James Morse wrote:
> The resctrl arch code provides a second configuration array mbps_val[]
> for the mba socftware controller.

"mba socftware" -> "MBA software"

> 
> Since resctrl switched over to allocating and freeing its own array
> when needed, nothing uses the arch code version.
> 
> Remove it.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>   arch/x86/kernel/cpu/resctrl/core.c     | 20 ++++----------------
>   arch/x86/kernel/cpu/resctrl/internal.h |  4 +---
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c |  2 +-
>   3 files changed, 6 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 56b3541617b5..e864dbc6fe3d 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -397,7 +397,7 @@ struct rdt_domain *rdt_find_domain(struct rdt_resource *r, int id,
>   	return NULL;
>   }
>   
> -void setup_default_ctrlval(struct rdt_resource *r, u32 *dc, u32 *dm)
> +void setup_default_ctrlval(struct rdt_resource *r, u32 *dc)
>   {
>   	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>   	int i;
> @@ -406,12 +406,9 @@ void setup_default_ctrlval(struct rdt_resource *r, u32 *dc, u32 *dm)
>   	 * Initialize the Control MSRs to having no control.
>   	 * For Cache Allocation: Set all bits in cbm
>   	 * For Memory Allocation: Set b/w requested to 100%
> -	 * and the bandwidth in MBps to U32_MAX
>   	 */
> -	for (i = 0; i < hw_res->num_closid; i++, dc++, dm++) {
> +	for (i = 0; i < hw_res->num_closid; i++, dc++)
>   		*dc = r->default_ctrl;
> -		*dm = MBA_MAX_MBPS;
> -	}

Since this function used to reset the array to default I was expecting 
its callers to now reset the new array (more below).

>   }
>   
>   static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_domain *d)
> @@ -419,23 +416,15 @@ static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_domain *d)
>   	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>   	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
>   	struct msr_param m;
> -	u32 *dc, *dm;
> +	u32 *dc;
>   
>   	dc = kmalloc_array(hw_res->num_closid, sizeof(*hw_dom->ctrl_val),
>   			   GFP_KERNEL);
>   	if (!dc)
>   		return -ENOMEM;
>   
> -	dm = kmalloc_array(hw_res->num_closid, sizeof(*hw_dom->mbps_val),
> -			   GFP_KERNEL);
> -	if (!dm) {
> -		kfree(dc);
> -		return -ENOMEM;
> -	}
> -
>   	hw_dom->ctrl_val = dc;
> -	hw_dom->mbps_val = dm;
> -	setup_default_ctrlval(r, dc, dm);
> +	setup_default_ctrlval(r, dc);
>   
>   	m.low = 0;
>   	m.high = hw_res->num_closid;
> @@ -527,7 +516,6 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
>   			d->plr->d = NULL;
>   
>   		kfree(hw_dom->ctrl_val);
> -		kfree(hw_dom->mbps_val);
>   		kfree(hw_dom);
>   		return;
>   	}
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index a7e2cbce29d5..796e13a0e8dc 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -308,14 +308,12 @@ struct mbm_state {
>    *			  a resource
>    * @d_resctrl:	Properties exposed to the resctrl file system
>    * @ctrl_val:	array of cache or mem ctrl values (indexed by CLOSID)
> - * @mbps_val:	When mba_sc is enabled, this holds the bandwidth in MBps
>    *
>    * Members of this structure are accessed via helpers that provide abstraction.
>    */
>   struct rdt_hw_domain {
>   	struct rdt_domain		d_resctrl;
>   	u32				*ctrl_val;
> -	u32				*mbps_val;
>   };
>   
>   static inline struct rdt_hw_domain *resctrl_to_arch_dom(struct rdt_domain *r)
> @@ -529,7 +527,7 @@ void mbm_setup_overflow_handler(struct rdt_domain *dom,
>   void mbm_handle_overflow(struct work_struct *work);
>   void __init intel_rdt_mbm_apply_quirk(void);
>   bool is_mba_sc(struct rdt_resource *r);
> -void setup_default_ctrlval(struct rdt_resource *r, u32 *dc, u32 *dm);
> +void setup_default_ctrlval(struct rdt_resource *r, u32 *dc);
>   u32 delay_bw_map(unsigned long bw, struct rdt_resource *r);
>   void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms);
>   void cqm_handle_limbo(struct work_struct *work);
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 185f9bb992d1..297c20491549 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1906,7 +1906,7 @@ static int set_mba_sc(bool mba_sc)
>   	r->membw.mba_sc = mba_sc;
>   	list_for_each_entry(d, &r->domains, list) {
>   		hw_dom = resctrl_to_arch_dom(d);
> -		setup_default_ctrlval(r, hw_dom->ctrl_val, hw_dom->mbps_val);
> +		setup_default_ctrlval(r, hw_dom->ctrl_val);
>   	}
>   

I am wondering why new array is not reset instead of original at this 
call site? oh ... I see it is removed in following patch BUT it mentions 
that it is ok because reset_all_ctrls() does similar reset ... but it 
does not seem to do so for mbps_val.

Reinette
