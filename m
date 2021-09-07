Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFFF402EC7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 21:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345622AbhIGTMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 15:12:03 -0400
Received: from mail-bn8nam08on2045.outbound.protection.outlook.com ([40.107.100.45]:1408
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230203AbhIGTMB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 15:12:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P5wHfP07r6rHvydtNrSWemrtvtFXreMHJZnYMxSx5aGqMtx7tMZHICtTboZFz+j51cWq+YIU4y5hM8EuX5m9/uQxR5jmES6zDO4pGT8BX1oTD8ovX2u5kWnQ+9brrgxRACnSK1TVXSV+8xMNgbVYmVky7AS/EIxM5d9eCbFJIbadeSAb4FN6DMO6zU6vZM6MX5lTbBs3PK6Kg+3sm6Zy0B9fCbvogRPYwl/cmEzkjAbyBomycJwz9BUu6Sk1qt8vsg9GyZ5uoN1MahKU1b3tSpsuDDofSKsQQBKTMLduxXWqgNfT4JuERaAPGDgz84bLo0OO67zNSHTFjqUDJKJcOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=x6HJC1QCzoKrz5SkFD52IL+bveBqEtyFzT9/Xv4M8Ns=;
 b=QYtQ1TE0bbDeOvmtlqSh/T3+6tfSUPePrwPKHferqj2w+TUkIGDpEzpRfOFZjL5qIx/pe+nuEv6NN+wyfvcg+zZUuqkHaG0L60WkrfAZIyhFhaK9TMANXDxI3ocrlojW/569iUIRm/n9UX1VHkjyRm5aymvKAho7rzK0zC3QFZADeZsNYUa7CiLfS+p4FYV80SFlnVpTHXEVmAStGWddtWwkOhvFyPXGCQ2pqrUlK2EB6Fh0nlAKYpWdhngxv+3Vp3Z0C4nlLVa7+R7oa73feDiQLbVK+fM604mE1HNMjTr3kOi8vE1JSGHTe6is7d1+Vf1pIdPmkIpMt/kFLHS9mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6HJC1QCzoKrz5SkFD52IL+bveBqEtyFzT9/Xv4M8Ns=;
 b=DOKixaSZBKP7k/dl758rM537Uyl0wmhyuKE7hYoP88/yZNYt8LISDARKnr83xFJfMyxjQktSY5fkxB5HPwPIqNBhqyKpzljN5PUE9lDUXhR6OgOW1JpCx0HFBjLiCMgMQQOHcM09XY1thoYVQ7cOrUsTVT2NkIf4bHeUKPe1HXGjWaDoiq8p3KX4+eeFawdHZ8CtKq3jA3aMgW8cuEWQT5npZR41Am/VD8UnjcClvCz92xagf8kZxmUuyWWbTPLbb55KuQmQWXOG5qWdLZ7p4baS21lqKbZAEev/kNaNVqMbI+CEampTQIPbWTkd3XIZ1H4ee/TiTe2r3/Ds1RfYlw==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BY5PR12MB4835.namprd12.prod.outlook.com (2603:10b6:a03:1fd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.22; Tue, 7 Sep
 2021 19:10:53 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::18d1:be89:51d3:58c9]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::18d1:be89:51d3:58c9%6]) with mapi id 15.20.4478.026; Tue, 7 Sep 2021
 19:10:53 +0000
Subject: Re: [mm/gup] 9857a17f20: kernel_BUG_at_include/linux/pagemap.h
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        kernel test robot <oliver.sang@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>
References: <20210907153736.GF17617@xsang-OptiPlex-9020>
 <CAHk-=wh=4TJ3yN0+qpzDPJcH3KFkVsHcHO1FJjKHjaPTx8UCdQ@mail.gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <513d8734-7156-f3b6-b149-4d2cd83b5742@nvidia.com>
