Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 227C14380C9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 01:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbhJVX7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 19:59:49 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:25954 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230086AbhJVX7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 19:59:47 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19MNt4iT001637;
        Fri, 22 Oct 2021 23:57:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=mUFaq6yuJWyEHupP1PgDuJMkJGYukjFGWMr98tYxQ54=;
 b=CEoNGsPTidyZKLaXNN6ODnpwi8/7qeBLx5DI4vct9TuapJtT2nIN+pWW/mR3YnURv8uK
 DBWxPUBzZdJZ4d/+26mSqK+c5R3H44jV+vtM6rfF0XEIMyT4TkwRkkC+3YXiCbKE6ONv
 +/91mpiDzZV00qqNflFUrRy9iRZnQjlmj4m8ihj5zFsPE9dpO4eQfw2db0Gtq9u45hqa
 +NI4xo62zE4ZobQxjVQwnzQNs71aWEfJ/UVJRAOY0FMXo9BylPrD5KqeEi9apqGVXNBx
 knPzXgAVgmUh/QIHraMcQfLLKf0AUhy0rGndQ0z8JSmwTci+KbGlbU6d6P99cE/RwI7Z xw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bunf9crm7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Oct 2021 23:57:23 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19MNthuj161698;
        Fri, 22 Oct 2021 23:57:22 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by userp3030.oracle.com with ESMTP id 3bv73f8h17-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Oct 2021 23:57:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lX3NQplAwP//96euwxwLkgWE+C2639J01t1NJ8cd/7PB8Tu1O3kj8LBnqet84d8Ad/vN0j34H96zn1PUCFlwedPZ4K5nsr47WEjTpkMLIAtpwQkfaVs8V3MFncP02ibNkN8nmw0sTc1nnDi299QBVzw8jy1caA1vN5XFb+pkKpp3MLVt0dHHw9lTt9Oo+7dSEPZ9yvu6VD7vecRCbjOJF0RJ9732CyzYEnAoY2oEP3xAI7OmUeCLhvJUyOpJMyW1pdU9TgTQ+1E2560OyCqOEWFECoKj+hScKGBJdH0u9PU9K7C/JXZh4urwOsedCwEBpgzn0Zax0hsDSeHNYEuF0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mUFaq6yuJWyEHupP1PgDuJMkJGYukjFGWMr98tYxQ54=;
 b=W/+3jKm+htGgEzGeWvaPlfAMcCtRuV48LlqJNXmdezebD6I1Bg2J3+TeHSJ08KcVKReHkIrOSpjziJK3mqN1b6MHbSHq9i57fMiDjjaMjZxkTdtXIl/B0QwMWPDq21IY4e1BSaTYp2KS4cK95lZP5+6w0bQrfoOG7NOwM81qKuQgz1x/NSmMwyZ2umEyhX184zlSNva1Iow37fdWniMZamU6NrsxCZT4zm/euCuqnDuYw8OVlhS2lj6RM39Hr/B6ZSNmSNNM/JhcSghXzqmEm3FWNXu0zB9YUhckHTk4xs16tSWgj2aeSO3jCyUxzr/1UvJYfVROq8hawKVgc8WR/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mUFaq6yuJWyEHupP1PgDuJMkJGYukjFGWMr98tYxQ54=;
 b=iN+kJ/d+V/DO7ZLSZs8kj72BbJwEXYee1R+tyy4CfyQJGRRenNkInXrkUQLyed0d/I186cFJ3v1Nul0JDPFdqBZnBZMu79pnENdfzijECl7Qq4RprVsnFILQOYc4aLNQkJCHmxmgfyBQ+35h9ZYErBuLp2LZRJZWzbvFE9VFAFc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2742.namprd10.prod.outlook.com (2603:10b6:a02:b0::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Fri, 22 Oct
 2021 23:57:18 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bc59:71de:1590:cbf5]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bc59:71de:1590:cbf5%6]) with mapi id 15.20.4608.018; Fri, 22 Oct 2021
 23:57:18 +0000
Subject: Re: [PATCH 4/4] hugetlb: Remove redundant VM_BUG_ON() in
 add_reservation_in_range()
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        akpm@linux-foundation.org
Cc:     mhocko@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1634797639.git.baolin.wang@linux.alibaba.com>
 <2b565552f3d06753da1e8dda439c0d96d6d9a5a3.1634797639.git.baolin.wang@linux.alibaba.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <54e7cc45-dc11-b969-98b2-fd0825012426@oracle.com>
