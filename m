Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC0942B09B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 01:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234259AbhJLXyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 19:54:09 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:44112 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232870AbhJLXyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 19:54:08 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19CMdHA3013091;
        Tue, 12 Oct 2021 23:51:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=rXgzLcuK0zUtg2A3udiHFSzDrTp7eT9EWQmZ32O0Zkg=;
 b=mUjd9uJJKGukY5ryRIq/m4tfon3sZMVrODb5QP2LDX2ls76xYuf9hoEVq4UWNXn29Lly
 czmLf3FQm1ntTW7CR8RXcOBnwjQaawEjGoJOBO8BUXB/eHAOwMmTzmz+b8t3wo2xXt0H
 bC4pdBnEhRbKwvAFbzMfQbLGtaClQiH4xVTC550WFg+s+GXV3Jy4+J3WUzB2HPFJM5I6
 mKqqccM381Bmw/N2rxIkd9uKJGs5OGkUWT/vJgI61Hj6x/uCaQBEFYxjLg3fj+O6nLhP
 qWauWzgvDH7i0Rz4S41XfJNVeUvPeMnGQQ2ItPYrKq18DsZNog9K/1AoAmMAxZwTiqz0 eg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bnkbmrahg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Oct 2021 23:51:50 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19CNj83m091868;
        Tue, 12 Oct 2021 23:51:49 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by userp3020.oracle.com with ESMTP id 3bkyvb2t40-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Oct 2021 23:51:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YWq5oy6u1qRnKcdKNWmUdYZLwboq6EHoxCn8iPYPZsqZKmjT4CnLIjGBentdov6GIDMG10fztLUrZrUB52Ojk7YPo55YO2TwIKV3PVgmWxiV+yRVhlAqMhOBz6nX3UhlPku3OrxT+qSGe30bMoqCeWCxkIc/vxDT/Ac+kQxcA9G58exdltSy5DLwHtXh+MpNAViJLuM2gqzz0nwciMTs7uQN9UVPZEafDxazbIgyVt9RruD9YfWWu5en3XZ0bE4UQ07RBuQqST5LTJT7wLnyGemK9igptBhmp2I4wNVohb65X/STYltnOdugbgCM/ZOYHW8yfnewGBaawX60zbQ/sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rXgzLcuK0zUtg2A3udiHFSzDrTp7eT9EWQmZ32O0Zkg=;
 b=CmZD3nqL9W0cDbAtCmjWbvr+BJ1/DqA7aCPTeVfZ2cSXxidydDuEFI5V0gqF2fzxzhmO60RTt5jbLS01PZY+97ZjhXxy3cOWJiMx0w5P/C01KF79Tsvj6dFFCDxQ9Uc7idPmLsAgNci+idxex20Nd/ZiYUh5rAnb6clM1jWGGFZpQ1hs6xLjukBv6jospct95+LZyvESvUrjfj5YZXkoOZaGXdUcipCfLFvP+KNqZyFHJWuuGajmvP9yEQKZvjscYXaRzhIjd5Eu8EvK+M+5y800vnf7wlnuM5u3EWjBNHE9uTCekbfz1ZPInXNpZg4lSM8mJVWBMKnJatJFp/DnKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXgzLcuK0zUtg2A3udiHFSzDrTp7eT9EWQmZ32O0Zkg=;
 b=cIVY+usBsqbR6hzHANrcnaMThvr4tF8aFWI4pY0MVnuQ5rVDUe08NDMy4Ul0Wb1+yHm1RPNxxc8Du4Js3JOV7PTi8IZtyRKEHCPG9L9jHVDRfNz+mjNXZMa95pa30X7Po+xJow9YsvbMngkbolSbq2J5PTnCDjivQ/yqK7wpNZY=
Authentication-Results: shutemov.name; dkim=none (message not signed)
 header.d=none;shutemov.name; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB3908.namprd10.prod.outlook.com (2603:10b6:a03:1b0::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Tue, 12 Oct
 2021 23:51:46 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bc59:71de:1590:cbf5]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bc59:71de:1590:cbf5%7]) with mapi id 15.20.4587.026; Tue, 12 Oct 2021
 23:51:46 +0000
