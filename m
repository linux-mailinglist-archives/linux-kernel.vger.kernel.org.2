Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 274E033976F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 20:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233914AbhCLTcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 14:32:09 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:48540 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233940AbhCLTcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 14:32:07 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12CJOcok119704;
        Fri, 12 Mar 2021 19:30:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=XiSuSVylX3nAXHUv2HaPV2MVQo+uIjeNb3xewz660XA=;
 b=IpRyK9QUBbUTiqLOLDgSmN10NRHPHo533cbTZqWkWveEeHcuUpW8BU3YLVb558mbxy0K
 RXT3kQtxO4NDnwfTdcj8otUGMtivn05cBEASSv6DNxCFc74WI0aj+2AHB5IOxcNq0Qbt
 PbxCOTKDJHAgPiuAIkJm2Zbo7RCv3MgpqcUMVLmjWTg8RgaGi4/i08NkoTdQdo0iYdmW
 bkpYI4F7PtdAzz1WjY2t6mJOuigGpA63vLGB0Fl00m06S2JYxLCd8Waq3WA3+issGVC1
 PSp5TFXWFzGOJlGhaKuSfGFlUA6ATIE2ajD8gCE3PEoExOBz3TS720GM2PE4nwB4deOH WQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 37415rjw3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Mar 2021 19:30:57 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12CJPQZ1056606;
        Fri, 12 Mar 2021 19:30:56 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by userp3020.oracle.com with ESMTP id 378cexekr4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Mar 2021 19:30:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQ9urwbTfN1dGdDnDaSXOWN1vL2RDKSlIQCBbh35DPYQk3p080GqidLjbhoK/BBJd/cSGPZZ65Jct9NBxNSvV82UkNahMH9s78Hv/6E7gkLsMLZFgYD9T5oKaFcCpe/n4ee4nQQ5y0NQUzMJZO3vivykefppdobhFT+jVBsBzsZKYY8gfN1RuqZA6Ftb2i7GVxagiYPjT5yljZZQX8VWQa0FuEhV+Yck2FI43vRdy2B2Ag7l+6v/E/heksje+Ng0AqjczMyAwgkdfq2jKd/szWnaixzslWn5SqE6WkcOnqaaP07+KTZuaVi5r8A/6qEbBBVLqwKmNzTSZubHCRQ8jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XiSuSVylX3nAXHUv2HaPV2MVQo+uIjeNb3xewz660XA=;
 b=Cj/HVZeisNbC9UOYOpL7YoB/phJEuKRDVCPRsMS+So6sJuViMvGLFbJgOWF5UN2Z9udeuuI6GTJ53bpKDUvSnYTLfwfAVf0RASW5QacLxApDk5G7JFn65405Z3l2MPLbAjhgdavd99/+upxB6BzJVqc0wcklkTnQmdf6yqwkJ2TWwHKhK3FpRhAcvUB6vZGecx1sNDGGP017n/A7dFqGn2er/fHViXECpmY+I0ql7uVdbs2dptRZen1GfmnRpzNml4c7YI26LkRoLhHsMHporZMMA2zZiJpsVWcDZ5/SbazIG9GKHBZ8YCYLLugKKuKx8+NVV5SlXJuX22nWHPD6LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XiSuSVylX3nAXHUv2HaPV2MVQo+uIjeNb3xewz660XA=;
 b=IpOcMDrd0RR/XLkTmIzouweRzxmcpIAaNJGtOG+sKduM9DtuFvoV+cLqbg9wjHVPgH+TJr2YpZuM7VHnAg5RWDkZHkicApbyKT8IjaiCGtz/UujnyrNEkoMyVnoRxcwyBpy9K2jJ1j/EaWAHpUn63SkNALynxHNbMTjdHr07818=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4353.namprd10.prod.outlook.com (2603:10b6:a03:201::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Fri, 12 Mar
 2021 19:09:16 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%8]) with mapi id 15.20.3933.031; Fri, 12 Mar 2021
 19:09:15 +0000
