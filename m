Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 300E038F2BC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 20:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbhEXSJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 14:09:37 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42414 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232789AbhEXSJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 14:09:36 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14OHn3vA115844;
        Mon, 24 May 2021 18:08:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=hD0+Koo0xOm1VK3QuQJM6963Yiu/OSSggWxwb2F/mAU=;
 b=P0PlNVaNC4pnfZZa7G8rnpXFIV/0SNHqLv6ra2E/4fy0N/LQGn8sN+JaG7SfPmzJWeEv
 Mi4N1TQ1Guf49qzeKLK4H+5q5N28OoIJ7wR2kKIb2PQ1Awxqz0plcbmqqfThXC9yxi4p
 OejM4PccqSRvea8vRtCYwE3XVRXrYhAK4T4sEOetWoxC+841ZHa+qFrOKZHQ8bey8y0H
 QS6PApZrCOpRLqQo+eiyjnchqcGD+couwJSH4QShYbwvYbZVxLtwUkzdWv4FMRAp1W4O
 9VvX3wVWoAPiDialCQDTm/gL8SGy3dl81a8Hz/TEM1jmlZGxs4fdfjmtb/D3vqj2zPQR Gg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 38pswnbtrh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 May 2021 18:08:02 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14OHpw58081732;
        Mon, 24 May 2021 18:08:01 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by aserp3030.oracle.com with ESMTP id 38pr0b6s5x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 May 2021 18:08:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MYX4pWsaBDNn19/dA10J20H49vl8mm0GWIvsSSEm3b7QvGyE9zwPYapCtScs3I66MesdtOkShf48wcVCu4E1wLEB9aVmVfHJz3riKCQimRBNs+N1V+OQ19as5q8GkiW9D1k8IOm4bqE50RFrCtlXUu0mgPSMLwrFZT3iwOUk1oZFEHMOzeApSVi98romNJkMCMwr8CYYk7Qz1RM/DjLNzTwSyoEK+XFPGp4o+Ok6MVF/77+0pVrWAlnrrqw1z4cqMHRDXZCDwXeuL3THLC7HBUeqnjiU1VieHTrBd45XQh7xcePhupdTw+zKHCkBJJjZvNB24Fa89FAfiDbDy8P19A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hD0+Koo0xOm1VK3QuQJM6963Yiu/OSSggWxwb2F/mAU=;
 b=WkUyrxJu3EtQ8u2lh27EX2DUAtXN1ZULxZqn7dxjc3G7KXmm3Wkvi6Od+8+0MU1gFDmJFNs4fvm3GJua1SaWoT2VTQdFtFajAzcGywj+Y91hYxs19JYKYkCrVbOtOObShorQUIoEf5VcVT1k0JizFJP+yKHdb1nhiW9hcK9FdG09kiXa2KFjL/7qBHiycFc1HWevaaHweKrzSZ7bHk+f3fJOiKNuB4Qlzb9Mrj0Wpcab2e3mnxriM9RQqBl04//Vi8XbjLs8kGakQqM2NtDeuxpa5yUpOweF/mm1pxJK9wTmZWvkRRNumjs+4GqE+3ZtpreD0zlG8MtJ1KnW7VM2Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hD0+Koo0xOm1VK3QuQJM6963Yiu/OSSggWxwb2F/mAU=;
 b=wfj0CbE00ILrIKjfiAIMft/Urdp+OCB6sMh5OKVTfbHC3WaIhSZGdSuR1baVKAqEqAIkK5mw/UFDhHRvV+9KhOc2tzBWtutZvPbGZQ66bYIigrO7pnkxvLtfDyZpuC2m99m7fluMJh9Y5cjk9Bf9qSlwMUxXGF3IGl/rpIXfydw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3400.namprd10.prod.outlook.com (2603:10b6:a03:14e::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.25; Mon, 24 May
 2021 18:07:59 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90%9]) with mapi id 15.20.4150.027; Mon, 24 May 2021
 18:07:59 +0000
Subject: Re: [PATCH v3] mm, hugetlb: fix resv_huge_pages underflow on
 UFFDIO_COPY
