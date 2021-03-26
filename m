Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5627E34AFB2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 20:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbhCZT7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 15:59:17 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:44374 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbhCZT7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 15:59:07 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12QJtVMV151068;
        Fri, 26 Mar 2021 19:58:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=yZnXbhnxMchdlmPs9l/gXoJc7nCL3Zu4+FsilZBvMmg=;
 b=FHeW3qtHvFCmRVA3cQoTXJRLkb/imDvep+BIhaQYBzMkT6eRGyXKlLPJyHniIQeeOa6M
 cstGCmp+6Rqncm3bVbApN+hZq5NejZAUXraFma7i2KBZUm+Gy1ywRxT5xMMq63ZYua3N
 zsg1PCKEo/oELzoLfvVJ6iMJSPBuc4m0Kcx5gxutHjBl4F5qKpPNU0MbGmT1l6/2ho/4
 43JuxBXKly1e+MCY3H7ObH5VGxQ3+Em0mpUzJvjoPD2kKX661mCV7/DYjTP6L267dVjz
 76rUHak7kkz8AOO3+6hdghOZwxQ1S7EsLLZMAiKmu5b3uTFtxkbHlxgNLZ+GaNTxJYjv xg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 37h13ru88a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Mar 2021 19:58:02 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12QJtNEN192287;
        Fri, 26 Mar 2021 19:58:02 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by aserp3030.oracle.com with ESMTP id 37hff4qemm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Mar 2021 19:58:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XHJ8TdcGsVIsr66NdWVyaVJxIa0I4jQYiS/JGQfMo6n5uAk7wQ61NhfxbZrZAiY5W+2JnY87zdw2cgE86kc97aFEjMqSSlHUYlg6/xSw04aKXpXbLPme+S7wv0IBZs1kHKbCb1TczFFFdzI8jJMqY430InOXhoHBD/DQDCfKbwmkN/3hKCNqP7UW3SJQ28yb6672ItF9SmKvhEm7H1XHdVg1xsaTPsHJ+qzs5mAKa1bJr8vRzQGBsdWZep4Jbw6Hs7oP/Ar4zwi5AuaH7LUTvstFdamZSaCt+1NRYWfMUx4+PRwhUV3eq/DPHlw9OkwFheDad40YAgJKRk+WtSok0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZnXbhnxMchdlmPs9l/gXoJc7nCL3Zu4+FsilZBvMmg=;
 b=k4mxO6ZnKBLMD8f82Ri11LTQAwN+k2xrkGAVyEwJQqk/PAC1cdoIwy3EAwazEV7ieE4ZYcUYlQ7xlqjl2TWKdw5ipWJIFyrxp0jfyucVOsz24RRppWDh7mRhF8AF3fzKCtISRZI8AwNUhIVRdKk+xEsow1em81xY3wAfZXzPb4lkOmJb2PyVuC384GG72KlCcrGpdH+GTOSX7IEsrNtv5h1xyRhOqc1jJJSc6/h2a4F36jAJ9txz7Kq/fMKXCcyuerCBDnJbA/KOqP9MmxjOdNbrG/+uv6E6/rrAQWsOmUiMar90EjIOMLuCnzVcy6XtNDTKIajTinR+I1NsN8cwpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZnXbhnxMchdlmPs9l/gXoJc7nCL3Zu4+FsilZBvMmg=;
 b=qmnhAnU3b0HxB9rgpAw1RFdBLp1VN3ojAxJ3nod/15MvFIcBwKTplsLLXC8D/3A8LGfUaO0mcdzUdUJFL2e5ryi8xQ/sn9O62S0vXgaZAuWCvmjJrriFCP4hTtHa6ZbKX3ExeYpsGlRxhBTJ82dCEC+cUIUVz6ZBMqdK/59TL6M=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3096.namprd10.prod.outlook.com (2603:10b6:a03:151::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Fri, 26 Mar
 2021 19:57:59 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%8]) with mapi id 15.20.3977.029; Fri, 26 Mar 2021
 19:57:59 +0000
Subject: Re: [PATCH 4/8] hugetlb: create remove_hugetlb_page() to separate
 functionality
To:     Miaohe Lin <linmiaohe@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Rientjes <rientjes@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Waiman Long <longman@redhat.com>, Peter Xu <peterx@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Hillf Danton <hdanton@sina.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210325002835.216118-1-mike.kravetz@oracle.com>
 <20210325002835.216118-5-mike.kravetz@oracle.com>
 <ee3d6134-068b-8f21-31d6-4d13ef417ae1@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <def1f500-ae75-5669-5a3d-0472865d2d4c@oracle.com>