Subject: Re: [PATCH v2] hugetlb_cgroup: fix imbalanced css_get and css_put
 pair for shared mappings
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     almasrymina@google.com, rientjes@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210301120540.37076-1-linmiaohe@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <771ee69e-61d9-b1c9-b72d-3a50d2cbe4de@oracle.com>
Date:   Fri, 12 Mar 2021 11:09:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210301120540.37076-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR20CA0013.namprd20.prod.outlook.com
 (2603:10b6:300:13d::23) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR20CA0013.namprd20.prod.outlook.com (2603:10b6:300:13d::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Fri, 12 Mar 2021 19:09:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ebdd2665-bfce-4ab0-db2c-08d8e58a5461
X-MS-TrafficTypeDiagnostic: BY5PR10MB4353:
X-Microsoft-Antispam-PRVS: <BY5PR10MB4353556B14A9C2FE98826BFAE26F9@BY5PR10MB4353.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PopIWtuPGtA1UDQ55Tac/Q/R/zhbkq0HvwzaXePHlQu2MJ4NZSglYre74M4AsCwvSBoRDnwOEMegrT6J4Z/+rSRe2Vfz5f6DoeWn0iTjdqNRxH0TDU7WeE2tgzU6M7rMJ3rj1lGqb9mK0vWCEzHUXjh2gwJFjEyiXTQ6dymVsu+cBlNafhjxU5x2DqnPa5Xwte2g/3b+WNjMMUTve1cl1yVJ4+oG7YftMJ4M8f4AocZneWpykjac4ZlITr+n3JTLroCvbCiM7w/XYkYyeilXxZXXhPzHRYxVo8U3P6oe3eNoMEPd1oyicKcDk5AyS9wshiCkUlKBalqHtI4NENUJvmfBMkRIT9NF3syyLcT7JsTOtKEXFum3l9RIOjS0kSkCJ5ZY2BmbAxwlcn7yTunNTX8eQvt45dE/MBuCvvPDGzlh83gaE3rdvKpZ7eb8+tZyLtWonDD5fbcHvlRprbMAcLs9dm2CaKdgfde1zTnAC8FCZf3XO7P2oPskO0/UMavgFXskY/eR1tyVv/GMG9VNcjvBn+Lt62gSDoaecXBvin1IZPcQOHulkMgLsEY9V/Pmc130hImobZ8PxlVjOIGR3HGxJ4PkA5yQaoS3B0xekWqIB86xTQNKlyN0miYb8zqV7FhhgvCqko6FuKN8xYsOKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(366004)(136003)(376002)(346002)(66946007)(44832011)(8936002)(5660300002)(66476007)(16576012)(66556008)(4326008)(83380400001)(53546011)(6486002)(52116002)(8676002)(86362001)(2616005)(26005)(186003)(16526019)(36756003)(478600001)(31696002)(956004)(2906002)(31686004)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dkZEUy9SRnY1MFpuVHBOaHR0eTNxNXYyQkw5cFd6UTY3ZDBIL2pZVnpGUDk1?=
 =?utf-8?B?emtmTDFmTTdLbFNRRUtuZ09jTWdGeWxoTlhvN1orazR2RUZqeERTY2NYOVBK?=
 =?utf-8?B?c3J5ZGluZ3BhWDNBaG9OQ1piREFTRmZsaUl2TUNzK1FIcUkzYzVENmNJNmdF?=
 =?utf-8?B?a2tjNC9LYTdKckR3bnVTR0YyNUttcmtIWlFPYW1URTE5cDFJbEdnTTNiejJO?=
 =?utf-8?B?NXJNZHRHajJuZThsQ01EOTJyVzlrRlF2WFZ4YjJNakxGMVVuZjRFU25NUnFj?=
 =?utf-8?B?SXd5WDhaTThDdTd6OU1JeFhHTGpBVDNTNVlOeUNwVTV0Qm5tSVpLeEpXZ2Q0?=
 =?utf-8?B?OTJaZmlqMEZud3AxcEpJMFR6V1dwakhRU1Bwc25WK1BEYnhtaXVGbzMxZVhu?=
 =?utf-8?B?OUVxdm4rNnEydUJMbWhhRllXcHhsQXR1UkUzMXloSGp5NmNxSnVRcHBCeG5W?=
 =?utf-8?B?VG92Q3hhTGxYc0VJNTR3Z3RibGsvUjdYK1d3ampqRXhmSzMwZEppUzA1RlhM?=
 =?utf-8?B?MWlNNm85dGpyeGNpeEFzNm1TZVNjVXQ2UkZZd0QwaVZQR1pLdjM3dWs1cDJE?=
 =?utf-8?B?cnlOYVFMYldNOXZLZlJoYTlTRlVjUVhFMzM0VnFqWHA0MFdWQ0duREF4dUxH?=
 =?utf-8?B?NExwZWJON05iRjc5OXdOTGFMVzgzZC8zUFlyaTR0V1FqVkgrVVJPWVZ5bmVy?=
 =?utf-8?B?NEJVR1NxWkk4SG40NVNPQ21kM0ZpS3k4cFB3djZSbmttVmJleXJiYkgrdmxZ?=
 =?utf-8?B?aHNPQThPeGpQQ1NGaVRPMDFjWWxqdG1LRFNuU1FLZHVkTVVXRU5SZmdYTmZi?=
 =?utf-8?B?dFBVUXBqU1FjKzhtNUMxV001WGtGTVhXUUM5eC9XOTBibjJKS2d0b2tYdlRN?=
 =?utf-8?B?LzhhLzBHZk1hUkVUNE5EaUFabkQyaEpMTTJnMlYzM0NOVzB6NHJPSnJVV2dB?=
 =?utf-8?B?V3lRUm1nOUlJMjJaR0wyeEhEZE51K0dFVXRodTlmWVhJN1A1WEZDOGZwdXZI?=
 =?utf-8?B?bldZS3V6S0ZCYkdMRmdkOHVCZDVUb21XMXc0S2VtZFdjaEU4NnN5aGtoY1hy?=
 =?utf-8?B?YUsrc1cwejNFV3UxcXNJNFhVYVZtMjYwUUNsbW1rZVpZSzJNYS8xVTlNVkIz?=
 =?utf-8?B?L1V0L1RLRDhnN0tDN01kQ3V1NWJyYW9vbDlDUEowWUduNFBCZk5nUlhMaXlG?=
 =?utf-8?B?RGdvb3FVRE4vK0tZcUpadDJ2Y3k5dlFEVk9aYjlWN3A1KzBERTlCN05ZMFRU?=
 =?utf-8?B?RXhxN2NTRWFVbURrbEpWQzVmQnV4Z0c2WGNjSC9VbGkvdHdzeStGaDZPM3Z0?=
 =?utf-8?B?eWVlUVBLMmIvdk1ReHNzY2Q2bHY4T3AyZHVLUU41ZVpJUFViTTBqVVNYTUFn?=
 =?utf-8?B?VHg5OENranZsN1NFbXZIbXRFM0JFR1dWS1pySVhlcHJESWdKNmJlWFhMdTRQ?=
 =?utf-8?B?VndudVY1ZitBb1VRcWhFRW5YNERTUkJnNlY5TWlYTEFOMXlHSTQ1SHhPTG5W?=
 =?utf-8?B?TzVOZHVpQjBORVZGSnJ2Q2lDcWx1YloxWE1PYXEvMXBQR25ROVUxWndVQVZX?=
 =?utf-8?B?ZWpMMTNYcTQzV2xZalI4bk9nUmxhbi9KMWpNMUIwbFJkVWVoamhod20wSk1N?=
 =?utf-8?B?RDNDUHV0QWlEUG84K0E3RktQT2FtZ2VzNk9oODBzVGFtS0xQSVFDWkVOYURz?=
 =?utf-8?B?d1FGeFBEaUlkU3ZxNWN3bDlTQ2JUS2FZUHVVN1VFdmFuT04zSjJvbzVhRUpE?=
 =?utf-8?Q?eUQNt0e1Kn2hqNiPKj6zEz1rH7HLh/pMczkRcXB?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebdd2665-bfce-4ab0-db2c-08d8e58a5461
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 19:09:15.9042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pSDlaWQooZ/AsvDwQ5or90trR6KoZuEEyQXOtMRu7TTZ5Sbv/Eq4fQCkhvoD3wIh9Fz9MM2w60EcGNuMiMziPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4353
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9921 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103120142
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9921 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 adultscore=0
 phishscore=0 spamscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103120142
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/21 4:05 AM, Miaohe Lin wrote:
> The current implementation of hugetlb_cgroup for shared mappings could have
> different behavior. Consider the following two scenarios:
> 
> 1.Assume initial css reference count of hugetlb_cgroup is 1:
>   1.1 Call hugetlb_reserve_pages with from = 1, to = 2. So css reference
> count is 2 associated with 1 file_region.
>   1.2 Call hugetlb_reserve_pages with from = 2, to = 3. So css reference
> count is 3 associated with 2 file_region.
>   1.3 coalesce_file_region will coalesce these two file_regions into one.
> So css reference count is 3 associated with 1 file_region now.
> 
> 2.Assume initial css reference count of hugetlb_cgroup is 1 again:
>   2.1 Call hugetlb_reserve_pages with from = 1, to = 3. So css reference
> count is 2 associated with 1 file_region.
> 
> Therefore, we might have one file_region while holding one or more css
> reference counts. This inconsistency could lead to imbalanced css_get()
> and css_put() pair. If we do css_put one by one (i.g. hole punch case),
> scenario 2 would put one more css reference. If we do css_put all together
> (i.g. truncate case), scenario 1 will leak one css reference.
> 
> The imbalanced css_get() and css_put() pair would result in a non-zero
> reference when we try to destroy the hugetlb cgroup. The hugetlb cgroup
> directory is removed __but__ associated resource is not freed. This might
> result in OOM or can not create a new hugetlb cgroup in a busy workload
> ultimately.
> 
> In order to fix this, we have to make sure that one file_region must hold
> and only hold one css reference. So in coalesce_file_region case, we should

I think this would sound/read better if stated as:
... one file_region must hold exactly one css reference ...

This phrase is repeated in comments throughout the patch.

> release one css reference before coalescence. Also only put css reference
> when the entire file_region is removed.
> 
> The last thing to note is that the caller of region_add() will only hold
> one reference to h_cg->css for the whole contiguous reservation region.
> But this area might be scattered when there are already some file_regions
> reside in it. As a result, many file_regions may share only one h_cg->css
> reference. In order to ensure that one file_region must hold and only hold
> one h_cg->css reference, we should do css_get() for each file_region and
> release the reference held by caller when they are done.

Thanks for adding this to the commit message.

> 
> Fixes: 075a61d07a8e ("hugetlb_cgroup: add accounting for shared mappings")
> Reported-by: kernel test robot <lkp@intel.com> (auto build test ERROR)
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> Cc: stable@kernel.org
> ---
> v1->v2:
> 	Fix auto build test ERROR when CGROUP_HUGETLB is disabled.
> ---
>  include/linux/hugetlb_cgroup.h | 15 ++++++++++--
>  mm/hugetlb.c                   | 42 ++++++++++++++++++++++++++++++----
>  mm/hugetlb_cgroup.c            | 11 +++++++--
>  3 files changed, 60 insertions(+), 8 deletions(-)

Just a few minor nits below, all in comments.  It is not required, but
would be nice to update these.  Code looks good.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

> 
> diff --git a/include/linux/hugetlb_cgroup.h b/include/linux/hugetlb_cgroup.h
> index 2ad6e92f124a..0bff345c4bc6 100644
> --- a/include/linux/hugetlb_cgroup.h
> +++ b/include/linux/hugetlb_cgroup.h
> @@ -113,6 +113,11 @@ static inline bool hugetlb_cgroup_disabled(void)
>  	return !cgroup_subsys_enabled(hugetlb_cgrp_subsys);
>  }
>  
> +static inline void hugetlb_cgroup_put_rsvd_cgroup(struct hugetlb_cgroup *h_cg)
> +{
> +	css_put(&h_cg->css);
> +}
> +
>  extern int hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
>  					struct hugetlb_cgroup **ptr);
>  extern int hugetlb_cgroup_charge_cgroup_rsvd(int idx, unsigned long nr_pages,
> @@ -138,7 +143,8 @@ extern void hugetlb_cgroup_uncharge_counter(struct resv_map *resv,
>  
>  extern void hugetlb_cgroup_uncharge_file_region(struct resv_map *resv,
>  						struct file_region *rg,
> -						unsigned long nr_pages);
> +						unsigned long nr_pages,
> +						bool region_del);
>  
>  extern void hugetlb_cgroup_file_init(void) __init;
>  extern void hugetlb_cgroup_migrate(struct page *oldhpage,
> @@ -147,7 +153,8 @@ extern void hugetlb_cgroup_migrate(struct page *oldhpage,
>  #else
>  static inline void hugetlb_cgroup_uncharge_file_region(struct resv_map *resv,
>  						       struct file_region *rg,
> -						       unsigned long nr_pages)
> +						       unsigned long nr_pages,
> +						       bool region_del)
>  {
>  }
>  
> @@ -185,6 +192,10 @@ static inline bool hugetlb_cgroup_disabled(void)
>  	return true;
>  }
>  
> +static inline void hugetlb_cgroup_put_rsvd_cgroup(struct hugetlb_cgroup *h_cg)
> +{
> +}
> +
>  static inline int hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
>  					       struct hugetlb_cgroup **ptr)
>  {
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 8fb42c6dd74b..87db91dff47f 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -280,6 +280,18 @@ static void record_hugetlb_cgroup_uncharge_info(struct hugetlb_cgroup *h_cg,
>  		nrg->reservation_counter =
>  			&h_cg->rsvd_hugepage[hstate_index(h)];
>  		nrg->css = &h_cg->css;
> +		/*
> +		 * The caller (hugetlb_reserve_pages now) will only hold one

This can be called from other places such as alloc_huge_page.  Correct?
If so, we should drop the mention of hugetlb_reserve_pages.

> +		 * h_cg->css reference for the whole contiguous reservation
> +		 * region. But this area might be scattered when there are
> +		 * already some file_regions reside in it. As a result, many
> +		 * file_regions may share only one h_cg->css reference. In
> +		 * order to ensure that one file_region must hold and only
> +		 * hold one h_cg->css reference, we should do css_get for

... must hold exactly one ...

> +		 * each file_region and leave the reference held by caller
> +		 * untouched.
> +		 */
> +		css_get(&h_cg->css);
>  		if (!resv->pages_per_hpage)
>  			resv->pages_per_hpage = pages_per_huge_page(h);
>  		/* pages_per_hpage should be the same for all entries in
> @@ -293,6 +305,14 @@ static void record_hugetlb_cgroup_uncharge_info(struct hugetlb_cgroup *h_cg,
>  #endif
>  }
>  
> +static void put_uncharge_info(struct file_region *rg)
> +{
> +#ifdef CONFIG_CGROUP_HUGETLB
> +	if (rg->css)
> +		css_put(rg->css);
> +#endif
> +}
> +
>  static bool has_same_uncharge_info(struct file_region *rg,
>  				   struct file_region *org)
>  {
> @@ -316,6 +336,7 @@ static void coalesce_file_region(struct resv_map *resv, struct file_region *rg)
>  		prg->to = rg->to;
>  
>  		list_del(&rg->link);
> +		put_uncharge_info(rg);
>  		kfree(rg);
>  
>  		rg = prg;
> @@ -327,6 +348,7 @@ static void coalesce_file_region(struct resv_map *resv, struct file_region *rg)
>  		nrg->from = rg->from;
>  
>  		list_del(&rg->link);
> +		put_uncharge_info(rg);
>  		kfree(rg);
>  	}
>  }
> @@ -659,7 +681,7 @@ static long region_del(struct resv_map *resv, long f, long t)
>  
>  			del += t - f;
>  			hugetlb_cgroup_uncharge_file_region(
> -				resv, rg, t - f);
> +				resv, rg, t - f, false);
>  
>  			/* New entry for end of split region */
>  			nrg->from = t;
> @@ -680,7 +702,7 @@ static long region_del(struct resv_map *resv, long f, long t)
>  		if (f <= rg->from && t >= rg->to) { /* Remove entire region */
>  			del += rg->to - rg->from;
>  			hugetlb_cgroup_uncharge_file_region(resv, rg,
> -							    rg->to - rg->from);
> +							    rg->to - rg->from, true);
>  			list_del(&rg->link);
>  			kfree(rg);
>  			continue;
> @@ -688,13 +710,13 @@ static long region_del(struct resv_map *resv, long f, long t)
>  
>  		if (f <= rg->from) {	/* Trim beginning of region */
>  			hugetlb_cgroup_uncharge_file_region(resv, rg,
> -							    t - rg->from);
> +							    t - rg->from, false);
>  
>  			del += t - rg->from;
>  			rg->from = t;
>  		} else {		/* Trim end of region */
>  			hugetlb_cgroup_uncharge_file_region(resv, rg,
> -							    rg->to - f);
> +							    rg->to - f, false);
>  
>  			del += rg->to - f;
>  			rg->to = f;
> @@ -5128,6 +5150,10 @@ bool hugetlb_reserve_pages(struct inode *inode,
>  			 */
>  			long rsv_adjust;
>  
> +			/*
> +			 * hugetlb_cgroup_uncharge_cgroup_rsvd() will put the
> +			 * reference to h_cg->css. See comment below for detail.
> +			 */
>  			hugetlb_cgroup_uncharge_cgroup_rsvd(
>  				hstate_index(h),
>  				(chg - add) * pages_per_huge_page(h), h_cg);
> @@ -5135,6 +5161,14 @@ bool hugetlb_reserve_pages(struct inode *inode,
>  			rsv_adjust = hugepage_subpool_put_pages(spool,
>  								chg - add);
>  			hugetlb_acct_memory(h, -rsv_adjust);
> +		} else if (h_cg) {
> +			/*
> +			 * The file_regions will hold their own reference to
> +			 * h_cg->css. So we should release the reference held
> +			 * via hugetlb_cgroup_charge_cgroup_rsvd() when we are
> +			 * done.
> +			 */
> +			hugetlb_cgroup_put_rsvd_cgroup(h_cg);
>  		}
>  	}
>  	return true;
> diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
> index f68b51fcda3d..8668ba87cfe4 100644
> --- a/mm/hugetlb_cgroup.c
> +++ b/mm/hugetlb_cgroup.c
> @@ -391,7 +391,8 @@ void hugetlb_cgroup_uncharge_counter(struct resv_map *resv, unsigned long start,
>  
>  void hugetlb_cgroup_uncharge_file_region(struct resv_map *resv,
>  					 struct file_region *rg,
> -					 unsigned long nr_pages)
> +					 unsigned long nr_pages,
> +					 bool region_del)
>  {
>  	if (hugetlb_cgroup_disabled() || !resv || !rg || !nr_pages)
>  		return;
> @@ -400,7 +401,13 @@ void hugetlb_cgroup_uncharge_file_region(struct resv_map *resv,
>  	    !resv->reservation_counter) {
>  		page_counter_uncharge(rg->reservation_counter,
>  				      nr_pages * resv->pages_per_hpage);
> -		css_put(rg->css);
> +		/*
> +		 * Only do css_put(rg->css) when we delete the entire region
> +		 * because one file_region must hold and only hold one rg->css

... must hold exactly one ...

-- 
Mike Kravetz

> +		 * reference.
> +		 */
> +		if (region_del)
> +			css_put(rg->css);
>  	}
>  }
>  
> 
