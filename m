Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEA8C3B4AD1
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 01:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbhFYXKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 19:10:34 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:32274 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229816AbhFYXKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 19:10:33 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15PN6kJK013269;
        Fri, 25 Jun 2021 23:08:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=3Y1482Xsl+p/IkNzHOCLBxH0bCqHpaOpybaa/kpXGDI=;
 b=PKQUyTi8EphLMQKxXDUsrrGXBteX2+BusPKwGTcSdOMymru5cdyKBqBQXJVx4WmC57XU
 wPdJy+y4G8x6UuZK6zaCblkyFxy9PQE8Fz7xaSNbO/kEKxhb2ewcnWVkKPn2Qk3qLgnu
 Xl2QU4BRwGgsHDXHcAK/KeMsFuUWTjxrhUTZqSjsaayrkGO6+HIzcC2co33s0Pl7kGnk
 hWJTZcylvHL6BWM80YccgLNCsP5NwJ6oE7IPSmzmbbEYPHW7jStGUDSNz+yn4DAPzKPA
 WybSZhQouM7MqzQO1QDgyOIUCGCNiiP4nv3aSk9y2J8JT89KQspaCT5OJ8+yAT2Gn63g tw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39d24aad5y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jun 2021 23:08:00 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15PN1eNS165179;
        Fri, 25 Jun 2021 23:07:59 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2049.outbound.protection.outlook.com [104.47.74.49])
        by aserp3020.oracle.com with ESMTP id 39dmq2gw44-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jun 2021 23:07:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ELNjEfD65X4pxBjPkfxsnIfIn1rcYNPQU0GmIkIAN/w3dSm7RcbnZ5NEjrwKkdcr6gifh1C8OCmHgzvQNxDvKHhcrtW5ZPPg2nbFTv0PmOaF9rLyQ//F04tl/lgTP5xWxILt/1UuCjXcrpN83gmrs+wV3T5ETljyEvo6DiXFtfhPrw/phYON+hnl2iSpEfuUN/mzoGDrQP56o41XP6Y7Uyrbkm2mPv0gsA+DGjY7JB7skR4KTlN44xKHVgwX+71l+wLf/U4H7GeQ6SeMI/ML8lcKYmQtPAct1QrskMKwwH+WRo0S5s16Uwbi8PpcsUNQO/eAPYP4iAffBb1JdKNhNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Y1482Xsl+p/IkNzHOCLBxH0bCqHpaOpybaa/kpXGDI=;
 b=nksdjXxRpRqoBAhtA2zgsaBMsnE6pXinQIa5ybxDVpsi7/t0vlF0oFlAvWePRlSBaRbxdb/wq5rdER+cxbPNgZ8NClU9FBpYpHAa4RxbRdRJk7HbRdcHVX/vB1bRWm6sgT873UBVAEEWBjqzqLsXTADHDqZpeIU2YIEYQcaWB62ublK4jbc//q6Imyq3Jy7I0ynj/YPMplNHFNhPooFvp+5ShgyJ7GYLL5GbPxwYDotVuEBwzEe4pt7mnxHUWLJB6Cf9qt2X4/NBMqRagP0QIA5rXhgKDKrLzyjhfXHC5uOrz1qKqKHNqdFKxAtDPx38kG3+8jJDbRFjZFQmwDQF2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Y1482Xsl+p/IkNzHOCLBxH0bCqHpaOpybaa/kpXGDI=;
 b=HoX4vs9NAATswjYQw08IVEe6LRjCKyRdx7Cyc9IkRwKSBibuXSCFNPGs9kZkGue2kxRznXStEXrTaOxF5YLs5Jp0V0N7tO021spm4I7kHOGGJhAWPqKaoIV7ToX9K9pHxEy7tG3MvYHqiB/GtfkQbvNWGfyYZO54u6cyksqIb8I=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4528.namprd10.prod.outlook.com (2603:10b6:a03:2d4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Fri, 25 Jun
 2021 23:07:57 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::5d11:ae6d:24b6:e838]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::5d11:ae6d:24b6:e838%4]) with mapi id 15.20.4264.023; Fri, 25 Jun 2021
 23:07:57 +0000
Subject: Re: [PATCH v2] mm: hugetlb: add hwcrp_hugepages to record memory
 failure on hugetlbfs
To:     wangbin <wangbin224@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     nao.horiguchi@gmail.com, akpm@linux-foundation.org,
        wuxu.wu@huawei.com
