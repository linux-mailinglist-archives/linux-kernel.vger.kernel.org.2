Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBA83452C8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 00:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbhCVXIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 19:08:38 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38570 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbhCVXIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 19:08:19 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12MN3uN8190729;
        Mon, 22 Mar 2021 23:07:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=dzcWb+o2H9DwCSt/OctjupvzGiwEK9W4o89BCKGMKIo=;
 b=bmsmKWGmT+2uEXrNr9O29CDTyL9KuoIc23WWKfbTFUGH0FVew+12fCOqxI35c+hJYB4l
 lq9TGi5qnszrfhSNlRa5vC1gUFEe0SEXlrb3Hv3SMrLfMCzup17yQY4HxHwGuK6HD2J5
 cUPM3gmr7sU+cZC84c+3YvJiDjYzgKDaFjpecM4opk2Gk0Ixz9+WJt5gvGs9mICk+k8M
 p3QObhXvbQ+DvbAA4B1FGhHu6THzch9lKMmbwbtsV71eTzFqskoawt8zJfZ1p+0Lgou+
 1uDYz/pnkc7FdbNGzvgXKyL+sbnp4FWLeqIz4zTfAQca7zwA8eVCaEGabrWK2iwZk29J DQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 37d9pmw29q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Mar 2021 23:07:35 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12MN67G8170902;
        Mon, 22 Mar 2021 23:07:34 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by userp3020.oracle.com with ESMTP id 37dttr6357-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Mar 2021 23:07:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OQdHGpAkJ/iRjkdi0OnqPDKQt75uGxp+P+m7vVfmBt6pX2No3UVPvLKf3vZn73dFoRooRs9wKovyWG/Lu85U57A/QRvfUD5j8a2xh4YpP28Yo2iNIgnqiA6g4l2+3M21FJxsJd05cxTpD2c5dxs0uSkZJMtdb2TWls+/vAhcJNOiehkDBxoK5FvtP89+qHtFCxBwC6XX8uB+LJSgrBo+4X8Gwnu1i+A65K4Sp3ejPhFVnLQrgAJmEVDkbrSTso7dULCpdMZ22lUvMJg4FeY3Zj9oh+OyYhvMokJybwVFNab6x7dHO9CWpFxEd6Ugwr9Dy9zHHAOAenZbyVef8n6Bbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dzcWb+o2H9DwCSt/OctjupvzGiwEK9W4o89BCKGMKIo=;
 b=loabKnehT1Q/hKbT46tMqFxj2iJYCNTeGvhbTvn3ZeuqH80zR3/5l3/MtA1Tw2FiGGGYNDi98YwRyMhg/eROtifiA1FRkJcxHBi3+MPiXCIY+zl7pb80ikLXMhyYjSMGF6IbznAJrIYXjyGtkKOPIWm0drUCoG7s5f8L7fVdwf+JAXJNE6iz+DVBqqAOXIZ40n1k8UaToU5nJWeJ47jZAso/mKNmEYB7EsFPkQk83EYzKT0w7FTm8WO0z588MQPrj5wfraXUnWsPS+QzFw+T/1unfwfa8y1xAkQG4OqzHy5BWWtnlqndVqxNu8dILn4jlGnZhp28MJKyAGdksie1jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dzcWb+o2H9DwCSt/OctjupvzGiwEK9W4o89BCKGMKIo=;
 b=o5XgXqCLt5p6Q+2HoaoOhGGWKrnEyT29OXSbvY/krc5sxUad+8e0h5N+CHLFnj+qXKmq2J50O3EpsmbQEaZ6hTJNanuyMNf9odeBpb12h6thPLlZ5kx/Nx4+82UxnX7+ljldraS/ewmd3dh/N+m9x4muACANWgTi2836LMjAsLA=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB3762.namprd10.prod.outlook.com (2603:10b6:a03:1b6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 23:07:32 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%6]) with mapi id 15.20.3955.027; Mon, 22 Mar 2021
 23:07:32 +0000
Subject: Re: [RFC PATCH 2/8] hugetlb: recompute min_count when dropping
 hugetlb_lock
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Rientjes <rientjes@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Waiman Long <longman@redhat.com>, Peter Xu <peterx@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210319224209.150047-1-mike.kravetz@oracle.com>
 <20210319224209.150047-3-mike.kravetz@oracle.com>
 <YFikrdN6DHQSEm6a@dhcp22.suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <a7d90d58-fa6a-7fa1-77c9-a08515746018@oracle.com>
