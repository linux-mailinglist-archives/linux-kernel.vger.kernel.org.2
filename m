Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C99C034980E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 18:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhCYRal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 13:30:41 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:55408 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbhCYRaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 13:30:18 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12PHOYuY146151;
        Thu, 25 Mar 2021 17:29:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=HOYPIcxVnTKVguQKh4MqPbuM0DAT+3Vv8vE09DajPIg=;
 b=pCS3Dy/bITc7mPpRuQl4DNwXu7eugitbCTLsObQNVxKmfJBE7bfSt3AAotIXWnt3yY0X
 dYx6beVL6l9g1DX2hAKTDN64+6m9hr7BXiedWNPimcaczZjW5rRMHScndTHqah/75A+9
 c5Jh9eg6o4X/V/VbfBrdsjOgXf8Z1FSEQkAVngbErjS+ZHF64aBabG+J8MNXlzPSIAqa
 IHIawnIFL1+nlOLQTwwIOHJavZ5azNiJI9D/V351LXVd9YuwiCiaBLiVjoQPJ5XGb0Ws
 E7rLfOtJM+oy7+SQkcQxZqjCWgn0RW+E+Hetzs8Dufkk1XoEsF58wd6WFPaNm0kONue4 +w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 37gs1r9ban-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Mar 2021 17:29:06 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12PHPGeC087690;
        Thu, 25 Mar 2021 17:29:06 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2046.outbound.protection.outlook.com [104.47.73.46])
        by aserp3030.oracle.com with ESMTP id 37dtmsdjcq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Mar 2021 17:29:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kvosK8DhZ020H4nVixGouMVtykr0zivNjSIg5OQQVM/inMy0FUz2cd93xwBIL3moFff/52olS2tbVUqFfRU48euzjA6/ysiQzCsQf42HBRyOwoYQcs6KarfOdMWPAYwGLHEybVQTO6uDL+39oM4+fQMJjWMBM5ntRpDbNWBuI68qXqZfZhnDCtdZa6IM0MPTv3cGq23aZez0PMeppK6m4ljlfSGk/V7UGBp6ZmjNITsRGt3sc7Y0offgs4leqWBGfAt3AT8KKKTTcOOMoEAN7cWDAZjhYjFP3sfY0Y0cYOSeECW4R1utz6mFjgTx0Gh0bEqqP9jTiMpVvQuyWl4dWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HOYPIcxVnTKVguQKh4MqPbuM0DAT+3Vv8vE09DajPIg=;
 b=JM3CNhRQz0kmr667fz7062N1G4fBpHdZyVj2B8MkkETGnn0PrILmMZpqscT9jDYJAcJFOJk0VhtuxDgmw2b0pGBW5MEqhG9lEFKI4Y4urVDcBbP4GtQm/h/zgGwVNYRrl35SBYxZvy53KegXSakwm1r7ihp/CZPo+6wcI1bbO7op/fHE+AqpioVYDYfiDWHW0pfWanHfyHUeg17mf/LYQ7wKwaJIs2v26WDtw8k0l14/uid5Jel78avc7ZyQ2X7pabUgLa5UCvL6PwmtFvD340Zta4OTK/k58Sa5YIT0CEbqETz+ONOyMNKwY2Nw4S77SrwmHiijWH1n4JajNX+E5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HOYPIcxVnTKVguQKh4MqPbuM0DAT+3Vv8vE09DajPIg=;
 b=LFISHrHz8MCVJ1mJIhh7A7HlRo7v0bZfIODYwBmT4WEsnJcIegl8ITG1KBXJuAF9cV781sP1R4NUeFlVALZ/WsgPR/avwRzrjmAZO08ulk7zyf8TxRYqz3hOOJ97xLWbsrowihyZ5uZWgTAUvjODOn+SyYb7SDuOZreCxwSHN8o=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3253.namprd10.prod.outlook.com (2603:10b6:a03:154::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Thu, 25 Mar
 2021 17:29:04 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%6]) with mapi id 15.20.3955.027; Thu, 25 Mar 2021
 17:29:04 +0000
Subject: Re: [PATCH 6/8] hugetlb: change free_pool_huge_page to
 remove_pool_huge_page
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
 <20210325002835.216118-7-mike.kravetz@oracle.com>
 <YFxurrhDuZZG1FlQ@dhcp22.suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <c47d8c15-dec9-8f65-d9ac-e0abb27b65ea@oracle.com>
