Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8AA6435499
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 22:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbhJTUbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 16:31:15 -0400
Received: from mga07.intel.com ([134.134.136.100]:17145 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230020AbhJTUbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 16:31:13 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10143"; a="292338771"
X-IronPort-AV: E=Sophos;i="5.87,167,1631602800"; 
   d="scan'208";a="292338771"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2021 13:28:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,167,1631602800"; 
   d="scan'208";a="494806234"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga008.jf.intel.com with ESMTP; 20 Oct 2021 13:28:58 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 20 Oct 2021 13:28:57 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Wed, 20 Oct 2021 13:28:57 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Wed, 20 Oct 2021 13:28:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RbiyVO4gUafpHBMdK+VhPzZge0at5KSFXYdU7cZua4bCQi+fAXB8zrZv6O0pC6HV/0EOpjDVBjFoYxHLaUC83pblpBkSmh7zzjvUtqtbnpZw1ZlH1gi4g+EYb3E/VzJpLu7RzieI9rUUhhs+GeVZdTt+k00D0Ym51HVmY9SrXnO2NCe6bAFidol6yR2yhzVls7/WRD3JpZ1ZL5wlP3NXnx/nlZDYOYXch/Ui/huKAOKPho8+ltz5FgkoaccDIWqBipRE/f+H58SnbuPNU9Omvhbf9tXX9PVJyfCyPGpeJR1kdGVNKOTJfZ9+QXe2+fNRAmVKvt0wO5QhfOztoMwtgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GuF2hy8hRo3zLTgo/ViM4oFmjUGsTXXmug5Ldyz2sQk=;
 b=S3dD0+llWrRq+SnFjbI2gGBDIcL/goovbNTIpe9zpc0vT/G3uhLa+MhbVnksQcgnNch8XxekNzPuD9qp2E6oz+fLIZ6FQjjteBroGPXbgE2QQYFzi9wbnRXItFEpSHdxJlpTh2c96FzrDkfUc/jrnu2TDg6BsZW03IAqkIJglJr+I/68qn+YYt9gO+k/xCcxBDFklv+8Sv1T2KGQvExDfbAmMb70U3LGZat2Dx98maja3If5wl6933Y0m1EqXXJgjPmmtuDc7KJ0mc9OfuRL0Hh56qiV+1WxcPtB4Kr6rmvIqJLERnpaH7NFiCQvpfipVWzn59r5U7waIFfw1vxoDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GuF2hy8hRo3zLTgo/ViM4oFmjUGsTXXmug5Ldyz2sQk=;
 b=A+RmAvUwFSTjcuLgtV8a0icVZAj/KBq4ANhF/A76l2dldMu8N9YhnJifUoxtUUumFLgQVjKI1NlRUufJhsMZcrc3J3nSlW9UV02UFnoNlLv+kdhAt8KXNhKQ/qk6/XMOaVJeUU5ZhXLdTVMKv6PJqRICq0ed8pMQBMyJqmN3Zno=
Authentication-Results: fujitsu.com; dkim=none (message not signed)
 header.d=none;fujitsu.com; dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN6PR11MB1300.namprd11.prod.outlook.com (2603:10b6:404:3c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Wed, 20 Oct
 2021 20:28:55 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::d47c:525:2aef:f6a]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::d47c:525:2aef:f6a%3]) with mapi id 15.20.4628.016; Wed, 20 Oct 2021
 20:28:55 +0000
Subject: Re: [PATCH v2 17/23] x86/resctrl: Abstract __rmid_read()
To:     Babu Moger <babu.moger@amd.com>, James Morse <james.morse@arm.com>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        <lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
        <tan.shaopeng@fujitsu.com>
References: <20211001160302.31189-1-james.morse@arm.com>
 <20211001160302.31189-18-james.morse@arm.com>
 <887f8946-6d2b-27bf-a49b-f83af05cbc68@amd.com>
 <dfe2f33c-6103-9699-42f9-73983fa62057@intel.com>
 <81826a4f-c3de-787f-8059-4808815b4800@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <71efc804-4ca0-f31b-4485-005b3ad6e4d4@intel.com>
Date:   Wed, 20 Oct 2021 13:28:50 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
In-Reply-To: <81826a4f-c3de-787f-8059-4808815b4800@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0180.namprd03.prod.outlook.com
 (2603:10b6:303:8d::35) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
