Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79A1033A162
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 22:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234744AbhCMVR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 16:17:56 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:55054 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234299AbhCMVRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 16:17:35 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12DLGxHo068048;
        Sat, 13 Mar 2021 21:17:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=6SdMLb1VmdPTle5M6FlXq6RK6Wv3Ww3uoj7L+fefAwM=;
 b=Cq+T71qomYpJYpuLeeFLDEsT62XDPvjuJQAUSl6h7S/wrmgB7R5prpostAj64xD8dG17
 Ea8whUzHshx/7O54uInCiWcBkISG58naEANbtS89qziXrvori7gCQoA2m7DUBbzcLKsb
 xKFeYvR87ZVDLy7s9HEWXQaYtcDo+/KfIjdg5T132X1sdZEfac9gvZ3CU/Iew1ZxPyX8
 pqN/TWxz0MmCg1aM8kpz3LsgZ9lVbBsXzlaUL/9FyzK8HqtpBdesnt61nrGSuuM2Jchi
 hGZhvldZZViya38dL+1xBOVnFl86d6VXq+0B1jFFJPQMKBMM+JLkf/mGLg3drqdpJLz9 wA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 378p1ngx2j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 13 Mar 2021 21:17:26 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12DL9bom009910;
        Sat, 13 Mar 2021 21:17:26 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by userp3030.oracle.com with ESMTP id 378jgug4mx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 13 Mar 2021 21:17:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dVGEK7BTPIY8BNgvSTwRHOpL80TM3s7mKcPXgovZO7K+eoZIVAGBWdfhnp966eQv+X009hqj8vy0ufwwiK8YLBCF5RS+d9DE02WrMqoHpg7aiaMncIDBLMFzlORMhJN6Fu/1qb0mdhaw/rwnSQI8FLYmJpr3cCqClTEfBskva66my1G6RRGUlZfTQ5nq9v9EYAFBcqu/WUs6/2A0s1nxM7OkM27pZsubGR2J05aTikDW6UOr05EMf7BOb8Ld/AeA4bZDW2w3E+7g07icPml9ilDddn0Kbb51Ebo3nrfhlVjBZLDb558LW3Mds+cyaF9Tq65ZF+il/w/UBLfq6G4euA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6SdMLb1VmdPTle5M6FlXq6RK6Wv3Ww3uoj7L+fefAwM=;
 b=EiNIhW+3oOIGPsBi+/GYSgOfs6jXQ6C1JgmmXhZ55xloCs1w/hE3J6uZIkzzUUt6SZe0pIGoD8CB6gTlVzF8ANOspcmtmS0zifjPDTKbfs+DT9Rwo0Iww04Yk/tyeVvtm5tN13ab0gct4DJLQiZtXtwZmFW9Bdy1D25mGGXev5S6jYo0L9MyzGo4y+CtRxnwRxuzudYKbbhSFMdgWPiS4/qYzUfyRHXR0CJlH6Xwojc1d3C7VtvD561+AhWX0ABsdyucBpGvznIkT4ADElZVGG5Wi8pG/V5H9C46/L7IxPF7GDOcB2UVpQnKmNipVjZIQUhoQ5GxdqoyJPM1ur+i4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6SdMLb1VmdPTle5M6FlXq6RK6Wv3Ww3uoj7L+fefAwM=;
 b=uEyQQOeE6GqDav5LiACl4iwuME/062n4AkRHFKBLln87YNnRBfgOkWb5tunCJI3WcondCIKp0mx5iuGLEu2EQOiUKbdAlO9goQz5+ciBqiK3K3uBlnmdwmFDgDWKTJDzxuOAukrF4JTlshn5y7nOTs6j+GSWleln5ztBFj44bvY=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4323.namprd10.prod.outlook.com (2603:10b6:a03:211::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Sat, 13 Mar
 2021 21:17:24 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%8]) with mapi id 15.20.3933.031; Sat, 13 Mar 2021
 21:17:24 +0000
Subject: Re: [PATCH 5/5] mm/hugetlb: avoid calculating fault_mutex_hash in
 truncate_op case
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20210308112809.26107-1-linmiaohe@huawei.com>
 <20210308112809.26107-6-linmiaohe@huawei.com>
 <2baf9a1b-1c69-8168-cfd9-5b5ad45a4cc8@oracle.com>
 <d40df812-7b02-78fd-65d4-41bbcc9d4c6d@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <9f385943-4038-f457-c742-30982b8b7d5d@oracle.com>
