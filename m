Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84DA1404124
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 00:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243521AbhIHWnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 18:43:40 -0400
Received: from mail-bn8nam11on2064.outbound.protection.outlook.com ([40.107.236.64]:60033
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240269AbhIHWnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 18:43:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZZGI5ggKP1yi15VKbpdtedkTTJlCSnKl0dx0GMv/wSKNc2RScm/E89e1Wm5uhd9tXS+4FAUpd/HWFVfW+HL8I6hUVUkF4zlgaqpwko3xl/CbVgCuBeZghJRNG/rwbDVjNtHrqYW42/CdGMZBZtdxlEhJhjONwxHsd9o5gSE35uK2qJSMzfYMzKLDK48dPt7Thzhtqh9O5C3dJ0YS+yqGbbzhF407IKhIDKFHm/cjz/tQS/+Y7J2FLUR1KVsxxhTpJNvzeKIFmW+uQ/TTO0izujr2uhQ4aXAHzDLu9z7+3q1+U0VeMYvrdNbKqev+sNthffGYsgTf6XQgT8C887IJNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ghGDySCOxD+tyRl9gZZ86W8oVwsc0UKlgQlzTddFF/4=;
 b=SaXLXgJX24JyOFxGeZjU9wZjCyYQ79w4N4U0P/ZUaUnGw6/iiYfMM6u+oIT6q1QInXtJ5qkXq5erEuRXaonvpGKhQ4EvPYetyiMAL/ccxry+AS0Gdp1OWs02V45BdJP3FSh9RmmJsvLbvgn6r1c8Tr2rsHWq13yG4FbScnKHHva4Mw1wepTofgR85hDPUpsiFxmDoJVv0nZRutMIxGm0cNB7dVPETD/8LupFLZSyfmgQMGHi67uKA7AhGVCWIef3Ei2Dr7mkx3kATCtOmqirTjOAMZOfGiigs6mKMCE3AYdxp7SmK9wpMEhZlGRNRpOhwgge7sGMLEgAcGcj5go0yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ghGDySCOxD+tyRl9gZZ86W8oVwsc0UKlgQlzTddFF/4=;
 b=lJ9lZaOn9x4rHo0PKixEANSF9dajewvgIZRkKpCvxwwmBso9XkOD4PgnrRA00iEm9uB20fe2tKAKMJ8VWD6jUvpHGJspdgkMxjGR3MNlOcAF6vGGkXKSpPP6LRACOZkgJla9c69zZCUOQcAlnBRDzVO0SVsMrsJ+ds5k1yj0yCaxXybOSrKiDdfL18F71aFrkI0ptdErmM8bWb3hUtWQJnihtGVqBkaFgjJ5uE/5iUtq1Ng0rlsX16A4FhHi6EXmrHQEj0GDyf+wMo2csr7PNXLDtbHq17qBxCBJeA4PMQ4LTJgjmC4urSnOIKcAC1ej/cse50v98Wb4GyLfdMV9Fw==
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BYAPR12MB3064.namprd12.prod.outlook.com (2603:10b6:a03:da::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Wed, 8 Sep
 2021 22:42:28 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::6811:59ee:b39f:97b9]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::6811:59ee:b39f:97b9%7]) with mapi id 15.20.4500.016; Wed, 8 Sep 2021
 22:42:28 +0000
Subject: Re: [PATCH] mm/page_isolation: don't putback unisolated page
To:     David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210904091839.20270-1-linmiaohe@huawei.com>
 <3b36529f-ab97-ddfe-0407-66f0cd1fd38d@redhat.com>
 <2d06db75-5c26-8fe2-6883-ac99056a9894@redhat.com>
 <b0a2947b-360a-40c2-03e4-f0f67845f4c3@huawei.com>
 <c60dc5e2-6f19-3be8-56be-555033cc9ca4@redhat.com>
 <b4615b3c-8217-9f32-39c7-b91c9ec3cccb@suse.cz>
 <80cfffdc-227e-c045-be74-1c08fb62c1e3@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <febcceaa-7d94-c3a3-c683-7a8694981b47@nvidia.com>
