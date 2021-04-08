Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E743F35904B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 01:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbhDHX0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 19:26:01 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57900 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbhDHXZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 19:25:59 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 138NJYMs146588;
        Thu, 8 Apr 2021 23:25:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=XV69ZtraBkOTt2JqqlpMTN3/UfE55yVB98mhEpzmne4=;
 b=l0PIu70WNaoBQdDYkk5o22GnDO6mxkQutirBD3OJKF1x0uFxNU2t96Qhlj2dgBvy+apB
 rGcwchdFIqURv3SBvY6lsk7XqGoC9I52DOlBeEB/V/JlwrvXbwwSiX+wTyid7nfmZCIZ
 FSsIInA1JuZ57lS1aO5sNvsw1RN4UdKMk7MD9B3CchCHjGrHW0xS4krkSmP238z0TEt1
 oS4/vPMSs++6Tw0VwpCTDAz5TWTxzaALEaTL+693cc8UjMwy1KuTqYehXpNjF7T1yTY4
 1MypnFXLZ+8wI5YyuGGYj2BUnZrBR0Ax5o3we8vbz/oyXdqRFQIhWglHVR/BqcwG81QB AA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 37rva67knc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Apr 2021 23:25:36 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 138NK30o119699;
        Thu, 8 Apr 2021 23:25:35 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by userp3030.oracle.com with ESMTP id 37rvbgabwg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Apr 2021 23:25:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HEDqe/dwfZ2RGz/amwR4K70gF8Q1lHS2Afh7xF03rU9+gUPFs6Qy3UosJxQb0adL/7n4bHuJ/zK7aOnJL8lDr9hwY2+kyT0VaFfE1JAv8l7UlfOs+ghthqCaGiCjolG/sAxHC79Gbo4IYRgYWMiPuT6plFPwrG+6bqHjd8CcJctvrohEvDqTel/3Onzu/UquPpzoGX1fxFPUehFMrl20ADzHCsw05HrAVbZfqHI639pYYiACYvTXWCAF/BNNWshSTUgORivVFSxCtskKLAW6y024+yLUbWRzuS3A+pkszlA4eowRdnDai0W9rJjAkDyQpPe+yylfP1E8m7AHagr21w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XV69ZtraBkOTt2JqqlpMTN3/UfE55yVB98mhEpzmne4=;
 b=Ax9JBDF7f/fvGFn+cd/l7ZkXcYU1ITQ7mKBthoRPf7NNOFuCV/E+5mhNdVbnchUNCK3+hJ467SVsTumbynhZ5GT0GirwNT8DQ3pwWybYpBP7Ai89xDuXw1Z5m5/532K9SFVu+5xRs140oL//CKjmDUTI3lQpyM7hlq9y467s0aXqOvuz7fIum/E19mhuXoYcBTJ0dvYnki+Cyv0LLiKItUuRM5sLOEtW/hKwMxA07a882hRTUhTA8n4+PYdf2RSLk0A2Evmws/0KdEvxr/FZPoMA7xMkk8lyVK/NiSpeNy6YBm93ben+2n8hXgqE3rtcabFT6U4Uxmq5kbsPhM8DEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XV69ZtraBkOTt2JqqlpMTN3/UfE55yVB98mhEpzmne4=;
 b=ihI6+hMVGg1FPm10xfkkwO9HF7jfVkr4yRjuaVIbGU672Kw446rWIl0Yn4+pD/vml/q+d9CdfUx8h3xyx4iHYJafs3wnNvcIc7VDfhXoDhuazXQgoAGGrnJ2F+K9Ine+2n/ohH0nS7j467HwtjEOKlf4vbupzchhWqZGM1HlW6U=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4355.namprd10.prod.outlook.com (2603:10b6:a03:20a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Thu, 8 Apr
 2021 23:25:33 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%7]) with mapi id 15.20.4020.018; Thu, 8 Apr 2021
 23:25:33 +0000
Subject: Re: [PATCH 4/4] mm/hugeltb: handle the error case in
 hugetlb_fix_reserve_counts()
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     n-horiguchi@ah.jp.nec.com, hillf.zj@alibaba-inc.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20210402093249.25137-1-linmiaohe@huawei.com>
 <20210402093249.25137-5-linmiaohe@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <a61335c2-c6ab-6169-012c-5b5d2d9499da@oracle.com>
