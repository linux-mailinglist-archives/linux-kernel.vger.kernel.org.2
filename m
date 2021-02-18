Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E895331E41E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 02:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbhBRBrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 20:47:33 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:43044 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbhBRBrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 20:47:31 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11I1iBun023306;
        Thu, 18 Feb 2021 01:46:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=xHOkLXw7Ufh9jXi4jmzMqDf/TvfvEVC2QoyYiewfTDY=;
 b=N2YIU7aJaK0l4LhMi3jx170oZ5+w36RisJIx8FeJSoMXPYFuBJ1xaamQ6iSmhKBfKDYi
 VWNeEg3DDQkkE9i6orDA0haqzynnw2Tr1KD70UqEGqN23eXvILd6vIqAzOpJLWLZHS0T
 VrAdnx1LKGkScgL7f3RrJEw7+AjcJ/JxVLPHZ5Pjs2oPt2m1jSQoqALtJ1WWTmVXhlOC
 SJNgjcXm1wsGaR/1s18VQZSrrd6o2spvLIp58OtOygMnxDcoinX2VVbdPXjn5oBxUS+4
 FVuRlv70kH+emPHU3NtzrvtbT1bI2q87sIpBU6SYxtQtvRw2KI0zyDR5ToOGC8bMRe/E 4Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 36p7dnm940-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Feb 2021 01:46:39 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11I1k7Mp190478;
        Thu, 18 Feb 2021 01:46:38 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by userp3030.oracle.com with ESMTP id 36prpyv4b1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Feb 2021 01:46:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GrDFT4IfDSVABPkJjDPGDPbMzQpYSeejjVjUlyDyjPLA1frGxnjWzQdp5BG6vDi5Wso2O75Cl1KTQA7PZLgMkugf3xYVLfG4o+WeWwns3X19+niHrTKkQlD0g+XlIU0u4zUUWlZ9bkoIGQB3pJa82wtJqyCaoL9mVqAamMAt8Q9qpfOkNHqL5dQMuSLSHezp6PbzFvQ/nUHN6gNzGNQzYNlytq2LUjXzRipcwvlFDPhZNHPF7oppMIsCMT2glLhhm04+FRPalWaVLH/bW2Jou7cRPiAIkKKzlyEogSaJLpYJg55IMLxZd4Hb3FKk2itJcGZNV+MJs4qziLtl8fTAtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHOkLXw7Ufh9jXi4jmzMqDf/TvfvEVC2QoyYiewfTDY=;
 b=iVopDYYn08/+gsCmPBDQajQ9X8DzlLZ68pqlgd6TOduivjkE/GOleG2cnjn3Trb09Jpgq4plbsgkjBfLE/wpTFUq7ts0rv+dnwcEs4SZ4zT9yhCBUEYbMQUduFS4aDmWc6avf/p5qNwPpLxKsjoF3G8M7rZfpd3bn0K2sit07Nq7RoXhzbvLAS9w8t3zyAXfBW+Itv1/jnNNdcURNypUVfIeVLDuu2WZSdSPsix5kSKisulkhrA0kp5JFYYs8/Feb4DMTv6QAPEzCP1dfqre/mcGzGVjXwH+5Zmyc1lEuxhcY9d3DDSnV6dQd+eekuSsR0T2a5lhR1ScWPzfk0StDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHOkLXw7Ufh9jXi4jmzMqDf/TvfvEVC2QoyYiewfTDY=;
 b=QcKb3IgJR/jIZ2pyydcFgHSO4kGdpxNCsKGqA8RhztKrhU6QGwZFsk8ARNRMjS1zV9XZI2lrvJdvFDjyWiJbuRiGv9zozYuUbYvThjSXWTG6eXA906DF+q/di/Is40KUpI+OBc6hZlyCNjaMyb10iSURXJIQMip4M2N9rDDKkYc=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4783.namprd10.prod.outlook.com (2603:10b6:a03:2d9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.29; Thu, 18 Feb
 2021 01:46:36 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e035:c568:ac66:da00]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e035:c568:ac66:da00%4]) with mapi id 15.20.3846.041; Thu, 18 Feb 2021
 01:46:36 +0000
