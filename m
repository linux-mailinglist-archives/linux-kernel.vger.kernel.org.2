Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB01314739
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 04:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbhBIDvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 22:51:32 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:44042 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbhBIDkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 22:40:51 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1193Z2IF011157;
        Tue, 9 Feb 2021 03:39:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=UaNdj5eW9j2dqEOD/KU+EsJXlsOiY7V0mw7Ahoj7edg=;
 b=B/P9IWRu4MvI/trBI8ErCwS3icAM5mChqH7upDiZWhuux1JJrpPHGzBhgurfEjN8qmM6
 moHmfWKm0eYxTnmfaNjKC6BMjcfiPbxM+UUJqcXNz/PjqBnmjffdGM+Bog1Vvdk5Kchg
 7B3PkSMXxnMIY9VVRcnmsPjR4fRZ1R5kZCULj7UvPWchM7lKttqFxfeFW0i7HOwoGbL2
 7l5a+6IJYcSvUFMF6UZuYiENPO73g+DEq4dpWeuCI13U8o6HdHA49fZPY9iBWmYhT3pC
 xFI85SP4AWYhDM+7wgRKgcC0dczwS2FQi2Wop2z1WO7nJZJme3Ucjo5Uw7qfuWWRplyf BA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 36hjhqp4fj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Feb 2021 03:39:33 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1193Z01E184186;
        Tue, 9 Feb 2021 03:39:33 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by userp3030.oracle.com with ESMTP id 36j51vgh8p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Feb 2021 03:39:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KUvyr2MvYdjvxSMVplDfTtI39BMadBj7s7a58wc4UdAS24kfARV9NWMrvxUoDGCEU/0NvsWMbT+n5iUZcIOCmbN+wldi3FBGF1C6v2kjZt1VooqMFPFjRQITracljUBd65qDx7yNfJUXNFvUSt9iWezFpMgEDHP77xZljWykFPZPTrm9Y0tZCBZAY4AKojPvBFEJruXkhdIfOiAkxDvJCNnpEU76KbNvMMBUWv/uMqAR6oF2wNLFmc8S34DymsvwtsLhlyUzrpgDL6v5AKKBjRohz+kaEtRMXsOJEcX1rtisT1ysU4zdik85azuGmO56lrhgGS+42E+rxklnSYB7pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UaNdj5eW9j2dqEOD/KU+EsJXlsOiY7V0mw7Ahoj7edg=;
 b=ZtIuXjDXw4ISFrbo2KNwY1XyT5vXZur7AiriaVs/rcXYoQh8baunl8LTz3QgyCwtZMX3881xK6uUKqu6jv/NWvG6my6yLhi1yDxVp7i88IlbIrRsgwyQumfnNlBIucj6rMq9QHhppTCYanGjw8W186yQ/fTJ4hiU7BE5tKuSgs6rVWnADUCzjQwRObTVGjV/eLyDnt+oJPDgl8h8Xo1h9KXnNQbqyOrkarXH+6LDPp1lgRCQJdFPdVKOyGItkkiAwj1uPSQzPrCdJpuFik3tSFt0ntCdn5vZ4OYAx+VhAfUs06LOStienFeuzWJyj3VidNiigVJP83g+NZbwmb54uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UaNdj5eW9j2dqEOD/KU+EsJXlsOiY7V0mw7Ahoj7edg=;
 b=APwGINUrk1OtMxh01pJgSUvk1CZGpJHhVJZsdfmlbVlKMniSiNuKXAGGXD1EVJFFj66Z3JOdPIpW3xZbZvH0t1/4ONvUsOQAFJoKM+hjaU/oZdTeXv2rMysFHjAp+r7x74QcMcWUjoW/23GVcPWnpOVjlp16bMa1nldxFIN4cLY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by MWHPR1001MB2286.namprd10.prod.outlook.com (2603:10b6:301:2d::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.23; Tue, 9 Feb
 2021 03:39:30 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3825.030; Tue, 9 Feb 2021
 03:39:30 +0000
Subject: Re: [PATCH] mm/hugetlb: Remove redundant VM_BUG_ON_PAGE on
 putback_active_hugepage()
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210208083739.33178-1-linmiaohe@huawei.com>
 <7e1cdef7-e3cd-79c1-c30c-5f5e9e9f85ac@oracle.com>
 <a5a09912-72ab-f494-0f29-5e3b7fb7c5a4@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <90572a26-a55c-10d1-3c7e-bcdea1f32fe2@oracle.com>
Date:   Mon, 8 Feb 2021 19:39:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <a5a09912-72ab-f494-0f29-5e3b7fb7c5a4@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: CO2PR05CA0108.namprd05.prod.outlook.com
 (2603:10b6:104:1::34) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by CO2PR05CA0108.namprd05.prod.outlook.com (2603:10b6:104:1::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.11 via Frontend Transport; Tue, 9 Feb 2021 03:39:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5f9e8fe-8f27-4b77-563d-08d8ccac4ef5
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2286:
X-Microsoft-Antispam-PRVS: <MWHPR1001MB22868972E727B203DF04AE9AE28E9@MWHPR1001MB2286.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:288;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7i0NywLb7bLBujxxCDrVYJn4U2WiShylLclilVRTcwLqRUd03RsZ5WitBIg4jKTF/J0mxX8D2vdr4Zx+JAU8dT00bDeJn54y27InYEc6T9qP8pYaMm7PJevrYokjS0WyMPYYdvAmF7ZsfWHgRCjFMVIlltW3EJmEJIs9MUxAfLLxNfoq7csljcRMIMXP2s83r5sx7/sZI+nokueoch6dK4qSaeJhgq4uyyeXFLLtk+Bo//LN9zpyciDHAjXs2KQKoFxalOCyyfmjk3A2cGF/eNgbAN6xkYjWTPEAnsfo6GvU7ZfWDfqJyBxH1sshFXa3P7FAO6oGEWzqNQtdaa9xbqs/M15WxOjDpWthO6eWrFc1Xs1B9JhDIKCYf1z+LIOlanxLd4hMxk0MzKZXNGZZe21lbzcLEoTv47so6ELnCtJsDoogmcSAANzCnVJ81u5jLyaIEu8zJUbzoQCjluXNAfHGvKpfZnr2IO7o22siuBf6DkNv3eXhJ5uu03sgpU39/82KFvLThM9mC0pI5a+SMJLv6hSsy7gM9F2AZXalulYjsoQ4iLm4aFIosQPBR1MAb97XuGTPjVal5XTfWSEIFtu11arConfov3UsgvEjG1g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(39860400002)(366004)(136003)(346002)(66556008)(66476007)(6486002)(44832011)(2616005)(52116002)(66946007)(4326008)(8936002)(316002)(2906002)(956004)(186003)(36756003)(26005)(83380400001)(16576012)(86362001)(5660300002)(31686004)(31696002)(478600001)(53546011)(4744005)(8676002)(16526019)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bGdiMUNWZEN3Rjd6ZXRSaXhCY2FpRXBwU2I5Vk9YNC9lNmZlY0FWa09KdWFZ?=
 =?utf-8?B?S3M2azgydm04a21YQWlZV3VqcG9pUEkwQy9rL29hVlR6N05NaXlnOFFhcUNN?=
 =?utf-8?B?U1ExWGUvMytyU0h6bkhFa0MyVnJzVTUyUys3VWhQSmJUM2hTWm1UVlo1Y1hY?=
 =?utf-8?B?Z1hsTkl6SWdsSnh5WkZBYWl6N2YrcGcxMnM5TWl1c3VudWFPY01KcTRWOElz?=
 =?utf-8?B?VlZpcS9iVzkrakh4UVJVb0ExSGNqUThXcDRuYjRGUzVvb2pmZGdkMDBKdjhr?=
 =?utf-8?B?OXBBaDFmRElQM1JCVVdZV0h5aVZaYmdRRGFJNTVUTzExU09vdDlPRkNRWjcz?=
 =?utf-8?B?YXFJVnBJNTVtR3d5ZFd1OW9zVlF0ZkZTeXk2ZHNHb3dYSHgyTnFGQ0srVkhW?=
 =?utf-8?B?SjRkVzNrd285czdRZUl4ZzQzS2t5L3BwZitxSURmY1JMM2dxRzVtYm5tV3NY?=
 =?utf-8?B?WWdlSmxwNWNhNEdXZWxjOXI3ZW54Z0ZUa0h0RUswL1RjcmV4QkxuVndCSWQ3?=
 =?utf-8?B?SzFIQ0FpY2RqaDNITHNpZWUzWEZ6RWpkOWlhc29YbE0zTzkvVEVyMjBhdnRj?=
 =?utf-8?B?RGdrcHpsc0w3cVhTSGI3U2JpSkMwSXpwWmZ2TmoxdWhPb0UxYzdSbGY5Q3Ev?=
 =?utf-8?B?N2p1d2JHM29YQWNaUkd4UnpyTzhDb3JSSklhODU4YUpWb3pYNjZXUDB0eDlT?=
 =?utf-8?B?ZkwrWUhPSHJOSWZXVWtyNTJhN2ppSlpHNHhQUFYzMG4rQzdlYVhnOUVvQ295?=
 =?utf-8?B?M29OVzVkbmkrMEtsUU8zUHBVTElvT01hTnRYR2FzazVaTndLamhPajM0SWNw?=
 =?utf-8?B?U0tBQmJ6ZUZ3enlxYi9oMHRueW9DUk1JbGtKUjFlakJHUk52M0JZSktxMFBG?=
 =?utf-8?B?N3hxVVZmZWJXNTZwejhNR2lqRWR3dDBsRlgxSlR0TlRvWWVMdmQzdHVrQzM2?=
 =?utf-8?B?KzRCa1ZMRWdBanNicXgyQWtrcUVLM0VDN0IvMjBzT240UzhXbS92aTIvdU44?=
 =?utf-8?B?TU1XemNpeDdYQjRiQVV3MzZuejhFZ2xpd0pZeDFob3BLM3dNdVRjWnUybGtS?=
 =?utf-8?B?Y0IxUG9INi9iWmJDK3pkNUFpZTI0cld4UkJvR3ZEZnVsUndndEt1RjdzRk5o?=
 =?utf-8?B?VStNOHZVZnEvSlE5eDlvVU9PM3pWYmRBc3lVQ0FoTExrNlIyMzVOSEw3OHQw?=
 =?utf-8?B?cVI2ZUZxU0U1VHZOVTkwWVVORGtBNWs2ajlFVzFzc00xUWppNlBvQU1pQUNR?=
 =?utf-8?B?L0xjSWFINlVXOGdPeHNjRDhTTkg0SGdxVE1YK09mUW5NWEl1T1huWmYzZmdU?=
 =?utf-8?B?RVZ2cFh1d1VmNldKRkpQQnQyMWp5ci8zZDlFS2tKT0V2UHBTSDljaHc1WVlN?=
 =?utf-8?B?WTRPa1RRbzY0aUFjTEJHMzZFNVZJQW1ZZHc1MTBwVXNaSURSMFRETU90OHRH?=
 =?utf-8?B?U1NmbkJrZjhiTC8wVVAwbldURUFIMHYxYkI3bWg2NkdKcmRLMnR2a0FxODhH?=
 =?utf-8?B?Qnl1c2lOd3crRWhYUEFqeWlDOWNYY2lUOEllMC8rYkdnUmxVYVozMDVReW5x?=
 =?utf-8?B?SmRTRm1sSWpwbkdXQTcxT2dhZHhibmNnTUk0U2dabGRTWTljWVI1QVdXZjkv?=
 =?utf-8?B?Qmd6T0NKNnEvUUllVUV3NzhPRHBLY2pKcmVjdmRyYzI3Q2NoVy8wUEYreEZ2?=
 =?utf-8?B?M05wR09KQjR3MU5YS3ZSYjF5YUVvcjU0VXdUa1pRZG4rNEtPUEcxcFJjWnVp?=
 =?utf-8?Q?YE5T8QfABI87pBRUkl4FdcL3OEzDsyEeRpw0xiK?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f9e8fe-8f27-4b77-563d-08d8ccac4ef5
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2021 03:39:30.6496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qoKxtk/luAh5yhC+4b+2lz0bkiLUvcJ0GIzJZjN0j9N47C9pxO8lLXZpgrNPOv6tCTk4/GEOPFmQ2FLSu/3Fqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2286
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9889 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=982 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102090004
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9889 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102090004
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/21 6:10 PM, Miaohe Lin wrote:
> Hi:
> On 2021/2/9 9:26, Mike Kravetz wrote:
>> On 2/8/21 12:37 AM, Miaohe Lin wrote:
>>> PageHead(page) is implicitly checked in set_page_huge_active() via the
>>> PageHeadHuge(page) check. So remove this explicit one.
>>
>> I do not disagree with the code change.  However, this commit message
>> is not accurate.  set_page_huge_active() no longer exists in the tree
>> you are changing.  It was replaced with SetHPageMigratable.  Also, the
>> VM_BUG_ON_PAGE(!PageHeadHuge(page), page) was removed in the process.
>> So, there is no redundant check.
>>
>> However, a quick audit of calling code reveals that all callers know they
>> are operating on a hugetlb head page.
>>
> 
> So I should change the commit log like:
> 
> 	All callers know they are operating on a hugetlb head page. So this VM_BUG_ON_PAGE
> 	can't catch anything useful.
> 
> and send a v2. Right?

Correct,
-- 
Mike Kravetz
