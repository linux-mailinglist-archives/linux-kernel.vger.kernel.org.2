Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B74C53100A3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 00:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhBDX1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 18:27:09 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:60250 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbhBDX07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 18:26:59 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 114NKLxG109342;
        Thu, 4 Feb 2021 23:25:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=2v27m/t29FUJz+r9fTnJFb2JHqbO+feLSPezVLjWQqY=;
 b=S61Q652045FKtOLTqqdiioZ6EUmdSh8U/qt46MkEtEibZsE4hxy5WPfgvAZnEVoZfmfH
 EYIi/xWUg4Ht8f9NmeFr5X6gLTRij4O7/u2iNp0e8/WwFxud0ejlXeuQiNgQrKu1ZqD9
 p8QVlOZUCyRnv+FoZu0ntCR6Qbq7l6IkU7uNfhT3I7V0Wk0t+h71HLA2yZk1MH/vr5c4
 +9ztNlvapEso3LcTEUXsoS2UIkp0MsPT5HO/fWW9WXgFTH4eLeelLKu2YXzRgqFinDLS
 HxTL+10qM23tOfi5gMiXSCTYs3hlFJSy/WMj7evD8796ClJKT3mqbKJzkq6KhuJAO6lU kQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 36cxvradn1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Feb 2021 23:25:41 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 114NGLbx037090;
        Thu, 4 Feb 2021 23:25:41 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by userp3020.oracle.com with ESMTP id 36dh7vvmdd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Feb 2021 23:25:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J6gAcjpN+Sa1T5jEM1Vs86NzSEYLmTxqwNUmnD0DoP/zw4yO/Kxf57UK8FS4ng9blUkyR/4c2vA124RVDRb51OhHj2YtuieIx2oCbOUMP5Xst280OF+gCqXWa4TS0gOvnf1ULQsfWt6xP1K8lneR8ouhMPabjQ/dBMdvGIuW8y3ZeHAoxGRzJTo0DwUo7ado6+SIOlKhKAV2e5OinrHmZydOi+twOrV+UWp6UrNuvoc4yRf7nQtXe7jPLQP+TtHRLADaM2EwGXK+kYaPV/gQe2oJkE8QKJYL+t/8SnxC5ZChCcMphM0dF951CsXOpi+lwIE+CRNvnE3vhfjAw9HBoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2v27m/t29FUJz+r9fTnJFb2JHqbO+feLSPezVLjWQqY=;
 b=RqdewcGLRJT3MmtsP8PFup6IeO4HQMtzgsXSvGOh2o5xMO9ul10WGXmQpqfQPaRTLUkyKELpzCVWJszehKZcX3E+ZqDRoXzy7hT6EQpoQToD2AgEi23Pi3x2XSus0NPWDFnZsLDSZGiMRvZDtW5TujlaVPLOOMB2WmYAHFeaOCXby2+VYX7SFlAJKQ1l9vQ1pEdW2iLmu2vKQlgAld0+FW1P1FfH9ZQavV8oU1736FCAcKQuTj63TA1Jx0SxpoPOtpBJBc1QhAHnufxIj28yMOPDoW97/xNSApJqtQrC0dhl8VHb+yxsu9FM8fuX+Euua07PNcAHAeozx7I/GLQR8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2v27m/t29FUJz+r9fTnJFb2JHqbO+feLSPezVLjWQqY=;
 b=B+/KGMFnYLqhbro4RGsBx165d2GqTnbt02iRrtkFXIH1RzpscrOjkZDHjE3qtkSr42gwTId3fWFFbacyrJ6fQTPbbpzTPtSWqKCtSJJyWoLoD1sbBmZpdtDmfljY9Z6b5Mg4k9jbP4hqqg1nCvgI1blbJ8sRMMLHPcw4/T1UKcE=