Subject: Re: [PATCH v2 4/4] hugetlb/userfaultfd: Unshare all pmds for
 hugetlbfs when register wp
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210217204418.54259-1-peterx@redhat.com>
 <20210217204619.54761-1-peterx@redhat.com>
 <20210217204619.54761-3-peterx@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <f2122560-fbb9-c0fc-1b05-6d82ccf4525c@oracle.com>
Date:   Wed, 17 Feb 2021 17:46:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210217204619.54761-3-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: CO2PR05CA0076.namprd05.prod.outlook.com
 (2603:10b6:102:2::44) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by CO2PR05CA0076.namprd05.prod.outlook.com (2603:10b6:102:2::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.12 via Frontend Transport; Thu, 18 Feb 2021 01:46:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74ffd97d-2972-4ff0-b9b1-08d8d3af0722
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4783:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4783DF20EF84F811ED8F90F9E2859@SJ0PR10MB4783.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xDKQxm1IizmUMnMHsQI/4azwMlOzeflc6gqFXYnnonhh/gJWm/QGORckOupPcUBAWw5dfUjcH+n6KKkGpVGD3MYqfHIkp29RGcW7mY55uSd0V/QaKrzA/mxHXjufAjvvYjL5gNXZN0IxQzhWO96dcdwnX6ps/KqUsHMYh7k0A7J6ZNIoHzdZBp9QzVspMp4tbrFDMEtFAUa7SM3h7yXH8Tj4aS3HX+NAFojCoE8DZ0HbUStN/ihmiYnl+Wy9auIjjoYoo/Qz5ZxfE0328W9NNkSg6ZPyw+HxZYb6kx35CaAY+R0WMmziXIDKmRU6WZfKYVoh3jkf81Uhy6AW6jAjL87RsPhKADdfnrdBkLLfQj8QXSDjU+nGoIjkIAFBmJ5B7gRWTZDUMbAM+/l362FT39OPx7Ub1SwgficJ6wp6eNTeDp6NThO28eYN2jrFAvFYnt6ndC+Ty+jLAdl+la2RK2wPI6k2ckYJiqpG5fVZwX5/UoGMqHh2OyHj/f99w2QrlFukjEGwpWoZoaCNFQLGV4Wkk8MlHoCI8eQ5iIgbKUxPUkoIiCb8TVQwxzUlnyJ4ZY31JajqSwfWUBR+/cFAjYcm+UhhXFgcTzlk0YDSptU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(39860400002)(376002)(346002)(366004)(4326008)(36756003)(86362001)(16526019)(478600001)(53546011)(6666004)(956004)(8936002)(2616005)(52116002)(31686004)(66556008)(66476007)(66946007)(316002)(16576012)(31696002)(5660300002)(83380400001)(2906002)(186003)(54906003)(44832011)(6486002)(8676002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VHpaUUpScHMraHdXUzN5QUJ3L2RFd3VvZk0zZUh3cHBNcEpyUTZVRno0Ni9z?=
 =?utf-8?B?cER5a2VwbDBBRytBLzAxSW52aUdyOUJvMGxRUXJlRlVsTHg1aTNZWlpzelcy?=
 =?utf-8?B?RG80Nkl2Ui91cHhRL2VoMUV2ZUQvcDNFNmIweFljT2lYQWI0OE1aelZwUTVH?=
 =?utf-8?B?WE5mMXBxQVJqRmY5OGFiZjR6aFZicUM5K2ZnNXN1MXh1Q3pxN3J2cS9xb1h4?=
 =?utf-8?B?YldXZzRXUGwzRTdiZCtVbkF3V2U5ZkM5Rk5EdDFRK2YvUHBUcFBpM3VNSzVl?=
 =?utf-8?B?WjMzT291LytDd2JmbGtoL083Y2VJNjdJUlh0SjJUSnR6TkZFYWJIejh5RFQ1?=
 =?utf-8?B?K2gvVVRCWmlST2xoVjdkUldvYU81RnZhekt4TUgyVmlvWFR1WTRHbWFHUE1n?=
 =?utf-8?B?SFJyZEI2VWhBdDkxUmY1SmhRdUFGUVhVSmF3VW0vN1FwKzYyQ3hOd1NROUZX?=
 =?utf-8?B?TjhRTUdvUFBEUTVUTmx0WjYyazhFRWtZWnp1OGxtV1FNaEdpR1Q3dXRSc1B1?=
 =?utf-8?B?L2FyUVNlZHBBa2ZoRGdvZlFHSk9JSUlpVTdaUFBBbXl3VXk3VHR1cVE0R3gv?=
 =?utf-8?B?RzIxc29wbE03N1RObXRVSDdPYy9jcEFoM1hxdGhMWVJOVnVsZXRYSytEQnBD?=
 =?utf-8?B?VnFLYVJqYUR6b1Nua1BlRE9MMnpzRVR5YU1DNWlHN1lXN2dyQ2c3SGRKaTAz?=
 =?utf-8?B?a3VlcmRDM1FIbkdid2IrSVE1ZlhKdFgrYzMzbWJaeFNmbW9qQzVDRDB4SFRK?=
 =?utf-8?B?cVA3Z2ZXUHczNkVuQ3QvRG1zNW1XTExCWFZMdHlVVGNxbHRYVUVKMVNCSFN4?=
 =?utf-8?B?ZjhtTUhhK0UwVlAvaVExN3VCQk9yTENQd0tLamNiN0hnVEtoYnk0ajlYaWQw?=
 =?utf-8?B?aGJlakxWVmJzT2txUkNlTTZsbDRoWDdaTEl2eTQ0cHdaZnlmS041UDB2UGpy?=
 =?utf-8?B?eEZNRmJUYzdGKzBlK1pVOHZlbms2Mmp3cXd2R3hWVTNHZC9KQVZjdlh0aDBJ?=
 =?utf-8?B?RTY5VFBTRUtMRlpnelJtWnFVRTVNWUFibnVtZE1GSFMwaURPVkE4Y0kvWlhL?=
 =?utf-8?B?eEtJQWxmLzBkd2pSdHQvbC96TkpSd2tqVkhRcTkwNEJHOFIrekhpUGxNNU1h?=
 =?utf-8?B?ak85Z3poQk1sTjJhZzdoeVJyL28wYW1pdU1YM1R6VVUxczRJU3Rkc0hidXIx?=
 =?utf-8?B?SGk1MGFLN2xPWG1INnd1UlJ3YmF6cFc2ZFdtQmFudjB4eGFZUEpUZDE3a1h0?=
 =?utf-8?B?ZXhuUGQ4ZWtZdHltYzNFRTczMEN0NjdyQ1gvcHcrMzg0L09XVU5TTmJoMEFz?=
 =?utf-8?B?YTFVYkR2akVpUE1WeFNUV2JoY29GNlhLVFNhV0Ewd1B1cmUzSDZZa0hDMlNj?=
 =?utf-8?B?bWVHR0pzcDRUSk1lMGxLZm1TdW8xYXRqbHQzS21pZEJqNE9zTjQxMVdwNkE4?=
 =?utf-8?B?eUhXZzVEeXhZMXo2YTQwT0IrQmhnUUErVGxXV29oUU53YzJ3VHNOREpoa2FS?=
 =?utf-8?B?Uld1bCtVZlMxSEhhU0xGREo1RzR3a1RmbzVJcVU1Z0txWHlzaWtISmkwdHlI?=
 =?utf-8?B?SGQ0R2hZMk9KTkNSNG0xSTZaRXVXZm5TQXpFbnU5bkFLYUNuWmZPMXVza2x5?=
 =?utf-8?B?UC9qN1lCVzJiUzlZVlEyVTFNRElsSGZYOVB4VGxCUDZoQ3V3eXNUYjlqT25J?=
 =?utf-8?B?bVZRaXlQMEo3V3ZxZHBmM0dzWE5OMW16eHY0OE9SMzZVVzlrcnJrcERxUWV2?=
 =?utf-8?Q?GjsoMjqBwkvKmFSjmHTyvuwfuNADeOUSSric+4U?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74ffd97d-2972-4ff0-b9b1-08d8d3af0722
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2021 01:46:36.6573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: liSamZBNcSOZBorJlhUlMtgnElW+16+Ye3epYCVUT6Sicw+uqFBLh88EbLk5qPXvijKYQxj9r6crwtn+jpF4Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4783
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9898 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102180011
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9898 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102180011
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/17/21 12:46 PM, Peter Xu wrote:
> Huge pmd sharing for hugetlbfs is racy with userfaultfd-wp because
> userfaultfd-wp is always based on pgtable entries, so they cannot be shared.
> 
> Walk the hugetlb range and unshare all such mappings if there is, right before
> UFFDIO_REGISTER will succeed and return to userspace.
> 
> This will pair with want_pmd_share() in hugetlb code so that huge pmd sharing
> is completely disabled for userfaultfd-wp registered range.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  fs/userfaultfd.c        |  4 ++++
>  include/linux/hugetlb.h |  1 +
>  mm/hugetlb.c            | 51 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 56 insertions(+)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 894cc28142e7..e259318fcae1 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -15,6 +15,7 @@
>  #include <linux/sched/signal.h>
>  #include <linux/sched/mm.h>
>  #include <linux/mm.h>
> +#include <linux/mmu_notifier.h>
>  #include <linux/poll.h>
>  #include <linux/slab.h>
>  #include <linux/seq_file.h>
> @@ -1448,6 +1449,9 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
>  		vma->vm_flags = new_flags;
>  		vma->vm_userfaultfd_ctx.ctx = ctx;
>  
> +		if (is_vm_hugetlb_page(vma) && uffd_disable_huge_pmd_share(vma))
> +			hugetlb_unshare_all_pmds(vma);
> +
>  	skip:
>  		prev = vma;
>  		start = vma->vm_end;
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 3b4104021dd3..97ecfd4c20b2 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -188,6 +188,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
>  		unsigned long address, unsigned long end, pgprot_t newprot);
>  
>  bool is_hugetlb_entry_migration(pte_t pte);
> +void hugetlb_unshare_all_pmds(struct vm_area_struct *vma);
>  
>  #else /* !CONFIG_HUGETLB_PAGE */
>  
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index f53a0b852ed8..83c006ea3ff9 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5723,4 +5723,55 @@ void __init hugetlb_cma_check(void)
>  	pr_warn("hugetlb_cma: the option isn't supported by current arch\n");
>  }
>  
> +/*
> + * This function will unconditionally remove all the shared pmd pgtable entries
> + * within the specific vma for a hugetlbfs memory range.
> + */

