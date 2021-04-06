Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6E80355991
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 18:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239446AbhDFQua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 12:50:30 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55248 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233218AbhDFQu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 12:50:28 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 136GnQfP122566;
        Tue, 6 Apr 2021 16:49:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Z0pHlT8qJantSLBDBf4JzSHDpBuYQnooajIBp9oSuhQ=;
 b=ZOu0beBcgn84w+SRuGYqIpz4/uosza7aYi4XRGCyEtPHRzGCwDSoAVqNt3bw2m7JSvsh
 dIFhAhXpIKUEIQDprO4aALgeklORIIUuIN9vpoT9ZvsZZTR5PgFOIKXSRZbE7PBogkQ6
 8fkeHML0/2LjwIZNm9faYlyrGNNedYREsTxL0kWGDi8kNgEKRV9b9bw0Nfk82snNKmOc
 6MfuTlt2S8eutWYIC8pG82hc3JrZ4M7tUeyG56qTuE6R8IJBdYgCAOXOAoeisQ6+4gWC
 kFdFe1WoYmlDvBMmWFE4SIB0okVwJz6myxRbFpVbQ9+idm1RyEZWFYAD4+RA7MpVrRO4 Gw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 37rubug0yg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Apr 2021 16:49:25 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 136GjGQa105694;
        Tue, 6 Apr 2021 16:49:19 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by aserp3020.oracle.com with ESMTP id 37q2pxrx15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Apr 2021 16:49:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LwxORZE5QkQxeurQbJkpiMr75ubN2Csy/6b8dDa0O7tFpy0K/IHy/1sKMIb72CNUpyYL1ME7Quac+D9v2y8z49qs380zCo6sv+RLY+aoj9iFeGP1xRMGOF4VRBQlFEBxwZpzuCCB6kqV3tOtGFijZB1sAE053q4RTUBu9SLlHdF1MSB4OCkcNd9TrosVhDpwpwQ5R1s8aummq4pqGx9k2oUd0PBhrZKXBF3KaHFdthuWCQVVcoN6ovzdfMClSqUooqZtu8dz3t493Vajw0fpapzqkJxpHBmkrh98O2RY0VkgOteDpNRNltxfUI0OLHzAzRncaRzL0+oVJ4ftvG91ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0pHlT8qJantSLBDBf4JzSHDpBuYQnooajIBp9oSuhQ=;
 b=Be/pbjTNk91/rllsVngI/DCgnyjkkw24dO25D/FK/Zwm7cIj0s8llbXOXtB+XYvjRJveMZGNqY7fSWEng/Cz6ECqai2J6AT/Rs8Z38oCH14QVGhKdN/S2W5kj3UXNuJZm3JIecG+vwa85Z+fBN+7M44g0Bn199dz+GWatviTW2wzHFSKCOh6KLUTcmrSxjplnEX1jdygZV9PYjRHxRaxEo0+WG3hThXRptvMttUNdjAZTmWBTBbeO6GtS5ahhm7Nd+rEI8n3AqzBBQWMeoh3EvEu5XI5URvqPlN1JVKR0wkDu37VCPPpJdVFmOl9hG7AyrgHBo5xHI4zU+aHciPI4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0pHlT8qJantSLBDBf4JzSHDpBuYQnooajIBp9oSuhQ=;
 b=xvarr4p6E6qw+so0amfsxdHSnIiQ3iKL9quF9u0MmbsAgJ3ZwVRhnrC95PVZUYbsHXzdZ/A9hBU72+H5EOJnunU/DcVCgo0nJ3M1PqNrhjpMxQC3QM6CnGfVbWIUKxK7NLE5BOOX+nT9tu8iNPEgc7tYuWD6EOqTd/N80HsI7B8=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3688.namprd10.prod.outlook.com (2603:10b6:a03:11a::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Tue, 6 Apr
 2021 16:49:17 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%6]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 16:49:17 +0000
Subject: Re: [PATCH v4 4/8] hugetlb: create remove_hugetlb_page() to separate
 functionality
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
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210405230043.182734-1-mike.kravetz@oracle.com>
 <20210405230043.182734-5-mike.kravetz@oracle.com>
 <YGwwO0galuKQsD0J@dhcp22.suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <b684d7bc-4c59-0beb-3af7-a75e76e77a87@oracle.com>