Authentication-Results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by MWHPR10MB1808.namprd10.prod.outlook.com (2603:10b6:300:10a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.24; Thu, 4 Feb
 2021 23:25:39 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3825.020; Thu, 4 Feb 2021
 23:25:38 +0000
Subject: Re: [PATCH v2 4/4] hugetlb: Do early cow when page pinned on src mm
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Kirill Shutemov <kirill@shutemov.name>,
        Wei Zhang <wzam@amazon.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Gal Pressman <galpress@amazon.com>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        David Gibson <david@gibson.dropbear.id.au>,
        Christoph Hellwig <hch@lst.de>
References: <20210204145033.136755-1-peterx@redhat.com>
 <20210204145033.136755-5-peterx@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <d45d4ce3-f386-708b-0f7a-4950df6721d9@oracle.com>
Date:   Thu, 4 Feb 2021 15:25:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210204145033.136755-5-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR21CA0037.namprd21.prod.outlook.com
 (2603:10b6:300:129::23) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR21CA0037.namprd21.prod.outlook.com (2603:10b6:300:129::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.2 via Frontend Transport; Thu, 4 Feb 2021 23:25:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b218957c-a78f-4186-be72-08d8c9642e78
X-MS-TrafficTypeDiagnostic: MWHPR10MB1808:
X-Microsoft-Antispam-PRVS: <MWHPR10MB180807C6BDE61A48779F59D2E2B39@MWHPR10MB1808.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rvZ51vKCULsEz1Q9zjOQDQ4VR4bMXLqPz25SkHscEemwqls7vaGdPP8YFrAP7nTNK8M5QIPIpmVcyiY9+3Y7qIuhm1B8thnOS5avH8oUJImlbICRI43OC3EHIJ/hOFhfxfxHt19pT8L1yWFYW2O0oQ0ExCNANuDcsYoSKB9RgwgboxpGzWA0UNsqNlExFBwbeLGh0vVUm1B/tOQD8v7ToaalXefZxBc4ystMon3bwIAdbwxAr/j0oIpm+9C1RfYs/gWkCHK4RaPEHxwqAPsDwj1evUnlIOLJ60EM52KaM/IUkDz9n+6CTq8RaVfo74voo+oemgUnbj/NkkIzh3NDPXfk7FJQ9xnKF3zK9ZnlNt9yvsaEsgJWvBQSppDqpZdaGNv7yYD8G3AatEMbzTJZ2x+wCXxTM3lBCxaNwvyQUXteru/eCH1+NTrj+DvCBvvi/kQZ4IkrFV0Rwtwk9WQNoQ3rcXu5G5Fc7sNyAdb8MC6R44qF9/1pzjUWRcQlbZPwPfPHAnhVzhItkbyleK0csmgxSZNkHtaYldsCYR8E1Gs+xWXg51l0DJ4nByDwuOpaRzqDJ4AKci0OnVMX2aDHBgEMBFTym49dHIH6r8z2dzg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(396003)(136003)(39860400002)(346002)(4326008)(6486002)(7416002)(8936002)(2616005)(8676002)(478600001)(52116002)(36756003)(26005)(16576012)(186003)(86362001)(54906003)(31686004)(956004)(16526019)(5660300002)(44832011)(66476007)(66946007)(53546011)(66556008)(83380400001)(31696002)(2906002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QWhkWXRNZXV2NEJWWXl6M1RzYUZ6ZHo2UWpQVDl3TFJLd3l4VUc3bEJUaDV2?=
 =?utf-8?B?emMra1JrOWR1QlY3MVFMaisrandXMDBUeHI0WnY3NFNOU0pQQTdPTE5XdU9P?=
 =?utf-8?B?d3JmUFNIM1hzT3RMcXpkNkZoQzYrcEh4WUlJVHJ2MkNBZ0ZZaUMrS1lmTXFD?=
 =?utf-8?B?dGNnY2Q2dmNIZzNFamdoZmUrUGxvRlZBMDBLYitHanZoRXA3N3NVVnVlZGs5?=
 =?utf-8?B?aVh3ZHYyTGdGYTd0c1RJb3lyZU00VUVlQ1dyZXF3UnlLeU1YSFlvL1p4RGts?=
 =?utf-8?B?dDFHTEkzT3BqZXhQdy81ajFNTEpWWTJjY1pBb21UODJ5c216OVEwekhFdFUx?=
 =?utf-8?B?c1dnUFhhaWpZc3pVVm1lWWg4aEorRVl1d3NjUlhQYlBYR1lXR3NGbE93U09t?=
 =?utf-8?B?RHFVRUdLRG5CcitWMDBXZ2lRMW9KcStaQVk3TDR0Ym9BeWZ6bjRaa3lFYk52?=
 =?utf-8?B?NnVDcXp3RmtPWU90di9iWGdPNDhCenpwblNuSmdTWjhPWENEY0ZiZWtRaEhj?=
 =?utf-8?B?MVdLWTlIVVJYUWUvS3Z4aUs0SXM3RG9kaUFGeXF5Y3NsY1ZVVFo4SVUzbWU5?=
 =?utf-8?B?RXJURXFLY1Rxc2JjWWdFOGoySUU2Y1JpTnpQbGsyK3FIeENBQXdJRUVWcFNP?=
 =?utf-8?B?OU1vVGpFRVpDT3d5emR6NmhDc1dOVlk4cXh3NWNKSWcrcVEzSG9kWWNiMlB4?=
 =?utf-8?B?RENpYnRLUjI5REx4YmxxWkNPb3NvVncyWkRFWEVFTHRJN0ZBVGVPQ1F6aTYz?=
 =?utf-8?B?SkxSWEdmZjhmTnNHWS83VThpVyttcDlMQkI4RzdqajJnRGZFemJReVJwNkFp?=
 =?utf-8?B?YTZIUTRreXVJUjNxM21oMFc2eGZyQ1hmZ25nNlJuSHlQMHVvT0NYVW52TGxn?=
 =?utf-8?B?SW1pM0MzcFFzYVJMZW5iR0xtaWpaSkxTQ2JMUjZHRnZBQWpOUHJoWTREM0sr?=
 =?utf-8?B?b2g0T2NQNWVSUWltcFpaYmtuV2ZqeFd4YmF2Wm9BSWlMRmVmRW8vdWF6ZlVQ?=
 =?utf-8?B?NE5TdTF6KzZiTG9PNERIL0lUL0lGVEhIQjNSODdIZFRCUkpDZ0VCZ0tnUnhB?=
 =?utf-8?B?dkFpb0VRY2NNTFNJdmpVaDZmTEE3SzIyVC9udUo2ZkJGVlZrcmxwSHVRU0t1?=
 =?utf-8?B?RWdhWE1XTzJXTnk5R3N1cDRQdFFOelZ6M0pxSnJLK3lReUZ0d255aU5OSTFs?=
 =?utf-8?B?NzIyMmIyNlRvaERxa2hkZ25CMHFvbDg5b1d2SStydVlzRlp2S1FDZmYwNlUv?=
 =?utf-8?B?a3hxbmJOVFVCTG1xQWpzby8vOUo3cDl1c3VHTWFkSU5ueHFMZWRvL3JFNlVO?=
 =?utf-8?B?VFQvYWtaYzVGMGZrOWJxdmJWaFNVTWpPUzQ5Z2tkUjBSQ3N0MmdSell4Q1dL?=
 =?utf-8?B?cmpMZCtyVU55eVpGTC93T004enRIbHBaV3N5ajM4TkJoV2dPSDBLcHQ1aWlT?=
 =?utf-8?B?UHVsY0Q4cWw1OUlhcXdOUC9kK09uaWE5NUFBTGFCMmtkUDl5UnBOTklVVldZ?=
 =?utf-8?B?MCtIRmZLUXhRUXRzeFQrTk9jTzhDa21wbWxVWlI1dEVEMXNabXdnOVFKcENl?=
 =?utf-8?B?MmNUcklvZFN0dm05NVJwSzhZMTV1aFN3WEE1eW5iV2pJNUltRHQzMy9vRTVy?=
 =?utf-8?B?bzl6dFhGVGRRS3Vacm5kTEp6NUx6cDVJTERKVU8zS3YyUi9HVnRTdkttMURh?=
 =?utf-8?B?RHFFRDE0VXBUc25TN201clRhemh6c21HREduYzRQRVF2TWg3YzNNVFI3cFh3?=
 =?utf-8?Q?bZ14mACFvIkpQlmMm/yN1yMHNohZJH0O93PV1TI?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b218957c-a78f-4186-be72-08d8c9642e78
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2021 23:25:38.8441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X/IuXc9F0e5VdjFj+wHrfnCV4oDv6MyPtk4Uw6LcmGAr4Fr7PXfgYls8zN2RvbErYyhK2cEhnc0CCw8v+bdB7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1808
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9885 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102040143
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9885 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102040143
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/21 6:50 AM, Peter Xu wrote:
> This is the last missing piece of the COW-during-fork effort when there're
> pinned pages found.  One can reference 70e806e4e645 ("mm: Do early cow for
> pinned pages during fork() for ptes", 2020-09-27) for more information, since
> we do similar things here rather than pte this time, but just for hugetlb.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  mm/hugetlb.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 56 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 9e6ea96bf33b..5793936e00ef 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3734,11 +3734,27 @@ static bool is_hugetlb_entry_hwpoisoned(pte_t pte)
>  		return false;
>  }
>  
> +static void
> +hugetlb_copy_page(struct vm_area_struct *vma, pte_t *ptep, unsigned long addr,
> +		  struct page *old_page, struct page *new_page)
> +{
> +	struct hstate *h = hstate_vma(vma);
> +	unsigned int psize = pages_per_huge_page(h);
> +
> +	copy_user_huge_page(new_page, old_page, addr, vma, psize);

copy_user_huge_page calls cond_resched() and has might_sleep().  Imagine
the time it takes to copy 1G.  Usually called without holding locks, but
this new code is calling it with ptl locks held.  The copy should be done
outside the ptl, but you will need the ptl to update the pte/rmap.  So,
doing all this within one neat helper like this may not be possible.

> +	__SetPageUptodate(new_page);
> +	ClearPagePrivate(new_page);
> +	set_page_huge_active(new_page);

Code to replace the above ClearPagePrivate and set_page_huge_active is
in Andrew's tree.  With changes in Andrew's tree, this would be:

	ClearHPageRestoreReserve(new_page);
	SetHPageMigratable(new_page);

Ideally, the SetHPageMigratable would be done after the set_pte and add_rmap
so the page does not get migrated before these operations.  However, this
can not happen since we are holding the ptl.  So, no problem here.  If code
is restructured to call copy_user_huge_page outside ptl, keep this in mind.

Also, technically ClearHPageRestoreReserve is not needed as it would not be
set by alloc_huge_page because we did not consume a reserve.  However, better
to leave in place in case someone wants to use helper for something else.

> +	set_huge_pte_at(vma->vm_mm, addr, ptep, make_huge_pte(vma, new_page, 1));
> +	hugepage_add_new_anon_rmap(new_page, vma, addr);
> +	hugetlb_count_add(psize, vma->vm_mm);
> +}
> +
>  int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>  			    struct vm_area_struct *vma)
>  {
>  	pte_t *src_pte, *dst_pte, entry, dst_entry;
> -	struct page *ptepage;
> +	struct page *ptepage, *prealloc = NULL;
>  	unsigned long addr;
>  	int cow;
>  	struct hstate *h = hstate_vma(vma);
> @@ -3787,7 +3803,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>  		dst_entry = huge_ptep_get(dst_pte);
>  		if ((dst_pte == src_pte) || !huge_pte_none(dst_entry))
>  			continue;
> -
> +again:
>  		dst_ptl = huge_pte_lock(h, dst, dst_pte);
>  		src_ptl = huge_pte_lockptr(h, src, src_pte);
>  		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
> @@ -3816,6 +3832,39 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>  			}
>  			set_huge_swap_pte_at(dst, addr, dst_pte, entry, sz);
>  		} else {
> +			entry = huge_ptep_get(src_pte);
> +			ptepage = pte_page(entry);
> +			get_page(ptepage);
> +
> +			/*
> +			 * This is a rare case where we see pinned hugetlb
> +			 * pages while they're prone to COW.  We need to do the
> +			 * COW earlier during fork.
> +			 *
> +			 * When pre-allocating the page we need to be without
> +			 * all the locks since we could sleep when allocate.
> +			 */
> +			if (unlikely(page_needs_cow_for_dma(vma, ptepage))) {
> +				if (!prealloc) {
> +					put_page(ptepage);
> +					spin_unlock(src_ptl);
> +					spin_unlock(dst_ptl);
> +					prealloc = alloc_huge_page(vma, addr, 1);
> +					if (!prealloc) {

alloc_huge_page will return error codes, so you need to check IS_ERR(prealloc)
not just NULL.
-- 
Mike Kravetz

> +						ret = -ENOMEM;
> +						break;
> +					}
> +					goto again;
> +				}
> +				hugetlb_copy_page(vma, dst_pte, addr, ptepage,
> +						  prealloc);
> +				put_page(ptepage);
> +				spin_unlock(src_ptl);
> +				spin_unlock(dst_ptl);
> +				prealloc = NULL;
> +				continue;
> +			}
> +
>  			if (cow) {
>  				/*
>  				 * No need to notify as we are downgrading page
> @@ -3826,9 +3875,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>  				 */
>  				huge_ptep_set_wrprotect(src, addr, src_pte);
>  			}
> -			entry = huge_ptep_get(src_pte);
> -			ptepage = pte_page(entry);
> -			get_page(ptepage);
> +
>  			page_dup_rmap(ptepage, true);
>  			set_huge_pte_at(dst, addr, dst_pte, entry);
>  			hugetlb_count_add(pages_per_huge_page(h), dst);
> @@ -3842,6 +3889,10 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>  	else
>  		i_mmap_unlock_read(mapping);
>  
> +	/* Free the preallocated page if not used at last */
> +	if (prealloc)
> +		put_page(prealloc);
> +
>  	return ret;
>  }
>  
> 
