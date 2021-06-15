Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4B8D3A8BDE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 00:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbhFOWdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 18:33:49 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:23246 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229898AbhFOWds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 18:33:48 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15FMBbXa021025;
        Tue, 15 Jun 2021 22:31:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=9pfz219z4ipZ+nVD6eZHtp/jJMCuGcTgLtjSwlrEl2w=;
 b=vz6VlnZ4cjIs8G45gdJULo2xrDpVecjW5tuV/Sn5eoPzMXj/LLtug08WNAVaMJf5E8su
 7aA6mhdtFNFNdko1orH9WMfgytOyXUHBFwaPZLGqjpyQXZvT3Z+AZa0cGsvbNzXjz7hY
 oNrfD0TSrro/YEkWdpZHDWFJBnm99S9QUuN4ig85Vq9UmB28NP6GFhMrcf2QRO2Otsd+
 xn5JqFY4nQyDTrVJxRfbmUhRFHW6mtaUUpECVBHo5rdBEWxRkMQm6Lc+9HQ3dFaBvsuJ
 yCUMjYOSHfToxCWrUU6yCpvacZIEIsdCNkXz9Ai9fM6+yjRV32ehlv6AgxDSQq6eF1b7 lw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 395x9qshxn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Jun 2021 22:31:24 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15FMUmmL010501;
        Tue, 15 Jun 2021 22:31:23 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by userp3030.oracle.com with ESMTP id 396wan31qa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Jun 2021 22:31:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cSMXUPD9YL1XH2bOAt82Nt+pYmq/p0Bfn5HbMwztJmD6A2zKlvgSJe4r0K+P/9+Qxf0kz8KYm7/VNticE2odqyN5ChCbhPPc3N6cqKjUFTpuCwXXK8m22HEDGGTib7CvDqSJkBfuRNrdfFRfXQieYcUyJaFTaqBVec4hfYmtm8wDmuhdYThHNaTLLvhyn+AOkaPnA+8/cfdzna1YnMsEBx2TnzXyQfQP5Yhw89Bf9hzLJfSfbSH86wLa8tBG3QOY3qmoYe5zLXs8HooGqTRy0GJt13bN+f37WSS+BNEk753PDfHvSe1sfS5kZBbtNMfYrRtSNfSgU29EBWgKUzRq4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pfz219z4ipZ+nVD6eZHtp/jJMCuGcTgLtjSwlrEl2w=;
 b=JeBUedFNu6QAVGWlBFxs6rAdcbecTuCS9mIKpsoiT9CHkjFxi0598rRkbAPxMhjGWcpJkg3GpYVWHZNyAg0SGihbarrj7rbp2lO9tsBNwWMbo/kJ2B84RxFFUQ1c+cbrKH6EguU0panX0p4nsCCl+Ao278w8S9wFJxEvKGN2wi82C5ck69KSowH811kG6VM5X3y3lykImyaqzoknpDrki30tZNahcfQl5zDktNuVhbSCMfP2R39IMOv0Nqmru7HBE1hZpyPAXSMesHsS1XBGrUgiO+PsfC7kO8z7OEPbAqHAc+Sa+vDu/BxsBFSll3E/7XpBREHaohHwYiLnWrIhQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pfz219z4ipZ+nVD6eZHtp/jJMCuGcTgLtjSwlrEl2w=;
 b=Pg8sT5eNNe2T82isuBueocygX22HU0ApYEArY3S2g/ak1vN4cCv9jBvm/lAfuqjaCd5LWoMXR6eBqJsSrWs1JjK3VNB57NGOdwrJHOd6NLCQDGYgTi2gJ3bbovzTAe45d6b3DDiDIZgkDyWCEX/VFWB23sXjcRM9Q0/6RgBXGX4=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4179.namprd10.prod.outlook.com (2603:10b6:a03:206::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.24; Tue, 15 Jun
 2021 22:31:17 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::5d11:ae6d:24b6:e838]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::5d11:ae6d:24b6:e838%3]) with mapi id 15.20.4219.025; Tue, 15 Jun 2021
 22:31:17 +0000
Subject: Re: [PATCH v2 1/3] mm: sparsemem: split the huge PMD mapping of
 vmemmap pages
