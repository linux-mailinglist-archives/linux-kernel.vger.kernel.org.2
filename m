Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3E473722E1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 00:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbhECWLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 18:11:09 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34880 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhECWLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 18:11:08 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 143M0JRT098134;
        Mon, 3 May 2021 22:10:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=BeIg+igJFY4nLnkEU6cMY9r9piRcAPjmwByD9s4eP2c=;
 b=ZNm0kUDlYDmKPWRBJfYtIMe1LZNLlXhn6EiNqMRFq2kbdWFmRMLIr7zufZ4WHorJMq82
 BIo09HJ5UGppbXkZ2o/hxXfSaR5nEpIwk81Uux4DHLfblQQQwokvASPQg1b3F4MeyMWe
 eH9EPkLrKqAC3c7WyshuvwgxsdKFt0KQ+BLnLBMVF1HBHtEtCMcxzWkA1JWkxMqU8rmF
 FHqz2rWmrHrJOnvExB72BdexxGJJ6z8+iS/7KwJ5BN/+skogp3AypqZn1P9ag7XAUEn1
 gJq7G3kXDEgyZZfn1H3Ic9kPjDdmC5cyk3/NmUzEJsM8YWTYtw/D+Prh7pB303YH2z/j /g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 389h13v1vc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 May 2021 22:10:08 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 143M0E3B126333;
        Mon, 3 May 2021 22:10:08 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by aserp3020.oracle.com with ESMTP id 388xt31xx2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 May 2021 22:10:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PgTEfQpG/iB79Cd+7uHdlRhDnx3jtOuNWEVs2RV0HovlP2jf9PHrSUvp+oeCyf3Ejr6Y1dBxgd3IF7Swki+hopr5Y32oIScKcq9/nNiOK9eKhFZrz2Y56maMvanuacokyrcwL0n5PZvAS5ThV3YFTlPNnnwseRYgkJxt2Oa5ChqG5PEIAFCXAjAf4vAMgarRB1WVhI8AJGss+ZwV7qapAJH9JENiJmynvSN94DJ12ytSrcxgKWSAc+L7PojKvvdqwzcxXzFpIvzwAXW19ZlRCM7M6psYbeFLuLu8ks2RpcrTDkiK1cTCXmvKdVlhyLBrYmo24+MW9PYjI2qGBYV0Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BeIg+igJFY4nLnkEU6cMY9r9piRcAPjmwByD9s4eP2c=;
 b=XGUqiJXboiDyMD1JptnnubnA/BE6Lz8kV5FNZq9cpk882inYWSJsyhZBIDfLleSbU5o4eDMTdQs6xSd9/6ej/OwhiUUieo6RaYOUc2W8P+msAU2sv/KQ2XVNJK7jDF/700A/fQ8f5o4Af+h5/pxjd+SouyIbRPXHcEjAdgtLtYtcYAlR5njsoNVli2MOwMNjeqb2DXYWj7TC/op1yzROpOnnosWLKqayoJQx3du0m9iYPdkcykFxA8TbaqjVb5GfzIwwr3LMJ3AdGDDfrTtJXCbWYtoqkN3lEYPU0a9GpqgBWD0N9WZ1GHFWxYEkDGWSw1P2GWDenuz0B5Ao1vYSBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BeIg+igJFY4nLnkEU6cMY9r9piRcAPjmwByD9s4eP2c=;
 b=NWTrLl3UMLpMk77CvLQuuFoa6CgwVJoaAB0rNF6/M8dCB3WA9lOP6yKz52ZKXEM3CRJuRDH81PSjLw9sWIc2tzYVe99xIbN9VE0hoiKoPq/koASsELnIwWiBeqT5fNXu6Zw8Xev5nMUjXxO+Zj3lQVuu8y5Vasrtz1W8XOa9NaA=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2952.namprd10.prod.outlook.com (2603:10b6:a03:89::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.40; Mon, 3 May
 2021 22:10:06 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90%8]) with mapi id 15.20.4087.043; Mon, 3 May 2021
 22:10:06 +0000
Subject: Re: [PATCH 2/2] mm/hugetlb: Fix cow where page writtable in child
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>
References: <20210501144110.8784-1-peterx@redhat.com>
 <20210501144110.8784-3-peterx@redhat.com>
 <c69c12d6-1615-e528-37a7-4776abfc7200@oracle.com> <YJBt+61zIh9wOCaq@t490s>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <ba559981-326c-3c96-3885-fe2826f8d34e@oracle.com>