Date:   Sat, 13 Mar 2021 13:17:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <d40df812-7b02-78fd-65d4-41bbcc9d4c6d@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: CO2PR04CA0182.namprd04.prod.outlook.com
 (2603:10b6:104:5::12) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by CO2PR04CA0182.namprd04.prod.outlook.com (2603:10b6:104:5::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32 via Frontend Transport; Sat, 13 Mar 2021 21:17:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d65b57ed-96d8-40d8-724e-08d8e6656589
X-MS-TrafficTypeDiagnostic: BY5PR10MB4323:
X-Microsoft-Antispam-PRVS: <BY5PR10MB43232A00896C7630E74FC52DE26E9@BY5PR10MB4323.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5eBNMQNn3i3TBynNmNb1hN/mSJR4Hy567TQAxV5O+pBnpx74XCrePPabygU5CZybXdFuyhE2E+jAZL+z3Dwt4RqrocQ51dFRoHtk/8RnHzWvtoCZafVbhjT3o7ZYAB64PwcwXhBJVF+AOsNv1jl2kFQgFqutn2BYqYh06zYhCPAJKWY/UkUqJS7pAGcZ0GKgYRRiU64RevTVQANp1bXXaOa8jxoWpFQ7k8CaNGHylNyPn8eoA//JOksfVMO0G4gx9l5NUvmexIuVftNbgfBIA118Ipvdw+6vOP4OxQEXrVV62GnMAfYRXicOr0vGDzlSTUc8HA12KKDDbJru8SEj2sNfogA734pNKMdP+yG+8KxMYfUhn26F8kxyrkteBmD9gnnZPAypxHkWUlDa10Fpbc3tN3Z2aBUJv+FJDuPIHnjrO8cb4SuDdGT6Dk2lyj14QMFx+YsuTxCwWpBLeqW2c0MoytGEnKScgC24zCmrr05eKELxKHjK8QbiM54Ky+/NmRA3rYoqVcqkPohjbuYDH53AAuKSr5TcOdvLzkOtH2UL60ZnxBVlwHz10g4n3+CpW1/kL/hJApIhMVs8umji7Ifdnc+D7tVI/Vj9jh9KCDcYnmRwb5mXp1XoDA/hJ22Sor6q5YJE0yhEQ4NlU8buTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(136003)(346002)(376002)(366004)(66476007)(66946007)(44832011)(16576012)(66556008)(83380400001)(53546011)(5660300002)(8936002)(4326008)(52116002)(956004)(8676002)(2906002)(2616005)(6486002)(31686004)(186003)(36756003)(16526019)(478600001)(86362001)(26005)(31696002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SGM3NThDYkJ0b3pSSi85Z2UrdldvRkI4NUxaSFdYSVJuMHJ5YjdESzR6Z2J2?=
 =?utf-8?B?UG5KTzFjLzI2OVpYZDlock50WUxLelhqM1RyeXVMdStONjJIcVVjQU9OK01J?=
 =?utf-8?B?VlA4eWdmdWFDc0h4Qk9ySGp2UkRnOHlKQVJEc2VZZ0VKYnJWeEtJampQSFVx?=
 =?utf-8?B?OURhM3orVTA5bUw3bmFKUHVKblA3VGhncjBEcGVmNVJhYWpSWExBOVVLSDZL?=
 =?utf-8?B?aDJGTWZ1UlR1emxUWDB5NDBRcEZ0ZWVBNzN1cVNDSmVqaHJiNWJ6WCthTUE3?=
 =?utf-8?B?WVNTcTlLc1g4T3hKSDhRd1FQWTR1TFhIVE1BWVRnRlFhUkd2UlNCcUlWdjFq?=
 =?utf-8?B?NHZzWnU5TmU3NjZDdFczMkl1RHU1NW15eE9ZcFZzYVQvYThudjNTUTJvblpM?=
 =?utf-8?B?TXFZaTdCK2E3d29ONGdjS1Y3TGpUOXY0VWdDTFRHLzJQNUt0UTZVRTZpWGxZ?=
 =?utf-8?B?T2xyekgrK2xRR2VGTFFVekdUZGIydXNJWlFqMkRackFBbDNwbHByN3BzQ2R1?=
 =?utf-8?B?bGpFVGloSzZyME9EVk9WTVlqeWhwN3hoWG5ZS29LQjJFQWRuZkgvVXo5ck1j?=
 =?utf-8?B?Y3BRRDgrVHF5T2t3TW13SWhPR2Y1NzE0RUJqNS8wZU1QdGJJQzRDdWYzamhs?=
 =?utf-8?B?b2p3bVBqMlFCcE5vUzRzR3dUUUE3ZjJkZUo4Uy9CbDhEM2RwUTJVZm1qd1BU?=
 =?utf-8?B?THpjcG0wRkh0VzlZbWFDenMyem1Td1p2Uk1XNWlJenBGWmtoVkcwVzlLTXBU?=
 =?utf-8?B?dTVGQ3VlcWdpVUJIMzBjQ3pWbEhSSEQ3SkNmYjE2NEc1aDZ5dSs0c1hSbENs?=
 =?utf-8?B?SU9IS0hIMHhkOU9hWjBzSU52Q0pVQTdFazB2NnUva0dGRWlBUDNpaFZpSVRj?=
 =?utf-8?B?S3BrSWM3LzJuL1U5bVNWTDFNNXNQTkJHcHlnWERhRk9hU2ZHSi94Q0xqQjQ5?=
 =?utf-8?B?MEliNXpEcEUwNHNESi96Y1lYUEVLWktvOVdkeXBsRjd1azdBMWVGSGdNMlRo?=
 =?utf-8?B?WEpucDdZaWtOTXpDQ2hlTkwrM1plY1RoY29vdEpOYXMzMFRsSFYvYjU1c3F6?=
 =?utf-8?B?QWtiT0FsZEtUYmdQaDhvSUNHZjVZUmF4Y2pFVUtWbWpzczZma2o4UVRoS1pm?=
 =?utf-8?B?OGZLTHY4TlR3WVJlSnFkdFplTlkvdGZ4cVFHaXhMVkxEQjFmQUo4cE1NeXAx?=
 =?utf-8?B?SXVGdXgzRTZ6VGV2NFNxNHAxSUdWWmpKMXVVZ01GdDZOT2VuMkxOVHl4Nmhz?=
 =?utf-8?B?bnlsTGZ2R1pndmUzalZkWmNULzRDZVhWbUJQQVhCUXNyRE93QlFNYTJmLzA2?=
 =?utf-8?B?T1U3LzM5QTZtcHBaU0ZCbVkrQVFHMEloZ283czNMemxhbElpTnU2ZGJxVDRy?=
 =?utf-8?B?UUt2R0p6RzIwNWp2VVlrY1BtLzdYUzhsKyt6UTVZNE1MUm5jRXc0K2w5NzdL?=
 =?utf-8?B?UXJ6d3VIa1F5cE9uWWxTWGJBRjl2Wk9Yb3BtL25zOUVkODQ1NTFHTUwyanlk?=
 =?utf-8?B?dzU0VEJQZEh6TjhFamdKYTRkcFY4a1F0eW9jcFluZzNYRWUyQ2NMM0hoRDRB?=
 =?utf-8?B?L2o1TVR5bmswWVFCVENLRlo0M3hSc29ueWtiVlZ2ZURZaVBueng2NndsV0I1?=
 =?utf-8?B?NVNIRnRoUmhaZHozemFIVjRCaXBjT1lXSWQ4Q29ESXdCemhhQmN4NE1oTXF5?=
 =?utf-8?B?ZldBbXdzblgvcmlFMmdJdG1MNTBUc1JtYjN5bGY5S25zcXpwaENhSmd1b1ZP?=
 =?utf-8?Q?MlOLnUW4ZqSVjbiqvYukOXICkeBZVP7nTgiysw6?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d65b57ed-96d8-40d8-724e-08d8e6656589
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2021 21:17:24.3622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: klSmw0ad9TyRYMCkxuhNER4X5OfmxAqXJ3YXQb40rAKyjDDitbKJ8t2cl7ix2VcfSHA7ClPgiSuVtSFEpGCUzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4323
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9922 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103130166
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9922 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 adultscore=0
 spamscore=0 clxscore=1015 phishscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103130166
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/12/21 6:49 PM, Miaohe Lin wrote:
> Hi:
> On 2021/3/13 4:03, Mike Kravetz wrote:
>> On 3/8/21 3:28 AM, Miaohe Lin wrote:
>>> The fault_mutex hashing overhead can be avoided in truncate_op case because
>>> page faults can not race with truncation in this routine. So calculate hash
>>> for fault_mutex only in !truncate_op case to save some cpu cycles.
>>>
>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>> ---
>>>  fs/hugetlbfs/inode.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
>>> index c262566f7c5d..d81f52b87bd7 100644
>>> --- a/fs/hugetlbfs/inode.c
>>> +++ b/fs/hugetlbfs/inode.c
>>> @@ -482,10 +482,9 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
>>>  
>>>  		for (i = 0; i < pagevec_count(&pvec); ++i) {
>>>  			struct page *page = pvec.pages[i];
>>> -			u32 hash;
>>> +			u32 hash = 0;
>>
>> Do we need to initialize hash here?
>> I would not bring this up normally, but the purpose of the patch is to save
>> cpu cycles.
> 
> The hash is initialized here in order to avoid false positive
> "uninitialized local variable used" warning. Or this is indeed unnecessary?
> 

Of course.  In this case we know more about usage then the compiler.
You can add:

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
