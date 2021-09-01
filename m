Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56EC83FE4CD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 23:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245517AbhIAVUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 17:20:55 -0400
Received: from mga11.intel.com ([192.55.52.93]:33174 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239661AbhIAVUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 17:20:53 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10094"; a="215738761"
X-IronPort-AV: E=Sophos;i="5.84,370,1620716400"; 
   d="scan'208";a="215738761"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2021 14:19:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,370,1620716400"; 
   d="scan'208";a="428101687"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga006.jf.intel.com with ESMTP; 01 Sep 2021 14:19:55 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 1 Sep 2021 14:19:54 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Wed, 1 Sep 2021 14:19:54 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Wed, 1 Sep 2021 14:19:54 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.44) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Wed, 1 Sep 2021 14:19:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lEme/MGfdjJl7f+WSUhdp3rO664f6ftUmEGE/ZomgRM6A8a0GzNObufkIAz/T5W+uPlf9iHVOFkuvue4VbQwyiqOZ/SWWHbySrqV1O8CCAIyko9v8/SAx3a6tp28JRkrxWWVgXLvmtMSpo+R+7K8NwQj8bIk+5QwMCKc19KK95fXXZJC6+xpxWRUH38vwGPNktDGkHtE9qzAZQFJzatookxlT8ksoFygAhaQYEHWkI/lT522VGb4jxRH1lYgPdpFXEjY4ccYfu9HmReQWwbAbNzyDX76KyTqIZCBvEHCsZzrUZs2/c2qnhQXTyByk6qAeh2H7UK4snKZZlBcdqLerg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=4gXwHh4aApNMKtQsCsLIz9UB0FVyUxv9djUwB7RAA6A=;
 b=ViEuXbXIhw8Jvwjk7d6MAJ4P8yI9XK4ALvXpWRHkM+7o+MimLdAcY3/OgqeXARtb+YUJT+YNpVJ3fVPKzEFBpD0hgONOEeI/E4opyb+rQ/oT2ukzKmfTZ+Uu2ZVMnxISe5JcZLUn2NOhIzBFgzbFKcM4MDsr4VLtYvS7WCCCvHYDHMlMO23AC7n23rQWnpUF66ercY7jEY/JF7UyeNYQixS+LqPyV0wYtVgcjyPcmI/+Jdaft9H6pH4AvghhHZsMpnIwBt1PVsDQ5gAOnQjUcNuL7ZlHwI9NLtS6I4TRaluKCIjrnF3DJQJXCYf5DdqaWAhKli3fDJrY/XQGYXzmOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gXwHh4aApNMKtQsCsLIz9UB0FVyUxv9djUwB7RAA6A=;
 b=SNW9YBYEZzqXVC5WMLANK5gbxTeSdpRDR39+/eddd9GjQ/mH1RPAd9CLZN4MqAyS073waAuCyhNA09yrpkeO7AMUK3SAwq+6MJq/rVsp2IRXvAXYULYk+J6DgAsEUoTc4DPSYqizIpuXBHA/tyUIQYVJkpc3qmljhz3423ThZJo=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN6PR11MB3970.namprd11.prod.outlook.com (2603:10b6:405:7a::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Wed, 1 Sep
 2021 21:19:50 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::d47c:525:2aef:f6a]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::d47c:525:2aef:f6a%3]) with mapi id 15.20.4478.019; Wed, 1 Sep 2021
 21:19:50 +0000
Subject: Re: [PATCH v1 03/20] x86/resctrl: Add domain online callback for
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
 <20210729223610.29373-4-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <fc092644-0f5d-b0d1-d14d-765bd42b9cf8@intel.com>
Date:   Wed, 1 Sep 2021 14:19:45 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
In-Reply-To: <20210729223610.29373-4-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0028.namprd06.prod.outlook.com
 (2603:10b6:303:2a::33) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