Date:   Mon, 3 May 2021 15:10:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <YJBt+61zIh9wOCaq@t490s>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR17CA0056.namprd17.prod.outlook.com
 (2603:10b6:300:93::18) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR17CA0056.namprd17.prod.outlook.com (2603:10b6:300:93::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend Transport; Mon, 3 May 2021 22:10:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f37c39b9-6ffe-4d64-8502-08d90e80351c
X-MS-TrafficTypeDiagnostic: BYAPR10MB2952:
X-Microsoft-Antispam-PRVS: <BYAPR10MB2952BDDC3DB52273ADB2DA92E25B9@BYAPR10MB2952.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C3eQF4uUQiO8eKmiK8E4cL3thKeJp8PKOi+ekSOm+1IY4E0jK4UOSSkKx9M1vWFpPXaBWnSfBTOzsMK3/b3WLL06N7JCGSUM9lyre60pvnm5NYqq20ZflX5PtkAKyxD+meNadsqp3w07QnzLRA7nusgtvfIQY5YQxEKwtfNYOqT24mpqxy58PzH/u5Nah7Gd6MkloWw+coKe/m+P129mt66RDbFMy4a105V8MQZHc+h1+eZT+yAvqMs9iZUro0aQPhCmeYOFX4x9fk4aI9OJJ06KyXmCAa1qQ/xOlNQejoL9W2l9s6DQT1UTYsrkTjMn15AtehWlAffgxECWVWwgG6G132U9w9EAtUNaMRqu148THx1QGyFUvlJ7Jq7gpUKcUy7l1v7JM8e8PYFLQ4KhFaBgJ+0fuXsu7zJ6yWOgNMsh2WH2i8o/O0gZkJ6r+ATp5mb0x87jOGg4JJbOnQRzve6JR0zJxPfEoZunr9MVu9LKqMPfikicWZsrdNxIbUXljgxSIUJmFd6ZAL5gO0ybWlLQjhz36Yj8waOssJ/zamg+q/lkheg7OWyLDGxW0gCifOSIIvzyPT+EO3Nmcd8DI2bV1YiU0gNIBYovzz2Gp2oWYBsTnJHHKeokDmjuqWEp+kbTOoQe6soMd75/gVmm8XBK64DT81zBh+gSDwm/x7VQu4z23YtbKMS5TcDHhsXXJWTC4LW6dsihqDjoHNsiaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(136003)(366004)(376002)(346002)(16526019)(36756003)(5660300002)(6486002)(38350700002)(8936002)(38100700002)(54906003)(316002)(66476007)(478600001)(52116002)(8676002)(31686004)(66946007)(186003)(16576012)(6916009)(2616005)(26005)(956004)(44832011)(2906002)(53546011)(86362001)(31696002)(66556008)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?M2liWi9JdFhvZ1pOcG5WR0RYYjZrcUVlZzZBYURBYklWc2FkeDFodDJlYUVD?=
 =?utf-8?B?akE4ZHlVY2hqcTBzVFE2eTFnMm1vOFdsQ3ZteGxiQ3VsZVE4Mm9XMmZqaytt?=
 =?utf-8?B?UWNJbDF1UndNd0xxYjVJaC8yR1NCa1FqVFllNmZpc2c1dWhaZU5XY1FZbVRu?=
 =?utf-8?B?cTNKZzE2MUxrSFYrQlZ0Nkh4eE4wUHlJSSt4Y1cyS3Rqc3hoNVBqcDY1RlA2?=
 =?utf-8?B?UHlOQ0loTXVRUXkxNDVMbnUwWklzU0V2cG9XUE9JRVoyQ3BVaGsvK1FNU2ta?=
 =?utf-8?B?aHZzbU1TK05IOUEzbXFNT1ZDbGVrNDdoUk5nTDJJOVNzZG0xaEVpNzlWeGla?=
 =?utf-8?B?K2U0eG1yMkdTQTBlaGIvOHRTWlMrWHFNU2RIWTRvL3dXVE53ckZpOHhBd1JY?=
 =?utf-8?B?cVNQY3NSMDBPZjVGU2xpd3FaZ1IzWUxwb21ENEplblQ4VkVTZWs3ck42RURO?=
 =?utf-8?B?SENkTm0wSUhIUld1UWVhV3AzWnRQNVdaWithd3RGc2xVYmdPUG5PZ25GQWRq?=
 =?utf-8?B?S3pTWHhSc28ySjdiWjVUYVJZWmhSeDRZdElRbmZRdXhPbHhmdThpUVVUd0Zy?=
 =?utf-8?B?VThDMmQxUnlhbzI1QW4wVCtuN2xFK0p0V1JwVTIyYWh3L0RZUjZRWGJ6Z3pu?=
 =?utf-8?B?SkE4UndHcDk5SmYyNTdxRFRuUkFjZGVDeElERExOK0tMWDFmK2xJeXBIOTJY?=
 =?utf-8?B?clViTUFRWWgycFQ3VnAwVThZMTA1SGtXWG5OYXEzNmVpbGZ3M0JHcURaeHpK?=
 =?utf-8?B?aGlMSmJXQUtGbjFtL1p4TWE5aEExL1B3NUVwbTBwbkZlSVg5K29UQVVUaUVs?=
 =?utf-8?B?UGhMSlFNb3V3dnZBSGlpeXNob3pzSDFYUHJuU1g3Y2JyNkoxZXF1Z2ZqU1Zm?=
 =?utf-8?B?eUM2aFJPNUxoenlYNWJRL29CaWJ0V2pLa2Jjb1ZFRzlGUXVncEFWQ1ZtcDVK?=
 =?utf-8?B?QW9JcFRhRDdUVkNyQUd4YjIzYjg2eHFrT3hIREMydUM2aGJHenVZUnhEejF5?=
 =?utf-8?B?WHVySTVqYmN2QUtKTFk0MjVFRkdIN3d2KzZSV3ZEUlFDWGFFeVFvVVUzMVoz?=
 =?utf-8?B?QmtXK2ZFZzZTUmNGbkYwYmpyWGpnWHBUQXBld0dBRFYrRzVpZi9YdHFab09O?=
 =?utf-8?B?MGx0dTduRHJFamhtS2tZZHNZR0JDL093dXI4NXg0QzRCYk4xZ2lrdjNTVTdw?=
 =?utf-8?B?UlBKSlVLSTA4WFl0OUpUVUVua2c5eUFQaXBwamZ0NmN1M1RlWUw1dTh2ZmRK?=
 =?utf-8?B?NjhRWFhwNnMxRHJjdWx5NFF1VldSc3FORWhma0t5SnZaOUtsNzFmdXpTdUxT?=
 =?utf-8?B?L2lCSlZ4R21kRVZnVm5hQ3V1ZVFnUkRscFFqR0ZWclBnckN6ZjlsTkNHanRD?=
 =?utf-8?B?YnpKeHZRZkFTNVl6aXp2TXo5c2ZIdGNlejhYU1MxWXVKV21YaG0rVkVDN05Q?=
 =?utf-8?B?VThxTXZLdFBHRDdSem9hNTZqL1RFdW5MVXFuaEE1ZDFvaU1MRllYZEU3NUhx?=
 =?utf-8?B?OWMrZmN5YkJtRmY5TlF0d0JKZjFuOW1pQ3AxOTBKRW1XanV0NHB5dU91QnZy?=
 =?utf-8?B?U09XMlZhOXFjQUc4Y2tqZDR2OXRPWkpvak9sT3dDTlorVUs5aEFBeFRZUlZQ?=
 =?utf-8?B?RlpOVjNTdGR1QnJBeEVyWm1xMllERFBzOXp4QWlRK0dYWFhxeW9PbGRDNm1k?=
 =?utf-8?B?cG5IWk43Lzg2d2dFTldFVEZTVkZkTGZNcDRXb012ZTlkUG5weGNYUVQzV2tk?=
 =?utf-8?Q?G7Icr3qCvmTVWokBxkVwSqLAk2/+u8oEfWovz/6?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f37c39b9-6ffe-4d64-8502-08d90e80351c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2021 22:10:06.1301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VhRnZ8nTXnvXx32de1tRb+gvkS1UZr7823slJg7blHc/cMYW9pOMDv7fz/WxWAgSzLW+74KU+cfxcc7I3dhC+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2952
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9973 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105030150
X-Proofpoint-ORIG-GUID: LNTy5u-tW1gJUPf6S4l5_oro2HTOJyBL
X-Proofpoint-GUID: LNTy5u-tW1gJUPf6S4l5_oro2HTOJyBL
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9973 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 spamscore=0 mlxscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 mlxlogscore=999 malwarescore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105030150
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/3/21 2:41 PM, Peter Xu wrote:
> On Mon, May 03, 2021 at 01:53:03PM -0700, Mike Kravetz wrote:
>> On 5/1/21 7:41 AM, Peter Xu wrote:
>>> When fork() and copy hugetlb page range, we'll remember to wrprotect src pte if
>>> needed, however we forget about the child!  Without it, the child will be able
>>> to write to parent's pages when mapped as PROT_READ|PROT_WRITE and MAP_PRIVATE,
>>> which will cause data corruption in the parent process.
>>>
>>> This issue can also be exposed by "memfd_test hugetlbfs" kselftest (if it can
>>> pass the F_SEAL_FUTURE_WRITE test first, though).
>>>
>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>> ---
>>>  mm/hugetlb.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>
>> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> 
> Thanks!
> 
>>
>> I think we need to add, "Fixes: 4eae4efa2c29" as this is now in v5.12
> 
> I could be mistaken, but my understanding is it's broken from the most initial
> cow support of hugetlbfs in 2006...  So if we want a fixes tag, maybe this?
> 
> Fixes: 1e8f889b10d8d ("[PATCH] Hugetlb: Copy on Write support")
> 

Here is why I think it was broken in 4eae4efa2c29.  Prior to that commit
the code looked like this:

			if (cow) {
				/*
				 * No need to notify as we are downgrading page
				 * table protection not changing it to point
				 * to a new page.
				 *
				 * See Documentation/vm/mmu_notifier.rst
				 */
				huge_ptep_set_wrprotect(src, addr, src_pte);
			}
			entry = huge_ptep_get(src_pte);
			ptepage = pte_page(entry);
			get_page(ptepage);
			page_dup_rmap(ptepage, true);
			set_huge_pte_at(dst, addr, dst_pte, entry);
			hugetlb_count_add(pages_per_huge_page(h), dst);

After setting the wrprotect in the source pte, we 'huge_ptep_get' the
source to create the destination.  Hence, wrprotect will be set in the
destination as well.  It is perhaps not the most efficient, but
I think it 'works'.

It is subtle, or am I missing something?
-- 
Mike Kravetz
