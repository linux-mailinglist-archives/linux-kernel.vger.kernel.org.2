Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D70D63FE4D1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 23:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343664AbhIAVWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 17:22:16 -0400
Received: from mga14.intel.com ([192.55.52.115]:32282 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231745AbhIAVWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 17:22:13 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10094"; a="218584698"
X-IronPort-AV: E=Sophos;i="5.84,370,1620716400"; 
   d="scan'208";a="218584698"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2021 14:21:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,370,1620716400"; 
   d="scan'208";a="476353834"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 01 Sep 2021 14:21:13 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 1 Sep 2021 14:21:12 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Wed, 1 Sep 2021 14:21:12 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Wed, 1 Sep 2021 14:21:12 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Wed, 1 Sep 2021 14:21:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hjnuh71NRh+NIebVHlcHra2Jc8jyZIe7Xwg64Yzsh5H4waN9TkMmCI2gZd26+ub4/f9ucvsebseFwmP7VhbnQApWvU1wVuG2HVD5F4p5QSCahpCvc88ZOY15erXbHlhTEoD431o12jqFl11kwAlCi8yCi+yJNl2V0QIT/twQr5j4a3LO8rW7zjSee8FIMNvVLG86JVr8QFectoZMsjtCbG7elqu0g/NwFPRk+ntxOd7bAWo4PycA8+CGcDGxAR57iD7ASuFB+BwCaeRG6dck9ZL64pJqlmR9JpMlABBdMMfnf3NxfTkRC6GNYSTzVSW22eON2/9M1XFLGzu3KrQRQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=klXGvaXa85CyEUuh38QFJVnb14cPkeUHqJD9URk8wXM=;
 b=kkJIWvOKTuUMBRmuRxa+SfpmIKAUuJHOChKNd6iJ4eSBlnxo0OxTKOXZj47MvnZsnlYpm35xNi3M0oHpStLT4GSW003znmQe8tcy9lGYciQRAWk+MfuOXzYa5d+DE9LGgfCnq++zhrSsmiSDyQ/JlBMhSgRn635jKDkp2nQYtEHA87rLItj/0ZiFHum/v4wneoFnqPwAt8gock82fSg259cQhp9ZL3fACXb2GP1jXmkSDK+mcz+Raw2ipbp7ReL4AEQxXSg7HacYXR0d82Hummo6dVP373SHfh3Ur70Xrq3btHbrTJSCKA3YN0GhMd2+/LeGuTyBAHcZ2/cckNfPxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=klXGvaXa85CyEUuh38QFJVnb14cPkeUHqJD9URk8wXM=;
 b=GRVm4a+9qKYWbW1pv/izbS5fTI57eNZ/nzW8wImsisMleCJP33Si0k9MRYYE5kMAyajdU9+WZR/M2d1EHDTuWCP2BiCeKVmcYNpZMlOz2lYlytyMMEk4oVDYDAZ2NSyEz4xvBtlKwsSW+CHcjRpyCTpULDHTIhS28WwxH05kkQI=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN7PR11MB2532.namprd11.prod.outlook.com (2603:10b6:406:b0::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Wed, 1 Sep
 2021 21:21:07 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::d47c:525:2aef:f6a]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::d47c:525:2aef:f6a%3]) with mapi id 15.20.4478.019; Wed, 1 Sep 2021
 21:21:07 +0000
Subject: Re: [PATCH v1 04/20] x86/resctrl: Add domain offline callback for
 resctrl work
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
 <20210729223610.29373-5-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <987bf8ec-44d4-6aa9-820c-8a2dff60d807@intel.com>
Date:   Wed, 1 Sep 2021 14:21:03 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
In-Reply-To: <20210729223610.29373-5-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0187.namprd03.prod.outlook.com
 (2603:10b6:303:b8::12) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
