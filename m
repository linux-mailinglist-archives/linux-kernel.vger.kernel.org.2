Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E61543B0CAC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 20:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbhFVSSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 14:18:22 -0400
Received: from mail-dm3nam07on2063.outbound.protection.outlook.com ([40.107.95.63]:3574
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229612AbhFVSSU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 14:18:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KO09xtQb5Hoi7WoZh/F7MMBHRe1aGbQtziyRnyJJmYyURIrcWjSMUudTsUClXt06HTLqoiHGutqCRKWKghmAYHf/+s6Xw6HiN78ICUh2J6mxpVq/ieJ0T6QouarH/KhClaisKrerSyXzUa+gAi08FlQjods8HG3LP4ZEGuoMhtsb1jDx6f1JIjVQ2UIJahdaNjzX/GPnTCa4PTRejPyyyUqogrgKNFp1hiU4XtpCqdM9fzD0U8W9WL9o0+IT2jwPybvMEGpTtlzdEM1LmWV/GWxEqpMUlkxhb6Y2d+9EfxZdZrbuLGdJF70Hxe78LH5pz8Ccpc9+tWFcKMdlFTPhwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qAIPzKW+KquI+cjqkvIibErACtd2+u854LtotnulMZs=;
 b=PTw0piT0ljib5he7N5fN7u57Tc+GhHLWR1IC5qFl/+4LIFsedMCS1l6FItpaLf/3y/cJoBfe2s0Hi4cdkNyB6PCGgOL93JMABzCrWyHlrky0DKgIjm7ZHfIs8PT1nfX6t3ZfCTGptz8PTOvBkPBorc97rYi2q/K3IRXMHFeuHhQ2h0voDctzlhh7Y4CNSwUjxZT2NjJqaVBIhjfjCjU0Chi0cCJgETJkZwvRjMJg76hrcQXC3812ChLJZJRdVWgSrtzv0EexdIjlFe+5BB3pUpHzXmW8bLw6wsDd8q3s0V+UbJQgjPm7b4nrc1KQoF4SvVotvZSHMXrkkkGkcGx8ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qAIPzKW+KquI+cjqkvIibErACtd2+u854LtotnulMZs=;
 b=tBDXZAvIE/yvsqZ1ITm5b/lFUIabHp/k5B9GOYdzq/TG1kj3un0A0RWFsiBj5DnD9SFVirCZEpR8hPORJfYZUv21R4QU/GEvBvjlnLwQJ8Al+/7pXDn2ItQ/iyn4Sl8hiQTbwLAFby5R6o9e0S4I4AGPu6QkZ02hlZDBSg5dY9FWOd/3gingn6r8COvF6uEp/5aWBjZhnMbJBJqjjeTr9fSzoaPU7rRo61aV+h3DgEGB8M1YvgqNb4bF/yv5hf6ZNy5V78rNGCGPmPRNrMOd417KjeD/9qP1R8DTQDqglE6bnGdY/WhimaqFw4t4LCZp2jeKqgogFVXf33DWKRu9ZQ==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by BL0PR12MB2372.namprd12.prod.outlook.com (2603:10b6:207:4d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Tue, 22 Jun
 2021 18:16:02 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::dcee:535c:30e:95f4]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::dcee:535c:30e:95f4%6]) with mapi id 15.20.4242.023; Tue, 22 Jun 2021
 18:16:01 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>, Wei Xu <weixugc@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        osalvador <osalvador@suse.de>, Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH -V8 05/10] mm/migrate: demote pages during reclaim
Date:   Tue, 22 Jun 2021 14:15:55 -0400
X-Mailer: MailMate (1.14r5812)
Message-ID: <AA5C91A7-FDAD-46F1-9B31-0511707E5140@nvidia.com>
In-Reply-To: <CAHbLzkpr96b2WXYS_Y1yA21crwuawYxPcBRmatR_jZO_mQY0NQ@mail.gmail.com>
References: <20210618061537.434999-1-ying.huang@intel.com>
 <20210618061537.434999-6-ying.huang@intel.com>
 <88CFDFA7-70E1-4C26-B9CF-7A0CEFEB035A@nvidia.com>
 <874kdupab0.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAHbLzkoOYoMuDQx7rBG0-9BrpczAbuE5_-HNLrr_Jn=ttc2kkg@mail.gmail.com>
 <87o8bymyzg.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAHbLzkpr96b2WXYS_Y1yA21crwuawYxPcBRmatR_jZO_mQY0NQ@mail.gmail.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_F165F988-9D07-4880-A7BC-953913FF3C71_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [216.228.112.21]