To:     Mina Almasry <almasrymina@google.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <20210521074433.931380-1-almasrymina@google.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <2a983662-ab90-0cdb-850c-eb50b0845b49@oracle.com>
Date:   Mon, 24 May 2021 11:07:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210521074433.931380-1-almasrymina@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR04CA0068.namprd04.prod.outlook.com
 (2603:10b6:303:6b::13) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR04CA0068.namprd04.prod.outlook.com (2603:10b6:303:6b::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26 via Frontend Transport; Mon, 24 May 2021 18:07:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e9aba8e-cf43-4f7c-5cb3-08d91ededd37
X-MS-TrafficTypeDiagnostic: BYAPR10MB3400:
X-Microsoft-Antispam-PRVS: <BYAPR10MB3400690C740F3024985A0BE0E2269@BYAPR10MB3400.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qiDdHWJ5FKSJccOTJu2MM/L0JUTaqEZANW3BgniLUJTpEbWAEU8YNeMxKMhX8Emy2LJfKxsVdfo0CBNisF1FAQq6O3PzvjsG6TcIaNjKPxQGghNolUn93BUu9XWXygoievY14xNTDuNSQJm9Ln7FTXerH5hNr5Izvrvs1gyPalmB+oF8KSRtELOtUVSaNc+D74ujCd+QSp6osytjpFRoSa6we9z/QxCWM5KEQSK8JtyknLkeQ6y0zTD7sNvLtZGrELAH8ZKt5a/OfLLnZISrzzXJJerJlOrv+b6iD+lJ+T8D7VZ3Of/3EFP90otdCdpPeKhbCO2fZET1AW+cbdIwXR9VvEQOdmLRy9D9+q7XSG0PcKCTGSPcc/bOf5KjVeg/i1oIzxPKcB4Tld3cuhOg9mUwEEOkqrx6t6g191TbIhayrsO5DqUuIN5iX2FTqI9EGeiZNu3+sPYZgxFEtqoT32hst1DRiwVw1a+IrOSBpzKzmhlKo+p7+EuCC0UhWI6uiSW7AHX80C5jvFhSsfrdF279ZE/B1X4wZvOIORhjGK1Ic4UflVnt2iDriZ024e5f/EsI05zfvFtWPxQqdK/JEK97lbiza3f2qVKRYY7a/OvgkEiobufIEfFINN5oB5kE+AAc/a2O+m68IzIH8iHq3wBOacyg3IVNAKgIALx+ZffVDhI0tRjx3Vwtp8TJVVwVK5MmaV6E5uKWiYjj9zjaXg2lbxHuJ6FqjRL9SU6Esyg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(39860400002)(396003)(376002)(346002)(83380400001)(30864003)(54906003)(6486002)(316002)(16576012)(16526019)(31696002)(44832011)(53546011)(31686004)(8936002)(5660300002)(186003)(2906002)(2616005)(956004)(26005)(4326008)(6916009)(66476007)(38100700002)(36756003)(478600001)(52116002)(38350700002)(66556008)(66946007)(86362001)(8676002)(14583001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WThGam50NG80KzNGZVkzRDNEVWgzb21kVC8ycXliYmNvSk9Ca3dMVCthSWpJ?=
 =?utf-8?B?TFUzOUpJbFRNVHBCK0EvMnhzM29jTWE2eXMvaTN3S0kwVGVlR1ljdHBKeHNN?=
 =?utf-8?B?b1IvcnIxZkFmQUJndWFtQmZxZnJjOUY3TFpoUUV5aER3d2NabmcrY1hRT2Va?=
 =?utf-8?B?b253OWoyZHZ1cDZhb0cvV3BWUlVvWGlvcS9la0tXVVFyL0U1ZUlzN1BRbGxK?=
 =?utf-8?B?UkRlRWNTUjV3YUZLUlNJMi9QSWtDTllTRzhRRlRxb215bHdLOXhQcTlIQ0ZE?=
 =?utf-8?B?SlNhVm9NbGJBTlFYd0UwVE9hZGpBSzZRMWlDdUwxakVaYWFTaHhQTDBBeFpO?=
 =?utf-8?B?WGtBZ1NYdmNRMDJjQStVdng3UWhvTHorcGlhTElHNVN6emZzbDNoRlhqamk3?=
 =?utf-8?B?SEZibFBCSEVnaUlTS3gzWTFpT1RlNm1rWjI5VnhFdW1ZanZKdWlFQ3hrZmlm?=
 =?utf-8?B?OUp5UU93NGZSRFUxUzhCQUJzeFFPZEhPKzZFaFJzVWxJZ0h3b3o0Y3Q0U3Er?=
 =?utf-8?B?cE1KYkRaZUlTeGVQcTJCR2hTNVFNZ3FxQ3RGRzNIZC9MUGpoSEVITkR3MVNB?=
 =?utf-8?B?TFVrS3NOdDA5NkZtdzlNRTF5citQTnFwTUVPck9UdzY3N1I3U0dCU0MrUmpD?=
 =?utf-8?B?QkVTRjBwc2Iza2E1VDY3eEdOWGFINS9iUkRtS0tsOUM0T1BIaHhvUFA2a2Jv?=
 =?utf-8?B?U0pUMWllSUpzcGt3R1M4alZ0VW9NNHdUVWN2TUZ5aTVFaS9uUlhHVUpCZHBK?=
 =?utf-8?B?MUM1ZjJ6bVBKeHRkWWVrNDduVlUzdXBCWTFFRFBEWTA2ZUNXK2krUC9zalNj?=
 =?utf-8?B?OWhYdjhmYXkvRTU5amw3bVNiQ1EzbG5HMUErZzRHZXl4KzFVZHVOZG9ZTmRp?=
 =?utf-8?B?cjdIdllpUDJZUytUQUxaQklFQ25seXRZYmJOaDltaTl2RHZPN0lBeVlQTnhR?=
 =?utf-8?B?a2ZEY2VhcTdrdGJEQUtHR0IzbVdQeTE1TFNKZkFXTmJpL3grMTRsNCt1TGhl?=
 =?utf-8?B?V1lOL3QrTC83b2dPekJ4N2J2M0xubG5CbCtFbVluSTBoUjZVVWExYWFURE1v?=
 =?utf-8?B?dFFVY0NDalRIR2pjd2hBMEU0cUpYTTBZWERhakFnaXFidHpnSmpCcVl0UUdL?=
 =?utf-8?B?VVdFbnFlM1JCSFRqUmZlRE5iYmN2Y2xNdU9nc1BiRng3dEhRYitNMytqTUls?=
 =?utf-8?B?QlNEbGlnWWdQS21SbDI3c05qa1JXVXYwUzR2RUFtRUpUTmhiWVBOOXM3NzBn?=
 =?utf-8?B?VVlXM3FsalczblFodjRiV0xieE04c1pTYVQ4ZGsrYzRsZW4zQVpCZUJQdmVl?=
 =?utf-8?B?UUNsaEpOTzVhOFc1RUhiQ2hIMk9hL0FaWmVXc0JEazhWd2tNaFpTdERzMUxK?=
 =?utf-8?B?SUlkV29icjByWGlaS2g2Kyt4TVljM3JQbjFJbHNpZGx2YTdLMnRXbVRHOTRu?=
 =?utf-8?B?QzV1K2JUUG5qMVhvTzlySkNQUzI0eFhkaEw1UDI1VEhSczUza3l0MDdhUHUv?=
 =?utf-8?B?VlR4SkMxZVp6c1VJY2hLMUNha01SaStXU2RZMjlUTzd2RUMvMVRzTGpIYkIx?=
 =?utf-8?B?UDk5OGJYbm1IbG4ya3ZoNkRCZjc5R1RBTngzYURza29LSHZsTlNCT3p6cDZ3?=
 =?utf-8?B?UjYyNkJUN21xa3RnQUZvZ21rSVhZWWdvWXhPTlEzNjdWQnVLTUJJTmJaZ0sr?=
 =?utf-8?B?azluYWNSbWJIU0FFbXFOdENUb3ZKU0hYeUVhbnBKZGlaZXh4NHN3U3BXcC9r?=
 =?utf-8?Q?aN32o7WCrQ//j2oNbvr0NXWZSsA0Xth4kwMK85i?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e9aba8e-cf43-4f7c-5cb3-08d91ededd37
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2021 18:07:59.5867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O6czg/ye1pGD1IbNCUfhqFDWLsch5BcfM41o/ZKWVL1t0mVhpZfuXF2lFHL7vyVdSm0KH/2f8zobsXaQJLs+pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3400
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9993 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105240103
X-Proofpoint-GUID: aosH_8xlTUKWU-ehkRSsVL3yZ4MiwbgU
X-Proofpoint-ORIG-GUID: aosH_8xlTUKWU-ehkRSsVL3yZ4MiwbgU
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9993 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 suspectscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 malwarescore=0 phishscore=0 mlxscore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105240103
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/21/21 12:44 AM, Mina Almasry wrote:
> The userfaultfd hugetlb tests detect a resv_huge_pages underflow. This
> happens when hugetlb_mcopy_atomic_pte() is called with !is_continue on
> an index for which we already have a page in the cache. When this
> happens, we allocate a second page, double consuming the reservation,
> and then fail to insert the page into the cache and return -EEXIST.
> 
> To fix this, we first if there exists a page in the cache which already
> consumed the reservation, and return -EEXIST immediately if so.

Thanks Mina.

Andrew brought up the possibility of two separate fixes:
1) A simple one to address the common cause of the underflow
2) A more extensive modification to address all the error path code