Date:   Fri, 22 Oct 2021 16:57:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <2b565552f3d06753da1e8dda439c0d96d6d9a5a3.1634797639.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR04CA0068.namprd04.prod.outlook.com
 (2603:10b6:300:6c::30) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from [192.168.2.123] (50.38.35.18) by MWHPR04CA0068.namprd04.prod.outlook.com (2603:10b6:300:6c::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend Transport; Fri, 22 Oct 2021 23:57:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b7a226e-847a-4a22-bc70-08d995b7adc7
X-MS-TrafficTypeDiagnostic: BYAPR10MB2742:
X-Microsoft-Antispam-PRVS: <BYAPR10MB274238D0F0B68ECF7A6DBED9E2809@BYAPR10MB2742.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ELdV9+mUQQrJ4EYBnLnW2RuqNIJwl5PSWXKfY6U58yTYEKzIVFQSZve9hWdKybsFr0+dvtDmBDORHnUie3mAeBDbas8rDgz4uKD9FKkK2UZScQJ70eFO2MsJcDZz0PS13t0kSyvBTQoF0VSOMJkCZF4MMfYO9sDVZH881JTRkdFq91sNBPoSrkkWqTORBr3drH9RXwgZZB/kMVDgJXWdNYCbRN2wrsM/0wR7XCkzMEbnXcXdNWWDSf73hZmFHAnsP8euX86cYxYy6jtDIp/ifJwTBfVzvMVtiBcPATuQS/zNglCQFCdVjSWWimGmN/Xt11sTiieeW/IFt9DYIh+aUEqSMj27rcP88ee76esi+iZ2Z8imBkSoqLUpKowBcrVX3CuyB9BfoJrch+RtfIAE7aRIIoLrr4BW6DDfo6ROdisPD0ITm4GK8XnOdxrqT/QWxHjy+cmcSWScabrat+jBwN+y8yyDASdWgrWX2I+PsJUBOAecR1oeHxjiB+T4d0YWAXIufUdTlnXgCBbAnxWPsY/tJ5ptqyYVr0U6xfJCx7zxh4u2oPJZO8HyjRZxTz84Ny2vWFn2EJk0ocXmig+aBd1wX8lcCW49bNGiQCFO4zqhPOXuUkyDBA9LSrlFK49XLILzpqVm9zi5kXnuR5tIY/pKHiGL2/fN9RhnrrMHYkLGHx/ryJQW6aiQJqcsEtFmgFOP8hdOM39bbQI+HKExmo0TABF6Mwg0ZfgyUUe/AAfjNtju8xOJVW+Ab/rCNzmWyw1vy8WfU1wf93j5wUJlqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(38100700002)(38350700002)(31686004)(2616005)(4326008)(4744005)(6486002)(52116002)(2906002)(508600001)(26005)(31696002)(316002)(44832011)(956004)(5660300002)(186003)(36756003)(66476007)(83380400001)(8676002)(53546011)(8936002)(66946007)(16576012)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkVmTHRqRkxHVm5ZRnV1MWpRamxUQTRVdjZjL2dFVlY1MGJvVkFWaDJsaXdN?=
 =?utf-8?B?V1JUMmEzc0VmOVZWUThuT0V0NHE1QkFFZktPMnpDcXcwM3ptOGl0UnRVU01T?=
 =?utf-8?B?QlY0ZnhUaDZscUdzRjlNbExqNXJMdVd6bWJISURrRGJISzBQUWI5NGM4a0x4?=
 =?utf-8?B?bmhTV3REWjhVRDQ0b2l3SkxBQXY2VVpTYkNDd0M2T3JQanhMMUFUK1l6NHNO?=
 =?utf-8?B?ZjQ2SWNlWFBlMXRhYnMvR2pLV0o0RHhWblJUYnJxamJpK0pHZU5OaWsrdStI?=
 =?utf-8?B?U1pSVy9XUC9QNzg3SVRqeEhScnhYMVRJN1NmdC9QdEhRbFQ0OGhmTTZwUkw1?=
 =?utf-8?B?MW0vaVlQNm4vNEJ3V1lObWRnUFplb2hEeVJUSjRQNHd3TUwyam5CamdXWlFM?=
 =?utf-8?B?KzRGb2w0VUxRcHcvWnBsVXJqZGhLRzU3M25HQnFvTnRCVlM4dGxMSnhpVVNu?=
 =?utf-8?B?OXZPRFdhWWMzUHRBc3lQaThodUVsT0xWRlM2Y3ByOEpwSlhxK2ZkUEhqR2NF?=
 =?utf-8?B?T3dsS3d6YkE5cVppMGJSZittVnh5ZkdLZHJIbkY5UHJBYjlyeklYaHBWZGhK?=
 =?utf-8?B?R3FlVkxwcFNqYytmbnJoVzNHN3ZadGJ6UFhJaTBacDVaampKSzJQVmIvbnhH?=
 =?utf-8?B?elZ0d1BjTnF6MWRPcG5wSFdNR09aMVA5eTFOWDJYSnV1UlhaZjJhblh3MlVM?=
 =?utf-8?B?RVN4QjBDRm9BK2hSeU55clllL2Y1dnBmUk5kZUcybFFLdU9LNURpRk1BZGp4?=
 =?utf-8?B?M3NXMDZ2OU9TUkhvWVRZbGRLQjF3RlBEUEVwTWxZbktUZVlXQ216Wm10MGNX?=
 =?utf-8?B?L1h4RG14TCtWb2NTcTZvaEFuY1ZSMkVsQjZ0UFpoZFZ0eGl5NTIyTUlwUmhU?=
 =?utf-8?B?MjFPMjNXaUlUS3oxRjkxeFpUVlFVQmh0bHg5R3NMRk1zOEMvUGtoR0F5bWdl?=
 =?utf-8?B?VW0ybDZsR2l5dnJDMU9SckJaVThjMm5iMEp1N1dEVVZ0eHdSdW5xRHc3Zjlt?=
 =?utf-8?B?L1l2dVc2N2tTRjYvTXQwZ2lxdmszSkt2NVlqNE9iem9VM2NwQkhVZ0tJK1RM?=
 =?utf-8?B?Y3VjTkt4ZFJHeFlGNlQ2U1Q0clRjV2dOZ0ZEbmdRUVRNVEdXUnFFekIzdUVJ?=
 =?utf-8?B?YWh5bENrYVRQNWF6ZU1NMzJ4cFFqTThxU21Sci9wT0ZDcWtmWXhuRFRCQ2JX?=
 =?utf-8?B?c21nNUl1eWNmL2taSTR4UlBoanRKOS9CbHg5SklWWm15NE9qTHRBQVRYVnZH?=
 =?utf-8?B?Z1o0emoyN004N0lSRW5TM1AvZnByS29VYktGbW1uSGtMdjk2WDN4WDQ5Z0pa?=
 =?utf-8?B?aVlEV2w1RmErK09OV2FUSFl3UHl6WVJzVmZpa1IydER0dVF0K0JkZ3hCQTM5?=
 =?utf-8?B?T2ZYMmpOWnVPN3dwbHYwY0dRdnV1eWF0MjNEYmlKZnY5SUM2ZFE2c3dJY1dO?=
 =?utf-8?B?RGk5L2RFbGE2VXNqT2NZZitwMk5IQ1ZWZ3ovamJ5b1oxdXQ2UXRWcnE2MnI3?=
 =?utf-8?B?WW1rYU9KVjdsaXlEaXl4UlpGWVZnYkI5aWtmWi9ic01ZM29jbzE2aTJ4Nndi?=
 =?utf-8?B?ck14MzBPU2F0SWJJYWdJUGZBY1pjb3ZaYnkyYzBTTUc1Mkdneno4VzRGbHFU?=
 =?utf-8?B?UTVIVWhkSEFXQUJCKzdtZDJGeEFOa0Z3TktiT3lhaS85bzVhT1VpVzgrMjND?=
 =?utf-8?B?TUtISWt2RFFUT282UjhlM1RLbStqZnVDNFJ4TjNuMDdrWWFjb1o0VE1TdGQz?=
 =?utf-8?B?WUpPdXhHVUlUT2JTM3BuQXFoY1BNbENXdlIxQXhXU2dpVGRHdUZROE92UkJF?=
 =?utf-8?B?VjRhTTY4WTMzYmFzM1NFNDZZQ084MC91bExab2g2NW1WUDQ0SGtuTThaK0ZU?=
 =?utf-8?B?TG1GK09iNDlIOXVFL0EyUGNDZDRtVnVtM05xZjFBQzdacmhXMU5obUR6dTlJ?=
 =?utf-8?Q?kKaaLRD7d1A=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b7a226e-847a-4a22-bc70-08d995b7adc7
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2021 23:57:18.0013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mike.kravetz@oracle.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2742
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10145 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110220136
X-Proofpoint-GUID: GJ_-uToqdpA5LyDnhAVH7tmhZlLXgZQj
X-Proofpoint-ORIG-GUID: GJ_-uToqdpA5LyDnhAVH7tmhZlLXgZQj
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/21 11:31 PM, Baolin Wang wrote:
> When calling hugetlb_resv_map_add(), we've guaranteed that the parameter
> 'to' is always larger than 'from', so it never returns a negative value
> from hugetlb_resv_map_add(). Thus remove the redundant VM_BUG_ON().
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  mm/hugetlb.c | 1 -
>  1 file changed, 1 deletion(-)

Thanks!  You are correct, we could never trigger that VM_BUG_ON.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz

> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 5922629..166cfa1 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -446,7 +446,6 @@ static long add_reservation_in_range(struct resv_map *resv, long f, long t,
>  		add += hugetlb_resv_map_add(resv, rg, last_accounted_offset,
>  					    t, h, h_cg, regions_needed);
>  
> -	VM_BUG_ON(add < 0);
>  	return add;
>  }
>  
> 
