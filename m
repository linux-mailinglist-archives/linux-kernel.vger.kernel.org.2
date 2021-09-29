Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6726941CFDA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 01:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347533AbhI2XX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 19:23:27 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:22982 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245755AbhI2XX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 19:23:26 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18TM93Qn031091;
        Wed, 29 Sep 2021 23:21:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=XYuVWPB9X/IPs6UCboHGNu/NI0MuuSthNBENRDdOIZ8=;
 b=RnUX4FnMC18jzQQYu4H/LDiRECukglXaqQmTx0sUAmGLLc883YiAQUIxN4xG89DK5ayd
 +P81rpwvPkGlztQqknC9Xr0RgQYB6vMwEmLh3TRvHAQB2vXk9pkNc+BrSttz5+ejrIYJ
 94V1cqP7dW1t/Gn+8O6cANE93/mEkjaZizSNJwjw/JMwZk7tLvBmvuHKAim9JoRwdITA
 +l5YtbrsoUN/5S05ioh9S8wkCnCmRkHHytmely3FoOrgFSepoawkLrxzZ3+yefjrDBSq
 qSqcasBru+01xsg390Ez/KrakHo5x7XBPS5BqoRKY+uG4r6GUfqGWeqIzJMm4VXUMg4Y 7Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bcdcw2s06-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Sep 2021 23:21:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18TNAUQv178495;
        Wed, 29 Sep 2021 23:21:29 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2048.outbound.protection.outlook.com [104.47.74.48])
        by userp3030.oracle.com with ESMTP id 3bc3bkqggg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Sep 2021 23:21:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MGVqzQbThJh4HGkMakHS7PNrxsWzrWDXxNwdKEiwcjTAJf7igeVFbrI/hbvwvg/9GZq5+iC9EfRWdDAq1Cl1eCUykQyBEF18l/qLx7lrxX5LLs9wJRtfkGqKyWM0zYT1LmMSydyeNxXyqkGHnZCWZsD4Jfr079tzbHhuJLxk1h5PI3gTDsQ8pAwJiP/+POKD2oYWcusxNZJT60k8ONO5B7Qw0aWIZsaz2WpuBx11JGIZOug9zuil7/gwoZcy2HcwtsqRYIO5HHgJaWimhj/2Pyot8moMvW4S5xAfrNOfWr7g8z902fdeV1HkYRsqezdDBQLP3c96SEFaaXmX41bDBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=XYuVWPB9X/IPs6UCboHGNu/NI0MuuSthNBENRDdOIZ8=;
 b=WVYKJ0GRJNyc3xt7eIJprYm3EzYjAiEQO80hlzuAXmtQy6etaddiG2kaeAi4SYdUnP3Eitc6ON6EpvR6FYE1F2+OPD9Z07i4f9WHUHVnM30/Bs8wOdseKIFVQQI1aAQIDDZ/7IEd406dzSk/41+AssBTp7wGK4wgWs9wcl6nAiT1QTMY06P5dR0zldZV59FQ8QcLLieaJ4oM2r3pXBAd+e/aoBjFRi9LpXRGORdkbmCSD6MFeeoD70J8evYOUJ7tSfD33pLVaa6iHgx0uK7n3V0QQwx8C2nIHxpFuZgorPOpweESuAtQ9iLo/haVcfIk+xACgEPC44crK/3SExj5rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XYuVWPB9X/IPs6UCboHGNu/NI0MuuSthNBENRDdOIZ8=;
 b=vQ7gRb6pS14HzZETi2d8TBxzNjdy8rn7r62t7/ux50JBXphfC21lsRMsx50X3S9+b5ALL50nVPX7c3aracQPtBufCMrVefVQb0h44L9KQdQ1MwjEwpAF6hxe4RH9r4wVJWrpgmKWQG3Ks303xtmIwpaHjFHs7uYdZJi/F5RL2XQ=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4463.namprd10.prod.outlook.com (2603:10b6:a03:2af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.13; Wed, 29 Sep
 2021 23:21:27 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::a4a2:56de:e8db:9f2b]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::a4a2:56de:e8db:9f2b%9]) with mapi id 15.20.4544.022; Wed, 29 Sep 2021
 23:21:27 +0000