Date:   Tue, 7 Sep 2021 12:10:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <CAHk-=wh=4TJ3yN0+qpzDPJcH3KFkVsHcHO1FJjKHjaPTx8UCdQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0036.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::11) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
Received: from [10.2.63.205] (216.228.112.22) by BY3PR05CA0036.namprd05.prod.outlook.com (2603:10b6:a03:39b::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.4 via Frontend Transport; Tue, 7 Sep 2021 19:10:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18bc312a-4e10-4119-0a35-08d97233364e
X-MS-TrafficTypeDiagnostic: BY5PR12MB4835:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4835FC2FFF7405EE8952DD36A8D39@BY5PR12MB4835.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7sAPUbLa0QRkn4NB7IysrKOSScpEY5UbC7+TyBZnYVaV5ufK52zY/fDuOYOthnCNh/7c2eB49V4ZLM2QKTlJIeFN4EkmYbsSShDYHYZg5Xd71xx+d4znhlx/rN3MC8I6oqQw5xRRtHCvyZ7FotqmZdHC3juN6GJ7Ige7URrS0nlbozXGuaRIqdmpi1Ougc7eEQekZxUeLDRP4ewwmILWKH58zxHVE1+lYVm7ML4Vo9c2lWiuyXq1B6IwxFF04W+SGcYj77qb0JN/cPL+sD2hpXq4J9bWzEsrzIg+4MjnYAKWmlQD9K5VkYIjItr+kpOJAPD7DDvkIBYhApUpBpoy0OA10t41OJnCqOzTaBT6f1Pa8WxkEAyq02ZXqdfygJSNM1oYQh+dnXXdaFmWqlm3ze3+ZAWGhNWc4jegsZE+m75WQTJEn9/KucxFm44XkAltIAy/u60LSshHFLVwlvX1LQPNbid/VS6CT7RiMBMifGAOoxDUFoXT6m1JMf8tlkOolC43AJQgpWNKIVYpjbngqU6wQORcPbXwM5s39ixQ0Gj1D6s1Nw+AMh0JzBz/iB5dZzn7JETQmLhm2FPrFRDURjquoQWTzsXmlUgAoqwjCJZi26ueuxkmC0FhTVrsrGe7VVHQGTZ53eAbCnirrpZvQKmQlK4qd5Qv6jJ8wF0VnzSVmtFPXY5JiNTKU8+Zl28Dw37Sxeyzvpz4pXT7KR2L3WuF/MEo1O0sg4WrqouTxXI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(83380400001)(38100700002)(8676002)(86362001)(7416002)(8936002)(2906002)(54906003)(53546011)(110136005)(66946007)(31686004)(66556008)(66476007)(508600001)(2616005)(956004)(4326008)(186003)(6486002)(316002)(26005)(5660300002)(31696002)(16576012)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckVOeXdtQi9FS2hSZ0E2VVBQTzZFMDJheVZjMDNyaHRWRkNOTXhONEVWdGhq?=
 =?utf-8?B?MjU3RXJaaVFQNmQ3L0d6c0xreVhwU1FEV1l3MXVMSjZBQW9BQUY5SmFzNThL?=
 =?utf-8?B?c24zYXplVmNwMEhwSThyZVprMzJkWTZkQXlDcnJxejVoOVJUUmt0YjBMNjgr?=
 =?utf-8?B?NS9MUzZ5QmRHaVBpMlpRUW5wMlZobUl3and1MGpyWEM0M1BFWWdTbjJPaXo4?=
 =?utf-8?B?UURta2NLZW42RUtLTjR0elgwNXZ5OWpJNWRid0M5SWZNZHg2RGQzS1orWFJ1?=
 =?utf-8?B?UmRHdkl5MGRpNXg4azYrb0UyVFJZOUMycWtnYk5lRGhDTjhSK0hyc0pzelRu?=
 =?utf-8?B?R2piNWZUWTlic3IyY3h2TDdjaG5BdjJadXQ5bkJhVVBLRUhwcXkwVk5tTUIy?=
 =?utf-8?B?aGFjWXNqdmFHNzNpVXlVK1RyRmFRN0ZGRGttWHdXdk4yS2pPakczUnFJVmNs?=
 =?utf-8?B?ZGJ3KzZ3VGIrRzY5SXdKeEJlc1JzSWlVOVFNa0tKV2xUNFYyKzFFMXNydmgw?=
 =?utf-8?B?N0s0Vit6MnZNd0FlcFFJNUVOVzRzSldleEozc0FhS3grWEQ5THhhL0RvMkxH?=
 =?utf-8?B?MGRkekVxZ25xS1NXRW41ZjJwY09QdmJzS2NReTBRUnZGTEJHN2NtUFVxdHFQ?=
 =?utf-8?B?djNSL2xNbTEwd3RyREJOTXJZMldXQUgzYjM2dXU2cGlyb0IycEJNZXRQUXVr?=
 =?utf-8?B?ZVkzMVU0TzJtbzRYSVhBb1A5d3BSbW5hM2NxNzM5akFIZ3ZWZzVPR0pPQnV2?=
 =?utf-8?B?b1l2STFDLzZNaXZtUVgxTlNORENYM010WEc5TTk2QkFnWHlOZi9MZlJXNWdp?=
 =?utf-8?B?MDFSOGRoOGlzMjc3cDlWTHZtU2RzdjZPZ1lGV1FZb0ZrNWFIeVA0aHF6Zld6?=
 =?utf-8?B?NWlSWHlwb0RvK1V4cUg5MndlVUMycnBQS0RTNDhxWVpzQXQ4ZFlJQ3F3YVhB?=
 =?utf-8?B?MXhIQ1lpaGQrdWZCN3A2N1BXSmUrNUx2WHBtK2JOTTMxdDlvcS9wZG5DYW1E?=
 =?utf-8?B?Z0JqNEJ3VVYyeTFXeGxBeGF1d1Zvbm1LNWxIMzROelVSMVpNZGxMRXJFOTdF?=
 =?utf-8?B?Q3kxNW5NNVJNMm1IUGVoUU4zVmUrU3hTc1Y2bTNHQ0hqcVN0QlIyWVJqT2F1?=
 =?utf-8?B?djhEZmlseldJUnlVT0NCZTkyOCtqSUtiV0dLQ3FwS3FyVnJTZHIzUkYrVnF3?=
 =?utf-8?B?T3lCWlpNZXVSOU5na1lhYVRoY0VJeithL0NXSEtieGVIMVM4NGJWMSsvMkwr?=
 =?utf-8?B?UTVzM3JpNEZlUml0bjFTZTRER01CaW5jR0Z0Vk9uM25DMy82ZWN1bXErV3Fy?=
 =?utf-8?B?OVUxZDR6ckpyeE43SDFTTndxeUNabnRKVUJXV2pZVjBjeXBIUDFZVEtoZEVB?=
 =?utf-8?B?RDZTNG1jOEo0bndmNE0xSDBZUjdQeTg4UEpFUllHbUhoOW5uZjZOc3NSNnYx?=
 =?utf-8?B?bXgvMzVTQVZacGRCL3pvbzB4dnFTSXpUQVpkOUZhSXJPYThBazUvUUtrREla?=
 =?utf-8?B?eG9waVBsc2pIQzJzWWZKdFRhUVp6a0c0cHRLd1dMQzdiRWxUeEsrNWdxbEJ4?=
 =?utf-8?B?RnBFQy9BZVNweW82UjdaejlDR2x6ZG1pVmFRb05tSDF2WVpSSnRQODBJUHZy?=
 =?utf-8?B?elZDL3E5TDRDQnliYzFUL2NhR0JRTHpoUEJaWCtaS3k5Uy9temhxV3F1Wnhz?=
 =?utf-8?B?VlJ2dXEvSXBIbGVnK202UGFBUTFOcVByMDlBNjFHclNINWMyUG83MVhjUjNo?=
 =?utf-8?Q?ZDPEu3jlo0civ2Y0LnujbFJmBdVd952W2hWQWlv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18bc312a-4e10-4119-0a35-08d97233364e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2021 19:10:53.0564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Dodp7uDwNhJM4yhlXnxYlvCqgeaVpwGCTwzs0qBOoTXsXpJMbmdkxTFq5J1IM0li+G+VfJGhgVEDvj1TIWdjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4835
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/21 11:14 AM, Linus Torvalds wrote:
> On Tue, Sep 7, 2021 at 8:20 AM kernel test robot <oliver.sang@intel.com> wrote:
>>
>> FYI, we noticed the following commit (built with clang-14):
>>
>> commit: 9857a17f206f ("mm/gup: remove try_get_page(), call try_get_compound_head() directly")
>> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>>
>> [  143.908513][ T3260] kernel BUG at include/linux/pagemap.h:223!
> 
> Ahh, well, yes.
> 
> That commit is clearly buggy, in that the try_get_compound_head() code
> really doesn't work at all for us.
> 
> __page_cache_add_speculative() is not at all the same as
> try_get_page(), and I should have caught on to this as I applied it. I
> just read the explanation, and it sounded believable, but it was
> entirely wrong.
> 
> try_get_page() is literally about that "page ref overflow" case, but
> try_get_compound_head() uses page_cache_add_speculative() which has
> different logic and has those extra "this only works in RCU context"
> logic.
> 
> So that commit was completely bogus, and the "lack of maintenance" was
> not lack of maintenance at all, it was all about entirely different
> semantics.
> 
> Reverted.
> 
>                   Linus

Apologies for the bug! There is a lesson in here, somewhere...


thanks,
-- 
John Hubbard
NVIDIA
