Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E07A535CFF8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 20:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244632AbhDLSFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 14:05:34 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49856 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240038AbhDLSFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 14:05:33 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13CI0gHl154342;
        Mon, 12 Apr 2021 18:04:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=j5QMmnsWIQq+4Im2/uHOgRrSG97Hsqs/FvX6iuOgGwc=;
 b=HBJW9sq6MF0S9INkWlgm6cJGYZH3sbeoHl/oawuboDvCpqrZaPTIIzHSSxLnGZAA9I/T
 /zv41zOjB1gwIV73rDx1z5yPpUWtq7CPJcbCZLQHS+VnDI3fZU+nro0BQjaiMAIS63WF
 1fQniRZNDn3u2hQAMdYcHenN1C3ZWCFzvfoZyQ8TF3RXkLf6yLKcKrfdxhtNLzVfQPxO
 quNiFOryos6GdDb9Cy32jweW4haGH0Ve/t7GqvfYVBcBh5i3ZgWozDu9CcbbgZkbXzET
 /KQVhk1bmNEnDXBSGomMFMKsHOZ+tC9kcvews/FrfZPvYYL6QXks0XaMhZMjeCr6Rz+F BQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 37u3ymckgm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Apr 2021 18:04:03 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13CI0KBI132909;
        Mon, 12 Apr 2021 18:04:02 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by userp3030.oracle.com with ESMTP id 37unxvqvm2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Apr 2021 18:04:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AN2dbTw4LP9Y/y7MZNGslmH0hPHr4t3QyeN7rtG8sfbXwUSewiBpcDs7G0B+nyN1pTTwlQBazsfvrheYyflFFG61a71PUdFCv0LPTHHt5ixcwGZrLbV8fanATT+6NJOGgxZLTyqpMbeAMAHyNDKaJ6wZDVNz3FY9wvKX+GKEgxbN5DAfyU19kmKoy/Z1BsIExu0+rhgiTZkLJ2inMXzMhwUebC/vpJKhTFS0GQtaljWqiD4RnsonsqlFMkLS2mXKhCTWErMZgxFZoeEloOOZbJ9/hlE4dzWvBUyzVZpBlHCk+N1aQX5lb2U+tZVZVuV2ByF2e5qYosuUehVkvwGfxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5QMmnsWIQq+4Im2/uHOgRrSG97Hsqs/FvX6iuOgGwc=;
 b=kjhHVf3rXIk9R1Gh3tXG+xE8lIASf/X2X8oHmFq0SSDkC1gq/NJYzGuIuPgd3YWUhTJlVlYUnW40xcBOXtD0c+uNO5IbfXOo7iYC3db0MloMbgdCKR2/p0CHdFfsqRDtnibA8AFAHH1hBJ11efbBFj9BpoG04Ooi8Hw/hvrgMRZNp5BA96Eb5iBen8lMXrVLKEcOCz/oUBWcBwgN9yr0eZQu1qFf3Tj0FxZVqyg/taxxk8Z4KRDKe7G9sC7KeayFFT60w3VNoUK3ne/nkK9DvJegizQgZZjPQQjkrht0hlibde+Amx8Ha/XHPIILzO9y+WCybhhmoaiz5QimTc9qZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5QMmnsWIQq+4Im2/uHOgRrSG97Hsqs/FvX6iuOgGwc=;
 b=Rq83gLW235y0Re3ZwwTOsv57DAFG6MV2opXA2usJqjFC7iGV4HuRni+gt/y36I2bDest6TTO+vkHMWAFOoIU1r6KHhYYobkNfQwW5iGeJnLS6aDGfvF0a8TchP4W7T+IcCjJl0HAdVdiZPBP0/gCca9MIawjgLcpi5Jt5mtXXjw=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4369.namprd10.prod.outlook.com (2603:10b6:a03:204::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Mon, 12 Apr
 2021 18:03:59 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%7]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 18:03:59 +0000
Subject: Re: [PATCH v5 4/8] hugetlb: create remove_hugetlb_page() to separate
 functionality
To:     Oscar Salvador <osalvador@suse.de>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
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
        Will Deacon <will@kernel.org>
References: <20210409205254.242291-1-mike.kravetz@oracle.com>
 <20210409205254.242291-5-mike.kravetz@oracle.com>
 <20210412073307.GB27818@linux>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <5f7bd4f5-785d-caf9-38d3-76ccdb9f3d49@oracle.com>