Received: from [192.168.1.217] (71.238.111.198) by MW3PR06CA0028.namprd06.prod.outlook.com (2603:10b6:303:2a::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23 via Frontend Transport; Wed, 1 Sep 2021 21:19:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ed2c891-8b76-419a-eb65-08d96d8e3b72
X-MS-TrafficTypeDiagnostic: BN6PR11MB3970:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR11MB39705E3612D7CEFC7FDB39DBF8CD9@BN6PR11MB3970.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bWKKX3aEFit0DonoiazYYvDICNn+zPBDL6jmQLlsguiCxmRLUM9g1g0lev/9jKvtNDbOUUe7P1YkLhlDaJkmNIAE45ZJkyQBPqE+IsIXG2lidWz5bUOxPRoty38nrWU78jkMqea0yms+pwU8pNQzFjdvgddN+ZdvKts0/LHxIC/w5/XNVzKyxHjJNSK3Yy4TDR8HrOfsPwe7MraB98a2nn806VtUAe5gmvb/dzYwDcgLULBmLLfSCgpb234DGPtLToXSEGEMA4GgnZH6LgVze/APsWrjHHxfzg351qBLK28jftKBKovifwuROxDaGlYmeKVF5a9C3TpErJIevc3gTEjDFcIiNL2V1y3ZjZtbj0lLYI4rQf0fImuND3BE9JUxTt3fQDUZT0rtblHakbzal4QDuONhfGNNmlamYmJ8S8bNckQfMonE5m5PiarGS1fCOOfDRlKcTH89GXijBwMwe3qb1CebKdNiykvOaY3KiNfwzqPyfxPURsAU97nZ7M0UC5wJq2EKs8qZYfuxNwu81r/oHQxYvMTTjXNwOZQMVlZhTTDD3wyAMD/kGu1hFsHUymgNI3IxSkaswfEytzfnPiE3HQACbVKgRa557SKBGUlzFvHGhC1HPfeGJmXyn7CNtL/ZmXdqSybOqjK1Y7NHWlfnhpGNIhfqPUMfebG2Gm86INhW7/xBKP/5P2O5/49Ke+LKp1j5Czf0r988mauHK9ErvuRKwZ7Pbn5oZcqaRKY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(366004)(39860400002)(396003)(38100700002)(2906002)(186003)(26005)(478600001)(956004)(53546011)(83380400001)(66946007)(54906003)(4326008)(8936002)(44832011)(2616005)(16576012)(6486002)(7416002)(5660300002)(6666004)(31686004)(86362001)(31696002)(316002)(36756003)(66556008)(66476007)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVE1TFM1cG50S2tSTktYUmtkUmtiRnQ5Z2U5dXJYL2ttaEk4Z3ZIa1NMeVpC?=
 =?utf-8?B?UzgvcUpjRWtTUHVQWHVENWc5VHFsbGoycmV6ZXYzMVVuQkFad3Z0eFROYVZ5?=
 =?utf-8?B?SUZycUc5RlZxeEw2bzcxNzBiTkVVUlh6c0taUTZBYjIrcWRyOTh5VGdqbGE5?=
 =?utf-8?B?SnhpazV5aXFXRFQ5ZG1LTWNTOEJpcHhmNXBZcFlqWFlHa0ZNZ3FJb3RCdWRo?=
 =?utf-8?B?UWRlak5oc2VHQXd2L1hoU0FlRGwzT1F5Q3F6R0VScnRnd2VWY3ZBRzJ4czhK?=
 =?utf-8?B?ZW5WUlZzeWxyYnl0alRpSmRxVzJ2bEJsTEpmOS9GUjR0NTNrMkg3ektLVk4x?=
 =?utf-8?B?bll3NXlVRjBRazZrT1FuSGZOTWNpdlhOR1paZzQrVlRsVFM4N25lbnR6Qjl3?=
 =?utf-8?B?NHB5elFpc0pqSkUyV0pBT3ZONGZxU0Zra2hHdk0vZVVyeFJaZnVVUjZBdDhl?=
 =?utf-8?B?YkprSzZQQ0FvYnFLN3BCMk5ZU3VqQzZlcTh1V0VuOFhlY3NPOGtlWnQ1d2RZ?=
 =?utf-8?B?RUhVQVRwYmJPVjlPb1FnUWs0ak9manlldmRJOWJoeENqVzhCNk9iUWszS2U5?=
 =?utf-8?B?UXdmcmFXL1ZMaDBpWVJGdzdwaWpldTJQK0M0UnNzOUVCNWg0b2xZMUtRcFkw?=
 =?utf-8?B?NWZlNDh6aldwMFRDcnNSZXg2d3I2L1g5bmRtRU9ucm9xNGVBNU8zREVCKy80?=
 =?utf-8?B?Uzc4MGNMTTZ1UWZzbnZjRVV5RXRKMjZjcjZCZkFIK29kc2JBc1pkK3ZITUJZ?=
 =?utf-8?B?eU9UK3hoanVjbk4weHV1RS8rMXpESExOVFNJREdncDgva2h3WFFtNld5dWxL?=
 =?utf-8?B?MVZqb3JLVXBrQTYvSU43WVBaNFhXNlFYQUJjVGFWRTc2Q3VhaHI0NzJqUUFz?=
 =?utf-8?B?c003VVVublM5aXBQcUdiVkc0UEc2R1FBQUJZUjg4VmZITEpWblRkTkhENGRU?=
 =?utf-8?B?R3hpbmlkd0E4S3U3aHorb00yMnA4NFdnRlRDaGNVRVpUWVIrdUxzY1o4N0Zp?=
 =?utf-8?B?NXNhT0p0SitCcFFtMGdlcFcxOVB3S2wySUhncHNPUzhFcGpNdllKcFIyTUVK?=
 =?utf-8?B?MTBZVG9uVzNaRWZNK2xJTkt6Z2FBZXd6TkhSc0hlaVREYjVaelRTUVcxdTkv?=
 =?utf-8?B?WW94b1NDSndSWVpkRFdWVFJ4ZFZDbDB3S0dxT1hiVFVTN2M1OHpXZHlNbHZB?=
 =?utf-8?B?eHh6RWJxdU5GOWlRcXBHbVJBdGZhZjZwVFcrNHoxblk3ZHdtUlVqNkZpMmpi?=
 =?utf-8?B?VVMwWko3K1JwalJEajVRYlVvQUR2YzZoZnEraGZlM2trV3AvTkV5K0x6OGRF?=
 =?utf-8?B?cmk2SmxOSnBBQ25pa284MHg1eUk2MXQ3bENiUUl1cFljUzRJQ3FoN2ZkVlkw?=
 =?utf-8?B?UFg4d21pSzNUNVluQUVrTWdFTlRSMS9DSkRFR0pnelNHRko4YXR6K1ZGcUFY?=
 =?utf-8?B?Q3MzeUQwTzcyQU5UUW5MQXM3OTJrcCtJMmpuK1EzMkNKaERFcFprc2tWNUcy?=
 =?utf-8?B?QzBvQnlINU5QTUp0VXhIQk5RWTMyVTZqZHlOUmZaSktZYWhkbE9QajIyYWhF?=
 =?utf-8?B?Q2l4SEQ0ZTllNjg1c2NtVVBTcVR5OWpDNGM1RmxtL2NEOW5KMzR0TXR3amJJ?=
 =?utf-8?B?ZnVNNXBWVXBVb1JOanUvYlEvL0o5YnZUUTZTOWNzL1krTlo3YzBCeTlhbk9s?=
 =?utf-8?B?TFd6TFZ1STlwVFFoZTBvQlBwTFgzSlgyZnNvUFBDSVZCRWRjY0NNbkpyR0sx?=
 =?utf-8?Q?JjlecbAkvS51AHhx0X7y0H13vCymRLJfY/assz1?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ed2c891-8b76-419a-eb65-08d96d8e3b72
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 21:19:50.0772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lTcPf9LiRlr2CQsJ8QL2druGud9Rbcl4282IO3WlemdX6bAUvB9UYSWSsIZJrQPUwGmj0kKN1cd6M3oCZ4xM2XTystCLCicu2ReyySckVIs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB3970
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 7/29/2021 3:35 PM, James Morse wrote:
> Because domains are exposed to user-space via resctrl, the filesystem
> must update its state when cpu hotplug callbacks are triggered.

Could you please replace "cpu" with "CPU" throughout the series in 
changelogs and comments?

> 
> Some of this work is common to any architecture that would support
> resctrl, but the work is tied up with the architecture code to
> allocate the memory.

(I read the above as problem statement.)

> 
> Move domain_setup_mon_state(), the monitor subdir creation call and the
> mbm/limbo workers into a new resctrl_online_domain() call.

(I read the above as what the code does.)

Could you please add description on what the patch does to address the 
problem you describe?

...

> +}
> +
> +int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
> +{
> +	int err;
> +
> +	lockdep_assert_held(&rdtgroup_mutex); // the arch code took this for us
> +

Please do not use trailing comments.

> +	if (!r->mon_capable)
> +		return 0;
> +
> +	err = domain_setup_mon_state(r, d);
> +	if (err)
> +		return err;
> +
> +	if (is_mbm_enabled()) {
> +		INIT_DELAYED_WORK(&d->mbm_over, mbm_handle_overflow);
> +		mbm_setup_overflow_handler(d, MBM_OVERFLOW_INTERVAL);
> +	}
> +
> +	if (is_llc_occupancy_enabled())
> +		INIT_DELAYED_WORK(&d->cqm_limbo, cqm_handle_limbo);
> +

You also seem to address an issue where this work was not properly 
cleaned up on the error paths of the replaced domain_setup_mon_state(). 
Thank you.

> +	/* If resctrl is mounted, add per domain monitor data directories. */
> +	if (static_branch_unlikely(&rdt_enable_key))

Should this be rdt_mon_enable_key instead?

Reinette
