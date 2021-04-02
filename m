Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D32435306B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 22:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234855AbhDBU5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 16:57:09 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59126 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhDBU5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 16:57:08 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 132KtYHG031296;
        Fri, 2 Apr 2021 20:56:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=KoTjXhLla9W7wd3n8hZZBCIhtadYXXOksAKZJEmtB2g=;
 b=bY/JUEuVn1+jWsXdUxAPXz+TjVg8P0K00oxInp5pIWNWE8P/PMrbVWG/DbkEZLRDkPpX
 Ql4xX2eduuIske47ipJ/dkE/VqF/BIGy/QXMPjyniJvJSERyxVkP1zJAidbre8jEZX5F
 Y6cyoJmzGd7Ss335wXlRByzRxmpOVq5elcbq9+QuU4MXe/utI/IeIVDSLkYWrqLGp6KQ
 xT9Z0unQK/KbyshU4roVFKdPUbZYu2piZ0lNu7lBcc+FFglz9+DO4Tl3rW0B20/xt2Qw
 mSl4EgYBb2xPgi1hiBythEE8o+D+h7pvm2hyh3bz9lSQnfq66rLHbfuvxge09+d2xUvO +g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 37n30sdh61-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Apr 2021 20:56:02 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 132KnfuF106202;
        Fri, 2 Apr 2021 20:56:02 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by userp3030.oracle.com with ESMTP id 37n2aue7np-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Apr 2021 20:56:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cgx62JkKG+YMpdSpJOn0YAOOAg9cR7Ipcl/dbQkkS21LyqDvHfCtnDZvqnUNZsIJoem5FCXtgAffU2LV5+8wlwYRBmrJO0Brhy3DKjVEMeANQkitj1yyZgDHIRkUsML2XfTcD96SrkicEtImkT8O6g0YcxDLXIE0eHnNQsx6Zy1Eo5m4z5B5AwLQxzhZOrvMPMQC4k5dn2VfpYH/jVdaQ142iB0agOTy7xstYDIXffPvXPyjrcMLciHCQHC84PXlY2REwrTp8F2SLZPaV4j59rtk9nHhQS24EA1d98R48/dp29wGICH8KaA9uFT2rpnFVsLEDl4Ih/u/0Es8/F2mvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KoTjXhLla9W7wd3n8hZZBCIhtadYXXOksAKZJEmtB2g=;
 b=Hrtt6YvgfoVMwKx/UavywRqnrjGGEOvynRR6LW+YEtRuWz8VDQvPitBxRfvXipXTu7qgOQ3R4xOEhucdzRM1ij14eD2Sdrmk1Hmnj8fNlJ3jLm4S5ZRYfXNUGbvlWZAQktOPAjjAUnivrG0kwoyZrxCuSg2vzwbkHnXFlql8HBUOaWKvJiXP0JYh334/c8bnJndBaIiBheQT/KeNZkISIAi+37+wAxXc2Mf2/zhdWCHZtzRug7ABX/sOD59xHv1G/0jTDgMA2p41g8VXMDI0sNXkaZjq/KbDF0LXoSDNwEnASBGTvhvlT7zUjqwCddGfT9dint+BlIh/+pgmmq8hZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KoTjXhLla9W7wd3n8hZZBCIhtadYXXOksAKZJEmtB2g=;
 b=TtEe33RUxe069ts4RfeaMHvnKvLTThQdMfTAtbuPFZHC5iBQoU4jLo8trTp+0NmwDHxXVFMN1Ye1W8buUSzb1/tMjZeUUtEgarnjQtBIe/XKDUjo7C9YdBLXw4sfe2A1Bvf2lvBobWEKO+9ZTGMRSxk5KNsjX9hIvQrrncJriO4=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB3970.namprd10.prod.outlook.com (2603:10b6:a03:1ff::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Fri, 2 Apr
 2021 20:55:59 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%6]) with mapi id 15.20.3999.029; Fri, 2 Apr 2021
 20:55:59 +0000
Subject: Re: [External] [PATCH v3 7/8] hugetlb: make free_huge_page irq safe
To:     Muchun Song <songmuchun@bytedance.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Waiman Long <longman@redhat.com>, Peter Xu <peterx@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Hillf Danton <hdanton@sina.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Will Deacon <will@kernel.org>
References: <20210331034148.112624-1-mike.kravetz@oracle.com>
 <20210331034148.112624-8-mike.kravetz@oracle.com>
 <CAMZfGtUUWD4WkTOXL3D--jfbHYXUuYQsWtiX0k3UD=_x2SC78g@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <b0b081e2-9d78-77ab-684f-a0989a7f1d27@oracle.com>