Date:   Mon, 12 Apr 2021 11:03:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210412073307.GB27818@linux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR03CA0041.namprd03.prod.outlook.com
 (2603:10b6:303:8e::16) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR03CA0041.namprd03.prod.outlook.com (2603:10b6:303:8e::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.19 via Frontend Transport; Mon, 12 Apr 2021 18:03:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f351dfa1-90e3-4f71-54e9-08d8fddd5893
X-MS-TrafficTypeDiagnostic: BY5PR10MB4369:
X-Microsoft-Antispam-PRVS: <BY5PR10MB4369C475C84BE9C634D66494E2709@BY5PR10MB4369.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2kJi7vxdh//OHXGWEp8jQXdIb7DNYuz1722PjkBTl+8UNltEewS5NQZPU/OfgJGAqSlmt0VrDhxPN0vi/Frctf1WIF8kEaFXKft36ue9TMXtsKYmCqR0O+kJ/KXZe1fMWc73Qz01ekIGl5wSsDGADDRp2Tee5wCDtpGmB5r5JXpCd6Bsml86iDn7bB6v9OZt0h2CTfuD/5scf0mo8nvrX2+0+3FODLJY19sM4msO8GSkjgiioxMZ0huUb5dg5n2I1zJsoDpy0colpRLWcrElFBla5FY3/VxdKzWH7NiyTCMNn1HmLy0panMs81L1WlWXcwDFX9nj/amimVDlkrJBnO88PW8B/OfmS1raRG9eG6ki78BT820wTbnT9CvBqFDLQiWDT0y607D0II2HA5kMvObdKUWssWl55BlmoZi+Q9JUmL4fshV8ZmizmZxUhJTbzULG8HNq8Wx7UNzikB5JazB5fIoupINmEBjA+pU+EHG207vPjvfU/cN7KKSIDncoGu2iOOpotwVhd5fY7DDuY1NQe9MbNDK5vO10foKDz0Cey/IXzy9nnuUiO5jigEZo4r6y9p3IX7Ro+H/I4yndQDP10tw8AOe8GXLDPXjDiIq/mwbk4ieVuWtfrnyMoM84XU4Qmt/UsHKAKWvwnKZStOqCzOBqylfwqtX5jRLQHsWYY+/w+opqUseFT/mSz37Z5J2RzS/2zOLx1QGgayLb2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(366004)(346002)(39860400002)(376002)(4326008)(2906002)(7416002)(86362001)(16526019)(38100700002)(38350700002)(36756003)(54906003)(6916009)(5660300002)(66946007)(31696002)(53546011)(66476007)(52116002)(6486002)(26005)(316002)(66556008)(16576012)(8936002)(8676002)(44832011)(186003)(2616005)(956004)(83380400001)(31686004)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SkllakEyOHM1SEo3WG9wNDU4WVhzc3p5aFdZWlF3QksrQ2M2MXV4eXlQV2xH?=
 =?utf-8?B?amtZNmlzbi9veDcyU1AreHBWazduL0tKRTdGTmdVZUgzWlJkZVQ5R0xvZS9s?=
 =?utf-8?B?VURtbmRDTVlGZGh1OHFsUUQyRW5yUXF4THhDTUNPTjRtYXdhVy9zWXd3TVEw?=
 =?utf-8?B?QnVsVjg1ZmpkdG9ZOVA3UTdNSU91WnhURmRMRDNHcFZXbWdraEUxdTVoWElr?=
 =?utf-8?B?L25LSm4xZlNJYm1oWWJPejQ2ZGxwS2FBbHA0TGxUc2NzT1NyT3QvYk02czVL?=
 =?utf-8?B?RUo4cUJXVHF4S1JEY05QbnNLTHFtV0Rvay9sUElrR1Rwa1F6ZzFtSWpRdi9v?=
 =?utf-8?B?WkdDdE5ZNVMwWExFOEE0Z3ZJeERoMy9uanJaR0lWK2JWMnlFcUxZVjR1UlN6?=
 =?utf-8?B?QW90enl2MTNJQ2xzUGNqQ3B6aEtvVTUvZk50ZE1LbWUraFQyS2o1RDA3dExI?=
 =?utf-8?B?NFBJOXRuY2FWcVVLMFB5QmRiTHhTRWVCZUYyRFhxUjVSRUo2ZlRrLzE2dUtu?=
 =?utf-8?B?UGJRYmRFK0FwR2o0K2djUTl0NGh2bFVEZ01VNi92c1FhcXZ3WFBXMHdWSDlN?=
 =?utf-8?B?aUpENk9MZ2hzYjZBa1ZvbDRZNG45enRuL1VMVzlBalBhWjh3NFlNMTdCZm9a?=
 =?utf-8?B?a04rYkVJSlpweENaKzNwNWRCV21JZHdIaVdFU1FMTjV5c3FFQjBwQWNBZmE4?=
 =?utf-8?B?dzNEeU9FTDZwWU5oaTF4UHVFaEQwODRHUWtHRnZNTDVrY2VNRExWNWwyb0g0?=
 =?utf-8?B?SzJhbDJhRXM0NC8zMWp2QjdxUkJoS2ZWcGRqVmk1Z0xWdjcxWGNpWU5tQXZu?=
 =?utf-8?B?aWFXeVBoODdUem82YjBIdmk4cTcyWERadk02VGtNcjIyWTRpZ0JCa2dMSnM5?=
 =?utf-8?B?d0MraElZYXNCc1FpRGx2a3dQbzN4WGZsSVdEampXejQzYjdmRGVlK1dqWkQ1?=
 =?utf-8?B?cksxK2w5NnN0aHRvVWhOc0daZ0c4Yld2NXBoemJ6eTJzb1hZNkNNS1FvaGZn?=
 =?utf-8?B?Z2FiRjlFeExoZll0ZjZFZFJGSmkxRnNQOG9MMXM2WjdoTE5GYXJ3QU5Wbm1I?=
 =?utf-8?B?S2t3UVdTL09GRFRSdVlralR1L3plR01kNERvcUJCN2NIT2ZIeHVyT1l1eXZo?=
 =?utf-8?B?cnorc2lDcDcrZ0lPbGthZm53VmJDU25uc1VIWkozZG5SYlhCajkwaGlNdXRJ?=
 =?utf-8?B?QnQvY255RCtCSThhQlF2VzFkeHg2WmFqcS9pSlNBclF2cGdITWhMOGhkbyts?=
 =?utf-8?B?d1J6RVluWWpPZzczYndnN1pwb3FsVmp2OElVeUo0SlRmZXlOb05HaGdvZmpI?=
 =?utf-8?B?aWNCMzhoZ2JUVUJrcFBNUkEvcUtKNkQxdEhkWlJPT0dIekZSaTF5MVZrck8v?=
 =?utf-8?B?eEc5UzV2eXFpNnZNSkxmVGFPQUtENjFqL0RMbFNwMU1SenJOQ0hia3k5V0pI?=
 =?utf-8?B?TUZnQzJDWkJlaWw5LzVnVjV5S29hSktQNkdYcXQ4YlZGV09QWjVLbG9LYTRu?=
 =?utf-8?B?Y0ZQbFEzR1FsdkpONnRMSlEyYWNXWjNhMG1tZVVLQmFRQ21pd3JzVXBldGpN?=
 =?utf-8?B?eUo3azJVT0R1OTJCRnlSeGpPajBLM0YyYVJvejB6KzROU1dCcThmNTJNeEZO?=
 =?utf-8?B?TDc5ekQvZmZtdHlYd3NkWGdMOXJaUHRIOUZrRHBPQkpFQlhSNlRqZVdqMUFS?=
 =?utf-8?B?YmZRVDJIVjBIdjcrMlB0bXB1bFg4bExVcE5VTVNxNlJWVTU0OWc0UjNzOXps?=
 =?utf-8?Q?wcGxwFzV9x8vrYR3D9052LNRRcZmA/eBKJiKJVl?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f351dfa1-90e3-4f71-54e9-08d8fddd5893
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2021 18:03:59.5196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 61zTG7hNHnzFcmABWKRPJ2xzD3pTWb1l/DBsGz1gVyObyBcs7gyK/KiDEOwbFXh6JWCmdkstK0SXD0R4uzL4Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4369
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9952 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 malwarescore=0
 spamscore=0 adultscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104120115
X-Proofpoint-GUID: ws8kda4Wsj8IRRbs3cKRemAe46geJqkC
X-Proofpoint-ORIG-GUID: ws8kda4Wsj8IRRbs3cKRemAe46geJqkC
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9952 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104120115
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/21 12:33 AM, Oscar Salvador wrote:
> On Fri, Apr 09, 2021 at 01:52:50PM -0700, Mike Kravetz wrote:
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
>> Acked-by: Michal Hocko <mhocko@suse.com>
>> Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
>> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> 
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> 
> A "nit" below:
> 
>>  static void update_and_free_page(struct hstate *h, struct page *page)
>>  {
>>  	int i;
>> @@ -1334,8 +1369,6 @@ static void update_and_free_page(struct hstate *h, struct page *page)
> 
> After this, update_and_free_page()'s job is to reset subpage's flags and free
> the page.
> Maybe we want to rename that function at some point, or maybe not as "update" might
> already imply that. Just speaking out loud.

Thanks Oscar,

I did not think about a name change as the routine is still "updating"
subpages before freeing.  We can certainly keep this in mind in the future,
especially if there are more functionality changes.
-- 
Mike Kravetz
