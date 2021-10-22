Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98BC4437F6F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 22:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234271AbhJVUrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 16:47:23 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:47498 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232750AbhJVUrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 16:47:21 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19MJ9OI9021654;
        Fri, 22 Oct 2021 20:44:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=lRAaWBHIbzwUnKwQgBQzZP7rg/mfjtawk2w0WywZ3tk=;
 b=T2R4ldHHOcmV1wk3rTDQEr1ncmDFNMSco86VbOXYlkryEWe0WtDn1wN3J1Ro3UZKN+P4
 jFeoiMPfJdLJnqz1gXtTa3LJTPktuOa6PtVIOK6k7zQJ067nd5e0Nf4Vvq0gMc1x+m0t
 dDoQGzBXc4LGvOdgvaO3jUylmWxyhSHtPdSaKV0kJ/EA/yEAaCbBnL3RV360wXPbE1so
 k8iRVv59koeFXEKv+d3kU+I1DRs9rZyt8fI7jsjjZlWsLy8lB0wbaHLeDh8f4ykAycSg
 +7MEFNoxYM+MftIPklOj+zwOIfgESywVKy6Hi3iOJUG5Nwh37pHWK7HfLVQX8aKLdxhW rQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3buta8bd9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Oct 2021 20:44:57 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19MKbJ3j035499;
        Fri, 22 Oct 2021 20:44:56 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by aserp3020.oracle.com with ESMTP id 3bqpjb5y3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Oct 2021 20:44:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m5OHv9pU56j30dpIuPwZswPTUH734m2V89cdgEeDFxCiPExn5I0nACx9KQTEHLj64Ee9usO41Fj+atzRyfBn/c+XcWdV/K7leaxT/oAwHT+4Nx2of64d8goW1qNuLoO18aqD/eFTstPD2HGd2l9dPQlfw5/OSd0VuK2JlcObT4drC8DR913UY4QsMMMH7hwl0CM61Pvt31hlm97l8QKuyhGcG+/G7wIuiNl9WyWN2kIjySseGu66mODgvsMf4n5D75ibK0bASEHSY1BmmLwuzvCmXUJiZILdE4Nf7ZrqLv03tvMPK1y7mXH1O5OR5y4E14J4UVE/tneEJa8BdyAquQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lRAaWBHIbzwUnKwQgBQzZP7rg/mfjtawk2w0WywZ3tk=;
 b=Mfw2q1hKMRAZCKYOXCqUJvncdcKicL7UJ9+G49Lzdk4x+lbG0Lb+9n4AtVcwdRNSQE5AledV/A+aYrrVX6iqDuTiy05AgwUVKhMmi2JaUTErjefstb9lRdUNJrDRgFNb9SEF8ZgAUQ/ka/oUmFI2HVWG8+8DFauKGjwSp9GMgwz9FYwXPgl+GLJ5uwrhG5kdkqfpRYwu9TbqWzGQnqICsSWk2yJFhO5H8BX+gf5lIc24JCqM433rikLmq+zW24LRSrilkRk8WrDLJjSqWiMe1l27zrFBxWAIhjmyR5F5++nCxDRDt5+UenVEd+yle/RHs+vCgjBIbgFFpzvulZzCvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lRAaWBHIbzwUnKwQgBQzZP7rg/mfjtawk2w0WywZ3tk=;
 b=Uilbf6mmSdlMgS/WXUm3YqpPzlxvaJykZngJdNxIer0yw3GJbcYN9BAOIMhnpMcKBTLZ/YA4f4ELPc9kL/WURhVqN+ERX7IoP6m+GMvJkRR3AlZzsAoGiuFoDQH61EOwKC+YSbzIO2JW4l45mq6x5Hbxz2y8JFbYRRWjkxWrAJg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3397.namprd10.prod.outlook.com (2603:10b6:a03:154::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Fri, 22 Oct
 2021 20:44:54 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bc59:71de:1590:cbf5]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bc59:71de:1590:cbf5%6]) with mapi id 15.20.4608.018; Fri, 22 Oct 2021
 20:44:54 +0000
Subject: Re: [PATCH 2/4] hugetlb: Replace the obsolete
 hugetlb_instantiation_mutex in the comments
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        akpm@linux-foundation.org
Cc:     mhocko@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1634797639.git.baolin.wang@linux.alibaba.com>
 <4b3febeae37455ff7b74aa0aad16cc6909cf0926.1634797639.git.baolin.wang@linux.alibaba.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <9fe106cc-29da-c243-41ea-a703747a9011@oracle.com>