Received: from [192.168.1.217] (71.238.111.198) by MW4PR03CA0187.namprd03.prod.outlook.com (2603:10b6:303:b8::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.20 via Frontend Transport; Wed, 1 Sep 2021 21:21:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68e9e228-6966-4f06-a385-08d96d8e69af
X-MS-TrafficTypeDiagnostic: BN7PR11MB2532:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR11MB25322AD9ED89BF71263519F9F8CD9@BN7PR11MB2532.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kVbUIvoCIUmBH1ubPmntnwrEkZjCpNYpbZ/Ss9g3yGJCLVlyqd9fk5wjtk9NCD6Hj0XtgnQu3+cEfKK7Gy5nQYMXMyxqVHwgxVMZTFQ0JSXv8OBpdnaVep6yziulhG4HzQg8iv4kC5hL4+HHnLH9zB0JiXw+GAu/SUj2zBqyTq6UzxpRNL3UPH3PFHfOMauDO/aujr20t/8AxaEJUmHQe+eAKbkD3BVpT5XpBnp4lGxPxIB8dPBsGGEV57/RQIG7MVAwqGDPBNI5lfU1qz5cEA+WMwYDnz7NGKWfW0Eahdc6cc6dExCYKNLuQGmYz4F1hZFu2PjRUEBn6F0e/toAtA6wio84LOMI7DmdbvtdeiOB0DQCV/q9rg4R1doX1DrCcQW2qMB/YNIYdxN4n693DGBmS2bOpjc7AeH36qZT/9KS1PhGcnOvs2x+24sbZHZcLWzRozgOMFhZnRTWNBUd5heKw5/jrfPuYm9QgGdR/0Y08LC+yU2fbGxfW0vlW8Tfrah8teJ7MnzNEMDH2EodeBbkIvUuyxOp7UY+BgLFfd8WHazhjpLqpAK+ngnjQWfmzEpGD2jNBFg/l6L1DcEtDqc9EXSn3Mj8ftPZzHoO9XiVuH3Iul+ltOVPfxUFKfsIM79vvO5yMyrbIeG42YLQmMcOhQdXKRE8Dn0eWY21YpalwnhPLVOKtQiCauR2LBJ/GDPXXj7k4ANVO+t0Io/9v/gyn3ZuupujpiQnHVLHgjE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(5660300002)(6666004)(4744005)(86362001)(66946007)(66476007)(66556008)(31686004)(6486002)(31696002)(36756003)(316002)(16576012)(54906003)(7416002)(2906002)(8936002)(4326008)(8676002)(508600001)(44832011)(2616005)(186003)(956004)(53546011)(26005)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXQ4UVM4dmJqWWdzeWhlVVhHSjZxZ1FHVGZwanUzOFFvTzNVWUV0TklTbUFY?=
 =?utf-8?B?WFBYV3duS0E1MEw2NGx3WU95T0tEemt1SXlOa1dBczRhK3NHRlErdDhiQVIz?=
 =?utf-8?B?WmVVYWlUbWZrc1dHeEZTT0xNL2tRUkYzd3I0UlRPYU1MUlFqQVNuemt3MXE1?=
 =?utf-8?B?T2xWanRJcmhSNFlXdU8vLytRazlFSEZKa1pwcVIyYktTS2FtMW13L1hucitB?=
 =?utf-8?B?OFFuSUJFUWRGT1pVSUV1QkZEWmFoTlovY3luckRFY2xMQldUbVVWenlaSWpW?=
 =?utf-8?B?K2J3OERqT0djZGVqdDhYRjFqWHdyaXU3bnBGSi9YWklvWGF1c1dINS8rVXZI?=
 =?utf-8?B?cFBDK3RpaGhkdjAxaTlEaUU4WTQ4ZWZRWU4zcitUT3ByN0JIZmdNRm41d0Qr?=
 =?utf-8?B?NzI4Y3FITjU1dXluNDZ4bFRNTGFFTVJVQWVYeWFVaXF1dzk3Rm9pbjJmektz?=
 =?utf-8?B?RmN2WXVwdDR1UXdDVWdiNU5VK1RJb3RwUU5GQUNveUN1Vk5WdDV2U2tSYXlF?=
 =?utf-8?B?SWhNWVhsZGtFOXFIOEVpL1RkS3Qvb1RKYzdHRE5ZRGdpaW9GR3Z4eW1jZVpj?=
 =?utf-8?B?aWtaVVNpVG9hQ2dBVlJYZkhXc0xFN084K3VhVEhlVmdBc0IwemtVd0xzR2FT?=
 =?utf-8?B?NWs2djBPQlBtUVliaG44Mjh6UlhOazJkMXhYVWw1M3hvbDNKMzVHbmd1UDIy?=
 =?utf-8?B?RVBlY2RUclJxN2w4UWFGZ1Fzd2c2dDJ6OHhpb25SUDE0UDRPZkVpdUhEQkxw?=
 =?utf-8?B?V3dHcUtWZUMzMUxGM3BJQmR0d1I1QTM5dEhCUmxWK2JXWS9yQjdYcmk3TU5v?=
 =?utf-8?B?NjQwSWNNT083WjJzQi9iazlYVXNGdkFPN2J6VkpXdW9xYVF2WUM1SUhZdjVK?=
 =?utf-8?B?Ukt3czVUQUxsRDJQQ2xSVUJpenNCYTZmWU5MaDZBQzVvaHVHanZITnVkNmlR?=
 =?utf-8?B?Sno1OUdJL2lNd3VuTDE1dXZZV0Z6aG80TWV6ekdzZVR2VWU1cnp2M3ZBbVh4?=
 =?utf-8?B?dkpHVGV0N3NpS01QZ1podjVIUWc2U2Q1akN6dUZ5RHhvZ0dsSW1wLzlYOWtK?=
 =?utf-8?B?Y21oY0xYRFNzcFB5SUNPUEVJU2dLUUVBdWFORkJ0cXhkRU8rYVR1S25qWm1r?=
 =?utf-8?B?R3VVVnNuS01iQStpczB5MS9jcmlneGRWRkM2OFJsRVRlbEFJTTV3Uk9vMWR0?=
 =?utf-8?B?aHBjdE5QdmJsd3V5OUllcnVDUmVXYTl0UlE2TEJLWXhFSmo5OWtVR2JhQmJO?=
 =?utf-8?B?M1Z1eUZUYVJrNEhjWkV4VmlYTEY2MS9JY0lPVzZCY05zckZQa3RDSzlXVWZL?=
 =?utf-8?B?L1djN3FWRzBKay9QTWdNelVqdDAvUjdiQTk2dGtwQk52c1l5bzBUUENWTU5o?=
 =?utf-8?B?T2lpTEdlL2svbCsvTk1jM2FjekFsQTVMMWwyYSs1RFBYbS9PdzI4WFEwR0hO?=
 =?utf-8?B?eFRUS0VrbjhKbnlGMnZHVkZaak5QUFJ4c0ZzVmZweS9SMHJGd1lPcmVTdVZp?=
 =?utf-8?B?ZWlySnZqMklCSUd4NHlVWE1mcVhya3pCeUFISlI3ZGR5S1hoSVZlODRSamMw?=
 =?utf-8?B?cmZ0MGR5dDh6YXBVT1FQeG9WUldxdlRtVnljVmVFODBWOVZ3MDhDSnlYblV6?=
 =?utf-8?B?VWRDTWpkemRvVTVEMndSMWQzNm1qdFdVREh2TWdMWEVVbW56M3JjSFFVaWhE?=
 =?utf-8?B?MVBUQWNRVDlvRE80S2JmTys2QmQwVUd4bk9wL2VzeHBRd2lST3R0cjJXaXIr?=
 =?utf-8?Q?T8v9NI1jZQeNmXY4Y0JSdZcAoIOGxcU3D/xwlXM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 68e9e228-6966-4f06-a385-08d96d8e69af
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 21:21:07.6762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +AH3scby2H3/1KPaoRuEKx+J57u3suZtvndIkFva0qyzGumOvodMAiuPL3HKwiHHNeLnMBWZKDLpp99Ne2PwDlChrKVtyLJhfewVkMHvEbM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2532
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 7/29/2021 3:35 PM, James Morse wrote:
> Because domains are exposed to user-space via resctrl, the filesystem
> must update its state when cpu hotplug callbacks are triggered.

cpu -> CPU please.

> 
> Some of this work is common to any architecture that would support
> resctrl, but the work is tied up with the architecture code to
> free the memory.
> 
> Move the monitor subdir removal and the cancelling of the mbm/limbo
> works into a new resctrl_offline_domain() call.

Same as previous patch, could you please elaborate how the code change 
you describe fixes the problem you state earlier.

...

> +void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d)
> +{
> +	lockdep_assert_held(&rdtgroup_mutex); // the arch code took this for us
> +

No trailing comments please.

Reinette
