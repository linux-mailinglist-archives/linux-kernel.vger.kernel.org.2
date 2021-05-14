Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6471380F58
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 19:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235286AbhENR6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 13:58:01 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50128 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbhENR6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 13:58:00 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14EHuecC033541;
        Fri, 14 May 2021 17:56:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=xHrTNjQk5OjYT6IdCjHX9JwlM3/3ORfepaZ7cKGqXdo=;
 b=MbBBafb0EwbMKItTpPzvHFRCGwdONUgQKgUoAF+Gncz44jFKke/B3l5Qs22dd/SGQQIe
 SJbxkya95L4FiRSWjUA/AWV27GDjdjpLduWXa2BAs8ku8+PQluILYX56+jKgavu5uUU9
 L9BS1st4bmeaEFVd7eRi3AMqvUXRupYnIrsp7zxjAYpuMA5Lurewu9DzrFVJlC8kunxW
 BoiwrNXHJdNG5fYt2rf4IfXZek5e4U+G5mpVPCWZJAPySUiWbg7XbLsw8mQIk4aS5/zO
 8w1GgdhttvBssS7LuOqR6o5m71ZAqwA6leIADmRAtXBPrEhXtZSAEL7/UMSQgDJt7Ouz Aw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 38gpndd0yf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 17:56:42 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14EHqFrn112736;
        Fri, 14 May 2021 17:56:41 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by aserp3030.oracle.com with ESMTP id 38gppqa6ds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 17:56:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B5sT9m9MEk1Gj+2Z/cuVzq1QsV+v7aul4kk2HxUCH6ehCobK3os3Oh6DH9LR5z6WTkXhSkrJp5CE658kHI0tT3L+r2rLMunhv1EZuybsKBvmczmj2JqRnDIoGc3gNqU+AOacKP7uYgwrk3JyolaJBLa+of4YPOxX+dErV3s+kJO/h/12WQ4fJAUSCc7i/miTmwxcDtLqGhn0ViC0TOXpjxF6C05W2UbZxCJFPyH4lbWnirJ6HaKGN0JUuxtUNQMecdaS5mYqvU2cazsz9I5IeVnFoiPeXDxJEQSPcViOzWSBGugvj/5mLbGFhI1o8fV3/DWqQ32g3iqdUuf4Sbnomw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHrTNjQk5OjYT6IdCjHX9JwlM3/3ORfepaZ7cKGqXdo=;
 b=hs2ivWquKKChSovWVQxkUGVjPTUkf+eKWkCW5WUin5L6rOX/WFC+b6vc/IwUOfYpqx2iWO1bdheZ6PbWsZR8OTDbA8Lt++vNQGfuofrav33qe6/gZiLgkKtHeCX0vWwoesVFFsC4WngUr1zjfNaVSiHKfdBKfmgtxwb3hP8Wlg7KKZ4ARNksmeEYZ3ubOxHUQH8mHrEWhhWjlEqsuojLU8PewpdLNBQbotRvqfHAOUXXzN/cBW/8zdiBpxDOY48tyxxo50Bt7CJxrB24jmapjwmqJ+f0oz7Khe8gMfV90a+SUysOTIxqzHzbNzwzdpHZittbJ+p+NxSQRqirMc6+pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHrTNjQk5OjYT6IdCjHX9JwlM3/3ORfepaZ7cKGqXdo=;
 b=t4xFtfBURLmLExiGLi8oGEIKjTk8vOXMDE5RmviQZ6rkWOQMUiotu/6rylsxikFgH18rAzX2LVIA2wTZEsLjn2oN5OSDQpAEw1SoM+P2T+7+QS6ioKiqZctVAp3Qld58oQQ4F2i4L3LTfkeyXvSnA1fxvJXjprhghYDXmv9YOL0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4415.namprd10.prod.outlook.com (2603:10b6:a03:2dc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Fri, 14 May
 2021 17:56:39 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90%8]) with mapi id 15.20.4129.028; Fri, 14 May 2021
 17:56:39 +0000
Subject: Re: [PATCH] mm, hugetlb: fix resv_huge_pages underflow on UFFDIO_COPY
To:     Peter Xu <peterx@redhat.com>
Cc:     Mina Almasry <almasrymina@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20210513234309.366727-1-almasrymina@google.com>
 <CAHS8izNkBvS9gkSjy8FbWBOPDynwr8PXXXbMHt_2=5sZJsa6-Q@mail.gmail.com>
 <09dc0712-48e8-8ba2-f170-4c2febcfff83@oracle.com>
 <CAHS8izPFc+bSrKN-6gRguGefAqrj6kXaMUvgeUL5U7QxhXfWDw@mail.gmail.com>
 <f9c85756-62e1-3d5c-9fbc-f38c6e8f07f3@oracle.com> <YJ5tjWKyVZk2mvxo@t490s>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <dd83c970-797e-6b7a-194d-790df5d53867@oracle.com>
