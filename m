Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85E9D3347D2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 20:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbhCJTW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 14:22:29 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:50116 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbhCJTWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 14:22:08 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12AIxZ6U037081;
        Wed, 10 Mar 2021 19:21:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=dYAJtSDqH6jLI2dEgPRnUH2zEvGXp+nFff+Ge1uOHKs=;
 b=t2npHZBb+HJl1VFm3jzzteUhh1jHkp6n6rk6I22VsTYGvafYv96gas+d2ZUJ7jAwCflb
 hybwmyOVtH17IjtvIp6hb+QAZjRUInYFr1paNnf+RJvg0aogNIkdDD7bfh0vhg6041qe
 DVVGRD1w8ir5QT8gtVN383kIdjTgwRfqK9Y2PPSXrcKm+lRNgq4RB604EjS2qGsh2EaL
 +mWzgMJ3ml8AhFP6UTBtZwY8l4d07Er7vGu5Z8pAg17YyOv/T0VsuyX1QlMsDg/sqKSA
 WuC4vyZWg8AsV5KlYxE6xzrwP7KI0WXBZQOJgQc5HIr8/JNMkjdFCXmE8T4Pma/1JXGt WA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 373y8bvbdk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Mar 2021 19:21:55 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12AJ16Hm091654;
        Wed, 10 Mar 2021 19:21:54 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by userp3020.oracle.com with ESMTP id 374kgttn0r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Mar 2021 19:21:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+/8Wup2rtAsk7AITUf/15UCRTpA0+oay6B9++YHujht1cX6FEMmyabE0pzun7DLNGoLrRMMvDLsj5j9N2v3+Ws3zpmNS6JUQMMBg/hNbPQZrNKXihae/AyHA00qFQJuOMEjYpx/jA/I3Z0ntkvwm4m28G8e3RJm+FjT3Umq8c9YksqERH9zuIxQPuY36HWCY0zH1FnE8RC7uElGAXhIpc7yyvEWUw0u1Scux1T17uiW9yPDcc03wQP5o+lALxtlA2UaHRef6TbiDXfenWggLv66CIZGLQyzdi7LEEkk6odT/gUYd0NxhYVjxnWPy/AZ5D4avD2dRPL+pxlHdDULwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dYAJtSDqH6jLI2dEgPRnUH2zEvGXp+nFff+Ge1uOHKs=;
 b=Z4Zw0/jv+h/9eMgYxKXllPhpqhIYUcTnA/33Er/ED8I+YAo+YrSvrfT+inBVs75TnDFOCY8dCUWejSm+oT3HMrddDWFpL7jQMJ05Fpbf7ZVbeF/Fbrz97Ui+txMX7TvXt4cXez331zwTKn3m2/PVnFVukh3bSyMirGBCRW8ihNRwpowZ8SrxyGeCORIkrAVaraF0DqS+cp5xacVM2/J2a+nE23Y6vTcNcQn//Hly7iXU2yZ+fKdcQIpqVXiJK33An631AO52aK5Q0T3cBDv/No2KYcOhkGE5BTjaRO1owHm+g6wOJwZBXWGQMKqmIoqterRcZa0JqSIGIjiEoaazNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dYAJtSDqH6jLI2dEgPRnUH2zEvGXp+nFff+Ge1uOHKs=;
 b=uti1yMZ1tctQohuWdH074xNjNACpiTUu/UzbMFPYMKEfTD7GIUDjmqtOhQutFvDKf3lGbV6jwltvlV6u739Amay0HnIPEkTsPKVzN3XcCBCr1qZtPn9CKZJ/sYsrUpzP3nqyEpo13NEOD6BBVUTieNnNObV8qsVsmqK7mnjk5kE=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2853.namprd10.prod.outlook.com (2603:10b6:a03:92::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.25; Wed, 10 Mar
 2021 19:21:52 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%7]) with mapi id 15.20.3912.029; Wed, 10 Mar 2021
 19:21:52 +0000