Date:   Fri, 22 Oct 2021 13:44:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <4b3febeae37455ff7b74aa0aad16cc6909cf0926.1634797639.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR17CA0054.namprd17.prod.outlook.com
 (2603:10b6:300:93::16) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from [192.168.2.123] (50.38.35.18) by MWHPR17CA0054.namprd17.prod.outlook.com (2603:10b6:300:93::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend Transport; Fri, 22 Oct 2021 20:44:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c904fb78-84d3-4e11-8c05-08d9959ccd47
X-MS-TrafficTypeDiagnostic: BYAPR10MB3397:
X-Microsoft-Antispam-PRVS: <BYAPR10MB3397C9F90FA5B5A712788928E2809@BYAPR10MB3397.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:425;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yI2OFFwUfv2q6WUI1xJWAUC5uTKIlvC/9dX5lGGn/m6nj+hKcNRCd+ap4qBSco7s2wAxbV64+29QZMg9dRsHmpJo2bnlMQX4OaYcEmdqxc4oSt6N9sgCdU34kcEx/MkF9tjywmK4aqAV+JhZhUP5vOOzmT4kWZJvbuV9s2pcGucP7sGfkDEOdhXzbFjKE76iMeRvvqaI2cN8qwLAVffzDI41l02NnXnSpFLRThyUlB4YZuKr0jkYcQUCWBqurAobRDplTmlNAIFtyEoI0JgFy4qwzJQzRiYf2VU42Sxua1lsvV6ZovuAsUbOhtHH8JJ/CAqmmkY+/zOYPBjX3fLej5Y4Fsp9w0cuh6wi0zXVvaPHuvR6ow8/n7EpXooJNs+UCvOM2qqLj+i/Fk1J9FcP9/UpO6fAuXu88CtKLa1OsJ+SlLla1+8wv+Lre9J2tS61DEQqn9+AU/J+UldSmLlO+QnfvZTivmKu/c9aEpNghDeiNqY25HiM8IVSU1yrW5owKlmbDkXA4Ojb52M5Eklij6pbwIP9h/3AWCvqKg2UImDravx3WTaU2AI/ZuLHph2dwin7VDtgqn5VWb5k8YZ9Fl5M2E6kUq2SpdePqJe2gkuVpydRCJmUpPtB8GBgocWDxN2yn03AHxItP54AAcXOiZi368sHXXmNJndzc7gZBd0cKC+8AOJGK718MAEoVlU/UAsfvcKV0LnEQ0uv4DIsR9zEAVpqdXdpCfFfgBdok1Y4ImmWNRGw59IprR5vwXWLvRXkl+jl98pqNZz499s/Ow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(52116002)(31696002)(2906002)(66556008)(38100700002)(5660300002)(316002)(86362001)(38350700002)(36756003)(44832011)(31686004)(53546011)(16576012)(2616005)(4326008)(83380400001)(508600001)(8676002)(186003)(956004)(26005)(8936002)(66476007)(66946007)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UStpbW9VWmhibDkxcDRvanByUEVJbmR0MDJKbldZdENieitJWVZST3lhY3NY?=
 =?utf-8?B?WEVCQU5NQmppa1B1V1k0Rno5Ykt1ajRvTCtVcy91ancwTVhzUStRTTJkQnFw?=
 =?utf-8?B?WGZ6R0EyZUlJaEx3MFhwTHpYRlNKL0ZIdXlBNENZNUJTVlJzMVplb3VvNDhO?=
 =?utf-8?B?NDJ4bEJrYk5EOVp0dGM4RlFaVFUzNHE4UlBTbWY4QzJGRStJcjhjdWppNWFl?=
 =?utf-8?B?aE1yUmRFOVpDYXluMTJXTDl5YWVHenZLZ3g4bnlZMlVUKzdPLzdSYnZvR1hk?=
 =?utf-8?B?WnJOVmMzYnIwLzZCREtBbFFEdzByN0RqQ3NRWkwzdTJIVHo3Q3FUS1U4SDkx?=
 =?utf-8?B?eXU1NWhUMXhKMlJjNGRKYXFQVXdMUEhsU0hkb1JwZUxBS1JFR00yZUxHMENj?=
 =?utf-8?B?dVpvdUVZcnhNWUpCWGQvMUU1MHdZNlk0R2RpWkQzUllzMjJtL05EOG9YQ0tG?=
 =?utf-8?B?WUJhVkhQaWlIZjlnS3pRVDJiZ1A2OW0xME15VkY1bWd6aGhDdmtzSnZ0cVVo?=
 =?utf-8?B?L2NpOGtiR3M3VVRqQTJ4MzVZUklvSFo0REFBek1CSHZmenJaU29CQ0ZPb3Zh?=
 =?utf-8?B?RG1xUWp1K0QxYzcvL2ptdUhRMUVRMFZKY0MwN0N6WmJkSnRVeHV3YkJiZWpG?=
 =?utf-8?B?WkdKWWpqZzQvV2ZuWks3VEt5bUxSMEoxS3c3MU9KNENydTRZZlNtYWpPTWQ2?=
 =?utf-8?B?Z3pKeFpkU3JuTjZMYWhmcFBMOXdVdjAyYXlJWDFHS2wyaDRmeTB0dERUcys3?=
 =?utf-8?B?aGx5Z2Zsb213c3VJeVdtTnZyaytDZ2N5TXd5YlhKeTRaSHlZRTQ4MjR6N1dm?=
 =?utf-8?B?LzVxODhjaU9XUHlvcmt3a2VXbStTVjlML0hHRUo5cHpzbmNlWEkrZ2VYcGk3?=
 =?utf-8?B?NmsvOXlhQ1NISHNJMXZtempoODNSQldadEdLSVRFZmFmc3RqL21icHBhM1BG?=
 =?utf-8?B?UlBwdXpkTTFXRE1FN0ZObEFqN2F0OGc4U3FzTmxGeHF6NG5yK2kzT0lNZktJ?=
 =?utf-8?B?RWZWV0ZYNFFmZjN3ZGs2TllzUXBRTTFYRmpZRktySjk5V0ptays2ZG5UdlN6?=
 =?utf-8?B?TzY0Ylhoc0w2THIycktKRDVmQzhITUphaFcrZGpIRjdDcW83ekoxUkRCY3cz?=
 =?utf-8?B?UmZDR2xPTmZyVzhGRVRUYU51bFRMZXgrUGpCb1I0UjU0MDkrSnVUUEZBOURi?=
 =?utf-8?B?UGs3N0ZidVJ1Q2hoSGpPd3dQT3BXcmZtK2F4UWF5bDhrNE8zbEpDMS93cklT?=
 =?utf-8?B?WThMMkdQSURNbGYzRFJYeHh3Y2puL0JoYVpwTGRrbWQwb09uK1dhaVdROHRz?=
 =?utf-8?B?VVBmRDdheDJSZk9JaU1sUVZVaGhvTFB2Y1RSZ1dLNlkzZy9JZFkvdnlNS1I3?=
 =?utf-8?B?NUk4L1lTZWs5SGJoei80OHZMSTRzbFc0VGs1UDdQbWlxelU3WG13NkljRlhl?=
 =?utf-8?B?ZlI4YTZ1eHkxUW9zWWJaTEhxejJHYnRqdVF3U3FNbTBpcHE4eWZmKy9NNG9P?=
 =?utf-8?B?S2lhMG5HaGFTcG9qR05EQzhRa1ZIR2dBa3pmVVJnZnFUMk13dnJzVUtHNnp6?=
 =?utf-8?B?b3V5SUtIVlZWSXVueU9FTGY0bFYyYlBRRElBdnFiT2lHbVRnWFEwQjhwNXJo?=
 =?utf-8?B?UDJmVVV1cDFCbGhaNmNsVVRTTkdRbVFNcDV3dkxXL3U3aUd6UUlhVnQ1ajBB?=
 =?utf-8?B?dmJDUHZabXc3Qzlyb2UxdTVudG9jVEdodUFDVXI3cVdGWHQ1R242ZHZXQ3Z0?=
 =?utf-8?B?SE8vQ0dBNzVKRkd2ZWhpTDk5SHFoQ3NoRGJxODI4NE1LN2dSMVQyTGtzSW9j?=
 =?utf-8?B?MXZpeXdFQkpPRFRsQmRTT0RnV2JnKzluVm1yczBtdnJkcDdtZmNUM0RYeFdm?=
 =?utf-8?B?eTNnSlFUbG5KTjU3ZkVUR0lWZ0RrZE1vR0JXcHdTRVE3NDU5bWs0TXFHbC9Z?=
 =?utf-8?Q?PIaTd38BWkwrN9hQ89cOyOaORpwg0uCo?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c904fb78-84d3-4e11-8c05-08d9959ccd47
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2021 20:44:54.4017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mike.kravetz@oracle.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3397
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10145 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110220115
X-Proofpoint-GUID: xEka_uy_5aAfuTUJfiZtiN16zz0fwDEA
X-Proofpoint-ORIG-GUID: xEka_uy_5aAfuTUJfiZtiN16zz0fwDEA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/21 11:31 PM, Baolin Wang wrote:
> After commit 8382d914ebf7 ("mm, hugetlb: improve page-fault scalability"),
> the hugetlb_instantiation_mutex lock had been replaced by
> hugetlb_fault_mutex_table to serializes faults on the same logical page.
> Thus update the obsolete hugetlb_instantiation_mutex related comments.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  mm/hugetlb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks!

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz

> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index ee0db48..8902b07 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5012,7 +5012,7 @@ static void unmap_ref_private(struct mm_struct *mm, struct vm_area_struct *vma,
>  
>  /*
>   * Hugetlb_cow() should be called with page lock of the original hugepage held.
> - * Called with hugetlb_instantiation_mutex held and pte_page locked so we
> + * Called with hugetlb_fault_mutex_table held and pte_page locked so we
>   * cannot race with other handlers or page migration.
>   * Keep the pte_same checks anyway to make transition from the mutex easier.
>   */
> 