Date:   Fri, 2 Apr 2021 13:55:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <CAMZfGtUUWD4WkTOXL3D--jfbHYXUuYQsWtiX0k3UD=_x2SC78g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR04CA0335.namprd04.prod.outlook.com
 (2603:10b6:303:8a::10) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR04CA0335.namprd04.prod.outlook.com (2603:10b6:303:8a::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend Transport; Fri, 2 Apr 2021 20:55:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14d2086d-a1b7-45ef-5c6c-08d8f619b7c6
X-MS-TrafficTypeDiagnostic: BY5PR10MB3970:
X-Microsoft-Antispam-PRVS: <BY5PR10MB39708B48DFAE711155440417E27A9@BY5PR10MB3970.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:88;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L+EQuOL5m6dmUG01G14HSKUIC/1prOSjqeOBIV/StfAwIS5F8MMslrEg2wdch5YIyzUw7/fUdQ4YMBMV29+9NiBmAbHVlO5YzwIM+5MWL+21ySzlJyihbXuv4gHvF8FVOm/MG5eIf4yedsyx1puhZJ2/MSN53myiqyYft7/Qr2T0fnL9V4cmU9eqnRkYVLcBLCKjVloQwojg94k2U0gXYtZL6PZ79dX1sk8c20q35dh8WQPjKxDpBnKiS/ozEfpH/XgQUtijBH6cthlroZxao7aCmYoe0y+62spIaBDN52q2O0BzS5kj7r8vE+JbPBUdQvKlBZ7BfSaNgdKXvoOv8Vgw0l+OEbUuTiuq3kCGAROYOgcjoz0zO4ZyflZmXgO/GtI+yas7DtMsJGF/DoFEAi5YJREeZoXEqrvzlYtTIkiy2O4Zg0wO8x39W6D+n+ixHhSAiHsncOnDkqynoEUv5ZEAXkxea4cywB4P6Beh9+oHXIaZo3FQrxby6WMNz+HdAmeK4P6BBcAvY/lrx12n2qXoHyB4Lcavv7v6XlTFqeSlIiDe5SaJZW9jiSJp0uB84kWJwVj+c+f8NZXGt+we+aFHxOVhLNRwneJZs9Yi6Nhv1n8S/Kp0LbUtnFkgD8dQPCxThNnVdHoGP4s371wdp9oB5O5uTPpAnqrGQoSLhkeXVO+Mm/FQf8pqVjM5aaboCi0MM43/ZBkzVV01eBm65QGmqbcTDLxspaJ+GLJXi/baLiyf28gcnFN5ymlaZBLj9Bx3Px6xt+S+sI+5a8vBRhQCHRHGhCMpaLjbtbsmhYtcFXg/H4yRZ/PqT4UYRgG3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(396003)(39860400002)(366004)(346002)(7416002)(478600001)(36756003)(8936002)(110136005)(54906003)(16576012)(2906002)(316002)(66476007)(44832011)(8676002)(5660300002)(66946007)(2616005)(956004)(66556008)(31696002)(52116002)(38100700001)(6666004)(16526019)(186003)(26005)(83380400001)(966005)(86362001)(53546011)(31686004)(4326008)(6486002)(14583001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?YzBYZFhqbEZMNHphVmFSZHpGeXd5N0M2cWVkYjFuczhHeU92ZysrQy9OTlk4?=
 =?utf-8?B?aktBRmp6WWhYTTkremFHZ2RPdmFYT3RQNWJOcmdPdmJXRlJmUGZPNjdEeklI?=
 =?utf-8?B?VWI1K0E5RTF4K2RseFlmcXRNdzg2RWRyZ1lnOUJrdGxKbjg4aXhXb1MwSDJh?=
 =?utf-8?B?bCs1MVRaMldPVFVKc0xkb1U4OFByNVBXMGNCemt2a0JUUENIbk9oemNkU00z?=
 =?utf-8?B?QlBZMnJ1cUFRcjFsUURYOXZEaDZiSnowMlZraUJEK2xERmtLNVBzQm16czRp?=
 =?utf-8?B?WWtYSnVXdzZTcnBiQ2xCc3B5TjZCV3lOVWc3YW40VnB5WlJNbFhVRC9lMUQw?=
 =?utf-8?B?UFVPUmcycUZRSUppNWNrZnNzS2NQVWJKaGE4Mm5UTVNraXhiTlhLM25wRVo2?=
 =?utf-8?B?dDhRS2w5NlBoTXFpWE9pVzhQMlNtM1pROHhQaGJxV2VxMlI2VUE5TnIwd3Jw?=
 =?utf-8?B?cW9hS2ZVTS9CTlFtOFF6QStkRHN0UXhvMHg1bnBCMHNtazUxMHdiSm9CSHhj?=
 =?utf-8?B?TDVSZ2FtdzNPaGVRL2RCazB5NmM3US9qM20yM3Z6V2ozRXVKQjNDdjA0NjRm?=
 =?utf-8?B?Nks2T0dsWU9KZ1dZUWswV0lMM2VsazUvV0drTmV2R1diV3ZnQlJ3S1R3L251?=
 =?utf-8?B?bW0wRFBvMHZSMFJERUNpNnZoV05qSTVzTStEV1NwaTZCS2kzMmM1SEZZL1dN?=
 =?utf-8?B?dzJVMldRQWxjaW0ydkFVMTk0TFUvTkh2ZnhMaE1sWDdsYmUzYzN3NjVyWjFI?=
 =?utf-8?B?Z1BNTm9EMkRPRHI2N2VpTkt6c1N6a3d2OGJoL0JKcFZuV3dVZ0FZU1N0b056?=
 =?utf-8?B?Tkh5OHphUzJOTDN5YmcwRDFMUWNybkt5dnNlNERMVG1aM2VFdm01ZGdhSmJG?=
 =?utf-8?B?Q2w0c041Q2Z0QkdWa0xWNXE4eVpPYTFqOEkzWEkxV3MrSEI4eW9CTE9xMHZ6?=
 =?utf-8?B?SjV4QnQrU1c5VDlSQ0hjTG0vMEtraGd5STIvQzVtejhwZ3VlOENVMnZpc2cw?=
 =?utf-8?B?TmM5TWg1ekdFeEZFMmZXdnFYVW8xeWNaeXNZYThIamJ4LzRPSm1IRmFWK1dx?=
 =?utf-8?B?d0VuUHFhY25oZVloMnArSnJtUFRBdHpUOXZsa1VJWllBZE1QcGxCMWE2Q0c3?=
 =?utf-8?B?Z1V4K0V6VTJxaU1DZnVGMGZiNEczNFgrL2pBWGRHbEdxNjB3aUlCYUdkTWVE?=
 =?utf-8?B?NkxuWVB6cWVVTGpONzdtYTBhdmVxeWxpMHFzcU1xK3FRL2xneFZrTjFvQ0lY?=
 =?utf-8?B?ZjVmQkVHYXBuVjlFeUxUVGx1aCt0YjFDbGgvR2MveStXSGVvcmlBMW13aE13?=
 =?utf-8?B?L1hpeGNYd3RDTStQRzF3cnl1NTl5NmdnUHpkdUtpcDV2NGR6b3diZ1E4SXJR?=
 =?utf-8?B?cWpDbzcvTW4zZEpQOFQxQnFGb0lqcE44clI0T2FOaTdKK3pEbHQ5L2ZYNExL?=
 =?utf-8?B?UE5lRmRXRHVRR0l5c1J1YUUzbjFFM3RjYkRhSXVRNTVvc2l6M3Q0SFM3Q0Y3?=
 =?utf-8?B?UzVlM3FKN01wY2FXcFdnY2NVNnI3Y1dlaUd3V1dBcmsxNEhWKzBxNlZFZWRt?=
 =?utf-8?B?dDA1UG41Vk85MDJBRm9mL0tPT3NvTkpkZUI5L0VkeEVkQ2puZmtoWUVKZnR1?=
 =?utf-8?B?aG5RU1BEMnRPY1NMckdDMXp5U1BKZDRFMExTMVdEa1hic3N3WEYrUGxCaXJ0?=
 =?utf-8?B?M0dKaVlheUNZWVVIRHRQSGhOMjlJejRQenl6WllJNlUxbmxBTUp1ZHl0UU9t?=
 =?utf-8?Q?5MWy9DYc4xjrwJZ2SzXaM0w/V0wXXXCkb98sIGu?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14d2086d-a1b7-45ef-5c6c-08d8f619b7c6
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2021 20:55:59.3399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5/B5tlBdlV+ez1yQuUTuMb9jEfM4NPC8wm4+W/Gu44IkpIXtXpzUdN29Rx8A6+llK4fAPRIfywEgk1ydZGue+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3970
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9942 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104020141
X-Proofpoint-GUID: DpCv6xbf65fFbiaTtbEaMHIodC0VXYSV
X-Proofpoint-ORIG-GUID: DpCv6xbf65fFbiaTtbEaMHIodC0VXYSV
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9942 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 mlxscore=0 spamscore=0
 clxscore=1015 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104020141
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/2/21 5:47 AM, Muchun Song wrote:
> On Wed, Mar 31, 2021 at 11:42 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>
>> Commit c77c0a8ac4c5 ("mm/hugetlb: defer freeing of huge pages if in
>> non-task context") was added to address the issue of free_huge_page
>> being called from irq context.  That commit hands off free_huge_page
>> processing to a workqueue if !in_task.  However, this doesn't cover
>> all the cases as pointed out by 0day bot lockdep report [1].
>>
>> :  Possible interrupt unsafe locking scenario:
>> :
>> :        CPU0                    CPU1
>> :        ----                    ----
>> :   lock(hugetlb_lock);
>> :                                local_irq_disable();
>> :                                lock(slock-AF_INET);
>> :                                lock(hugetlb_lock);
>> :   <Interrupt>
>> :     lock(slock-AF_INET);
>>
>> Shakeel has later explained that this is very likely TCP TX zerocopy
>> from hugetlb pages scenario when the networking code drops a last
>> reference to hugetlb page while having IRQ disabled. Hugetlb freeing
>> path doesn't disable IRQ while holding hugetlb_lock so a lock dependency
>> chain can lead to a deadlock.
>>
>> This commit addresses the issue by doing the following:
>> - Make hugetlb_lock irq safe.  This is mostly a simple process of
>>   changing spin_*lock calls to spin_*lock_irq* calls.
>> - Make subpool lock irq safe in a similar manner.
>> - Revert the !in_task check and workqueue handoff.
>>
>> [1] https://lore.kernel.org/linux-mm/000000000000f1c03b05bc43aadc@google.com/
>>
>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>> Acked-by: Michal Hocko <mhocko@suse.com>
>> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> 
> Hi Mike,
> 
> Today I pulled the newest code (next-20210401). I found that
> alloc_and_dissolve_huge_page is not updated. In this function,
> hugetlb_lock is still non-irq safe. Maybe you or Oscar need
> to fix.
> 
> Thanks.

Thank you Muchun,

Oscar's changes were not in Andrew's tree when I started on this series
and I failed to notice their inclusion.  In addition,
isolate_or_dissolve_huge_page also needs updating as well as a change in
set_max_huge_pages that was omitted while rebasing.

Andrew, the following patch addresses those missing changes.  Ideally,
the changes should be combined/included in this patch.  If you want me
to sent another version of this patch or another series, let me know.

From 450593eb3cea895f499ddc343c22424c552ea502 Mon Sep 17 00:00:00 2001
From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Fri, 2 Apr 2021 13:18:13 -0700
Subject: [PATCH] hugetlb: fix irq locking omissions

The pach "hugetlb: make free_huge_page irq safe" changed spin_*lock
calls to spin_*lock_irq* calls.  However, it missed several places
in the file hugetlb.c.  Add the overlooked changes.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index c22111f3da20..a6bfc6bcbc81 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2284,7 +2284,7 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
 	 */
 	page_ref_dec(new_page);
 retry:
-	spin_lock(&hugetlb_lock);
+	spin_lock_irq(&hugetlb_lock);
 	if (!PageHuge(old_page)) {
 		/*
 		 * Freed from under us. Drop new_page too.
@@ -2297,7 +2297,7 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
 		 * Fail with -EBUSY if not possible.
 		 */
 		update_and_free_page(h, new_page);
-		spin_unlock(&hugetlb_lock);
+		spin_unlock_irq(&hugetlb_lock);
 		if (!isolate_huge_page(old_page, list))
 			ret = -EBUSY;
 		return ret;
@@ -2307,7 +2307,7 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
 		 * freelist yet. Race window is small, so we can succed here if
 		 * we retry.
 		 */
-		spin_unlock(&hugetlb_lock);
+		spin_unlock_irq(&hugetlb_lock);
 		cond_resched();
 		goto retry;
 	} else {
@@ -2323,7 +2323,7 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
 		__enqueue_huge_page(&h->hugepage_freelists[nid], new_page);
 	}
 unlock:
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irq(&hugetlb_lock);
 
 	return ret;
 }
@@ -2339,15 +2339,15 @@ int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list)
 	 * to carefully check the state under the lock.
 	 * Return success when racing as if we dissolved the page ourselves.
 	 */
-	spin_lock(&hugetlb_lock);
+	spin_lock_irq(&hugetlb_lock);
 	if (PageHuge(page)) {
 		head = compound_head(page);
 		h = page_hstate(head);
 	} else {
-		spin_unlock(&hugetlb_lock);
+		spin_unlock_irq(&hugetlb_lock);
 		return 0;
 	}
-	spin_unlock(&hugetlb_lock);
+	spin_unlock_irq(&hugetlb_lock);
 
 	/*
 	 * Fence off gigantic pages as there is a cyclic dependency between
@@ -2737,7 +2737,7 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	 * pages in hstate via the proc/sysfs interfaces.
 	 */
 	mutex_lock(&h->resize_lock);
-	spin_lock(&hugetlb_lock);
+	spin_lock_irq(&hugetlb_lock);
 
 	/*
 	 * Check for a node specific request.
-- 
2.30.2

