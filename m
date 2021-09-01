Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C92EB3FE4EC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 23:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344609AbhIAV2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 17:28:32 -0400
Received: from mga04.intel.com ([192.55.52.120]:43145 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344587AbhIAV2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 17:28:30 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10094"; a="217017827"
X-IronPort-AV: E=Sophos;i="5.84,370,1620716400"; 
   d="scan'208";a="217017827"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2021 14:27:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,370,1620716400"; 
   d="scan'208";a="476355501"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 01 Sep 2021 14:27:32 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 1 Sep 2021 14:27:32 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Wed, 1 Sep 2021 14:27:31 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Wed, 1 Sep 2021 14:27:31 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Wed, 1 Sep 2021 14:27:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CeVH5Pw46XBf2AlAvu3zKIPrJiV+DaYe5yflKazEIO6uvim2IREzQ7UlanbPDVayZ+h6BzgokHVdglFTKJ0/1WnREHF4kQr84D0GX3ShSupTXBR5Z2vaPkqSSt6NFwVSBrKKgVIf3JHOnG7X317x+ojREkXVZyzW3HjTfp1bGftW72OBIE750P097z5wWdSBmYSSZ9T1Ck5ARLAKAxK9QdBK7HsL7ttgzFGfPngQaqR5hDLSXeBxJR6Lyxg80ecV06Vq/SW46pxY73xAIyAXThnW8hXOB8cvRVnv5IUhdunQZsUDTGxQrqj7iT1e7NU5kmmGCS7R5UZseRb279mKUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFvm2cQgV0ac+T954C3kQbVgUBbPir6q1m2/9UDHQPc=;
 b=NQCSgisMkfqDl0TBbtBwP0+XmFnh/S9naMLok0IuwP6r42ZzMoRjReWiuK83jbDVYQd+vX/Z7ZD51V8mLvVoTJ3xynvmH9rTb4nbaMwTfKRWuaIZqrlBFZ6nc7AdEYN6YDdq8FHyhZTdhzCeF6BaI2vWfv9KFiiI/aFo5iXsJKdc7k038qF6yhiQalz5bZ9Pc2jO0gekL2aOPoq9WEPX2KA1PTzYsAZntoXvw24FZBXmV2pLnemAjUKYpG25jwIEfuBgngE5LLi3xHL7uWwFbPUo6OIzvMiVhs10H4qQde7NVZ57hM56gFmjZHClVVRUkcjqWpYUnvQMcq7D+Qp5fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFvm2cQgV0ac+T954C3kQbVgUBbPir6q1m2/9UDHQPc=;
 b=U2tdZSsHGnH7QHDW0RtvYwbOs9pmPpOqgId+Fgx84VfYTfXFYntgLnEnioyUfBHLd/MZwu658lGUTUIMa5tHzZPNILsV/bYRZJNM53XY73PUABrKswvIIBHOqJOHrDAPa6DPQ8u3r0d7lI158xLbVgLk5U1HqhcaCLn0aErwbCY=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN9PR11MB5244.namprd11.prod.outlook.com (2603:10b6:408:135::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.24; Wed, 1 Sep
 2021 21:27:29 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::d47c:525:2aef:f6a]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::d47c:525:2aef:f6a%3]) with mapi id 15.20.4478.019; Wed, 1 Sep 2021
 21:27:29 +0000
Subject: Re: [PATCH v1 09/20] x86/resctrl: Abstract and use
 supports_mba_mbps()
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
 <20210729223610.29373-10-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <c8ef35f7-efa1-0e2f-e1ab-7b0df4a5ae2d@intel.com>
Date:   Wed, 1 Sep 2021 14:27:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
In-Reply-To: <20210729223610.29373-10-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR2101CA0032.namprd21.prod.outlook.com
 (2603:10b6:302:1::45) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