Subject: Re: [PATCH v2 2/4] hugetlb: add HPageCma flag and code to free
 non-gigantic pages in CMA
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@suse.com>, Oscar Salvador <osalvador@suse.de>,
        Zi Yan <ziy@nvidia.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Rientjes <rientjes@google.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210923175347.10727-1-mike.kravetz@oracle.com>
 <20210923175347.10727-3-mike.kravetz@oracle.com>
 <7ab7690d-aa21-0fd9-75f1-f3a23b892853@redhat.com>
 <30db728b-36a6-aca4-75e1-c583202d1cb6@oracle.com>
Message-ID: <24dc6cfd-8b2e-4ed6-d64a-9bf9372b1b4c@oracle.com>
Date:   Wed, 29 Sep 2021 16:21:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <30db728b-36a6-aca4-75e1-c583202d1cb6@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR1201CA0023.namprd12.prod.outlook.com
 (2603:10b6:301:4a::33) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from [192.168.2.123] (50.38.35.18) by MWHPR1201CA0023.namprd12.prod.outlook.com (2603:10b6:301:4a::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend Transport; Wed, 29 Sep 2021 23:21:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34a63df2-c7a0-431c-f45f-08d9839fdc6b
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4463:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4463934E224A76D1679BA5BBE2A99@SJ0PR10MB4463.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +aPhAo42emP10apbalYv5pkQ3IMoi8rvbVh+PSxuTo4TW5YEgJMdlTuQ6oSn49DHIUzHJowCTYZI9By4wcbARMyr3fg9MF1fvvofcWj+0xHmdlLDjYtCfxXnCg0xKC1ApO48Pmszg2IFuCMhXyZmTClT6N86NgrJA+5yb5iou0aDcaYlEQqdxn8qIFsn3ay/ZSepKYSHHlPoUi35OYBpywc2tooDdgUnnbPQ0mbOQ/x/jj6rbCOhQiWB91Y3PZa+Ccv/EHLtIVEOy+7MJvYy2ET3rKXvOZbIIjBI47sinqCIh7FbCyhMaCGjV9rZTV9UJohIh1myGDtxJWw4Gu6MU4/uZ3xNw99u02UhpDZlyYecB5JT6ZO4ORT9dY9rXVonOU+aJkglL5GWKqGdxd7j3f45ee/ZbvmkYlnuN7ehJCQyZql56Q/SmQDBRoNN177mv2uNOc6Y4Y/Pgaq3nc5H8uWAc30YSF9LAYgwfR7g9DTd1Tt4N3jxdZj0L54at5h6mwhgBpNMizpyNtRzfWjn10DcBOdpuWOAOwTwU02exgi/q149aaMwK5epkwE2PLSSDD0S0VuHQYmitRnI0PVrKw5yAfjpGC/Gt2tyUSPQK7cAw8CznznuHnLAgkC1fxoUM6tXeyeCuvO8Ff49Tj22CRxEy9pZlejXGvGXyewuBwktcGWR/zUeSG0ciHS4SMEn906FYjXq8SugvcxfFrqcWt/JZAq4qf102325cKTvzZgPuSH0yVYBP2HFkcvYjYoMjwMuItWKJWFMZ8gmibswow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(508600001)(2906002)(8936002)(5660300002)(31696002)(83380400001)(38350700002)(38100700002)(66946007)(66556008)(66476007)(52116002)(54906003)(16576012)(8676002)(956004)(186003)(6486002)(4326008)(2616005)(31686004)(36756003)(44832011)(7416002)(86362001)(26005)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTIyRTVCT2M5RHBZdTdYQ2V3NnJzcnhFWUNJclNKT2M5bS9xUFgyYis0VHRw?=
 =?utf-8?B?aEZjNWtlK0VsSHBDaDBieDZ2ZW9hd3VXaFY0VldCTHdiN2ZZdU4yYkg5bFNW?=
 =?utf-8?B?cmE3WVFJMUVvb2pqQ2owWE1IUDdKS2JacHYydHBpb1M3R3pqYjhWaVlYUTBW?=
 =?utf-8?B?WllJbGE3S3NHdURpVXV5cUI5OFVaWnE1TVJkQk5KWGZQMzgwZzhVMCtQSzM4?=
 =?utf-8?B?U0ZxR2tkbjdlNXBRQTlHK0xrcm0wNmFFUkYwN3RTeUczdVBXeXlJcG4zOU5y?=
 =?utf-8?B?bzIvRGtDZ0J2NnFBVGtzcjY0TlRQUDhTZXg1NjVoc0ZnTkpEU056Z1hOMGph?=
 =?utf-8?B?bGVGQTJLejZKR1oweVJTZitDNitrU1ExSWx3UC9PMGZCeHhUYWJ0RDBXRnBD?=
 =?utf-8?B?OG12YWpqZXFMV3hDdmtmL1FuYkZsSVZhVFAza1pYbFd3K2NyVndiajl3Unpk?=
 =?utf-8?B?aUI3NXdTL2NiVlFPNVFoNW9QQ212RDJ0V0k2QmJRSVBzMW03cUpzZldFNmxS?=
 =?utf-8?B?RXJBRnNadUJLa1Q2dWRuUlJSSWlVNEQ3U0FWSFFqcDVTL3FzUFBoVHdINmVt?=
 =?utf-8?B?SXEzRGszSXovcVBiZVJTWElvYXRIUnRMKzdDL1V2T0QySXJ2M1g2aUhTbmky?=
 =?utf-8?B?UWpISk92QXNsRHYwMWdnUEFsWVlOdnJGd3p4ZDY5OW5qWTIrSndoOXRZdXZl?=
 =?utf-8?B?dGFUWXhwUjdXNG02UmtWRW1rNG5WT2ltZlUxMUZTOU9mb3hjV28vSmY5SUc5?=
 =?utf-8?B?OW9TWHRZQzFEU2VwcTFzQ2I1VllsSHhaeEszOHo3dXFoekVuMnh2dmVCcUh3?=
 =?utf-8?B?UDNDenppN2JjUTNkZUlOWGhFRzI3dVY0S0xkVzlFUDhNdG0vSjJkVWZmUHBR?=
 =?utf-8?B?UVF4NUt3dHRtRUptbUpXdEcvdEt5aHZuWHZscFJzOGVYcFM2bHVmWGpzd0xv?=
 =?utf-8?B?UUNRdGNFdHVxa2dTczdqOFRmdFVMSHhuUWp5cDgxVWdpSW42U09EdjF0UTVO?=
 =?utf-8?B?blU3dFEvWWYxVnhuUWs0RFd0VFBHUkRJQ2I0eGdQa1ZkVnpwOGRoSHlRU0NY?=
 =?utf-8?B?blVNdHdqT3JLa1BHdi9FZzQ1Wk5sOHRkZHhNakxPcEREUmFocURmNWZtaC80?=
 =?utf-8?B?OUZEcWtQSFJ4aU1qc0VKR3Y2WWJSTHdBcHVvdXVEaHcxWWx5ejJMTURFYWJo?=
 =?utf-8?B?ZngyMDVNU1hGMnFvYUtBdXM0aGc3MEIzbVJsUEg3RWlPY0lSaVFZQTZ1M1NU?=
 =?utf-8?B?Zm9aQlYyT2V0M3luYU56TmdoSmJtSzE4NGFLVmEyUW5nUVNCMURwTnJWYTBY?=
 =?utf-8?B?VzJYUHN2ZkxnTzBzb2p2Q3BIYlFPM01MOUpoWWZVRXNlcHZBR3pxNG5zQjNq?=
 =?utf-8?B?c2hXOEhCODlFS0JPY3BETUR0VGNjRnpKRWExVzZncnNkVkRQNnFGWkNOM3JZ?=
 =?utf-8?B?OHBwd3h1K2FaTmxMTkEzVWRBK3ozWStIUnF1bkR2NVRvZzVSUTlBNGdUUVIz?=
 =?utf-8?B?QzNsUTczUlRxdXAxTjB5VjF0N1VLK0w0ZlBaVXZ0SUF4SGc1NTZZMzkrbmEr?=
 =?utf-8?B?M0V5bDhRNkFUZ1hmRmRacXlVaGk4NWh3VVo2bkZNalRIVE16M3JjdnRFbTEw?=
 =?utf-8?B?eFAwZ0ZWenErQURwVzVaWWp1Z1VBa25jdks2Nzd6WENreXgwWE4rQ0w5ZFRn?=
 =?utf-8?B?YVo1R0ZjOWNLSmhvMi9JMkxlY3Jxb1hxTWROODdBTXFyR1VKTHFCdTViaHRa?=
 =?utf-8?Q?TL7jutiMnn1HQ9zZiEsbnVElR3UcKHfUp40chnw?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34a63df2-c7a0-431c-f45f-08d9839fdc6b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2021 23:21:27.3066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jIXCyeycZoktjJUtCc1S50KFhIzO+o89hJ0pf1z8VUuEsDZk8T9sQRkuZFMCCOLn23E1XN1qbVMKlj5xc/bJ5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4463
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10122 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109290136
X-Proofpoint-GUID: Vr5tsx7isrekxFhXFje3_OWsQ5kucwcE
X-Proofpoint-ORIG-GUID: Vr5tsx7isrekxFhXFje3_OWsQ5kucwcE
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/29/21 12:42 PM, Mike Kravetz wrote:
> On 9/24/21 2:36 AM, David Hildenbrand wrote:
>> On 23.09.21 19:53, Mike Kravetz wrote:
>>> When huge page demotion is fully implemented, gigantic pages can be
>>> demoted to a smaller huge page size.  For example, on x86 a 1G page
>>> can be demoted to 512 2M pages.  However, gigantic pages can potentially
>>> be allocated from CMA.  If a gigantic page which was allocated from CMA
>>> is demoted, the corresponding demoted pages needs to be returned to CMA.
>>>
>>> In order to track hugetlb pages that need to be returned to CMA, add the
>>> hugetlb specific flag HPageCma.  Flag is set when a huge page is
>>> allocated from CMA and transferred to any demoted pages.  Non-gigantic
>>> huge page freeing code checks for the flag and takes appropriate action.
>>
>> Do we really need that flag or couldn't we simply always try cma_release() and fallback to out ordinary freeing-path?
>>
>> IIRC, cma knows exactly if something was allocated via a CMA are and can be free via it. No need for additional tracking usually.
>>
> 
> Yes, I think this is possible.
> Initially, I thought the check for whether pages were part of CMA
> involved a mutex or some type of locking.  But, it really is
> lightweight.  So, should not be in issue calling in every case.

When modifying the code, I did come across one issue.  Sorry I did not
immediately remember this.

Gigantic pages are allocated as a 'set of pages' and turned into a compound
page by the hugetlb code.  They must be restored to a 'set of pages' before
calling cma_release.  You can not pass a compound page to cma_release.
Non-gigantic page are allocated from the buddy directly as compound pages.
They are returned to buddy as a compound page.

So, the issue comes about when freeing a non-gigantic page.  We would
need to convert to a 'set of pages' before calling cma_release just to
see if cma_release succeeds.  Then, if it fails convert back to a
compound page to call __free_pages.  Conversion is somewhat expensive as
we must modify every tail page struct.

Some possible solutions:
- Create a cma_pages_valid() routine that checks whether the pages
  belong to a cma region.  Only convert to 'set of pages' if cma_pages_valid
  and we know subsequent cma_release will succeed.
- Always convert non-gigantic pages to a 'set of pages' before freeing.
  Alternatively, don't allocate compound pages from buddy and just use
  the hugetlb gigantic page prep and destroy routines for all hugetlb
  page sizes.
- Use some kind of flag as in proposed patch.

Having hugetlb just allocate a set of pages from buddy is interesting.
This would make the allocate/free code paths for gigantic and
non-gigantic pages align more closely.  It may in overall code simplification,
not just for demote.
-- 
Mike Kravetz
