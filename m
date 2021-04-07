Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6014735617A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 04:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348131AbhDGCu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 22:50:28 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:41832 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236291AbhDGCu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 22:50:26 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1372nd7e098211;
        Wed, 7 Apr 2021 02:50:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=SIJ+USGUKZoAj0ZMCvyKG57uiLgwkl7/kKnpPc3RVOA=;
 b=BAbz2nQSldQZPYfscRUjq6D+daA/p4isZMMtz5FmBwTJn/MzakTDkPA05QZ/59tPbwFW
 sNaVT2Zmw0CyuXpU8PuYuE5kc+EZXF25xjnHIzJeU9zuThwezezCOEhn0YBqOR9lB/zL
 9CfbD1DC+uO3LY7yu2CRP4OmK87QaszlJ2uc1TBZ9kDM0BMhhzfn7bNoe1H8oiiaN2Js
 hO7kq477fX41cigEYds9zWyNqYna+g5GmPIjnzI4ieaTuFVk9koaQohR5cpllBhMx314
 ey/6lnfWDJCz7fvTVnPt6VxmQ7ZYxkpL59+VYgvqhwzFYJVkDDV7Cjm1bRuFF43EDzFb LQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 37rvaw0ywv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Apr 2021 02:50:04 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1372nt31193488;
        Wed, 7 Apr 2021 02:50:03 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by userp3030.oracle.com with ESMTP id 37rvbdfbyc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Apr 2021 02:50:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G9Hkx37l1q+rehg8QKoHGNUDMeDPd3Nmw42rYouJopBcty3f2XIUx01545FxsrP0Uf0c47FU/CfHYax6TdLRwpEp8pOMrmNLv54Pd1O8rc57u3LiYjw86mrexyylUbpykBtOxN0aco0pQoFhqlsmyA7NVBWtSe7PObeG4CUcZkkZPMm2cZKcGmNBREWf54qlw4dxE8G93UT4PKavKKN/5YN3cYAgUXGz44knGEpGQskRIhH7WghQr4AwCRwX65AgJAqBSmA8Sme3ZkA8OfJHkTflWITGYrI6CP0QD2mN/me/4VzE3/kljRsKW5dlQX61MHa7KW19/0ZiVLp4tN8Mug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIJ+USGUKZoAj0ZMCvyKG57uiLgwkl7/kKnpPc3RVOA=;
 b=jHcgGHU9P2WZlt+x2MMFhK7kpvXfWMpo1T6h8CVG6UrDH99eDGYCR9UN7JdVXDsBVreS2lhgnqtuEtvAM99y312abnVKMDdvy9zCegDxfFwZ2GbhOhymNyoR/4/w/+GMbbgjSePL8EldMLZMU/ISa1XkQJdYXS3daw0BANlRQfNBumooF5EB44z5lBXiKRoCHNeR6X9r/JC5hmxYJZ2kEUdrMgAKOtAJO2/DVdrblg0UlHe7dBtziW58sOkMbKKgAtS73k1e/TLKKVXEdXnmE21anQvYyykItMoY7TaezNAxj1zOLRKhsF/b25Ixjw2zIi6QDpDIqd1x/XTvvW8YUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIJ+USGUKZoAj0ZMCvyKG57uiLgwkl7/kKnpPc3RVOA=;
 b=cBNCZXooX9Iw62Id+ptCMpJ6avtLmjNZlnjdRWmr10BqcLNbUxrIT9tbYTzWELGUqqJ+bcEmtVoOQZaqA3/wE0phPn03ushNxe6djhjXGxCrABxReFQCttS/ZMJTwD3yifOysxNDIeqqvI3ZE2NZANb1h3voXhqz95JeNcFtJSk=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4736.namprd10.prod.outlook.com (2603:10b6:a03:2d6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16; Wed, 7 Apr
 2021 02:50:00 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%6]) with mapi id 15.20.3999.032; Wed, 7 Apr 2021
 02:50:00 +0000
Subject: Re: [PATCH 3/4] mm/hugeltb: fix potential wrong gbl_reserve value for
 hugetlb_acct_memory()
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     n-horiguchi@ah.jp.nec.com, hillf.zj@alibaba-inc.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20210402093249.25137-1-linmiaohe@huawei.com>
 <20210402093249.25137-4-linmiaohe@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <20afccd5-2bc4-9db9-695e-dd6175b0b42b@oracle.com>