Date:   Thu, 8 Apr 2021 16:25:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210402093249.25137-5-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW3PR06CA0009.namprd06.prod.outlook.com
 (2603:10b6:303:2a::14) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW3PR06CA0009.namprd06.prod.outlook.com (2603:10b6:303:2a::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21 via Frontend Transport; Thu, 8 Apr 2021 23:25:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05896217-59b2-49ed-0de5-08d8fae59b30
X-MS-TrafficTypeDiagnostic: BY5PR10MB4355:
X-Microsoft-Antispam-PRVS: <BY5PR10MB43559664DB472E214E226299E2749@BY5PR10MB4355.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FCFMJ7/4djvvlhoLBXjmKIHrqCfYz8T9k6W/Omzej3gAP5qobH0vypQSRhWdY30m/MdSMIJBVjharYu+1XuuDEY7oN6+ryK9h8gnmkIM/bK3+PN7wSTmkY6QVaprOvk5XtfkPlIDiuk8znYqAT2Y9G3UJED1gOevXM8GQFZXukw+T7kNqGVoc9MxeHDgd/3CwQ8hwNYXVXOMhlxly3lbZXtMgqSlKwxci064mnTDQejvZfmEq4RbSXJ1uBN+dRgPoMUY5TOxLwr3fvaYz1MGNeBVBmIJIE20mQTI9VeSeUpb/6RLiQAEnvWwIb4tPjtgrV7jAQNu1mPk7GCSa4n/gXuZqXQZyYojEpnrU4O8/wzedvrz6NNDKEvvlKvPJkweEAk/e2RFs+V4UU5uTic2Es6vJHmWtyaAY6+WZS0mP77j4BQEasLXXCQoGmorC2xbOXIUVjyBTKHMAroEMd4jvWSi7vZzPpYpslH86K6IACJrFCIvFrWBp1mseJ3Q+TDdDeyU/YBQW7Iepv+cIC1VH8CN3RJJJDy3GKtZljYNEKmRfYgujmPq65U1kkmCI1ilKDcqwRs6uB1XjJiUf0xO7oToFA7DwCpTpV/6nw5YB99LxCbJO7z7N677b5B0zVNTSW/vaibrcetGPQGemGhzpAe/60DwHNq8ftrRXZzuD6rVJ7a8mb5JMA43UWtHHzLVOY9mGlVBT/xux3jV4nMvPGyTE7tR7hnCujLJQ5Ax6X7W9PxGbB7L7WUfeK7wP/03
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(376002)(366004)(346002)(136003)(478600001)(186003)(86362001)(31686004)(16526019)(66946007)(31696002)(66476007)(6486002)(38100700001)(36756003)(2906002)(38350700001)(66556008)(44832011)(8936002)(316002)(16576012)(2616005)(53546011)(26005)(8676002)(4326008)(5660300002)(83380400001)(52116002)(956004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZCtqci9vczlEdG5aM2hvbzQzUDQ1em55M0VqWjFFZlAzeDI4dXROVjVudk11?=
 =?utf-8?B?c29Kd2wyVmpON1dZd3dLVmFSUzZUdXdlRmh3NjNCNGV2ZUpKcEdJVzhyeVBi?=
 =?utf-8?B?Z0lLdWJRcUFGUHVYeHhTUXdNMnNBUGdaWExaL0cxWDdRbCtBV1FXQlNkajZR?=
 =?utf-8?B?WjNySHRiclJUMm9XM1VhY0s4d1l6YlNnVUdXdE5ZZUpJNlExTmN0RkExYnFY?=
 =?utf-8?B?eWJxL3JZeTJWUkNtb2J4STQ2UU5hZEVtUWNVMGNIODZFTEdsclU0ajJ3WmhJ?=
 =?utf-8?B?aFkxbHpwcWltRWNHWm5FR015ZFZIbGo2anYwTjJxODRHMU8xY1BMUTZwcUNV?=
 =?utf-8?B?QkJYRjFGQjlkSWE3ckhqY1lVZk9oT1B1TXdTTUNnd0lSWE5jQjJNVlliZTR3?=
 =?utf-8?B?cW1DZXVTMUQ2cjEvczZjVWtidzhEREdESEhBaWNVOUxDa1o3bkNaSDdLOWw5?=
 =?utf-8?B?ZTlidTJxdUl4K0paa2dPWUtRUUMwY3lSRGMvMjhSdzJ1aUovaWZ6ejNNak1P?=
 =?utf-8?B?bE9QMExndVh0Ym9tYnAreHljTkE5clhjdzBkZjZJMlBSL0c2ciswT0NuZHdB?=
 =?utf-8?B?QkZPSUlmcS9Wc05yRHBaU1JUZ2pRdGRqMFZBL3g5eWszdmdoZkdLTWo1VkNW?=
 =?utf-8?B?d3oxMkdHOGFxNEZZaUtBY1FqUloxeVN4N3p4S1BiWStqUWRwZFdzbEQvNk9u?=
 =?utf-8?B?ZUw5c3d6ZHZ2R1BPVDlXcFNQSXBydlFWVEZJWjVPeDZueG5xckdOYVhLWlZ5?=
 =?utf-8?B?QTFNN1ZMbHBMVDRTZ3BHbUN5QXpsQmpuN1l1MnlqM0RRejVpeU1VR2xnaERI?=
 =?utf-8?B?RU1EamgvSUZ6U3hYVDBoZG1UT0hkUEpiSHNndUsyUE1rc21QVVRWa2VkcVVq?=
 =?utf-8?B?aXZJWmhPVXVBRWcrTnRVSzM5dkpwUTdrNjE4UDlIQ1ZiRlZQQ0xtK25kVHJ6?=
 =?utf-8?B?SHRpODNUcGtid3hXSU1ZczdHMVBCYkl2amk1c0VWUVFEYzErQ2JrODhraWVs?=
 =?utf-8?B?V0RLUkY1VmhvSDBJL2VaM1BiUmxxOHNRaXdGUmlYMnBYM0xETG5ESUN1T2Fw?=
 =?utf-8?B?Y0hSTVlpZUxwdGJsc0wzSFp5QVR0Q2hsTHgrRDJreGxBSmJxMnNCU25iWlZT?=
 =?utf-8?B?ZGpWRC9oMUVsdk9xUHJRWU9mdGhwVVNmWnUyeVNQSy9aeHcyakNBQjdSc2E3?=
 =?utf-8?B?eGFpbTQ3VlZQWHI0OGZXajNxV0lKYW1RRUVaNkVLSnNHblhXWko2VFcvUDJJ?=
 =?utf-8?B?YXprS0ZsZmhUM01EMWU3QTFDczhENUd6M2RHZEd6OGFzVDhXby8zaHZwandO?=
 =?utf-8?B?WEtSbUozc0ZhcFRmbnc4UFRGVk9BNVc2Y1FsaGZSWEo0aW5NZk1aVzE0Z0V2?=
 =?utf-8?B?dTlRbUJOQy9XL3lJMVNDMWJNcTNYRGU2MXpiZmRwbWlCNnk5L3I5aEJnbHd1?=
 =?utf-8?B?UERReEVKSkEzV0ZxTTFHNC9yUnFVa3BHdUJMZzBvK3oyR2UrTVJJYzlFT2Rt?=
 =?utf-8?B?Rk9DYjJvZHM4eGZXclZBWk93Y1U3MW91R2ZPdnNhUjNrbno4SkpscUFtWDJh?=
 =?utf-8?B?VkZ4TFJ2d2xaZzVDcWVUbDl1bFd3UEl4WTF5cEh0bEtONHovM1BHaXRkQjJt?=
 =?utf-8?B?WGRNZkdTTW10RVNIaHFxREI5dEpST3Nmc0hITnVXOWIzcHJ6ekR1aU5kWEtW?=
 =?utf-8?B?RDY0VTNKQThkVFd5dUxFcFZtVkI4SDlWYjRRdloxcVI2eHhrRmZ1N3hFR3Vt?=
 =?utf-8?Q?w4NXJUivgnkqLXG11umMtUu3TOd0L0VaM9597pW?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05896217-59b2-49ed-0de5-08d8fae59b30
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 23:25:33.2725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aWl+SUsN75qRz6prUAlOrE90hbacDJClIZJAOnwRsV1ThfInKkictq2BoQV7uU8nhkXtUdWJ8NMfZv2wRP+ieg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4355
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9948 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104080155
X-Proofpoint-GUID: UHdry9v-DQeVOn6v0FaEihhOs2KZnFt5
X-Proofpoint-ORIG-GUID: UHdry9v-DQeVOn6v0FaEihhOs2KZnFt5
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9948 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104080155
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/2/21 2:32 AM, Miaohe Lin wrote:
> A rare out of memory error would prevent removal of the reserve map region
> for a page. hugetlb_fix_reserve_counts() handles this rare case to avoid
> dangling with incorrect counts. Unfortunately, hugepage_subpool_get_pages
> and hugetlb_acct_memory could possibly fail too. We should correctly handle
> these cases.

Yes, this is a potential issue.

The 'good news' is that hugetlb_fix_reserve_counts() is unlikely to ever
be called.  To do so would imply we could not allocate a region entry
which is only 6 words in size.  We also keep a 'cache' of entries so we
may not even need to allocate.

But, as mentioned it is a potential issue.

> Fixes: b5cec28d36f5 ("hugetlbfs: truncate_hugepages() takes a range of pages")

This is likely going to make this get picked by by stable releases.
That is unfortunate as mentioned above this is mostly theoretical.

> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/hugetlb.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index bdff8d23803f..ca5464ed04b7 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -745,13 +745,20 @@ void hugetlb_fix_reserve_counts(struct inode *inode)
>  {
>  	struct hugepage_subpool *spool = subpool_inode(inode);
>  	long rsv_adjust;
> +	bool reserved = false;
>  
>  	rsv_adjust = hugepage_subpool_get_pages(spool, 1);
> -	if (rsv_adjust) {
> +	if (rsv_adjust > 0) {
>  		struct hstate *h = hstate_inode(inode);
>  
> -		hugetlb_acct_memory(h, 1);
> +		if (!hugetlb_acct_memory(h, 1))
> +			reserved = true;
> +	} else if (!rsv_adjust) {
> +		reserved = true;
>  	}
> +
> +	if (!reserved)
> +		pr_warn("hugetlb: fix reserve count failed\n");

We should expand this warning message a bit to indicate what this may
mean to the user.  Add something like"
	"Huge Page Reserved count may go negative".
-- 
Mike Kravetz
