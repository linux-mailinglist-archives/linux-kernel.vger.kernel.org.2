Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39DDA337ACC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 18:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbhCKR04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 12:26:56 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:38334 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbhCKR00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 12:26:26 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12BH9MvB165844;
        Thu, 11 Mar 2021 17:25:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=J7cibUhFAw3Nr01AuK+6oV3luLnFuzGGgZE6ZnPx1oY=;
 b=k15HZMDCYTtN6rykdI2sKCANqkdNtvEAcDhGzmuiQjji1TZA/r1h8m7oZWXjV+L7nBU8
 QIWIg/xcOi9zikNTl4SyuO39PPnFhb57Ok2IFPTIYuj3BYirtMtKj4QZxlKll7x2GR1B
 /LJIeWC+M0CFBq5c7hqLBzTojpVc1Psx4BMKuV9IJGdiDhcNeJkIpRKI933W+U+7bTBy
 3nZ3VsCZcC3rPzGWy64tgUZvXR2iwtEIHL4f8vNVfk//U5H8EC4p2N2dJJDng7wUg18h
 UGOo1QZOoLoybfWw9EnWVIlqkf0fniDRDPI65+sYwyiAB/VHrL9W/sDEXIZCyMKysY97 KA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 3742cnfbx2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Mar 2021 17:25:56 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12BHBdpZ101429;
        Thu, 11 Mar 2021 17:25:55 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by aserp3020.oracle.com with ESMTP id 374kn2ujm5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Mar 2021 17:25:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IT3r/Smhr0RMUXq9yl5KuX1Zboz3TRfdLiGsxZfxBoRY9i/9lyfBSBeMYtWFOXACKpDR4iTxi5kAu5Tylvl+WVOB41jlhY0XOoHR0IwCbt7TynJqlHjxyHg9pGO9cwTXaCQJJuz4o4J7rRGZiZAhtQpmlfe7/ILSPxgvUwTypa6v5QJDPZI+hnzpoCT3E+WTEaXQO7V5vgsE/htl39VplYI5LUYp3Aen0gSIqqKA1YTnJ2UDTv3q0aAf0Uiw3hiNbCO4qea+cIGuPwVjPkilz3Hm7Dq5PlM0LaF7yZK+Sv0vvHazuHhAeKUXrzixymIen+RUYUqMKaWuOl7LJFkuSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7cibUhFAw3Nr01AuK+6oV3luLnFuzGGgZE6ZnPx1oY=;
 b=i7faZU6rGI4ya32ke5MRzAveTZGBdaHRf+/jNNRcZ9Sn8FVqu5XbEd89bXCjEewIljCpQeZDdDVmCY9ltP2DbDrl0ELYrIXV3dbEUnz3U27uGIEVAk2sfRlNhHlZRuhfOJWi83zQO8y/Gma22qEceExOXMaWWGfexU3J0LYgAJdSmOEM4LNTUZK0tW8CPEvztIgSCQppQDF0U8+eHA14ZevQvyJYpEVYyatTvDkhbUBVvVsoDYpyRcZuh1hh0QkWWJ0zjyyRA8A53HYZbV0s3sxTkwZ7Y4lfClvggDN1QbyX/jUJLLG4GkLYKwMncBsTXZQNb52XsLgQL+ckHa7cEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7cibUhFAw3Nr01AuK+6oV3luLnFuzGGgZE6ZnPx1oY=;
 b=Jq4kGukmXxdJuD9tXPA7poW9u/hoIA8kZ7ay7MLuXU1bl0a8w+0VUsKp0Xfc7r9vWxNPRhRB20hXE/DET6EjBC7ae2zSZh4HRYkaQGI+rV+iRwIQiPnT/Z0IuyZ7G25mywc4gRaF0BOquiQP9pu/ZRrvti4d93fNlEG7BuJUhTY=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2997.namprd10.prod.outlook.com (2603:10b6:a03:90::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.28; Thu, 11 Mar
 2021 17:25:52 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%8]) with mapi id 15.20.3933.031; Thu, 11 Mar 2021
 17:25:52 +0000
