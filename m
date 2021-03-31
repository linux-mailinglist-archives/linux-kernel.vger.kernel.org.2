Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D44C434F6EA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 04:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbhCaCkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 22:40:53 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56056 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233537AbhCaCki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 22:40:38 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12V2d8Ds126470;
        Wed, 31 Mar 2021 02:39:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=R9Oo3ZmOOYMqNa0QNOBK5u0nzEAMG4UWbkv2dfRF5Ek=;
 b=KHmCZiCbGacpxJJWAat4CvmOf6XNR26mk/PkySfpDQv6j41x8LWflHTRzkfraHX338Hg
 sLbc0T6dg9cg2I4Lbjm+bX6/3IOINrxMFiN9mk9OsdOGm3hbgSFy75I8ttGKJKP3k7Ac
 mA8g3W7ICAetT9rytBVzWx/Ffm/35MIh5GwZRhNzhtMg+1mSK2WHtbVLWPSCibAVrKRM
 UGFV9ZCNQgePpZoq4frhrxa0YsNbQgIVzcIAwCggmHCffWlk/RjdDTS/Gf6NYVGCBB6T
 RYuC7NSVs4uyCk4xfPUakHiG2/hVC8Qs9yb7HqzaDriP+jLxPvLREABSs9HX6TWJh4Lg 0g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 37mad9rpq5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Mar 2021 02:39:53 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12V2ZVC7085078;
        Wed, 31 Mar 2021 02:39:53 GMT
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2056.outbound.protection.outlook.com [104.47.37.56])
        by userp3030.oracle.com with ESMTP id 37mabkjwwk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Mar 2021 02:39:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mkg9Rc/U18oCljfE0PILpi9KmwwkX7lAnv5/ALgnIxHlfAzHn+EmgIeWq3iVNicb57aCc9sZW0t0sw1ipQsgBZ64zxZfmmuC4FK6zdwUnlyQJCFjmD0g673lK3LtNNmWoHvVX6VAFxy+FMLOMUwxqSbcwIq/qOn4iQKZuNMzzzDVIJniA928xaMc19Fr6oHWU+m779Y5F2DSLIHdLChYfEHZ3m+HtyzrSwsONlYdLzHfDDXEQPge3mRivC3LnpNBN0t0SVNOlTaQxPNrzp/uKzfq/UFdFqaEBpQgAF8E8Uwhr4kXXMgmQQ07YYRInnFjCU/TSrVHJ3w2/6jBMCWJnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R9Oo3ZmOOYMqNa0QNOBK5u0nzEAMG4UWbkv2dfRF5Ek=;
 b=N0iYXzTXs268LnrwoWc59vXoyw5B86hDHaPjMT1oMVZEEu0oTau8TTpzflscgCRAiSlVj0NEOsgFD6wE+CIDVBPN6niGRDLZlAg7VdN4Wi11CrMYDX4teEm9U76dx9iAuttCEu9+o3pO2RYT2Tz1yLeVzgJFyX0GELGHleXOOxQWJwc/5g6yrl29L75Zuh0ba6ZJHaF8fR4eRgvA5sKfypQcmI5BrIh2rlXz7ynsGLIwT4YS+LyXWnElQHe7YfJOgBzSIStAAKZ9x8mUz+0xZbRMpjMIq5W6babDap2eHW43Ah4wK2gXhv/fUKpe3edeGRp4sgrOlyls1I2Vxv+SmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R9Oo3ZmOOYMqNa0QNOBK5u0nzEAMG4UWbkv2dfRF5Ek=;
 b=UXgtBVHHhXe1w82M0/scMP4LGe/fSLWKUt5jL5+4KyFFG6b84DJLhAsYclRdVyzqcIZ5LLqf+kBSWQCAigCmQfN1NdzUXcOO60o38gAp6kSWXfuoZRCFfsyDRDN7KsnxFoxvuig6moB2vHINt+isvOMBiNyeR1aix4XPxgvw3ME=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3351.namprd10.prod.outlook.com (2603:10b6:a03:14d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Wed, 31 Mar
 2021 02:39:51 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%8]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 02:39:51 +0000