To:     Muchun Song <songmuchun@bytedance.com>, akpm@linux-foundation.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, chenhuang5@huawei.com, bodeddub@amazon.com,
        corbet@lwn.net
Cc:     duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20210612094555.71344-1-songmuchun@bytedance.com>
 <20210612094555.71344-2-songmuchun@bytedance.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <d951d312-cbe8-ceed-6932-ee20de260aeb@oracle.com>
Date:   Tue, 15 Jun 2021 15:31:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210612094555.71344-2-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR03CA0077.namprd03.prod.outlook.com
 (2603:10b6:303:b6::22) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR03CA0077.namprd03.prod.outlook.com (2603:10b6:303:b6::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Tue, 15 Jun 2021 22:31:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5001c0a2-f82a-4e3f-e0b3-08d9304d4aa0
X-MS-TrafficTypeDiagnostic: BY5PR10MB4179:
X-Microsoft-Antispam-PRVS: <BY5PR10MB4179B88CB9ECBB0B8AA14C55E2309@BY5PR10MB4179.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e5SFEzUCCcpnRpgEXNtm8NWGSyaL2/3hYOxAJXayETmCwsn6cftvBnrmFeOs/bnJM5CEL5lchNMHh4mP2DnnGzSbnC2frDK5vo84cJzMFvXgFixIN/GIfK+Havzx/kXUXjOetb4Cg0VmiAED9e1ppk2pKCZENkWTR6Fi9EDKQUnjEnASZspg9pu+iUTEsELSlrTaE3YKm/xo9SobXhIU1nwgTrvQSm0uVQRMOghkOVM1I9jSlv/9OvTW460MbSLPpOXxEn526Iwki4nk2SQV0Nu713RqOqums4TrgbrF5DYSQz4rI7nbDdi74+cwVfoM089f+gEOTGMl7ndFtl+c2ToTDTlhg86ajLg/AVBSTcFCeIP/c6yi5+TMKvDjZLqEFZpNIc2dctj6w+pwdlCFO0Uev5i4tMkqW6M4jkSgIcGtrd98E3ZuBTmKg3h55WBWBW2faFfOXaH5S4r+LxJs+8rrdayp14GmHpKwzPnO+aHx+Hy4xpOks1Et+avCHAsvpjOvj26RwzdLoNDHogdrerxAW8HrvxLN5NvFqchgjTNQd8FGOJrhUWQvxgw/euY09xQ6jdBpLP1Rd/biKz/SAw97TEp8YZqgXKPUj/iwfyveNTBCgBNqLaiLCEIEKnGVggKaWMjddWDm12Jt2iVCKXNUkYewV6+Y370Zd6ESgkqaL8F0WGsYSSTYRRQuA+Bld9U2F60o4qXhFt6S1/UXx2d6+9C/wTc4cEEAmoZtzwKAfS4A3GMqxYSaeq3CVw7XKpP8qJgJWZHN4tHuUOInRrLqS2pBkAiIxWvbEeuvaIihb55AH19cG5LqczXI1/SsLIXSjmFLZFTSxyW4GqnOp1JvxrF4XZVfGiliEf/73b0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(36756003)(66556008)(966005)(498600001)(8676002)(2616005)(83380400001)(956004)(44832011)(66476007)(66946007)(31686004)(53546011)(186003)(38350700002)(5660300002)(52116002)(4326008)(16576012)(16526019)(30864003)(2906002)(86362001)(6486002)(38100700002)(31696002)(8936002)(7416002)(14583001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnpTYjhVRCtQWnZGMXhhenZIZEVOdUpPWk1EeHB4bi9lYW9uU2lxejZkTms4?=
 =?utf-8?B?Zy9KWVhSZWR0WGpmejYxQ014R2RGUm1LYytKV1JteGhST0tteFdpWHU5Ui81?=
 =?utf-8?B?MWMrb0ZLYnFXRE95NWpsVkxTanQxUHdlT3oxbW1oUkl6NHZSaStrQjZkc1p1?=
 =?utf-8?B?dGVud3pnYm4wMU5CSEdhN1N6bHJsNDFmRTZiWXpQMmo0VDFHam5xZ3luMFZt?=
 =?utf-8?B?dy9RQmhrZDBhSDJjOGJzQ1gxdHZoUzRTeW5uYXBJQXp5d3lKMzY2MDlSZGRT?=
 =?utf-8?B?VFpYV3pyTnRWdU9nUXpNb3BreTRTZFZjaWh1WTRYMW9QQlYzS3NtYkVpL3gr?=
 =?utf-8?B?U0xRTmw5aXR1bC9LQlR0VEN4aXppOG1lQmt5b2tFSW0wRHZtR3orWkJSNWFV?=
 =?utf-8?B?Wk84VC9McGhqamtYVitBMnY0bk1rdU1ya0ZJTHR0a1hNeGdLNFJJUWNkcFVa?=
 =?utf-8?B?WTBURk14ODJqZVlTQitSR2ZsL0xBODNWQmJRaHFsbnl0TElEaDZrM2E5MkxC?=
 =?utf-8?B?djVXanlIRGhDM1VnMmRuWGJqeHBUcnA5aVIzaE5KMjRDRUxoMVJ0VzhjQ0Rv?=
 =?utf-8?B?SnBGMGs2VG1VUDcrSyswOEV2aTBORlU1eWRocmEzVitoNEs5aUNvRXVJM2Er?=
 =?utf-8?B?U05HUVdhdEVDamJKS2RtTVAvMGZpdTZHTXA5VTBHaUhpWDdXWllVWjlCWDc3?=
 =?utf-8?B?cWN2M01vazNwUjV0UlFpYVI2d0JOaXhCN0NaSzZlb2d2UmVSak9TR3lWa3o2?=
 =?utf-8?B?TklGU3BrMGxnS0psZytzTDdCbzAzQkhmZG0xUzFoWlgyblpPUUZyVExzUWZz?=
 =?utf-8?B?a05RS1RudW9mVU5BbERiVjhOR3NaVTd5ak9wcS9uUDAwL1dyQ0MwODFDbXdo?=
 =?utf-8?B?aTVUUnBTNE5Icko1cEhpdWpvQXFHL01OaEFMdCsrOXJvQWgzbHVsMzZQMkpQ?=
 =?utf-8?B?RmUwUzd6Y2JGcHk3ODNXOHFJZ3Boc2lSTkJKai9NbkFsZDlLNzdaSy9RRHcz?=
 =?utf-8?B?VFROR0g2R0hpNVhMdkRCbEo1RGxOZ3I3WStnOEc2VVprNmZ1MXJyN2Qvaml4?=
 =?utf-8?B?MGJpb3hiU1BDSCtPQjVxWnoxbDFZOUgrMEoxYmhpQ2FBNGhqeU41R29DTUpN?=
 =?utf-8?B?eDNtZk5NbVdUVzkzNXNlejNBUzJoTStoTzZnMDZiTkcvQjFmVDAvTmZTaU92?=
 =?utf-8?B?YmFDM0wyZG16M0pRdll2cEVrMVdORTVScWg2TmJrd0pFVDk5dXU2WXZCdm1n?=
 =?utf-8?B?Z2YvQkhjcHFYaVovUFBibzhpUTcwcWlFOE8vdHRjN1MwajFNUXY0Sy83c1F0?=
 =?utf-8?B?ZUlGWnQ0aE1IUnNYMlZIUGFqUk9UOEJVK2pBbEwvbE1jQ3NtOWsrY1pzeHQv?=
 =?utf-8?B?TXZjbDFuT1QydjhCeTA3d2tEekpkaFlFWE5KKzJkSXV2Uk9oV2U4eVRTZC9q?=
 =?utf-8?B?Vmt2dzNPa0hsL2l1MzUwcDZTcDU2TGNvQ0dCeEY5ZjdwZC82MU40aGRwM1ov?=
 =?utf-8?B?akphU1lldkkrUkI1bjdvQmg4eEd2RXhZclNxUWJKVlQ2UUxMSFZud1c2d2VL?=
 =?utf-8?B?dGF2c3BJOHg4blNtejdJcUFpNXlHZFpsQ3FIY2pvVDYySTA5N1RVcXF6K1ZR?=
 =?utf-8?B?bWlVa056c1lvb1FmcXd0QklKT2pydVZPUktXcStjdC9CeEplbUZlVitZN3dz?=
 =?utf-8?B?UUxuQW0yd0xHWGswbG9ZMmVQTjhET2hyc3o0WnZyY3c0eVJNaTZ3bE9nSUpZ?=
 =?utf-8?Q?6xyGTA0wijA61TIWTbLlYNn9Uw9boN7bwnH0xUr?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5001c0a2-f82a-4e3f-e0b3-08d9304d4aa0
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 22:31:17.5792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W4D3IAC9gGP7XNOdIFb18J/4HtY7qhrHRoQyjaUGhUfosSwS4OZ5ZN0d8vVQNigRVSm3roWqcmGeMn8MCwJPPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4179
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10016 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106150138
X-Proofpoint-ORIG-GUID: 1YI6vJtIhOf1iteX-UYi31I2eSwGQGr-
X-Proofpoint-GUID: 1YI6vJtIhOf1iteX-UYi31I2eSwGQGr-
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/12/21 2:45 AM, Muchun Song wrote:
> Currently, we disable huge PMD mapping of vmemmap pages when that feature
> of "Free some vmemmap pages of HugeTLB pages" is enabled. If the vmemmap
> is huge PMD mapped when we walk the vmemmap page tables, we split the
> huge PMD firstly and then we move to PTE mappings. When HugeTLB pages are
> freed from the pool we do not attempt coalasce and move back to a PMD
> mapping because it is much more complex.

Possible rewording of commit message:

In [1], PMD mappings of vmemmap pages were disabled if the the feature
hugetlb_free_vmemmap was enabled.  This was done to simplify the initial
implementation of vmmemap freeing for hugetlb pages.  Now, remove this
simplification by allowing PMD mapping and switching to PTE mappings as
needed for allocated hugetlb pages.

When a hugetlb page is allocated, the vmemmap page tables are walked to
free vmemmap pages.  During this walk, split huge PMD mappings to PTE
mappings as required.  In the unlikely case PTE pages can not be allocated,
return error(ENOMEM) and do not optimize vmemmap of the hugetlb page.

When HugeTLB pages are freed from the pool, we do not attempt to coalesce
and move back to a PMD mapping because it is much more complex.

[1] https://lkml.kernel.org/r/20210510030027.56044-8-songmuchun@bytedance.com

> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  include/linux/mm.h   |   4 +-
>  mm/hugetlb_vmemmap.c |   5 +-
>  mm/sparse-vmemmap.c  | 157 ++++++++++++++++++++++++++++++++++++++-------------
>  3 files changed, 123 insertions(+), 43 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index cadc8cc2c715..8284e8ed30c9 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3055,8 +3055,8 @@ static inline void print_vma_addr(char *prefix, unsigned long rip)
>  }
>  #endif
>  
> -void vmemmap_remap_free(unsigned long start, unsigned long end,
> -			unsigned long reuse);
> +int vmemmap_remap_free(unsigned long start, unsigned long end,
> +		       unsigned long reuse);
>  int vmemmap_remap_alloc(unsigned long start, unsigned long end,
>  			unsigned long reuse, gfp_t gfp_mask);
>  
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index f9f9bb212319..06802056f296 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -258,9 +258,8 @@ void free_huge_page_vmemmap(struct hstate *h, struct page *head)
>  	 * to the page which @vmemmap_reuse is mapped to, then free the pages
>  	 * which the range [@vmemmap_addr, @vmemmap_end] is mapped to.
>  	 */
> -	vmemmap_remap_free(vmemmap_addr, vmemmap_end, vmemmap_reuse);
> -
> -	SetHPageVmemmapOptimized(head);
> +	if (!vmemmap_remap_free(vmemmap_addr, vmemmap_end, vmemmap_reuse))
> +		SetHPageVmemmapOptimized(head);
>  }
>  
>  void __init hugetlb_vmemmap_init(struct hstate *h)
> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> index 693de0aec7a8..7f73c37f742d 100644
> --- a/mm/sparse-vmemmap.c
> +++ b/mm/sparse-vmemmap.c
> @@ -38,6 +38,7 @@
>   * vmemmap_remap_walk - walk vmemmap page table
>   *
>   * @remap_pte:		called for each lowest-level entry (PTE).
> + * @walked_pte:		the number of walked pte.