X-ClientProxiedBy: BL1PR13CA0248.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::13) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [169.254.44.40] (216.228.112.21) by BL1PR13CA0248.namprd13.prod.outlook.com (2603:10b6:208:2ba::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.7 via Frontend Transport; Tue, 22 Jun 2021 18:15:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f04edca2-7a6a-4a88-6be9-08d935a9cab6
X-MS-TrafficTypeDiagnostic: BL0PR12MB2372:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB237259813B18BB8BB7412B9DC2099@BL0PR12MB2372.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +WpmR9bP4iKQBBA161VTUkxoh/Xi9SfmEw2cDsLI07IEFbdqU9vUlLvZvWRUsr3WfnLSIN/aA2Zlt68WbgG/xY6PJIv7yvLYgx8ouw8SL/bmfMyXXn7TQHfTZdyAMKVz8ohgIfcUhRryqak7vmJERgl1+fvrBCYOHPwdVdg1t6OWg/UIoi40I+0Hpse1RE+UaSPVxgF4F4G7lLnArs+n0zQfX8pRcpEnyMGFcXjmW+usNmxeBBv7bIDF774DzZvWuubXg6COtjRJNHeBqkkqXEHXnNttexaby4CN21NJawX8GmT/qAA61mjYaxZ+dX68iYykW5iXsEIpY7PfmDqsdfg1NJKMfCBf/WbYE5GsQ35cZPcMEVkpLL2gbH0xnIz1EQHjjBYOCU/kOwodn/2A9+NdNEJ8ZiuUWXg/AON/3F+2fZo9W5kC8xUSI+09yV1lSgQYsDoPxv0IbUOqYx4BzmilVYxFFumm9iTZbMY0e18joKu7F8T7qiEP3r5Z/bz0jeVqWT/FqpcNMkL/tSxhBE4DGXXdUoZzn553/lDXuEE+i9Hlwg8nDoOr5OAnun4p3TFQGVeKoBYSaYil8/4RGhVwEyI8alzPgd5wRnP5T48Ak1OcooSE2b7MyaF59vGRfjh9BlXEhW9i1avTMManAQnscPPrca7yDAPOJCk4e2GvLdMUoXPVX7T1vkeYvbE51AsYWDw3i4XSP/L+aOjx9jMa5qbgp/A9USXkJZDdW/mCgT26ayxKQSelw/vC2CRw1mXwVoTRqEgGbC1G0gTEnEr0wHYtb9lxM82tBLJCGJKo3pemt/sR0P2iPZbMzasA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(376002)(346002)(366004)(136003)(4326008)(5660300002)(36756003)(6666004)(110136005)(235185007)(54906003)(38100700002)(33964004)(966005)(16576012)(316002)(7416002)(30864003)(478600001)(16526019)(186003)(2616005)(956004)(2906002)(8676002)(33656002)(86362001)(66556008)(53546011)(66476007)(66946007)(8936002)(26005)(21480400003)(6486002)(83380400001)(78286007)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aU9ZQ2NubUpWNTByS2cyRC9qNUMyUTJSLzQzTjVhaVl4QW45dUlMekMzNzlT?=
 =?utf-8?B?VXBlOW9ucklvSFNGM1JpdXBoVmloUGtsTGFSWkpEcEI1TlJsZUpFdWVlQnZ4?=
 =?utf-8?B?Zmp0TzE1VmdLZzdleVBpeVRvOUNyQnA3NVgvYTlmU2xIRlRSdVppRkdMZkJ5?=
 =?utf-8?B?YkV0T1lBbjZzTFViaXRwbDRacnBFSlUzTHZnQ0VlUTM2L1BlMW9pQ1huKzhm?=
 =?utf-8?B?a05UbENFUThUSHgzK0U4aGpXVGIyYUNCL3pRcktwZUJUWTNuZWw0UkJrZnpw?=
 =?utf-8?B?a1RXeDArSHBMYjFMa09Yd1oxK0dBOWhSc2ZTcEFQb2pKRmN2Z2dCemJXckxz?=
 =?utf-8?B?N3RiZmdrcjdOL1JXa0ZvVFVmUmpFODAyRnZsN0szb1MwaGZDcTE5Ni9wV2VJ?=
 =?utf-8?B?d05QMVBCb1pPWlVGMTljTDQ3SVo4ajdqV1VrK1RVWjExQ3JNYkRCcjdIdnNX?=
 =?utf-8?B?M0lKelI5cktnS2JHZkJxcTdxbjBKMk9VSGRxcXRBeEtBQnRqZXBEeG84ZHZp?=
 =?utf-8?B?eFBqQmJLaGJTUkd6RUM5eWZ5MXoxYnNwcTNZdjBYUHJobWE3VHNaVnRHajA1?=
 =?utf-8?B?WXovRHJFSy85TEhlcUtoMnBoOHlleEZYUklYOThQWkpMTEZMSzNNRlhrbGhG?=
 =?utf-8?B?dGhaOC96dmxZMnBZd0FNTUJaZFBCVVp0MTA1RjlMQnVhNzIrakFkdzBzVlZo?=
 =?utf-8?B?QlU1T0RpWWhJcVM4L0ZyRlRoQ0ZadUdDeXA2RnRmQmJlZVNrYVBOcjBOZ3Q1?=
 =?utf-8?B?ZXkwN290elNtZGJnamRKY050LzI3SXNEUEFiK0o1VmdEbkVYYXd1YkJNV3lV?=
 =?utf-8?B?YTl1Y2JHVUoxTlVvSXB2eEU2VnphR09MS1ZJdHEzVWNIQllxS3YzV0VLK1hh?=
 =?utf-8?B?L0l6V21zRWo5UXFIcGhLVWoxVXlCbjhvVXJwa3pjME14UVg1TXZjRlhIZmZY?=
 =?utf-8?B?N1QwVnhPQ3I2SVJvM3BkRjhwV3ZaVmZmTFZjVy8zZUczYkcxaWJMV3UxakVP?=
 =?utf-8?B?bTI3RW9IZmZVUDdtMi9pYVZ3L2ZVanExSEtjTlVCTmh0WVlFSGU4UVVNdFov?=
 =?utf-8?B?ZVIrTlcxS28zSUUrcmVJNCtDa3RSUDEzWGtDbTY1U2lIRTRjZHpGTmxhRTR3?=
 =?utf-8?B?Yk9aZ25Nckp5SXRMbERDd3RwYy9lcGtKSkNWdmRWS0U1eEZraW9WT2JqWlVj?=
 =?utf-8?B?YU52Y1p3MnErZ2xzcm5sRlR1eFY0aVkyY3lyam9tVndXUDl2VWNjTnMvV3Fr?=
 =?utf-8?B?WHRSNkhNZ0c1RnpuMVhoc1ovTFhYUmk0U0xpazhTUWFqQllkUi9FcFFjNVVD?=
 =?utf-8?B?VGNVbTJScitmT3R4N3c5M1dwVzBYd2tuR1FkYUJucWg3ek9wNUlmeXBKdGNz?=
 =?utf-8?B?a3V1STFtbktSMG1HbTY5MStEUjZNUEYvWWZrUXN5QmZBandUZmhNSUIrSnFE?=
 =?utf-8?B?VllQTldpbkVmTU9iS0RYTEZuQUxQWlZGeExWdTFvZzV4VjlBMHhpQ3Z0emRs?=
 =?utf-8?B?Sm9EQWRZcXVVZlRxc2lZRVc4SGNld3dZOTJXR1VuUUJ5MkdLOWJPcVI1dEhQ?=
 =?utf-8?B?QWdqM0t3QlQ4b3F1Ly9lZXZXU2RaZGNPVUt2UGRzOFZmTFpZL3JsaGUvdGRV?=
 =?utf-8?B?Q0g1bGJPNFNLMjFGaW56L1NkaXpDZnlna1lvVkpITFZJdDIxNDZKM1RvdzhQ?=
 =?utf-8?B?dmoreDB0OEN2L08xWWtINmVpcW1GakZWUWtWLzdzOFNnTlJocWRJTFBMZXhQ?=
 =?utf-8?Q?KewVXRWQNXoYVpV4BUFoReHFGuW8z6CvoSEUmIe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f04edca2-7a6a-4a88-6be9-08d935a9cab6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 18:16:01.7982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CWlRU2Slte6ZQC2WPYdzdS+MJ32DwlFq/aFBoSD+lrArfDoQE1OcRRZelqthP5ww
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2372
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_F165F988-9D07-4880-A7BC-953913FF3C71_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 22 Jun 2021, at 13:15, Yang Shi wrote:

> On Mon, Jun 21, 2021 at 7:09 PM Huang, Ying <ying.huang@intel.com> wrot=
e:
>>
>> Yang Shi <shy828301@gmail.com> writes:
>>
>>> On Sat, Jun 19, 2021 at 12:45 AM Huang, Ying <ying.huang@intel.com> w=
rote:
>>>>
>>>> Zi Yan <ziy@nvidia.com> writes:
>>>>
>>>>> On 18 Jun 2021, at 2:15, Huang Ying wrote:
>>>>>
>>>>>> From: Dave Hansen <dave.hansen@linux.intel.com>
>>>>>>
>>>>>> This is mostly derived from a patch from Yang Shi:
>>>>>>
>>>>>>     https://lore.kernel.org/linux-mm/1560468577-101178-10-git-send=
-email-yang.shi@linux.alibaba.com/
>>>>>>
>>>>>> Add code to the reclaim path (shrink_page_list()) to "demote" data=

>>>>>> to another NUMA node instead of discarding the data.  This always
>>>>>> avoids the cost of I/O needed to read the page back in and sometim=
es
>>>>>> avoids the writeout cost when the pagee is dirty.
>>>>>>
>>>>>> A second pass through shrink_page_list() will be made if any demot=
ions
>>>>>> fail.  This essentally falls back to normal reclaim behavior in th=
e
>>>>>> case that demotions fail.  Previous versions of this patch may hav=
e
>>>>>> simply failed to reclaim pages which were eligible for demotion bu=
t
>>>>>> were unable to be demoted in practice.
>>>>>>
>>>>>> Note: This just adds the start of infratructure for migration. It =
is
>>>>>> actually disabled next to the FIXME in migrate_demote_page_ok().
>>>>>>
>>>>>> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
>>>>>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>>>>>> Cc: Michal Hocko <mhocko@suse.com>
>>>>>> Cc: Wei Xu <weixugc@google.com>
>>>>>> Cc: Yang Shi <yang.shi@linux.alibaba.com>
>>>>>> Cc: David Rientjes <rientjes@google.com>
>>>>>> Cc: Dan Williams <dan.j.williams@intel.com>
>>>>>> Cc: osalvador <osalvador@suse.de>
>>>>>>
>>>>>> --
>>>>>> changes from 20210122:
>>>>>>  * move from GFP_HIGHUSER -> GFP_HIGHUSER_MOVABLE (Ying)
>>>>>>
>>>>>> changes from 202010:
>>>>>>  * add MR_NUMA_MISPLACED to trace MIGRATE_REASON define
>>>>>>  * make migrate_demote_page_ok() static, remove 'sc' arg until
>>>>>>    later patch
>>>>>>  * remove unnecessary alloc_demote_page() hugetlb warning
>>>>>>  * Simplify alloc_demote_page() gfp mask.  Depend on
>>>>>>    __GFP_NORETRY to make it lightweight instead of fancier
>>>>>>    stuff like leaving out __GFP_IO/FS.
>>>>>>  * Allocate migration page with alloc_migration_target()
>>>>>>    instead of allocating directly.
>>>>>> changes from 20200730:
>>>>>>  * Add another pass through shrink_page_list() when demotion
>>>>>>    fails.
>>>>>> changes from 20210302:
>>>>>>  * Use __GFP_THISNODE and revise the comment explaining the
>>>>>>    GFP mask constructionn
>>>>>> ---
>>>>>>  include/linux/migrate.h        |  9 ++++
>>>>>>  include/trace/events/migrate.h |  3 +-
>>>>>>  mm/vmscan.c                    | 83 +++++++++++++++++++++++++++++=
+++++
>>>>>>  3 files changed, 94 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
>>>>>> index 4a49bb358787..42952cbe452b 100644
>>>>>> --- a/include/linux/migrate.h
>>>>>> +++ b/include/linux/migrate.h
>>>>>> @@ -28,6 +28,7 @@ enum migrate_reason {
>>>>>>      MR_NUMA_MISPLACED,
>>>>>>      MR_CONTIG_RANGE,
>>>>>>      MR_LONGTERM_PIN,
>>>>>> +    MR_DEMOTION,
>>>>>>      MR_TYPES
>>>>>>  };
>>>>>>
>>>>>> @@ -191,6 +192,14 @@ struct migrate_vma {
>>>>>>  int migrate_vma_setup(struct migrate_vma *args);
>>>>>>  void migrate_vma_pages(struct migrate_vma *migrate);
>>>>>>  void migrate_vma_finalize(struct migrate_vma *migrate);
>>>>>> +int next_demotion_node(int node);
>>>>>> +
>>>>>> +#else /* CONFIG_MIGRATION disabled: */
>>>>>> +
>>>>>> +static inline int next_demotion_node(int node)
>>>>>> +{
>>>>>> +    return NUMA_NO_NODE;
>>>>>> +}
>>>>>>
>>>>>>  #endif /* CONFIG_MIGRATION */
>>>>>>
>>>>>> diff --git a/include/trace/events/migrate.h b/include/trace/events=
/migrate.h
>>>>>> index 9fb2a3bbcdfb..779f3fad9ecd 100644
>>>>>> --- a/include/trace/events/migrate.h
>>>>>> +++ b/include/trace/events/migrate.h
>>>>>> @@ -21,7 +21,8 @@
>>>>>>      EM( MR_MEMPOLICY_MBIND, "mempolicy_mbind")              \
>>>>>>      EM( MR_NUMA_MISPLACED,  "numa_misplaced")               \
>>>>>>      EM( MR_CONTIG_RANGE,    "contig_range")                 \
>>>>>> -    EMe(MR_LONGTERM_PIN,    "longterm_pin")
>>>>>> +    EM( MR_LONGTERM_PIN,    "longterm_pin")                 \
>>>>>> +    EMe(MR_DEMOTION,        "demotion")
>>>>>>
>>>>>>  /*
>>>>>>   * First define the enums in the above macros to be exported to u=
serspace
>>>>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>>>>> index 5199b9696bab..ddda32031f0c 100644
>>>>>> --- a/mm/vmscan.c
>>>>>> +++ b/mm/vmscan.c
>>>>>> @@ -41,6 +41,7 @@
>>>>>>  #include <linux/kthread.h>
>>>>>>  #include <linux/freezer.h>
>>>>>>  #include <linux/memcontrol.h>
>>>>>> +#include <linux/migrate.h>
>>>>>>  #include <linux/delayacct.h>
>>>>>>  #include <linux/sysctl.h>
>>>>>>  #include <linux/oom.h>
>>>>>> @@ -1231,6 +1232,23 @@ static enum page_references page_check_refe=
rences(struct page *page,
>>>>>>      return PAGEREF_RECLAIM;
>>>>>>  }
>>>>>>
>>>>>> +static bool migrate_demote_page_ok(struct page *page)
>>>>>> +{
>>>>>> +    int next_nid =3D next_demotion_node(page_to_nid(page));
>>>>>> +
>>>>>> +    VM_BUG_ON_PAGE(!PageLocked(page), page);
>>>>>> +    VM_BUG_ON_PAGE(PageHuge(page), page);
>>>>>> +    VM_BUG_ON_PAGE(PageLRU(page), page);
>>>>>> +
>>>>>> +    if (next_nid =3D=3D NUMA_NO_NODE)
>>>>>> +            return false;
>>>>>> +    if (PageTransHuge(page) && !thp_migration_supported())
>>>>>> +            return false;
>>>>>> +
>>>>>> +    // FIXME: actually enable this later in the series
>>>>>> +    return false;
>>>>>> +}
>>>>>> +
>>>>>>  /* Check if a page is dirty or under writeback */
>>>>>>  static void page_check_dirty_writeback(struct page *page,
>>>>>>                                     bool *dirty, bool *writeback)
>>>>>> @@ -1261,6 +1279,47 @@ static void page_check_dirty_writeback(stru=
ct page *page,
>>>>>>              mapping->a_ops->is_dirty_writeback(page, dirty, write=
back);
>>>>>>  }
>>>>>>
>>>>>> +static struct page *alloc_demote_page(struct page *page, unsigned=
 long node)
>>>>>> +{
>>>>>> +    struct migration_target_control mtc =3D {
>>>>>> +            /*
>>>>>> +             * Allocate from 'node', or fail the quickly and quie=
tly.
>>>>>> +             * When this happens, 'page; will likely just be disc=
arded
>>>>>> +             * instead of migrated.
>>>>>> +             */
>>>>>> +            .gfp_mask =3D (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM)=
 |
>>>>>> +                        __GFP_THISNODE  | __GFP_NOWARN |
>>>>>> +                        __GFP_NOMEMALLOC | GFP_NOWAIT,
>>>>>> +            .nid =3D node
>>>>>> +    };
>>>>>> +
>>>>>> +    return alloc_migration_target(page, (unsigned long)&mtc);
>>>>>> +}
>>>>>> +
>>>>>> +/*
>>>>>> + * Take pages on @demote_list and attempt to demote them to
>>>>>> + * another node.  Pages which are not demoted are left on
>>>>>> + * @demote_pages.
>>>>>> + */
>>>>>> +static unsigned int demote_page_list(struct list_head *demote_pag=
es,
>>>>>> +                                 struct pglist_data *pgdat,
>>>>>> +                                 struct scan_control *sc)
>>>>>> +{
>>>>>> +    int target_nid =3D next_demotion_node(pgdat->node_id);
>>>>>> +    unsigned int nr_succeeded =3D 0;
>>>>>> +    int err;
>>>>>> +
>>>>>> +    if (list_empty(demote_pages))
>>>>>> +            return 0;
>>>>>> +
>>>>>> +    /* Demotion ignores all cpuset and mempolicy settings */
>>>>>> +    err =3D migrate_pages(demote_pages, alloc_demote_page, NULL,
>>>>>> +                        target_nid, MIGRATE_ASYNC, MR_DEMOTION,
>>>>>> +                        &nr_succeeded);
>>>>>> +
>>>>>> +    return nr_succeeded;
>>>>>> +}
>>>>>> +
>>>>>>  /*
>>>>>>   * shrink_page_list() returns the number of reclaimed pages
>>>>>>   */
>>>>>> @@ -1272,12 +1331,15 @@ static unsigned int shrink_page_list(struc=
t list_head *page_list,
>>>>>>  {
>>>>>>      LIST_HEAD(ret_pages);
>>>>>>      LIST_HEAD(free_pages);
>>>>>> +    LIST_HEAD(demote_pages);
>>>>>>      unsigned int nr_reclaimed =3D 0;
>>>>>>      unsigned int pgactivate =3D 0;
>>>>>> +    bool do_demote_pass =3D true;
>>>>>>
>>>>>>      memset(stat, 0, sizeof(*stat));
>>>>>>      cond_resched();
>>>>>>
>>>>>> +retry:
>>>>>>      while (!list_empty(page_list)) {
>>>>>>              struct address_space *mapping;
>>>>>>              struct page *page;
>>>>>> @@ -1426,6 +1488,16 @@ static unsigned int shrink_page_list(struct=
 list_head *page_list,
>>>>>>                      ; /* try to reclaim the page below */
>>>>>>              }
>>>>>>
>>>>>> +            /*
>>>>>> +             * Before reclaiming the page, try to relocate
>>>>>> +             * its contents to another node.
>>>>>> +             */
>>>>>> +            if (do_demote_pass && migrate_demote_page_ok(page)) {=

>>>>>> +                    list_add(&page->lru, &demote_pages);
>>>>>> +                    unlock_page(page);
>>>>>> +                    continue;
>>>>>> +            }
>>>>>> +
>>>>>>              /*
>>>>>>               * Anonymous process memory has backing store?
>>>>>>               * Try to allocate it some swap space here.
>>>>>> @@ -1676,6 +1748,17 @@ static unsigned int shrink_page_list(struct=
 list_head *page_list,
>>>>>>              list_add(&page->lru, &ret_pages);
>>>>>>              VM_BUG_ON_PAGE(PageLRU(page) || PageUnevictable(page)=
, page);
>>>>>>      }
>>>>>> +    /* 'page_list' is always empty here */
>>>>>> +
>>>>>> +    /* Migrate pages selected for demotion */
>>>>>> +    nr_reclaimed +=3D demote_page_list(&demote_pages, pgdat, sc);=

>>>>>> +    /* Pages that could not be demoted are still in @demote_pages=
 */
>>>>>> +    if (!list_empty(&demote_pages)) {
>>>>>> +            /* Pages which failed to demoted go back on @page_lis=
t for retry: */
>>>>>> +            list_splice_init(&demote_pages, page_list);
>>>>>> +            do_demote_pass =3D false;
>>>>>> +            goto retry;
>>>>>> +    }
>>>>>>
>>>>>>      pgactivate =3D stat->nr_activate[0] + stat->nr_activate[1];
>>>>>>
>>>>>> --
>>>>>> 2.30.2
>>>>>
>>>>> shrink_page_list() is also used by reclaim_pages(), which is called=
 by
>>>>> madvise(MADV_PAGEOUT). This patch changes the semantics of madvise(=
MADV_PAGEOUT)
>>>>> from =E2=80=9Creclaim a given range of pages=E2=80=9D to migrate th=
e given pages to lower
>>>>> tier memory or reclaim them if the migration fails. You might want =
to check
>>>>> the caller of shrink_page_list() to avoid changing madvise(MADV_PAG=
EOUT)
>>>>> semantics.
>>>>
>>>> Thanks for pointing this out!
>>>>
>>>> Literally, PAGEOUT means writing the page to the disk instead of
>>>> migrating pages to the lower tier.  So it seems reasonable to make i=
t
>>>> keep the original behavior instead of demoting even if in the tiered=

>>>> memory system.
>>>>
>>>> If nobody objects, I will change this in the next version.
>>>
>>> I don't have a strong opinion on this. But I just thought why not let=

>>> PAGEOUT do demotion if tier'ed memory is available and the "migration=

>>> in lieu of discard" behavior is opt'ed in by a knob and we keep the
>>> consistency between passive reclaim and proactive reclaim.
>>
>> I thought about that too.  Considering the kernel API naming, is it
>> better to define MADV_PAGEOUT as writing to disk, and MADV_COLD as
>> demoting to the lower tier if enabled.
>
> IMHO we don't have to bind kernel APIs semantics to hardware
> configuration, right? IIUC, MADV_PAGEOUT means "we don't need it
> anymore just reclaim the page" so shrink_page_list() is called
> eventually, but do we really care whether the page is dropped (i.e.
> clean file page), written out to swap partition or just migrated to
> lower tier node when "migration in lieu of discard" is on?
>
> MADV_COLD seems more straight forward, it just moves the page to the
> inactive list. I don't think the patchset changes anything.
>
> Anyway I don't have the best answer, IMHO I'd say let's keep it as is
> for now. We could revisit it when the usecases get clearer.

That is my thought too.

Actually, you can either make MADV_PAGEOUT a special case, always
reclaiming the pages when shrink_page_list() is called, or change the
semantics of MADV_PAGE and add some text to the existing documents saying=

if multi-tier memory is present in the system, MADV_PAGEOUT will migrate
pages to lower tier memory instead of reclaiming the page when possible.
I just want to make sure we do not confuse the MADV_PAGEOUT user when
this change is merged.

=E2=80=94
Best Regards,
Yan, Zi

--=_MailMate_F165F988-9D07-4880-A7BC-953913FF3C71_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmDSKNsPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKiSYP/i9gcge+/YVQGHArB5bkj4VlAF3Fyv1IvfLz
7m95zjCI2MJ9BZ2w22/Y1CbxJ3XF8t/9rimE54TqSAb7/5mJvXRRtexINfxDvJ4q
zf7hGD3vW30jB4wvfsd5EL+FOxMUiRpFMn22UK2FR75NSGx+p4pHenC74i6TSUCU
Hi8EBpKSUXOqQc+hKV+vy78qGr/oBPv38Ya11i+HR+zTrAa+8S+ksJ5+lnCepRTa
t3NMrAMh7BVUTIyTHkSeYtMv2hVA7AvQhPhvN4JjJ28LD0gHeEoGllVdjhxtJem6
LCqgkp3+yqcXEkZtjSFPaTzkDES5HO9rfKzu1FGW01+Ek7ooPBMNu9xW+0DVr30j
J56e7Q9lJuJD2eI+zUmFrx4ZzuuZasAyw5ZJcG+KbQPVdnlm843SoseZGexZtkS6
xAukEsxHg3cd8wrCyV04dMAkoKC/YTyeH1gzOpg8UDbkiPO2pnUSkiCEG1rFtzvr
huMekebnOT1Dm8ZGPsPtKLMzG0nu1BZiOEZfgJ0xbWXNivia5BmqwGk2izq3p4JF
3fu1RBgcQkpgeEXMtWIA4xTT/k17rYaE3TCKPIGHIdz2NZP5cGhWPhdN59dyu6iU
Fm8shjnoqcxD5WUClpPWwU9N9xE6CGQlsYY4RLuYXJKmq+Pv84OFE0+klFjqoArl
IEuP+Cvq
=nOix
-----END PGP SIGNATURE-----

--=_MailMate_F165F988-9D07-4880-A7BC-953913FF3C71_=--
