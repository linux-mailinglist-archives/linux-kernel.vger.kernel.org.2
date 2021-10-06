Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3A05424649
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 20:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238898AbhJFSyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 14:54:45 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:19856 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229564AbhJFSyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 14:54:44 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 196HxjYr028464;
        Wed, 6 Oct 2021 18:52:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=50iGaYtrOZG7plH+b4SiuXrHsDIR+Reu86ILepFznp8=;
 b=DPZxhquhk/boyeoXY+swHdJ7u+TprQYkcwCnLa0DsugCEm1XtpCUe1SrlInwYXpHwLk9
 lq6mcdVd4kkFnolKDuiuMfD4gBt2wzm6Kp4VXZ7VJyGvOJh9Z2gS/dag2VVx122TOr2G
 IcJvhzsbjf7hIvsvNeEoSJIJM+3lZfAHc8qFsfs17CYqZUAjWvTqymhF8QMkiRi6C4BW
 1XF7E2cwsL1KHOElxDVArjU5Vaucf9/uIbRx6858vTBV6jvVziyPxKKaNnrv9MtcVPQW
 1N4+vpIIo+/9XKdmnfIsLO4+7tXKYJFaKHcUyUZkswicNc93thnGGuGv5DNKzkbgHNUK VQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bh24h65gp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Oct 2021 18:52:38 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 196IU35i182009;
        Wed, 6 Oct 2021 18:52:37 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2046.outbound.protection.outlook.com [104.47.56.46])
        by aserp3030.oracle.com with ESMTP id 3bev7vbmsq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Oct 2021 18:52:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eeUS8vaU1m4JOB9J9Y6/+n9B8Jxfvdny94UhkGJUjxp92wUA/MEyaALg7rW/Tyw7ef99L6tqqiEMpnfW9ZA6bYpxVQI3OGG/I5F16qA47Dbw5Oy1UHUsrLHNYS+L6qhS4n0ExiTxpQRsG1g46g/OYuDISXQ1LBxDlK5a2+iXICf0yhLBm/bZPpuPjASiy3AEll3AgwdInsPVmSdvvA7EiAQrLJYDOkPmC7lwFG21xFcrd3WWCLcX6s7nyocv+sA3QkvdlPCa1G2aVSRShb1V7EOjLRa52q+GsMvtHRzJYSe7Bw7sc1cck1VNeGLLuKlyFOeFnoOtcKcZCjtOm9DTug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=50iGaYtrOZG7plH+b4SiuXrHsDIR+Reu86ILepFznp8=;
 b=n0xsdHWMUcllvKFTeNKDH/S/l+MfVtbE0wzVM/TLtB8rp0N/BWRtFJP7rjxE8ccoo9mV62LKjxJiQMMgo+47LIsWDlJ6TB+pzAyktEBgdSJLyxPgY5sgsuICyiCXK/BBzf8S0pdEel2TkcIvdOrNsb2Pjt/OYDiXE2gUYwb0CRErRMucCi04I6kpN0+TH7xF2pnBsQCVKH9VTh+pGsUKXBBvMV5sob18Nk9LL6f9KborK3fbtZVsUDttqs67PJ46Jef5Fh1bIj0Urg3dDIrlmpmOQRwTeBducXka+RxkC+BmBmW6lmTmD6LXHOGUJmCgEJiGcRkvcqVsEWehCuq6jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50iGaYtrOZG7plH+b4SiuXrHsDIR+Reu86ILepFznp8=;
 b=VfQsEkdcZxDn+0LY9FITN70T8TKeZ6k1qBzms3R2c/cEz6IwMmtzGNCPz3f9+xYocjVlQTUoL8R+0RG6hVY35SL8dPOMxg5QqdNFAdMOZOHu1/QmbAnUz/XzNGkAnoV8eSamPX1KwIbHxmiEiZpckfQOGxXFNrfoHSM4ZVvb5q8=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2552.namprd10.prod.outlook.com (2603:10b6:a02:ad::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Wed, 6 Oct
 2021 18:52:35 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bc59:71de:1590:cbf5]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bc59:71de:1590:cbf5%7]) with mapi id 15.20.4587.019; Wed, 6 Oct 2021
 18:52:35 +0000