Suggest name change to 'nr_walked_pte' or just 'nr_walked'?  walked_pte
could be confused with a pointer to pte.

>   * @reuse_page:		the page which is reused for the tail vmemmap pages.
>   * @reuse_addr:		the virtual address of the @reuse_page page.
>   * @vmemmap_pages:	the list head of the vmemmap pages that can be freed
> @@ -46,11 +47,44 @@
>  struct vmemmap_remap_walk {
>  	void (*remap_pte)(pte_t *pte, unsigned long addr,
>  			  struct vmemmap_remap_walk *walk);
> +	unsigned long walked_pte;
>  	struct page *reuse_page;
>  	unsigned long reuse_addr;
>  	struct list_head *vmemmap_pages;
>  };
>  
> +static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start,
> +				  struct vmemmap_remap_walk *walk)
> +{
> +	pmd_t __pmd;
> +	int i;
> +	unsigned long addr = start;
> +	struct page *page = pmd_page(*pmd);
> +	pte_t *pgtable = pte_alloc_one_kernel(&init_mm);
> +
> +	if (!pgtable)
> +		return -ENOMEM;
> +
> +	pmd_populate_kernel(&init_mm, &__pmd, pgtable);
> +
> +	for (i = 0; i < PMD_SIZE / PAGE_SIZE; i++, addr += PAGE_SIZE) {
> +		pte_t entry, *pte;
> +		pgprot_t pgprot = PAGE_KERNEL;
> +
> +		entry = mk_pte(page + i, pgprot);
> +		pte = pte_offset_kernel(&__pmd, addr);
> +		set_pte_at(&init_mm, addr, pte, entry);
> +	}
> +
> +	/* Make pte visible before pmd. See comment in __pte_alloc(). */
> +	smp_wmb();
> +	pmd_populate_kernel(&init_mm, pmd, pgtable);
> +
> +	flush_tlb_kernel_range(start, start + PMD_SIZE);
> +
> +	return 0;
> +}
> +
>  static void vmemmap_pte_range(pmd_t *pmd, unsigned long addr,
>  			      unsigned long end,
>  			      struct vmemmap_remap_walk *walk)
> @@ -68,59 +102,81 @@ static void vmemmap_pte_range(pmd_t *pmd, unsigned long addr,
>  		 * walking, skip the reuse address range.
>  		 */
>  		addr += PAGE_SIZE;
> +		walk->walked_pte++;
>  		pte++;
>  	}
>  
> -	for (; addr != end; addr += PAGE_SIZE, pte++)
> +	for (; addr != end; addr += PAGE_SIZE, pte++) {
>  		walk->remap_pte(pte, addr, walk);
> +		walk->walked_pte++;
> +	}
>  }
>  
> -static void vmemmap_pmd_range(pud_t *pud, unsigned long addr,
> -			      unsigned long end,
> -			      struct vmemmap_remap_walk *walk)
> +static int vmemmap_pmd_range(pud_t *pud, unsigned long addr,
> +			     unsigned long end,
> +			     struct vmemmap_remap_walk *walk)
>  {
>  	pmd_t *pmd;
>  	unsigned long next;
>  
>  	pmd = pmd_offset(pud, addr);
>  	do {
> -		BUG_ON(pmd_leaf(*pmd));
> +		if (pmd_leaf(*pmd)) {
> +			int ret;
>  
> +			ret = split_vmemmap_huge_pmd(pmd, addr & PMD_MASK, walk);
> +			if (ret)
> +				return ret;
> +		}
>  		next = pmd_addr_end(addr, end);
>  		vmemmap_pte_range(pmd, addr, next, walk);
>  	} while (pmd++, addr = next, addr != end);
> +
> +	return 0;
>  }
>  
> -static void vmemmap_pud_range(p4d_t *p4d, unsigned long addr,
> -			      unsigned long end,
> -			      struct vmemmap_remap_walk *walk)
> +static int vmemmap_pud_range(p4d_t *p4d, unsigned long addr,
> +			     unsigned long end,
> +			     struct vmemmap_remap_walk *walk)
>  {
>  	pud_t *pud;
>  	unsigned long next;
>  
>  	pud = pud_offset(p4d, addr);
>  	do {
> +		int ret;
> +
>  		next = pud_addr_end(addr, end);
> -		vmemmap_pmd_range(pud, addr, next, walk);
> +		ret = vmemmap_pmd_range(pud, addr, next, walk);
> +		if (ret)
> +			return ret;
>  	} while (pud++, addr = next, addr != end);
> +
> +	return 0;
>  }
>  
> -static void vmemmap_p4d_range(pgd_t *pgd, unsigned long addr,
> -			      unsigned long end,
> -			      struct vmemmap_remap_walk *walk)
> +static int vmemmap_p4d_range(pgd_t *pgd, unsigned long addr,
> +			     unsigned long end,
> +			     struct vmemmap_remap_walk *walk)
>  {
>  	p4d_t *p4d;
>  	unsigned long next;
>  
>  	p4d = p4d_offset(pgd, addr);
>  	do {
> +		int ret;
> +
>  		next = p4d_addr_end(addr, end);
> -		vmemmap_pud_range(p4d, addr, next, walk);
> +		ret = vmemmap_pud_range(p4d, addr, next, walk);
> +		if (ret)
> +			return ret;
>  	} while (p4d++, addr = next, addr != end);
> +
> +	return 0;
>  }
>  
> -static void vmemmap_remap_range(unsigned long start, unsigned long end,
> -				struct vmemmap_remap_walk *walk)
> +static int vmemmap_remap_range(unsigned long start, unsigned long end,
> +			       struct vmemmap_remap_walk *walk)
>  {
>  	unsigned long addr = start;
>  	unsigned long next;
> @@ -131,8 +187,12 @@ static void vmemmap_remap_range(unsigned long start, unsigned long end,
>  
>  	pgd = pgd_offset_k(addr);
>  	do {
> +		int ret;
> +
>  		next = pgd_addr_end(addr, end);
> -		vmemmap_p4d_range(pgd, addr, next, walk);
> +		ret = vmemmap_p4d_range(pgd, addr, next, walk);
> +		if (ret)
> +			return ret;
>  	} while (pgd++, addr = next, addr != end);
>  
>  	/*
> @@ -141,6 +201,8 @@ static void vmemmap_remap_range(unsigned long start, unsigned long end,
>  	 * belongs to the range.
>  	 */
>  	flush_tlb_kernel_range(start + PAGE_SIZE, end);
> +
> +	return 0;
>  }
>  
>  /*
> @@ -179,10 +241,27 @@ static void vmemmap_remap_pte(pte_t *pte, unsigned long addr,
>  	pte_t entry = mk_pte(walk->reuse_page, pgprot);
>  	struct page *page = pte_page(*pte);
>  
> -	list_add(&page->lru, walk->vmemmap_pages);
> +	list_add_tail(&page->lru, walk->vmemmap_pages);
>  	set_pte_at(&init_mm, addr, pte, entry);
>  }
>  
> +static void vmemmap_restore_pte(pte_t *pte, unsigned long addr,
> +				struct vmemmap_remap_walk *walk)
> +{
> +	pgprot_t pgprot = PAGE_KERNEL;
> +	struct page *page;
> +	void *to;
> +
> +	BUG_ON(pte_page(*pte) != walk->reuse_page);
> +
> +	page = list_first_entry(walk->vmemmap_pages, struct page, lru);
> +	list_del(&page->lru);
> +	to = page_to_virt(page);
> +	copy_page(to, (void *)walk->reuse_addr);
> +
> +	set_pte_at(&init_mm, addr, pte, mk_pte(page, pgprot));
> +}
> +
>  /**
>   * vmemmap_remap_free - remap the vmemmap virtual address range [@start, @end)
>   *			to the page which @reuse is mapped to, then free vmemmap
> @@ -193,12 +272,12 @@ static void vmemmap_remap_pte(pte_t *pte, unsigned long addr,
>   *		remap.
>   * @reuse:	reuse address.
>   *
> - * Note: This function depends on vmemmap being base page mapped. Please make
> - * sure that we disable PMD mapping of vmemmap pages when calling this function.
> + * Return: %0 on success, negative error code otherwise.
>   */
> -void vmemmap_remap_free(unsigned long start, unsigned long end,
> -			unsigned long reuse)
> +int vmemmap_remap_free(unsigned long start, unsigned long end,
> +		       unsigned long reuse)
>  {
> +	int ret;
>  	LIST_HEAD(vmemmap_pages);
>  	struct vmemmap_remap_walk walk = {
>  		.remap_pte	= vmemmap_remap_pte,
> @@ -221,25 +300,25 @@ void vmemmap_remap_free(unsigned long start, unsigned long end,
>  	 */
>  	BUG_ON(start - reuse != PAGE_SIZE);
>  
> -	vmemmap_remap_range(reuse, end, &walk);
> -	free_vmemmap_page_list(&vmemmap_pages);
> -}
> +	mmap_write_lock(&init_mm);
> +	ret = vmemmap_remap_range(reuse, end, &walk);
> +	mmap_write_downgrade(&init_mm);
>  
> -static void vmemmap_restore_pte(pte_t *pte, unsigned long addr,
> -				struct vmemmap_remap_walk *walk)
> -{
> -	pgprot_t pgprot = PAGE_KERNEL;
> -	struct page *page;
> -	void *to;
> +	if (ret && walk.walked_pte) {
> +		end = reuse + walk.walked_pte * PAGE_SIZE;

Might be good to have a comment saying:

		/*
		 * vmemmap_pages contains pages from the previous
		 * vmemmap_remap_range call which failed.  These
		 * are pages which were removed from the vmemmap.
		 * They will be restored in the following call.
		 */

Code looks good and I like that changes were mostly isolated to
sparse-vmemmap.c.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

It still would be good if someone else takes a look at these changes.
-- 
Mike Kravetz

> +		walk = (struct vmemmap_remap_walk) {
> +			.remap_pte	= vmemmap_restore_pte,
> +			.reuse_addr	= reuse,
> +			.vmemmap_pages	= &vmemmap_pages,
> +		};
>  
> -	BUG_ON(pte_page(*pte) != walk->reuse_page);
> +		vmemmap_remap_range(reuse, end, &walk);
> +	}
> +	mmap_read_unlock(&init_mm);
>  
> -	page = list_first_entry(walk->vmemmap_pages, struct page, lru);
> -	list_del(&page->lru);
> -	to = page_to_virt(page);
> -	copy_page(to, (void *)walk->reuse_addr);
> +	free_vmemmap_page_list(&vmemmap_pages);
>  
> -	set_pte_at(&init_mm, addr, pte, mk_pte(page, pgprot));
> +	return ret;
>  }
>  
>  static int alloc_vmemmap_page_list(unsigned long start, unsigned long end,
> @@ -273,6 +352,8 @@ static int alloc_vmemmap_page_list(unsigned long start, unsigned long end,
>   *		remap.
>   * @reuse:	reuse address.
>   * @gpf_mask:	GFP flag for allocating vmemmap pages.
> + *
> + * Return: %0 on success, negative error code otherwise.
>   */
>  int vmemmap_remap_alloc(unsigned long start, unsigned long end,
>  			unsigned long reuse, gfp_t gfp_mask)
> @@ -287,12 +368,12 @@ int vmemmap_remap_alloc(unsigned long start, unsigned long end,
>  	/* See the comment in the vmemmap_remap_free(). */
>  	BUG_ON(start - reuse != PAGE_SIZE);
>  
> -	might_sleep_if(gfpflags_allow_blocking(gfp_mask));
> -
>  	if (alloc_vmemmap_page_list(start, end, gfp_mask, &vmemmap_pages))
>  		return -ENOMEM;
>  
> +	mmap_read_lock(&init_mm);
>  	vmemmap_remap_range(reuse, end, &walk);
> +	mmap_read_unlock(&init_mm);
>  
>  	return 0;
>  }
> 