Date:   Mon, 22 Mar 2021 16:07:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <YFikrdN6DHQSEm6a@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR03CA0067.namprd03.prod.outlook.com
 (2603:10b6:303:b6::12) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR03CA0067.namprd03.prod.outlook.com (2603:10b6:303:b6::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Mon, 22 Mar 2021 23:07:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5bb5ec53-61f8-44b4-598e-08d8ed8745bd
X-MS-TrafficTypeDiagnostic: BY5PR10MB3762:
X-Microsoft-Antispam-PRVS: <BY5PR10MB3762CF937E8BCD30D75FD766E2659@BY5PR10MB3762.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aY6bPpxf5kI3tt6Dt/8y2TLQomcittR0ssGpvg7EEjSw6+2PawvR+hfECk2b+bJBECwTsnJY0kaRjOqxSEBsk9o7IwUgRnvEMNOoG3ayTUUiJrie5GpO4IxyRzdFaw8n6VjO6w//8nYYW9x4hcicE9cEDNUI5ejXag/AvqtG1E+G9ohnHZibH0elwVsWbNIL8dN0dJxp+5QBCTQL1InrMnF3+Cq6XaKFiBnB1Kx4kHFafrtyk090ZTQRn9d2+/G4Nw5nl9724DC25Pbh2zrh9ENgISv5PSNrdZde0xfl6eBSnjAqHhkqUyE0pMWNfn0Qa7qa0awa0GeO8xJy7FinwXPz4eUl52e+o7rhSTLC1AlDAt8rqwOw5g9CryPfgVh4gmSY4WaqXYW3a1tEGCKGj2VOQu+lX6a7HUS9IO+WyEoudHRmdWPJMydNwiUWPQGdXZboD7NNl2sN293Mf5bIXEcN9G825zwKduKfnTFJOTC1XAGCfg11fUX5Qn+wtrpuDzhpis7QfQDvQeuh8vz3hHdHTvOqyc9dxh0Qx/MmEDrY2bI/XyeUUBbEaK3tV5s32SOSAhxfDbOTaDQgjjqAJ9R/W+StTianVTP10ejk3vnLMk0BcRtbRU0NeK6yqCM4USt3HLKX6prDUx00flJYRtqWfx2GfX1reKGvTE+YNYeAPWrWaKb/SNhBgZF2RQ8KrdbKkR5C8V57+wZSjiiQnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(346002)(376002)(396003)(39860400002)(66476007)(66556008)(66946007)(83380400001)(31686004)(2906002)(478600001)(36756003)(38100700001)(5660300002)(86362001)(31696002)(53546011)(8676002)(16576012)(8936002)(4326008)(316002)(2616005)(52116002)(7416002)(26005)(6486002)(54906003)(956004)(6916009)(44832011)(16526019)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Wkl2dHE4M3krR2JoNjZGOVEvMWN5U3doZmlFN3hXSVM0V2hnQk5BcGlFdXV4?=
 =?utf-8?B?SnRmNk9OZGdQSkxpcHhZQnZiTG5QMWNVOVdJOVMwNEhVL3ZuT0cwTFUxRzQ4?=
 =?utf-8?B?eTIvMTBmNXhsSnhJd3g0TEJSaGJ5SGJURlRpaGNOVEIweTVWaEc2ZHFyNzJR?=
 =?utf-8?B?ZkRuYjVQNHVnUE5IR2hUYTk0UUFicnNOSmR2b2d5NGlDeGI1bCs3cjBnMXov?=
 =?utf-8?B?eFREMGM0VGxKS2tyZWMya0VnY0RlVytyMG5uTXR5dWZWaUNmZDlGck10cGZV?=
 =?utf-8?B?elNycHJiN3EzQ2xpS2orZXFtUVFZdTN3bTVpZmE5QU5iVXpjNENWSGZjZU5G?=
 =?utf-8?B?RTBwRFlMa1lrdkVXQnhSTjQzR3BHMjFWRVAxSkUzWEpTT21pOW1rdUd5RXZp?=
 =?utf-8?B?TmVMaWtrOVUxaVM5bzdGa1E1ckN0UmtNcmIvTkx5QkV6WkwrRGRRalhneVhG?=
 =?utf-8?B?YjE3YVh2Vkh5R3BtTVM4NmlMNzhKd3h4dS92OVB0blRMTzRERUFETlJTeEtL?=
 =?utf-8?B?aGVRQ0thKzZUODlFTXU1bTdHWkNLSWNBakQ2dlJnV1NEQWFDZ2I1V3FHRmN3?=
 =?utf-8?B?ckZZNzNzZkhQWVpTeXpiUGRNSDZZTUozTnF6ZVFQZTZBVFlrVHZsTWxyK2lO?=
 =?utf-8?B?b0RqbVp0WkpuUzg2d3BxVm1zeUVRVzlwVGRzOWJkVTB4NTFHWG8xanAyb08r?=
 =?utf-8?B?NllBMCtLWXQrYUVQYzBSQ2ZZSG5TOGwyODJFTnBoYXM2d1pEdG1uS1BZY2c3?=
 =?utf-8?B?ZDJScTVDYWJlbkFaMVdRZm5JZ3dJVnVVaVZEN1JEbXdRSjlWYml5MEczNDE2?=
 =?utf-8?B?dlpYd0ZwYWlKa1hUZUcwdzNOZDluYTlKaE0wenM0blZNaWlvUXVtL3ZLTnQy?=
 =?utf-8?B?d1NqV2RmeWdPZnR5czlSNFBKZTY0SVREQXMvWlZpK0h0WEh4d3R4MTNpbEtL?=
 =?utf-8?B?MTNNWXBJUjZnYXZoN1EyQ3RLZG4vNkVZNzRpOHZpZE1GS1pBaksyUm9BeFVJ?=
 =?utf-8?B?STArQ1JqRzZrZURQT1ZMTGRYQVc1ZWlRNk55bWRxd2V3Y2QweUxCRytVeXFX?=
 =?utf-8?B?dFd2ak1nYjlYV0xqc3VLR3NCZ0xDQ0huTVdscDNZeklxK1FSK3M5bllFYU5N?=
 =?utf-8?B?OFdBYVFlUm9KUFlJTHNhV20xcVRpb2dPZTdZWlpiazZJK2x4ZmRBUWQzYjFH?=
 =?utf-8?B?Y09McXAwQ1pXZGpDL0pBT3pVcWd4MUpwbUFRRVM0VzhjYlN0UktiUUxRc0Zq?=
 =?utf-8?B?ZnMwQ0Jhc1FUeGxUNUdyc0wwbHByU0F0aVNDbjNudEFFbUI2NlVhTnhtSTNK?=
 =?utf-8?B?SUFHLzVvOWJzTlZ0b1NvODZ0MDBRMDZYenp2VGJMY1I3UDYwY29jYkVpTG56?=
 =?utf-8?B?Tm1OZUVWd25xdXVyUWpxVEZMSVZTcm5yODNrbEE1Nmk1Q3NLUEI4eWNITUdq?=
 =?utf-8?B?U0VaUmpYc1dOUHJMSFZQV2JwNHFTUlViVlpKVTZLUzFOVG9ZOXdhL2F0ZHVK?=
 =?utf-8?B?TTh2eHlwRW9nelU1S1haNkQyZXZpL201Z0UzOWNaWFNZSEg4d1NmSHcyWEVF?=
 =?utf-8?B?VDBMeDFmL1dSMVNDaDdLcGlFb2d0Ymx1MjB1M0VlS01abzZRR3Zxank2ZmdV?=
 =?utf-8?B?dHJaV3VOS3huRG5NbUJLUFZEUzdiVUxhbFc3Qzh4Y09VMWlPdzdGTFZ2NUVV?=
 =?utf-8?B?NnViSlNueUwwOEVENzZUNCtEZTZESSttOWZxNFdmdloyeUp0bkc2a3VJT1BB?=
 =?utf-8?Q?AJoY/b/Dp9ONwIyts+OsXXnNcF5txQZRSyZdhIL?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bb5ec53-61f8-44b4-598e-08d8ed8745bd
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2021 23:07:32.3392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6dmQcFD/hT1xZp1XGM5CqgPHjckB1Cl+wJOpv22Tk7f7UsNa52Iyacfef3bIoc+y5EihFcYBWtiuuF81ZVghhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3762
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9931 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103220171
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9931 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0
 adultscore=0 clxscore=1015 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103220171
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/21 7:07 AM, Michal Hocko wrote:
> On Fri 19-03-21 15:42:03, Mike Kravetz wrote:
>> The routine set_max_huge_pages reduces the number of hugetlb_pages,
>> by calling free_pool_huge_page in a loop.  It does this as long as
>> persistent_huge_pages() is above a calculated min_count value.
>> However, this loop can conditionally drop hugetlb_lock and in some
>> circumstances free_pool_huge_page can drop hugetlb_lock.  If the
>> lock is dropped, counters could change the calculated min_count
>> value may no longer be valid.
> 
> OK, this one looks like a real bug fix introduced by 55f67141a8927.
> Unless I am missing something we could release pages which are reserved
> already.
>  
>> The routine try_to_free_low has the same issue.
>>
>> Recalculate min_count in each loop iteration as hugetlb_lock may have
>> been dropped.
>>
>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>> ---
>>  mm/hugetlb.c | 25 +++++++++++++++++++++----
>>  1 file changed, 21 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index d5be25f910e8..c537274c2a38 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -2521,11 +2521,20 @@ static void __init report_hugepages(void)
>>  	}
>>  }
>>  
>> +static inline unsigned long min_hp_count(struct hstate *h, unsigned long count)
>> +{
>> +	unsigned long min_count;
>> +
>> +	min_count = h->resv_huge_pages + h->nr_huge_pages - h->free_huge_pages;
>> +	return max(count, min_count);
> 
> Just out of curiousity, is compiler allowed to inline this piece of code
> and then cache the value? In other words do we need to make these
> READ_ONCE or otherwise enforce the no-caching behavior?

I honestly do not know if the compiler is allowed to do that.  The
assembly code generated by my compiler does not cache the value, but
that does not guarantee anything.  I can add READ_ONCE to make the
function look something like:

static inline unsigned long min_hp_count(struct hstate *h, unsigned long count)
{
	unsigned long min_count;

	min_count = READ_ONCE(h->resv_huge_pages) + READ_ONCE(h->nr_huge_pages)
					- READ_ONCE(h->free_huge_pages);
	return max(count, min_count);
}

-- 
Mike Kravetz