Date:   Wed, 8 Sep 2021 15:42:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <80cfffdc-227e-c045-be74-1c08fb62c1e3@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0031.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::44) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
Received: from [10.2.63.205] (216.228.112.22) by BYAPR02CA0031.namprd02.prod.outlook.com (2603:10b6:a02:ee::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 22:42:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c54ebc7-36ef-4e27-e088-08d97319efc9
X-MS-TrafficTypeDiagnostic: BYAPR12MB3064:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3064BC09F54F6FD4A724079AA8D49@BYAPR12MB3064.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: phOzqueh/4tqdQTfLL7D53wDytSiQ88j4amKs1oylPtZC/4eRU2zYjVFeCCQvHsxwmX9QLulte/1Htw9ZbWjd7sMtfw/Ss2WR3dMlhAsRvuNiHac9592//VY/kszSqxnlhSld44/+qzr66w1SgLlaBhr6sPJnIHcsp4C8XdIqyGLiAqJFPCeZGWfljVvaLk5JK5d8soKijBchMwwnSUqlCQXde64IxbrODi1/EHjQBu2trzVCroYsw1eeH4K78MOLNibmguIqiOs13ULXMMqgoG5cORVkEWgI7q6C3bIiwM915dnw4YAi5xJbBI7bLR3sFIPTYdoCEI8l5Yp0UffYzlVWY648zoC4IgT1GSoHRpNVzesKZfg+MNOmEkOg0v2HCyGoifffg0YratOD4IpLvlcOmFXezyZPXIuSNLIWwHjxEaaDQh2bQZe0liL/WuIEMq+SIh3VZubhfkyYlZddYi6pCtuBdDdQnb6sALFq53du8uaQHgp/kZXKip7aipZfL3znIGnyJhdocRY0ZKq7cX3BEQH0Kdp22wEEVtmwSWkywMd49cWjrUwe3w08jRKwpfzU3XyEW9RNQwPLomiyBunLl6psAzzMn8uxBzqY4Zi6ouf2ZX27z04BY+RiYAFtPLyLTjvL/yxHz1n3nlJbkJ8APgJR0f8yoLFuxypxmXcSeHZM9LUSPfnv0xYQA6GxH2ko7WvNeylIQZRxLDZWfkINdnODxRJ+B8Q/H+4JTYCW6GhWsWPBUiJ3f+APEz4ZQQ92lv0x5in4FsNitCdJePKaGsVn+aH5Pg0f+hQH+NOLxOsdgU6osAWMa+nhopqBhafHGiG1rfKorSzgw8acQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(366004)(136003)(396003)(83380400001)(4326008)(38100700002)(31696002)(6486002)(31686004)(2906002)(478600001)(86362001)(4744005)(16576012)(966005)(66556008)(8936002)(8676002)(66476007)(66946007)(316002)(5660300002)(36756003)(2616005)(53546011)(26005)(186003)(956004)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFkvbGJLZ2RXVmdZQ2Q5VWlVNEdiK2sxYjlRczBHbVJNcVdjVlF5MnFXa1RS?=
 =?utf-8?B?Z0x4R1VxVFFOQ1VENEExWnNSYTNtUitoY05LOUY3ajBVR3c4Z3h0ZEtQdTRo?=
 =?utf-8?B?SXdPZUxSMktnNmozMjVQUHEzN0lCbzlqdzBOSVI3UHZ1VHJNNWE2eVY3RHdj?=
 =?utf-8?B?bmoyWWxHOW84WTg3TFBJUWNZdDE2aXV0aVlTYjBGdXRGWXAwZW5tRXA2NDRt?=
 =?utf-8?B?VytjSDlROGI2clBOU0VnbUtIM0JkbFdnVXE4YVpaMmllZ0U4R1JMaGYwMkVs?=
 =?utf-8?B?b3MwM1F5TVlKV3dycGZuOEl6c0hGQlU3V2l0UWx4N2ljVDc4ckpmODhobTlh?=
 =?utf-8?B?ZEptRUZnSEtaMjhKSzhCWlRsdEJXUnkzV0dXNG1tTzJrK2g4UnNGR3NYSlhZ?=
 =?utf-8?B?R2hxR1ZJMS9aMlVLak9Uci9HckIvZXFYK1E2YWhRU045V0VzdURNRmRrcWl0?=
 =?utf-8?B?d09zUWVDWGFLL3haVlhtQzZxZksvTUZrYVRnVTlwL3p0bnBURlljMUEzYXFi?=
 =?utf-8?B?dGMwZ05LQ3I3M0RiUDVBVWIxVW8wQ09TUG1lVk1OK2xzT2pZL2RheUpMMmdT?=
 =?utf-8?B?cWQ4ZGdaM3k3OERXUXFsaEpHUVdtbjhOZ0VZMnR0bnJHRmg5UGJkemM0YkFt?=
 =?utf-8?B?ejJmQmZMY1A1RkFpYllWR09kTWZDNG5oS0RJeloybFdBY0ZYd0NEcFFQd3JO?=
 =?utf-8?B?WFZBM1FDVCttTTlHa3pYTkptdUVmZ2lFakMrK1o4M1dVY1V5djdGUjJDb1Nq?=
 =?utf-8?B?K0JRWTBZUE5sVE1MaVIvR2Q2ZFJXbThLVkY1QTZSSUNwVHVxSEl5cFJMeCtQ?=
 =?utf-8?B?UVFKUzNlZ25oRDRacnNHTUlLYmo3MnFQdXppcDBKQVdIeXhzNTBTbldYUTcz?=
 =?utf-8?B?ZXBicCtEUFZVWFJTMTdtekRNS0pyOEx0Y0EraE1GcjBRSkJjU3NGV1dJeHBR?=
 =?utf-8?B?V1VnQWo5RXN2SmM5KzBVWmY3aURCd0ZobHBmVVBDdUNGakNnRGNmRzZBWU5E?=
 =?utf-8?B?UUZ6S0IrMXB6ekFuV2xveUxlZ0JYYVdRd2RhemhKcDkwOFhLL1pDVGNmSkNk?=
 =?utf-8?B?eHNYT1ZtTTR0VjVCMXJ2QXVSaDlPMDh5elNwTHc3dUs4bUNHMHJyUGc3MnEw?=
 =?utf-8?B?NWJkTlZCOEQxUmdCdHJsSXFQM3FzNlNXNXdES3JjN2FMc2tYNmltUjY4RUtM?=
 =?utf-8?B?M0hjaDl3WE1Oam13ZnpuMXBqcGIrTm5OYVJSY0RPMGlGSGlNYmwwc29NeXkw?=
 =?utf-8?B?RG1oSW05QjlXQnoyeUNHMWJKcm1tdG1WTUNiOVZvbTdnbDZsaXpMb01BeVNI?=
 =?utf-8?B?bGxHSnZ5eVVnWm9DN2lwWUJkcy92QnBRNUJEQXppNUxiK2xNZFM5eDU5VjN5?=
 =?utf-8?B?a2IrNkFwM3JIVVBHRkc0WHVvQWxpcm1lc3VUNHRPeHRyUlE0SmdXbGtWVHVq?=
 =?utf-8?B?ZDJQelJ2QzliRDlBMTVOL0VPWWp3SkVmKzFJWlRCVkJERHh1Nyt6SHp0ZWFh?=
 =?utf-8?B?NDB0OFNlTVlhUmJWVkxVTmkxS1RuZXZyZ1d6MzZ2WEdiU25YeHgrL2hlU1pU?=
 =?utf-8?B?U1JXeS9KSktpSnFkUFU0dEVzODZGZS9RSTVzRlBEM1gxVnNFWEV0NGloN013?=
 =?utf-8?B?U3pDUlN1MkdRWVVkb29RaVdjd2w5NXFmbExiL2JWMTQvNndXRHBuU1V6QTFD?=
 =?utf-8?B?UUhJRjNXWXM0VWN6Zi84THpZM1hQRFZhayt5enVHN000WXltamtIdG11Ry90?=
 =?utf-8?Q?xJF33NzWBZRwGADoW0lDcF4fRfEVuj5UuRGg6SF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c54ebc7-36ef-4e27-e088-08d97319efc9
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 22:42:28.7213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pDaUNOVL8ANp2atITFkJ+3fE/PCWqhChzk4iTk5lG8GtH4l+Adb77bK6+EKztQ+C7VoLyOMU/0gu2wFwxrKtXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3064
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/21 2:56 AM, David Hildenbrand wrote:
...
>> If this can be handled gracefully, then I'd rather go with VM_WARN_ON.
>> Maybe even WARN_ON_ONCE?
>>
> 
> I think either VM_BUG_ON() or VM_WARN_ON() -- compiling the runtime checks out -- should be good 
> enough.
> 
> I'd just go with VM_BUG_ON(), because anybody messing with __isolate_free_page() should clearly spot 
> that we expect the current handling. But no strong opinion.
> 

If in doubt, WARN*() should be preferred over BUG*(). There's a pretty long
history of "don't kill the machine unless you have to" emails about this, let
me dig up one...OK, maybe not the best example, but the tip of the iceberg:

http://lkml.iu.edu/hypermail/linux/kernel/1610.0/00878.html

thanks,
-- 
John Hubbard
NVIDIA
