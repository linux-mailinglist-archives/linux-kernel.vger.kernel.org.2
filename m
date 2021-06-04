Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1084839C2B9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 23:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhFDVoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 17:44:00 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42994 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbhFDVn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 17:43:57 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 154Ldq90066350;
        Fri, 4 Jun 2021 21:41:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=8qK+eQvSTQdlrf58eYGev4aDXhJyK/k4izdPnR/iJcY=;
 b=dN/vus0zHyV7scSHl3Iq1UFfdTWZWslO+xHxBN6jFGvi72VgTSUMu62TXFKooh9UkumK
 +Uat8wch11k5AUiM3nUBpERKYTCjrXQbsIv7pUeaJH/JFsIxFVx1PzK75l/JNJ+pEULY
 7CuCtm1J2fAMmEzvWJf2YIlmVqy72ePF+0cwqxO/jQ5mOBiiZbp+XVOv3uIO7TbI1G/W
 TYprWrIVl73QkHx4nXJYAkrho3rdwIDPtxttg98q7umDDApimaiLmEkaicDEIgpny3GX
 BNKzjRzz/im1Swu6aQaLDTc2T+30mxVc8QHMD3IwikbAoFnkgAflC/S45rKcW1r5ynnu Fg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 38udjmxwnd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Jun 2021 21:41:32 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 154Le9rV079790;
        Fri, 4 Jun 2021 21:41:31 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by userp3030.oracle.com with ESMTP id 38uar0mfrc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Jun 2021 21:41:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d58yLKXFMDW/z5rLu5WuY0kMli/AVhI96HoCp1m5/3592/9w1xe9P9/YYHKOXMYMf7imkPVVScZVJnCNkwGTzxOdWqUX/KKgV/XrOZ3NlZ+oy5nN98P0AMudlAnalvXtpFlGLiuJugNGagpmcxbVe9TYEFabbNJHogwAv0sqIYh7WG+HtxttePHvjUQyeeejqhEiyK492iytVxnsjuemhsQFWxS/DmlJ77Q2XRulj4lUFucDWLVIeHrZcoNnA/S6dRzFt4nL5gslpBBvZw8G3EkTsGDscy6vgkRHkwPRKidUBFdUsuUQttvAk0BueW606bYja6KmeQTpZ8WSRhNDXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8qK+eQvSTQdlrf58eYGev4aDXhJyK/k4izdPnR/iJcY=;
 b=S8FTFtT4For+1QjxYe6uiAytKAnVO+WeK1UfoePkW505FTohJDHnJqgZq3T1OhBsVjqktoTWDkcrFi2Tfs9FR7buJKS4I82ruAF0XE/dJ5rEJai/VQNYJ550pMZFSLYX21EoFznNMJjETCPQlEXkbODiwGCje5Dz/GTyUD6iGaL7Xf8mJ2d4/EWlQBEZXgjDcTLYw7SeDrtP2asOikYR7CxGI6mOYeqjlHgcZnBNGoNoyYRWs3WnF2LnKf4fhyhhYraGjDJi/x5Z1CaD9005fA4JCHzcq0loCewQ2RYXFKScHkPGe8FseVt0tfZhwmPM60Oe2gk2NjcQfWpsmNCsug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8qK+eQvSTQdlrf58eYGev4aDXhJyK/k4izdPnR/iJcY=;
 b=cgXx9M061I7EYS9m/MBQJeUIGxCBMjtV02pQjL5LC500DM1xKaWbjY4ZSWxxnycMej71LMF3TR19NNmbsAoABQGbTU0KBt/DtCtVZOIXwK37oesCDIiHeSLlH9bLLYppPOKg0Q2WzmTLfJ8NPN87lqMKx7EwIHkeEL9JW2cOgb4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4114.namprd10.prod.outlook.com (2603:10b6:a03:211::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Fri, 4 Jun
 2021 21:41:28 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90%9]) with mapi id 15.20.4195.025; Fri, 4 Jun 2021
 21:41:28 +0000
Subject: Re: [PATCH v4] mm, hugetlb: fix racy resv_huge_pages underflow on
 UFFDIO_COPY
