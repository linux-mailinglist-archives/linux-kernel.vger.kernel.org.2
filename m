Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D93742FE1B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 00:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243326AbhJOWaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 18:30:03 -0400
Received: from mga02.intel.com ([134.134.136.20]:7463 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243322AbhJOWaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 18:30:02 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10138"; a="215166134"
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; 
   d="scan'208";a="215166134"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 15:27:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; 
   d="scan'208";a="627957459"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga001.fm.intel.com with ESMTP; 15 Oct 2021 15:27:54 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 15 Oct 2021 15:27:54 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 15 Oct 2021 15:27:53 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Fri, 15 Oct 2021 15:27:53 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Fri, 15 Oct 2021 15:27:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vit9DoBxdmq4HPdbUj4wpr5UbIJjUMVuEpKLCnoJUJxAHdouA8xiJuQyVDZSIEsGcA/IHjKaYvDhYay6w/EiRw8wX9w9DYtRWWfE0ctn/RE8hn+DmmV6aioZBvTGXRMZsdEp5qbONavC9mb5MKa578kzLCL+ToP3EIrTXAGpWiJYmTE6ZVaEnpSwa8Tu8KRBAiTWDsVnkhjPLX/BSH4VpmT2NiWry3iLMOEVi/Gu6OpzNZ3hh0ewhxJogyFqrs2hAatibGVqZsLIca9Zb3Zmw+dJw/GHUapj9ydeuUTlHZdLff/ZTirpLPyZ8iVmG4iSLA36M99ddqOqFPQmBRSKWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q+2SZlQi/tjig2ARiw71dFinmzWjgw/T9LKBejBPJrc=;
 b=YAkee3GP0BKE6SNQV+mmHYorZAUnxbjEQr5fdZtAogubcwVC47/Ec9roWGeMAzX9j+HUaxUUi07ysM+53bXjYb3vkWQU3cfJKrDowtWno9jqNCoDApKLH9ijFOAftvLtxO1PoIYHtYlGGuUA5lF8x4QRQ+WJqvq+Cdufx+cp0lTbtGQei2k0gmUyHlLXdq4uH5hVCH/TgFF+NbhwN0C+IZVQkdOa8ThGkhEJzmEcsMYHXcnl4NK05nMXqKpQBzT71uStiuQc7XbAyXnQk65FR3uei3HOcxDpyzzdb+6WrbfzB5Y2lEE0nvVI7pvBrEA70XzZ7rsBFaG+FaPUws0enA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+2SZlQi/tjig2ARiw71dFinmzWjgw/T9LKBejBPJrc=;
 b=uUtNxhERWTgA8HY0hcfM+F6GfmPty8z4A2bWlceuLtTbpU2a8FtdVFalmQziokw0chtQdWp20xWkJYD86K8oamk/r8lwU5PVy5qJYqrvIQ+uYHpNYLXfwhSdcZttLEnShQGUdyhzTbZVUVwHzm+072diZEIRdA/vz9y3CJ3mlRM=
Authentication-Results: fujitsu.com; dkim=none (message not signed)
 header.d=none;fujitsu.com; dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN9PR11MB5291.namprd11.prod.outlook.com (2603:10b6:408:118::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Fri, 15 Oct
 2021 22:27:50 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::d47c:525:2aef:f6a]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::d47c:525:2aef:f6a%3]) with mapi id 15.20.4608.017; Fri, 15 Oct 2021
 22:27:50 +0000
Subject: Re: [PATCH v2 10/23] x86/resctrl: Remove architecture copy of
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
        <lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
        <tan.shaopeng@fujitsu.com>
References: <20211001160302.31189-1-james.morse@arm.com>
 <20211001160302.31189-11-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <81977073-3b1b-b8e1-6aec-828225e3a531@intel.com>
Date:   Fri, 15 Oct 2021 15:27:45 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
In-Reply-To: <20211001160302.31189-11-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR2201CA0052.namprd22.prod.outlook.com
 (2603:10b6:301:16::26) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
