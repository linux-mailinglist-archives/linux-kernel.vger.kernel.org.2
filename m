Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 127DA32A98D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 19:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1581028AbhCBScw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 13:32:52 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:12395 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349312AbhCBPqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 10:46:14 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B603e5bbc0001>; Tue, 02 Mar 2021 07:37:32 -0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 2 Mar
 2021 15:37:31 +0000
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 2 Mar
 2021 15:37:23 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 2 Mar 2021 15:37:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OihoGsNdgOCVlrfbYsUKLvufNhBWg7C0L8rWBYxcEMo0jSDNI3UDpPq51CdOeB5ziWJc3VL+QFATFP/I6WroItOHk+EebBrd85d97RfgiX/PCvDetMtU5PPr9bRXl8owD6zHPleMycnXTl/TXJkdZrWO7oIinIeNh+Ut48GBtyzntJCXlviOY8HGkCjg81KAqAL0ix+ZqF16gFHB/voyvtGXwYQT5qDEJVOlvDHWbCujOAC8AkB3OiU75eKFJC5CP9zgFto6W0+iOK2brcRI2s+dEmNAYNLIQQLOHh0Vzfgtf9Tdojlq4L+8hbcvQ1BRNPe0LXIkgo3yw6OgeXEaKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swRW7vKgLpMinSTyIJB2EGIPW004uOqwBuh6V6dwxWk=;
 b=ivzftwwIsGzjtZXcE8ydnmdl+cgm8qHgMSbudSfwdU/kiUFcVjmFhfB3Mh4wPignUf0JPqFU5u28TTyuzgK6YtRStishpKZzzLdNabaXO/y6SJvW7ybvieR13yTZN9Kuw6Z1jgsXHwmv51npasKkzCy82OvX7XmQhIqH2s3K2HTDCFDsy4TX3RzG4Uhi70tHCUOrBFxpo5ZywlvrYsocn55RwbaBUx+v3dZ8XETD7x5UyMOlDkLYVo3Nw2YwLvYIu/eTGuPHcnwGLyBIKgpFTI7fRQwwQphJQux5qNcs/GURJT0BlgGwRqRVsis8M447CY4tRCePxRXsXfOhoYpHNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN2PR12MB4015.namprd12.prod.outlook.com (2603:10b6:208:16e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Tue, 2 Mar
 2021 15:37:19 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a1b1:5d8:47d7:4b60]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a1b1:5d8:47d7:4b60%7]) with mapi id 15.20.3890.028; Tue, 2 Mar 2021
 15:37:19 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     "Zhouguanghui (OS Kernel)" <zhouguanghui1@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <akpm@linux-foundation.org>, <npiggin@suse.de>,
        "Wangkefeng (OS Kernel Lab)" <wangkefeng.wang@huawei.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        Dingtianhong <dingtianhong@huawei.com>,
        Chenweilong <chenweilong@huawei.com>,
        "Xiangrui (Euler)" <rui.xiang@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH] mm/memcg: set memcg when split pages
Date:   Tue, 2 Mar 2021 10:37:13 -0500
X-Mailer: MailMate (1.14r5757)
Message-ID: <1E25514A-202B-48E6-97F2-1E02B0980A96@nvidia.com>
In-Reply-To: <aab0bc059f3b4ffcb7acbac1724bcaa2@huawei.com>
References: <20210302013451.118701-1-zhouguanghui1@huawei.com>
 <733264DE-1845-4615-8573-481E63895397@nvidia.com>
 <aab0bc059f3b4ffcb7acbac1724bcaa2@huawei.com>
Content-Type: multipart/signed;
        boundary="=_MailMate_C4306F3A-BF1C-4435-A9C3-D7BA6C1A7E16_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [216.228.112.22]