Received: from [192.168.1.221] (71.238.111.198) by MW4PR03CA0180.namprd03.prod.outlook.com (2603:10b6:303:8d::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18 via Frontend Transport; Wed, 20 Oct 2021 20:28:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e37c0224-32d8-4ec0-96ea-08d994083cab
X-MS-TrafficTypeDiagnostic: BN6PR11MB1300:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN6PR11MB13009804CB90EF10E44D18EFF8BE9@BN6PR11MB1300.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4jjQgntALPtjoUo5rhBwC0lKZpfx0uhgjnFqwD2anT8LR18700R6MZv/nY8UBG3GX4ge+jgQIImXWWXbF6znm2MfakV5a7kqPbxRjWytJiiFp2Ud4GCV1oZwc8l/o1s3Ir81WV9CTQJZczNbLiLHwjNtaaNoPposeSYeCV/cbSTq0onDi9WaK+nWNsJJuH6pC5B5cQwdxiQmEhWeFphutOtzXUXQgr54yZAkurrRANX+VciKx+b/GYuB5UrU27+t2MMofDUz+6wwCxV9J3X3dCf3dQlFFKUwl70z1zy0l9tT1PpuwC3EoOuxlwh7+ZfpV7KHjITjGfo078TdAjSk0X+1i6Nh8q7DAZIKYgUa28I5moOTrU1nhk25wqN5FcCZaF1IpHIsT1zuDyBn07qnejGRcJtZSfupp3MaxtqzONLQQKKAWs0X+au+kDPM3z40zIP68lqFLL1B9czULQ2Xp0UCogJxVz8p+JB6assNNdPF6CB6ymzOuNdsTdyKOKW069jT9ImUFV9XnLJ+7FIJV4IyerOHQogwuBYntf9niL5CoxYnKMsX+8QwiuSvchg8cA+FJjKwfa/87QdqwXfbov0HmsR09O598e1Cl7evB0ZvQjZvynAbijqsNkwA/1lD6IS9N3h4HuDP3eKAdzyxwQVfs5du6BsoORfggXNUe9J/E/VGGJT9bxbYL6B30rvzbPuKuBm8onY9OXAiQDiJPd4866uovDOiyOrr74umqVlbw6CJxDp0MxPXMfL1NWIyorSTtzuWSmk78L0BdkmwQL3E2Ig6WlJ/plNEqBsBbTUjEiIRdLTCYUI9fDQZvRkX+baMuldb7J7ecQkv06up3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(83380400001)(54906003)(5660300002)(110136005)(7416002)(86362001)(2906002)(4326008)(44832011)(316002)(26005)(16576012)(31696002)(6486002)(53546011)(8676002)(36756003)(45080400002)(186003)(66476007)(66946007)(66556008)(2616005)(508600001)(966005)(38100700002)(82960400001)(956004)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXYwSi9kaTJJelMwc2Q3K3o0ZUdFYjg3bWRBZjlpNWNUd0R1UDNFbm9xcloy?=
 =?utf-8?B?V2NSNlgzRUptU2ZmYzhnclF6dDNUWHNjeVlmTHVZSEF4YWVSdlcxKzdLcmtG?=
 =?utf-8?B?Nm52QjBSd2psS2xVSHVEUWRTZVhSTGQrTUQ0dEpGSEovT2NsVm8vMlZKMTJi?=
 =?utf-8?B?eWREVytHZVBTMEFSZUVtUDlkOU9YQjkwWDM4amVESGZlNTRyQlh2dklUOWtr?=
 =?utf-8?B?SUpaMU5FRXBud0t1bUU1dzFMU1N5elV3VFVESGxmWGlLeHdLMzI4NjcrUUh6?=
 =?utf-8?B?c3hNbTZCSm90a1JoR2tPUVUwZFJiTng4cFhkbGJaUkF3S2YrYVpWUkswVVFn?=
 =?utf-8?B?VDZIWG5ORmxwS2tZV2VQbTdELzZWOXVoVmEydHpZNTZXOWhuQU1lOFhHYlYy?=
 =?utf-8?B?Wkw1eUQ2anJjRGhZdWZwUk1UUGdsSnNCWWtxVnZFd000anQ3dzJmZWl2U2ly?=
 =?utf-8?B?NHZMaHF0UHdsWnZ5YkFGdDc4S0VmcjE1SDBLM0tnWFpDdjVDY2kyQ2Y2QTJw?=
 =?utf-8?B?QlBNSTg0TWE4amU5TndBZjdyQWh3YXR4bCtLMmFmbFdObWlHRVNTM3JnNnJt?=
 =?utf-8?B?S3QxS2dFeUo2QVBpRWZ3ZldkUGJEZ3lhYzFISk5oUnJuWVZpbi8yNlphOHlu?=
 =?utf-8?B?aHJ2dVRyTXYrUEhKN29LbXU5bXFQK0ZwOXNKeUVIcTZ6SHZuR3Z3cTF5eTFL?=
 =?utf-8?B?VHNCSjU0bHRKcnN6UmZoZURjVWNkdGJ2TmVWWkJ6OVFVSFdHWkJCVnVaT0Uz?=
 =?utf-8?B?QmlOZEJkUmxGZElSTGxRYVoxVG9wNmhNQmliSGlKcXdZZ3h6Ri9NVHp3Q2ph?=
 =?utf-8?B?ZDdlYW9ob29SSkdZTDJWRVI3d2ZVMm0vNzJBRDRmaG1hTHFVSmNCdHBUSzJQ?=
 =?utf-8?B?Yy8xS0JJdnUxSnN5aStwSDdYdjVXN3hYOWFPZUxBTDFjN0Rva1MvTVlmV3Bs?=
 =?utf-8?B?MGVhOUNTUll1NU9HNC9QR21UQ1BPdWZ3cDVDQnFxTU12ZzdyQ0FvVllUaXFM?=
 =?utf-8?B?eG16S0I0VUIwVVY4RHpBRGp0YmVTdENsU0NML0V3MjJRdDRUYjN0Q1pOSlpS?=
 =?utf-8?B?aGtqcmtpS3RiZmhjVldMV09VRUpGVk5LdnNlNDNVY1d0c1QxVkVIU3B5dSto?=
 =?utf-8?B?R0NDa2dsNFRMZi9VOUprckFDQTZzZExxOExqWWVUSXpmMDVZM1h0eXMxWjJP?=
 =?utf-8?B?bGR6U2MxVzRVRUZOSTkwNDFrdjdaMnl4NVBpQ254aGNiN0ttRkppOUE4MXIr?=
 =?utf-8?B?elA4QlNsMGtsMEUyQjB4QlJ1SXZsMGlEanZ3bHltekM5R1pMb0JhQjdJY3VS?=
 =?utf-8?B?MkhnWlVia2Y1N2x6Vm9KSFJjdUxNVGpvODZTSUNZS2FBdnZ5MXo1REhMSmoz?=
 =?utf-8?B?cC92eDY4czZLSUsyb2hRY2xBcnNENjdRQTV5Sjl5d3RxTGR5Uk1SaSs4dUNu?=
 =?utf-8?B?dlNkK3ZSWnZEdXJ2TWU4MlFMSnEyOHFrV05PL1VSZnVxR0Yza1o1bWhsVGZq?=
 =?utf-8?B?TC9yZjIwRGExMGdtSDdmOXNWZUM4NVlzMmxpTzhNcEVoQ2xNbTYzVGhIaXM1?=
 =?utf-8?B?NTdDZ2pYQWErcG5WUkhYMUtwS01vZVJ5Sy9JSXhrcXdkdzZVUnF4RFRzQmwv?=
 =?utf-8?B?ZDdoRUNoZE1KSzd0KzBTN3hsb2ltSi9lOHBxa1drSldtNFVJc2tUTWxNTTFT?=
 =?utf-8?B?NStGTUcrYTBVTjYwVWdPb1Y2azlIV3lIRTJMUDU5aTZpL3hHeTV2M3ptbFhJ?=
 =?utf-8?B?VDljUWtjTmtQWkpLMWdQWVR6TVRsTFd0TUJqYlRndk5xOVFyR2lQSFJZNHhF?=
 =?utf-8?B?d0kxQzhWUHFydE5qNDlYc1U0Q2ppV0dXSjRUU1NZN2kwTFZjVjNQQ05ETEVW?=
 =?utf-8?B?cVRSMXJ3cncrTTNuYklQWjZLUytwYjRaL3h0ZjQzU2JzWnVoQUZGci9GaGN4?=
 =?utf-8?Q?35HO5yQwFP8sLpbknKy+zg40rKnbgl+N?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e37c0224-32d8-4ec0-96ea-08d994083cab
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 20:28:54.9816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: reinette.chatre@intel.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1300
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 10/20/2021 12:22 PM, Babu Moger wrote:
> On 10/20/21 1:15 PM, Reinette Chatre wrote:
>> On 10/19/2021 4:20 PM, Babu Moger wrote:
>>> On 10/1/21 11:02 AM, James Morse wrote:
>>>> __rmid_read() selects the specified eventid and returns the counter
>>>> value from the msr. The error handling is architecture specific, and
>>>> handled by the callers, rdtgroup_mondata_show() and __mon_event_count().
>>>>
>>>> Error handling should be handled by architecture specific code, as
>>>> a different architecture may have different requirements. MPAM's
>>>> counters can report that they are 'not ready', requiring a second
>>>> read after a short delay. This should be hidden from resctrl.
>>>>
>>>> Make __rmid_read() the architecture specific function for reading
>>>> a counter. Rename it resctrl_arch_rmid_read() and move the error
>>>> handling into it.
>>>>
>>>> Signed-off-by: James Morse <james.morse@arm.com>
>>>> ---
>>>> Changes since v1:
>>>>    * Return EINVAL from the impossible case in __mon_event_count() instead
>>>>      of an x86 hardware specific value.
>>>> ---
>>>>    arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  4 +--
>>>>    arch/x86/kernel/cpu/resctrl/internal.h    |  2 +-
>>>>    arch/x86/kernel/cpu/resctrl/monitor.c     | 42 +++++++++++++++--------
>>>>    include/linux/resctrl.h                   |  1 +
>>>>    4 files changed, 31 insertions(+), 18 deletions(-)
>>>>
>>>> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>>>> b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>>>> index 25baacd331e0..c8ca7184c6d9 100644
>>>> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>>>> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>>>> @@ -579,9 +579,9 @@ int rdtgroup_mondata_show(struct seq_file *m, void
>>>> *arg)
>>>>          mon_event_read(&rr, r, d, rdtgrp, evtid, false);
>>>>    -    if (rr.val & RMID_VAL_ERROR)
>>>> +    if (rr.err == -EIO)
>>>>            seq_puts(m, "Error\n");
>>>> -    else if (rr.val & RMID_VAL_UNAVAIL)
>>>> +    else if (rr.err == -EINVAL)
>>>>            seq_puts(m, "Unavailable\n");
>>>>        else
>>>>            seq_printf(m, "%llu\n", rr.val * hw_res->mon_scale);
>>>
>>> This patch breaks the earlier fix
>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%2Fcommit%2F%3Fh%3Dv5.15-rc6%26id%3D064855a69003c24bd6b473b367d364e418c57625&amp;data=04%7C01%7Cbabu.moger%40amd.com%7C85219a5827114935cdaa08d993f59fa0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637703505420472920%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=yP8awDgGGZ%2BWj5ZItdTNJItTVuK828yGnibwq%2BrVaf0%3D&amp;reserved=0
>>>
>>>
>>> When the user reads the events on the default monitoring group with
>>> multiple subgroups, the events on all subgroups are consolidated
>>> together. In case if the last rmid read was resulted in error then whole
>>> group will be reported as error. The err field needs to be cleared.
>>>
>>> Please add this patch to clear the error.
>>>
>>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c
>>> b/arch/x86/kernel/cpu/resctrl/monitor.c
>>> index 14bc843043da..0e4addf237ec 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>>> @@ -444,6 +444,8 @@ void mon_event_count(void *info)
>>>           /* Report error if none of rmid_reads are successful */
>>>           if (ret_val)
>>>                   rr->val = ret_val;
>>> +       else
>>> +               rr->err  = 0;
>>>    }
>>>
>>>    /*
>>>
>>
>> Good catch, thank you.
>>
>> Even so, I do not think mon_event_count()'s usage of __mon_event_count()
>> was taken into account by this patch and needs a bigger rework than the
>> above fixup. For example, if I understand correctly ret_val is the error
>> and rr->val no longer expected to contain the error after this patch. So
>> keeping that assignment to rr->val is not correct.
> 
> Yes. You are right. rr->val is not expected to contain the error.
> Hopefully, this should help.
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c
> b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 14bc843043da..105d972cc511 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -441,9 +441,9 @@ void mon_event_count(void *info)
>                  }
>          }
> 
> -       /* Report error if none of rmid_reads are successful */
> -       if (ret_val)
> -               rr->val = ret_val;
> +       /* Clear the error if at least one of the rmid reads succeed */
> +       if (ret_val == 0)
> +               rr->err = 0;
>   }
> 
>   /*
> 

Yes, this looks good. If the first __mon_event_count() succeeds but a 
following one fails then the data still needs to be reported so the 
error code needs to be fixed up afterwards and cannot be done inside 
__mon_event_count(). Thank you very much.

Reinette
