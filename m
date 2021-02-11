Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF913182DC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 02:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbhBKA6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 19:58:20 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:48080 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbhBKA5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 19:57:07 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11B0tWoJ035740;
        Thu, 11 Feb 2021 00:56:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=rMmb7pREtLtxV/yjryHAOO3l6yTHNkrI7DuMRG6Zsl4=;
 b=cgxnwLPKekQyc2qr0Ut+eQSewZMgIPXIKr24y3kl2Z6JNtSQ4cc+zE/9zhORvLtumF0J
 Ijxx1vLjEzWMqvSPZZSekDNJnJjcxEGaGKh9tVcP3+WWz1kRnj0fVKx9s42OAOrJnvdi
 k0N6yGl+6XFjB1E8fcYqpukxh1Hiqp/Vw/Pz4IxugHKUqayMQHggvzjtfb3sxqECw3uF
 +/Qtr10TIOBx53j3gL+Cj4vsFZdalfsBIz1mOmQUemJGJQu9v34LKz1Kd68HiiA/6Eii
 Edm1kR6yaEzulW/hgT8tHdVgfbhfZAfa1+ZqSLLHaFxhPtnEuOaJbBhmUSJThFqPyR4/ mA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 36hgmanr83-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 00:56:05 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11B0tTS7025713;
        Thu, 11 Feb 2021 00:56:05 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by aserp3020.oracle.com with ESMTP id 36j513c0st-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 00:56:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DwnMyoLcbe0+uprvhvV9eeqvJpncvsWH1gO2iq+jdV/QwfNxuuCq1vmUeuBB3ii/gdleCRwukD59VF2Yg+ruI6iVxMx2ewyK0Rgbtxk8e2BUz8EekOBcHPkkXs/jvdmbW8w0/Vo3DMdlrN6NU23tEa3QNlz8OrOwGpaITvXFPQEImildVc8ewVainlkMr0AhqkaUYOxBIqQH8eRxh8xc6g0B1Z2543mkr9kwZGGakgwHxs3iK+/thTGzPX7/h4fvuYUPBuhlWoW8UOy77/fNK28ingdwg26Q2MWuA4vhIP2VWksXDiWdfdfb5b0IcaLC5dztS/S242gcbwDnJu8Yjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMmb7pREtLtxV/yjryHAOO3l6yTHNkrI7DuMRG6Zsl4=;
 b=c7C5MjoW1XfeBvJsBvXSk7xWASpxxaJIchgjaDHCgJIU6k7t91bvNaEI0VH3oeIFeCKXDox/4NDVhg2awxzyEfXh4PtksUYNWyzwgJfwW/njaluMTsl0XcsPSYH4AbVpL0VNK8EwasIpNaiA37c10gLm2MZHAinI09OsEPTyWsstA6bFZweYhH+lNM0uLr5xMwnpjQRzlD0J4gpWJkulD2xTHezFv+w5CPQr23NNIOHu2Wsp4hewdGlo6FqMIIfxFPo2vd1AXBDdvcaahLWs906N6rcEVc6GyQ9qavw+C2/7MoqHRLH22US62zKkZDQJOcnBgepCESCnCXmZkPyrZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMmb7pREtLtxV/yjryHAOO3l6yTHNkrI7DuMRG6Zsl4=;
 b=rXXp/wH/+mzqnJ4vtJq7LjNHeBAmXoSBtVDyeHRkNdjDd1vJ0wy/nv6Y59W7WFujizCWRuWtmHc6nYkyhJRETOyulI+YHW4yJyr+2yqs/uO1lTP80I8PkhDok3NSyny1/SqAHDFNcTdwLLCz619AvmXpVd7qDcTCMDsbECYWdNY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by MWHPR1001MB2302.namprd10.prod.outlook.com (2603:10b6:301:2f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Thu, 11 Feb
 2021 00:56:03 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3846.028; Thu, 11 Feb 2021
 00:56:03 +0000
Subject: Re: [RFC PATCH 1/2] mm,page_alloc: Make alloc_contig_range handle
 in-use hugetlb pages
To:     Oscar Salvador <osalvador@suse.de>
Cc:     David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210208103812.32056-1-osalvador@suse.de>
 <20210208103812.32056-2-osalvador@suse.de>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <6783e871-e981-c845-16c3-c5ff3e6502ed@oracle.com>
Date:   Wed, 10 Feb 2021 16:56:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210208103812.32056-2-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR18CA0063.namprd18.prod.outlook.com
 (2603:10b6:300:39::25) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR18CA0063.namprd18.prod.outlook.com (2603:10b6:300:39::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25 via Frontend Transport; Thu, 11 Feb 2021 00:56:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97a30b5b-3ba9-4e51-f8e4-08d8ce27cde8
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2302:
X-Microsoft-Antispam-PRVS: <MWHPR1001MB23027E914F6CD558F66E2F7CE28C9@MWHPR1001MB2302.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0PmiZhTxvjaB3bT53MUkVlvvbqeSJ0ZYOnD0KJUJDUcrMGo02RK9o5IS5jQXuATnhyaA+mY52foulSV5ruZUYmP4pK1VGVkry1z8WxOM3upOrZv8D8vNR76fs0SGyneUxERXE+wKrgYrreQ2WU7FZdvkhnEcFPF+YTf4z2dyL0FvBVFNPJF8CBbSeDDmEQZXRuOY5iLN9rKttIith7rFTj9mtnidQyn/lqRE5gqgtni8fP7XBvThSmzruubfvYkjNNd53+4KYSsXBaFp6O7/2DyISGDubmBJe/DoVPzpRqEwVDXZNY8bVxqHaITWzUubMYB3wjRCVFdI8V0qnZpSVhToGOED+1/QG04ZYgN/UAQW2VfKx6ElWmYKLZdzc60zrKbqDzyw0fpFkKy+5mVVqrN0mOaLA6RuszFSZ5oSwD1hNd3/Kxf1z0CUnwTGrT7QPPNtj1qrpeCbkb2il7o3BgFLyjpHxqsbpamW9FGJH1SQZLOjN9VPXlfTrT9wHI3g81hkNCcIcKVMa83TWxeZQ3F/9VfLnJ9GK+KmIeayJBnDSW8rf+KrHO9qUfz2DB1q2bA3WokTaVoaajqt5QKyCIcXR/OslMLBSO/U0wNrzjI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(346002)(136003)(376002)(39860400002)(2616005)(956004)(16526019)(478600001)(186003)(53546011)(44832011)(52116002)(6486002)(6916009)(26005)(86362001)(66946007)(31686004)(66556008)(2906002)(5660300002)(8936002)(54906003)(16576012)(316002)(31696002)(8676002)(66476007)(4326008)(36756003)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MVorOThUUFFGZGRMVkIxNFlmcC83QTFYRUdGdlkvUXdWTGVwMDdCL1ZRcnhC?=
 =?utf-8?B?OExaeFZJUkVMNm1hZStQVnpTdVlyTnVqdWRPTk9UTllVWnhmTmUvQXVhMUZG?=
 =?utf-8?B?R3l2c1o2S1k3bkxoVkZBa1loWEVhM3dYK2NKUmVRME5ONlJwQmdiM00zSFk2?=
 =?utf-8?B?bEtJcjZoSWxma2EvT29ndCt1QnBVWlRDbFgwaUZwaHYvdGUvT3RYaFpCbkRH?=
 =?utf-8?B?SkJZbWNBTXQvUU5rcS9NNjFnbzJrL3YrMytndDJJRVJiN1cyTUQzMlhpOHVi?=
 =?utf-8?B?YlAvLzhsbkVrRE9ZdS9US25xVkl0S01lR1dtQ24vdWFTZ3VuWlppLzZ4RnFV?=
 =?utf-8?B?djVCOGFxWkNiUVFhVEUzN0doR1lTczk5RytwcnFZOU9BWHJKWUZ5bDZpcWhE?=
 =?utf-8?B?bndjZVBsQUg2bEtGU0l1ekNSck5MYTdIVEZlSUF1bzlCcElYZzAvUkZhZDMy?=
 =?utf-8?B?ZVJqQ2pOSDR5aDdBalFZVFhRbFFsU3FMei9LSmxaaFZ3OFEvWnl4a0E4WHN1?=
 =?utf-8?B?T2UxZDR1N0lGc05Edis0YlhKWFhOVEFlam03VVVEekZFa0hJSnIwL1R1bENj?=
 =?utf-8?B?NjNQVXBac1FkemlzYlludTRMdm1XYUswYm1jaHlxMkg3dkZGMjdVcmZGcEdj?=
 =?utf-8?B?aEtuVHNPZ3hoekkvckYxQ3FYRmUzays1Sm1UbDhqZk9kOUhFZ2JYSis3bktR?=
 =?utf-8?B?bDR0bU9yRndNSHdXME9nOUZLWG1tN0ZLeTlBYmVpc3Vpdjd1VFk2SkVIZlJG?=
 =?utf-8?B?WVVKWkxXU2xBcDVOQUxkbkZjdTl0N3NPTTFrVGZtaEN6WnlNR0tRZHpMMUhs?=
 =?utf-8?B?cUpmT2hYVjNrMnlBSng4VDBBUDB6M2w2Lys5ZHUrektQd2pabm1MZUFIRDBo?=
 =?utf-8?B?TEhqTWVOdjdMVHdVVjgwVDdYNG5BVlNtSUJPaHFuVUV0TVV2RGJLbUpxZnph?=
 =?utf-8?B?TmF0clVCVjM3YW5ndDlkSzZSTk9Ic091TzREUFJESzFoODh4Y21VRzdBZWVm?=
 =?utf-8?B?bkNSZ1lpWGFiM2s2QlphT204L1pvc2VmQkRpR05lcU56YVl5VEhyb3RRdXBh?=
 =?utf-8?B?TDhxb0ZWaWJtdGZWd20vV2prTXRxUXR0Zm02dEhhcE1zMXhnVnNtNkVDNllV?=
 =?utf-8?B?WkRzL2xNY3VGQTJEcHQ0QU9xajBqazVnUm5VWFFTaDFPREwzSkM0bFVUaCtk?=
 =?utf-8?B?ai81Z3YwdzF1K0JjeDdYYzBKUXFjckJFb3BZSFptRVh2ckR5cmpXZGxsck8y?=
 =?utf-8?B?c3FSZy9HM0loRXRnVUxXaW1JcXBDUWlic0Urd0lUbFkrNHhRa1NNSTBLOXEz?=
 =?utf-8?B?M0FqUkJ4MENxWGJLQmlCTElaQ0hodys3MnlhYjRlT1lla3k0ZXlQZ0VHME5X?=
 =?utf-8?B?WGFEd01sc1FZUHBoMExJNmNoR1Z6M0FhYTVFdk04M0QvTGlHVjFxMnRvK0tR?=
 =?utf-8?B?eC9Nb0tGOFMzRVpCRThmRWs5Qk00RzN6eGdVYjMxOXJsTktpV0c5Nnpyd090?=
 =?utf-8?B?MWJML2dnQkRZTVlxQ3BpY3E3NUxtaGN3U0pKd1RXckM2R0M0YWZaeTNnTFJB?=
 =?utf-8?B?anp2b2d5eUZLalMzdTdKdmRtRXhTcU56b3NxV3BIM281eVN6S2kyWDN2YmlR?=
 =?utf-8?B?b0J6UDZzQ1luQmdUTkhjZWtJTWtZUUJuK0hZL3d3c1RhNjZ4NElKSDg5VUYx?=
 =?utf-8?B?Q1RrSW1vWENxRUcrVlhTT1NUTUE0ZElqZWIrOVNyMVh2cnpEYmhwaXhZcVNG?=
 =?utf-8?Q?/9ZOSGu5ffU2G7SsVmwkCUw2dAEXpYcM6yTUFMU?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97a30b5b-3ba9-4e51-f8e4-08d8ce27cde8
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2021 00:56:02.9647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ryz7Plp0ofx4ZCResfu122kmVQXRnf7V9sgeKApbLHGPuPD4+RD3S+4gtL2o7Z5qYD1FKGkCFCh3yj+vJg5Qzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2302
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9891 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102110003
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9891 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102110003
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/21 2:38 AM, Oscar Salvador wrote:
> alloc_contig_range is not prepared to handle hugetlb pages and will
> fail if it ever sees one, but since they can be migrated as any other
> page (LRU and Movable), it makes sense to also handle them.
> 
> For now, do it only when coming from alloc_contig_range.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>  mm/compaction.c | 17 +++++++++++++++++
>  mm/vmscan.c     |  5 +++--
>  2 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index e5acb9714436..89cd2e60da29 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -940,6 +940,22 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>  			goto isolate_fail;
>  		}
>  
> +		/*
> +		 * Handle hugetlb pages only when coming from alloc_contig
> +		 */
> +		if (PageHuge(page) && cc->alloc_contig) {
> +			if (page_count(page)) {

Thanks for doing this!

I agree with everything in the discussion you and David had.  This code
is racy, but since we are scanning lockless there is no way to eliminate
them all.  Best to just minimize the windows and document.
-- 
Mike Kravetz

> +				/*
> +				 * Hugetlb page in-use. Isolate and migrate.
> +				 */
> +				if (isolate_huge_page(page, &cc->migratepages)) {
> +					low_pfn += compound_nr(page) - 1;
> +					goto isolate_success_no_list;
> +				}
> +			}
> +			goto isolate_fail;
> +		}
> +
>  		/*
>  		 * Check may be lockless but that's ok as we recheck later.
>  		 * It's possible to migrate LRU and non-lru movable pages.
> @@ -1041,6 +1057,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>  
>  isolate_success:
>  		list_add(&page->lru, &cc->migratepages);
> +isolate_success_no_list:
>  		cc->nr_migratepages += compound_nr(page);
>  		nr_isolated += compound_nr(page);
>  
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index b1b574ad199d..0803adca4469 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1506,8 +1506,9 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
>  	LIST_HEAD(clean_pages);
>  
>  	list_for_each_entry_safe(page, next, page_list, lru) {
> -		if (page_is_file_lru(page) && !PageDirty(page) &&
> -		    !__PageMovable(page) && !PageUnevictable(page)) {
> +		if (!PageHuge(page) && page_is_file_lru(page) &&
> +		    !PageDirty(page) && !__PageMovable(page) &&
> +		    !PageUnevictable(page)) {
>  			ClearPageActive(page);
>  			list_move(&page->lru, &clean_pages);
>  		}
> 
