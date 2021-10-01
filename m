Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F10741F39C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 19:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355462AbhJARwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 13:52:19 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:13174 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231852AbhJARwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 13:52:17 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 191HnuaP016047;
        Fri, 1 Oct 2021 17:50:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=rkRuXbma0owJbU82l4eaodmlvst1R2dOpz5LbifXdsU=;
 b=BZ6+GBNG6yMRclPgu6aFl6sN6gdoCzveMy7xv1FUezjIrS/Nr7X/R34AT+fHfK8BAnal
 ziMqybjPFHvtQ5QMOyhwWJVnhhPA3a1WIK89xOxOhZxrUP35GZLOS++fy9SOPRwH45wO
 jprJg922AeTfsstSalHXoE3IuxvF+AIFRVllmPXXuY3plot5wLIP0mV7jP/AIZSh9uUn
 iOr+cEpMZb1PzhSlU2uvxy2be2aFE4GNl/jvLDPeTM7bwZGYtQtBLdaPkCaMHkpl5Ls+
 /Y/8/kJAPYWIbZgx+yiGGIJcx1TW6XQbN6tYtudB/6i6P1yg76Z1z3Xv4+c86SzR9gtf Ag== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3be440hc2y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Oct 2021 17:50:12 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 191HkNpo109078;
        Fri, 1 Oct 2021 17:50:07 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by userp3020.oracle.com with ESMTP id 3bc3chukb3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Oct 2021 17:50:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X93OHtLLaw7IaLYfHQ0an3FUCvrYpgSK9/HIvob+kQXvUjlnKsVy6bvkUJtkAsvOnPd3zkFiMRdzCOWh9e7i4d1irZ+a11eI/i9765t9r9qzzez4qcpN48xPwnVVD5PGzDymcIFUEcnv+JTwjTHQhj4YUMZkViLGzvTsv9Ja/RV2aoUlxCKKe3w39IQfa+yxRvKXXbQv6c3l29lgtVh4fWeVVQz9wq5FiM+Y5WO03G7iij7RJIgLGquF5jCFHtysc4hGajXEYR2NobblyM1efyjYuM0FPF9prVoBvT62litHluIxoNfbOna1q84RhP7xVV0EVcsRIK6kDid7GkKQ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rkRuXbma0owJbU82l4eaodmlvst1R2dOpz5LbifXdsU=;
 b=Bk1EUTlILVnUKhZ/xpnIwxzFzalGxGVQAsRn+No4okzd3fAIARlIcZ02rK7ZevdbbZ6wyzpw0nbicLT4f8Y2Pb/GLnTJpjt/rqOuB6ZOst8hnTHErvl60zH9dcTQQ67+Pu0moYkGwjWVC9JVAmMDLKli9N4GMazgJOIo3GrO5Cj1FJ7/+V/NV19NDLgMJTxVZu1amthLWIRsfgG3ZcZA5L/fz1OK+ZdmwkUAfZ9jShwe3R3MYfnrjU0BvRpgyA5p4O2uAWzC2njWFMm6mbTqsFbn5tO+3hEOYIvAIPVSS+tLHrKFSK+vFRHg3wVQp6hy5XliHNLzza6E6J4FZjw0eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkRuXbma0owJbU82l4eaodmlvst1R2dOpz5LbifXdsU=;
 b=jv2puP1s1PnbO8ESSSoCetyO+EqSPLH5n8Ci1NzhW7wJVUGlpF9O6i9Eccvu6O4bi28IJyRPebKmeFc1S5A3JfGgzoO+NU2aq5F50QzjOJ7nn0hpEBYOg6mPz86k3LlsIjtnNvYf6/N/rNKPquYrjPvt3l9fFd8SHaMJ7liM6rs=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from CH2PR10MB4200.namprd10.prod.outlook.com (2603:10b6:610:a5::9)
 by CH0PR10MB5177.namprd10.prod.outlook.com (2603:10b6:610:df::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Fri, 1 Oct
 2021 17:50:05 +0000
Received: from CH2PR10MB4200.namprd10.prod.outlook.com
 ([fe80::9516:b37d:b134:1e73]) by CH2PR10MB4200.namprd10.prod.outlook.com
 ([fe80::9516:b37d:b134:1e73%9]) with mapi id 15.20.4544.025; Fri, 1 Oct 2021
 17:50:04 +0000
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
 <24dc6cfd-8b2e-4ed6-d64a-9bf9372b1b4c@oracle.com>
Message-ID: <bd1ab280-3287-eaa6-a56f-557d3ddc5941@oracle.com>
Date:   Fri, 1 Oct 2021 10:50:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <24dc6cfd-8b2e-4ed6-d64a-9bf9372b1b4c@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR18CA0028.namprd18.prod.outlook.com
 (2603:10b6:320:31::14) To CH2PR10MB4200.namprd10.prod.outlook.com
 (2603:10b6:610:a5::9)
MIME-Version: 1.0
Received: from [192.168.2.123] (50.38.35.18) by MWHPR18CA0028.namprd18.prod.outlook.com (2603:10b6:320:31::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend Transport; Fri, 1 Oct 2021 17:50:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ab74722-98f8-47d5-6b2d-08d98503e661
X-MS-TrafficTypeDiagnostic: CH0PR10MB5177:
X-Microsoft-Antispam-PRVS: <CH0PR10MB5177C4D1E10BA1237C03B726E2AB9@CH0PR10MB5177.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4MEsGmQ2lx47fN/Juh/WBpBIQ1adfuEbB2fCHob3SiDW0A6bTv28nsbiVgdX8GUtOB38kShdyWCscKLhFQzw95iziebFkZK7cJoJ1W3pgvu/AZtODr5bEryipirfCQdRM2HyGC1F+rBAQ5qAFIgqQOBAvoizvTTFUn76oFY2umPMBtj97biYg6NMzHV/RjLq3AD1TvdWM9r5Mm92UYnu+iCNM6RrKqyCslqT3SDYCcXVkK2VDSwMK7UBKp5qP+xJQ7M+bTg8osn1bGDBsz4Wkap0wWw9JYG+TT71iWgiqBD9gj7t2f86X30oRXcH/l7HBHZq8zWJqeRxDxA/305EgLyCUXcax4xeVk8j5+6kND8zxm5wckRpyKrPrzvaHQX9vf2tdHT3ZXl1pTPVJ5yxC9aJRSJyXL+hm4JamAarXaCKtqo4GzKLjle0sm9ux3qlV5sMLJq/+KzFYJZ86RglAwwZPM42hqba7K1pDoPqyqQmKXPuCIGOOR3QPoiJC3qRe/IJmwKS2qhCzLbfMfRYUgnMUaIvfBgC7UjkkqlLAovehzpGkKSCySBmUu54YjVI6ZoXx1DD+7vUEHYs8Sg3MHijv+/ECdqyvoGmjBHgI+8IYcPeFIVZvTzwU8NVyBPnJ8chOc4NxPwAewpFogf8N5HKYZds4KATcHWzs32upJHA0WL54txiq+VEfIQGznweSETibC90LLBhAdi8/1quV0dUkUspp+NNwa2ZvdieQnEaUNgh0AnlR7TiGJ0Zsa+3/9K6XneRMkQ8DMFMXKyfww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4200.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(7416002)(2906002)(52116002)(83380400001)(16576012)(53546011)(31686004)(31696002)(5660300002)(316002)(8676002)(38350700002)(4326008)(86362001)(26005)(66556008)(66476007)(54906003)(6486002)(36756003)(66946007)(186003)(44832011)(8936002)(38100700002)(956004)(508600001)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVNZbjB2bTdUWGtDNEJtUEw4M1BqQzJ2WTc0SVNVYjh1bXd0VFgrcUtBUUdq?=
 =?utf-8?B?dnpXRE1nelJDMzNKcTYwMWpzUmtIZDVSNHlDdlA2SHhsV3oxdWQzbGp0dk02?=
 =?utf-8?B?bUFnYWZ3TEZ6RkFyS2tra1BWdEI2RU5FYmowVmU2Z0NqMXBZVitSZmh1cHJi?=
 =?utf-8?B?NEp4b0h0ZGd4MXprSVNwUFdrT25RdnRVMDFZdWUxL1BJakp5dUtqeUlrWisr?=
 =?utf-8?B?Q2JFZmdEa0F4eG1zeVBVS1RaUDZ4RllsNjJrTEpaWXE0RldsY0VZSk9mL3Jt?=
 =?utf-8?B?SElpKzJiaXR3TTlOUWtCRldwNHVkMzlwKytDejczSTkyKzBXcnp1K2ZGd1cr?=
 =?utf-8?B?cUxYdTA1UkNqdW5JTzF1TGlEU00vVFFDbGxkaE02WGdNTFJLMVBzNUFvWHBL?=
 =?utf-8?B?b3hzN3RtWTRUZ091RXdjTEw3ZDJISVJkbEgxNlpHa0s0ZWhiRGlJWVgrVnlL?=
 =?utf-8?B?aWtYMUQ5dkdsN0ZxQkoxZUdvSnlMcVR0YVpxbGlmMEViYk1IRXVpUGF5TUgx?=
 =?utf-8?B?QjBpTDhsNGw3aTkvMWYwcVRheFJkVzV3RmZBSk01VUdYbEMyRzVLSFZrNjUx?=
 =?utf-8?B?WTlTY0lUZFNYY1FyK1JRZjZKMkJ1NVIyQ0tzMklvRXB0R0prZFNNSUJhRVR0?=
 =?utf-8?B?RGlKVEtYN1hOaGd2VkN5RnY3Zy9vWE1sWXF2SEgydWxwL0NYdWprYkdmUUM2?=
 =?utf-8?B?Q2NEVHVIZGpjQS9MVkpMbzdkWWtWcFJSS29vV093ekNIVm83cXZtRHRKM2VG?=
 =?utf-8?B?b1N4WmJzenVWajJGZUk0THdBM0NkYTRoQkg4VHRGbENmZzYrTTZoVUo2ZHBN?=
 =?utf-8?B?cFh4ZHdvUTQ3TjVac1BSbk9Fcm5rb2lMWHJJbHhiTm12WlgwSzZPRjJWUS9s?=
 =?utf-8?B?bWJNTWlJN1hZaEpjTTliUmQ3ZnJuWEgrR1o4dW9PUjZyU2J6cWV6VHZKQkQv?=
 =?utf-8?B?TlF3TE1LRGs5UDhQQnlIc1EraXhqVEk0WDNoeWdFTGJFTXBKWk52VG9jTWZP?=
 =?utf-8?B?NGZ4eWl4QWhpejllYkV1alFIQWhwZnRWSXlYcWs2SkcyT2luWU5sV0RTYy9C?=
 =?utf-8?B?Wjg0SlNEelBpb1hQbitiaGZqWUhJODZ4QnpZY25kY014d3VQYm9uUUJESHFW?=
 =?utf-8?B?TXU3OFZyWnpSNW4zQnU0aHYzbWhQbFpTd1diSzU4R2hPbG1rWitOYzM4Vm53?=
 =?utf-8?B?Q21pOTJodmpkbzlvd25MY2FFeVlxcm9ma25XUXFKM08vbXhHS3RwckVseVl1?=
 =?utf-8?B?SmprSmpEd29TL1ZFNEZ5T0tBeWh4QXJxSlF1TlMzQ1VwTnY5OUZIbFpmQjRa?=
 =?utf-8?B?eFR4cElpczFIWjVBTWZTcW5YWGoyK2tiS2pVMDJuL3p3REFkemNCRVZZd1hB?=
 =?utf-8?B?NWN5Nzc0bjJaSlV5SXFSYXZhUDNJS20ydm5hbUFMalhBZ2tYWDRwSy9IbEFi?=
 =?utf-8?B?UXV1T1hLYVJBR0pqT1phWHAvV3RNSFRFVDg0RFd1ZVd6cnpTdVBoeG9sNGZY?=
 =?utf-8?B?citJbjM3L1lpc290UkUxMjR2S0t1T0NJemEwMitOUUtCU0l6N0hUTDQxZ3hX?=
 =?utf-8?B?TUZZVm9UeUVlNEgreXIraEtHY216ak56em5WNzh4REVwKzc2T21wWnZ3ZklC?=
 =?utf-8?B?VWNSVGhMNFZDdWxva1V1Z1pLWDA5OTBVQXViZ1hPMmp4UGZsVG0xMUQ1UXkr?=
 =?utf-8?B?dDArTXVRc3p3eXFuS3F2ZmdnaVhDS3dhWHE3cjZrYloxNVVXK2FneldRVmQx?=
 =?utf-8?Q?xL0bs1NfHUpCtT/5ijmY1GQ6Y7oPeI/K9MO/Rt1?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ab74722-98f8-47d5-6b2d-08d98503e661
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4200.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2021 17:50:04.9008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PdpDJ+olj7xe+JzBsGb2J2tfE75fdr0jgXGwePp5FCBlzLroCjqu4dKqBkczkItxM7bolJUc3q0Z8c+vEXkhmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5177
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10124 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110010127
X-Proofpoint-ORIG-GUID: 6YqhnjpAd-jQvlO4NfzoD_6ttQUVP4xM
X-Proofpoint-GUID: 6YqhnjpAd-jQvlO4NfzoD_6ttQUVP4xM
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/29/21 4:21 PM, Mike Kravetz wrote:
> On 9/29/21 12:42 PM, Mike Kravetz wrote:
>> On 9/24/21 2:36 AM, David Hildenbrand wrote:
>>> On 23.09.21 19:53, Mike Kravetz wrote:
>>>> When huge page demotion is fully implemented, gigantic pages can be
>>>> demoted to a smaller huge page size.  For example, on x86 a 1G page
>>>> can be demoted to 512 2M pages.  However, gigantic pages can potentially
>>>> be allocated from CMA.  If a gigantic page which was allocated from CMA
>>>> is demoted, the corresponding demoted pages needs to be returned to CMA.
>>>>
>>>> In order to track hugetlb pages that need to be returned to CMA, add the
>>>> hugetlb specific flag HPageCma.  Flag is set when a huge page is
>>>> allocated from CMA and transferred to any demoted pages.  Non-gigantic
>>>> huge page freeing code checks for the flag and takes appropriate action.
>>>
>>> Do we really need that flag or couldn't we simply always try cma_release() and fallback to out ordinary freeing-path?
>>>
>>> IIRC, cma knows exactly if something was allocated via a CMA are and can be free via it. No need for additional tracking usually.
>>>
>>
>> Yes, I think this is possible.
>> Initially, I thought the check for whether pages were part of CMA
>> involved a mutex or some type of locking.  But, it really is
>> lightweight.  So, should not be in issue calling in every case.
> 
> When modifying the code, I did come across one issue.  Sorry I did not
> immediately remember this.
> 
> Gigantic pages are allocated as a 'set of pages' and turned into a compound
> page by the hugetlb code.  They must be restored to a 'set of pages' before
> calling cma_release.  You can not pass a compound page to cma_release.
> Non-gigantic page are allocated from the buddy directly as compound pages.
> They are returned to buddy as a compound page.
> 
> So, the issue comes about when freeing a non-gigantic page.  We would
> need to convert to a 'set of pages' before calling cma_release just to
> see if cma_release succeeds.  Then, if it fails convert back to a
> compound page to call __free_pages.  Conversion is somewhat expensive as
> we must modify every tail page struct.
> 
> Some possible solutions:
> - Create a cma_pages_valid() routine that checks whether the pages
>   belong to a cma region.  Only convert to 'set of pages' if cma_pages_valid
>   and we know subsequent cma_release will succeed.
> - Always convert non-gigantic pages to a 'set of pages' before freeing.
>   Alternatively, don't allocate compound pages from buddy and just use
>   the hugetlb gigantic page prep and destroy routines for all hugetlb
>   page sizes.
> - Use some kind of flag as in proposed patch.
> 
> Having hugetlb just allocate a set of pages from buddy is interesting.
> This would make the allocate/free code paths for gigantic and
> non-gigantic pages align more closely.  It may in overall code simplification,
> not just for demote.

Taking this approach actually got a bit ugly in alloc_and_dissolve_huge_page
which is used in migration.  Instead, I took the approach of adding a
'cma_pages_valid()' interface to check at page freeing time.  Sending
out v3 shortly.
-- 
Mike Kravetz