Subject: Re: [External] [PATCH v2 5/8] hugetlb: call update_and_free_page
 without hugetlb_lock
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
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
References: <20210329232402.575396-1-mike.kravetz@oracle.com>
 <20210329232402.575396-6-mike.kravetz@oracle.com>
 <CAMZfGtUPgurtQt5u5gw-XsUWdv9bwPQdsZd=c5uNpbi80+-zDw@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <10c0f1ce-6011-b4d9-219f-1809680c4889@oracle.com>
Date:   Tue, 30 Mar 2021 19:39:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <CAMZfGtUPgurtQt5u5gw-XsUWdv9bwPQdsZd=c5uNpbi80+-zDw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR18CA0064.namprd18.prod.outlook.com
 (2603:10b6:300:39::26) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR18CA0064.namprd18.prod.outlook.com (2603:10b6:300:39::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend Transport; Wed, 31 Mar 2021 02:39:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f819ac5-298a-4b11-ce48-08d8f3ee420b
X-MS-TrafficTypeDiagnostic: BYAPR10MB3351:
X-Microsoft-Antispam-PRVS: <BYAPR10MB335167E5A4114105353891A2E27C9@BYAPR10MB3351.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xcYObYALnPENvu3QCi7L5op01SlEw/u01wRRDQiQmQ/jardVAHC54rY7iT7IJchVroAjsKeqLPp7dfr2NC2U9wnvdbGOapjAvxBJh3Uc/dBMZ88F55OYpA8j0nPv8MI7uiUsHg/cxqc3fqmL2z65eln2KPmTLjz0LOtb6GTJEh+zmFYBsQVXVenHq2R7lggv67ce2nZq9lU1rbAbS2pbok6+OKAx1LWyxqSFpc5gWLQvPFhCnVK498cC7cY5h++sg1L24tNSDGpNJqBYhwfayyBJA6dm6VBJ9Dd2Ic6fJGRkkmetHVILk6B6xqb00jZAsCLGDi6zbKqJ2PCZHUmWf7TtyUVtWd5QvbNux+marIGrGn+fU1BaJns9DOEVhdCBZun3P+XA65A8hiCH6Jx1W1Kx9lp912pyRbkWFRH7RksNSo+/ZdFEAuR1dGP1BeTwC5Ah8whDQzSHu8psFCgpgLITFbKU+huTOfmxW1nepRnZDfpKfOuH18MY/M6N6+07r+EyUimNDm7Gkvnu2W1KjqIQBcWEDi6sZxOvHKIAAR2T9xI4lrI3IlB7weLnNyOFNLGerrPHiGwK1t5GmQ7FAs41+JuSdQejvVb/rDoadTbK+dh43iqOy0cOjngf4EHC2uAVMcU10zH3+N1TDgkrNUK/3NGOAc5Aq6k4UMPfXHCmGDgcJ+bfiLWo+3u88E26zExNEFybwMOMdXb+HjK6Y4SDMSgFvwu/cltANJ6ndlE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(396003)(366004)(136003)(39860400002)(16526019)(956004)(66556008)(52116002)(4326008)(16576012)(316002)(2616005)(6916009)(186003)(66946007)(53546011)(7416002)(44832011)(31686004)(38100700001)(54906003)(66476007)(8676002)(478600001)(83380400001)(26005)(15650500001)(5660300002)(8936002)(2906002)(6486002)(36756003)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eElyd3dUb3pPQ0Q4aFRKaHlnYmFSdXdpUFdmcCtacmRQMUVBdnBBOHhuY3FS?=
 =?utf-8?B?azFiSW9TdEVHTDZuS0xOSkR2WWg0S3hMRTZnb0UvaTlEN2d5R2d4d24wdkZ2?=
 =?utf-8?B?SFVDRE9wTnYrd2s4dHJoeittK3VSRCsxMEI1TW5UR1UzcVYwM00yQThoZlBh?=
 =?utf-8?B?dTlpUlBKRnNZcEtQWkM2U0tIbXJPQlNPTHFTMW9QRkpqOVlKTUFidFFMUnNL?=
 =?utf-8?B?NVRZcW9OWFd4NGZOYTQ4S3ZOdGFtc0xTZXJYeS9FUjBoZjRadGNTVDY5VHFv?=
 =?utf-8?B?TVdhTERXb09TcFdkeVo4MzhZOERlL01hME4vUzF3VW1GZU9RM2k2cEk5dk1Z?=
 =?utf-8?B?dzUvcEcyajFmZm54NStoUk1hUGJFcklrY1NDNTdQSStoZVd1UVN3M2xxVzdi?=
 =?utf-8?B?WTN5WHdOMjFCbll0VlQxOHl6MGNUTVJFdC9DYk0vSmJ6RkJLTEhzWWZNM3VQ?=
 =?utf-8?B?Zm1YQTBNQlF1VU1RdHhUV2NOYXZvK3BNRDRHRVlHVUM2ZENERk8rT2hHRVZx?=
 =?utf-8?B?M1UrMnA3T3lNQVY1bFZ2SHkxQmpIanJ1dEEySVM2K3FCa25DajMrUUFYMTU2?=
 =?utf-8?B?TE1QRmN6VVAwWnEvSnk0Sm41TGpBb2dORWNrc2RlenFVMTdKRjVESEdTZDNa?=
 =?utf-8?B?K05iazBDQTJJc3AxRm5iOU9OdnFzRjBKcWMxd3BUVENRZWhoY25UTEhvUExI?=
 =?utf-8?B?OHNJbXUyd1BqMVVRZjltVW4wZHNON0N2WlR1MUpSNHpzYmJ0QUxlVVYwc2NR?=
 =?utf-8?B?RVN5NkhsYjFGeEQ3cFNKdmFLNE5VejdISFpnZHdpNHVZVW9aNnpKM1gxQTU3?=
 =?utf-8?B?MkFaT2kzMm1pVEd2ek1iVFA1SGZGUjNCM1M5cWs4MVgrVWNWZmowSEJsbDN0?=
 =?utf-8?B?T083YU1xTFhZdk5XcW9RYTlVSEtMMzdLdElEV3NvdDY2RjFibkpWTWZWMHdM?=
 =?utf-8?B?cEdqR3paN3ZOVUh0Y3ZGY2d1emltVEYyY3NQOGNhQ1VOWXZUVDdxS0plUTZ3?=
 =?utf-8?B?SWl3Ynd5allCUmcxRkh5TkJQemNrQTI3Zk41VXQ0enVQdFhhOHBMaVFCK2tU?=
 =?utf-8?B?L1JlUnNuZm85cDZhalM5bmRhR29BRzBjU0hXZnpxNWZya0NCcTdGR1hXek9P?=
 =?utf-8?B?WC9TR3lKbGdmdVJqamh3STdFcFozbzJRY003QjAwY1V3Ylh2bkpPVEcyM043?=
 =?utf-8?B?Q1pxNXRiVlB6YkZubEpaNTZ2QnMrWmRDcnRoRk8rbkNRUXpqeXJWZ1krQUhz?=
 =?utf-8?B?L0hjak43ai9tSGViMWgzeG9KODFYTXZjbnAxWU80Y0xBZkdNSU9oZzFTUmlJ?=
 =?utf-8?B?WmRoTVFLMDJRWHk1SXR3WkEzK0tubmp5cTBibC9FTkd2WHFTcUJpWlgxRWJ3?=
 =?utf-8?B?S0hhZW1KU0Z4cEhTRm4wcittd1lXai9JR0dKWWkyTlFqMXJXQmVBSXIxNzky?=
 =?utf-8?B?QTMwOUhoc25tWUNBR0ppSVNtajQyTUlsVHZ2Zi9SZnlKV0U3MGdoeWduUFg4?=
 =?utf-8?B?SFBEUkxBRWJZU0RUN2pGWkNwTlVZKzA4Q29KQjljeXF3Si94SE9MS0oweE9S?=
 =?utf-8?B?RXQ4SVEwMitpZ0FpdG5xaEphdDdvdXh4cG9kQXo5b2ZxV3hZSXNqaEdnb3hm?=
 =?utf-8?B?SlB1aTQ5Rm5XdmpDdlVYVmtYcTZuaG9xRXRCTGMvUHRyZ3JQeVR3YlhGU2lr?=
 =?utf-8?B?UTZadzlRWnRpR3MvekQvR0FpUlNSYzIzZGlEM3h5RUxDN2pKdW9yY3ladi9V?=
 =?utf-8?Q?+Dze/zN5CdOFSgG0ul29DGgJRpHY/J9P7AFvB70?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f819ac5-298a-4b11-ce48-08d8f3ee420b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2021 02:39:51.1110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yIbOoDyG0gE99kOpaltzGgaR0CT298PdFW7XdqDDmc0xqNypGve/6fM2bhAYWvPasF1roZbhDPv4K+nVw2uX3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3351
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103310018
X-Proofpoint-ORIG-GUID: k2nWkFRWSHoMIy3Jq6LdGmNsL_sC9UWZ
X-Proofpoint-GUID: k2nWkFRWSHoMIy3Jq6LdGmNsL_sC9UWZ
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 adultscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103310018
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/21 7:21 PM, Muchun Song wrote:
> On Tue, Mar 30, 2021 at 7:24 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>
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
>> Acked-by: Michal Hocko <mhocko@suse.com>
>> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
>> ---
>>  mm/hugetlb.c | 32 +++++++++++++++++++++++++++-----
>>  1 file changed, 27 insertions(+), 5 deletions(-)
>>
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 16beabbbbe49..dec7bd0dc63d 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -1451,16 +1451,18 @@ static void __free_huge_page(struct page *page)
>>
>>         if (HPageTemporary(page)) {
>>                 remove_hugetlb_page(h, page, false);
>> +               spin_unlock(&hugetlb_lock);
>>                 update_and_free_page(h, page);
>>         } else if (h->surplus_huge_pages_node[nid]) {
>>                 /* remove the page from active list */
>>                 remove_hugetlb_page(h, page, true);
>> +               spin_unlock(&hugetlb_lock);
>>                 update_and_free_page(h, page);
>>         } else {
>>                 arch_clear_hugepage_flags(page);
>>                 enqueue_huge_page(h, page);
>> +               spin_unlock(&hugetlb_lock);
>>         }
>> -       spin_unlock(&hugetlb_lock);
>>  }
>>
>>  /*
>> @@ -1741,7 +1743,13 @@ static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
>>                                 list_entry(h->hugepage_freelists[node].next,
>>                                           struct page, lru);
>>                         remove_hugetlb_page(h, page, acct_surplus);
>> +                       /*
>> +                        * unlock/lock around update_and_free_page is temporary
>> +                        * and will be removed with subsequent patch.
>> +                        */
>> +                       spin_unlock(&hugetlb_lock);
>>                         update_and_free_page(h, page);
>> +                       spin_lock(&hugetlb_lock);
>>                         ret = 1;
>>                         break;
>>                 }
>> @@ -1810,8 +1818,9 @@ int dissolve_free_huge_page(struct page *page)
>>                 }
>>                 remove_hugetlb_page(h, page, false);
>>                 h->max_huge_pages--;
>> +               spin_unlock(&hugetlb_lock);
>>                 update_and_free_page(h, head);
>> -               rc = 0;
>> +               return 0;
>>         }
>>  out:
>>         spin_unlock(&hugetlb_lock);
>> @@ -2674,22 +2683,35 @@ static void try_to_free_low(struct hstate *h, unsigned long count,
>>                                                 nodemask_t *nodes_allowed)
>>  {
>>         int i;
>> +       struct page *page, *next;
>> +       LIST_HEAD(page_list);
>>
>>         if (hstate_is_gigantic(h))
>>                 return;
>>
>> +       /*
>> +        * Collect pages to be freed on a list, and free after dropping lock
>> +        */
>> +       INIT_LIST_HEAD(&page_list);
> 
> INIT_LIST_HEAD is unnecessary. Because the macro of
> LIST_HEAD already initializes the list_head structure.
> 

Thanks.
I will fix here and the same issue in patch 6.
-- 
Mike Kravetz