Date:   Thu, 25 Mar 2021 10:29:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <YFxurrhDuZZG1FlQ@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: CO2PR06CA0071.namprd06.prod.outlook.com
 (2603:10b6:104:3::29) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by CO2PR06CA0071.namprd06.prod.outlook.com (2603:10b6:104:3::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Thu, 25 Mar 2021 17:29:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 793fc539-00aa-4bd5-38a7-08d8efb37c80
X-MS-TrafficTypeDiagnostic: BYAPR10MB3253:
X-Microsoft-Antispam-PRVS: <BYAPR10MB325366FEB706EF61AAA19F48E2629@BYAPR10MB3253.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p495poptwKDfi0c3U4O6TBZH2IBqIgH7QMQH48qLWfoXtmNXYZohI5oKUxkWPKqSGnDp0hTNKBzD41QItXSwBPrWlTNiK5mwfy3C7kbfZxt1JApqAIZ7R6dEvawqdr1fk8YCYJhsE8v7PTuyEiJFRqXYo0wlQeyhLUR38jnsfE8xJkreN17v2QA8LMeJOkVCSm8/0WQLC/t00ethqc3Ydfe2JzVH8+lRFY6jMNrRS+wutOsEgkafeXGl46RpKtr+TNmK2UD9EbtcXiN2x99Ygm8CEH/aWGBMYjb1nHHm5Gu8UbTpXNo6J83Qt122z4G/eFI+pObTUq5gx3FzwQmM+z2q4JIvfq1IqF7hotOmw49NQxrmFsLw2i+psVaSRLxcG5hJe4fH5sMWB6FA7t9neq0Q5+R8RZARCm+r3RBDsGJ3P+GDInrZNu8ThdhezXu5qdnaqn/HFb24xQN/UQ0bcC1nuOqyx1I35aICVm38+40dsQsI3z56FyZy9nTtJ9MXnoKYUVdI7hGdwr4YoKfsbwjIAe+4ZNMdFS3hMjhJcrLqxblM7mJgAtfupXBaaCfH0EHg16xgXVSZdH+F7f23dOqMoxGGje5yBpCmIZS69h7bWXyLx1ObJD0d1DYnquj7La6ifjsjolLhMrCSIqr4aJSvnd7kO8imJRlXP4WCFJfhm4QsRL0vaYwVdoDxekf75I07MOV9RhePRGECB9tozz4RCRa5pMnoUZ8pX8k4HKOCbiagb7qRqzYpGiwdlb94
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(376002)(396003)(346002)(39860400002)(52116002)(38100700001)(26005)(16576012)(36756003)(186003)(478600001)(8676002)(5660300002)(16526019)(53546011)(6916009)(8936002)(316002)(2616005)(44832011)(4326008)(956004)(6486002)(66556008)(66946007)(83380400001)(7416002)(2906002)(86362001)(31696002)(66476007)(31686004)(54906003)(14583001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MmR4NVJKYzZnRTNVSXVrNENVWTdreERKNHVwaEh6RGVSNDM2Qy9OQ0xFZzU2?=
 =?utf-8?B?WXVIekJEWEtzWXNOQWVIK2YvL2FNeGxVSldpTWdpVzJqRGprai81dWlnOEhN?=
 =?utf-8?B?bUk4QmpEOEJYWGJEa09LTThqdEhrVVJHb0ZOamNTMVZ1bk54Q3FNSlViWmYr?=
 =?utf-8?B?bzNINm5zVFhUdDk5THQwVjB5aVErR2Z6MENvbTFaZC9YanBwb3FMa0pUazda?=
 =?utf-8?B?eG1tdlBxbklNOEV2UjlBb3R1bHFOcXpYb0ZYQW13REVKTWh6aDFGcUF4c0tw?=
 =?utf-8?B?WUNGbDU5TnpQMHl5Y092RlphWXgvYU5vaWdFY1UwR0tkak0vTnVOdDJnK2Rm?=
 =?utf-8?B?K0hYTDZhRGtiU3o1QmJXTzBRWitieXZzSXNhbUFCdkNFSVU2WXZ0SXdjUFJS?=
 =?utf-8?B?R2YvMTlhQzJLb2NyQ29Bd3o5VXQ2b0RxbHhtTzk2SjN1WFJIVGNlUWlXUFll?=
 =?utf-8?B?THlRU0QrSkFKdFJFN0FoRFUxRmIwK0VKeU5QN3V5b3lkbXMrT1E4bVJma2E2?=
 =?utf-8?B?dnFVTzVISEtXQlhtOERCNmF4cEY3UkFsMll6SWMwRnZucElMbXk4Zmc2TkNl?=
 =?utf-8?B?UE1Eb1AvWHVoc255cUh1cHdnUlhBakVlYnM5bi9QVkcvSWt0UGVqK0EzUmtN?=
 =?utf-8?B?RnRYRktTOC9EVFZYK1JxdWV6bDZMQ3pBNzZSU0Y0QmFmcTg3ZmRoQXowdzNW?=
 =?utf-8?B?NjJ1b1hKcXNYSTk0S3JYVVBTMUwzWFQvUzIrVTQyQlJoYUlQano3TTdiNVdp?=
 =?utf-8?B?ZTlZWElGUVF2eS82Tm1Eb1k1KzV2WmFyaUFIMnhwbmdyeVNiWXRZZVRhRWQ0?=
 =?utf-8?B?UVVXZjI3NGZra0podXNDU3FVZStrMVN3VUJxSGpPUURZNzNlTjI1UXBmWU53?=
 =?utf-8?B?RU0vQk5Wc2t4cTdCNk9FMkdDL2hNQjVYTG9MQ29pSWlXSFNGUXNCK05jNlJ0?=
 =?utf-8?B?R3AxTCsxTThoUHBna2tJbUhnM2pPbmhxUy8rc0dXYWJmTkl2NVhLeFRLdlJY?=
 =?utf-8?B?T2NJdWJWaC9RVVM1R2l0SVFvVjdYQkVYdkltVjBUOHg0ZHN3SEdRNGYzYm1q?=
 =?utf-8?B?K2RKV092NUYwVGFjNEphQndqOG9EOG5NbDVBM3libXpjaE0zeUxrVnNQMjdR?=
 =?utf-8?B?V1lPWVlSYllYM3p2K3hITUVPTFh5R3E3MWJheDk3aXNBVnlWblExcURKNnNu?=
 =?utf-8?B?dWhWVWhLanhHQUxKZUdXYUxvVXZ6Uzk2YmZuMTd0WCt4OHVBVzZGaUlSVXlO?=
 =?utf-8?B?MXJiOGpXdTFKeHVWVE5pMVZ1NkVnc2l1ekhxamI3SVFYbHY3UURzV3BPK2Mr?=
 =?utf-8?B?aHNja2V4V21Zci9rNVJUN0FlblpTL2FRTlZkd1oxalZWU2pnUW1kSG9hYUVw?=
 =?utf-8?B?SmgzcFFuNkgvUjJ4V0dETWJZSG4xUkVDY0srOTFNN3Z6Q2FZVlArTFkxUmZL?=
 =?utf-8?B?aEFwQXUwR0dJMzEraUJOemU1UjNvREZwVzh4cXpHZk9lWnEwV2wwYkNmenhp?=
 =?utf-8?B?eHNOM2JQSTlINS9CQytKU0lwbmJ0WXl1WTYzSEx4RlZvVzJIejdlOXZoNFNt?=
 =?utf-8?B?N21IQ01yYzMxWElpaWhKYW94WU5VQVowVXJhT3MxZm90c0ZGdWIzU3lUblM0?=
 =?utf-8?B?b3ZzSFRJRUxYZlJpZThLS1AzOUYyTGNNY1lYQXlzN29aUUliMDZuSGFsOGVD?=
 =?utf-8?B?OGxQdWVWM3FDTVpURmE3Z3JhakdWeC9XKzFPYWNkdHNQRUdZTzJIai82Risz?=
 =?utf-8?Q?c1yE6OZLwDB49OKDIMl1rud+f0GIJonaYQOzECG?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 793fc539-00aa-4bd5-38a7-08d8efb37c80
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 17:29:04.1978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EfyaBzfEmZ/iVuADfOfSkI2rhi2izeiZCBAFT1bHjZU4LsdSxlTzL9kbJ9Lun6gqpzTR/BXb4E/k+DYh2La/SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3253
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9934 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103250127
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9934 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 phishscore=0 impostorscore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103250127
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/21 4:06 AM, Michal Hocko wrote:
> On Wed 24-03-21 17:28:33, Mike Kravetz wrote:
> [...]
>> @@ -2074,17 +2067,16 @@ static int gather_surplus_pages(struct hstate *h, long delta)
>>   *    to the associated reservation map.
>>   * 2) Free any unused surplus pages that may have been allocated to satisfy
>>   *    the reservation.  As many as unused_resv_pages may be freed.
>> - *
>> - * Called with hugetlb_lock held.  However, the lock could be dropped (and
>> - * reacquired) during calls to cond_resched_lock.  Whenever dropping the lock,
>> - * we must make sure nobody else can claim pages we are in the process of
>> - * freeing.  Do this by ensuring resv_huge_page always is greater than the
>> - * number of huge pages we plan to free when dropping the lock.
>>   */
>>  static void return_unused_surplus_pages(struct hstate *h,
>>  					unsigned long unused_resv_pages)
>>  {
>>  	unsigned long nr_pages;
>> +	struct page *page, *t_page;
>> +	struct list_head page_list;
>> +
>> +	/* Uncommit the reservation */
>> +	h->resv_huge_pages -= unused_resv_pages;
> 
> Is this ok for cases where remove_pool_huge_page fails early? I have to
> say I am kinda lost in the resv_huge_pages accounting here. The original
> code was already quite supicious to me. TBH.

Yes, it is safe.  The existing code will do the same but perhaps in a
different way.

Some history is in the changelog for commit e5bbc8a6c992 ("mm/hugetlb.c:
fix reservation race when freeing surplus pages").  The race fixed by
that commit was introduced by the cond_resched_lock() which we are
removing in this patch.  Therefore, we can remove the tricky code that
was added to deal with dropping the lock.

I should add an explanation to the commit message.

Additionally, I suspect we may end up once again dropping the lock in
the below loop when adding vmemmap support.  Then, we would need to add
back the code in commit e5bbc8a6c992.  Sigh.

>>  
>>  	/* Cannot return gigantic pages currently */
>>  	if (hstate_is_gigantic(h))
>> @@ -2101,24 +2093,27 @@ static void return_unused_surplus_pages(struct hstate *h,
>>  	 * evenly across all nodes with memory. Iterate across these nodes
>>  	 * until we can no longer free unreserved surplus pages. This occurs
>>  	 * when the nodes with surplus pages have no free pages.
>> -	 * free_pool_huge_page() will balance the freed pages across the
>> +	 * remove_pool_huge_page() will balance the freed pages across the
>>  	 * on-line nodes with memory and will handle the hstate accounting.
>> -	 *
>> -	 * Note that we decrement resv_huge_pages as we free the pages.  If
>> -	 * we drop the lock, resv_huge_pages will still be sufficiently large
>> -	 * to cover subsequent pages we may free.
>>  	 */
>> +	INIT_LIST_HEAD(&page_list);
>>  	while (nr_pages--) {
>> -		h->resv_huge_pages--;
>> -		unused_resv_pages--;
>> -		if (!free_pool_huge_page(h, &node_states[N_MEMORY], 1))
>> +		page = remove_pool_huge_page(h, &node_states[N_MEMORY], 1);
>> +		if (!page)
>>  			goto out;
>> -		cond_resched_lock(&hugetlb_lock);
>> +
>> +		INIT_LIST_HEAD(&page->lru);
> 
> again unnecessary INIT_LIST_HEAD
> 
>> +		list_add(&page->lru, &page_list);
>>  	}
>>  
>>  out:
>> -	/* Fully uncommit the reservation */
>> -	h->resv_huge_pages -= unused_resv_pages;
>> +	spin_unlock(&hugetlb_lock);
>> +	list_for_each_entry_safe(page, t_page, &page_list, lru) {
>> +		list_del(&page->lru);
>> +		update_and_free_page(h, page);
>> +		cond_resched();
>> +	}
> 
> You have the same construct at 3 different places maybe it deserves a
> little helper update_and_free_page_batch.

Sure.  I will add it.

-- 
Mike Kravetz
