Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E41630E59C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 23:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbhBCWGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 17:06:00 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:33300 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232750AbhBCWFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 17:05:44 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 113M4SxT154091;
        Wed, 3 Feb 2021 22:04:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=GLCNVusdveWJfT2sgVDYgx8hZg/AXJ0ElOu6+aZ/Tz8=;
 b=lGJGTJ3EhvyoFPnenI+9ZA79PesU1Jhvu3kp/Ow0bWsBIyF/xRihMBURetBtP6B9ZZSH
 zVhGeuUxmBErBU/t3s77YlCTPpAudqZX6GcUvanyphir+WxMc967U7nejgYCWQEPMCsk
 TBqBHqpLil/H79ULDnTcP5PRamxIIEZnZOpQGa+D8bjZ9u7GCkahdyh0VWn3rtmHZk2d
 GTs2k+946b6wKQdxhwaP1nQ6X/IrTTpDSntlvLJwD5QbdKX+bxS+RNDoVixMrKj1NT75
 Zy+0Ac/p9iYXH0MD3yv39HaBonyt/1EqQ9Fs4HzFoRlsXbCBtWtDOmWo8EH885lT3Zla Ng== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 36cvyb2mwr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Feb 2021 22:04:34 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 113LxbKf098394;
        Wed, 3 Feb 2021 22:04:34 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by aserp3030.oracle.com with ESMTP id 36dh1rjqqk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Feb 2021 22:04:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LAk88hJCHbdeFr6IW7LxLbSnRwOOl6DhhO+R8tsZdJ0Dmue/6mnte/6pXkECkRs2I0xfl6VGTO/3j17Y+q+/FVHPnoBu1BhxM/u0WDNSf6nF6/iayjBE8PEsY5ZqlqBiqKUU4//8Q6GaXs5PYHEryh3jHr4oRXqesjdP7MXqVtfQbqpgUN1/VBZ4AlCMQiUWjFtZPebXOKF2uLeXQV/rt2BGXtAhKQE2fgvqJ2sSq1tKRXxxYkl3cTv9pvLU4PPs5rlQqPWGXcY+69ATGm1fWepapIApzXforwor7Ypa5g80dO9Ljffzmrl00YuP4wT5wOLwZ2rLufyE7QZZxjJ/4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLCNVusdveWJfT2sgVDYgx8hZg/AXJ0ElOu6+aZ/Tz8=;
 b=ZUdihla6Mne8kFsSZ4q4ENl5WNmsnkxeTXuAqjfsZ6c+GbrEkI4mvOhJDQVpFZ2VMF7XSgVNiFPnHFbK7H0+QSBYVuAc1iUcqSoCi4szDjTPZxXAFX/La8AMtzywyN/leu9GQ5zDOa2/FEAyzg5R63u4V6MCDF3G8xLV1vE/Ao01exWF+jraMKTEyNPGwbPq6dTNPDLaU90Q1SdgIpHHHEk9yCNHbXK4vsez6zqDUoenURWjK4b/KrAdA4gR2fx7Ld0lLIs8F39ndjHo7UcnjSD9AaqsxQFOxDOXSyVd4X3UtLWXU5VZ6xZcH14SWBAUB0xHxS9j0hRsrdhnB3YUAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLCNVusdveWJfT2sgVDYgx8hZg/AXJ0ElOu6+aZ/Tz8=;
 b=ER4s+Ol08getxaoFXOaMrXtBb/hTjzEMsDPkymhjGjKzAGONB2BHogJmuK3PnrLAYvt5DKzVILvysKmr/9wFsS3YUlGONzn4hRVOW1iidZnrJ1JUMhrVUKFLxEF79/+KYI6vChVWmZEzApQewFdrY8mL4V7yFd6JJwOe/YVAkmY=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by CO1PR10MB4579.namprd10.prod.outlook.com (2603:10b6:303:96::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17; Wed, 3 Feb
 2021 22:04:32 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3825.020; Wed, 3 Feb 2021
 22:04:32 +0000
Subject: Re: [PATCH 4/4] hugetlb: Do early cow when page pinned on src mm
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Wei Zhang <wzam@amazon.com>, Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Gal Pressman <galpress@amazon.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jan Kara <jack@suse.cz>,
        Kirill Shutemov <kirill@shutemov.name>,
        David Gibson <david@gibson.dropbear.id.au>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210203210832.113685-1-peterx@redhat.com>
 <20210203210832.113685-5-peterx@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <2038a69e-8c2d-c959-4bdc-9d2ddf093061@oracle.com>
Date:   Wed, 3 Feb 2021 14:04:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210203210832.113685-5-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW2PR16CA0056.namprd16.prod.outlook.com
 (2603:10b6:907:1::33) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW2PR16CA0056.namprd16.prod.outlook.com (2603:10b6:907:1::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend Transport; Wed, 3 Feb 2021 22:04:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0c1b107-11e4-4e84-361a-08d8c88faf07
X-MS-TrafficTypeDiagnostic: CO1PR10MB4579:
X-Microsoft-Antispam-PRVS: <CO1PR10MB457941F0666184C437338DF6E2B49@CO1PR10MB4579.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AGQ2JflsFJSAygmYJQhzCjJ5Sz2kuKiSbBbxfUiHge7Po+K/z1xrUuBr7pcSNy1KJh2roK917pZC8SvYt4fKFmSbbxJ87yDb3DBGq/QVtsfwN7fq5+IMiiNX7yJ2dZlXC0YdBI+EG1gdRCTLRwNPvLbKnPGMo3w75wV8wk6jzbYt13eQYC9tJaQnlzxKmaI3wuygodx5EiCtXfdJ6pnrFMMFwGCMnfKAnEsusbUXyoFv0nOfu0O2t65BEH800MuwKTy5mVwZIk8p63QiZwNamGcILvsaUAvyywEexUcvYYYTB0B8J3maV44Hwv+wBH1SgbU6cvXFrRDmJBIP+mIX+Qtyw3RrTQp+ILEqPXQbDQWUF0VgL+iIX/tZHIhABYQukdSYSHRpTWVjjRDOm+SP8J53WDOE3Up+uUem+fK2LbOf+WNTaWE+4hp02FJQXtNWfvUwxCZKf4psm7wt/hCpr5h3NgGx4UXsstNBWNqRphNY1lnvj5KDTpi4hAGPKwcf6gsk1bcqF4shMKGo98q1EeByNbTBE3piRsjHLkcBUntBVdAt8WBqZFedXtLvuUntMxwT83uHgeYFVV6l5NDLdiH27HgU6LbW4lBrhOFC1O8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(376002)(136003)(346002)(396003)(53546011)(26005)(31686004)(8676002)(2906002)(4326008)(6486002)(186003)(16526019)(83380400001)(86362001)(16576012)(316002)(7416002)(5660300002)(478600001)(54906003)(31696002)(36756003)(66556008)(66946007)(52116002)(66476007)(8936002)(956004)(2616005)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eTlZY2xOMXE1eDdvSE0ySFlYS29aNWxhZXgzMThhcGgxcWxJaWp1NlVCM3I5?=
 =?utf-8?B?c21OT2x5QTlvam5kQUpIb2RxcnBTMEQ0MHJWNTlRV0lMUytGV05PNDlIdE96?=
 =?utf-8?B?MHlwU281N1Z0a2drQVMrNmwzMHRVUlorcEpINE1OZlBQNERoNXdlQnVwQ1Nz?=
 =?utf-8?B?RXVjelY3WU1lSlBVZUl0OEhWNDNVRDlQT1pyVWxLWkUxWm5rTmkrTHVtOEF1?=
 =?utf-8?B?T2h1RnhjTXliTEUwM2xWaVVSNDJnUGJSeVR3Rm9wS3EvZmNzbzZyWWEvMkpW?=
 =?utf-8?B?ZSthWHEzMVVMaWp1NGc2M1c2ckxJbGlGd2l4ZytBeUhtUkpCRWFJVXdoQVVq?=
 =?utf-8?B?dGRjMjZnL1hKcDNUZitTVm9MakhadHJlZWJXSklPd2dHMmRlaWkva1N0M1Jv?=
 =?utf-8?B?aDVSdGVXVCs4YWlobXpEVExUbk41Zm90cVZTTmpLbUg0bkdpWFpTaC9vbW1r?=
 =?utf-8?B?R3llS1dFOG9Fd01mOERERkZmcE9jMGg1Qm05c2NtdDcvTThQY0dmVmdJWGhq?=
 =?utf-8?B?T3dWVm5hR3BHYlRZTjRmSzJsaU1hZXVXL0pXd0RFQ2V2SlRoVDJmOWpjL1JX?=
 =?utf-8?B?c2FZaTlqZGRsZ1RNYUZZZ3ptSDJqV3NkSWJUc21HODNOOUFsNnpWVmhiZkUw?=
 =?utf-8?B?cWdtejJubG96RGwwU2tuUXJLTk5oTWlhSTFsakY3OVNLL1pzcmJ2ZFY3Qzhi?=
 =?utf-8?B?Vjh5MGJid1JOblB3L1VkOHpSL280U3M5ZW5kK2RzR3ZMQkw4Q1FQL2hXQ290?=
 =?utf-8?B?aWNwQ295ODNkejVvSG1LOURlVFR4S1RMM3BCZGRPZmgxT0t5ZnlSVDRqbGF2?=
 =?utf-8?B?TWtvRVR3dm9kRm9xUWlVQXhNZXdqZTNoVVorNEhVOWU2U3htckI0N2s0K2s2?=
 =?utf-8?B?VTk3RVhWK0pLa1Vtd0srbGwyVWxLV29YZVMrYlRiTmV4Qlk4dFZqdFpuZmE3?=
 =?utf-8?B?UDVrRlE4M3RhRm5aQyt5eDloMkRWS2k1c0FLM2lvOExQK28rWVdpSnNaZkZY?=
 =?utf-8?B?ejIrZm14Mlg3a3lVNVpacmhkRXJYb2ZFZk9UcXpIZzYxQzhCMi8vS0VYS1NF?=
 =?utf-8?B?dTh6Q3V3ZDNXQ25JU01ZZ2FHVFI5L0J5Z2VqSFFVenpocTJlRWkxenVtSG90?=
 =?utf-8?B?ZU5IeUkrLzZpQkhSMFZLNVg5REpoa1J4Qng0SmhrWHE0L05ieGUvb3FmeWNZ?=
 =?utf-8?B?K2diSThub29veCtiRlpULzZSSDJXdUZ1ckNUQ1pMcmtybUZSYzcyK01yQnBI?=
 =?utf-8?B?cGpZNGt6OVJva1VCVXhBWWFOR0N3cFZ6di9BTHkrUjJxcklNWnhMV2ZQL1Rp?=
 =?utf-8?B?RzVodnpDbXRiVmUvVjFBRjBsNVIzL3E1Z1pZbk1UUmNyTHVtalRrejhIWnN6?=
 =?utf-8?B?ajZZWnNyYXJvZG1EWEhjSTNvRng5Vk5xajEvL0NWb3JWbDc1b3I2VHlMSURC?=
 =?utf-8?B?VE0vb3o0S3VwWUR2cFd1cFdrMXdYSGlrY0JEVUtKa2V0ck5HVUpsUlJMTHJx?=
 =?utf-8?B?b2xZYlZ4ZkRWNGZuaVZIWXNSL3RXck9XQUNuYnJNeitFek8rQ0srdm5UL3A1?=
 =?utf-8?B?NU1va0tqU05lRDc5TnN5bS85eE9WTmJVVmJqV0djbFd0bFJjSnpaRHM0SXdj?=
 =?utf-8?B?K09vV1hRTFpRRDBGcmNua1BXR3Fwb2NrOFA4S2NzalVCQWRDWGNQcUYwS2FS?=
 =?utf-8?B?ekVYVm9WMVRFT2tkOHNSczVtV25DZGc0TFpvRXkvbHdBWk1MK3ROQXBUN3A2?=
 =?utf-8?Q?5AjPRnMFNFPfjsJKdxt8v2waiTUsDVcmXh/jh56?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0c1b107-11e4-4e84-361a-08d8c88faf07
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2021 22:04:32.1086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UQ86tWmb/uFneE4W12aZTf+9A38PQvHyajV0Ws+AQwcGtJOhudGVvqSeiyAL9GfRANwI7Sa+KjylT/pfKH3NEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4579
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9884 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102030133
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9884 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 impostorscore=0
 mlxscore=0 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102030134
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/21 1:08 PM, Peter Xu wrote:
> This is the last missing piece of the COW-during-fork effort when there're
> pinned pages found.  One can reference 70e806e4e645 ("mm: Do early cow for
> pinned pages during fork() for ptes", 2020-09-27) for more information, since
> we do similar things here rather than pte this time, but just for hugetlb.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  mm/hugetlb.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 71 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 9e6ea96bf33b..931bf1a81c16 100644
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
> +	__SetPageUptodate(new_page);
> +	ClearPagePrivate(new_page);
> +	set_page_huge_active(new_page);
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
> @@ -3816,6 +3832,54 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>  			}
>  			set_huge_swap_pte_at(dst, addr, dst_pte, entry, sz);
>  		} else {
> +			entry = huge_ptep_get(src_pte);
> +			ptepage = pte_page(entry);
> +			get_page(ptepage);
> +
> +			if (unlikely(page_needs_cow_for_dma(vma, ptepage))) {
> +				/* This is very possibly a pinned huge page */
> +				if (!prealloc) {
> +					/*
> +					 * Preallocate the huge page without
> +					 * tons of locks since we could sleep.
> +					 * Note: we can't use any reservation
> +					 * because the page will be exclusively
> +					 * owned by the child later.
> +					 */
> +					put_page(ptepage);
> +					spin_unlock(src_ptl);
> +					spin_unlock(dst_ptl);
> +					prealloc = alloc_huge_page(vma, addr, 0);

One quick question:

The comment says we can't use any reservation, and I agree.  However, the
alloc_huge_page call has 0 as the avoid_reserve argument.  Shouldn't that
be !0 to avoid reserves?

-- 
Mike Kravetz

> +					if (!prealloc) {
> +						/*
> +						 * hugetlb_cow() seems to be
> +						 * more careful here than us.
> +						 * However for fork() we could
> +						 * be strict not only because
> +						 * no one should be referencing
> +						 * the child mm yet, but also
> +						 * if resources are rare we'd
> +						 * better simply fail the
> +						 * fork() even earlier.
> +						 */
> +						ret = -ENOMEM;
> +						break;
> +					}
> +					goto again;
> +				}
> +				/*
> +				 * We have page preallocated so that we can do
> +				 * the copy right now.
> +				 */
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
> @@ -3826,9 +3890,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
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
> @@ -3842,6 +3904,10 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
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