X-ClientProxiedBy: BL1PR13CA0098.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::13) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.2.62.13] (216.228.112.22) by BL1PR13CA0098.namprd13.prod.outlook.com (2603:10b6:208:2b9::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.9 via Frontend Transport; Tue, 2 Mar 2021 15:37:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4068bd9f-12d8-4c5b-5a6e-08d8dd9110b5
X-MS-TrafficTypeDiagnostic: MN2PR12MB4015:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB401503085EDF4A200DA95EE3C2999@MN2PR12MB4015.namprd12.prod.outlook.com>
X-Header: ProcessedBy-CMR-outbound
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dSfZIAOad1zZ42lBrej/l5gvNDsfIv0TQk4oLHtHIiBlrA/Wd3dkgZApEgM/btk3o11DmWy6DoIWMiSNqFhQKdfREb7M+eJfgEqhP6wpGj7NC6eLIgYZyD+saLS2OL82gp7pithmO2iIjb+AkUaUmGtLndJK+LzV5o3u8Ekfv39lVSZmGi+OCIrkat9xmCiVTOeIQ+Q5XbxpbuaXcMM7QHx4k6BY/wtayukt7DwHw5GsnUZFtIc2ROlkdrpqAU71rj/d96tEfX6WNSv1mFARnzo/VGDZTUJfoI3vXLndLaCdErzGz/p114dmzGDfIZ0mml+T0G3wCDtBKt78IWn4ugw27/nDAuEyvUwIYGnsSS3VbHgPYklRbXJ9MMI9gZFi6gQ2hXPhosIu+XUVbMtewHiu1w0tfw4u7xM/B1qfy2yMxSNOKTY2W2ZEWAdTTaK2t5DQf9gKd6EI2HJg1zD9tkGqIK47EVlsSu9RfWbeBuUNimVaGG1mWm8NoUUVeClmCDIqAOA7r1Mhj23L2eRm7AgJgfdtV5+O6fvRLq7DWMT4fJ778VPF41BCJ9y8cJpVn6sWjt5gLHW25tqYrntUsavGkUkctyWmqGMtBsGy+mg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(186003)(86362001)(6486002)(235185007)(6666004)(26005)(478600001)(5660300002)(53546011)(83380400001)(16526019)(33964004)(2906002)(4326008)(66476007)(66556008)(36756003)(33656002)(54906003)(8936002)(7416002)(316002)(16576012)(2616005)(956004)(6916009)(66946007)(8676002)(45980500001)(72826003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SFh5MWMzWmFMN01Od1FxQ3IxLzdOanNDT1BpL3JVazh5OUhCYURpTzVEb3FT?=
 =?utf-8?B?ajkwNFdDbzFnb2VVbVdlOVBlTmhkek1HZG9lNUg5MGVZYU5JQlIyQzFpTXdk?=
 =?utf-8?B?d3BrSUw1UVFxVHU0VmV4WkNFQmRDek01M0ZVWEtWTHB4dWszK3BqVGVjUmlH?=
 =?utf-8?B?Rm54K2dkZGFTZGViSkFsS0hCcjZtR0k5SnJwVElVZnNEeGlkRlFhczZIdUlj?=
 =?utf-8?B?ZFRRemcxcnFPZTlucVhsVGpWQ0d2dGJHSGNCNUVFVyttQlpsUis1V1VMMTRM?=
 =?utf-8?B?NmZpbmRDVmlLNk4rZTVsTFhmcDdOcUJxVTBCZDBTK2FDZUpmM29mcDB3a0px?=
 =?utf-8?B?S2pYdXZYVUxJVDdZMU55anJhN0xUbmx6ZW1iaDNHMTJXM001RUhJMTVSYzBz?=
 =?utf-8?B?d1VVNldzb1pzbG1BNnZWdEVuVmJmWXFYWEFMbkR2ZlRzV2tmbUdBLzNMYXM3?=
 =?utf-8?B?TzhnRjFZOTcyRjJIU29MRnRqOVZXcjFacWtSMndrUUp6SkVDVmNQK2Njcmlh?=
 =?utf-8?B?b3hUenJhR1haMDdzUmlBc0c5ZXNjemp3RU5FajJBRTVFRnNiVkJaaFNzUjUy?=
 =?utf-8?B?LzZWREVSekFleFc5T3FNbUQ4OHErUHJNTUlWcE5RSmZ4RmVmSHp4U1djL1ZD?=
 =?utf-8?B?V2F3SU9MWmZCOWVBRkNBT0laOXFEd3RtWXEvdTVlb0NIazMyUHBqUmR5Z2k0?=
 =?utf-8?B?SHpBQjgwaUZtakhVWGh5U2F2SEFxUjJ2V2FVY3hWclNocGJrU2NvNlordUZw?=
 =?utf-8?B?Kys0cHFmN3JkQ0lPOVROeGRwSm5nY1RET091ZlJScTRWYzlONHhkeU9VYllI?=
 =?utf-8?B?bTVoZmdwcVV0R3BYWXJtRUlud2ZkVC9Za3N6UW1qWmJ4NDdFcERyUjlvVEJX?=
 =?utf-8?B?V0pBRVpQdHVDT005OG9rckNUa3MwOXdBQWpEQmFrR20zNXluTnRIM3ZvbEpt?=
 =?utf-8?B?b0FLaHJqWGFIdmk2OWFuMlVCbnM0bVNPeHB2eFo5VExpSUx4aTJiRGpCM3Ux?=
 =?utf-8?B?N21JRXoxQ2VwL0pkaVlmaUtEekNBc1RkRTJxeDJnY3NiaUhVVjdPamVnQ212?=
 =?utf-8?B?RmRlYXlCcFI5SnpjcHJFdDV4MnMxVkc3cVd6QzI5dWwxdzZiTHRqdUZMVVFx?=
 =?utf-8?B?TTB5b1hLUXgxNXAwbzZBODdJbkpVZ2ZYUzJac2orYnZIenpvNWtqWEhqL0Qr?=
 =?utf-8?B?anhXZ1JCNnQyQlBFR2luenlSUGN0aHA3U2Ezc1F2RGRKMUxiN1NLbHkzMTZC?=
 =?utf-8?B?b0srWlpvYWx2REp5d1duTndjbTcrUS9aNk5PaDBYc3ZjUlF0SytrQytNUzNI?=
 =?utf-8?B?VVNpaFpka0k5bHNPMm1zOFk2cmdEZFJuVGtrRkRWamEwcXYxS3hJM3JJamx1?=
 =?utf-8?B?eGp1bkZHVkt4WmlXaGJpTkV0NkVDQXpqbGd3d2RiaTdWWjZnaU45M09Ibnkz?=
 =?utf-8?B?OE5SbGNoL09lTVZMSnRRTzl3VXFPT1QrcnNrSFlhbmlEaEtOM1FVdzNHUzhu?=
 =?utf-8?B?d2xuWmJBRVF6eVcxSFZBVElKaTh5d1NuelE0UE43UzF3OVFPRWFyUWRiMGJI?=
 =?utf-8?B?TURWV0NtNmMrR0tQaGYwR1N5Qkgyak5UbjNWUDVUa0xkSWFzTlV4Mlo2ZHpu?=
 =?utf-8?B?MHMrbkZWRVIzYWd6OWZKSWV4cEMwZzhMRDI2ZUpsclBtRjhJN0M3b2JCcWUv?=
 =?utf-8?B?bms4citvTmJ4ajB6RTdrcUNFZUNLRDF1WG00WEt1ZzZLYWozZENQOW4wUFl6?=
 =?utf-8?Q?mATZRbmKcjnOzHWamzPEcycUaD6kn7qN7M/qNA6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4068bd9f-12d8-4c5b-5a6e-08d8dd9110b5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2021 15:37:19.6380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G9348O8HSXvUqdHcDpY6RyseDsj3R87417StS8PK5LH4Sa8clSIAddH5jO663qnE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4015
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1614699452; bh=3MpVkV8UsZG+64eqGoeIH9pEZa11dtg3KZdPrW9zebI=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:
         Authentication-Results:From:To:CC:Subject:Date:X-Mailer:Message-ID:
         In-Reply-To:References:Content-Type:X-Originating-IP:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
         X-MS-Office365-Filtering-Correlation-Id:X-MS-TrafficTypeDiagnostic:
         X-MS-Exchange-Transport-Forked:X-Microsoft-Antispam-PRVS:X-Header:
         X-MS-Oob-TLC-OOBClassifiers:X-MS-Exchange-SenderADCheck:
         X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
         X-Forefront-Antispam-Report:X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=l7miPwTg0vUgROny23iluRDT1TmO1K3EYZa3vKoxY2T670V7gBnWh1Q2WilSGqWtB
         zAmm5BScJLqzEeiVrhvA4FROa3rFQFOyOcHVK7prsq+DgABdLZI0dNBM06sh0FBZYe
         6CALJKjuPpNi9FaX0ZC2BZePaJB8OL+suCEvupCIhjgessTvHIFvTKsBx/qqn1v5eu
         BdbmW0Xhq9YPJeBqWDnxdHJP0O0jqJlfxzmy5YQP3EW+/uQcGPTJ2fssHVC/JwC4zV
         e083RhSs6xtr+w29BI6QjkA0McQVy0hLUSbOhVDIjMNvUzlADH7KOExom2Wz/v+TQB
         q56DxuHT2x2FQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_C4306F3A-BF1C-4435-A9C3-D7BA6C1A7E16_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 2 Mar 2021, at 2:05, Zhouguanghui (OS Kernel) wrote:

> =E5=9C=A8 2021/3/2 10:00, Zi Yan =E5=86=99=E9=81=93:
>> On 1 Mar 2021, at 20:34, Zhou Guanghui wrote:
>>
>>> When split page, the memory cgroup info recorded in first page is
>>> not copied to tail pages. In this case, when the tail pages are
>>> freed, the uncharge operation is not performed. As a result, the
>>> usage of this memcg keeps increasing, and the OOM may occur.
>>>
>>> So, the copying of first page's memory cgroup info to tail pages
>>> is needed when split page.
>>>
>>> Signed-off-by: Zhou Guanghui <zhouguanghui1@huawei.com>
>>> ---
>>>   include/linux/memcontrol.h | 10 ++++++++++
>>>   mm/page_alloc.c            |  4 +++-
>>>   2 files changed, 13 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
>>> index e6dc793d587d..c7e2b4421dc1 100644
>>> --- a/include/linux/memcontrol.h
>>> +++ b/include/linux/memcontrol.h
>>> @@ -867,6 +867,12 @@ void mem_cgroup_print_oom_group(struct mem_cgrou=
p *memcg);
>>>   extern bool cgroup_memory_noswap;
>>>   #endif
>>>
>>> +static inline void copy_page_memcg(struct page *dst, struct page *sr=
c)
>>> +{
>>> +	if (src->memcg_data)
>>> +		dst->memcg_data =3D src->memcg_data;
>>> +}
>>> +
>>>   struct mem_cgroup *lock_page_memcg(struct page *page);
>>>   void __unlock_page_memcg(struct mem_cgroup *memcg);
>>>   void unlock_page_memcg(struct page *page);
>>> @@ -1291,6 +1297,10 @@ mem_cgroup_print_oom_meminfo(struct mem_cgroup=
 *memcg)
>>>   {
>>>   }
>>>
>>> +static inline void copy_page_memcg(struct page *dst, struct page *sr=
c)
>>> +{
>>> +}
>>> +
>>>   static inline struct mem_cgroup *lock_page_memcg(struct page *page)=

>>>   {
>>>   	return NULL;
>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>> index 3e4b29ee2b1e..ee0a63dc1c9b 100644
>>> --- a/mm/page_alloc.c
>>> +++ b/mm/page_alloc.c
>>> @@ -3307,8 +3307,10 @@ void split_page(struct page *page, unsigned in=
t order)
>>>   	VM_BUG_ON_PAGE(PageCompound(page), page);
>>>   	VM_BUG_ON_PAGE(!page_count(page), page);
>>>
>>> -	for (i =3D 1; i < (1 << order); i++)
>>> +	for (i =3D 1; i < (1 << order); i++) {
>>>   		set_page_refcounted(page + i);
>>> +		copy_page_memcg(page + i, page);
>>> +	}
>>>   	split_page_owner(page, 1 << order);
>>>   }
>>>   EXPORT_SYMBOL_GPL(split_page);
>>> -- =

>>> 2.25.0
>>
>> +memcg maintainers
>>
>> split_page() is used for non-compound higher-order pages. I am not sur=
e
>> if there is any such pages monitored by memcg. Please let me know
>> if I miss anything.
>
> Thank you for taking time for this.
>
> This should be put in kmemcg, and I'll modify it.
>
> When the kmemcg is enabled and _GFP_ACCOUNT is set, the charged and
> uncharged sizes do not match when alloc/free_pages_exact method is used=

> to apply for or free memory with exact size. This is because memcg data=

> of the tail page is not set during the split page.

Thanks for your clarification. I missed kmemcg.

I have a question on copy_page_memcg above. By reading __memcg_kmem_charg=
e_page
and __memcg_kmem_uncharge_page, it seems to me that every single page req=
uires
a css_get(&memcg->css) at charge time and a css_put(&memcg->css) at uncha=
rge time.
But your copy_page_memcg does not do css_get for split subpages. Will it =
cause
memcg->css underflow when subpages are uncharged?


=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_C4306F3A-BF1C-4435-A9C3-D7BA6C1A7E16_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmA+W6kPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKulEP/1iURdH1hpWZd/y2ZS4UD2FayDkx3r2i8ES/
/ubDNHcsAmhjYT9pzFzidumkBIKNI93QZAaHzXWcxIeeEmlbqJo7EYgMUEmKK+N5
+TSWJZO7ZtV4+IWNG4FXxl3XP4Ngo6KRqjFROtkbjYq/IYeBx+4hTVnE0/bDIPSL
Br8PFEP6JKatRCLxZkT4jXN/OApNauUtx6pYXZC12liWu9Ht0TLAibji7qviBinN
bC36IUzdem5h5SJN7k3rne1LLJAV78BFcV4lFqb2+cJXS3o1YyId+fWgOQ4dx0Zu
WlnjtXk+6j8mA+KSRsXUxjBcjl/fFvbMHyvEEP4l1hgeFx26lpfwPUSBEuiwLG+x
3Q+m4iFml5KfuzuOGlETML6Goas2lLEU0aQ1nhz2uSeZwGAXQVj6dDhcQEUMvfwS
oO8fflt063x+wi461rpA4PE6AMXlHOkib28vw94J1+OoBEFvbDkToL6ATxcnafHi
RoIBaZR8deya7st4lvQgtsFKPmUoL6YWk2nCH3kRBKOKQVt3B/u2mQ03MS56s4al
JnJCn+5YiYPV+CFcnRAtz4fLk6JClio599gSVNcQBKTlOUnYR4d3Uu3vIPvBv18J
QOmTqCuvOjLoqbfaPLQ7CfOoBY6El5Qb1UGgz1UugF3ADttjGDosfGJZ8yqNrTk3
HaW3M9XX
=GVr1
-----END PGP SIGNATURE-----

--=_MailMate_C4306F3A-BF1C-4435-A9C3-D7BA6C1A7E16_=--
