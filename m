Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B64A2368921
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 00:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239136AbhDVWrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 18:47:04 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:8052 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236851AbhDVWrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 18:47:03 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13MMgbip020532;
        Thu, 22 Apr 2021 22:45:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=vxP4RtLpJgnI0PPkLUwX1pYLS0obWMwAOK6E9xX9vlE=;
 b=ZUAYeKTvHtFp+M8V7Ra+q0+2vvAFXOwY0mNocyDr4TYez3oBW0l9r/ItQIH+BSnPoEaK
 XeKPo8wyjw2X23XQgXoWKDZqCmVyQfvFzyEtgw4tcGuWKhseO14nSYaefgDm6IxZ1D9i
 8b6gcL776ys08UEYZki7UFcjfRt+lDDjsZw4fTnxATtIcsNFLZHb3of14nTL75Pgdu9t
 +3JCBXC3Y8V9JhZ2FVw6OQkRdJ+6SJmQjWh+PAPf/8NExp5XLmcQCTKZ24tniDLFjfKv
 mq0E5Xc129ST+Y1riaiHE2Onlx1xLS9BKvpD5qrra+NMgGPEUfIU8KcQnzqMYwXppv8C Jw== 
Received: from oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 383duh82xj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Apr 2021 22:45:45 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13MMjif1008060;
        Thu, 22 Apr 2021 22:45:44 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by userp3020.oracle.com with ESMTP id 383cg9pq16-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Apr 2021 22:45:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B7vtxFARzzTzPbJKHlnFq/zCwyNrgN7xgx6FJnbKSibFLWeYcpghEnGpYES9eYg6Nc//7I14+mSfVUjyunTapT6KAuMyxDEoD4Wbg89VGBl5JsbXNxir8wSBPLQJZAKB/AtyvztclxLse1A4JzP3uaj0lENgC8Av1ShkDuxEKBQrffgJuUemI7RGzGt7/zpbWeXev/aAWSdrM/6nouB3Q9e7lTvUyEUaHbnOWCQgaMCWCNjLxEYjfv0GUkYaDuTFgx8FdnGNnmZeSeLliiLDBGaX6fJ1pMVrhgwukkK1SEIGA1Vq3Xczloh+Zlpro2z3QXDoC+NRVAZREU6JcFqVtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vxP4RtLpJgnI0PPkLUwX1pYLS0obWMwAOK6E9xX9vlE=;
 b=LJ4LooVCJLoBeWhTOZ0JkQGNcCFHkREHVKc3qC99pjMA8mqmaZLimvbs9JEbynN4BPCIt0ORGSqY611RVGGbLbqwynSl/QT+fEyxp00Yz6C3Vc88jeAC/qGvFZNyAtCSFxOdHxuBlz8EyVkYCaIqOeJLFyChJjXlDhGmrZbG5t/5wKjOjuriF+G0AprRbebugJ9BvkzWm/rg5NaoqTJtUrJry0yQNyVRQ2Xm+PN992v1yHgAzdYU80G9RAmNEla4Odbmur5uNzwJ1xcf67NbW6gxtJKL87wg7uCDvYKFZZpgtPEWgXUixm9V9rFrNpS2JQ3fDutuSSX+LPBdLSziaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vxP4RtLpJgnI0PPkLUwX1pYLS0obWMwAOK6E9xX9vlE=;
 b=Nuo1XP3M8QhFO8B8QmFbM9FQujbnOuQY93/lz+6bP5XKCSPnaDAVGLsMSjU9F4T999m4SFGmPyHimm/IS1fKpGBZ0uWVqAkwcKzwVzBpuenOoZy2XvKfE5OXpTab2UTVQMI9q0tlB47OCWiBh4XnjIp97eup2NA1+dcSBbv6SPY=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3687.namprd10.prod.outlook.com (2603:10b6:a03:125::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Thu, 22 Apr
 2021 22:45:42 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%7]) with mapi id 15.20.4042.024; Thu, 22 Apr 2021
 22:45:42 +0000
