Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFE23A8C2B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 01:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbhFOXDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 19:03:34 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:39428 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229811AbhFOXDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 19:03:33 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15FMuHND018824;
        Tue, 15 Jun 2021 23:01:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=4ecsbeh8KxcKGhnoJ6sMfLrpik6518Z6zbVD4bnx6dI=;
 b=qiPza9IagxdjZAx6BDBBrw6xveNE6ordU7B5UoA1Wbc2T0aLgt/41airZHv/koYYNZ07
 XG7KLETRhAhtUIFy/bPLNk1R9CA2lYQ/8u4JajOfmfIHBZkOzZYDD4n+DL1zpx1UO/a7
 VHOzFHXxCemS+WWLUKcDfvhre14iqjzxPS92YhXvJgVxx4SMJBwpwm7QPV6x8p6hkY/M
 dy0RLAWJBVxI6vv4ftep04387dIZWmMwbZtbH526zSg7ywe4V0bIVCxKMj1Ya0YGMUjU
 lBKxlSrRmMM2MRfgUTRWd4TEiNoePQL1Z59vJmsT9hSnwZs2exzkbagXis1jX1sMLWlX 9g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 395x06hj4e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Jun 2021 23:01:06 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15FMsm0X084479;
        Tue, 15 Jun 2021 23:01:04 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by userp3030.oracle.com with ESMTP id 396wan3v7f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Jun 2021 23:01:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DNu4aQteUJZ7mpbK3BxIBiXEg5QTpS4SvTRypilsLBXW3CKujJanmM+MuW7HU9Tf08jhiBRgM42OcYYXSCKXiQV1Ih+y5Ttl/DV5CABMKONKmfUaKyPnYvNZ2q4tpq8x9kfZuqLnfznlsi2rg0ermUdz0r/lZm+dMpeRqIMD/buriWYNIDteGChmf/iQW7oufJ5rnRw+FPPu5LsHK0/TBodpUNsZYanwIJaR01lI+0tj4DyjAIcbMseObMGraKeDfmyeDxew6iDoI6w/UsGLfs3N5Fn0BLAtURWf94ILRwmYc+gHs7PXy6qP+eC6KAg0I11sWMC3lapK7F529bNu+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ecsbeh8KxcKGhnoJ6sMfLrpik6518Z6zbVD4bnx6dI=;
 b=ZzLvR8g5mp8X/3Sd1jEQLSBFcyysWBGSlArA+V/zU4gQL/WqcvMOf4xOyUcy1OZEhhroveX/yk4z0oevj3tUhoP/42isEplwdDsJkAaHgKec9y//NYOzZRS2D5bHzgJW/yUP5JS022XNbvmwyJJ/wwDEEwt2Xnekd4dC/Y49NFhsNEfT2WOzD/RGZ+xECVceid2ofbuHHOUXUzvcDsExQjxEUspa3HnWlAQbxQ3wiBuZlOxtjwIUsM//1U5e0j9l51jhby6Ngi4EKQaLhwP4i8nWw0lTrj6B8SIWJYbY7IAL0/XChbSYxOZ8+hHuPxqEARhGGBtDLZ07Qb5A8Biq+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ecsbeh8KxcKGhnoJ6sMfLrpik6518Z6zbVD4bnx6dI=;
 b=dUixrOI9Mk+ichQ89NaEMyElO2SdxvtA2lTFmU9Z++XRWrh91sNSmZhnjID+Qe0nJ1wcHItMZMrEkj+zYOERZ//EjTiW5tRQegLhlPkmSd5z4AU/ERtosb9XO3vICmQgDKetqzTTS5SHIoAgUHtrHyG8rdytrg0CTnTwmkDSwtg=
Authentication-Results: amazon.com; dkim=none (message not signed)
 header.d=none;amazon.com; dmarc=none action=none header.from=oracle.com;
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by MN2PR10MB4334.namprd10.prod.outlook.com (2603:10b6:208:1d9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.25; Tue, 15 Jun
 2021 23:00:59 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::d875:3dd7:c053:6582]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::d875:3dd7:c053:6582%7]) with mapi id 15.20.4242.016; Tue, 15 Jun 2021
 23:00:59 +0000
Subject: Re: [PATCH v2 3/3] mm: hugetlb: introduce
 CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mike.kravetz@oracle.com, chenhuang5@huawei.com,
        akpm@linux-foundation.org, osalvador@suse.de, mhocko@suse.com,
        song.bao.hua@hisilicon.com, david@redhat.com, corbet@lwn.net,
        bodeddub@amazon.com
References: <20210612094555.71344-1-songmuchun@bytedance.com>
 <20210612094555.71344-4-songmuchun@bytedance.com>