I think this is a good idea.  You mentioned that the underflow is
transient and will correct itself.  That is true, however code assumes
the reserve count is an unsigned value always >= the number of free
pages.  If code like the following is run while in this transitive state,
we will run into more serious issues:

	/*
	 * A child process with MAP_PRIVATE mappings created by their parent
	 * have no page reserves. This check ensures that reservations are
	 * not "stolen". The child may still get SIGKILLed
	 */
	if (!vma_has_reserves(vma, chg) &&
			h->free_huge_pages - h->resv_huge_pages == 0)
		goto err;

	/* If reserves cannot be used, ensure enough pages are in the pool */
	if (avoid_reserve && h->free_huge_pages - h->resv_huge_pages == 0)
		goto err;

For this reason, I think the simple change sent to stable would be a
good idea.

Do note that the call to hugetlbfs_pagecache_present() which would be
used in the stable fix is not 100% correct.  See below.

> Secondly, if we fail to copy the page contents while holding the
> hugetlb_fault_mutex, we will drop the mutex and return to the caller
> after allocating a page that consumed a reservation. In this case there
> may be a fault that double consumes the reservation. To handle this, we
> free the allocated page, fix the reservations, and allocate a temporary
> hugetlb page and return that to the caller. When the caller does the
> copy outside of the lock, we again check the cache, and allocate a page
> consuming the reservation, and copy over the contents.
> 
> Test:
> Hacked the code locally such that resv_huge_pages underflows produce
> a warning and the copy_huge_page_from_user() always fails, then:
> 
> ./tools/testing/selftests/vm/userfaultfd hugetlb_shared 10
> 	2 /tmp/kokonut_test/huge/userfaultfd_test && echo test success
> ./tools/testing/selftests/vm/userfaultfd hugetlb 10
> 	2 /tmp/kokonut_test/huge/userfaultfd_test && echo test success
> 
> Both tests succeed and produce no warnings. After the test runs
> number of free/resv hugepages is correct.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Cc: Axel Rasmussen <axelrasmussen@google.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: linux-mm@kvack.org
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> 
> ---
>  include/linux/hugetlb.h |   4 ++
>  mm/hugetlb.c            | 103 ++++++++++++++++++++++++++++++++++++----
>  mm/migrate.c            |  39 +++------------
>  3 files changed, 103 insertions(+), 43 deletions(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index b92f25ccef58..427974510965 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -194,6 +194,8 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
>  bool is_hugetlb_entry_migration(pte_t pte);
>  void hugetlb_unshare_all_pmds(struct vm_area_struct *vma);
> 
> +void hugetlb_copy_page(struct page *dst, struct page *src);
> +
>  #else /* !CONFIG_HUGETLB_PAGE */
> 
>  static inline void reset_vma_resv_huge_pages(struct vm_area_struct *vma)
> @@ -379,6 +381,8 @@ static inline vm_fault_t hugetlb_fault(struct mm_struct *mm,
> 
>  static inline void hugetlb_unshare_all_pmds(struct vm_area_struct *vma) { }
> 
> +static inline void hugetlb_copy_page(struct page *dst, struct page *src);
> +
>  #endif /* !CONFIG_HUGETLB_PAGE */
>  /*
>   * hugepages at page global directory. If arch support

How about just making the existing routine copy_huge_page() callable from
outside migrate.c and avoid all this code movement?  If we want to do
any code movement, I would suggest moving copy_huge_page and routines it
depends on to mm/huge_memory.c.  That seems like a more appropriate
location.  But, I am fine with leaving them in migrate.c

> index 629aa4c2259c..cb041c97a558 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
< snip code dealing with movement of copy routines >
> @@ -4868,19 +4907,20 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
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
> -
> -	mapping = dst_vma->vm_file->f_mapping;
> -	idx = vma_hugecache_offset(h, dst_vma, dst_addr);
> +	struct mempolicy *mpol;
> +	nodemask_t *nodemask;
> +	gfp_t gfp_mask = htlb_alloc_mask(h);
> +	int node = huge_node(dst_vma, dst_addr, gfp_mask, &mpol, &nodemask);
> 
>  	if (is_continue) {
>  		ret = -EFAULT;
> @@ -4888,7 +4928,14 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>  		if (!page)
>  			goto out;
>  	} else if (!*pagep) {
> -		ret = -ENOMEM;
> +		/* If a page already exists, then it's UFFDIO_COPY for
> +		 * a non-missing case. Return -EEXIST.
> +		 */
> +		if (hugetlbfs_pagecache_present(h, dst_vma, dst_addr)) {

We only want to call hugetlbfs_pagecache_present() if vm_shared.
Something like:

		if (vm_shared &&
		    hugetlbfs_pagecache_present(h, dst_vma, dst_addr)) {

This could be a private mapping of a file in which case we do not care
about the contents of the cache/file.  In fact, it could provide a false
positive.

> +			ret = -EEXIST;
> +			goto out;
> +		}
> +
>  		page = alloc_huge_page(dst_vma, dst_addr, 0);
>  		if (IS_ERR(page))
>  			goto out;
> @@ -4900,12 +4947,48 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>  		/* fallback to copy_from_user outside mmap_lock */
>  		if (unlikely(ret)) {
>  			ret = -ENOENT;
> +			/* Free the allocated page which may have
> +			 * consumed a reservation.
> +			 */
> +			restore_reserve_on_error(h, dst_vma, dst_addr, page);

Good!

> +			if (!HPageRestoreReserve(page)) {
> +				if (unlikely(hugetlb_unreserve_pages(
> +					    mapping->host, idx, idx + 1, 1)))
> +					hugetlb_fix_reserve_counts(
> +						mapping->host);
> +			}

I do not understand the need to call hugetlb_unreserve_pages().  The
call to restore_reserve_on_error 'should' fix up the reserve map to
align with restoring the reserve count in put_page/free_huge_page.
Can you explain why that is there?

> +			put_page(page);
> +
> +			/* Allocate a temporary page to hold the copied
> +			 * contents.
> +			 */
> +			page = alloc_migrate_huge_page(h, gfp_mask, node,
> +						       nodemask);

I would suggest calling alloc_huge_page_vma to allocate the page here.
alloc_huge_page_vma will allocate a huge page from the pool if one is
available, and fall back to the buddy allocator.  This is the way the
migration code works.

alloc_huge_page_vma has the advantage that it 'can' work for gigantic
pages if some are available in the pool.  Note that alloc_migrate_huge_page
immediately checks for and fails if a gigantic page is needed.

If we use alloc_migrate_huge_page, the userfaultfd selftest you are
using will fail when tested with 'hacked code' to ALWAYS take this
error path.  That is because we will need two huge pages (one
temporary) and only one is available.  I believe this is OK.  As
mentioned, this is how the migration code works.

> +			if (IS_ERR(page)) {
> +				ret = -ENOMEM;
> +				goto out;
> +			}
>  			*pagep = page;
> -			/* don't free the page */
> +			/* Set the outparam pagep and return to the caller to
> +			 * copy the contents outside the lock. Don't free the
> +			 * page.
> +			 */
>  			goto out;
>  		}
>  	} else {
> -		page = *pagep;
> +		if (hugetlbfs_pagecache_present(h, dst_vma, dst_addr)) {

Again, check for vm_shared before calling hugetlbfs_pagecache_present.

> +			put_page(*pagep);
> +			ret = -EEXIST;
> +			goto out;

We need to set *pagep = NULL before returning.  The calling routine
__mcopy_atomic_hugetlb will BUG() if we return with an error code other
than -ENOENT and *pagep not NULL.

> +		}
> +
> +		page = alloc_huge_page(dst_vma, dst_addr, 0);
> +		if (IS_ERR(page)) {
> +			ret = -ENOMEM;

Again, clear *pagep before returning.

> +			goto out;
> +		}
> +		__copy_gigantic_page(page, *pagep, pages_per_huge_page(h));

See previous discussion about copy routine.

> +		put_page(*pagep);
>  		*pagep = NULL;
>  	}

Later in hugetlb_mcopy_atomic_pte, we will update the page cache and
page table.  There are error checks when performing these operations.
It is unlikely we will ever hit one of these errors.  However, if we
do encounter an error, the code should call restore_reserve_on_error
before the put_page.  Perhaps something like:

@@ -4996,6 +4996,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	if (vm_shared || is_continue)
 		unlock_page(page);
 out_release_nounlock:
+	restore_reserve_on_error(h, dst_vma, dst_addr, page);
 	put_page(page);
 	goto out;
 }


> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 6b37d00890ca..d3437f9a608d 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
< snip code dealing with movement of copy routines >

With changes like those above in hugetlb_mcopy_atomic_pte, we should be
able to remove the following code in __mcopy_atomic_hugetlb.  We can do
this because any page returned/passed to __mcopy_atomic_hugetlb will NOT
have consumed a reserve.  It would be a nice cleanup as that big comment
explains how we currently guess what is the right thing to do in this
situation.

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 63a73e164d55..e13a0492b7ba 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -346,54 +346,8 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 out_unlock:
 	mmap_read_unlock(dst_mm);
 out:
-	if (page) {
-		/*
-		 * We encountered an error and are about to free a newly
-		 * allocated huge page.
-		 *
-		 * Reservation handling is very subtle, and is different for
-		 * private and shared mappings.  See the routine
-		 * restore_reserve_on_error for details.  Unfortunately, we
-		 * can not call restore_reserve_on_error now as it would
-		 * require holding mmap_lock.
-		 *
-		 * If a reservation for the page existed in the reservation
-		 * map of a private mapping, the map was modified to indicate
-		 * the reservation was consumed when the page was allocated.
-		 * We clear the HPageRestoreReserve flag now so that the global
-		 * reserve count will not be incremented in free_huge_page.
-		 * The reservation map will still indicate the reservation
-		 * was consumed and possibly prevent later page allocation.
-		 * This is better than leaking a global reservation.  If no
-		 * reservation existed, it is still safe to clear
-		 * HPageRestoreReserve as no adjustments to reservation counts
-		 * were made during allocation.
-		 *
-		 * The reservation map for shared mappings indicates which
-		 * pages have reservations.  When a huge page is allocated
-		 * for an address with a reservation, no change is made to
-		 * the reserve map.  In this case HPageRestoreReserve will be
-		 * set to indicate that the global reservation count should be
-		 * incremented when the page is freed.  This is the desired
-		 * behavior.  However, when a huge page is allocated for an
-		 * address without a reservation a reservation entry is added
-		 * to the reservation map, and HPageRestoreReserve will not be
-		 * set. When the page is freed, the global reserve count will
-		 * NOT be incremented and it will appear as though we have
-		 * leaked reserved page.  In this case, set HPageRestoreReserve
-		 * so that the global reserve count will be incremented to
-		 * match the reservation map entry which was created.
-		 *
-		 * Note that vm_alloc_shared is based on the flags of the vma
-		 * for which the page was originally allocated.  dst_vma could
-		 * be different or NULL on error.
-		 */
-		if (vm_alloc_shared)
-			SetHPageRestoreReserve(page);
-		else
-			ClearHPageRestoreReserve(page);
+	if (page)
 		put_page(page);
-	}
 	BUG_ON(copied < 0);
 	BUG_ON(err > 0);
 	BUG_ON(!copied && !err);

-- 
Mike Kravetz