Thanks for updating this!

> +void hugetlb_unshare_all_pmds(struct vm_area_struct *vma)
> +{
> +	struct hstate *h = hstate_vma(vma);
> +	unsigned long sz = huge_page_size(h);
> +	struct mm_struct *mm = vma->vm_mm;
> +	struct mmu_notifier_range range;
> +	unsigned long address, start, end;
> +	spinlock_t *ptl;
> +	pte_t *ptep;
> +
> +	if (!(vma->vm_flags & VM_MAYSHARE))
> +		return;
> +
> +	start = ALIGN(vma->vm_start, PUD_SIZE);
> +	end = ALIGN_DOWN(vma->vm_end, PUD_SIZE);
> +
> +	if (start >= end)
> +		return;
> +
> +	/*
> +	 * No need to call adjust_range_if_pmd_sharing_possible(), because
> +	 * we're going to operate on the whole vma

not necessary, but perhaps change to:
	 * we're going to operate on ever PUD_SIZE aligned sized range
	 * within the vma.

> +	 * we're going to operate on the whole vma
> +	 */
> +	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, mm,
> +				vma->vm_start, vma->vm_end);

Should we use start, end here instead of vma->vm_start, vma->vm_end ?

> +	mmu_notifier_invalidate_range_start(&range);
> +	i_mmap_lock_write(vma->vm_file->f_mapping);
> +	for (address = start; address < end; address += PUD_SIZE) {
> +		unsigned long tmp = address;
> +
> +		ptep = huge_pte_offset(mm, address, sz);
> +		if (!ptep)
> +			continue;
> +		ptl = huge_pte_lock(h, mm, ptep);
> +		/* We don't want 'address' to be changed */
> +		huge_pmd_unshare(mm, vma, &tmp, ptep);
> +		spin_unlock(ptl);
> +	}
> +	flush_hugetlb_tlb_range(vma, vma->vm_start, vma->vm_end);

start, end ?
-- 
Mike Kravetz

> +	i_mmap_unlock_write(vma->vm_file->f_mapping);
> +	/*
> +	 * No need to call mmu_notifier_invalidate_range(), see
> +	 * Documentation/vm/mmu_notifier.rst.
> +	 */
> +	mmu_notifier_invalidate_range_end(&range);
> +}
> +
>  #endif /* CONFIG_CMA */
> 
