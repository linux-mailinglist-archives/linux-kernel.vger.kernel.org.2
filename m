Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C44E330E8D1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 01:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234333AbhBDAqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 19:46:15 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:45806 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234561AbhBDApb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 19:45:31 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1140OwlR033439;
        Thu, 4 Feb 2021 00:44:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=hcJbYnpn9ngQZ4hBommPiorl9O9OiJKL27d9IRFxtis=;
 b=rVMe3xOBiVGow/aiMhZNcsqg07SoJucPvE/M9p3ncwBBPqHFumNtM1cpYnRT1gSTs1a7
 JZ5C46hOCRSPqb/5pp3aTej37qkVd9yV+2WWLP4Hxk2YJdQWd2/kiKUAW7nPIRwNaw/4
 iX8g3aaaUAG+DiEayJhY2bgVxyE43TjmLRYqoXeN9dNZq3q2/6CYmbX+ybLCqK2+XTI3
 xKmSgjtfKyebU2WpzeHA31a0jNQ0KEKEebaxvySngIkMxRq+WrKJqsGOSQfsq6YslkV0
 vzxOSMwAaPKaHhD7Io6CQ2uVhq+9rDEIuuqVXcMSUALytkbZvXR2fTdAhV1zxIMuUL6B Sw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 36cydm2v51-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Feb 2021 00:44:08 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1140P3eG077253;
        Thu, 4 Feb 2021 00:44:08 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by aserp3020.oracle.com with ESMTP id 36dhc1y7u0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Feb 2021 00:44:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C2+9CFLSieWduHMRgc6GBkCGKsnfircswH+ZxNtDE05vUp98Sld0RsqcMJjwKPEpmLYZ1UmNjVIgoZkhggEHBgTOnEECTbh9P4RP9hZVOEsZJYIkVgOpJq7RkvHLlfP6VZmwRiD5fwPnkRkFKZGeWRvCPgE5IR7p/vMf10f3y9hoVRl9nDCXoYcQHGeEMqjkcArR+5vCgU0wUPbKwKVU7vBk0KLN4iCCy+cVeHwImBtUqDZvZXipBjGzgMtBapfr2Sxws/gHMT0ie91O2mfUBOv3eSI82HgBXRteHmTIGH99NMNb78LazZv+FNyHBKSr21XHavxdwIboewWgfqgjPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hcJbYnpn9ngQZ4hBommPiorl9O9OiJKL27d9IRFxtis=;
 b=PlNnsCYz9zJiMI1c928cwMqjVm6PT7OqvJdObi8Vot5HAs8U1FUn0UIhGhpAMwLTz/s424UVRq/kYPtLLwNaaebmX8mHQObhAyyQDEofaxKHMODLWRSMciumE6EcLmVCaiqycFaWXpQtwzX8w6ssnx8FRar6NfwmwVIaLbhaQWGli1wf20re05t1tNuqX0ew+xarD25qYIdWLLgfGhxk/B/cxrkJYLMjTxkxp5OEDCcUv5B8o0psLBR/6sfyWkawe6TgK2yyfoMNVaS49Y/7Uw+KA7oYyar1kysxOKkE+PwjOjS2ry5k9gSWZekcsS1FWKurgjXKpJ4TT182FZphAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hcJbYnpn9ngQZ4hBommPiorl9O9OiJKL27d9IRFxtis=;
 b=Xh5x1wehCg3cLM/cc1qMgqJhDZ9zJxPrcgpIvu6XQVgcE56JJRpq5ALKHyoF/QX8h3XRELjcsWqm0o2P8eVOkG0j3fO0a6gmXV2abner+Sp3RYy4GoZO6si4k9U/9QKfDEIrtirweRaxM4+K9HWYG0LH/YdRRVrt47itEZfu+Co=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by MWHPR10MB1600.namprd10.prod.outlook.com (2603:10b6:300:27::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Thu, 4 Feb
 2021 00:44:04 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3825.020; Thu, 4 Feb 2021
 00:44:03 +0000
Subject: Re: [External] [PATCH v2 2/5] hugetlb: convert page_huge_active()
 HPageMigratable flag
To:     Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>
References: <20210120013049.311822-1-mike.kravetz@oracle.com>
 <20210120013049.311822-3-mike.kravetz@oracle.com>
 <CAMZfGtUda+KoAZscU0718TN61cSFwp4zy=y2oZ=+6Z2TAZZwng@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <8ffcaec2-6401-ee11-d71d-9f7a93a13309@oracle.com>
Date:   Wed, 3 Feb 2021 16:44:01 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <CAMZfGtUda+KoAZscU0718TN61cSFwp4zy=y2oZ=+6Z2TAZZwng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: CO2PR04CA0102.namprd04.prod.outlook.com
 (2603:10b6:104:6::28) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by CO2PR04CA0102.namprd04.prod.outlook.com (2603:10b6:104:6::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend Transport; Thu, 4 Feb 2021 00:44:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d25034d7-b5ee-408f-338e-08d8c8a5f86f
X-MS-TrafficTypeDiagnostic: MWHPR10MB1600:
X-Microsoft-Antispam-PRVS: <MWHPR10MB160003FDD5F5F42DC99CF969E2B39@MWHPR10MB1600.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:419;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qe6wAMm1d/R+JUluaM5s9uLalSAnN6pzC8uEAXKypCYNsXNOfgi81gwS3FYYHSa+fIyGL0xe+wvEepYO/9OZkt6P3vo22Fe9kNYROJRJNcU0rzyV+i1+11hfubh26PyVNN6jIbzGYl0IkHtLpUz3460VfyGnyq6R8dG6SeFHO7JWvTNe706/k9v/0WSw6LamUNX+C88RPB3LwQfC2kvQYKiSDmbkxoew4NEbLBkB4vgpgOTY6MpdX0VMt9RKhIx9/Htrnco3zWt5YmNrbly66Zfz85BpFnu7jo9Ei4utA3AHWhfWiInEwa/tz90DihEG08Ud/NPB2zInHeO2dftTfbuDb2VbPGSXHOCeSvu860OGRGkUhL7sey5w2mquDKsUosHPNNI7NuZFnilj0M8Cm7YpdA0Q8SkPTQPxpjxtRC+h0bUL2bcSaIx69KQzPUi12p4SqZspRxCbiLb5CMOktVlW+Cdj8qGJI/FodBZl64gy93tPrSXnIEuxyfwMIMpNYzNvVk9lPJI4DI7F99yiLvovEINTZ7tmmmOM9HUIWC7s2qSEeakRjkOUhYQlBrcBeLKLEqwZscuChZxrXi+InSWGwKk+/5EjJcpERuqMW6Ibk98bA2PkcIuq2SE/Y0bR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(376002)(136003)(346002)(366004)(5660300002)(44832011)(2616005)(31696002)(66476007)(186003)(478600001)(16526019)(316002)(26005)(53546011)(66556008)(2906002)(36756003)(6486002)(4326008)(8936002)(8676002)(86362001)(52116002)(66946007)(31686004)(110136005)(54906003)(16576012)(956004)(4744005)(14583001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RjQ3K1JMN0hFQSthU09ST1h2UVR6ckNLd1hFMGUvOFpveFpobXljbVE2Y0JI?=
 =?utf-8?B?WnJHdGdtSEwwZHJpbDdpSk4xU0xJQzR3NHJNSHJiaGdMV1NMM0Jjbjd0U2pj?=
 =?utf-8?B?Tm0zZUtkWmE2R3Bma2RPRkxZY2FIcE9SbE9adXMvcU5CYzZocjkrL3VXS1ow?=
 =?utf-8?B?c01iUDdXcHh5SW9HaG9uVjRFMHpValZOWmM2ZE9sWFVkRDhzT3JrYU9tcWFo?=
 =?utf-8?B?bFp1ZzZwbGQwOUxDV1N2ZWlUdDJLS2pZdnlOMzNBNG5DajNYSnZCeFFpMGlP?=
 =?utf-8?B?K20vZEI2TWs3ekhNOWJnbXpUOFlucGlpemdBOXFOd2luY205YlZpbzNXZk01?=
 =?utf-8?B?T1JkOEsrbnVmRnVIanNvWnFkektGK0Z5SEhORlh1VHNiV1lodkgzYS9WZlFB?=
 =?utf-8?B?UWpacEtpeFJmSWdSdnlLN0UvMHp3NUFJbkVxOUtRN1NnTGxPSnMrdys4UXpG?=
 =?utf-8?B?d1FrSjF4ek9nZmt3eTYybGVsOXBCbHlRZEdqM2JtU2lHMEx0eWVTM1dMcTFU?=
 =?utf-8?B?UXN4VTZEK0RveVBnMGpmUXpsODZYYlA3T1NHTkJ6R2ErNWxWcjIwVVBxRE5w?=
 =?utf-8?B?WFVUWUR4bmlnTlR1NG5jbFI2UWdGejA1azczTE5vSVVJd1NlNWoyYXFLcUhD?=
 =?utf-8?B?WGF6eXQvdHlHQ3NqN0cyWm9XWDUwNkxGQk00RXNnZ1hZYldZaHhyQlRybXV6?=
 =?utf-8?B?TDh6Tkl2aFZ6VjlkeGs5aFFRV3VOdEFXTnkrUlNRQ3ZISVBGVXlUaXg0czVP?=
 =?utf-8?B?WFJFTGJzT2gyREs2YWNBNE43RlI3NzZER1B0VFNkMVpSaERvNHpWWVlUaUJu?=
 =?utf-8?B?NW9ZQlZmbWVlZGtXVEpqTTVOeDdTSFU3STVycUhXbmNXZXRtTTF2QVlQek1W?=
 =?utf-8?B?REgvVUtFczQ3WG9oTUEwRmk1VWQ5Y251bW1mT2ZYQ2EvUGhGSGRibGRhYlJL?=
 =?utf-8?B?UDhTeU9jWUVBM2p1NmFRNkF1UjFkeCtBa1VzN3ZtVW9tV0loc1VhNmw0a3Y5?=
 =?utf-8?B?TklPZlFJMWpXeXdIZWZrUHdYb1NsdmM5aWwyMkx6czNpQVd2WWxtdVhHZis3?=
 =?utf-8?B?TXRGV2w3b1poaFFmeWpYdTlyODk3K2ZKblRVd0hNT3RYVTAydHlzcEk4Zmw2?=
 =?utf-8?B?a0x5aUpoZG9QUnk1V3QvRnZDUTA0ZGpTSHBTREZjcnRGS0taM0ZBVUxhU0Zp?=
 =?utf-8?B?eXI3NkNpbmdzTHZwRU9JUWV1OW1XZU84UHp5akNVK09JblduK3hXNXlMNUti?=
 =?utf-8?B?U1NqdlVqUnNKcFdYOUp5V0hocmJHckJFUFdzYnZ1Mnh3LzNYRGloSDZMZkQ3?=
 =?utf-8?B?VWhsaGhES2phdFZNZUROcnhRNHJqZVBkSXY5WW4xN2JJWUVEQitzb1hrWWdi?=
 =?utf-8?B?YXNLQ0lvOGEvUmpPcThpUUZtNDBHQi90TWMxN3NuSEVSVldpencxWExLRzJW?=
 =?utf-8?B?OTNsdTgzMHR4MGtsTzdEK1RwaEwzdjMzdnBYZGJ2TzVTS0UxQnlTVTNVWUZ6?=
 =?utf-8?B?Z3NJaG5RNGIweXpoQnFadUo2WGlGTm1tRE1DcVVqUkd1dCtmekNxUXpIZTFI?=
 =?utf-8?B?Z2dESk85bldER0J4eGJoL2Z6NzI2dGNOd0lMS25aaGZPVHoyQ2toRjhSTFlP?=
 =?utf-8?B?Vml4aGV6Sm5BbHpuVGVYRWR2T2FIam9iZnpMWXpaQklRb1lUWGthUW5LWld3?=
 =?utf-8?B?V3AvNE1lRFBBbXpYWVRlc2FXVGEySmJxVnJUWEQwSkR4TUtEYzA3bHJKb2th?=
 =?utf-8?Q?Fpnk+i7NXtIpSI4Z0CGfPPXKxWAEYwwUGENORjn?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d25034d7-b5ee-408f-338e-08d8c8a5f86f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2021 00:44:03.8530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l2Wj6tntn1nHHWXW2WzaSFNVEaPgNDkLuJipuVr2WwYrMya7x3+uA3yNyXsthaa2DKC3Ne6zx8OELbzaezZrkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1600
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9884 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102040000
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9884 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102040000
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/21 11:42 PM, Muchun Song wrote:
> On Wed, Jan 20, 2021 at 9:33 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>
>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> 
> Hi Mike,
> 
> I found that you may forget to remove set_page_huge_active()
> from include/linux/hugetlb.h.
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 37fd248ce271..6f680cf0eee6 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -852,7 +852,7 @@ static inline void
> huge_ptep_modify_prot_commit(struct vm_area_struct *vma,
>  }
>  #endif
> 
> -void set_page_huge_active(struct page *page);
> +
> 
> Thanks.

Thank you Muchun for finding this.

Thank you Andrew for fixing in your tree.
-- 
Mike Kravetz