Date:   Fri, 14 May 2021 10:56:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <YJ5tjWKyVZk2mvxo@t490s>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: CO1PR15CA0101.namprd15.prod.outlook.com
 (2603:10b6:101:21::21) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by CO1PR15CA0101.namprd15.prod.outlook.com (2603:10b6:101:21::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Fri, 14 May 2021 17:56:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad47ce60-8140-4857-2e74-08d917019fb4
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4415:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB44150BC4B5EA422FBDA4A5CBE2509@SJ0PR10MB4415.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dQR8ehrcS8w5n0ZIm6/ozMo0A5cv6Z+QCsyxE3fed0rQuGngYYHSkeobkx3ZhyEj48SPfbYpIWFLWFW3MA5PQeSZDcINNQ0FKBVnsQLk2ji85pSKgIKXl+Uo82Paeo3Z4zT2gpyfKgK70ohAtWK19QmG5mve0KvVqdCzcHjGBjuAYfI69lTvILi9VeQ0ywWvPaJg6AowAUm2aYsJUD+SnvZhYUlcMWUYvFLPMUrZqlxtUFTP/j31ZfYPTDqT4t0Cjey4EuBzPpwH0dSJSmmin6zoQf0NGVmlbxnEy5SRFmNBMWKVYINEr8RxEsrTrHtRlq8OGoxo/K/XBvjIpBntYw2T4P8vMUA50caGax0TxJOLIses2+Vl5Dfp7QsSCYnDqauZ59SVG1v91jAEr8wq67ZtBUAQs8OqkoEM10Uuqe9vmU6NGaeQDmpP9EWZDn+cFr8FbqifOLJyOwZRL++xSGMFKbA5KbTSxQiYIiv4wJUy8Yj1NRu6lpXs02+Yk20I/yXwrjz3q0mwU74FTZdTOQ/PuAo4CUDqAQKDAgZhAi8k/K7bCsGkaW0In++Vb4ezngKiVHCaS6jQizV0b1ZlvmA5y1QCCmaE1Kjh+fiwKF1k/MybZmiPBhODm85caPIsZrB8ZE0sNH6auG6UezXgRChbYGwA9bP77Tb8txtfIxTjNpmeX6Kl97LIR78L0ZeUnyloeihB+hmlXozxTfeaIg3UFnBZokz6nWNz/AVzd68=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(136003)(366004)(346002)(396003)(66946007)(36756003)(66476007)(66556008)(54906003)(8676002)(8936002)(316002)(956004)(2616005)(16576012)(478600001)(31686004)(5660300002)(86362001)(6486002)(38100700002)(186003)(16526019)(6916009)(38350700002)(4326008)(31696002)(26005)(83380400001)(44832011)(53546011)(2906002)(52116002)(14583001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?L2ZXcXBGQVhMOXFCTGZVNnFnem96WERBN3ZyYmJBMzRHYnY3YlhlNW0vemg1?=
 =?utf-8?B?K21DTnZMSDZDb2UrTktqTGhmMC9EdlB5ZCtoVWZGdUx5RVAxSnVRTUFUa1d0?=
 =?utf-8?B?d0c3Qnd6U1lweGNzTmZ6eWd1OFY2cXEvd1lWamczKzh2MndwZVUwc1dyb0pQ?=
 =?utf-8?B?SjJoNitHRXdVVUZJWTVXZ0dhVUlqby8zazVENHR5UktMSGd2NEhRNWczWUMz?=
 =?utf-8?B?dlhrN3FndnNpbSt4STZ0YURYWW5URWZLNVFlWnNiYU9PMmgrMGZmVWdONTZz?=
 =?utf-8?B?azZIeWpaYkRpNTYrS2hLSWlhV3hrc1VkOVlLMmUvN3lCdWc1WnFFL1JtMlli?=
 =?utf-8?B?eUh5ekMwVXc4TkhrVms3bGhlSTRuRkNXS0FDM2lGYm9xNlZuUktESDlEdjBS?=
 =?utf-8?B?RGJOSzFacXFYaTNzZzgxQUtNRCs2ZE9ZQXBqVk1QSUVnODNtOEFuczFubWM5?=
 =?utf-8?B?ZUpmQ0ZXb2pHZTg4ZDVCNWp5T3lJTlVBS3ZTRk0yWFdDOUZNMDdKbkltd1dn?=
 =?utf-8?B?ckhaZzdCQnRhWUR2N1dURXI3dTYvS29LdjgxeHk4T2RoL2x1cGdDeFg4S01T?=
 =?utf-8?B?Tkg1c3MyVURTeTRuOC9yUUJtWElVbjBTOGVGMDJUazlmTUZuMEtYWWNZMEZP?=
 =?utf-8?B?WGorU3kxNlVsWTFVRk5UcGV6WERsYmFIRTZuZnBsY0pFQlBzd1YrNXV4VUc4?=
 =?utf-8?B?Z1FacGhKWXlPMkxhdjN5b3lmSDg1U3NyZWI3L0hHUmdUclRNVGs2QklGcDN2?=
 =?utf-8?B?SGZYZGN5cTBLQ3pZVXpucXVhSHZyeW4vMHJHSmZuTFRqQzVEbEhyaFphVHNG?=
 =?utf-8?B?ZW00QWJIS2ZBM2FvTmtMTnZxSTdweVJXd3B6Qzk4akYwaXVFYjRsNlFBVXh2?=
 =?utf-8?B?L05oTjd0M2tnNVgveE15Um0vT09RVGR2NHlTU01SczhBZW0zcHkybllGL3Na?=
 =?utf-8?B?Q3NjQ0plb04vVzJDZWRxUDArUkphcHJoTkU1SGdiZjBNTkhDNDlWYk8wMzFq?=
 =?utf-8?B?dnhNeGtvNUZVU2lrS1VNMXg2RFlhaHJ5ZG5PaXZxOGdCOGpmcmZyMlBKd2hE?=
 =?utf-8?B?NnNsZVhoZzdldUExYzFzUHRkV0MreEZyc0J6bWtkdjl4UWFvbEUwUlVySXJv?=
 =?utf-8?B?U3Nrc0RNK004cDNMckVvcFVBL0tHYS9ybHYxdGg5OTlxTnZzTGFDWUVCcDJP?=
 =?utf-8?B?NWptSzdTejAxR0YyNEY4U2h4UWtRZGthN0RPaWJRajN4bEpMdnAzNHlZcTB4?=
 =?utf-8?B?ZHgvRE5BV0xDVUNMbDlEaWE0bmZzbEU3aDNONm5NcmtCZDBwSVRKVk9pTHlG?=
 =?utf-8?B?SGZhVTRVL1V5SndWUHgwV3Z6dnZlQk9keFIxYXA1TUN5R3JHVG5IcDlBdXBL?=
 =?utf-8?B?d2wzNDBXRlEycHJuNzRVNTBNR0JiaVpjZ2lsKys0ejNid3dkeURrSGZXZGVE?=
 =?utf-8?B?VlIycHo0QjhDODh2MmQ0RjFSNXpKejJ0alFQK2JUR2o2WnpKY2NVNjFDOCtQ?=
 =?utf-8?B?bW1pVStvaU9OQkFTVk16THZwa0Voa0ZvT1M5Y3RZRUFmeEVOeFNaRmxQZzNo?=
 =?utf-8?B?cUdrVkZ6dTQrZ1JvTDRENEJHalhDWlRmZkRlV3B0dkxCMVZERy9uc2VWaGNF?=
 =?utf-8?B?TlRuYTRNaVZGa3k3RGxRTmtwMFhNM2Q0TW8vcjNkMjVaMytNNEhuV1crTEZ3?=
 =?utf-8?B?VnU5MlhnTTZMMVNGS2w4U3VOdDR2VG4wMnhMblJpdGdjTER2OG9uV0licEhW?=
 =?utf-8?Q?NNyVBqJ/JgPxdWwN498Cntuo5iTA/Zs4vVQL7bt?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad47ce60-8140-4857-2e74-08d917019fb4
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 17:56:39.3189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OgnYmDjPlqBDMfecy/mlFKr5+87qWp8OxEi/5xOCEqD0Hyzf/snuPn/8JIODK0OfofzT4eMwtDiDi9+/gYn9vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4415
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9984 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105140140
X-Proofpoint-ORIG-GUID: f8xOAwHqV64UqZpOBEf33j7v3UZcCdMl
X-Proofpoint-GUID: f8xOAwHqV64UqZpOBEf33j7v3UZcCdMl
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9984 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 mlxscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105140140
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/14/21 5:31 AM, Peter Xu wrote:
> Hi, Mike,
> 
> On Thu, May 13, 2021 at 09:02:15PM -0700, Mike Kravetz wrote:
> 
> [...]
> 
>> I am also concerned with the semantics of this approach and what happens
>> when a fault races with the userfaultfd copy.  Previously I asked Peter
>> if we could/should use a page found in the cache for the copy.  His
>> answer was as follows:
>>
>>  AFAICT that's the expected behavior, and it need to be like that so as to avoid
>>  silent data corruption (if the page cache existed, it means the page is not
>>  "missing" at all, then it does not suite for a UFFDIO_COPY as it's only used
>>  for uffd page missing case).
> 
> I didn't follow the rest discussion in depth yet... but just to mention that
> the above answer was for the question whether we can "update the page in the
> page cache", rather than "use a page found in the page cache".
> 
> I think reuse the page should be fine, however it'll definitely break existing
> user interface (as it'll expect -EEXIST for now - we have kselftest covers
> that), meanwhile I don't see why the -EEXIST bothers a lot: it still tells the
> user that this page was filled in already.  Normally it was filled in by
> another UFFDIO_COPY (as we could have multiple uffd service threads) along with
> a valid pte, then this userspace thread can simply skip this message as it
> means the event has been handled by some other servicing thread.
> 
> (This also reminded me that there won't be a chance of UFFDIO_COPY race on page
>  no page fault at least, since no page fault will always go into the uffd
>  missing handling rather than filling in the page cache for a VM_UFFD_MISSING
>  vma; while mmap read lock should guarantee VM_UFFD_MISSING be persistent)

Perhaps I am missing something.

Since this is a shared mapping, can we not have a 'regular' mapping to
the same range that is uffd registered?  And, that regular mappings could
fault and race with the uffd copy code?

-- 
Mike Kravetz