Subject: Re: [PATCH v3 5/5] hugetlb: add hugetlb demote page support
To:     Oscar Salvador <osalvador@suse.de>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>, Zi Yan <ziy@nvidia.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Rientjes <rientjes@google.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20211001175210.45968-1-mike.kravetz@oracle.com>
 <20211001175210.45968-6-mike.kravetz@oracle.com>
 <20211006084112.GA12288@linux>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <1e699922-59a6-dc14-6676-b44c1bdf1a6f@oracle.com>
Date:   Wed, 6 Oct 2021 11:52:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20211006084112.GA12288@linux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR2101CA0005.namprd21.prod.outlook.com
 (2603:10b6:302:1::18) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from [192.168.2.123] (50.38.35.18) by MW2PR2101CA0005.namprd21.prod.outlook.com (2603:10b6:302:1::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.1 via Frontend Transport; Wed, 6 Oct 2021 18:52:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf1c2a5b-1905-4af0-e44b-08d988fa75ff
X-MS-TrafficTypeDiagnostic: BYAPR10MB2552:
X-Microsoft-Antispam-PRVS: <BYAPR10MB2552275F1205328C2400E4C9E2B09@BYAPR10MB2552.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KTdeVxaivvM6aPNNDfmRymXyWG95ybrZJXg6fIEXJ3vX8eGjc6jXwZLOySwXeagEp4Q0rP6PMd0wyWJSpxJRjWVd/o2/J/XlnHMbt1mXTDxJRUU9zu6hwLsKNxMTIGehgmwrSk2br2rzFPBjOnQEI4xF8tI5m0MwmzkcBeSYMQ07fuUJs+K6dxJ7QJHcPfuaxROz+kZu8bk5KI0boEbZ++fpOlMhw1WSKF4s30TAaJyADDajCNWBPF0pE8ubZPI2O5ReUcjypsCg5JVpMy4rawrouWWN6DGDv0Okpvo6QL7PJ4LLOgv1GF7mwRjzpatdv7PNuvYXoHT+UCCnQofPv64ddCjS0GgGDIrs8G/f7wWJAIxzcZQYzdeXvRKtzihn5vTnfkCMunw7xj8pTERdVpGmOUB5fSksJriezek0XLY72ymEBhh6zuMQ6+cptn2tislFkVXx4ax7STbiBc/ybou+b7d5UbURi5CJIHGC71ZRg6PEKHtFgC0avf6fszvb9ztN0uK8vcZfWCLbUWAoxyqakJk0AujMZwTKUxESqc4kQmnRJ8VBdFF2oxc8JtxTm692T7Rn/HSWs9V5KPvC/ick3HpXunnYy/9Ah6PqzJEwiT08SalD1UDWqNGb1dFMdMhQoOOG0iiovSHNBaDUW5OYkoJH2/RC9KwJs6yCA9yl1IRRj12njET5ZiV70TPo2CxhaBG8iimeXzbVjgQBj03QM95QRZqjcgjHlGgKnPCuQ4QA0yCShXJ71kgqHgsjWgu2L2ihy3JecrY/BsoeWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31696002)(316002)(86362001)(16576012)(7416002)(38350700002)(44832011)(6486002)(5660300002)(31686004)(4326008)(2906002)(6916009)(508600001)(54906003)(38100700002)(36756003)(66476007)(66946007)(66556008)(52116002)(956004)(2616005)(26005)(8676002)(83380400001)(8936002)(186003)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXFIb2xZMExWS21hMVRlWEE4Z0FVU3hOU0dQc3NSekMzWkFUZzFNM3o4blBN?=
 =?utf-8?B?a3lJdmhxaGZDVy9QZmN6MHIzV0doVkNHQXVpNkpHakh1OUpZUnpCYWhRNnpt?=
 =?utf-8?B?YWhHYzRLOUZKNHBhd1dmbmFuZkt0NHgxNTF6NHdRbE1yNDNoQzI4VmxLaklw?=
 =?utf-8?B?dXZ2bXRHKy9JS2NXZ1c1dGcyWVlLalF5a0NpMDY5TzdrMFhydy9tQjdnc3B6?=
 =?utf-8?B?NkhXRE9WUDI2aHN0RTBRWnF5S00yWWVvMXltaEpncU5ueCtxdHdtWjNhVWw5?=
 =?utf-8?B?RVRXVDRrcU9RWnZ6U3UxZEFxR2U0NlJCZ2FTY1RIZ3FUa0tZRGRsOS93em0r?=
 =?utf-8?B?aWFrRGFJR2pONzdtbzFmVHNVeDY0d3VGalE2Y3ZUVDNlbUxabzB0WmZHdnJj?=
 =?utf-8?B?dExTVCtONEZSY1U0a0NWOGhGd1RrUGlieFJ3Y3JETkg2UWZMNDNWM3FlaHdm?=
 =?utf-8?B?YVdBSkVnVUtjb0RXVTc2RitkT2dJQVRkNUpDTGVjbFBLZU1HRWJKZkh0NCtG?=
 =?utf-8?B?TnRXZzgvY3ZhcjB0dWhoanBVcCtRWVRmSFdtUTFsQ0JzUXNiOEFHZjZnNjJ5?=
 =?utf-8?B?d0pHb1Q4OW45cE1XVUNHMytyQW9LaENhVVN0K2FZUjhtT1B1TndTN1dQNnN4?=
 =?utf-8?B?VG54NWp6WFdqdDJ5MmYxL0JSaThrUDhTVU5NM3RNaFlLOVpPWk9EQVdQWW9X?=
 =?utf-8?B?L2l2UDlpMjJ3UXIwaVlEWVhESGtJSUdlZUxMT2tKSkVGYUlaNHlmMWgvR3hV?=
 =?utf-8?B?b3M4S3RGTlJLSmJDbUJrVktoMG44b3laNWlObXVZb0UvWFIrbEM3cnozWGUy?=
 =?utf-8?B?S0xraG9CZGRmZVU2Ui9kZzlHd3FyUjRIOUhFV1ptNjBkMXV2YlUwSlVrYktl?=
 =?utf-8?B?S2lKcW9aTVNIM0xobWkwOXQwUzNTZHF4a1IwUkQwaWtQbmFPYjNWbXJucWRm?=
 =?utf-8?B?QkMrZmIwdlgwazVESVNkMVIxRkVOdVJYUW02dDVZTFJSQ2hUd25FT0dVOU9r?=
 =?utf-8?B?MGhmR3dEL29oME1oMTA3WFh6STR3YzNBMHNva2F6R1lHY0xSdFhsNU0vT3JJ?=
 =?utf-8?B?cjkzWEU1dEFIYUpkbDQ3czdrVFN6WHlZNVlMM3g0OWR1SnlQQUkwcVpqR0Mv?=
 =?utf-8?B?d3dFQlozVWNPVHBiRFVnblhKQisreUVCZUxaR0x2ditPS0FRMDRla0s5NFRF?=
 =?utf-8?B?VUZqc1BhZHd4OEloOGxvQnBBNGhPdzJQOGVrU05FU2pIcjJhbkE0QmR6UDRk?=
 =?utf-8?B?MzQ0NThybUtydm14T3VnS3ZHb1pGbFBnQSswcFJVaFdwNEVVc201RVFTYlN4?=
 =?utf-8?B?VVNDNEMrQkZJK0xNUzNnbUVtektHcS9SVmd3YzFudklEM1FNRVpTYWhsekpB?=
 =?utf-8?B?NDByQmdCbktENC9XS00wU3RwTVZJaURFMWMvWFcxUHV2NnN2Zk5MakFnQWhj?=
 =?utf-8?B?aUFXQk1waHc0L3YzOW9mUFkrMUo0UEZFNFdNbmxvOGs1blZUeFd1RngwZitH?=
 =?utf-8?B?Ny9IQTBIK1ptL1NwU3JyTHBMR2JOaUVpVis3TWJTUWoyaGVsd0owWjltQUZo?=
 =?utf-8?B?ODNOK3FveTMzcW41cEhvYXFXejg2OWZ1WGtjZUJYZ0lic3AxWXd1N2c3eWhM?=
 =?utf-8?B?c29OZlA0YkxQREM4eiszZjZXQXZESHBSRVZYNmVoMTJybnN0ZHBUV1dGMzd5?=
 =?utf-8?B?cFVWRHhwUlVyV3B0L3d6bHZQU2NKRHlDSStuUVJ2NThMaG91dUtNUnhLdzdW?=
 =?utf-8?Q?J9fYMKBaul09kIix7EFmBLfecINxy/Xgl1DcE3t?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf1c2a5b-1905-4af0-e44b-08d988fa75ff
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 18:52:35.3487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Uha+Xy3tQXxMUcQUoG6X+4dtzwEoqKmoOIA1atSlM9TYzZi+uwLTHB91r4GYNpPi80ZOKqChSC/F5StcAowyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2552
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10129 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110060116
X-Proofpoint-GUID: -dttSe_3DR0tl8-q-TQ9fDBl3Uuw05KG
X-Proofpoint-ORIG-GUID: -dttSe_3DR0tl8-q-TQ9fDBl3Uuw05KG
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/21 1:41 AM, Oscar Salvador wrote:
> On Fri, Oct 01, 2021 at 10:52:10AM -0700, Mike Kravetz wrote:
>> Demote page functionality will split a huge page into a number of huge
>> pages of a smaller size.  For example, on x86 a 1GB huge page can be
>> demoted into 512 2M huge pages.  Demotion is done 'in place' by simply
>> splitting the huge page.
>>
>> Added '*_for_demote' wrappers for remove_hugetlb_page,
>> destroy_compound_gigantic_page and prep_compound_gigantic_page for use
>> by demote code.
>>
>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>> ---
>>  mm/hugetlb.c | 82 +++++++++++++++++++++++++++++++++++++++++++++++-----
>>  1 file changed, 74 insertions(+), 8 deletions(-)
>>
> ...  
>> +static int demote_free_huge_page(struct hstate *h, struct page *page)
>> +{
>> +	int i, nid = page_to_nid(page);
>> +	struct hstate *target_hstate;
>> +	int rc = 0;
>> +
>> +	target_hstate = size_to_hstate(PAGE_SIZE << h->demote_order);
>> +
>> +	remove_hugetlb_page_for_demote(h, page, false);
>> +	spin_unlock_irq(&hugetlb_lock);
>> +
>> +	rc = alloc_huge_page_vmemmap(h, page);
>> +	if (rc) {
>> +		/* Allocation of vmemmmap failed, we can not demote page */
>> +		spin_lock_irq(&hugetlb_lock);
>> +		set_page_refcounted(page);
>> +		add_hugetlb_page(h, page, false);
>> +		return rc;
>> +	}
> 
> Question: You keep the original error code returned from alloc_huge_page_vmemmap()
> here, but then you lose it on demote_pool_huge_page() when doing the
> !demote_free_huge_page. Would not make more sense to keep it all the way down to 
> demote_store() in case you want to return the actual error code?
> 

Yes, I will return it all the way to demote_store (and the user).

>> +
>> +	/*
>> +	 * Use destroy_compound_gigantic_page_for_demote for all huge page
>> +	 * sizes as it will not ref count pages.
>> +	 */
>> +	destroy_compound_gigantic_page_for_demote(page, huge_page_order(h));
> 
> It seems that for now we only allow gigantic pages to be demoted, but
> destroy_compound_gigantic_page_for_demote feels kind of wrong, even
> if it is only a wrapper that ends up calling _*gigantic_ functions.
> 
> We want a routine that destroy a hugetlb to be demoted into smaller hugetlb
> pages, so the name gigantic makes little sense to appear in my opinion.
> 

Agree, I do not love the name.  Since it is only a wrapper, how about
destroy_hugetlb_page_for_demote?  And, change those other *_for_demote
wrappers to similiarly not have gigantic in their names.

>>  static int demote_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed)
>>  	__must_hold(&hugetlb_lock)
>>  {
>> +	int nr_nodes, node;
>> +	struct page *page;
>>  	int rc = 0;
>>  
>>  	lockdep_assert_held(&hugetlb_lock);
>> @@ -3313,9 +3377,15 @@ static int demote_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed)
>>  	if (!h->demote_order)
>>  		return rc;
>>  
>> -	/*
>> -	 * TODO - demote fucntionality will be added in subsequent patch
>> -	 */
>> +	for_each_node_mask_to_free(h, nr_nodes, node, nodes_allowed) {
>> +		if (!list_empty(&h->hugepage_freelists[node])) {
>> +			page = list_entry(h->hugepage_freelists[node].next,
>> +					struct page, lru);
>> +			rc = !demote_free_huge_page(h, page);
> 
> I kinda dislike this as I pointed out.
> 

Will change.

Thanks for all your comments!
-- 
Mike Kravetz