Subject: Re: [PATCH] hugetlb: select PREEMPT_COUNT if HUGETLB_PAGE for
 in_atomic use
To:     Michal Hocko <mhocko@suse.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, tglx@linutronix.de,
        john.ogness@linutronix.de, urezki@gmail.com, ast@fb.com,
        Eric Dumazet <edumazet@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210311021321.127500-1-mike.kravetz@oracle.com>
 <YEnY5hWLT/en7kw1@hirez.programming.kicks-ass.net>
 <YEncYrWCVn2/20/C@dhcp22.suse.cz>
 <YEnjqLpGU2LHaysv@hirez.programming.kicks-ass.net>
 <YEnmmK42kpeB3Ho4@dhcp22.suse.cz>
 <YEnochPwIyAsiEWS@hirez.programming.kicks-ass.net>
 <YEn6W0RcjNiP0N0P@dhcp22.suse.cz>
 <YEoA08n60+jzsnAl@hirez.programming.kicks-ass.net>
 <YEoGyQJucV6FV3zY@dhcp22.suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <90abce15-9ece-d290-98ec-771addef9748@oracle.com>
Date:   Thu, 11 Mar 2021 09:25:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <YEoGyQJucV6FV3zY@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR1701CA0010.namprd17.prod.outlook.com
 (2603:10b6:301:14::20) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR1701CA0010.namprd17.prod.outlook.com (2603:10b6:301:14::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Thu, 11 Mar 2021 17:25:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9ba591a-165d-4175-8062-08d8e4b2b8a7
X-MS-TrafficTypeDiagnostic: BYAPR10MB2997:
X-Microsoft-Antispam-PRVS: <BYAPR10MB29979C5D344CF5043A397682E2909@BYAPR10MB2997.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fPMMV8rlGvQfZ2pk/z3aK0Yx+mOjEZAWMyzXlL0Pu9qm4Rdr5mNoBf4imKs81yESqubdBDKdEnz/NochTYlWOfROzADLnswr5tAPJS8FydXV+4PQm0VQv8NFKTfNZC2212RCEK2X1kFLUBBOB35JskSTGGnBpKBigVFFQ667naCqQizQ4Mg/QEATUCsRFYixbLlAnVtjSNDDq4v1+cgSH4DnRBSIdjukH3ydJ28ZwKEo6WOGvfn0VU3vAbRhA2PP0QHQcf5Zdl+9CLxGNHL/IEHg7cJcjwYzhOYE68Rp0LzXaGsC8f1gDs8TVzoqkDe/I6arvO1s9PbtVf6VhQQNGD2RFZ+70q3rgPDtNPtxCB7G47SJzXVwexUCCGyFGoxFPa0uCxrevdpzcRC5OUbrn2y/Z4925XpmZKv5fI7x0Jdio6DCPTDXflzApbnFrBr0uVf707czjCjOxGIL+BCGostM8E0m+seCMbRuV1BZcVQEjdFortfDF1+gVYWev5ndYXqXHtf4j56zWOrWUTTGCEcfLvQpbuMDTI9mRt3JZrk525eWqrnHdePhZbYoqH4nADKyqDHIG03HH/8PzrilLGSq6L1NSkuLTD/qzBBKrZ/XXmQDzkaYXj/47P8yew+RyDjJLmrOUmoEuFZz3CVnoI52cslHz1tNdKLnD3y+lX/BmnLxkP+ryZ08g25/bDCO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(376002)(136003)(39860400002)(396003)(6666004)(26005)(16576012)(4326008)(186003)(86362001)(2906002)(8936002)(7416002)(2616005)(956004)(478600001)(16526019)(54906003)(36756003)(110136005)(966005)(316002)(66476007)(66556008)(31696002)(8676002)(66946007)(52116002)(44832011)(31686004)(53546011)(6486002)(83380400001)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SGYybEd5OEtIbVRLeFBVTWNIaVJqUU52R0lrRU9aN2NXTU1uSVYxS1h4Rmwr?=
 =?utf-8?B?M3FWUEJ0RnRXeTcwbXdUUkk5dGcrcUcrY3htTTlPOVJrU0JKNWxzN2g3UVhT?=
 =?utf-8?B?YXpvOVlNSGxoQnlEcHFKNTdRMHNabVk4MGhYaU9wakxDd0VFZlVQQ0NBQTZw?=
 =?utf-8?B?bTRJeGRJRk9aRThNUjhFWXo2ell0M1p0MTRMS1I0KzVKSkFKSnowSGRuVHF2?=
 =?utf-8?B?MUFKNTNJeTJnUDVRQmc1VHdRa3VvWTRTT3hvckMzVGREb3lRbkVvY09OKzZu?=
 =?utf-8?B?Z1ZVa3JQbW4rc2FmSlhuNUIxMmI5Um9ab0pQYjdaUWJoLzhiT0w4QlZlQjdB?=
 =?utf-8?B?UTRaT2k0bDdCQTNRSmk3N1NaNm8rVlkzVWh0RVpNYzhJajZnOXJtZFo5ZEJx?=
 =?utf-8?B?UDFJdmFpSlhEemhIeThQbDNoZWF6QkloL2lCMFg2RFRFVXNHR0V6NVdlQVV4?=
 =?utf-8?B?c3ljS09uMmF2VXV3YWZkaUtESlArMWk5Z2t0UzBsMGVGcmIvUzJEbDBmSVdj?=
 =?utf-8?B?ZHdOZ1hsTmVzWXh3M2thaE82TFFHWHp6elFERlk3OE5HN1YrWm1oVkJkRHlJ?=
 =?utf-8?B?R2krSzNRQ1czVkowRnhYbVd6bDNlTFcvTE05Q25CcVF0a1JXcU13NUpoRzFn?=
 =?utf-8?B?alVobzhrZ0xRT3VOeFJPVDlDYjVDZ0lRclhHVjc3TXE4a0I5UHRWbzQ1WGRv?=
 =?utf-8?B?ZytmNDNTQW5pbDlZVi9JK05SKzU1Z1BtVzQ5ZzdRS0NrY1k2S3ZVZEJRM3k2?=
 =?utf-8?B?aFFKTUZ0SmlaZGdkNDkzdHMwNUt0cVg3T3VxZFZIellUSHBGdmZCSkhIWWdx?=
 =?utf-8?B?NTlzQStsdi9IbitFYmVrZnlBazBnN3hRb0prcWlqOE91ZFI1YWtSY0FTeWJI?=
 =?utf-8?B?OEwrQmRFeFdWWFpkamg4dkplY2o3QUhhdG1IbTN6R1JmWUMvY3g3Z0t0RTBq?=
 =?utf-8?B?RERaU3hNbW10Y2VCSldwNjJKTFhPMzlzTVFsWi9UckJnbHByRHhKOVprejM1?=
 =?utf-8?B?aU96eGc3cjMvSHVtVThCMCs3OXk4OUtwV2wycVpHYW5SOUpaQjZGdEFpdDBK?=
 =?utf-8?B?aE43bFByZnNwZ2JQa2YwaklKcGxmTWRDTVlLd1laMzhZNzFUL2FoZWNVUyti?=
 =?utf-8?B?NlVxd1FibjdUZ2ZQS1pHelVzRHBLM1V2cE9YYkJDSCs5dnBQblozS3kvQ1l1?=
 =?utf-8?B?REZvd2RIM0c5RE00Q2ozTDJiT1F3bmdtL1N6UFpSd3kvaXdqQ2RBbW51bnlK?=
 =?utf-8?B?QzJmV0c4ODR3Mms2bnF1Y2VhVG1oRFpNdm5EUVAwV09MeUxTVW9YcEg3enBQ?=
 =?utf-8?B?Y09IZld1Um1PY1EzcUdQTnhENmpiM0dwMWRoUU1WTTc2b2UvOEw2THQ5Zyts?=
 =?utf-8?B?Qnd3d1ZQaGF2L3UxaUhvREkwMllRSk1najczNVUyaFIvT1RtaTR6TWxWTUN3?=
 =?utf-8?B?QnRUY1FXSU0zU2htWXF4WUZ4K2lyWHV0R3NoWjNrQlMxa0x2Z2hWcVVZMm1H?=
 =?utf-8?B?MlB2VDRrcUF2VXFUQlhWQm5qSjVZcGhVNFBMNy91VlFVV2s5S2ZmME9CS3kw?=
 =?utf-8?B?VDU0VFVIZFVaeDcrbFVzMk14NzVlNE9abmJvUm81aGM1d3VQdkErckNVOWJy?=
 =?utf-8?B?OWlTT2MvTk9RdEhxMkJWTzlIVVFGYndUck1TVGROSmhxdlJ3b3ZFbkFxeFVm?=
 =?utf-8?B?MzlTWklya0V6U243djhDdVQrWFIyZGMzNU9scmVXN0E3WGdzeEpaMFhoRkhS?=
 =?utf-8?Q?EXEy8cz0CUZSapgMYuMSt5lTn/DLi+Ww+ST7n4b?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9ba591a-165d-4175-8062-08d8e4b2b8a7
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2021 17:25:52.7894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vq6JzN8+pFR61B+LgXn/0g0INzG+R3YYZvLVVc+Ga21rUw9gLvhLbE9w2DF5+0kpk5S7lP7CdnZBtmf73cv1sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2997
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9920 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103110089
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9920 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 clxscore=1015 phishscore=0 adultscore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 mlxscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103110089
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/21 4:02 AM, Michal Hocko wrote:
> On Thu 11-03-21 12:36:51, Peter Zijlstra wrote:
>> On Thu, Mar 11, 2021 at 12:09:15PM +0100, Michal Hocko wrote:
>>
>>> Sorry for being dense but I do not follow. You have provided the
>>> following example
>>>   spin_lock(&A);
>>>   <IRQ>
>>>         spin_lock(&A);
>>>
>>> if A == hugetlb_lock then we should never reenter with
>>> free_huge_page
>>
>> What I'm saying is that if irq_disabled(), the that interrupt cannot
>> happen, so the second spin_lock cannot happen, so the deadlock cannot
>> happen.
>>
>> So: '!irqs_disabled() && in_atomic()' is sufficient to avoid the IRQ
>> recursion deadlock.
> 
> OK, then I understand your point now. I thought you were arguing
> an actual deadlock scenario. As I've said irq_disabled check would be
> needed for sleeping operations that we already do.
> 
>> Also, Linus hates constructs like this:
>>
>>   https://lkml.kernel.org/r/CAHk-=wht7kAeyR5xEW2ORj7m0hibVxZ3t+2ie8vNHLQfdbN2_g@mail.gmail.com
>>
>>> From the code simplicity POV (and hugetlb has grown a lot of complexity)
>>> it would be really easiest to make sure __free_huge_page to be called
>>> from a non-atomic process context. There are few ways to do that
>>> - defer each call to a WQ - user visible which sucks
>>> - defer from atomic or otherwise non-sleeping contextx - requires
>>>   reliable in_atomic AFAICS
>>> - defer sleeping operations - makes the code flow more complex and it
>>>   would be again user visible in some cases.
>>>
>>> So I would say we are in "pick your own poison" kind of situation.
>>
>> Just to be clear:
>>
>> NAK on this patch and any and all ductape crap. Fix it properly, make
>> hugetlb_lock, spool->lock IRQ-safe, move the workqueue into the CMA
>> thing.
>>
>> The code really doesn't look _that_ complicated.
> 
> Fair enough. As I've said I am not a great fan of this patch either
> but it is a quick fix for a likely long term problem. If reworking the
> hugetlb locking is preferable then be it.

Thanks you Michal and Peter.  This patch was mostly about starting a
discussion, as this topic came up in a couple different places.  I
included the 'train wreck' of how we got here just for a bit of history.

I'll start working on a proper fix.
-- 
Mike Kravetz
