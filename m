Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88A563497AC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 18:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhCYRNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 13:13:22 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54014 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbhCYRMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 13:12:51 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12PH4mxh095819;
        Thu, 25 Mar 2021 17:12:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=iTh0OyQUggNI2y7D2piznrA9L3azHoD0CgsKQtu/mH4=;
 b=vdZH4IQj7tZUAG/QDEHe6nvvXTr+5wX74VE/onoD7pDf6/MPVUXcNQNw3EaRA03WWsHx
 99CWt7RVlSFyz8u++78umHP6xL9gopY5sDYUxTlJdkBpCXZOvtBha0XRoFWVUVLAeecV
 wJBRXkOV9/nIggYzk5GawLaeGOfEo3nmnCfZQza0MHYuhJWG4dlwg0dMK+T/v1AcMJh1
 jAmoP4B+0k5AyUvbYNzT6ENZcCZPKtUVMKib51P3Qh4fVmlXy8qPXlpXmt4/HbZL55Yj
 fJyN3xiZ4bo7NJvkuKfww/ahDlUIBRgVSliqwO9wVg7FgN0yXtcIwvfGlxjWCHXRc+9X MA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 37d8frf3m7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Mar 2021 17:12:10 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12PH5IXZ196054;
        Thu, 25 Mar 2021 17:12:10 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by aserp3030.oracle.com with ESMTP id 37dtmscw8h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Mar 2021 17:12:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JCUBT5TwX5kSuBHwFj12sGlwrnZD/UV7PSwdeBI3C3cjZ6ZLMu/jj4OE8/ETaRx8XSTi+tS7WY8VribMw4YlnZxIBLbIg8cv2kWjBR6DVEejtcblGGw6EQq76uvB8q6gBLYUik30SP6+V/aRJr5smk6OOXPqIcWuGzmX5hgTSX+q9b4kIYMQYVqKQcYc5ZEbgyDlWxcFXQ32Lm3XRWNFqxHLD3mr/mB6AmAM5bsKWAtdgCAp1e5BRDMAa7M5caqjUA+sXo8uvDm7Pgqmr9dBaS4BgWX86/dSc07YmNkbRLGFS1eDKuUVltmK4KHjEMG0ho/oFXnHrmS1uBtakefmkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTh0OyQUggNI2y7D2piznrA9L3azHoD0CgsKQtu/mH4=;
 b=gyStRLBWhErvAkwgK15P1z4xVS7I/MUQO2ValH3ZP/iu/jex9ertYd4pkq9C3qe/rlbA6kvaE4pfkbZnsHrHhsxbUUUZtzgrAKtY/ndutVS6ISJ5/efJHXieZ3/AXih71TYHCC4nhVcaNH7eVNwh/wFoOnSFvXjMyyEsDDlzIW+9n5wYhnVg4krJSJ708wm0XdGKMvtJ8uyLreq9Lws3vdVO2DCVTzxv8ZOVdfVH8kxZSfDznT7mqQahCHjoVTfSbfwMjnz6CHLqdzEX0sc6CcA02R35XICIJ/DhfC8p+47h8abkROiM9tVMw1xIqCuJ2Fec13EywwVjQz++vPaBzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTh0OyQUggNI2y7D2piznrA9L3azHoD0CgsKQtu/mH4=;
 b=h8mqQ2Bzcf/h2Dhf0Fw5EVj2RPz551nNlCaX9b8hhRGyYzLw2hCMDKb++mLRCWpskNKRR5XhGI37Q0srfDy3UvtCEV7jfDTZur6RPJ5IuIEeO7ESXpWenWrUd5G+Jq2pHd9gaOcJm4G+aZP+yZlEfrsPsysmOhtnjDf7OevS8cw=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4733.namprd10.prod.outlook.com (2603:10b6:a03:2ae::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Thu, 25 Mar
 2021 17:12:07 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%6]) with mapi id 15.20.3955.027; Thu, 25 Mar 2021
 17:12:07 +0000
