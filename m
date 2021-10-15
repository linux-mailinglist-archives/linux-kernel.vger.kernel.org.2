Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DAA642FE20
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 00:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243337AbhJOWam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 18:30:42 -0400
Received: from mga02.intel.com ([134.134.136.20]:7498 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243344AbhJOWai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 18:30:38 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10138"; a="215166193"
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; 
   d="scan'208";a="215166193"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 15:28:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; 
   d="scan'208";a="481859663"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 15 Oct 2021 15:28:30 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 15 Oct 2021 15:28:30 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 15 Oct 2021 15:28:30 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Fri, 15 Oct 2021 15:28:30 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Fri, 15 Oct 2021 15:28:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eI2xuFXaINLMz5q583TRLo22uyGqwxD+V3Fc5EKKePMgJnz5JfjlWYej5gavdjQTr3uOPSRTusswPJVmmM0oJ7JMRfVvu8ugzYcCc8RqA6N6k8TZHaMYlp7xvq8SkFsscUJlE6ya53ysibQcJhnPt2eTvQrgfgKqobH2wt2t5TKerCGjF6hMExzbYsQFjYvm4jPIPMOxCODX3fBBR6TF+WZbg0Xw9Ekyu7VO+xyDd68E9DIUJ1ar7Epa2IvMKLHfD/eoBIUewjQaXX107SkhsLKkLYAZslYp/6rCRl2pCYsiDod95Vrjlh5B4KjPwW/DoaldA5RT7ebCF6DmXkY7Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LgJVB5HgKB0UITbsQbyOE90z1BouPtjs6zVozDKQpg0=;
 b=MOjCBYabOu8HujXIiAYqeR+TuhCWuOVvyk51X7Zpj2y3xiwIwIqWUEpWEoIT8SfiptLNM9ucGFmH94CVv0bE8OA7P7HPEVP2nMnwmCh1CZPSkGz5fl40C0T8NpJRP5kWQ0EgSMnnKcQr6e7rpz0RsADdWxfSfnC1kngkPQPKEO8LI/qVGBdU1MNCmLBnRCxyT9ztL+7PrDqyiCq4ogoW6XvFnsHRw7dPEBuQAxhJVjDrBwvrMJB90mlE0a43xBrA6wIBpK4IupUVYPpSt9useTWLrfGBRryfbGjidmBFKg0W/C4wM+EvzBmZ7lzUpaBH6TYwCUneZPcgzrpUU5GHpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LgJVB5HgKB0UITbsQbyOE90z1BouPtjs6zVozDKQpg0=;
 b=xR0z98yf1wT35SBRgIr3Pbnprh7oWuuENT2wWkQaRr4wQxnrtrifurdb7K3euuy03sf4EuTYHAnSfwSMAshPfXHIgLRwCcTwzfCcsZS+GDT7yLF/0k1/4PgmMUi8rVzC8Gb9ZJTy8YWLsf8ZJh2tLCkq2wsvjYBJif7It6hIWMw=
Authentication-Results: fujitsu.com; dkim=none (message not signed)
 header.d=none;fujitsu.com; dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN6PR11MB1299.namprd11.prod.outlook.com (2603:10b6:404:49::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Fri, 15 Oct
 2021 22:28:26 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::d47c:525:2aef:f6a]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::d47c:525:2aef:f6a%3]) with mapi id 15.20.4608.017; Fri, 15 Oct 2021
 22:28:26 +0000
Subject: Re: [PATCH v2 13/23] x86/resctrl: Allow update_mba_bw() to update
 controls directly
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
        <lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
        <tan.shaopeng@fujitsu.com>
References: <20211001160302.31189-1-james.morse@arm.com>
 <20211001160302.31189-14-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <777770fa-c2fb-f091-13f8-a204869d8ab5@intel.com>
Date:   Fri, 15 Oct 2021 15:28:22 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
In-Reply-To: <20211001160302.31189-14-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO1PR15CA0111.namprd15.prod.outlook.com
 (2603:10b6:101:21::31) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