Subject: Re: [PATCH] mm/hugetlb: Fix build with !ARCH_WANT_HUGE_PMD_SHARE
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
References: <20210310185359.88297-1-peterx@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <debfe3d9-3d8b-af2a-de23-b927bd119e4e@oracle.com>
Date:   Wed, 10 Mar 2021 11:21:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210310185359.88297-1-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: CO2PR06CA0060.namprd06.prod.outlook.com
 (2603:10b6:104:3::18) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by CO2PR06CA0060.namprd06.prod.outlook.com (2603:10b6:104:3::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Wed, 10 Mar 2021 19:21:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba9af2a0-a9b1-4c5e-ae2a-08d8e3f9c27d
X-MS-TrafficTypeDiagnostic: BYAPR10MB2853:
X-Microsoft-Antispam-PRVS: <BYAPR10MB2853118E85B9B865A7C8B8F0E2919@BYAPR10MB2853.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:475;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bk/RqLqyGLKekHr6nQsh5P6YDM96uWsYrJ1m9Yryco6k3HTTccW7whV5wUDmXwVDn+6jN9i1mFe6WjRT1UMGmUF+vVCJxKmeZPbOS5a74ryfh4/smdTu7+nZ6yd25Ut7kgJUoDvN+hLqhmCElM8ULSutUNLP+13ygeKtNUnj3pEfPMYM4USMSZFSGfpCPr8BAd4lycy0UtpsiVysEKMaukEYD1PJSL1sl3NaBEBXfy7JY38Vt2niFB6n5ALdpN94ktj8Z6ONWISTxXmuoKWTyf+GkKqQ2pw4DBUEx//iXOB6AtkmtiqHMu6negzq9U3tbcQ3VgtfYuzd5yMMdaDUUfc9tzmXX4QOShcKVGW1Xs50m/v2DZBngrIuhP5m3+wLBp+SBL28YeX/CkPyRksL4lCEhuctJ5hZff12ncUToX54VTklkQI2udCYPLm31MA6qsgyQeLXELmtPNPUVMnglWvbG6uzkOA9MrCZhYOObA1Y00njVDjXPnDzoOzw/joWtQbJdMajZ6q5MKoak2gv0IQuBFlahIZVACrr9ANYaCnsVRNJVOC+dY3is2LFAebvmNEH0Zfr0yxAtXbSU1nWmO+ZzJrtima1Ryyo5ZalF2MhkcW2kFP3zEXoq3JdsPxU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(136003)(366004)(376002)(346002)(53546011)(54906003)(52116002)(8936002)(6486002)(66946007)(4326008)(956004)(31686004)(66476007)(44832011)(2616005)(8676002)(16576012)(2906002)(66556008)(26005)(16526019)(186003)(86362001)(316002)(83380400001)(31696002)(36756003)(478600001)(5660300002)(14583001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bFdoUXE3OXhGU2wyUysxWDFMVVFkOGFkVHczNk1EY2xnbW80ZFdxN01uY04w?=
 =?utf-8?B?T1VoT1pWUmhNUzRQcFNQbzRxRjZNRk9ZUmdZa2lKWTlDVS9BdGpXbzNvV2tv?=
 =?utf-8?B?d2U0NEc1eFlyM3pnUitXRXZvMzNBMFg3VUlOZmxrNWNRcGdIMG5lZkRIcFJP?=
 =?utf-8?B?dHZJNGZnMS9McVlwdFF6S3B1R3JYSm9MMDhjbFJ5dUxrZnBCb3ZQdDhHMWVj?=
 =?utf-8?B?MmJnMDFUZ1d1QWs1ajR5VEVLNVRNNXJiejcwK2JhNGVFb2ZHK1d5dG5XczJF?=
 =?utf-8?B?cFd1UUl6dWRtcVV5ekN4YlZTM1d3STdnM2NUYlE5ZU9INFdES1gvTmt2K21M?=
 =?utf-8?B?VVN1bWlSQVZscnYwYTNOOE9yMGZvSWIxb1NnS1YwSlVvSC8remNRK2RYNGps?=
 =?utf-8?B?M2NjRlBpOFFHWkpKVE5LTldic0QrVlFZVUZYbWFPeFQ1Sy9NV0Y3VVJ0WjdW?=
 =?utf-8?B?YXVPM1ZyeVVrOEVJWDIrWDR5N0xjd3BWcEtNOVlUcUZPWTdwWkorOFBaWUU5?=
 =?utf-8?B?aUFBdExyUHhiVVlZTlc0b0lBUzUvMkxtWVlvWnRFZThFUTZBK3lERFhQSHJo?=
 =?utf-8?B?U1FPR2VSdllOR0ZZSVQvT0cxTitnOVI0aXZOdnppUFAyYk9pVnI1YzhpalBy?=
 =?utf-8?B?S01DR3NXdWNCL0VCb003VTlIdXkyWWhDaEQzYitwS0p6RDgvK2NLVWJZRHlj?=
 =?utf-8?B?Skd4bmFjOUdoWkk5WVpKeW1jZ3BiSDRBS0NIemExUytVMTg4R2NQNXA2OGg5?=
 =?utf-8?B?MUphZzFvbHFOK2UrT3N2V3VpZjVRK0NPZ2kwdFJuUmVwMnUxNTRZbFJSUVc5?=
 =?utf-8?B?Z0lscDNrMG5pcE11a1NoWUwxYXo4MVVWaG03Ym41Z1l3bS9GUkJJaTdieGxB?=
 =?utf-8?B?VnAzSHU1Vmk4c09wTzdUKzhrV0xubldFbW5VbEU4ZXhveG85UTdXand1NGU4?=
 =?utf-8?B?eGE3RlNrWmY1Ym1jVXZjY1k2UHQxenA5ODlCVUZ5Qm1zb3prMzN4bXIza3F3?=
 =?utf-8?B?OW5vdVI4Q2F3U1l6bEhJSU9oY21DcmJ2MVZqbzhPeDN5QzlUbEc5eUlsQ2U3?=
 =?utf-8?B?WGFiUThad3RGc3RiWHdvT2xIZHFZWnhoUm1GR3ZqRVE5R3FqWkEzWWlrOEVJ?=
 =?utf-8?B?bXpGM3NxejFPTGxrNE80ZVNybWIzQkdFV0ZUQmpOV3RJU0ZlQlVIVGZnNVJa?=
 =?utf-8?B?WEhDZndIbXVnY3d5WmtHZFN4c3dpeVVyNEo0a3ZxTGJuMzRNVEZLVlJ6SmM5?=
 =?utf-8?B?RUx2WVNSOFowM1VnaHBQTWZYTmM2U0g3K2xqZFQ0ZUdYblFKYk0vTHo4LzRJ?=
 =?utf-8?B?ZER2TmduVmcxRW9ieVB6ZERXZ0Y3aUVyOTV5c2xsTENLZGpYa2pWbCtONy9G?=
 =?utf-8?B?Uy9xY2tTZzJIRitNd0lEbElzK0lxbnJNdXZaNDlGK2VjcWYvQU5IZ0ZNb3Zq?=
 =?utf-8?B?N1JidVYvR2dLVHJUWUlkSlZHdVlGRVpVZ0tZSGMyVVhEdTlIMUdpaHgyYjB2?=
 =?utf-8?B?ejlGa2FVOWhlNjFtaWhZQjZBN3NFb0R4Q1oxVDBzU3FXNmdqRTdyMVFUcyt1?=
 =?utf-8?B?eG1qSkVrV29uUDVReWU4RFlGeDJpRTJ4d05tYlNkbEt0T1dzSUQweEdpVk5v?=
 =?utf-8?B?cUd3VWlieWlYWnBOODdOREkvNGNibnQvSlNmZHVxb21XSE10L1ZCOWtUT2pD?=
 =?utf-8?B?NzdOMzlSTEtOVlJFamJTMzU5SFByMTgrMllGWEtkREpKUnlleDdlQkNVQVMx?=
 =?utf-8?Q?Entrw4ZZ759Xjzsf0plCyL5hG8xGPDfu7xB9KN6?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba9af2a0-a9b1-4c5e-ae2a-08d8e3f9c27d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2021 19:21:52.3149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n5A5XEPyqmsv34znA7LPhaITnRq5jKBLwwNV+ofJK0c2amhLEVNncTu+Df4Puie/FgjrPd7hfETv8coB0F/TWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2853
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9919 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103100090
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9919 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 mlxscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103100090
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/21 10:53 AM, Peter Xu wrote:
> want_pmd_share() is undefined with !ARCH_WANT_HUGE_PMD_SHARE since it's put
> by accident into a "#ifdef ARCH_WANT_HUGE_PMD_SHARE" block.  Moving it out
> won't work either since vma_shareable() is only defined within the block.
> Define it for !ARCH_WANT_HUGE_PMD_SHARE instead.
> 
> Fixes: 5b109cc1cdcc ("hugetlb/userfaultfd: forbid huge pmd sharing when uffd enabled")

That commit id is from Andrew's tree and I don't think it is stable.
There is a different id in the next tree.  Not exactly sure how this is
supposed to be handled.

> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Axel Rasmussen <axelrasmussen@google.com>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  mm/hugetlb.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Thanks Peter,
Not your fault, but that header file is a bit of a mess.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz

> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index d58f1456fe27..8dda7e034477 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5469,9 +5469,6 @@ static bool vma_shareable(struct vm_area_struct *vma, unsigned long addr)
>  
>  bool want_pmd_share(struct vm_area_struct *vma, unsigned long addr)
>  {
> -#ifndef CONFIG_ARCH_WANT_HUGE_PMD_SHARE
> -	return false;
> -#endif
>  #ifdef CONFIG_USERFAULTFD
>  	if (uffd_disable_huge_pmd_share(vma))
>  		return false;
> @@ -5616,6 +5613,11 @@ void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
>  				unsigned long *start, unsigned long *end)
>  {
>  }
> +
> +bool want_pmd_share(struct vm_area_struct *vma, unsigned long addr)
> +{
> +	return false;
> +}
>  #endif /* CONFIG_ARCH_WANT_HUGE_PMD_SHARE */
>  
>  #ifdef CONFIG_ARCH_WANT_GENERAL_HUGETLB
> 