Received: from [192.168.1.221] (71.238.111.198) by MWHPR2201CA0052.namprd22.prod.outlook.com (2603:10b6:301:16::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend Transport; Fri, 15 Oct 2021 22:27:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52eff2c0-5194-4a7c-c0da-08d9902b058d
X-MS-TrafficTypeDiagnostic: BN9PR11MB5291:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR11MB5291E72A74ABD67FB20AA1DBF8B99@BN9PR11MB5291.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QiWpiEA9rWkSSAlejDkmzR2yfD8+apL1dUoa01nwp7eMf1BQcLbUysHi4QX4neevnxBXmfFeQ+RNkWwZxiQ1u3pZr/JaxMSXCDdbCzK8cAfKnoSvQ4I4viD8N/jpMPMuORZoMzY+grQBGdXAQIol13oRbV12mlaaG5YZGVO0kTF4A0r4g3d36ySLtGpNLvZgKSML096Q56+c4OIjD8JsQapz+QEaq/R5S1oJwJ43xX6MGopEjDIq3jYLJ2sln8qba6HyoAMLM9jVb0Rb3F81jhjiF+YA/IyYt7kpcTOqum6FC2lkOtAzG9ByqEH9191kRQCs+ZQ0CEMijX642Rc2G5iftT9NmcMHRwJwPmYlTLDwNlTKCi8esGXj5lKcEnJnYra34yhXBpV90lu40wRA/GZNys5c1gYLJyxsaP4rlPjyspEWSxZ5jUx38od1eaIh8qAAucvTOW0A6B4NERJ2OmdnrQc3HVccrqt+YsUv7ecgDb/zXNG/gCcZit0nV8d/umaEhwqvg1PbjYl2ECKzo3p3gyz3piFH9DtMfnmW3tPlfYAAX821lDeJtu8+bj9CezSnUniAsLySHG23LMLqVmaKw17voOVHuUNPVqvjriC+oT4OwoppNbkMB8RORDuXE2wJsFtXT6mGihdR7SpSkG/gxAKYLcIQHUhMmsUhtXBSSOLYgqZx6KyNrvI3XLtk+7jsBLdNvoHp4Lwjd6CEr0O6y3YF5b4353MaBp9PaNc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(4744005)(31696002)(44832011)(54906003)(8936002)(38100700002)(2616005)(956004)(2906002)(66556008)(508600001)(16576012)(6486002)(31686004)(316002)(6666004)(7416002)(8676002)(53546011)(66476007)(36756003)(4326008)(82960400001)(5660300002)(86362001)(26005)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkhZbk5lMjg4a2Vjb0dLNzVjYWhQOWNQQmhtUmw2QTYyUWFaVjJCSm8wRjBq?=
 =?utf-8?B?K3dNT1c3QjR3QVZFaUtXeXRhRTB2ejQ2Sy81Ync4QzlmVFg4c1JSeGt4UTBI?=
 =?utf-8?B?MVVVejdaNlpKVEZWQklRQ0g2enFBYlF4bzRadmFpT1hHalh5b3pCNFdobnZB?=
 =?utf-8?B?dVBuZUpvSFl5WHlZVWxBcmxKaEJDRHFwMjcyaEdaRDBvUXZocTFDQkowaTcw?=
 =?utf-8?B?VnNaK2U1NGpvQU5OZGt0L1lqaWRUQ2wrNGc1WWFNOGdLN2NZV1RtMFVWeC9s?=
 =?utf-8?B?a0xxZmQ3dWE3ODRPa05iVE9GVU1BNmt4azBhSkdvelE0VWVDSy81R1ZmZWV5?=
 =?utf-8?B?T1JvMlhUbTYwMFlPcVc0SkNESDBGSW5Gb2JpMXluTmx5dUxlRU9CUkNZSk5B?=
 =?utf-8?B?aXMvOEQrRkRHNWRGVlkzVXRUSmxmcnRxMmo0aUVtdmJRWlp2cDExNHRnSGlh?=
 =?utf-8?B?ZUl4N2hlWE4vQlU4bDVSTTQ5ditkZUdlMXpFWHg5bXFYdy9JQU16TDBOUjZh?=
 =?utf-8?B?bmFnaDZjaURreGFLTEhxaERKUHUzMGsxM0JFQXh1UExtT2MxWUpwV0g5eVlE?=
 =?utf-8?B?d2pJWlhpOHBxVmFCRXFacnUxMXBUR0padlBITU1lR1A5Z05GcXNzQ2UzVHQ5?=
 =?utf-8?B?YVl5akIvOUxBYlJvbi9kNmNENW1nbER1UWo1OE8yam1pZ3pNbzNnd3JGeFJH?=
 =?utf-8?B?eW9NL05US1dlc0svQzJnR2ZoSUhzRmFtb0VhSGcxQlZBYkZjbUFrVm1IOFha?=
 =?utf-8?B?UHU5YWVMdW1SemEvbnZCQmxyYXg1SGs2S0pzS1dESjZBalpuZFR5Nk9xU2dl?=
 =?utf-8?B?WGVhcjZLU2lHMXZaTEptdCtUTFZYSmdEYVNxWU9vNHd5OG5YVEdzMXF0REJG?=
 =?utf-8?B?T2xYazhDUm5kUXpMRmxQcmJ6eEtuY3h2R0ZERzhGMTVvWktmdkh1RTlHdGdT?=
 =?utf-8?B?YnBHcDMxUk1VVURmWGU5dzNoYTZnS2ZMR1dxdktPRFZ0Qm1UTWxhVGdhTnVm?=
 =?utf-8?B?SXdDeVo3Qi9GV3BrMmtwQk52UGtMTmVFSVFnMVROVG1MZ0NaU1Yvb040NUZE?=
 =?utf-8?B?RjVhbHNuQ3I4dGZmNjgwandNZ0RRMDFjYmtXOVVrRzBBVDZEd2xJdFN3TTVu?=
 =?utf-8?B?RnBIZW9wbDdCYTE5dEwreW5kOTl4NWJvV0c4QWs1TEtjTm8vRVJkc0k5MG9C?=
 =?utf-8?B?eHhhaHkrUml5Z01xRmpiMnFtd0Y1YjlKOVRiaEpwM3ZNVHNKSmk5clZtN3o4?=
 =?utf-8?B?M2dicldUYjU4TUhZamlkUmpyU1JrbUZLRVV5M1VER3FYZVlvWGl5YmF5eGRo?=
 =?utf-8?B?VDcwOEdLUWZCRDFTcWt3Nm15R2FKdFpScWZITVMwV1Nuem8vQTF1T3hFVUE4?=
 =?utf-8?B?UlFhT2pJQmpFVk4yZnpHYnQranlOYWNpTTViQS94Q0lpSFI1ZUY5UDM3a2Vw?=
 =?utf-8?B?K3ZHOHNRdVBwNkNXVDQrcnNZM2pzaW5veGtIcFJmeDRqZkhaeTd0a21sK1N6?=
 =?utf-8?B?b0p5bUQ2ZThPU1dQbE1ZOWQrY2ROTndOa0dteFhoQ1JKVUs1OWRyWVpKVExj?=
 =?utf-8?B?eGZIQ1ZIckhpZHdMaWtkUGJ2b0Fzc2dHNU54UGhjY2JlZUYwSkd2R2NyZEVi?=
 =?utf-8?B?cU5heUFpclQ4UzRvblFJeXVLejlLcWlrZVZyUnZkSkFaU3RFTkZPT1dDbUU0?=
 =?utf-8?B?V2cwR04rYXRkZmJRS216Tm5WMmdzaFBqSmxZdXRUQ2JkbWloQk12N3JlcEVj?=
 =?utf-8?Q?kz7qqhWOhlQmDYpezWzQoMckENstj0xAopIL6Xh?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 52eff2c0-5194-4a7c-c0da-08d9902b058d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 22:27:50.2965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wAI7FACRIjwLZ0d8JuzVfYmaeRhFTqZK3EAzQINlohK1CqjpCZpoqkbq+SFHpQavpj/a/YyvyjfjHrKwq7JAoXh9LTl61yk/arpH8tBjBKg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5291
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 10/1/2021 9:02 AM, James Morse wrote:
> The resctrl arch code provides a second configuration array mbps_val[]
> for the MBA software controller.
> 
> Since resctrl switched over to allocating and freeing its own array
> when needed, nothing uses the arch code version.

With the previous changes this is true, that this array is no longer 
used. Even so, the code removed in this patch is not just the usage of 
the array but also its management ... especially how and when it is 
reset. While the array is no longer used I think it is still important 
to ensure that all the array management is handled in the new mpbs_val 
array. Perhaps just help the reader by stating that the values of the 
new array never needs to be reset since it is always recreated while the 
previous array stuck around during umount/mount.

Reinette