To:     Mina Almasry <almasrymina@google.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <20210528005029.88088-1-almasrymina@google.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <1fd32aad-c99d-e89a-cdb1-05843f568f0c@oracle.com>
Date:   Fri, 4 Jun 2021 14:41:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210528005029.88088-1-almasrymina@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR1401CA0024.namprd14.prod.outlook.com
 (2603:10b6:301:4b::34) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR1401CA0024.namprd14.prod.outlook.com (2603:10b6:301:4b::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22 via Frontend Transport; Fri, 4 Jun 2021 21:41:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20850985-d821-470f-4c33-08d927a1829d
X-MS-TrafficTypeDiagnostic: BY5PR10MB4114:
X-Microsoft-Antispam-PRVS: <BY5PR10MB411469EE104B88530E9861FFE23B9@BY5PR10MB4114.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tnGhe4onO7quhql757YYQ03pSAeoFnuQDMfyxaoLyViCalchwUG0LD19xZiaKPrvGc3cdQSAGWe4wKm6LeIf3R6ZBFypOzAptxYfh337VjOwwFt6mlqnBhseJCbLeITVXsr+znOI8iTYr9UvIsh8ML90m9VV/l86RYg/Koxr7CM52xzxNK/l1cnl/JTGTLv8OBy2PN/iHu+3CxEi8wuHEzV/EU1NVcdeI44wXzu+kUx6hM9LZ6iMM5rEPqnbPypfc1IrVdqJvoJjn2xHNtp72kUEuczDTtov1xdyapShfkAbpJLWskYrkBDVBgsRoGtU3NOZLniabJblEw2a4eXnUnBXcH7DUkslPhdpTrlLUKrGtqJVws1Eewlr1CIeDSvFY7jgXTCG0nwtV6XZWLXbfGqtKScWLerOsRVx+hKdsjKX2elF0upN+x3J12Hw50ez94tzDj8hnf01PkjHmBl212am/rY3tW962j/dfbloEfKDhjP930upCCNNBqwXlSzwiqyeksDfaFYYqFKhi6GtPU8A3bblZUhmktVsKzdI/coyrspUGKSce7jXp4QT4mLR4e6LoYmqFq1RoDXVh2DJD1lWPlC73hIxCmjW8/y+qttRTqaI4LYvM7YLuKmJEGiLRp9vjRcldADcloECpxwvI5HZxC/Lmw8R2tedNNyy/ZwGauffAo2hyu+OKWTxdvhi+c+RgVpipz0djxYries7eS+QR/75TiwRXMwsIs7pqY9hfbinz9qfgaQ54c1gwHCA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39830400003)(366004)(376002)(136003)(396003)(86362001)(38350700002)(4326008)(38100700002)(8676002)(31686004)(2906002)(8936002)(2616005)(6486002)(31696002)(956004)(54906003)(66476007)(44832011)(186003)(16526019)(16576012)(66946007)(66556008)(53546011)(83380400001)(316002)(5660300002)(26005)(6916009)(52116002)(36756003)(478600001)(14583001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TW1RQlZ5dk5XYjZnRTdLMFZ0ejBhSmhUNWhCaWl2VllzN3lwUDZUc0tNTTBj?=
 =?utf-8?B?MEhIRG9OYkt5dmtPSG1Xb3VGdDBpbFh6K2xzR1ZaT2g3WlE5U0RKRVYvWkNv?=
 =?utf-8?B?d3gvMlVPVkgvQmtrbHNkbnZ4RTRpTDdBaVNmSWhjMERGNTc2VEVLZ2dpZjUw?=
 =?utf-8?B?Q2U0bzJuVnY3N2dRay81dzdrNW11QmwrbGpTRE9vS1BHNXlBenJ5RGszVUFK?=
 =?utf-8?B?cWJPZmozelhQMzhLM0VTZDcrdlJnYVRIVUNoRCtsRHNHUjNETE1GL0l3TU5G?=
 =?utf-8?B?KzBOTXhLSllyRzR4WW54bDVqM3Jic0daOTJjZUFNSEs2YTg1ZkZiL2FQZkY0?=
 =?utf-8?B?UzErbHpyRjZ2RkkzQ3cxbkU4Nk1TTkhwZjJWVy9sSGlEUXJIQjFGbk4xRkNk?=
 =?utf-8?B?YktmQm8wR25hVGlXdGM5MVpMN0M1cmNLcXZheG83V1J5cGFmN0toK0V2QzRS?=
 =?utf-8?B?WVVoSEFQU1o1TFdoT05nMzdDZ0JYRTF5Rm4xSVFNZVRlN251aldDNDZGbEFI?=
 =?utf-8?B?R2ZWZ3owM0M2RVc5aU9XaDBENlZJTk42VXdYVFpwdlNmTGlXUlY4ajEvaEVM?=
 =?utf-8?B?VG1GUG5DQnNIeW12ejlEWXI1WElvTjdhWi9iK2I3WFRWRFA0UjFIejdzMFFI?=
 =?utf-8?B?NWM1UWJzWUJ6cFJ3RjAyblhJVGRia3JzYkJUUTN1TFlEalJQTVcvaXZVdWlS?=
 =?utf-8?B?YUdPRDJOUTkwQzlvaGFERGhETHU3dXNNQ1NBQzJWb1NCSVVKbTRlMElnMCtX?=
 =?utf-8?B?TFBRZEUraU5XYmJFaWpsaGVFRkFJWUJvQlVpQWxOalkyVWxvNkFENDZ3NWlO?=
 =?utf-8?B?aGRvSUVzT1pVWGxHNnJNY1d0N29rSWJOTWNHMWhUWlgzTGJ2RnpXNWp6T2s0?=
 =?utf-8?B?WUhFRDRRWVVtcmdteVNSL0xkenJGUG5YTGRtODQzdVlNa054Zi9PdHJ6blBM?=
 =?utf-8?B?L2YxY1U5aGRoTWtJMG1vMUVPemtRVzlUajZPYXUwOGw2OHVQdVBWSW5yeUVv?=
 =?utf-8?B?L283TjJud3k5QzIwRlJoRWVWbkZkNE41WUpqQW9qVnlNVElCTjNYdjM2Y0pL?=
 =?utf-8?B?R0ZYM1pYWGJBNjNpQ3hGek54bk1DcmRIemMxenhxaVBrbjI5czFZWkc1ci82?=
 =?utf-8?B?QnZ3VVN3OFJsUnJoWmN1Rit4WUorRDNIRWR5eGs4bEM4NEJlS0libDlhY3dB?=
 =?utf-8?B?ZVhyWERkTStjQ1RONTZpNWxtMG9BTzNJdEpOVGNlbjB6Z2hRSGRGaUF1YnFO?=
 =?utf-8?B?WTNndUtzZ0J1ZjhXUFBKaHh3MU16VU0yeEpIZW9wT2ttU0VwWDF3SkJteFNC?=
 =?utf-8?B?aFg3U0Joc0hzRWhUcG9wZFNpdlB2VHc1ZUdDUkhZSGhzTk5STFFqRExIQjEr?=
 =?utf-8?B?eHJLRjdlTG5nOGg0aExkVGhnTDErU24rbzhKTUpLbkhwTUF3SllNdy8zYkt2?=
 =?utf-8?B?T2FWbkV5L1VNR1BsZEFmdnRmcGNXNmNCWEhScm5jeEcxOTFSVEROaGlvY1Zv?=
 =?utf-8?B?WFRpZzI5ZWs2M1NOKzVoWWV4U2N1cjRtMHhCeGdwZHdoaWZqZ0NCcmVWT1F3?=
 =?utf-8?B?VWIwZEE1enhaQkRtWWZ0enJIOGRidTNLL1d1QVpmRmxJdVhJZEIxV2gvNXFU?=
 =?utf-8?B?K1ptemtHMllTUnJDTXV0UCtYcHJ1bmFXRTY2YVZlaE5PekVVNU5ya0RGUnhy?=
 =?utf-8?B?NEdDQlJYaEExN05xazBOUDQzeE11MVVuVGRDdmxnaUQvTCsycnZQRkJ6ZGxB?=
 =?utf-8?Q?Ml0u62Qa8oPHx/1LPtsKWPp+vcLLoRaLZmjexPH?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20850985-d821-470f-4c33-08d927a1829d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 21:41:28.5932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +xQrLlMOh1xeLzx5LNSdnTXnqPWL67znSWo85IocNrwsKIR7odNfeTkN0YAD9DrXoBKkhxynDznj8n7nvHG7LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4114
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10005 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=706 bulkscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106040149
X-Proofpoint-GUID: 4PM36Pyqx8dEO7p95U_WUFimQbO2HMB4
X-Proofpoint-ORIG-GUID: 4PM36Pyqx8dEO7p95U_WUFimQbO2HMB4
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10005 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 impostorscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 adultscore=0 spamscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=959 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106040149
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/27/21 5:50 PM, Mina Almasry wrote:
> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index 4bb4e519e3f5..4164c9ddd86e 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -51,6 +51,7 @@ extern int migrate_huge_page_move_mapping(struct address_space *mapping,
>  				  struct page *newpage, struct page *page);
>  extern int migrate_page_move_mapping(struct address_space *mapping,
>  		struct page *newpage, struct page *page, int extra_count);
> +extern void migrate_copy_huge_page(struct page *dst, struct page *src);
>  #else
> 
>  static inline void putback_movable_pages(struct list_head *l) {}
> @@ -77,6 +78,9 @@ static inline int migrate_huge_page_move_mapping(struct address_space *mapping,
>  	return -ENOSYS;
>  }
> 
> +static inline void migrate_copy_huge_page(struct page *dst, struct page *src)
> +{
> +}
>  #endif /* CONFIG_MIGRATION */
> 
>  #ifdef CONFIG_COMPACTION

I am not insisting, but it might be better to make the copy routine
available under the current name 'copy_huge_page'.
Why?
There is an existing migrate_page_copy() which not only copies the page
contents, but also page state/metadata.  People could get confused that
'migrate_page_copy' and 'migrate_copy_huge_page' do not have the same
functionality.  Of course, as soon as you look at the routines you can
see the difference.

Again, not necessary.  Just something to consider.  I suspect you
changed the name to 'migrate_copy_huge_page' mostly because it resides
in migrate.c?

> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 76e2a6efc165..6072c9f82794 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -30,6 +30,7 @@
>  #include <linux/numa.h>
>  #include <linux/llist.h>
>  #include <linux/cma.h>
> +#include <linux/migrate.h>
> 
>  #include <asm/page.h>
>  #include <asm/pgalloc.h>
> @@ -4905,20 +4906,17 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>  			    struct page **pagep)
>  {
>  	bool is_continue = (mode == MCOPY_ATOMIC_CONTINUE);
> -	struct address_space *mapping;
> -	pgoff_t idx;
> +	struct hstate *h = hstate_vma(dst_vma);
> +	struct address_space *mapping = dst_vma->vm_file->f_mapping;
> +	pgoff_t idx = vma_hugecache_offset(h, dst_vma, dst_addr);
>  	unsigned long size;
>  	int vm_shared = dst_vma->vm_flags & VM_SHARED;
> -	struct hstate *h = hstate_vma(dst_vma);
>  	pte_t _dst_pte;
>  	spinlock_t *ptl;
> -	int ret;
> +	int ret = -ENOMEM;
>  	struct page *page;
>  	int writable;
> 
> -	mapping = dst_vma->vm_file->f_mapping;
> -	idx = vma_hugecache_offset(h, dst_vma, dst_addr);
> -
>  	if (is_continue) {
>  		ret = -EFAULT;
>  		page = find_lock_page(mapping, idx);
> @@ -4947,12 +4945,44 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>  		/* fallback to copy_from_user outside mmap_lock */
>  		if (unlikely(ret)) {
>  			ret = -ENOENT;
> +			/* Free the allocated page which may have
> +			 * consumed a reservation.
> +			 */
> +			restore_reserve_on_error(h, dst_vma, dst_addr, page);
> +			put_page(page);
> +
> +			/* Allocate a temporary page to hold the copied
> +			 * contents.
> +			 */
> +			page = alloc_huge_page_vma(h, dst_vma, dst_addr);
> +			if (IS_ERR(page)) {

In v3 of the patch, alloc_migrate_huge_page was used to allocate the
temporary page and Dan Carpenter pointed out that the return value should
just be checked for NULL.  I believe the same still applies to
alloc_huge_page_vma.

-- 
Mike Kravetz