Received: from [192.168.1.217] (71.238.111.198) by MW2PR2101CA0032.namprd21.prod.outlook.com (2603:10b6:302:1::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.1 via Frontend Transport; Wed, 1 Sep 2021 21:27:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0b5b79d-24fa-48b7-a5e1-08d96d8f4d6d
X-MS-TrafficTypeDiagnostic: BN9PR11MB5244:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR11MB52445A6C70155D58F2D55AC9F8CD9@BN9PR11MB5244.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z+cvfCOrlueSYC/aYzO9+n95JM6zjcJhgOg2tRhYksTq1LAfdXgPt4CO5vkQRPEtSNRMZFypwlRNnkaE8/sV5p8TiY8oamcvZzl8F1noL/Dx4fIG2fO7m6XhOcTZhrFpmPaZFFZlUPZF5CguX7IkdRGIGlId0ovSziOnv6Zx92U4Fy4+AOGo9nVw2Rf54gGs5YCEGCpZEl6KKFRVly12A/mZzFnoKwq4T1cTy4XRdEBFe/apIYNSst23SWpkaz/VexsPMcKgf53y8ql5jsTfOv8dKB+d2jX+YtYEEk4RbwXRibmA268JxO5TBsxEcs6xhESQQTYEVkMw4J/0P9tTSGeyDYwf/IA+st4vZaOnA/8K6fBDbVkwFAdnlGT+Gjf+/VTjcyi2BZfvj5VNzUO0ZNaYgssg3JU808fQsBcLBp9NedVkee89dZJZT74+Dt8n0rYfjKV5JcZ5djnotOgzqBzDlSTuJ6HMUkKRspTx2EuxguZlwsL0mVjhN+qmr9bQ7w4CRBK9iOFJrROlmEjUgLgEIMMb4OIt4Sg1qlV27QsQhbHk418V/5AoiGgiElGUUpxh+K0NnFO49gEmT3IDvELDqi15k6I/PyceGLGY6dH9QaGbPQgvsHai31Vh5OUVwiiepMUeGbkHA/4xwqdlwq17mXQ61EhdBAGqslypOTgCoRylqCY2XgjJG0BYlhHWyrmyISYqENa9E2Najf+hZx655Q4zCX6iIZ1M51o0fhA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(366004)(136003)(396003)(376002)(66946007)(66556008)(186003)(4326008)(956004)(31686004)(316002)(8676002)(8936002)(7416002)(38100700002)(6486002)(2906002)(86362001)(26005)(53546011)(31696002)(36756003)(54906003)(16576012)(2616005)(44832011)(5660300002)(83380400001)(66476007)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWFrZStxcWZJdllOQUluRVBFN0ZEekpVa2VxRnNOQkdnUHJqOUtML1J6aUZQ?=
 =?utf-8?B?RWI3UnQyMGFVTFBtUWtnYVpCZzlxZzRxU3FBVTVHSU5DeXBkQVVsbVYybDZY?=
 =?utf-8?B?aXNVTXlFWEh0MWZGOXBlTjJGN1dMN2RlQnRudHNibzY1dW1PRTBtWmdORjNS?=
 =?utf-8?B?MGdZTzdCK09JV2p3QXRNSkxGTmxBOHAxbXdUVE5pVlVDUVdCbHQ3QnZaaHBN?=
 =?utf-8?B?b0Z1UVlLY0Z2dFQvQkM4Y0p0SEJvSFQ3aERqWUdnZjQvVlA0Q0EyOU44OC9D?=
 =?utf-8?B?UURKZW1ZODdWWjIyMktrTk1KMmVrbUQ5RkloNkd1K0szemhKYlZEd2dEaFlE?=
 =?utf-8?B?K05CbEsvaEw5ZGt1VXpSRlllZGhjcDdKWDlJdzV0VGRZczVEdDl4bUgybEFi?=
 =?utf-8?B?RHozRTNnU0ZnREYyaHBZTVorTUhra3hMc2cxTktsUllRWWVYTytCbUg4c0Rq?=
 =?utf-8?B?SFNPcm9qNkxRUkMwMDhYNzZwaGs5MWVwNTBZZytTSW1sbktvOE9zMlNzZ3pz?=
 =?utf-8?B?QkxBWUtnT0MwRFhnMWRiakdCZDJwajRIL00zRDhSczNxbURoN0hjS1FZQk5D?=
 =?utf-8?B?MW4wK0tibnBMVHZPNnhTcUEwcm1abndFdFRScVhydC9xNWd6M2ZyQnVaNFMr?=
 =?utf-8?B?ckV3UHlacFl0akcwak1aNC90Sk15SkorZDB1ZHFzaW1heFI0QVZ3TmpNeDg1?=
 =?utf-8?B?UTZ2VkVoMDBwWUNEZ05YUEtDQUE1dHViaHpUdnVhanEvSzNZU1pZUGpQN3dM?=
 =?utf-8?B?aU4xU2dWN2xCNnNSSmx3OEwvVVlieDJiS0ZtUWNlTG54aTk0bmtzMDBUc21k?=
 =?utf-8?B?aWpmWDRPaSsvTmR4Sjh1ck9tTC90VnpwbytRbm5wb1ZXZWc3RGx5SlA1a1Rm?=
 =?utf-8?B?TzdBejhkWmdlN2VSV0JuMnRYeXF4UzM5QWRMU1hWUzlHNmJCcTJiNThYL3cx?=
 =?utf-8?B?NnAwemVpUmZDSUxVclRiZDU1Z2kyNTFuSmFobi9QM09xYThIdDI5ZXI2QXQx?=
 =?utf-8?B?SnpWaGlEdkxJUnV1ZFk2T0JFbGszeG4ycHczcU5QdlpUc0hVVW1qWG9nUDhr?=
 =?utf-8?B?SVFLYnNZYXFkMTNGN0Z0WjNqTlkwamdBazVuTWt4cHZ3eXk3d2c3eXpadlRR?=
 =?utf-8?B?U0lScmhEMHpIcGNkK1padUZUQlgreitsK0pkaEpGZFZXd0F3cWpkVE5PU3d5?=
 =?utf-8?B?VUpCNENsSTk0U3Y4MUJERzd6dTVVVEJQTFNMc3h4V2p6QkQ1Qit1YkduL2V1?=
 =?utf-8?B?cW04eDhKcWJhMFlXSXFIVEJyOXhRM2E1aXNkWW44Vmw2YXB1T0JmV0EzUWht?=
 =?utf-8?B?VCtnRmNtak5aU1dWOHJzOW9jS05kK2QxMjNqQlBPWitrYVp6SFRScDhjUlVx?=
 =?utf-8?B?UHVxdHNNbC9wWC96N1JSRHFweG16OFRUQkR6ZGFsemJPcURGaGcyNjVpR1hS?=
 =?utf-8?B?ZTRLcFVJb0hpQjNVbmUwckV2ZWtUbmlMV0lGV2k1aHZmMnd4bDBFV2VOUU5a?=
 =?utf-8?B?bDFERSt4bG1RNFE1UDdURHBNZlZ2SSswMW5zckQrUHhoSklkU3JMbUNMTG5r?=
 =?utf-8?B?ZkdZZ3p6T0wreHlTZUtFV2k0NVpTd2ZreFV1OTNjZ2VRREtyQ2tJRlBDZXhN?=
 =?utf-8?B?MUcyT1dpL0RvLzl5NHRoU3IxN2R3NzNNdXl5RDhKVlVjaEVxYjZxcVFGWkVp?=
 =?utf-8?B?Y3gyZzh4cDdSejIwUXlISXEyNzREM1FKZzdRTlg4dEtFQ3hXcTF6d09POVM3?=
 =?utf-8?Q?86KorPok70oYX4Z0WDDD2O68rR8l7hdk5aW15si?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b0b5b79d-24fa-48b7-a5e1-08d96d8f4d6d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 21:27:29.7722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: isJQoknCd/bsLErxIeRmhuETSV81F0WGyu3sdjYo5t/Cjd0yRPHrIycF6dl8rS71WL6CLHK3pOHHDBILb6HO3GvxVirbHK3HwbPIJkHwMMo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5244
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 7/29/2021 3:35 PM, James Morse wrote:
> To determine whether the mba_mbps option to resctrl should be supported,

mba_mbps -> mba_MBps

> resctrl tests the boot cpus' x86_vendor.

CPU

> 
> This isn't portable, and needs abstracting behind a helper so this check
> can be part of the filesystem code that moves to /fs/.
> 
> Re-use the tests set_mba_sc() does to determine if the mba_sc is supported
> on this system. An 'alloc_capable' test is added so that this property
> isn't implied by 'linear'.

Why can linear not imply alloc_capable? It is a property of a MBA 
resource so if it is set then it has to be a MBA resource.

> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 19 ++++++++++++++-----
>   1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index e321ea5de562..4388685548a0 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1888,17 +1888,26 @@ void rdt_domain_reconfigure_cdp(struct rdt_resource *r)
>   }
>   
>   /*
> - * Enable or disable the MBA software controller
> - * which helps user specify bandwidth in MBps.
>    * MBA software controller is supported only if
>    * MBM is supported and MBA is in linear scale.
>    */
> +static bool supports_mba_mbps(void)
> +{
> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
> +
> +	return (is_mbm_enabled() &&
> +		r->alloc_capable && is_mba_linear());

As mentioned above I do not see need for the alloc_capable check since 
this is hardcoded to be a MBA resource for which delay_linear can only 
be set if alloc_capable is set.

> +}
> +
> +/*
> + * Enable or disable the MBA software controller
> + * which helps user specify bandwidth in MBps.
> + */
>   static int set_mba_sc(bool mba_sc)
>   {
>   	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
>   
> -	if (!is_mbm_enabled() || !is_mba_linear() ||
> -	    mba_sc == is_mba_sc(r))
> +	if (!supports_mba_mbps() || mba_sc == is_mba_sc(r))
>   		return -EINVAL;
>   
>   	r->membw.mba_sc = mba_sc;
> @@ -2317,7 +2326,7 @@ static int rdt_parse_param(struct fs_context *fc, struct fs_parameter *param)
>   		ctx->enable_cdpl2 = true;
>   		return 0;
>   	case Opt_mba_mbps:
> -		if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)

I am not familiar with the history but it looks like AMD does not 
support linear (based on __rdt_get_mem_config_amd()) which may be the 
reason for this test and thus moving it to a feature check is ok.

> +		if (supports_mba_mbps())
>   			return -EINVAL;
>   		ctx->enable_mba_mbps = true;
>   		return 0;
> 

Reinette