Subject: Re: [PATCH 5/8] hugetlb: call update_and_free_page without
 hugetlb_lock
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Rientjes <rientjes@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Waiman Long <longman@redhat.com>, Peter Xu <peterx@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Hillf Danton <hdanton@sina.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210325002835.216118-1-mike.kravetz@oracle.com>
 <20210325002835.216118-6-mike.kravetz@oracle.com>
 <YFxsB4YLXCobtGGv@dhcp22.suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <d60a13c9-24c0-1d24-85bc-08a0090d282e@oracle.com>
Date:   Thu, 25 Mar 2021 10:12:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <YFxsB4YLXCobtGGv@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: CO2PR04CA0092.namprd04.prod.outlook.com
 (2603:10b6:104:6::18) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by CO2PR04CA0092.namprd04.prod.outlook.com (2603:10b6:104:6::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Thu, 25 Mar 2021 17:12:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ddb74fa9-5610-409a-b394-08d8efb11e9d
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4733:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB47333F4802A7957E5C19EDF1E2629@SJ0PR10MB4733.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JwIFigvoEXJDJIsi0/VmPGRVx14LsR+STeQP/bDz+3SCpyn+VGhwEzfn8kCOXS50hd2CCxPp39I54yz55gTIqpoeZpz/r8RISL3XN1Doovw5xjAMh7jytYGPopFX2qB/oiK6mKkyNaO4sYWg0aHl9oQOTYUkmriwzVQSg82kCtLYBm5ZxrstYxkvbhmE1/lEKjw5m7/wI+8q+LUaX5JHZAFgOj3i0yflCWlkMWXVymQGNH2Ffz4Xx78WMUegQ5qP6n4Qe2uhNiKIYwOBUogk5eGOXG66iKowU7eQXxxWvW9IMS4ZqWLm3+k1eeGUGERn2ragpTYHUOA1vZPeQ8Rqg6WzI6Dh7kuiVVoHA+4fwUhiaHsk+zlrZw3pC3fkaq0neo0g97ckrm2VT6rsgdeQ+OXpJi/Fdx/mCa7VK74LwkL2zwvOj4B7osURlEETF3NP+TLk4gAtpdPLaCq7VWAQRzi3Ly146ulMG1PZ9ePj8pMJLFwWQIDmJJdPT8YcXn0Ig81R1RJxrLbakTvYivrG330w8s1m3v9XykUp1O2MEybs4XPznCjuOqAauj99AF9RSC0FJwHhJwqDy6KqAlu+x6CiOT5PQ8Q+FI72elONLkLOAMwe8AvDZrQ+1Bu1t2P31PBCtEqbO0BsjRQE2UWhkvjAgFZBZ33ftbusIVcZ4xX1LsxBExiP//+/DTD1nrooPPUvkmCBa7WcfFngY0uIUb70WdQAJvQB2tykB4/Fdro=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(39860400002)(366004)(346002)(396003)(31686004)(15650500001)(2616005)(53546011)(6916009)(2906002)(8676002)(66476007)(6486002)(8936002)(7416002)(5660300002)(66556008)(4326008)(956004)(66946007)(16576012)(186003)(16526019)(316002)(86362001)(26005)(38100700001)(83380400001)(478600001)(52116002)(31696002)(36756003)(54906003)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TDh0N3hsM1JOcDVHVnNydjYrWDd5b1d0c1ZBUkl1bUR3SXBjdmhIbmVzUmdW?=
 =?utf-8?B?bytEYnhJK1AzSlhQUitUK3c1QzhxYnlpQWZoUDF0WnpNU3lMakhPdmIxSGxt?=
 =?utf-8?B?OEZvWTNJdVdtZ1RxSkVJMCtBc2MvRXl3L0JqVEhHSExLcExoNUpjYjJOOXRu?=
 =?utf-8?B?UitldytPSzNxWlBPL1V3eFY5Qy9RVFNzNWxBSVZ6NmNtejZCOWloR1lOaUVF?=
 =?utf-8?B?bDd3L3o0Q2FwdEZ3TG52RHJMTjdSdUNnaSsrNGFtOFVJQU12eG9kZjQ1REsx?=
 =?utf-8?B?VUZzM3VCTGkvc1MzaVgzZEpseHFXV1pFMzJISE5QVVIwZHBSUzNMZi9XS1VW?=
 =?utf-8?B?S2RTR2Y4b3IxamRrS2Z6amdUN1JXcHkrempEdnhINkhDMytmTU40WElCM1Uw?=
 =?utf-8?B?STdNblAwU2RaU3hhcjBTK21QSEVIdm1yNkxKTmZ4dmdHemE2UlZ1Mm1XMXVj?=
 =?utf-8?B?UlRWNnJoeU1uTFVnVm93ZGw0UUo3MGhDRDFxMCtORDM5N085c0dTRWtvcldG?=
 =?utf-8?B?cTExY05PQVJLeW12ZGdWZTVPUzRLU0locXEwb0hjLzA5RVVFUGxGYytBdzNo?=
 =?utf-8?B?ZmZmZzNFa2JSb0pqa25YYUdGQWtyNUI3bk5SYTkyUjBRMSsrVzV2bmllcDNG?=
 =?utf-8?B?U3ZES1FjUGNNZGtkZG93MnAxWmpHbmtrc1JxUmJiVUN0ejJaOGhwVHhldGZN?=
 =?utf-8?B?QVpwOTI2SEtlTXMyeVd1SjV0cGRIVTU5Tm5kdVEzZ2RrOHhDbU5QNGR3L1JO?=
 =?utf-8?B?NUxGcldEeGNzd241aDVIZXpGRzQ0NnVibHBpUWFIb1hQc1JFQS9jNFpJQkxz?=
 =?utf-8?B?c0ZCTzdCY0dvTlJSS1pqQ25FbVU0SUNpZnJLVlZLQ0duMTVkb2h0ZkQ4MmR3?=
 =?utf-8?B?bnRTd29YTjAyOFI1cTN1TkVOSHU4VENmNkY1U3ZmN0dKRmpOU2hENndLVWdT?=
 =?utf-8?B?eGR3VTdSSzhKNGpLczJYNUlweWlmVEw5TkVVWWlXWFZVWVRxaVdqZEo2cXFV?=
 =?utf-8?B?azBvWURZWURlMWR3R2ZIWkNJdW5ySW9BZTNCZUN6WEQwL1c1S2xEVlRVdG01?=
 =?utf-8?B?Q3Z5Ry9pcUU0cjRVRVlkT0cxMmhWY29NY1RFdlNnckREVGxlWEowdEVtekFU?=
 =?utf-8?B?Z0pndEUzZnFDdG1HcHgvay9ab1dlWTBwQXF6bGlpd3ZnMjh1b2NCelFHdHlO?=
 =?utf-8?B?UkxBN21rSDNsOFRZV1NNd3RpWCtsZGVmRWFoak0wc3dqdTNiTVdjVmFPTWxk?=
 =?utf-8?B?dWVzMUd4aGRCcmx1MkhNYS9nQWxOUSsySEFhRUE2N0ErdjhtTmJxdzY0QW5R?=
 =?utf-8?B?WEh4TFhSalg3TmprTDJWYklnT2svSmlLVGxsVVhtUjNJS1FMeFBSK1VpcFRC?=
 =?utf-8?B?NUg3azVKdHdTWkl3ZVdSODFkMy9HaUxEN3dQYTR0czBuNU05YUlQWTlFYlN4?=
 =?utf-8?B?OWZ3bWl2V1JMWVZ6YVZSRTRFVDhwYklMQkU1UUoyMXJXQzl1cWZ1N25NUUpw?=
 =?utf-8?B?c3NyMUZLUDBpVUJuNWJMZjJ1KzFtNnp1cmRwNWJkc1c3bU93WE5WUXdHWkpM?=
 =?utf-8?B?UjdBbzdJTTBYT25EYmNZcTFvMy90K2lqcWlJTWRCYWYyQXEzQm44WlRMYmdp?=
 =?utf-8?B?MWxEaDFQeDNKOFFhV0s5dFRkK2wvUmswSG5vb0IyTmdaU1A0UnlFQ0dGV1hz?=
 =?utf-8?B?alBNSmp0S0F6RVhQK0V6c2p2L3VwZmtacFBoZFBxTUY2Y3JBRE9nUm93S2JW?=
 =?utf-8?Q?Nfp+QbYxuoORHAR04/3e/cBz3kgq/V//jUrrgb1?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddb74fa9-5610-409a-b394-08d8efb11e9d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 17:12:07.6250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Jav/M4VlFNSUKn0PBiYElcYCWwGKOWjFZ5SzbnB+wPFj/1PY247TbdeobU58KTBy0JFVFGk09qNPWWFXLIrpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4733
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9934 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103250124
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9934 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103250124
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/21 3:55 AM, Michal Hocko wrote:
> On Wed 24-03-21 17:28:32, Mike Kravetz wrote:
>> With the introduction of remove_hugetlb_page(), there is no need for
>> update_and_free_page to hold the hugetlb lock.  Change all callers to
>> drop the lock before calling.
>>
>> With additional code modifications, this will allow loops which decrease
>> the huge page pool to drop the hugetlb_lock with each page to reduce
>> long hold times.
>>
>> The ugly unlock/lock cycle in free_pool_huge_page will be removed in
>> a subsequent patch which restructures free_pool_huge_page.
>>
>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> 
> Acked-by: Michal Hocko <mhocko@suse.com>
> 
> One minor thing below
> 
> [...]
>> @@ -2563,22 +2572,37 @@ static void try_to_free_low(struct hstate *h, unsigned long count,
>>  						nodemask_t *nodes_allowed)
>>  {
>>  	int i;
>> +	struct list_head page_list;
>> +	struct page *page, *next;
>>  
>>  	if (hstate_is_gigantic(h))
>>  		return;
>>  
>> +	/*
>> +	 * Collect pages to be freed on a list, and free after dropping lock
>> +	 */
>> +	INIT_LIST_HEAD(&page_list);
>>  	for_each_node_mask(i, *nodes_allowed) {
>> -		struct page *page, *next;
>>  		struct list_head *freel = &h->hugepage_freelists[i];
>>  		list_for_each_entry_safe(page, next, freel, lru) {
>>  			if (count >= h->nr_huge_pages)
>> -				return;
>> +				goto out;
>>  			if (PageHighMem(page))
>>  				continue;
>>  			remove_hugetlb_page(h, page, false);
>> -			update_and_free_page(h, page);
>> +			INIT_LIST_HEAD(&page->lru);
> 
> What is the point of rhis INIT_LIST_HEAD? Page has been removed from the
> list by remove_hugetlb_page so it can be added to a new one without any
> reinitialization.

remove_hugetlb_page just does a list_del.  list_del will poison the
pointers in page->lru.  The following list_add will then complain about
list corruption.

I could replace the list_del in remove_hugetlb_page with list_del_init.
However, not all callers of remove_hugetlb_page will be adding the page
to a list.  If we just call update_and_free_page, there is no need to
reinitialize the list pointers.

Might be better to just use list_del_init in remove_hugetlb_page to
avoid any questions like this.
-- 
Mike Kravetz

> 
>> +			list_add(&page->lru, &page_list);
>>  		}
>>  	}
>> +
>> +out:
>> +	spin_unlock(&hugetlb_lock);
>> +	list_for_each_entry_safe(page, next, &page_list, lru) {
>> +		list_del(&page->lru);
>> +		update_and_free_page(h, page);
>> +		cond_resched();
>> +	}
>> +	spin_lock(&hugetlb_lock);
>>  }
>>  #else
>>  static inline void try_to_free_low(struct hstate *h, unsigned long count,
>> -- 
>> 2.30.2
>>
> 
