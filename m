Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B42D335E85C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 23:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbhDMVe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 17:34:27 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42572 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343824AbhDMVeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 17:34:21 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13DLXnpI109622;
        Tue, 13 Apr 2021 21:33:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=FBryYqb7d5bPeyx8EqpT8sMroz+c3D8iLPtL3uR0CCg=;
 b=G3OQTVjcBY4lsel6qcKtQ1PSuH9lgLIUDXKmZyoDJNBLL0kMkBzDuIFVgv+aYsurdI0S
 zvPk/fGAiz0VRnXP92HdLs9NgE0k1nY6ZIpkHaOWet2lm4D9oXQWTNjWrvD9MAu5KU3r
 LETc2l5BHyuJge4YtItMRecn68eUeVQyEtUhX0s6OxD0/HYpGgDJxZduyUs/JMYsCIGZ
 ZdQFv51jaZwAc+s1jSbmalBTA1ZZSPcpsFDb2H3urgT+WqL6Km1AIJ/fzVYfwxhSNtGO
 Ultf8pDUk3GpT3l+LqCCQuygLbOQOjnIeNvqyAGE54nSdGemWX9R5OqD6ZpJ8SWdST5J zA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 37u3erghk9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Apr 2021 21:33:49 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13DLUUMW137412;
        Tue, 13 Apr 2021 21:33:46 GMT
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2056.outbound.protection.outlook.com [104.47.45.56])
        by aserp3030.oracle.com with ESMTP id 37unkq3dg9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Apr 2021 21:33:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EkVEmAGykAXzEk4PTZPt5jdD/X5qjZYJO0IeyyeXpzedy3iJ+t/e4N9LG9J9HheULrqieaYWvDwF2rFbWkuWhXoRAR8X0/OhdcznMOK1TVJTuTRNlioa2q3OBXiSLGpjkka8Hr/OipTYWi82pXkoDqpFKxN34ekWcVKvsNIHDSz4RNCC44UcvjIepk0bKDii97uxCvGLjpKuFRivxcUep9spBylxoe4LlAy4UM51MoFyjqCEy3KNCVAVgxQUvvF8eMmd2NZBsnwTTWyP3z6puyr8vE5xn5I30Q8/xgAMTEJ2LBGN5Cl2FrVWJio0DFleUpKQNGc3q6GcJ7l91IzeFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBryYqb7d5bPeyx8EqpT8sMroz+c3D8iLPtL3uR0CCg=;
 b=WCaAmQ/hJQh9Mhwyx9O6iLNfxEiIGGWuKs6z1fYPqs1vPklApZKkRkYZ84s5U8oXNCGo+2h9m3nqvwmWSoluiKwy6UO8JzDK/qnslvrBEBhfP0Ifv2kcS7A3mQfUgIdRNNizorW12QhOKdRu+p2zag9CA2O93rj/0TuMAJfVl5is4XdMCJXNSvSgWV1ENmz3z8mLzrUPClvHG2e0C/R3vfL5AZMVNGuX1W6ok5MmSoQR2sO2X2CuIAFX7OSTUL5qSZyXsBn6g5zdyLRTigHXfqHf6up8FHtnC7cZW1arMNCtgN8fQ93s3Xrq6Gn8gvluTjXGcgZGRDmJktQ+iq8Ppw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBryYqb7d5bPeyx8EqpT8sMroz+c3D8iLPtL3uR0CCg=;
 b=nV+qHbEd/e9UN56eKKrkOB2rTvhQcKFWp8Ar8bE0g+/SKNKT0e6AwrSGl7C4ZsbJC9Nwye5jopz0ESG6ZWqaSAXlI5oBiQL2pi6vsbBfdQBWJfYPXS+c/97aLTh+BYmtTqNNhKVWju2JFhsGb0nry1g8LEbjDgAqlqdNcdJ+WlM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3399.namprd10.prod.outlook.com (2603:10b6:a03:15b::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Tue, 13 Apr
 2021 21:33:44 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%7]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 21:33:44 +0000
Subject: Re: [PATCH v7 4/7] mm,hugetlb: Split prep_new_huge_page functionality
To:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210413104747.12177-1-osalvador@suse.de>
 <20210413104747.12177-5-osalvador@suse.de>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <94992151-03fc-dedd-3e09-811908d26d04@oracle.com>