Subject: Re: [PATCH 19/23] hugetlb/userfaultfd: Handle uffd-wp special pte in
 hugetlb pf handler
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20210323004912.35132-1-peterx@redhat.com>
 <20210323005049.35862-1-peterx@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <3178f1ff-f8da-7fdd-68ef-8c35972ca2e1@oracle.com>
Date:   Thu, 22 Apr 2021 15:45:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210323005049.35862-1-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR14CA0027.namprd14.prod.outlook.com
 (2603:10b6:300:12b::13) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR14CA0027.namprd14.prod.outlook.com (2603:10b6:300:12b::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend Transport; Thu, 22 Apr 2021 22:45:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fdcab50a-647d-4768-15f0-08d905e05b87
X-MS-TrafficTypeDiagnostic: BYAPR10MB3687:
X-Microsoft-Antispam-PRVS: <BYAPR10MB3687677283ED82B7FDFAB65CE2469@BYAPR10MB3687.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8HzFKzm/5bLcVxqG+bhv1xLCrK0I6dL2mhz0w0gjSVHbwb+H9Rld0ACH5WPi4K9wPYSuoq6Nz5GrAyzlxR+GCB0SCrufVO3P50ELeH1QAAN13pp0dhxIHCVLnja9i8k4JtTF5gf1jAJhGlM44T9G2/PeSJOFPNJBCSxDl8KpvFsVZ5OzviDfadfBm7dys7W5J+nuzd8Lw1o+AQ9NIhmdUkB3rp5ogLn9P5VRR22gm7ZJXXcidoJxLrK45LEvKEBXu6xQyQOTHYo8xr1rDqkSzrr8tN19YeHVjZ95OW8hzu2LfSRRD8XdLsfHbMpE4tSLL31Ct26xEpTVUJCI6PqDNonO54PooGSktKBaDydBbsiv41j7L9jDc6jQhaeX97Nk3zQHxtZ6LJ1sIvJsx5KgwOe7B1rYvooA4cC0BHuxsoLnMuX7yKLl1T0R3eQSyR/MzdLyS9pWYpqIxSPZnKxS13ocBk7SEoyiSdB4Fo/n42NAk7L5NgzlnCg0bDmIKc0wDeXEtmfx6m2pRCBd8JSxEGl6PKWUbomp5WrFxVseyA8SlqZyDO0UuQ6QCTwbwmhQYZDakyil9KvV8Y8GOTlBAfgGorK5r8H1gzud5xFicClK+Ghknk4WydWZY4TqP4MkGT3KB9+3RC+rMDilrAxoXH3IldtWNwp4Hv8kMGKiWaR0tGhweXw7XEJy2W90ncrKBTjwk8X18Bz7tyyRjxrpdg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(136003)(376002)(39860400002)(366004)(478600001)(66556008)(52116002)(5660300002)(66476007)(16576012)(16526019)(53546011)(6486002)(66946007)(7416002)(8676002)(86362001)(38100700002)(26005)(36756003)(44832011)(31696002)(38350700002)(54906003)(83380400001)(956004)(2906002)(316002)(4326008)(8936002)(2616005)(31686004)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aGhhM3hYOE9VL041Tm9NZjJRT05EaXYyNVF1YUdMQ0NPSHBCUHBqWUlUNTZq?=
 =?utf-8?B?ZXk2MDNhWEtYK2xhTkpKVlFtWlg3bHBLL0ZrN2tLb3ljWnBtakp4K3RuQXQx?=
 =?utf-8?B?NnNtR25tRWIrbjlnY3RaYjhpajFaM2tBNmNmWE9GMW9NQWo5MTJycWlEejJt?=
 =?utf-8?B?d2ppNmJHbENLMjBjR2YrUXZYSHF1aGkvVVlPczJSM0JIelpDNFVmMkZBV2xu?=
 =?utf-8?B?U2FKamZXY0ttQmZvZlJHcTNoTWNFTVBrZlpFSkRXNmkxekJwd1BMYUxjYlFn?=
 =?utf-8?B?b0NqQm45K0xUZXFpS2dRKzlqS2hHQXlxT3N3Z1R4ZnNNVGtiazdLZWRRRThO?=
 =?utf-8?B?NU9xNC9McXFjVTNoL1V1LzcwbW4zNFhUUitVVERaU1hiR0M1THkwdVl4Zkg2?=
 =?utf-8?B?UXVLTUR2VkdVQ1JuMkpxTFl4THlBdXFkQmV1Z1ZsblhhV2c3L0hOSWlBeUVG?=
 =?utf-8?B?ak1KdEhZdFdXL2gvYmpEQkN2SXFwcXRMMjM4ay9iWEYrMUxmdHMyS3lLOC84?=
 =?utf-8?B?MHpmVXFLOU5tWEpkUFVmVVJDYlZaZWo5NEszTWg2RGtmVTYzenlBSDJSRmNz?=
 =?utf-8?B?VUlaSWVuZ2JHVHVHSjJZVDRRU2dNeFNyMzV3QWhtekY2MFhaZy9sbFRJRUlG?=
 =?utf-8?B?ckNVcWpVY2I0K2pCUDlXbVdPL3E4azJGVGFrR0thK3JwSVNoMjB5STg1ZnE2?=
 =?utf-8?B?azdCSXhVb3JKQUU2WnZUVWsyMDFoRTJxNFEzbi9yZ3JIYVowVklFbnRrU2ZF?=
 =?utf-8?B?czRDREx6SVJuNkNuVkFyMjYvQWVhS2FZTkZlUm5JZW5UcExVYlYvY0o4KzVw?=
 =?utf-8?B?WVBxdGppNm9mV3hZdHBHbjJ0VWNrWmJRT1F2eHhYOG1aYUxWUTJIcjdLeGdG?=
 =?utf-8?B?cEZrcmo0RU1LaVJTT2J4TWJINEVvR0Z0SWFJZnFvclJqdy9sZk8rb3JpY2Ew?=
 =?utf-8?B?dVArTGdrTXBuRy8xdVlhV250UnBBN1dZcHlzWmpqTnRxL2FzZHpyVmpsb3pV?=
 =?utf-8?B?MjAvOXNaYTRDV0I3REZMQ1ZMMVRhcEdNcXVXcks4eWZrUEFRR3R5Y0Rwckgx?=
 =?utf-8?B?Rk5PK1FHdUxLZC9EN093SFZpN2J5M1MveVpranVpMnBmTnBUU1UwZjJVVlc1?=
 =?utf-8?B?UkQ1Q3BFdjB5NTQraVJoamlTM21QMW5va3BHUFNHa2pJSmNydmo4cy9TdXRw?=
 =?utf-8?B?Tk1kM1RCc0tDK3BYY2FKcW1DZldKNWdRNFVXQXJFQ1R1RlI5VDhsT2ZodVUz?=
 =?utf-8?B?NmZLM1d5dWEzWFpCcFR1dEVpdXBYUncweUZqWS8rTm1BQTE0NGNPMGQ5ZXNB?=
 =?utf-8?B?NEd1VndEaDlnQURwV1RXZW5GZEFtZVY0Tm9CcVExQ1JIbWYvZkNqd2l1NHlw?=
 =?utf-8?B?bDRZK0pneis4SU9HaEVHR21IZWxDRXIxN3VFL2dBZXc2MlpOZVBoZEYrcytQ?=
 =?utf-8?B?QzhiOVB5N0k3NjFjb3N6d3F3eDdiSWxCYTF1dWY2ZGhrWW15VkpNZkM3c0tl?=
 =?utf-8?B?em9TMWVMRVBnanZwUFFtUzRDbm9ud3JmbjVQbHJqU0R6bXlNSWVTdm5QTE8y?=
 =?utf-8?B?YUx3YnZUazBxM3lWK0g2bWtJS3lLOVYwajQ2NFZmbDVWUTg4NDdEWjFDTmtB?=
 =?utf-8?B?RytWN0Y1bXR4b1FqaUlFQWlGQTVneFdKRi93NnllcHFubWFRN0NLVFNQck9i?=
 =?utf-8?B?eHJLQ1NxNGorMHdpVkxZRzRKSUlmMTZwT1NOYWpqc25mOUdFK2FFWjQxYnlK?=
 =?utf-8?Q?onvNI8xjjVaTmCDcim8Blya07f5qGq01RxqWxN8?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdcab50a-647d-4768-15f0-08d905e05b87
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 22:45:41.8836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vmt0OGReT9+JsAMi+x2YrhRQZSfo1D2aBB6rWy+ASMYbNiLekRDkt7pTHcUQITdHh6pWsU7w5wXQ0Up59t9HOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3687
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9962 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104220165
X-Proofpoint-ORIG-GUID: fxH1He8o5mmdp7JdZMNkkoMmvONanqsd
X-Proofpoint-GUID: fxH1He8o5mmdp7JdZMNkkoMmvONanqsd
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/21 5:50 PM, Peter Xu wrote:
> Teach the hugetlb page fault code to understand uffd-wp special pte.  For
> example, when seeing such a pte we need to convert any write fault into a read
> one (which is fake - we'll retry the write later if so).  Meanwhile, for
> handle_userfault() we'll need to make sure we must wait for the special swap
> pte too just like a none pte.
> 
> Note that we also need to teach UFFDIO_COPY about this special pte across the
> code path so that we can safely install a new page at this special pte as long
> as we know it's a stall entry.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  fs/userfaultfd.c |  5 ++++-
>  mm/hugetlb.c     | 34 +++++++++++++++++++++++++++-------
>  mm/userfaultfd.c |  5 ++++-
>  3 files changed, 35 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 72956f9cc892..f6fa34f58c37 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -245,8 +245,11 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
>  	/*
>  	 * Lockless access: we're in a wait_event so it's ok if it
>  	 * changes under us.
> +	 *
> +	 * Regarding uffd-wp special case, please refer to comments in
> +	 * userfaultfd_must_wait().
>  	 */
> -	if (huge_pte_none(pte))
> +	if (huge_pte_none(pte) || pte_swp_uffd_wp_special(pte))
>  		ret = true;
>  	if (!huge_pte_write(pte) && (reason & VM_UFFD_WP))
>  		ret = true;
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 64e424b03774..448ef745d5ee 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4369,7 +4369,8 @@ static inline vm_fault_t hugetlb_handle_userfault(struct vm_area_struct *vma,
>  static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
>  			struct vm_area_struct *vma,
>  			struct address_space *mapping, pgoff_t idx,
> -			unsigned long address, pte_t *ptep, unsigned int flags)
> +			unsigned long address, pte_t *ptep,
> +			pte_t old_pte, unsigned int flags)
>  {
>  	struct hstate *h = hstate_vma(vma);
>  	vm_fault_t ret = VM_FAULT_SIGBUS;
> @@ -4493,7 +4494,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
>  
>  	ptl = huge_pte_lock(h, mm, ptep);
>  	ret = 0;
> -	if (!huge_pte_none(huge_ptep_get(ptep)))
> +	if (!pte_same(huge_ptep_get(ptep), old_pte))
>  		goto backout;
>  
>  	if (anon_rmap) {
> @@ -4503,6 +4504,11 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
>  		page_dup_rmap(page, true);
>  	new_pte = make_huge_pte(vma, page, ((vma->vm_flags & VM_WRITE)
>  				&& (vma->vm_flags & VM_SHARED)));
> +	if (unlikely(flags & FAULT_FLAG_UFFD_WP)) {
> +		WARN_ON_ONCE(flags & FAULT_FLAG_WRITE);
> +		/* We should have the write bit cleared already, but be safe */
> +		new_pte = huge_pte_wrprotect(huge_pte_mkuffd_wp(new_pte));
> +	}
>  	set_huge_pte_at(mm, haddr, ptep, new_pte);
>  
>  	hugetlb_count_add(pages_per_huge_page(h), mm);
> @@ -4584,9 +4590,16 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>  		if (unlikely(is_hugetlb_entry_migration(entry))) {
>  			migration_entry_wait_huge(vma, mm, ptep);
>  			return 0;
> -		} else if (unlikely(is_hugetlb_entry_hwpoisoned(entry)))
> +		} else if (unlikely(is_hugetlb_entry_hwpoisoned(entry))) {
>  			return VM_FAULT_HWPOISON_LARGE |
>  				VM_FAULT_SET_HINDEX(hstate_index(h));
> +		} else if (unlikely(is_swap_special_pte(entry))) {
> +			/* Must be a uffd-wp special swap pte */
> +			WARN_ON_ONCE(!pte_swp_uffd_wp_special(entry));
> +			flags |= FAULT_FLAG_UFFD_WP;
> +			/* Emulate a read fault */
> +			flags &= ~FAULT_FLAG_WRITE;
> +		}

The comment above this if/else block points out that we hold no locks
and are only checking conditions that would cause a quick return.  Yet,
this new code is potentially modifying flags.  Pretty sure we can race
and have the entry change.

Not sure of all the side effects of emulating a read if changed entry is
not a uffd-wp special swap pte and we emulate read when we should not.

Perhaps we should just put this check and modification of flags after
taking the fault mutex and before the change below?
-- 
Mike Kravetz

>  	}
>  
>  	/*
> @@ -4618,8 +4631,13 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>  	mutex_lock(&hugetlb_fault_mutex_table[hash]);
>  
>  	entry = huge_ptep_get(ptep);
> -	if (huge_pte_none(entry)) {
> -		ret = hugetlb_no_page(mm, vma, mapping, idx, address, ptep, flags);
> +	/*
> +	 * FAULT_FLAG_UFFD_WP should be handled merely the same as pte none
> +	 * because it's basically a none pte with a special marker
> +	 */
> +	if (huge_pte_none(entry) || pte_swp_uffd_wp_special(entry)) {
> +		ret = hugetlb_no_page(mm, vma, mapping, idx, address, ptep,
> +				      entry, flags);
>  		goto out_mutex;
>  	}
>  
> @@ -4753,7 +4771,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>  	unsigned long size;
>  	int vm_shared = dst_vma->vm_flags & VM_SHARED;
>  	struct hstate *h = hstate_vma(dst_vma);
> -	pte_t _dst_pte;
> +	pte_t _dst_pte, cur_pte;
>  	spinlock_t *ptl;
>  	int ret;
>  	struct page *page;
> @@ -4831,8 +4849,10 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>  	if (idx >= size)
>  		goto out_release_unlock;
>  
> +	cur_pte = huge_ptep_get(dst_pte);
>  	ret = -EEXIST;
> -	if (!huge_pte_none(huge_ptep_get(dst_pte)))
> +	/* Please refer to shmem_mfill_atomic_pte() for uffd-wp special case */
> +	if (!huge_pte_none(cur_pte) && !pte_swp_uffd_wp_special(cur_pte))
>  		goto out_release_unlock;
>  
>  	if (vm_shared) {
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 01170197a3d7..a2b0dcc80a19 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -274,6 +274,8 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
>  	}
>  
>  	while (src_addr < src_start + len) {
> +		pte_t pteval;
> +
>  		BUG_ON(dst_addr >= dst_start + len);
>  
>  		/*
> @@ -296,8 +298,9 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
>  			goto out_unlock;
>  		}
>  
> +		pteval = huge_ptep_get(dst_pte);
>  		if (mode != MCOPY_ATOMIC_CONTINUE &&
> -		    !huge_pte_none(huge_ptep_get(dst_pte))) {
> +		    !huge_pte_none(pteval) && !pte_swp_uffd_wp_special(pteval)) {
>  			err = -EEXIST;
>  			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
>  			i_mmap_unlock_read(mapping);
> 