References: <20210623085102.2458-1-wangbin224@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <c38e54ea-6aae-addf-0d6b-140b097a346b@oracle.com>
Date:   Fri, 25 Jun 2021 16:07:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210623085102.2458-1-wangbin224@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR03CA0255.namprd03.prod.outlook.com
 (2603:10b6:303:b4::20) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR03CA0255.namprd03.prod.outlook.com (2603:10b6:303:b4::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19 via Frontend Transport; Fri, 25 Jun 2021 23:07:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c1309f6-7606-41aa-50e3-08d9382e1206
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4528:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4528FD6AF70489AD629D6F62E2069@SJ0PR10MB4528.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ujOCCF3vzUeGeSmEDYbA5CALKPFoc4ocvY5uAPG17ZTH8uri7JVMj2ZdWAmjsSFqVVV1qziA3SFGv4LQAS0NCahpx8NMtkEgHZu3d/3dLegcF0N86RL8jF4Qi1W5W0yKpUKRU6/EZOsqawar6pPpWbpEHVdhp1l9d/9Q2k1arcRG0pEwin834Ix/FdC8J5yvafRERoApQblY03WShQtoVqOgOSVLbYWOrW7zpp3zAPpQNdNZiL4yqNTW0CpynJ314bJAhbtruAo/VUiGzE0GNe6f0L2cJ885r2+Y8yLDtP6CXuccJghyqaXlGoh/WLqs8oOqb90/Wm/Ke/v5BsWwCrKkShaAgQoQLMIoEN1jzWCGDfcHaFnfcypmIdZctyrkozkXTphm13Bpwv6nvhc3IVgM7MWXThCgk8vfsVQWKhzRQdlzbxStW1Pwala49vfL31qaZkWPSBBzeUG3snCwrRuFap8aRfhSPZFW7G2bHTWQQNMQnTuJOcFvRgtgdpU0p2IrcYiq+HhAlBYeplcAGRLpW0U/0IOkosu1QFU0xCpZfxBA2wrQ7eITUihauBak3ltWxK3eSEXnRG0SxFhOzFjBsne6JiOCmtLH9oe+16tSRsTPaY0LOMwlYG6oSSEYUsVEG0LcQ3Oej9SphuEmzEOX+DtK9uYZRh1jYtsgkgNrKf25EcYTN7vY7QEvGlWg5tT0X7zUTjKdHPdBte1oL2LgQiphLty32imBzT62dIY8xS7xtw1V1ICta/mxuHAZecscx5bPU0v39Qr0v6zFdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(136003)(39860400002)(366004)(396003)(4326008)(16576012)(316002)(66946007)(66556008)(66476007)(956004)(2906002)(31686004)(44832011)(2616005)(38350700002)(38100700002)(478600001)(8936002)(5660300002)(83380400001)(53546011)(186003)(8676002)(16526019)(36756003)(52116002)(31696002)(6486002)(26005)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2grb2EyZHA1azRmL0haM1RPY1JzVUZLa3p0VzN1RmhTeUZrdUNPeWJIelM0?=
 =?utf-8?B?R1cvRmJ5MUF1blVCMUR2VFNtWktCVExid1c5QnNoWWpBL29ocEZaM2g5amR3?=
 =?utf-8?B?YVhBb3ZoWENoaUF4ZEQ5UHRnRTRtU1o3bzlLMjdJVXpFekpVVnRUbWRUT2xy?=
 =?utf-8?B?bjVYdHRPMktRYzN1WUxDTmhweU9BN2dSNnpFMnA0eTI4aVVxbysvNXYxTDBG?=
 =?utf-8?B?Z01WMXR5YlFKcGNqT1dDUzBQTm12VjRzb2d6QnNiNHpxcUkvK3h0VWM3U2Zy?=
 =?utf-8?B?eHF4ZjVQeExlQSt5VUhlTW8vWXdpbWxQSGxlbmNUcEVOVEQrcGdSSGExNlB6?=
 =?utf-8?B?cjVDeFFocEFIcDVoZ2h5YlFEZm43cEs0ek5SNVRGNzAyQnRrTmpiWWN6UEVJ?=
 =?utf-8?B?bUNNQ1U3bk9UMHdqRTlDYXdHRFlnT1lCU25wdkJ2TU5VVDdNakE2QU5qN3ZP?=
 =?utf-8?B?dUNVSmMzLzVCcDRUdEFEbUhldEorWmVWVlNLNmF3MWRpWW9aMm5BQVM5eElJ?=
 =?utf-8?B?WWpvSWFLNWJhaGJGNTdCQmRNNG9pOU42RGF5YmkrUjUyTzdlVHNhMmRkLzBY?=
 =?utf-8?B?TmRBdjYwQVpNT1NKWStZY1cwWjF1L2ZDc1NDOTlaT2ppNWp6Q3JTRzFZRVh0?=
 =?utf-8?B?VGNVeTNLR2M4SUdEUUgvTVdlZnVLUzBDUVBaKzZwNmVuY290ZFJFRWN3QkVR?=
 =?utf-8?B?VWJYOG5VbENFWXZSWmdTUytmdW90WFQwamFFcG1pSVFGU1J5d1ZHbS84OXZu?=
 =?utf-8?B?Zi9sdnBLUlRFMzFWZkJHdWVRVkEvclZEajcyRGdTeDRHOWdqdTNJd0gzZEVn?=
 =?utf-8?B?TWZlWDhGd2NpeFJOYlJkTm8yVjdraFVXUkJGQmtTaTZoOXNoL2d6aGhBeWhq?=
 =?utf-8?B?WTQvM25BUngwdmZ3Y2ZkbGhqY09idmp2K3RHSXlzSzRsU3ZGZkFCTXJmZzJF?=
 =?utf-8?B?WlFjNDBRcmE1b05DMG04b05EeitPbXpTVURXSXl5dXc3OHV1ODFQV1p6SHRY?=
 =?utf-8?B?Ni9xc2w1L3FiMlFqL0xGL1l5aitWdk1ZbWhPeU11TFNhSnl2ZEdRbEtpdGpT?=
 =?utf-8?B?TzAxdjVmQmdKMWhHY09Nd3Z5OTIwbVUvYkR4SXYxMHN2U0dxNHNuT1pWOVYx?=
 =?utf-8?B?a3N0MkNyQjBTYjdGUXF3a28xdmZ2SEdRK3N6V0tYTzNCVytHa1RaTFhxaXNJ?=
 =?utf-8?B?RmM3bGhCa1ZWYXpJSmU4RC8wSW9odGhTbTFQTjdtUTNQa0FQYXFRblhNVnEy?=
 =?utf-8?B?S08xODJqTVdXYVdHQXY0ckF5dk9RTjhmSTVnZHpMazczZWsyejZrMllJdGp0?=
 =?utf-8?B?eEpleWF0SlJyemtIVStIN25QaXVWd1FEVVpRV0tiTzd4cE1jakNxKzVLSUJo?=
 =?utf-8?B?SG9oOVN4TjQ0eWVkRFQ3MHhBMkp2M1hZMlQvVmtXVzdWWlpDRFlFUjNjTitP?=
 =?utf-8?B?a0l0M1RheklWSGw3QkhuTGVKT293ZW5VZTlFa2x2S21CdnhwOG1Xc0pSaEVF?=
 =?utf-8?B?eXB3Tll5RVc2MHJPK2pacitvYjFwZ0JoZzRWcGc0L0hISDAyeHMzZUdSbnVS?=
 =?utf-8?B?ay9SUnNXQ0M4cVZ2Ykd6NnZJN2RaNWgyVy95Z1BqRkdxWCt0NDZpbnJsSXFN?=
 =?utf-8?B?U2hBeXFsSkV2YW84Y0dtUitXZFcrRHBpSmhsOFpwVlpRblFBY1czSXRtZklP?=
 =?utf-8?B?MkU3eXZPQXZLM0ZVMDhrQVowc0VQQjg5Wjl1WXM0ZjBTMVdRR3QxdXJmYUZn?=
 =?utf-8?Q?29ngHvzSddSXNUpvrlNEugDQFfdcXiVUVVluWXc?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c1309f6-7606-41aa-50e3-08d9382e1206
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2021 23:07:57.3562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZznEb9DptgRw8co+l/gCWZoxJTE81jW+/hlUJ2NX6/VR4Q+DKzsnYz5mkzq2TSq8eai+4mbzBdoE/xJIMwQlUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4528
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10026 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106250143
X-Proofpoint-GUID: GB8AjxEtFPD8t2kEeAlLKKXwIwSEOzYh
X-Proofpoint-ORIG-GUID: GB8AjxEtFPD8t2kEeAlLKKXwIwSEOzYh
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/23/21 1:51 AM, wangbin wrote:
> From: Bin Wang <wangbin224@huawei.com>
> 
> In the current hugetlbfs memory failure handler, reserved huge page
> counts are used to record the number of huge pages with hwposion.
> There are two problems:

Plese review the comments from the first patch.  Reserved huge page
counts are NOT used to record the number of huge pages with hwposion.

> 
> 1. We call hugetlb_fix_reserve_counts() to change reserved counts
> in hugetlbfs_error_remove_page(). But this function is only called if
> hugetlb_unreserve_pages() fails, and hugetlb_unreserve_pages() fails
> only if kmalloc in region_del() fails, which is almost impossible.
> As a result, the reserved count is not corrected as expected when a
> memory failure occurs.
> 
> 2. Reserved counts is designed to display the number of hugepages
> reserved at mmap() time. This means that even if we fix the first
> issue, reserved counts will be confusing because we can't tell if
> it's hwposion or reserved hugepage.
> 
> This patch adds hardware corrput huge pages counts to record memory
> failure on hugetlbfs instead of reserved counts.
> 
> Signed-off-by: Bin Wang <wangbin224@huawei.com>
> ---
>  fs/hugetlbfs/inode.c    |  3 +--
>  include/linux/hugetlb.h |  3 +++
>  mm/hugetlb.c            | 30 ++++++++++++++++++++++++++++++
>  3 files changed, 34 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 926eeb9bf4eb..ffb6e7b6756b 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -986,8 +986,7 @@ static int hugetlbfs_error_remove_page(struct address_space *mapping,
>  	pgoff_t index = page->index;
>  
>  	remove_huge_page(page);
> -	if (unlikely(hugetlb_unreserve_pages(inode, index, index + 1, 1)))
> -		hugetlb_fix_reserve_counts(inode);

As mentioned, huge page reserve counts are not used to record number of
poisioned pages.  The calls to hugetlb_unreserve_pages and possibly
hugetlb_fix_reserve_counts are necessary for reserve accounting.  They
can not be removed.

> +	hugetlb_fix_hwcrp_counts(page);

This new routine just counts memory errors on 'in use' huge pages.
I do not see a call anywhere to count memory errors on huge pages
not in use.

>  
>  	return 0;
>  }
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index f7ca1a3870ea..1d5bada80aa5 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -171,6 +171,7 @@ void putback_active_hugepage(struct page *page);
>  void move_hugetlb_state(struct page *oldpage, struct page *newpage, int reason);
>  void free_huge_page(struct page *page);
>  void hugetlb_fix_reserve_counts(struct inode *inode);
> +void hugetlb_fix_hwcrp_counts(struct page *page);
>  extern struct mutex *hugetlb_fault_mutex_table;
>  u32 hugetlb_fault_mutex_hash(struct address_space *mapping, pgoff_t idx);
>  
> @@ -602,12 +603,14 @@ struct hstate {
>  	unsigned long free_huge_pages;
>  	unsigned long resv_huge_pages;
>  	unsigned long surplus_huge_pages;
> +	unsigned long hwcrp_huge_pages;
>  	unsigned long nr_overcommit_huge_pages;
>  	struct list_head hugepage_activelist;
>  	struct list_head hugepage_freelists[MAX_NUMNODES];
>  	unsigned int nr_huge_pages_node[MAX_NUMNODES];
>  	unsigned int free_huge_pages_node[MAX_NUMNODES];
>  	unsigned int surplus_huge_pages_node[MAX_NUMNODES];
> +	unsigned int hwcrp_huge_pages_node[MAX_NUMNODES];

I understand your requirement to count the number of memory errors on
hugetlb pages.  However, we need to think carefully about we represent
that count.

Noaya, do you have opinions on where would be the best place to store
this information?  The hugetlb memory error code has the comment 'needs
work'.  Ideally, we could isolate memory errors to a single base (4K for
x86) page and free the remaining base pages to buddy.  We could also
potentially allocate a 'replacement' hugetlb page doing something like
alloc_and_dissolve_huge_page.

If we get an error on a hugetlb page and can isolate it to a base page
and replace the huge page, is it still a huge page memory error?

IMO, we should work on isolating memory errors to a base page and
replacing the huge page.  Then, the existing count of base pages with
memory errors would be sufficient?

This is something I would like to work, but I have higher priorities
right now.

-- 
Mike Kravetz