Date:   Tue, 13 Apr 2021 14:33:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210413104747.12177-5-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR04CA0016.namprd04.prod.outlook.com
 (2603:10b6:303:69::21) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR04CA0016.namprd04.prod.outlook.com (2603:10b6:303:69::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Tue, 13 Apr 2021 21:33:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df9fa6dd-1455-40e9-36d3-08d8fec3d02a
X-MS-TrafficTypeDiagnostic: BYAPR10MB3399:
X-Microsoft-Antispam-PRVS: <BYAPR10MB3399BC7C7F9A577072CA3C17E24F9@BYAPR10MB3399.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YlXL6B50DfEzqkoIEKe+FMYim0nzh3x0PWgWVjmKo67Qy/D+lC6sC6l8QWAlfPhtTwqQW2u1lTq115WI0BPY0sWCYyWvx41fhOh6AkblexjzO+t1ZuOZIWhNKb4acDl5Q3Nr1r9HBAOJTZms9dPTZuemjiNNGHsjheUW/TEa5tB4fXiZssEhh+9WCSLA9HrhFqDUvFxk1AOBksM5NvP7ZE106i0kHXMIdVoySZPcOoqtBBA0P2Z1JMlNBbScdd1M+pQt69f+Y0sKY5mw9hEJL+9jQbVVMRf/a5D+3u4eie1mxnUUImg/mOPt15fgpqhWI/ltq/58BQ6ML+7Vb1/eioc7dyKOfQMqMwo+4T7WsLUr+4Ths5wPKemYLUZw9WYGPBrYyQhSz5f6MrGDLe3eNVjPPxMGrr3lnT0kE7cAo+y2IigIxuZEUdOs6cFUKitJfrZln+8ee8x+RuFvU2F+JDqrTSo9sfSdX782wERN+eaVE2Rc2+hKsn4P3A1mU4srLtKGWMry/VBch0FNnfvwNLnko0NRuJmvgmy+XQaK2K4naWzb5mYmMKov7pwXi5jgFj5doAG/3hhEhyDvmf2cTpx50aN/oMxgfr3M8WhIwGMtFH9dWiTNpQ++TAnWR7lc4mRNi2eJErcj4n+TFUUtS/mVz+Ll8VyWJt+hLtGuFRh78S4WspFsXZkZSg75mKgVEo2SWa+h9gH1FsdI8S8Ywu3EW+KCyvdGH6T06gwpHtLUvjPrrqMUM3odk/wkG1q7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(39850400004)(366004)(376002)(346002)(54906003)(110136005)(5660300002)(186003)(16526019)(4326008)(36756003)(86362001)(44832011)(16576012)(31696002)(53546011)(6486002)(26005)(66476007)(38350700002)(478600001)(2616005)(38100700002)(316002)(66556008)(8936002)(83380400001)(66946007)(52116002)(956004)(2906002)(31686004)(8676002)(14583001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZTZKK0VRLzkrVEl6M2pyb21VT0tuTmdWdU90R2IrQkE5QldoWVdEQm1HOW1C?=
 =?utf-8?B?Vnc5Z3gxd09nWVYzeFNiOFN3a056Ukg5VU83SG9NWXlwb3Uwc2ZnYW84Vlhr?=
 =?utf-8?B?Z0tLSmNGYVBaQ3ZmRHhaMFBlNU9taVAyMzRCVGpXTFVQcklKU20yWU5USXpH?=
 =?utf-8?B?cTJWWVJNdDZnd2krcytzOTNzMTBaUWVoRTVjZXQvSlNaQVZSZS94UWhFV0ov?=
 =?utf-8?B?VmRnT2FCdHZmNFpiU1hIVkpzampvMlZnL0dCLytIYXBnczVjcENza0YxZEh4?=
 =?utf-8?B?dnlnUGM4RSttTWdOV3R1Zy81RlJ0RzNOdlVMQ2pwQTkyZkJSRC8rNG1VMzFx?=
 =?utf-8?B?Um0rKzdJKzgvY3FBb0tTWDJzQ3o3ZUZ2WUx3UDZLWXExZlNUVjVNdzVhOStJ?=
 =?utf-8?B?L1dEK0JGQzdJNjR2RWNXRVhqTEt6enRHblpXYkdjbmtpMnBxOFNRZDRwTWtJ?=
 =?utf-8?B?ZVlpMXh2TVlYNE1vTFRiU25vT2JPc0lRZGlrTlMybnd4ejB6M3BMcHY5TTRT?=
 =?utf-8?B?NjVoNndndmN1QUhzcXhoTFFtZGFxWkgydHZMaEIwSG84M3JocnZpam5YY2Yw?=
 =?utf-8?B?bFM1YlVDTWtleFZXZWdJeDQwVzdUMkhva0FRcXJsRTNnNkM0Y1hFSGVWVmhX?=
 =?utf-8?B?WjZ5ay9uMFUvZjNyZkp2blduaVVvaXFSdTNnbXdwQkRYU1hsVkdRV1J6ZjZl?=
 =?utf-8?B?RmdmblpQMDdlcktpQjltTW1Ib1FBSEdlWW1ycXp4L3NwVGNqWnNvejNOQUFZ?=
 =?utf-8?B?Y2lDVFlaQ1NOVDQwdGI4d2dueWtMNFhmTlRHS0x4eEFWZ0MrVGRkU3V6RWRp?=
 =?utf-8?B?a3owdlJoN1RyVFdFbE1lWTdZQ3ZOQzVsbzdxbFAzWXR3dlFLb2RpaDVCVFV2?=
 =?utf-8?B?R2Q1TDVneGVpb1krOGx1T1NjOTIwSmhjYjRsTFB0cG9IU05wNmxyc29JM2FD?=
 =?utf-8?B?QjcxZXY4YjZtd1dEMkF0SEMxZzBhdno5RXJRQVYxRXIvRzczTEk3ZDArb0JB?=
 =?utf-8?B?SWl2OVdYY3ZleWFaUlFXR0RrYXRCaVRybU4wWVdGTW04N093S24rZHlRNVcz?=
 =?utf-8?B?WHYwYzR5SlJ5T3hLTFU2UVU3akhyaDNzcCtGYW1WMnBuS1NzNW1UT3phQk9N?=
 =?utf-8?B?N0VuTkNINFp0K3c3T3ZhVURhZ0hUb3ExQTR2ZGlmdEQ3VzY1MWFnZ0tLb01l?=
 =?utf-8?B?TFQ4K2pHbVF5RFQrQ3h0VGRDRnlRLzRYbmZ5NXY3N0JIUUdGcC83K3gwRDlR?=
 =?utf-8?B?WHZJQnJiRUhpTklEcE4zTWJ3dUtIUUtrUzhUYmU5NzV1eEIwUFBmSWlyRVAz?=
 =?utf-8?B?bVVIb2JoV2g0VWpWUW1wbFFmdEZxR1drcCtpTFpyZnEwWkFSRlM1YnYvRTZp?=
 =?utf-8?B?RFlyWHo3REpSQXdrNFdEbTQwVStuQnk2ODRrM1BxQUY2Qk8wRktJMjBaVGVj?=
 =?utf-8?B?WW1kRHhlMktQYzliWVNOQXgzNU5SQ09PYWYzR1ZCa0x2ZDVVQldGUDhXMDV0?=
 =?utf-8?B?QW5ZbzRSbE5CcEh0cWVIRmxnU1g2TnZ3b0doWUhKRVFOd2pYb25WUm00MW9I?=
 =?utf-8?B?V1lhWDVnNEdCL1JsQkpkNFNCWnBNYkxKMmVETFVpVWpudTVrUTQxM0kwY1VR?=
 =?utf-8?B?bk10Y1I4d0ZGMjB5emZZZERPRW05c21NYVJBdlZzcXdnMGJJZGRIUFp6clVo?=
 =?utf-8?B?Z2FXd0dWOGY1QWtka2pDL0JZZGdzaDBBUWNyZjRJNVhFNWRJNFJ6a3VBS1Ji?=
 =?utf-8?Q?vgCUFmBj0JA6Omyt6y6TkunwX/5fwI/4y7XWIX4?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df9fa6dd-1455-40e9-36d3-08d8fec3d02a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 21:33:43.8993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lAupZ4LgpeM9ZpI1Gh9N7iy4TpVm6p859J4nhPHptsqtA0SubpYTPkYpD6F33LX5shnPokq4j8tlzzvDyNT0FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3399
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9953 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104130142
X-Proofpoint-ORIG-GUID: GNnvD3jTfG-DVj5lnQnUMhVScmlP4EgG
X-Proofpoint-GUID: GNnvD3jTfG-DVj5lnQnUMhVScmlP4EgG
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9953 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 clxscore=1015
 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104130142
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/21 3:47 AM, Oscar Salvador wrote:
> Currently, prep_new_huge_page() performs two functions.
> It sets the right state for a new hugetlb, and increases the hstate's
> counters to account for the new page.
> 
> Let us split its functionality into two separate functions, decoupling
> the handling of the counters from initializing a hugepage.
> The outcome is having __prep_new_huge_page(), which only
> initializes the page , and __prep_account_new_huge_page(), which adds
> the new page to the hstate's counters.
> 
> This allows us to be able to set a hugetlb without having to worry
> about the counter/locking. It will prove useful in the next patch.
> prep_new_huge_page() still calls both functions.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>  mm/hugetlb.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index e40d5fe5c63c..0607b2b71ac6 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1483,7 +1483,16 @@ void free_huge_page(struct page *page)
>  	}
>  }
>  
> -static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
> +/*
> + * Must be called with the hugetlb lock held
> + */
> +static void __prep_account_new_huge_page(struct hstate *h, int nid)
> +{
> +	h->nr_huge_pages++;
> +	h->nr_huge_pages_node[nid]++;

I would prefer if we also move setting the destructor to this routine.
	set_compound_page_dtor(page, HUGETLB_PAGE_DTOR);

That way, PageHuge() will be false until it 'really' is a huge page.
If not, we could potentially go into that retry loop in
dissolve_free_huge_page or alloc_and_dissolve_huge_page in patch 5.
-- 
Mike Kravetz

> +}
> +
> +static void __prep_new_huge_page(struct page *page)
>  {
>  	INIT_LIST_HEAD(&page->lru);
>  	set_compound_page_dtor(page, HUGETLB_PAGE_DTOR);
> @@ -1491,9 +1500,13 @@ static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
>  	set_hugetlb_cgroup(page, NULL);
>  	set_hugetlb_cgroup_rsvd(page, NULL);
>  	ClearHPageFreed(page);
> +}
> +
> +static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
> +{
> +	__prep_new_huge_page(page);
>  	spin_lock_irq(&hugetlb_lock);
> -	h->nr_huge_pages++;
> -	h->nr_huge_pages_node[nid]++;
> +	__prep_account_new_huge_page(h, nid);
>  	spin_unlock_irq(&hugetlb_lock);
>  }
>  
> 