Date:   Tue, 6 Apr 2021 09:49:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <YGwwO0galuKQsD0J@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR17CA0093.namprd17.prod.outlook.com
 (2603:10b6:300:c2::31) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR17CA0093.namprd17.prod.outlook.com (2603:10b6:300:c2::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Tue, 6 Apr 2021 16:49:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 082433dc-f93f-495f-7606-08d8f91bea6d
X-MS-TrafficTypeDiagnostic: BYAPR10MB3688:
X-Microsoft-Antispam-PRVS: <BYAPR10MB36883B22EDE18360EF67DD9FE2769@BYAPR10MB3688.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:469;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J249Oee2uDHw0/VdI60EzrlPWaCDNUpslvr/VqJtyKR//pxP5oZ2aZo+F5Teb8i++iBsE36i2gS8xOBX8XfSWGGBKSEmy70vdW9JEDNz778oy1pjXM9pQ8Qw6xmZeiMc+hu2y8dzWmE8HLwS33Vwj6roIeS3OVSSDsxH6/TrifHjv26oSvqfwdRFe/fPoMv3UDy0ZOwFmt42pyzkrsHfVSaMM0I8X3si4Epa0dPrR5LFwz3S9ZaZxp798slNK5STr+VIAyQYc4NtR33nQyoLitEGi0CvD/kZzQACpdR47f9+EC7MxNXOsfiUe4ztpXDNjNsYQ0AnMOpGAhIDgIjrmjnd6/pwKdjhmAc4MwUSv7ndUmDStLCqt5890GmY2C7e50TtO1tgwemQHUyAgKUxo1Vhzu0sOrpwBi5Pyp7LwhSpsI+yXHWlVB6bn8gYhN+PQpWqVphzPWP69NgaPrX+Y3LqZ6SaK7qE1n/JAPam90VemYdqafwdRzBeokpauawoADSAam9XVomA9qcvkKobUnzx+/SBrDS43oI7VvoxCfb4VwCZaoT5tANeduKS5E8gjlUHl/zZLojFhIcEvIGJdoMhm2DC8jCEqRsZ9lOWz66H2TRj2KByXfbWo5oOHcL1pib+autAx7RliO53d74Y9cUlnjVhHezlwxNfLZR8PSbXoz3TeO7EGhvwgumjfveOiWZa3HzdLlMTVvKjHjyTEelcMsKwnInHKhYNoEaQIu4WywGet+dCKJnrkm8cGq5e
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(366004)(136003)(39860400002)(376002)(2616005)(83380400001)(956004)(2906002)(86362001)(16576012)(31696002)(38100700001)(7416002)(38350700001)(54906003)(5660300002)(44832011)(26005)(16526019)(66556008)(4326008)(66946007)(66476007)(53546011)(8676002)(478600001)(6916009)(52116002)(36756003)(316002)(31686004)(6486002)(186003)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ODJleGVJS0lJWmlLTzhaRUI1em92b1VsSVZMY3RSK1gzdHJ3NDhEbjB3VkpJ?=
 =?utf-8?B?a0pvNWczaE9KVjExU3NzWVpwSlF6enNqcFJrSVdERk5pOUJuK080eGUvOENQ?=
 =?utf-8?B?ZnovUVNSSC91MlhRRmdqdSt0TGpncTVoYXRubnd1dG9laisxOENNWTFiN3k1?=
 =?utf-8?B?UXZBRW9EMDJXZzJpSjdsQStCYWppbUx2SUdHLzFLSERmT3hMbU9YMkN2U1ZI?=
 =?utf-8?B?Z2s1Mmk5dUZBaE9rT1hjTUVpOExDM1hudENnbGdOek1XdlZqY20vcjE2WC9G?=
 =?utf-8?B?cTU1cnR0VVBCNXp2eWFRbHhFRHJEbFI2RWNRWTljbFdLa0hSTWhTUWt6NnAw?=
 =?utf-8?B?UXRXTkYzenRMQ2pNM09tYWJpa2ZtL3lZWmNzVTIzM01rWjU1RTkxYzhUdDN6?=
 =?utf-8?B?c3Nud3A2OHZiN2NiU3hVbnZhQnE5OTdDZWpTdExFMTdIRTBhUU4yNFJ5dWVv?=
 =?utf-8?B?WFdLaXBhZFdvbHBUZmZJWGZWRnVVU0xNL1ZhQko1RlVhb3puZmZOalBERmFS?=
 =?utf-8?B?VExoRTBTcTNoeHoyK0d6eWpweXJtYzhhWVRHRjFJWWZvWXVENjRTNWExeHlh?=
 =?utf-8?B?VkJEZmFyaGxhUGtWWUJ1M2tXYy90QVI3Y1d3SDZweUhWT0o2MHk5bWpCaW1s?=
 =?utf-8?B?bjY4M3JUeFNQWTAyTEVEMnhISEY2MkpSYnZScC9KeDU2SmVJNURKWG1WSWNN?=
 =?utf-8?B?WmFFejlqaU1la2NOVEpiMFRoR3dhOXREbnViUzloTmxJWkFhekJIZElqaUdB?=
 =?utf-8?B?R1BTdk5wVStUSDNpV3JCVkRIejVUVzdFTGEyVVV2RXo2WTJnN2VEZllCdGg2?=
 =?utf-8?B?bGNEQjl5a0c5VmxHLzNjclA0TjFCWGhEZkozWlpQeVE2TW5QMVlCT0FUUldh?=
 =?utf-8?B?dTdlTkZFcW5wdHZ3Zmx6UUcwdFBQcmlMakdwRlJWYlc0QnZvdnVTdTdpVGhq?=
 =?utf-8?B?dkl2LzUzbXNwaVhaRjUzTE1JNzBnOXVCK1lpOW1MY2l3RDUxOFlFTjNwbG5U?=
 =?utf-8?B?WGpMMFg2N2hJLzVpUlpBZGJMbnVCRG11SjJVUXNQYlk0VFpqOGtqZ3ZYZlA4?=
 =?utf-8?B?d3R5YmxJMnEzR1N4S2d1cmtSenhmbHZybmVMendIZitIa3hYd0pGQlpMUURM?=
 =?utf-8?B?clhXNjBzZWlSLzN5b3hMMWJuZWpTYkVIOUk4djlyUjZwL0YwWWJWZ201UTJB?=
 =?utf-8?B?N1A5TWZheFhBODRzL25hcmZkR3FZVi9FUXo3cXozUWplamFJUG93QU1GMGhT?=
 =?utf-8?B?amU3dXdXNFRpa2xvMEFvemhMR3Zpck8wYjRyNEFLVXhBQzFQbnZCMEMxV1Fq?=
 =?utf-8?B?VWJpY3JkNzB1cmJKeUhNYnNFMkFYdm1vekFZL0ZML2ZiRXRKdUdxcHJudHI5?=
 =?utf-8?B?NXRWSzBYUE1pOWpzZkFmaDJxc0dOVmxEVUJ1SW01R0VIUnpTSzZYd0VEd1cr?=
 =?utf-8?B?d01BU2JuQW8raDNlOEwwSkdMUXlqWnh1YzBBbGFEL2R2TExGeC9kRE9HMC9B?=
 =?utf-8?B?aXdEWk1pOElmbmJyWE0zZ2U1VDgxS3grQ3Zobkp6NWl5SlJ4OVc3bW9oV21G?=
 =?utf-8?B?Zy9za0dxWWVWbGN4dk1Jajl1TkwxdnZadnNWaFlidEFxU3NJYWQ5bHcrN3cw?=
 =?utf-8?B?UDA5ZFMvY0VlVjVMNktEZXVtV0QwWE1lNXdrT3dweEZnbm5HOUdwNGovTTR1?=
 =?utf-8?B?ZmxuTk0vTmZqS25XdkM3L2t0enZMWnZVeXlDTU5pQm5wWHdwdFloNjh1cHZT?=
 =?utf-8?Q?3jrRJvbbDrzuPkIOQLdekPmwdFbLhFar+Eno9UY?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 082433dc-f93f-495f-7606-08d8f91bea6d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 16:49:16.8666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eul+FvqF3ULRX5hRAA3ssGzrCXZxEI4CUpwsxpO6J59ylJpp4dsaAzAD2JW1iyyMZe154PFyrXin4TKJXSKl6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3688
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9946 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 adultscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104060112
X-Proofpoint-GUID: uTF2s3GOsOpDotJxcx2d4n8bPAglQLYu
X-Proofpoint-ORIG-GUID: uTF2s3GOsOpDotJxcx2d4n8bPAglQLYu
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9946 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104030000
 definitions=main-2104060113
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/21 2:56 AM, Michal Hocko wrote:
> On Mon 05-04-21 16:00:39, Mike Kravetz wrote:
>> The new remove_hugetlb_page() routine is designed to remove a hugetlb
>> page from hugetlbfs processing.  It will remove the page from the active
>> or free list, update global counters and set the compound page
>> destructor to NULL so that PageHuge() will return false for the 'page'.
>> After this call, the 'page' can be treated as a normal compound page or
>> a collection of base size pages.
>>
>> update_and_free_page no longer decrements h->nr_huge_pages{_node} as
>> this is performed in remove_hugetlb_page.  The only functionality
>> performed by update_and_free_page is to free the base pages to the lower
>> level allocators.
>>
>> update_and_free_page is typically called after remove_hugetlb_page.
>>
>> remove_hugetlb_page is to be called with the hugetlb_lock held.
>>
>> Creating this routine and separating functionality is in preparation for
>> restructuring code to reduce lock hold times.  This commit should not
>> introduce any changes to functionality.
>>
>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> 
> Btw. I would prefer to reverse the ordering of this and Oscar's
> patchset. This one is a bug fix which might be interesting for stable
> backports while Oscar's work can be looked as a general functionality
> improvement.

Ok, that makes sense.

Andrew, can we make this happen?  It would require removing Oscar's
series until it can be modified to work on top of this.
There is only one small issue with this series as it originally went
into mmotm.  There is a missing conversion of spin_lock to spin_lock_irq
in patch 7.  In addition, there are some suggested changes from Oscar to
this patch.  I do not think they are necessary, but I could make those
as well.  Let me know what I can do to help make this happen.

>> @@ -2298,6 +2312,7 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
>>  		/*
>>  		 * Freed from under us. Drop new_page too.
>>  		 */
>> +		remove_hugetlb_page(h, new_page, false);
>>  		update_and_free_page(h, new_page);
>>  		goto unlock;
>>  	} else if (page_count(old_page)) {
>> @@ -2305,6 +2320,7 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
>>  		 * Someone has grabbed the page, try to isolate it here.
>>  		 * Fail with -EBUSY if not possible.
>>  		 */
>> +		remove_hugetlb_page(h, new_page, false);
>>  		update_and_free_page(h, new_page);
>>  		spin_unlock(&hugetlb_lock);
>>  		if (!isolate_huge_page(old_page, list))
> 
> the page is not enqued anywhere here so remove_hugetlb_page would blow
> when linked list debugging is enabled.

I also thought this would be an issue.  However, INIT_LIST_HEAD would
have been called for the page so,

static inline void INIT_LIST_HEAD(struct list_head *list)
{
        WRITE_ONCE(list->next, list);
        list->prev = list;
}

The debug checks of concern in __list_del_entry_valid are:

            CHECK_DATA_CORRUPTION(prev->next != entry,
                        "list_del corruption. prev->next should be %px, but was
%px\n",
                        entry, prev->next) ||
            CHECK_DATA_CORRUPTION(next->prev != entry,
                        "list_del corruption. next->prev should be %px, but was
%px\n",
                        entry, next->prev))

Since, all pointers point back to the list(head) the check passes.  My
track record with the list routines is not so good, so I actually
forced list_del after INIT_LIST_HEAD with list debugging enabled and did
not enounter any issues.

Going forward, I agree it would be better to perhaps add a list_empty
check so that things do not blow up if the debugging code is changed.

At one time I also thought of splitting the functionality in
alloc_fresh_huge_page and prep_new_huge_page so that it would only
allocate/prep the page but not increment nr_huge_pages.  A new routine
would be used to increment the counter when it was actually put into use.
I thought this could be used when doing bulk adjustments in set_max_huge_pages
but the benefit would be minimal.  This seems like something that would
be useful in Oscar's alloc_and_dissolve_huge_page routine.
-- 
Mike Kravetz