Date:   Tue, 6 Apr 2021 19:49:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210402093249.25137-4-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR20CA0029.namprd20.prod.outlook.com
 (2603:10b6:300:ed::15) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR20CA0029.namprd20.prod.outlook.com (2603:10b6:300:ed::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Wed, 7 Apr 2021 02:50:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2bc55332-25f4-4949-790b-08d8f96fd671
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4736:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4736873E42C9A15F729D07DDE2759@SJ0PR10MB4736.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ev/QXEda6eBU6D1JLVS5+OuTIRzKuzn2aNqd7COi7KalcFFmiR2Y5pdsr2muck+NygEvR8OH5b17kje/xYWAfLx7huvh7YWhEYwGmP9JR+SEz6RU/spwudiafz1EuMpIlZK/qLql5tSD0KdpccI+5BMUCR2y6lgkWf5EqCNAOkJKjPqQYDsIKh5szIZ4rgXOQ1FtsEE+YVeATYU6kSKftt9qhhT/xXXlSl8Fl/AJYtJWtdnRzsm2dNsRWxnLZRdMV8a4xmxMy80ph5QzGmwE8mcJ1dP+816sFAjoO1kVoWK1awP0BQwCLsJZ/b/089kpTAqgn18a2NXH0YcdDGLgfbxWp1n7dMdIwTNZh/SMv9xbsAFNsvmRU+/vCY+Lz+vO6Avi2AZPNNiLn5twrsnu5Z5COfDQXdEL4G1cPmy2+8Pl//LZdtC3nZu3QC8v6cGD0LT4TJ4KUlyIUaQeN7p9vICysvIBN5stKtVve7XR/c8RFrXiNoAnmasLVns5k8wTHoLgp0bajf1kc5G6pXyUSe0cyCdCqNjtxHaV8NOo6Wpr8nCBr+F6NID8/vk0x163hzyZa1Co8/IaZtesOlRFRtNbh8NHZBxAjMuKkuQdGUURNGgRq1H8ygc3LlsL0Zr8c4xXDwiLcmb1RKbso4zRKQz97K+wLNugG44ti4BWC0pHSR+DGgDjLoMJx5nxn3Mh6IDTgvHe9/iciiF02qefp1EU/7/8banl4NeDmrRR4cEEC6iGPg1yKiGAi0vDNsAs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39850400004)(366004)(376002)(136003)(346002)(396003)(16526019)(36756003)(6486002)(26005)(186003)(5660300002)(2906002)(31696002)(478600001)(86362001)(31686004)(2616005)(44832011)(53546011)(4326008)(38350700001)(956004)(8936002)(66556008)(66476007)(66946007)(316002)(52116002)(16576012)(83380400001)(8676002)(38100700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WTlrZW1UNTJBT00vY0x0R25YVm9kazNOWWkrMUpBbFQ4OFRhd0tpWWF1SE9l?=
 =?utf-8?B?REVWYjFBSWtKaTU4cGU2NFc5Vk9BUUhMU1cvb1M5TXVtak5tRk9xYmZLamhx?=
 =?utf-8?B?RkFUZWU1TkQzUTdjTUQwU3cvQ3RPM203UTN1NWdSMmpiNHM5WXNnY0xCY1ZU?=
 =?utf-8?B?T0R0ZVFXQk5ZR25CRWpGaWdkdUk0S2RCM1krQTJSRHNkUXJhVWdsTHRxbjZP?=
 =?utf-8?B?cG45cjAvQlg3cGpBTm1Ka0tUeFVqcUZkVnNZNGNtNWhKK0M3ZURuTEdYSGdx?=
 =?utf-8?B?djVPSUdqNDBTMG0zRXlRejVmZGFvamo5dllGSnN4clRUYkV2b2Q0RTRlUENh?=
 =?utf-8?B?RUh0dmwxM1gwd3BkdWw5Wk9TK29xcS9IeWFFL3JYRnpYVTJsSUFKOUY0QlFB?=
 =?utf-8?B?Sk0wSmZ0MFdBcUZ6dnl1Rm01b3JKMld6cmlnejA5OXNaaXpaY25XM0FVTDZV?=
 =?utf-8?B?NE9RQSs3UG9TUlM5cG1JK2hpZG5UK0x1V0NqVVNndTRwOGR6MGRDOWFxc09y?=
 =?utf-8?B?Z1ZNQmhZL1lYbXdEZmM0SUEyT01VbWREOFVtTnl6Sm1vUmNGMTBTUGw3eFRw?=
 =?utf-8?B?NHFpY2xxRHZhVWV3djJRdzNpZzJlOHhIa1BHTVFXZUxkVTJLeElFTWtaaVhN?=
 =?utf-8?B?b2NqUEptYWdST1lFUzVtS1lGTURSR05uamhYMFVqVjFpRWw3WE1DcGxMeTgr?=
 =?utf-8?B?cDlEMXA1OW1NOGhzU0FrQzkxYkVHbkd3bVJGZE42eTduK0NZeHlKR0x1YnQ5?=
 =?utf-8?B?ZDhJc0dLTFM2WDUwOFFXRGhkNE1HdkxSNWN3RE8yUU9NRnl3aGNvVFY4aXln?=
 =?utf-8?B?QVI3TlIzQXFUQk5lT0s0YklFQ25lVGlEL1BwNENGd2ZSRStiRmswMXRzdlpy?=
 =?utf-8?B?RmU2YTRwbWdrMUpnSWRNaTdtRWJSbkU3ZFBiN2xvWmMwclpzaGE1a0R4Z1Ju?=
 =?utf-8?B?cWExMU1HRE44SEVsKzNZUnMvNW00YWlvYXFCTG9WdUhFeDBtZHlZTEQyVC9T?=
 =?utf-8?B?QmxRK21wMC9GUEtDbEg1VXZMYjlHblZpdTgvYnF4L2xOV0ZUaDZJUEJ4VFJx?=
 =?utf-8?B?QXQ0eTFWRWJWZFVsYmxaamlqU1B3WGhTWlE0RnZ1Rm9SbHpGelJ3OXFNSFRK?=
 =?utf-8?B?QjZYbE95MDhqWUNTcXVZNFdjWUxCRmxDK3RxSzg4MXc2bVVzU2xYR3B2ZW5Y?=
 =?utf-8?B?U1MwaWNMcFlmWllFaEc4TW5Pa3FPZDBNY2cyaVpOaUhZVHpmZ0oxdU9zTG45?=
 =?utf-8?B?YmZJNTNHWmNUU050allEM29vb2VKSXpSZHRycWYrTjJvWnFKNkVWbzVRNUh4?=
 =?utf-8?B?UUJ1UnJsUGZLdDl6RVVmdkhnSlg5ejNPRjc0a0ZiLytkUllCenJNRWI1NGJl?=
 =?utf-8?B?YXhHVDdSRUJwK2hUdGJLakdPZWYxbi9kcStxcm1SMGZlOUJ6eS9ncnpmd0d5?=
 =?utf-8?B?QlM0THlObHVHYk5Lak5XL3kwcTlKZGVVeDRnUlVWcW4vOTNSdXNHcUoxNnY2?=
 =?utf-8?B?UUk3Q1grR1hsNGoycGJiOS9aemdrbmprU3lhSzBqN2tCTjA4L2U5Y1BMbVdS?=
 =?utf-8?B?QVV0dE9CdWcvTFlweUg5ZGxoM2FCcTUyVS9wMFQxWW5ac29SQURjUEVVS1RS?=
 =?utf-8?B?VC9QZkZpcXNVQlZzVXNwSUp6aWgxK3BibStLYk1rVnVuQWQyU1lWV08vWlF0?=
 =?utf-8?B?ejQ1NDBCY0dsT2dVY1BuK1FQcU84Q2RPbjBidjFmSHdibmNkRkJqL25hTnhO?=
 =?utf-8?Q?y3soSDtyD6T610ckfiLcO4DCGfy59G1cvJd6rbM?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bc55332-25f4-4949-790b-08d8f96fd671
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 02:50:00.8447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CfRv+tmnmcb96OA7u0Oalf91tkfFeV9DKf3mGTK61lRsyY6LrDUfaXxxFKvDGRwrLYFitK89D7aDjMnDameW5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4736
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9946 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104070020
X-Proofpoint-ORIG-GUID: 9ysq0ZlMopfz-Hgiqul1-J8Nsj9rwbH6
X-Proofpoint-GUID: 9ysq0ZlMopfz-Hgiqul1-J8Nsj9rwbH6
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9946 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 impostorscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104070020
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/2/21 2:32 AM, Miaohe Lin wrote:
> The resv_map could be NULL since this routine can be called in the evict
> inode path for all hugetlbfs inodes. So we could have chg = 0 and this
> would result in a negative value when chg - freed. This is unexpected for
> hugepage_subpool_put_pages() and hugetlb_acct_memory().

I am not sure if this is possible.

It is true that resv_map could be NULL.  However, I believe resv map
can only be NULL for inodes that are not regular or link inodes.  This
is the inode creation code in hugetlbfs_get_inode().

       /*
         * Reserve maps are only needed for inodes that can have associated
         * page allocations.
         */
        if (S_ISREG(mode) || S_ISLNK(mode)) {
                resv_map = resv_map_alloc();
                if (!resv_map)
                        return NULL;
        }

If resv_map is NULL, then no hugetlb pages can be allocated/associated
with the file.  As a result, remove_inode_hugepages will never find any
huge pages associated with the inode and the passed value 'freed' will
always be zero.

Does that sound correct?

-- 
Mike Kravetz

> 
> Fixes: b5cec28d36f5 ("hugetlbfs: truncate_hugepages() takes a range of pages")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/hugetlb.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index b7864abded3d..bdff8d23803f 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5413,6 +5413,7 @@ long hugetlb_unreserve_pages(struct inode *inode, long start, long end,
>  	long chg = 0;
>  	struct hugepage_subpool *spool = subpool_inode(inode);
>  	long gbl_reserve;
> +	long delta;
>  
>  	/*
>  	 * Since this routine can be called in the evict inode path for all
> @@ -5437,7 +5438,8 @@ long hugetlb_unreserve_pages(struct inode *inode, long start, long end,
>  	 * If the subpool has a minimum size, the number of global
>  	 * reservations to be released may be adjusted.
>  	 */
> -	gbl_reserve = hugepage_subpool_put_pages(spool, (chg - freed));
> +	delta = chg > 0 ? chg - freed : freed;
> +	gbl_reserve = hugepage_subpool_put_pages(spool, delta);
>  	hugetlb_acct_memory(h, -gbl_reserve);
>  
>  	return 0;
> 