Subject: Re: [PATCH v6 1/2] mm, hugepages: add mremap() support for hugepage
 backed vma
To:     Mina Almasry <almasrymina@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ken Chen <kenchen@google.com>,
        Chris Kennelly <ckennelly@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Kirill Shutemov <kirill@shutemov.name>
References: <20211012011728.646120-1-almasrymina@google.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <8ade8697-3f03-c2d4-f7a9-e64cb600ad33@oracle.com>
Date:   Tue, 12 Oct 2021 16:51:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20211012011728.646120-1-almasrymina@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0233.namprd03.prod.outlook.com
 (2603:10b6:303:b9::28) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from [192.168.2.123] (50.38.35.18) by MW4PR03CA0233.namprd03.prod.outlook.com (2603:10b6:303:b9::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.14 via Frontend Transport; Tue, 12 Oct 2021 23:51:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 619f88de-440a-47cb-5a3d-08d98ddb3f26
X-MS-TrafficTypeDiagnostic: BY5PR10MB3908:
X-Microsoft-Antispam-PRVS: <BY5PR10MB390878E9CA22166D9813975DE2B69@BY5PR10MB3908.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OhoA3vTCDFwNgXWOIiKDOgpLZ65gLtcFkypXyWaxGu+lDlk+l81WoPeb0YKFV+I/jjfQzC9FHbqlGd6nYbLKqoCUuiHXbjSwbwOP5T5PojkpbfZ5bc86Eu6u5uq22AqVmf/P36D/2kG05pSVe/bdqqFJ9wPjm9mQSDq1wN9iPLOppSAouCUlycVws1MHuSkqAdvDOJMqAXrLoGc1DEttn8Gp/y3uNsSncPQuopr0kIDzDXCMzVl6lZxl33vR6BR7xzJ+koGdN36wVanrzTgE7Lz/AHt0mUm2afttSY5Y8aF7yO26T7lv8jAi9z1UZCRWwIePla8qAqv8ako1UGMd4/NqJOr8vrGUv9BQ2yvsy6oOWz9nNUrEZ9Fehcd1UtbkNR1sqVRIO+1+5JpGuBz/f3QUjRWBeBXIv5W0RW7lG4VFw43xBIVUfNPsoumcQxogrtj2cgRjUffV9FTThK56IEGAlnrulWv0qhy5gojz45W5SJ1s4VoBrzjEpwkyqBnhbHCraAN8g0uzhWGcVTS+57sAH+nPhYKvEqmj98Lz7jXpJ9alnAOJTWt+MH8Kc0Dl4N24YKmo8951hfbdA2OVDi2qVWU1dfTtL17ltQR3LCMlRinx8cPrOd4GfBhocJPf19x2i1HeeoJzzT5gVyWWTmKQYVUB+rgAXhcg8pbHev2Ozj6zBSkchsLs/GdAiFHQaGj/9hHM/OqsjmL5A+xbaMunrGdkJijJW7ln23JIZVqoGNH8uc7JSTLoP10GUY9oDZ73tQucKXFoSnEE0n95rg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(52116002)(31686004)(186003)(36756003)(508600001)(4326008)(66946007)(6486002)(5660300002)(53546011)(54906003)(8676002)(26005)(8936002)(6666004)(66556008)(66476007)(38350700002)(38100700002)(16576012)(316002)(86362001)(2906002)(31696002)(2616005)(83380400001)(6916009)(956004)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emt4Q0JmQk03T0R1NzBQcGJMSkxiRTd4Z21PUEV5eE5LOHo1OUZrVFhNZjM3?=
 =?utf-8?B?MnYzZFVseFh3M0p4YnNnOC9qVWdLcFV4Z2dTVHB6Ukc1QkVVVm0wZE1HM2Q2?=
 =?utf-8?B?YWVnQ21zbzVsMklFWUlBQkFDdHh0SmFvV2ptOTVDVStIU0pSbGZCekdhejFW?=
 =?utf-8?B?ekxJa1JRS1B2L3o0SjkzdSthNHk2L1IxbGcrM2ZHYkx0OVpwVkpLTmtzZVkw?=
 =?utf-8?B?WHU5R3d1UjFZS2loaG5UcElSUDZQTllQNHZUL1I1VkJDVHZBM2h4SVBMbDFG?=
 =?utf-8?B?bUUvSmQzMml4QUpsOS9YOCtpVjlXOE9kdkpRMjM1Y09tZDNYNVJFSzdjalFk?=
 =?utf-8?B?T1k4UlV0T1dHS1V3Y2krZXhMMjVWQW1ZMmZ4M3BTTENpWGpFSGJlc3pSNUY1?=
 =?utf-8?B?ZXI0SE1zRDZiMkFzNnlIbzJGNWYyWXA0aGZ0TWlNT3FiRlRtNGg5a3kweXhT?=
 =?utf-8?B?ZzRGMVpQZWtwSW1EcGJWTGlydUZ0dmdXUm0xTHA0UElZRFd1MHJxeHFXNkts?=
 =?utf-8?B?R2pFMVBpQUt3bGFKNFJTNTI5aFFVK05JRUR6NXh6d3QrT29iRXRwQU5YcVE1?=
 =?utf-8?B?eW9IdXIxUXRpdUdRZXhhUnQ2UGZZa1VvS2dzSTdJSHFBZjZQZ3dVaEI1a3Jl?=
 =?utf-8?B?TFI4U2piN0x4QzZxeXpGS2lHWmMzc0txTnM0d2Jyd2VHQTlhelpwdGQ1MXRY?=
 =?utf-8?B?SjF5QWhTR1RlQzNxMlBuWkRiVnhVMjVGbUVCaW0vTzBZSVhha01NRjhqSjla?=
 =?utf-8?B?UWNCUWtwZHBKcGxqSXpDRGVjREozdUVIbXhuSWNHVzkrUnlQamk5UElBZ1BZ?=
 =?utf-8?B?UU84dHlsMThQanVrTEttVkFqcHhXem95c251WEF3NVVwVFJOb2lFZlo1SllN?=
 =?utf-8?B?RjhON1plNFR5ZFg0bm56MVo1N3VFR1dlQUdDYjdQbDdiTkRJS2thdW1sYk9x?=
 =?utf-8?B?YlMzQzE0WSs0VFNUdlNYaHBvemU2NFVkY1FXUlg2RG90WU82N0dXN2pWRzVh?=
 =?utf-8?B?SGRNRHQyaWJTeDByNmtERlBROHp1WjF0TnhhVWxFZmc3Vkp6MjdsN3d3N1RD?=
 =?utf-8?B?SklsRUdsbFB3eHRkOGoyQThHWjJkeitlRlg2dnl2ZmtaKzBmVVpGSTA4Y1Bv?=
 =?utf-8?B?b28ydlBlc0tGOTJCYmVFSnlER1dzTUpHNG93L2lGVVM3QWNHdFMyVUh6cnk0?=
 =?utf-8?B?dC9FZ1VKTnU0YXdNVTVHVVJFU2pEVjU1dnh3Q3VDRU1ad3h4NWZHWUNQbVVR?=
 =?utf-8?B?SUFKY1YyNXRBbkI5Q0FwS2ErVjZ5bFdlZHdDRVd2MVRYOU1kVWVGQ0QzMW5S?=
 =?utf-8?B?YldBbUFMUWtiNWZMbDFwRFhmOTI0ZFBvUzU4djhwYVFuZE9TWVBGOTNoZy9B?=
 =?utf-8?B?bXhmRGZ0bmNHWVRLNmZta2o5V1Zrc2szTjlBZDZtRkU1NWI4UnJ5RExnclRi?=
 =?utf-8?B?L3ZiTXgrMVhXUWx4UlFCYzVhNVl6by9mMktiQ2d6YUxWcFA1bG5EZWxacmZI?=
 =?utf-8?B?cTFSdCtVdWl5WENRZUowNkRiT3ViSGEvRERXOWVnTkhaNWdyNm9OYm9SdWlT?=
 =?utf-8?B?VjhJUXJvcStJNUZtcGNTRzRGV3RJYnFqRVlsOHB6K3REQk9KVVhka1FtSXBV?=
 =?utf-8?B?UjNIVEs2TFYza05jNW1mNEhpQlRGRTIva0Vud0JvR1lFcTJCOXU4azlRYXNs?=
 =?utf-8?B?bDJRRG5PSmhTbXBzQlhGRkFLT3B3QW16SHFZMFQ5c0Q3eWo1dS9RQlNzdUNP?=
 =?utf-8?Q?SjNAlj5x/+HI4Q/VwVALdKZ0bwNtCz/+cKSBJau?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 619f88de-440a-47cb-5a3d-08d98ddb3f26
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2021 23:51:46.0934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2PbvzElpRvcvXW61+wdvf6eHCeEutau+CIvQD7I7vUom7k8m4f9awAJUeXNtBHZM0XVOrFRfXA0qcQVFk9Sn5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3908
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10135 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110120127
X-Proofpoint-ORIG-GUID: dkUzTntJJ4ll7cX2AyQBLDOowq81bQ8V
X-Proofpoint-GUID: dkUzTntJJ4ll7cX2AyQBLDOowq81bQ8V
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/21 6:17 PM, Mina Almasry wrote:
> Support mremap() for hugepage backed vma segment by simply repositioning
> page table entries. The page table entries are repositioned to the new
> virtual address on mremap().
> 
> Hugetlb mremap() support is of course generic; my motivating use case
> is a library (hugepage_text), which reloads the ELF text of executables
> in hugepages. This significantly increases the execution performance of
> said executables.
> 
> Restricts the mremap operation on hugepages to up to the size of the
> original mapping as the underlying hugetlb reservation is not yet
> capable of handling remapping to a larger size.
> 
> During the mremap() operation we detect pmd_share'd mappings and we
> unshare those during the mremap(). On access and fault the sharing is
> established again.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>

Thanks!

Just some minor nits below.  If you agree with the suggestions and make
the changes, you can add:

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index ebaba02706c87..c6b70f1ede6bf 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -124,6 +124,7 @@ struct hugepage_subpool *hugepage_new_subpool(struct hstate *h, long max_hpages,
>  void hugepage_put_subpool(struct hugepage_subpool *spool);
> 
>  void reset_vma_resv_huge_pages(struct vm_area_struct *vma);
> +void clear_vma_resv_huge_pages(struct vm_area_struct *vma);
>  int hugetlb_sysctl_handler(struct ctl_table *, int, void *, size_t *, loff_t *);
>  int hugetlb_overcommit_handler(struct ctl_table *, int, void *, size_t *,
>  		loff_t *);
> @@ -132,6 +133,10 @@ int hugetlb_treat_movable_handler(struct ctl_table *, int, void *, size_t *,
>  int hugetlb_mempolicy_sysctl_handler(struct ctl_table *, int, void *, size_t *,
>  		loff_t *);
> 
> +int move_hugetlb_page_tables(struct vm_area_struct *vma,
> +			     struct vm_area_struct *new_vma,
> +			     unsigned long old_addr, unsigned long new_addr,
> +			     unsigned long len);
>  int copy_hugetlb_page_range(struct mm_struct *, struct mm_struct *, struct vm_area_struct *);
>  long follow_hugetlb_page(struct mm_struct *, struct vm_area_struct *,
>  			 struct page **, struct vm_area_struct **,
> @@ -215,6 +220,10 @@ static inline void reset_vma_resv_huge_pages(struct vm_area_struct *vma)
>  {
>  }
> 
> +static inline void clear_vma_resv_huge_pages(struct vm_area_struct *vma)
> +{
> +}
> +
>  static inline unsigned long hugetlb_total_pages(void)
>  {
>  	return 0;
> @@ -262,6 +271,12 @@ static inline int copy_hugetlb_page_range(struct mm_struct *dst,
>  	return 0;
>  }
> 
> +#define move_hugetlb_page_tables(vma, new_vma, old_addr, new_addr, len)        \
> +	({                                                                     \
> +		BUG();                                                         \
> +		0;                                                             \
> +	})
> +

Any reason why you did not make this a static inline?  Trying to save
code in the !CONFIG_HUGETLB case?  macros seem to end up causing more
issues down the line.  I would suggest making this a static inline
unless there is a good reason to keep as a macro.

>  static inline void hugetlb_report_meminfo(struct seq_file *m)
>  {
>  }
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 6d2f4c25dd9fb..6e91cd3905e73 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
...
> +int move_hugetlb_page_tables(struct vm_area_struct *vma,
> +			     struct vm_area_struct *new_vma,
> +			     unsigned long old_addr, unsigned long new_addr,
> +			     unsigned long len)
> +{
> +	struct hstate *h = hstate_vma(vma);
> +	struct address_space *mapping = vma->vm_file->f_mapping;
> +	unsigned long sz = huge_page_size(h);
> +	struct mm_struct *mm = vma->vm_mm;
> +	unsigned long old_end = old_addr + len;
> +	unsigned long old_addr_copy;
> +	pte_t *src_pte, *dst_pte;
> +	struct mmu_notifier_range range;
> +
> +	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, mm, old_addr,
> +				old_end);
> +	adjust_range_if_pmd_sharing_possible(vma, &range.start, &range.end);
> +	mmu_notifier_invalidate_range_start(&range);
> +	/* Prevent race with file truncation */
> +	i_mmap_lock_write(mapping);
> +	for (; old_addr < old_end; old_addr += sz, new_addr += sz) {
> +		src_pte = huge_pte_offset(mm, old_addr, sz);
> +		if (!src_pte)
> +			continue;
> +		if (huge_pte_none(huge_ptep_get(src_pte)))
> +			continue;
> +
> +		/* old_addr arg to huge_pmd_unshare() is a pointer and so the
> +		 * arg may be modified. Pass a copy instead to preserve the
> +		 * value in old_arg.

		   value in old_addr.

> +		 */
> +		old_addr_copy = old_addr;
> +
> +		if (huge_pmd_unshare(mm, vma, &old_addr_copy, src_pte))
> +			continue;
> +
> +		dst_pte = huge_pte_alloc(mm, new_vma, new_addr, sz);
> +		if (!dst_pte)
> +			break;
> +
> +		move_huge_pte(vma, old_addr, new_addr, src_pte);
> +	}
> +	i_mmap_unlock_write(mapping);
> +	flush_tlb_range(vma, old_end - len, old_end);
> +	mmu_notifier_invalidate_range_end(&range);
> +
> +	return len + old_addr - old_end;
> +}
> +
>  static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  				   unsigned long start, unsigned long end,
>  				   struct page *ref_page)
> @@ -6280,7 +6385,8 @@ static unsigned long page_table_shareable(struct vm_area_struct *svma,
>  	return saddr;
>  }
> 
> -static bool vma_shareable(struct vm_area_struct *vma, unsigned long addr)
> +static bool hugetlb_vma_shareable(struct vm_area_struct *vma,
> +				  unsigned long addr)
>  {
>  	unsigned long base = addr & PUD_MASK;
>  	unsigned long end = base + PUD_SIZE;
> @@ -6299,7 +6405,7 @@ bool want_pmd_share(struct vm_area_struct *vma, unsigned long addr)
>  	if (uffd_disable_huge_pmd_share(vma))
>  		return false;
>  #endif
> -	return vma_shareable(vma, addr);
> +	return hugetlb_vma_shareable(vma, addr);
>  }
> 
>  /*

In an earlier version of the patch, vma_shareable was renamed
hugetlb_vma_shareable because it was going to be used outside hugetlb.c.
Therefore the hugetlb_* name would provide some context.  That is no
longer the case.  So, there really is no need to change the name.  In
fact, none of the remap code even calls this routine.  Sugggest you
drop the name change.
-- 
Mike Kravetz