Date:   Fri, 26 Mar 2021 12:57:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <ee3d6134-068b-8f21-31d6-4d13ef417ae1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR03CA0194.namprd03.prod.outlook.com
 (2603:10b6:303:b8::19) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR03CA0194.namprd03.prod.outlook.com (2603:10b6:303:b8::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend Transport; Fri, 26 Mar 2021 19:57:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d82a0e1-4466-41da-efee-08d8f0917497
X-MS-TrafficTypeDiagnostic: BYAPR10MB3096:
X-Microsoft-Antispam-PRVS: <BYAPR10MB3096A5BE2124965E2B914F40E2619@BYAPR10MB3096.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HCmw0LV/ZIbi3l9RlRPK4TztedL/QfauHUqJXbHHmw+4h7+cBNs7zB4caB2QDVfxGemmVOyXc9h2OtyrBw9jzlsYitMjUPHl7RA1N7NTyEt/3cnhOeqI2VcZF4429agH+u6eOqJ3ZP8t8vSUPLc+gZtTEnSyjQCJ56dBKP3utC8AAE3LJLAvMRI6pe9xs3j7LjeYKgIeB3ZwURj5IVYZJ/gbcIzVLZoBBz3Wi4WqIpzsaM3KkMziyGRw5HQ2Z3bxYoMhyXQNLpjbK2L0OAveoeHA8QRBVOKn+p7A3CkBc+z81/QIZKUpCj3C/KX7Agq3b2Z87O+9vOTYLVKSWI+rdv+G7liGvyDiQ9UQO4xC3d7FY0sCZeSBOMZm/ITkBnJ0Fz1IiU1lZDvLNZ0ycolJ1GGJJK1XxQamlxeHNPP473L25bgcYoKxHOEE+XQWVYiKPY5KSIV5PkYCQB1w6GBJkhi+gCpP1Sv7WNLS05W6dDQriYSzRo/nDd3BvSa3HTGN3LPdomq4lBHdF+H0kP/6da0kVPe/5Atc8AFuZOJlNkElAmMUCqbM0qIDXOIhYalmeRFqP0e8dTYwHba3WbhJdZThUo2V4F7BYIGeqLhVhTzzprqnIStdUrh2GgJaCbyZO4PHySQfzuGCI/hZHdsoR4Rfo2ttiqZ7EE+/ZrckCwKv2w+CV3ZPANaHpADvvbaiVVqH6EkiHLUBZ8x1KgQtsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(396003)(346002)(136003)(366004)(4326008)(956004)(83380400001)(2906002)(316002)(36756003)(2616005)(44832011)(186003)(54906003)(16526019)(7416002)(26005)(16576012)(6486002)(31686004)(8676002)(66946007)(38100700001)(53546011)(6666004)(52116002)(8936002)(5660300002)(66556008)(478600001)(86362001)(66476007)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?OWVXcmlsRGdrc0xMZWhZc2czdTM2UmpjeG9zVnNhb3FDSVBtM1g3WW9wdkRs?=
 =?utf-8?B?elhlZ1dkWksxQkpNd3N0c3RtMEF0RVF4TE1wMlVGU3dkamY3Zi9iTEtsQmJ3?=
 =?utf-8?B?V1p1TDNvS09uM0VsRk9FU1pPVmFUTjZYSmdqcVFYOUpHUGw2WElPaUY3eThj?=
 =?utf-8?B?MDk5NFp4VkpnWXJxVVAyM0tvcDFMWVBOV1Z5TlE5blpZUFo3OWNKQjFKT1p6?=
 =?utf-8?B?Z2xYQlF3bHZvTUQyY0lBWE53SFk3YWxjWFBXNG5Yc28vV3dGZDVnSUxuNHIy?=
 =?utf-8?B?UDZ4dE04Q0ZWR3J4dDBLQVZibmYvUFNaUHY4SmJVbmVEaXlyTjBxdGJwcW9F?=
 =?utf-8?B?ZWNZM2hrZ3ZHdDBQTnNJSFBHeGVYQTE1VG1obmpsTVJIL2NKMDk4REhNbmln?=
 =?utf-8?B?MU9DVnloeEp5RDlvRzYwbUpiSnFWRnhkcTdaQlIweW1lNzR5UzdzMXVhV0xO?=
 =?utf-8?B?eGs3ampZYUQxUnBhbHhyUTdQY3hZZ1k3TElQNWNWRnZ5a2tNbW5heFFvbERU?=
 =?utf-8?B?R2ZwVkp2NVhGSnFndGFzRWVRMmhUcDdnWmZyMXJlZnRPcGN1SzYrWWc3bGNY?=
 =?utf-8?B?cHA0Vjh5T2xmSW5VRzU3M2FpRUNBL1VoMFlJcVlpTEN0cTA2Z0g2c1N6c2lr?=
 =?utf-8?B?aUliVjNnVnJlcWFBR0d6cHBBNS9GS01Xbi9NQ1U3QWdkTzF5Q3M2MnRiNktS?=
 =?utf-8?B?T3YvWEwwNWZwTnNtQ24zc0txbHk5dWNIYUNOZm1DSGtodU5QYWhmRlBIM0N4?=
 =?utf-8?B?Sk5MOVVlSjQySjNRaFh2YnJrL2ZNb3NvU2kyaVM3NWVzVDVZZFNsaHI3K1ZR?=
 =?utf-8?B?U1Ixd2xaampENFBiWkZudGUrcHRSOXFtNm9ncElmMHQ5L3dIdXZQSVA2eXZO?=
 =?utf-8?B?anZVM1B6WjJkb2Y4c1YrbW5ydXVoUDFiNkEyNXdmTzhkam8yOERrL2syOUVN?=
 =?utf-8?B?ZjlsU1A4SXA4SVBCTmRYZWtBWlB1eUxxZ0JBQTVGSHc4d2ttT0o2SnIxdGox?=
 =?utf-8?B?aUgyMTZWSHdFdG51d1U3Y1pqcGJqRVJrbDdGK1JsVDdmNmFwUzNncEVBcEZj?=
 =?utf-8?B?SXZkZmVHOW83aGhHbExnb3Z3YXIzNTdvYjlJd1d4cUNadGxwVEZHVzFOZS9m?=
 =?utf-8?B?SVkvVEpYdzVhMFl1MkZhalVUdHdXRFdDM0htdFNCWHYybGFHV0ExQ0FkZGx6?=
 =?utf-8?B?YUhVbGlqN0RhV2N2RFNhSTJ2TmpMRnBuOVdKa00wd1V2ZWY1ZWRIdE1FcjNm?=
 =?utf-8?B?NTRtcjVOZHdza0ZDTGhvYWhBdHNQNGYydGhlVUVMalI4K1BkakxuQ1FQRXBm?=
 =?utf-8?B?eTg3L1ZDQi9jOG5JdXR3UU1hMGVVSkMvNWFlYzBmZ0Urc24wWjBZZTBFc3Fy?=
 =?utf-8?B?QTJHOGJEYmZReVFFREl2S0NNRFhVVVJZM0hKd3NVTmdnSG1JVDFYMjZaNGl5?=
 =?utf-8?B?czNNV2s0L1cvZGZjNktvbDRRdHVlc2pJaEx3aWtkcGpHbWwwTGlucENCNzc3?=
 =?utf-8?B?Z1p6YU9GOVhua3Z1a3RsQUFNb28zY1Y0c2Jwb1ZaZUcwc0NUUXZxazIzVHJH?=
 =?utf-8?B?VE1rdVc1VGk4TlVyOVZjVHp1dE96YTFoZTNhK29LSXE0WG5DeFdmYy9tSVg1?=
 =?utf-8?B?WWkybmF0cG1paUFUcFZCSGdtek03S1BKTzY2SW5ZNytrdmZ4QkdFeHJBdUZs?=
 =?utf-8?B?b04zLy9NeEdZY0dhbmNoWlNUYkFRL04rWndydExWTnFyZ01HRkVOb3J6QjRo?=
 =?utf-8?Q?XkETZUD0P2ygUiRUVCKk83A3F2o0dd5uOgllBP5?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d82a0e1-4466-41da-efee-08d8f0917497
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2021 19:57:59.2920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lUgsEoGfXJJeknrHkVshJq9/+4OlhA5J6yQ3ogiJLe/sTXy9WGbdYoUkT0VGY4MXuMrkyIO/K8JaCuPGPG81FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3096
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9935 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103260148
X-Proofpoint-ORIG-GUID: emcu-naHKZlRzOOb0B9-wdeJHJxQrj8r
X-Proofpoint-GUID: emcu-naHKZlRzOOb0B9-wdeJHJxQrj8r
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9935 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 clxscore=1015 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103260148
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/21 7:10 PM, Miaohe Lin wrote:
> On 2021/3/25 8:28, Mike Kravetz wrote:
>> The new remove_hugetlb_page() routine is designed to remove a hugetlb
>> page from hugetlbfs processing.  It will remove the page from the active
>> or free list, update global counters and set the compound page
>> destructor to NULL so that PageHuge() will return false for the 'page'.
>> After this call, the 'page' can be treated as a normal compound page or
>> a collection of base size pages.
>>
>> remove_hugetlb_page is to be called with the hugetlb_lock held.
>>
>> Creating this routine and separating functionality is in preparation for
>> restructuring code to reduce lock hold times.
>>
>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>> ---
>>  mm/hugetlb.c | 70 +++++++++++++++++++++++++++++++++-------------------
>>  1 file changed, 45 insertions(+), 25 deletions(-)
>>
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 404b0b1c5258..3938ec086b5c 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -1327,6 +1327,46 @@ static inline void destroy_compound_gigantic_page(struct page *page,
>>  						unsigned int order) { }
>>  #endif
>>  
>> +/*
>> + * Remove hugetlb page from lists, and update dtor so that page appears
>> + * as just a compound page.  A reference is held on the page.
>> + * NOTE: hugetlb specific page flags stored in page->private are not
>> + *	 automatically cleared.  These flags may be used in routines
>> + *	 which operate on the resulting compound page.
> 
> It seems HPageFreed and HPageTemporary is cleared. Which hugetlb specific page flags
> is reserverd here and why? Could you please give a simple example to clarify
> this in the comment to help understand this NOTE?
> 

I will remove that NOTE: in the comment to avoid any confusion.

The NOTE was add in the RFC that contained a separate patch to add a flag
that tracked huge pages allocated from CMA.  That flag needed to remain
for subsequent freeing of such pages.  This is no longer needed.

> The code looks good to me. Many thanks!
> Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks,
-- 
Mike Kravetz