From:   Joao Martins <joao.m.martins@oracle.com>
Message-ID: <3fffaa5e-246e-00bf-5972-54eeb6330a43@oracle.com>
Date:   Wed, 16 Jun 2021 00:00:52 +0100
In-Reply-To: <20210612094555.71344-4-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: PR3P191CA0058.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:102:55::33) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.67] (94.61.1.144) by PR3P191CA0058.EURP191.PROD.OUTLOOK.COM (2603:10a6:102:55::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22 via Frontend Transport; Tue, 15 Jun 2021 23:00:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13f1895a-4bd1-4bd4-5b50-08d9305170a1
X-MS-TrafficTypeDiagnostic: MN2PR10MB4334:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR10MB4334CE46A99A334C18D86284BB309@MN2PR10MB4334.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lZx+cUw6ydy+TmjNg3BcM4pQs0ooxheKYzyvv+Bv+j1rDpyjMYYN+0bLJ9BB3m363K/2mvg3cRb1l2Dm8Nww1yZBtlj0fyMHjGv22Ww6/4qeufSOBS2nIMLQDgR4JLPj3jHsW9xznbDD+fcHw8/RRfDEUsYD/sO20mUyAwFekJmGaQPEsYhIY5Yofk19FgJ/GtcGBZc6usJ5jmPta2PCvXWicLKAoV7+CA6ZhpVy0UStsRzzdPM8N/7lc84CJ8FuYqyvO3/QgLMEG9glHFDFkXHX4CCBmJHeO4eIi7ep9YNT/RfBsN/qLgh/rivMnQj3jJ0V+xNkI7zH8auONP6UzL0owFsSnzqbOOW/xgyAjjt05AT0s60U7y+KVBP0NWxRRoF8w8VCrlA1MDg16C3iWSL8aNkm4ez3+EJiBmhJmcwgoC6Ta39LTptXEKKLQLpDcANq2oOYokKloRtgvjo7I/71Khahz1WevT5nogRp75WKT0v6uNIUJ45dnsWgy9EmpvXwxAiewbDhNDFwSBx9I8lZAYV9o9LLLvpeW1zDILYHbs9e+tJcR76Ncz1exNGAxvoM7B11MchxNYz2hJSC9rjVUFn4EYm+6fj4+IbtqKoYmsuYAhWS5++ew/2JP13KrydrWKQozBi02pYCveXQDVPY0qrxmJJeseaBZz1gRoX5aC3sj9sdkFdzmInaEYfL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB4835.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(376002)(346002)(39860400002)(366004)(8936002)(956004)(6666004)(7416002)(86362001)(2616005)(5660300002)(16576012)(31686004)(6916009)(6486002)(36756003)(83380400001)(38100700002)(478600001)(4326008)(26005)(8676002)(186003)(16526019)(53546011)(66946007)(66476007)(66556008)(2906002)(316002)(31696002)(3714002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHp3cU5IYjdCSUNrVE1wNVgrNHN2aXdaQVRiUlM0elBqMjY2T2RwMlY5U1N3?=
 =?utf-8?B?ejVQcXVCZC93clBqdkNuUStBRjhCSG1Oa2VuSFZlTDFURWs0RnpjUWNXU3pQ?=
 =?utf-8?B?TnpuWVJOOWMvY1ZQMlJOTXFJT0VWWDlpYnhwUHN0WTZ3OVBXMmVUbUJwM3Bl?=
 =?utf-8?B?WWQ1c0NyQnU2ME83REk0Zit3dWVZOEJvV1BNZy9OREpIT2R1dGRWWU5nalRT?=
 =?utf-8?B?TmMvT1VJS0pvY3V6dk9teDZvd3JQWlNrYm01Y2dwemlYUEh1bmVpSXd5emdh?=
 =?utf-8?B?cFByL3N1eE1WNDhLd2t3QTVsZG5qaDdZNlFnSVdMQ2FmcDc3TW5wY0lUSVBL?=
 =?utf-8?B?ZGY3Y3FDQ0hlbitBbWMvOEM3UkI5bUp4SGN0RzJnV3RtVHozakZLeUF3NlZ4?=
 =?utf-8?B?ZjgxV2Q1cHB4dTIvQ2pLZlNkalVvVjRCbkQ5M3Jud0dKOHhrYUJQNCt0YW1h?=
 =?utf-8?B?S1NValVBTmFXTXpiZzFYbVpKR0ZWUU5seXhCUWJ2VGJYcUExQmpCTHVCN2hY?=
 =?utf-8?B?cGgyWjc0NEpKK0FEZ3ppQUM1ekNBQk96NkJRYUd2ek1uZmdldXM4NEVDNXNI?=
 =?utf-8?B?Y2p3bkZXYTI0VmdxRnRhZWNnbjJMRWxlekt6OWwzYkgvMHZjN1g5dERkbEtj?=
 =?utf-8?B?WlIwamkxU1dZcjI0VGwrSFpja0FDUWs1T3g3enM3SWx0TVMvaU9IMXA1M0VQ?=
 =?utf-8?B?UUc5VU5TdFl4MWRhb3VsZWU3eVo5VmIzZWVadEtsekZmYzQ4bzJnWG9tTVov?=
 =?utf-8?B?UW1mbkYxQllnVm1zNER3Y0x5b3dNTFl6UlVsMDRZV2wzZU1CV3F6VTlWdjg5?=
 =?utf-8?B?UEs2WkpHQlRjaTAxL09XV2EwRUpBYjJvQkJZSWs0ZWczb3hsdENiSnJiR21N?=
 =?utf-8?B?am5jTnlxRjNyZnpNbG1ZV0dtWGJnZDhjYWVsNjRMZFNQakp5YmdyczJOeEVh?=
 =?utf-8?B?dWNENWp5SW5iT2tuOFkwc1cxU2MwT3I0ektibnd3bGxOMDhwMnJyRHE3WXcv?=
 =?utf-8?B?L3JyTExiekQ3SmpPRWlqWFo4dVB3MHVTdlRkVkp6UElpZzhKRjZ4ME5oMHl6?=
 =?utf-8?B?UzNHejQwVDA4Y0RvZ2JyUDA1UlMvN3lPRXp0UHkxdkY2VDhJQmFjbWtNR1Uw?=
 =?utf-8?B?cGJvdVVwdFpuQlFmMS8rNmdnRDN4ejExN2VpOVpHV202VFVDc3pYQTRQK1BD?=
 =?utf-8?B?Qmt5Zm9VakZMSXZBa0FCT20xeEpCTWtQNWRHYnI2bXkrNGJJZ0FmSmlQUC9B?=
 =?utf-8?B?OXhMcythWEllMXd5eHNMMDVUOWlnY3ZDbEZqWHV1clFSdkFoMWZyWVZ2WWc0?=
 =?utf-8?B?dzFjWjR1YjQ5aHNBakhqTWRpdEQwSVE1Y0FzdVNXSk85ZVZwQ1BqSDRDR0VP?=
 =?utf-8?B?ZDEzaEc0NGZnZmZDeDV6dTd2dktYaE4xK20xNU1jcXNlNUV0NjRoc1NvUC9R?=
 =?utf-8?B?WDNmUnJlbFpOT2lTUmljWHdwMEJTdHp5L1c1TzZaWUY2WDI5TkFqODJNcWla?=
 =?utf-8?B?NDBoYktDZm5wdGJBOFFYTkRXVk9RNnlVTVpPTk4wZU1Qa0pyK3F4WkhJbXRq?=
 =?utf-8?B?UmpNVUxPQThkTzdoMzB4T2ZreElTaXlCb0dRYnMvTUs0Q1NlUTlnL2pNaHA2?=
 =?utf-8?B?dHN0NWtNQUErbThEcEJEK3dQM2dTUHBYTFZqbEpqR2FTRFhob1FXM29UL0Mx?=
 =?utf-8?B?QWdRRmtaQy9IQXRaYWo1WDBHMFF6N1ZMZFFHQTUyT09WNlJFUEE1NFJqY2xk?=
 =?utf-8?Q?tmRLRhRAZchq419lKg6boJodVBW+Q0tJhpVW5De?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13f1895a-4bd1-4bd4-5b50-08d9305170a1
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 23:00:59.1495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LQzSNUS3e7k8/iQq2uNTgvIByY2UCWh55DPyRUI7lMle2oDfoCJ/N6zBnQVpvIBc7N9lUvhAehvH7fCz3eS86QhbY5Te99v1Vyq56sw32Ug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4334
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10016 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106150141
X-Proofpoint-ORIG-GUID: gLE2qoKCX2aeR0hTEh8mirRH2b3DKHPR
X-Proofpoint-GUID: gLE2qoKCX2aeR0hTEh8mirRH2b3DKHPR
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/12/21 10:45 AM, Muchun Song wrote:
> When using HUGETLB_PAGE_FREE_VMEMMAP, the freeing unused vmemmap pages
> associated with each HugeTLB page is default off. Now the vmemmap is PMD
> mapped. So there is no side effect when this feature is enabled with no
> HugeTLB pages in the system. Someone may want to enable this feature in
> the compiler time instead of using boot command line. So add a config to
> make it default on when someone do not want to enable it via command line.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  3 +++
>  fs/Kconfig                                      | 10 ++++++++++
>  mm/hugetlb_vmemmap.c                            |  6 ++++--
>  3 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index a01aadafee38..8eee439d943c 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1604,6 +1604,9 @@
>  			on:  enable the feature
>  			off: disable the feature
>  
> +			Built with CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON=y,
> +			the default is on.
> +
>  			This is not compatible with memory_hotplug.memmap_on_memory.
>  			If both parameters are enabled, hugetlb_free_vmemmap takes
>  			precedence over memory_hotplug.memmap_on_memory.
> diff --git a/fs/Kconfig b/fs/Kconfig
> index f40b5b98f7ba..e78bc5daf7b0 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -245,6 +245,16 @@ config HUGETLB_PAGE_FREE_VMEMMAP
>  	depends on X86_64
>  	depends on SPARSEMEM_VMEMMAP
>  
Now that you have no longer have the directmap in basepages limitation, I suppose you no
longer need explicit arch support for HUGETLB_PAGE_FREE_VMEMMAP right?

If so, I suppose you might be able to remove the 'depends on X86_64' part and "gain"
ARM64, PPC, etc support.

	Joao