Received: from [192.168.1.221] (71.238.111.198) by CO1PR15CA0111.namprd15.prod.outlook.com (2603:10b6:101:21::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend Transport; Fri, 15 Oct 2021 22:28:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1592d171-50f2-480c-656e-08d9902b1b39
X-MS-TrafficTypeDiagnostic: BN6PR11MB1299:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR11MB1299E5FF082FDF0028A72BA8F8B99@BN6PR11MB1299.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7VRdGzRZN9kDhinkHbO1icDGvSyqDt3LJ6k7Rg8dXXwzjflV8GA303I3i/VrLSnHE5h/ls5RlxzSsi3Zu7OZt6A3rh6giUPAztaQQD/HjZaq3KhMz9UV+OUAYkanrG2WpWEPv2QTafYMcgj/GRvuKblTstHadKAJTSdcfnrSGj/qbooB6RgOGzEnpY/8BUB/+CWb+GbdKjjhwjGPHeoLZVAHbat38tnguSKDEmWfWdVFOEW3Q69AMDQGwMln5GcuCPkPnbx+dONCeknMktyCpNfC0yoQIwNlK73PzK8QWO8Nh2W4hhVLqSqw1KdrWCdRWnd8EF7WWIl+oPczt8YzgFbcQ/8W6FT9qG5smSqX3w5zhq05paOkyPVN0NDeggFPTv1cppNzWQI4EmSZu/hCStfkaqezYYg6t6dkZ6c9o3/4J9tXI8zQhOtzu113M7f5gfsDKb24mUD2Pat9F5xVWWYx6cXSNlkOYjuIDePJVwEgwTR9Tcf/RwcFQ6QoJ8KIiCH7zDS4714NGatgIgiBLqemzXBa7Buas4d7Bo1Mpp8Pq/a2weFvsM6rMHXjAaldI2FTTaVpTLF4+7tycDnW0D3LSAULlm1h5xNAXafvbqEmxa8hi8hwXIMtJdWCoxPINMbWmNOSu8E1tV1lKu8v9Lty3tudPQPVwxWkjawxbHctkD+/g6vNTLeTgXs/LC/29lBkeWiVLe5Tq9f1xCHAXla50szZdKSM2NLhhqbsx6M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(5660300002)(186003)(316002)(6486002)(53546011)(36756003)(2616005)(956004)(44832011)(8676002)(26005)(86362001)(82960400001)(54906003)(31696002)(16576012)(8936002)(7416002)(4326008)(31686004)(2906002)(66946007)(83380400001)(66476007)(66556008)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NENteVBnbThKK1g1d01ZNmdzZkpLeGY0UjlRWUZUQlR4TzMvOXRGeDNpa3JT?=
 =?utf-8?B?ampRWSs2WUJCUTM4aTQxNnZZUGFRSWp0RnNkN0dLYnlWRWRUay9QeWZSZGRW?=
 =?utf-8?B?Um83L2NGZFdvZS9LWm9NY3MvUW50Vk84U295dWVQbjFoV0kyc2hWNjdIYVVy?=
 =?utf-8?B?V3ZIVHJWNkFVLzl2K2V2d0dqWWZWaERLWmliWFVZZEFvOXJ2N1BxQnBvc25J?=
 =?utf-8?B?ek5Uanl1QTVZTFZnU29BMU9IMjJwODNTVkllZlJyTEFCNGNyWFNxWU10TFVL?=
 =?utf-8?B?ejNzTlNqOGU3eXQ2RStrVGJRdytDUGRlQ0Uybi9Ec1pkVDB1K0xhMTNXejkx?=
 =?utf-8?B?a2dZSFo5Sk8wQWFtcWFGQjIrbjB1b001dFJKQnpjL2FrOTVPektlL1M4RnF5?=
 =?utf-8?B?eG9saFZDQXlDRWxITklRZTVyTGlwa1h0L0pvZU1UdC9xckxrTEFZdzl5aWZL?=
 =?utf-8?B?RWRqYWxRMTY5Nm5hcnpsd0o0N2RNcGt6SCtoZmNRMWpXQ3VWMWppK0RoLzdR?=
 =?utf-8?B?Y3V6cE1LR2txdTE2cnlybUxYa1dZbDBrMjBad3pKWUdBVmVhNEF0NWxQNGov?=
 =?utf-8?B?WUIyTHBXbisxODdlTzlZVHk0K3VveWsvVXJWdkwvdGg2eExkSVpHSHdBWFFi?=
 =?utf-8?B?VWhvMzFVbnZYbTlXbXJJb1RFdjBLbHh1UDBmRlBpQ2JqWHo3MXoxSVRJTWk5?=
 =?utf-8?B?Y3AwcEp3S1Q1amFXZFkwNTZ6REx5SDk3Tyt4djFQaUlBTldYN1dsZWU3dlFw?=
 =?utf-8?B?VTdkU2FEdUZoaEt4VS9VeVd0UWNDYWtrWVJNNjZadjhXYWxyYXhHSFZ2bnR2?=
 =?utf-8?B?OW5yUmgzUVZsUFlNOU5hOUtEUXJJay9IM0RIbDRnZjJVdTZiYUk1UzZLT3VI?=
 =?utf-8?B?ZE10NmJxcjhGTUkxOU83ZmVzV2FoblpVKytiUUJJb1JQdlhHd25ORG9OeU1s?=
 =?utf-8?B?M2N3c3FpcEtEZFBDRUdaT3RtaGk5Zkl5ZnRTNDhrQzRoajRuZmdheTlFWmtD?=
 =?utf-8?B?UkYzZlNWUzdjOHkwem9HNjJjK0JVa0NhMHNkTmtQUUVYS1BGWXZEcDRicFdr?=
 =?utf-8?B?dDFIaWZZcFJRK05lcng2TDV5UGRyem5UWk5hVTJJMTJkYkpkcUdLMXVhOVdG?=
 =?utf-8?B?RHJtZkJVczZKUWdTR28zK21xYVE4M0F5YSt2ZlFYZEJvWVg4ZVlYL0xYRkx2?=
 =?utf-8?B?VHR1SFpnRm5OR1BBMlVRRmFOMytNZWFhanRuZW5vRCszNzhQQTJ3VkxkRmNM?=
 =?utf-8?B?bTk5eVFXbndxZVpnQXpPNjhhUk1LcnpNWTlrcUJQMyt4aWUxbXZzTi9LdFJI?=
 =?utf-8?B?Y2QvWWhMY3p5c1JHUFlmTFFpWi9FQ3YrTmhITWppTGUyU0I5V29zb2RVWjZk?=
 =?utf-8?B?eEFOUmZKN1NsQmRrT01POS9DZy9MSXZyVndFS2E4QkZMQzlyZUNvUmNYTkQv?=
 =?utf-8?B?M1NMSU5YcmpYTWhrT1VaeFhzbEdMaDJMRFZYUHUwam5yZThaNlFRV2xaVFlK?=
 =?utf-8?B?VGIzVTZHNnh2eHlVTmNWVUFBc0xvc0grVDU4TmxmRnZZQ0M2VmtyUDNEbXBt?=
 =?utf-8?B?d2ozVjJBcG1pd1V0Qi9CQTFyOFM3TWN2NHpaODJGeGkyNy8yNnBtWTlsVmk4?=
 =?utf-8?B?aUttQ0V4b0MzZzE3OVR4NlYxeDlsYmhFOExuMk1hRTZjK2w3SUcxaitVOVcy?=
 =?utf-8?B?emxFZXcwdmVjb1FNT1dKdk4vRWdsWUV2ZEpQSjFySmRmY3ZEQVB4SHJHT2lU?=
 =?utf-8?Q?DwQEP6hR1V4MEG6oXDCPSOEFt6lZyP3U9Jd8NFR?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1592d171-50f2-480c-656e-08d9902b1b39
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 22:28:26.6625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uORNzAF7Wy7f8LGjqWTVbD2QG4NWA3cHcF8kPY8aIU4Pf9kOp01Fmir6LxZBBkh6Rtz/CjO+LUJbByCuwklqTJ/C5H+h5Uw6h0hAVxaEzwo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1299
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 10/1/2021 9:02 AM, James Morse wrote:

...

> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index 9f45207a6c74..25baacd331e0 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -282,6 +282,27 @@ static bool apply_config(struct rdt_hw_domain *hw_dom,
>   	return false;
>   }
>   
> +int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_domain *d,
> +			    u32 closid, enum resctrl_conf_type t, u32 cfg_val)
> +{
> +	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
> +	u32 idx = get_config_index(closid, t);
> +	struct msr_param msr_param;
> +
> +	if (!cpumask_test_cpu(smp_processor_id(), &d->cpu_mask))
> +		return -EINVAL;
> +
> +	hw_dom->ctrl_val[idx] = cfg_val;
> +
> +	msr_param.res = r;
> +	msr_param.low = idx;
> +	msr_param.high = idx + 1;
> +
> +	rdt_ctrl_update(&msr_param);
> +

rdt_ctrl_update() will take its parameters and recompute the domain that 
is already available here ... seems to take a few steps back and then do 
the needed. Could msr_update be called directly here instead?

Reinette
