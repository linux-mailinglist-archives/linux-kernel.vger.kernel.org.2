Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 406E74272B3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 22:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243300AbhJHVAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 17:00:09 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:63998 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231587AbhJHVAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 17:00:05 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 198JbnDI007639;
        Fri, 8 Oct 2021 20:57:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=UjG1TyhL7xJDqBLmcUfpUvlIqxg9wZNdT+hZNtZCnPM=;
 b=vcQNmLTDZ+IFXJTMAOKbw0Epdzw61f0ZofF/q18lGrAX5JThqeg5zn/8eyU9NMH9wzj2
 AAYIycDEEdCx5PNmALpKceon9RCV38RNB4tW0r7il87IDl0AV9qDJlAWrTfogr3j03g8
 F4LvEyCNPMbKWdrhXGDA9uVaYnNZLAXC0WvCkU55ZEtP8kqfofE/qjaClwnpqR56tsok
 XdDqJzu9T45WUCX9aRgqpsdm0k8BbRXipooiJN+N08yPHao9Yi9OK4mp2F5ibCvdz8S4
 JDh0/vQE5XCIhoP99Nnn3WXCHR49dSz4FQahjJdU6s/kahB9bTZg2gAX/ZId0h3h8n3d nw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bj0pwahq5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Oct 2021 20:57:55 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 198KotRt125815;
        Fri, 8 Oct 2021 20:57:54 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by userp3020.oracle.com with ESMTP id 3bf16yyesj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Oct 2021 20:57:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gx4bq3Gd3MPylKrPahakbfsIm/o4wYgINuRPdrfue8QZz/qhjh3QTOVQ3ZaX4X8Wg2zjsfHOzhX4UZDoYR4i5DGhgQvPhS6WYBGOhK/dIfeNYkOXGihusTtQVIjuBT9EArM0zIWItPtkHDbkSe7+C/dewO1tbwcZM7KwRC+lDAbH0BsJASN8h/0Y6VfoaGkbf1PFy9Np1GZeJSuRiOXcWUEl3hzo2/6Zb1TXNOmTrDryEty4yY7uqANgjcDf0RzerjP1AKhxIJqZUNJEcjfdtO98Ny8A8lDv7tzkKvgiv8vqyQVH3gKDg6Rn6T5iBzuuuWrMkDTvf8j0e3/ef3uJlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UjG1TyhL7xJDqBLmcUfpUvlIqxg9wZNdT+hZNtZCnPM=;
 b=mmgUs0k0FL0qjbRIUPQMSigUWNcuLzzJaDYLttPrXT0+nohwfRhJTeqmEX7wi8kZ6GOhHVsPiudo7/XpuXDepogSclCisLeXw4iTSK2l2edSGrPZEFuGKRb6xBccFeKArKaFeSMY/AZYD7wLG6jLShL9gc0HVboWt6EeVqek20FPQhNDxUG8d3xcnTkxxZKcOStBguX+ixtTj7lhlT8mcglBzKh3iPQzSPp82I7m1MygI5AcYYFxxM1fI6x309Z6I9YNLVYZx7y9aMEtVplo2nk2pJ3cXvA+EzQ1LFPvxoDUD+F67mbqPyPO51m31+t3fgpalUnLbCmRNQwugMlriA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UjG1TyhL7xJDqBLmcUfpUvlIqxg9wZNdT+hZNtZCnPM=;
 b=opG9gbfZkeDpy63cko5it4ULa5sWAVp3jdrmQhcD4bciI2c8vyfLcD/NDHWZ7VfSzhrSovqucl+Dw9ykA6dBKn3/hqX+yHZ2kEoYifGKb25wwLp4Xy+3LPKkHqJGCKGRwr4tdcKnzf2Gy8DVLqPJGjR1k86/FxsLfwvg4Pz7khk=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from CH2PR10MB4200.namprd10.prod.outlook.com (2603:10b6:610:a5::9)
 by CH0PR10MB5130.namprd10.prod.outlook.com (2603:10b6:610:cb::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Fri, 8 Oct
 2021 20:57:51 +0000
Received: from CH2PR10MB4200.namprd10.prod.outlook.com
 ([fe80::acc0:d361:da0:dfe7]) by CH2PR10MB4200.namprd10.prod.outlook.com
 ([fe80::acc0:d361:da0:dfe7%3]) with mapi id 15.20.4587.024; Fri, 8 Oct 2021
 20:57:51 +0000
Subject: Re: [PATCH v4 5/5] hugetlb: add hugetlb demote page support
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Rientjes <rientjes@google.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Nghia Le <nghialm78@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20211007181918.136982-1-mike.kravetz@oracle.com>
 <20211007181918.136982-6-mike.kravetz@oracle.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <6ca29b8e-527c-d6ec-900e-e6a43e4f8b73@oracle.com>
Date:   Fri, 8 Oct 2021 13:57:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20211007181918.136982-6-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR10CA0013.namprd10.prod.outlook.com (2603:10b6:301::23)
 To CH2PR10MB4200.namprd10.prod.outlook.com (2603:10b6:610:a5::9)
MIME-Version: 1.0
Received: from [192.168.2.123] (50.38.35.18) by MWHPR10CA0013.namprd10.prod.outlook.com (2603:10b6:301::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend Transport; Fri, 8 Oct 2021 20:57:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76305a93-01e6-494e-5cc8-08d98a9e4a8f
X-MS-TrafficTypeDiagnostic: CH0PR10MB5130:
X-Microsoft-Antispam-PRVS: <CH0PR10MB513090DEA9DA0DE2B81346B2E2B29@CH0PR10MB5130.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k6xh6cyKdomXwHFQJciBE/97W5GezE/XBmD+PsiFo3xNLz5SC4jv1n25AhewqIAixtO0n97VGSnJpub6WTKJPr+8Ewnyx5iOn+4RMO7Jwv6TYhrMqc/GcBpQM+Xol2MSscxye6M7j5r+S4SObyK7yF/M3OwpKc5HibgZhl+AsQ879jwP8efg/phyz9Y3N1EcUWD1FwwV2q3IsePaYO1eFPzFibLLHCcuhHScvoX09SENPbSwCNlMds2CYtef4mV/fzUXDF1Qub9KoRPMQd81kluYgZGMH2u4B1adgQ+j4PfahcT1UqbQ1aHLIje3ikER/3uweQfnMCodc0qNUas8usq+4kXKHFvTsGe6PH+Cl0U+85NcHw3/N7JEHmFUUyGa3Avwt+fFGJ9yXZmZN7cHfYUVVw+vKN1bNIMJ7FnkFbC4nHA+zP1T9RvrosntBu+GaBRW8OOuXoAeFyAk2l56bq86+uUDIyDY1LeVCmDBmSd21DHqlTMx2aSdvC8aa93jYDb6yOyYqNv7XXVB8TzAkvXnlCGf9g8anoUoFeECIWq2USnbvG7oTWdE6RA9LDcC7f1+thuoRuOfIsQj8T/zQHjSFIggXdeaG3Ou2veJdwd/ZHlfx4HT2yiy4T/BhV2/3H1RzneAD8b1Tf1wFypRFQiu9Zl/4TtlFYybUqQ9aBBJHZJcxr6hlaeW4xtTCor4gNCHMU9vExlX+58e5FRAe5xul9MEmmYt0s8B1clm1t0MZPYcQrQqx/pRo8eTe8QPYyJ/vA2/5GQiMS0NmwyAfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4200.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(38100700002)(83380400001)(31686004)(38350700002)(956004)(2616005)(186003)(26005)(53546011)(8936002)(8676002)(52116002)(7416002)(66556008)(66476007)(6486002)(66946007)(4326008)(5660300002)(508600001)(2906002)(86362001)(44832011)(16576012)(31696002)(54906003)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0FYNWRqVDFJS1U0MXc5R0RmVGY5bjBQQzBoSlpiNU9VSmQrNktEVWgwOTYv?=
 =?utf-8?B?eGkvN0hyL3NPRm9QR1NZQ1h1RmZRMDRIWm5SY1ZITXhUb3c0dDNkKzNKQ0Zz?=
 =?utf-8?B?ay9RMVl2aEEwNWgrT3F0YVpNMmVyUWlRYS9qNmkwR3ViaUJUWkNPMzZTeHM4?=
 =?utf-8?B?UGI4RXBrcEZtc08yTjl3cHY1NE9hSW9XZVpoTVpwa0JreXRKTnpmZUNVRFdz?=
 =?utf-8?B?ZkR5L0hjbHlORE9XK1dXek01bkxYVzlYc1puQndQTzV6bEZiL1F1cWNpV1py?=
 =?utf-8?B?UmdFeEdhWlB4Wnk1dGF5Q1dEY0UvVEpKb25ZQlNVaTNkbWcrWmE4ak04MWxy?=
 =?utf-8?B?V2UrQ0VBaGswWkRDZ3YzVERxdDlXWFMrc2dHbmFjdVJ6Vm4xM2JIcUZxa3hl?=
 =?utf-8?B?WDNwRytnVXB6SnlnSDBnRGJxVU96U1JmNnlFYXhuVUlkL1dlbFcvcUIwWWRt?=
 =?utf-8?B?OVZTWXI1VmtwK2QyT096eUtBeUx4WlVHVWlqSUdYVndKbFA1UGMyNXR1NEsz?=
 =?utf-8?B?WWVMWGRvNytKNEtmZlZwcXZqUFFkNVpkUkVUOEZKV3JVdXJaSDkrZVRpL056?=
 =?utf-8?B?VmZvemwwblV5eE8yWkpZaElJbHk2NUJuYkJJYXZ4TVIvZ1lGY2R5WUdPQVlZ?=
 =?utf-8?B?ZSszb0xndyt2c1J3VTViQjJNKzdGOTFZWW1QS0JINkdGV09oSk5INk54WVNl?=
 =?utf-8?B?ZDRqbUlDR2dpZXIvTHY2QkFDNjRINXpscnZ6UTRwQnFieTlTWGZZWlIyZ2tN?=
 =?utf-8?B?ZHRKbnk5ZXhsMW1ibktqdHBJK2N5b0xrVFZOaUdlUHJrNitqRi9hZndvWGhM?=
 =?utf-8?B?SDNvcDl2YUdHSFhScEp3NngyTnJ5V0FvbWRzUGlMSUcwMlIwM3Fpb09YaE5Y?=
 =?utf-8?B?dTBZTks5VHJqdnV5R3dSTUNENVZjaG82VjVaMXBxcitYRVE4NjdiUEN6SVhT?=
 =?utf-8?B?MkZTZjk5NldMU1FHOEhqeC8rejEzUW9scndxTWp5TmtPUVZ2R1gvM2tCNGNs?=
 =?utf-8?B?aDNMeGFscE1WcWxCdXNVU2ZXVnhiN3dRT0pseHF1ZFVYZUtnRlBXVitmYmp1?=
 =?utf-8?B?S1hTVmtpNnh3RnhPcmx1LzZRNzZSZG1CYVVEOHlZUUo0VThpQnQwc2JXR1V3?=
 =?utf-8?B?ZWE5S3dEYXBoRUtaWkd2cmJmZFJjaEFRWE1ZRXowcWhLc3J1eDk4UWMrQXdi?=
 =?utf-8?B?Y0lJaU4rMzA0ckhpbXV0OW5yWldLcjRSS1dGOE5mdnFjWm9ybVlUSEcxanRG?=
 =?utf-8?B?bVg0V2hIKzRFUXlxbng3aDBONm5vcnNCa2gvZFk4eSt5eFhsTFJtM295dkhR?=
 =?utf-8?B?eHVWR3dNT3VzUG1qOVNQSnBEa1JtWmpQeGFSYnVVbVZSbzJ4TEovUzkvblJ4?=
 =?utf-8?B?TldtRlhXRjZTM2VpamhBeG9tb0NodnRtWVBlNFlmODJ6cGdnVUliQXg2Yloz?=
 =?utf-8?B?eTg4RkJwYlM3TDcrdFB3aUNhNzl6bHl0NklNejhlam5heVE0bXlVZ3l5ZTVl?=
 =?utf-8?B?L1d0OTJjd0pQcGhHOTcxU0FETHlPMWE2MEVzK0V3MURaV2tjN1c0eVVZcHlD?=
 =?utf-8?B?WklNQkg1eUJNN0ErUVlzVG1tY1Q1cDhQWHRJSkdwL3Ywb2VlV2Vmcm1wcE9B?=
 =?utf-8?B?MjlLaFBZVjFtK2ROZEtqdU1JU1lNek9CaGtWd2J3dGoyeU1EMXZYZE1WYXBT?=
 =?utf-8?B?SS9EbjkyaFNmTnRPVHVwclRuOUZFL1RCZy9wSWJEUXpjcGk5ZEl3SHg5d3N6?=
 =?utf-8?Q?HBEAbTDg4fg6DH4kCh41IdbiJNOPLpYR3FLztX4?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76305a93-01e6-494e-5cc8-08d98a9e4a8f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4200.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 20:57:51.2201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c/lhdynnQ4qnSmcPgwJkba/CWpXFl85SBH2vfiRKCYrGUkA5x/QdFJHS23RXl/XxL0WP+f/zrM+x1rWtThnaAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5130
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10131 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110080113
X-Proofpoint-ORIG-GUID: b75JI3iWZMDm7rM0scEAFfcm7Gy0DzCc
X-Proofpoint-GUID: b75JI3iWZMDm7rM0scEAFfcm7Gy0DzCc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/7/21 11:19 AM, Mike Kravetz wrote:
> +static int demote_free_huge_page(struct hstate *h, struct page *page)
> +{
> +	int i, nid = page_to_nid(page);
> +	struct hstate *target_hstate;
> +	int rc = 0;
> +
> +	target_hstate = size_to_hstate(PAGE_SIZE << h->demote_order);
> +
> +	remove_hugetlb_page_for_demote(h, page, false);
> +	spin_unlock_irq(&hugetlb_lock);
> +
> +	rc = alloc_huge_page_vmemmap(h, page);
> +	if (rc) {
> +		/* Allocation of vmemmmap failed, we can not demote page */
> +		spin_lock_irq(&hugetlb_lock);
> +		set_page_refcounted(page);
> +		add_hugetlb_page(h, page, false);
> +		return rc;
> +	}
> +
> +	/*
> +	 * Use destroy_compound_hugetlb_page_for_demote for all huge page
> +	 * sizes as it will not ref count pages.
> +	 */
> +	destroy_compound_hugetlb_page_for_demote(page, huge_page_order(h));
> +
> +	for (i = 0; i < pages_per_huge_page(h);
> +				i += pages_per_huge_page(target_hstate)) {
> +		if (hstate_is_gigantic(target_hstate))
> +			prep_compound_gigantic_page_for_demote(page + i,
> +							target_hstate->order);
> +		else
> +			prep_compound_page(page + i, target_hstate->order);
> +		set_page_private(page + i, 0);
> +		set_page_refcounted(page + i);
> +		prep_new_huge_page(target_hstate, page + i, nid);
> +		put_page(page + i);
> +	}

I was doing some stress testing with multiple concurrent writers to
sysfs/.../nr_hugepages and sysfs/.../demote.  On occasion, I would see
unexpected surplus pages of the smaller huge page size (2M on x86).

Here is what was happening.  One task was decrementing the number of
2M huge pages with "echo 0 > nr_hugepages.  It proceeded to the routine
set_max_huge_pages and was executing the following:

	/*
	 * Decrease the pool size
	 * First return free pages to the buddy allocator (being careful
	 * to keep enough around to satisfy reservations).  Then place
	 * pages into surplus state as needed so the pool will shrink
	 * to the desired size as pages become free.
	 *
	 * By placing pages into the surplus state independent of the
	 * overcommit value, we are allowing the surplus pool size to
	 * exceed overcommit. There are few sane options here. Since
	 * alloc_surplus_huge_page() is checking the global counter,
	 * though, we'll note that we're not allowed to exceed surplus
	 * and won't grow the pool anywhere else. Not until one of the
	 * sysctls are changed, or the surplus pages go out of use.
	 */
	min_count = h->resv_huge_pages + h->nr_huge_pages - h->free_huge_pages;
	min_count = max(count, min_count);
	try_to_free_low(h, min_count, nodes_allowed);

	/*
	 * Collect pages to be removed on list without dropping lock
	 */
	while (min_count < persistent_huge_pages(h)) {
		page = remove_pool_huge_page(h, nodes_allowed, 0);
		if (!page)
			break;

		list_add(&page->lru, &page_list);
	}
	/* free the pages after dropping lock */
	spin_unlock_irq(&hugetlb_lock);
	update_and_free_pages_bulk(h, &page_list);
	flush_free_hpage_work(h);

Now, while the lock was dropped the routine demote_free_huge_page above
added 512 huge pages to the 2M pool.

	spin_lock_irq(&hugetlb_lock);

Then after acquiring the lock we make these 512 pages surplus.

	while (count < persistent_huge_pages(h)) {
		if (!adjust_pool_surplus(h, nodes_allowed, 1))
			break;
	}

To prevent this race from happening in general, the hstate specific mutex
resize_lock is held for the duration of set_max_huge_pages.  Since, the
demote code is also adjusting pool sizes it should also take the mutex.
The routine demote_store already takes the mutex of the hstate of the
page size being demoted (1M in this case).  That is because the 1M pool
size will be decreased.  We also need to take the resize mutex of the 2M
pool as this pool will be increased.  To prevent deadlocks, we use the
convention of always taking the resize mutex of the larger hstate first.

An updated version of this patch below adds taking the 'target hstate'
mutex in demote_free_huge_page.  Although unnecessary, it also updates
max_huge_pages of both hstates for consistency.

From 25e4dac59f4d203f3a7e86d3591d70c1e956d11c Mon Sep 17 00:00:00 2001
From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Fri, 8 Oct 2021 13:21:21 -0700
Subject: [PATCH v4 5/5] hugetlb: add hugetlb demote page support

Demote page functionality will split a huge page into a number of huge
pages of a smaller size.  For example, on x86 a 1GB huge page can be
demoted into 512 2M huge pages.  Demotion is done 'in place' by simply
splitting the huge page.

Added '*_for_demote' wrappers for remove_hugetlb_page,
destroy_compound_hugetlb_page and prep_compound_gigantic_page for use
by demote code.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 100 ++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 92 insertions(+), 8 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 794e0c4c1b3c..e1883510309a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1270,7 +1270,7 @@ static int hstate_next_node_to_free(struct hstate *h, nodemask_t *nodes_allowed)
 		((node = hstate_next_node_to_free(hs, mask)) || 1);	\
 		nr_nodes--)
 
-#ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
+/* used to demote non-gigantic_huge pages as well */
 static void __destroy_compound_gigantic_page(struct page *page,
 					unsigned int order, bool demote)
 {
@@ -1293,6 +1293,13 @@ static void __destroy_compound_gigantic_page(struct page *page,
 	__ClearPageHead(page);
 }
 
+static void destroy_compound_hugetlb_page_for_demote(struct page *page,
+					unsigned int order)
+{
+	__destroy_compound_gigantic_page(page, order, true);
+}
+
+#ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
 static void destroy_compound_gigantic_page(struct page *page,
 					unsigned int order)
 {
@@ -1438,6 +1445,12 @@ static void remove_hugetlb_page(struct hstate *h, struct page *page,
 	__remove_hugetlb_page(h, page, adjust_surplus, false);
 }
 
+static void remove_hugetlb_page_for_demote(struct hstate *h, struct page *page,
+							bool adjust_surplus)
+{
+	__remove_hugetlb_page(h, page, adjust_surplus, true);
+}
+
 static void add_hugetlb_page(struct hstate *h, struct page *page,
 			     bool adjust_surplus)
 {
@@ -1779,6 +1792,12 @@ static bool prep_compound_gigantic_page(struct page *page, unsigned int order)
 	return __prep_compound_gigantic_page(page, order, false);
 }
 
+static bool prep_compound_gigantic_page_for_demote(struct page *page,
+							unsigned int order)
+{
+	return __prep_compound_gigantic_page(page, order, true);
+}
+
 /*
  * PageHuge() only returns true for hugetlbfs pages, but not for normal or
  * transparent huge pages.  See the PageTransHuge() documentation for more
@@ -3304,9 +3323,72 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	return 0;
 }
 
+static int demote_free_huge_page(struct hstate *h, struct page *page)
+{
+	int i, nid = page_to_nid(page);
+	struct hstate *target_hstate;
+	int rc = 0;
+
+	target_hstate = size_to_hstate(PAGE_SIZE << h->demote_order);
+
+	remove_hugetlb_page_for_demote(h, page, false);
+	spin_unlock_irq(&hugetlb_lock);
+
+	rc = alloc_huge_page_vmemmap(h, page);
+	if (rc) {
+		/* Allocation of vmemmmap failed, we can not demote page */
+		spin_lock_irq(&hugetlb_lock);
+		set_page_refcounted(page);
+		add_hugetlb_page(h, page, false);
+		return rc;
+	}
+
+	/*
+	 * Use destroy_compound_hugetlb_page_for_demote for all huge page
+	 * sizes as it will not ref count pages.
+	 */
+	destroy_compound_hugetlb_page_for_demote(page, huge_page_order(h));
+
+	/*
+	 * Taking target hstate mutex synchronizes with set_max_huge_pages.
+	 * Without the mutex, pages added to target hstate could be marked
+	 * as surplus.
+	 *
+	 * Note that we already hold h->resize_lock.  To prevent deadlock,
+	 * use the convention of always taking larger size hstate mutex first.
+	 */
+	mutex_lock(&target_hstate->resize_lock);
+	for (i = 0; i < pages_per_huge_page(h);
+				i += pages_per_huge_page(target_hstate)) {
+		if (hstate_is_gigantic(target_hstate))
+			prep_compound_gigantic_page_for_demote(page + i,
+							target_hstate->order);
+		else
+			prep_compound_page(page + i, target_hstate->order);
+		set_page_private(page + i, 0);
+		set_page_refcounted(page + i);
+		prep_new_huge_page(target_hstate, page + i, nid);
+		put_page(page + i);
+	}
+	mutex_unlock(&target_hstate->resize_lock);
+
+	spin_lock_irq(&hugetlb_lock);
+
+	/*
+	 * Not absolutely necessary, but for consistency update max_huge_pages
+	 * based on pool changes for the demoted page.
+	 */
+	h->max_huge_pages--;
+	target_hstate->max_huge_pages += pages_per_huge_page(h);
+
+	return rc;
+}
+
 static int demote_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed)
 	__must_hold(&hugetlb_lock)
 {
+	int nr_nodes, node;
+	struct page *page;
 	int rc = 0;
 
 	lockdep_assert_held(&hugetlb_lock);
@@ -3317,9 +3399,15 @@ static int demote_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed)
 		return -EINVAL;		/* internal error */
 	}
 
-	/*
-	 * TODO - demote fucntionality will be added in subsequent patch
-	 */
+	for_each_node_mask_to_free(h, nr_nodes, node, nodes_allowed) {
+		if (!list_empty(&h->hugepage_freelists[node])) {
+			page = list_entry(h->hugepage_freelists[node].next,
+					struct page, lru);
+			rc = demote_free_huge_page(h, page);
+			break;
+		}
+	}
+
 	return rc;
 }
 
@@ -3554,10 +3642,6 @@ static ssize_t demote_store(struct kobject *kobj,
 		/*
 		 * Check for available pages to demote each time thorough the
 		 * loop as demote_pool_huge_page will drop hugetlb_lock.
-		 *
-		 * NOTE: demote_pool_huge_page does not yet drop hugetlb_lock
-		 * but will when full demote functionality is added in a later
-		 * patch.
 		 */
 		if (nid != NUMA_NO_NODE)
 			nr_available = h->free_huge_pages_node[nid];
-- 
2.31.1

