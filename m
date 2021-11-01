Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC7FA442104
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 20:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbhKATpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 15:45:25 -0400
Received: from mail-bn7nam10on2069.outbound.protection.outlook.com ([40.107.92.69]:38849
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229883AbhKATpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 15:45:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eaOih3Mcurho5+CUbn7njrXvxMAtG2A8kgqty7U77bFHNu5aEivkcERGSL/FWtUxky2FpfIxKk3Os1hR3jIiZN6RTtMr++9sZhMa6Bq1HUwNOhBw8INO8I2Bg4NxmP/PRvgCZGO/YV5dCakhAPsavd5ZbJhjMrqXE9rat6Z8au6gPZcceccM+46u9OFdo3HDzriXpdxzE6xXDlPNJyIs5yUq0fGmTX1GBbtydCXV3nvTDnwqz/rhIQt0Tj5WsZANgfUJBfh6dzFYRmcH7YKZQGCG9NWoJ0JngyZOVmSqogcmq/2Djc2d3QJ2ZGZ/ZiNdcoA18vP4xHpMWdXaw5oI9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5pcFhAGND5TXLFMZk1QXcMm24yTk6MLAYFHO0A0t03E=;
 b=KBq6dOrdiEY6hIeVuXqkDWqK/Ypbn3Uhnq7DZRvZzN9buFfhlLsYWlXzXkgNDe4b9WLI91TcyvpQhfSAqWZUq35a25qRUY04wWfJjJxNJ0RZgFVlnq0tU46Zdi8rZmbH+oTuEumGJYpS+Cq+9iMKsApE3DH5wq7Gpl4//Y6R9dRfSFnUvKBZWvLwiuDPnd0+vXnPb7XLyq/ufG9IJdAG0oPTOOJ0wuXFrviw5UhOPq9FBVJB7Xpf2KkBtVzOb4ANZtz43AQqSwUQspn3pObtzceYDSoAHhS+La52bNmP617XK4EuZEINB779uvS8QJ5N/sYjFUs0ci1ZrUa75dhCqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5pcFhAGND5TXLFMZk1QXcMm24yTk6MLAYFHO0A0t03E=;
 b=WuivqlRhhGNUZ4ba2fScqTvC8RnvM54kdsES14Np5NdUIRQZO3hBxZFsWmbME9gEKOYHGYb5wIhD0Xf/x5O+zgk9GrFd//3s8fp+e3wO3rpogIqgrdoPZ5IsMtZfcsYWsMwilvePGzB6BGB/ub9W48UX24PI8aMzDORqb1VxlB60PrYpmoReFMFVir4yAskNzcGwZLB8RALfTUwTW8w8Jq9Cij3JTMF2U1DejKRNZdu8sJJCyevR0lUKU70I0HxVH1S9WWwkccgEprzkR/Zy9vdW56E8lfeh6SDw/ZIsHjK6ggB4YRVXbfUa5vdrbR5tQw2Wfgwin5l9sA10v7rplw==
Authentication-Results: soleen.com; dkim=none (message not signed)
 header.d=none;soleen.com; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BYAPR12MB3288.namprd12.prod.outlook.com (2603:10b6:a03:130::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Mon, 1 Nov
 2021 19:42:46 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::a0ac:922f:1e42:f310]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::a0ac:922f:1e42:f310%4]) with mapi id 15.20.4649.019; Mon, 1 Nov 2021
 19:42:46 +0000
Message-ID: <d56f9851-43be-91dc-1d45-f70eb1169209@nvidia.com>
Date:   Mon, 1 Nov 2021 12:42:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [RFC 3/8] mm: Avoid using set_page_count() in
 set_page_recounted()
Content-Language: en-US
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        linux-m68k@lists.linux-m68k.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        william.kucharski@oracle.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        schmitzmic@gmail.com, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>,
        Muchun Song <songmuchun@bytedance.com>, weixugc@google.com,
        Greg Thelen <gthelen@google.com>
References: <20211026173822.502506-1-pasha.tatashin@soleen.com>
 <20211026173822.502506-4-pasha.tatashin@soleen.com>
 <7b131cb1-68d8-6746-f9c1-2b01d4838869@nvidia.com>
 <CA+CK2bD6x01PevPqshzYqkO3aokjP2jBbt_4e5H5U3DVEdcJ5Q@mail.gmail.com>
 <b346cafd-d8b8-57a4-c7b9-6574b256a400@nvidia.com>
 <CA+CK2bBiomTe-vOuxM_R+0CMAippyrfZ6AgpXQGqps3ZFQCtRA@mail.gmail.com>
 <19d16b40-355f-3f79-dcba-e1d8d2216d33@nvidia.com>
 <CA+CK2bBn81pz5NqCvS9jz+DvXbGG6d52Q=xTySJvJuqNRmFkkg@mail.gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <CA+CK2bBn81pz5NqCvS9jz+DvXbGG6d52Q=xTySJvJuqNRmFkkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0016.namprd21.prod.outlook.com
 (2603:10b6:a03:114::26) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
Received: from [10.2.57.12] (216.228.112.21) by BYAPR21CA0016.namprd21.prod.outlook.com (2603:10b6:a03:114::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.2 via Frontend Transport; Mon, 1 Nov 2021 19:42:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83c1fcfb-f097-48af-635d-08d99d6fc762
X-MS-TrafficTypeDiagnostic: BYAPR12MB3288:
X-Microsoft-Antispam-PRVS: <BYAPR12MB328807FBBD982DDD66B1F729A88A9@BYAPR12MB3288.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: guqukGrhzaOYyJUB037uLSSw1kFKAsJtY/FJqcMC4LgCHmiSExhUhVacxqlKEIAbEcAscEcQuqSXrxxliA2vyXi4zjJ6u+u+PEg5fHvY742jdEl6m9MyaQpIQzQeOuh+PfP1h6H3i+WygxAPH7pwFifeNiruLZgY5jti5Np65gFtAAG2CJu9Z/hMqtrM/1PbA9U3vnlAfvSmx6WlMjmYyrNNcGQr0MpnzZPdSWcxBdedW9BPqApRhkA9CPePHkkhVmr6hUspOoxNEGFQqglR9jjl9FICgKi2fUAheBdjNfWdEaV+kZiQJ6+DN2oVWZdWeH/h8nmhVCWc5GCxiU6uIVkeVDSBC7aL2RXl8BjQe11tJCNauZgzjE3jgjAxdn4D/EIv9qEkDqcDhEUerF0srQVn9Z0eiozvO2zagixTuo7wWCJEeiKa1w6ok+Mc/rIHHjZdJ9tGy7qZdeV3FTXwC9kjtOqUsjSuxupcwTAe8A5zt3bLHDgbdnMI5E0MNjgXEXCPdFN71bsIXaI+X8A+2jedrkG/7FD34vst7U28kqLlr4vxr/Hh74nBm8N53aRHYF8O4YYuQ+UaDotvfoQSm7aXRlj2bhfctMmZzxzr4PNn3ea47toX83BiiGLZTHVq2ORsyqs21xg628772BUHHlupLXEKKIW3CJv9Yr9ksMcFJURrtXtwQ/6F1fMc4lGhA6SkmRvxGcFJDkbZpXE4vm6LfsJoy9Q0T+ySSPijHEyo3SgRn6boxIkpqI7sofFf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(4326008)(36756003)(508600001)(66556008)(2906002)(2616005)(6916009)(66946007)(31696002)(5660300002)(83380400001)(38100700002)(8676002)(956004)(53546011)(66476007)(26005)(54906003)(186003)(7416002)(16576012)(31686004)(6486002)(316002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3RTNTdNbnpTR0Vhb2FWelJPOWNvVktaUllFemZtUU5teDFVQ3k5ZXQzTC80?=
 =?utf-8?B?eldIQ1Vja2lUUEl3QTZxK0dMUkR0a1RrMjhLTzVvTlFVOEdYWlJnQzhwOHdO?=
 =?utf-8?B?TUx5bnBjRytucVlYVWltdWVzZU9HOTloUTRvNnNtUmROQUlNbXBzTENLbndJ?=
 =?utf-8?B?Qkp0bzdqaFBZZE5EV2lYK2xvUTBTY2tjWkp5b0I0K05VVHVaUjladEVsQXR4?=
 =?utf-8?B?M01TbnVrM2Eyb0FROTVDaWp1N21iTjVyNHlmazZYbk1VZ3ZNbStFSWt3cmJz?=
 =?utf-8?B?ZGVBV091bU0vS1lvWmU2RFF4SFlOMjZoaUFjV0FsYllIZ3NHZ3JjNFF0Umpr?=
 =?utf-8?B?aVZVU1V3bW1hOFVyRTdzWGtnQWhNaEJYVTZ2VEdmV2xyM1A2Ni9ZcU5KRWF5?=
 =?utf-8?B?b1llUm45NHhVYW5TU3RpSmdUWkR2d0RuWXdGem96VHYrdDN0RU5FNFVDL2Ja?=
 =?utf-8?B?Zy82R1ZrOU1Tczg2Tzd0MzZPaSthQTVTNFFVQXdYNzQ1V3MzTkFlQlpZcEdW?=
 =?utf-8?B?ZHVVamlDa3ZIem83TmlESmNHM2x1ZFFmWHoycFNSZlk4TERKeS80ZjloYmVC?=
 =?utf-8?B?VHhTNm9tTDV3RWI3NjZEUzRULzNBekw2UjB2QWRlQnJMbmh4am45aWpWNm9V?=
 =?utf-8?B?SzdTSlQ4Y09xdm96NUF0akxCYVo0aUIyVzJqbUNCUjloTXlvelR0YytwNHlm?=
 =?utf-8?B?ZmhxTTA1MkFyZG5GUDZBajl5S2oyVVhYdWNwZ2l0b1NxL1NTeS9zaUZkaXh2?=
 =?utf-8?B?dG1ENklKUm95YTl0ZW1PN3hvbU5lZkNLQlpsYXZrUFd3cTArQXVKeHkvdEJS?=
 =?utf-8?B?L0R4UmtKNXF0MG4vaTlidzd4ZjFpSzdqR2NNcnFJazBGTnlnajNxY2gzTVpt?=
 =?utf-8?B?Z29zSFBUZTczTWUvaHV1ZzNWZ2JWMndlb2YyMFJKVmp6YXkvWlFERURkbkZJ?=
 =?utf-8?B?eDNzcFZ6UXJOQWtFWXlXZjdxTkFiMmRucnJpNHFiZGZGOWhVcGw2cGpjVi9h?=
 =?utf-8?B?VnJRRFU0U3BGc3FBeklCRzFmK2JMOTlVR3BDTFNINnZRK1hnbUJIRGN2VHZr?=
 =?utf-8?B?cTFkNnJsYTVyK3ZTOEZ3cktDa0NZYld4RUFrb3RUZjIzQmp1NkxUaGZJcjlO?=
 =?utf-8?B?OElrTWRQMk14M2E3Qy9DN0taTCtHNGRRRkh1OURMVjZybW5PY1NDa3Q4REM3?=
 =?utf-8?B?ck92RjRnS2pOYldzdElPblEvdWR1ajFNUm4wOE5mS1RFWU1GREFFRjF0TlhK?=
 =?utf-8?B?M0ZwRmlDbVZnemExaTVCZFJPZkVkQUhVQmxubUxZNWg1bUNPdlRNRmliQ00r?=
 =?utf-8?B?NFZRUlBYMXR4V0JCMXYxaDJpTmlXNklBN0ZWUWhadmFOWURJeXNVYzhsM3hn?=
 =?utf-8?B?N2tSVGZaV0ZEYy9Xa09relp1OVZ6TmlQSzdITFpqYlZETEo2WkY2NHVKS3pF?=
 =?utf-8?B?azRVVHRKaDliSVpQMW9TUHhKNldxL2I3MkF2MXVnZkZQS0x0TkFRa1JFZHpz?=
 =?utf-8?B?WDVtSlpISnl2NWg5ajIwNG1sWVVJbm40VHFDeU1TOFVmZk5DSDl3bzlwc2cv?=
 =?utf-8?B?KzVrM0FrUVFIRDlqZDI1WGJLUERRa2VVUEVJSXMrN0trbzhWeUdXNEc4a2Fu?=
 =?utf-8?B?QStvZnZMZHJGL0thdjJobld2RjlSb1hWWThySFh6NFBVQkZSTUM3WEcrSktM?=
 =?utf-8?B?Vnh1Q1FmYXViN3RuOUV1anlUaUwwc0lERy8raXQ5S3YzdmQ1dVdwdnpXcUha?=
 =?utf-8?B?cStQWVFFSzc2VUFCY2JxZjc5V2NLL2pxcEVvQnpHU1JqKy91bGovQ1ZUNnJw?=
 =?utf-8?B?NmdIMkF4TlRybkZGakQ5MGNFRUhlc2VuMkJmRWtOMFB2Z3M0R3VpdWNtOTZI?=
 =?utf-8?B?bC9tL0k0cDU0STIvUmY4QWh1K2M4bWIxcFFJRXVmTWVxcFV3aVJoUGZKdzNp?=
 =?utf-8?B?OG9jNkl6ZlhYRlhqM05VbDFBTTlnbFVTalQ1ZVUvRGxwUnBmcmQ4OE1BR2JU?=
 =?utf-8?B?a0lXZENCcWlCQ0lZL3ZQSWlGWGpocXNUbHRQVXhIZUZEV1RIalZybXZ2azZ4?=
 =?utf-8?B?TmpGcnY2Vk5lNEl5SGZ5L2lYWUlTNjcreUNYc1FPNXBIelpqL2FEVDNDdlNS?=
 =?utf-8?B?TjFWd2hRbGQyVy9IOExTTnh0dEE4bFpoUHFjWFRHSGptVmY1SHg0V3JQckh3?=
 =?utf-8?Q?4GlQEHM5S0aZABQIOrsKZV8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83c1fcfb-f097-48af-635d-08d99d6fc762
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2021 19:42:46.3721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v9zoLKMTdfkN+L4xZX+ab7RBKUH1+cxdT+YjzqgeLxIi2eC08J0pqPNE2G6NG6jdGiYd+gR8iFfslH45d853vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3288
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/21 07:22, Pasha Tatashin wrote:
>>>> Yes, you are just repeating what the diffs say.
>>>>
>>>> But it's still not good to have this function name doing something completely
>>>> different than its name indicates.
>>>
>>> I see, I can rename it to: 'set_page_recounted/get_page_recounted' ?
>>>
>>
>> What? No, that's not where I was going at all. The function is already
>> named set_page_refcounted(), and one of the problems I see is that your
>> changes turn it into something that most certainly does not
>> set_page_refounted(). Instead, this patch *increments* the refcount.
>> That is not the same thing.
>>
>> And then it uses a .config-sensitive assertion to "prevent" problems.
>> And by that I mean, the wording throughout this series seems to equate
>> VM_BUG_ON_PAGE() assertions with real assertions. They are only active,
>> however, in CONFIG_DEBUG_VM configurations, and provide no protection at
>> all for normal (most distros) users. That's something that the wording,
>> comments, and even design should be tweaked to account for.
> 
> VM_BUG_ON and BUG_ON should be treated the same. Yes, they are config
> sensitive, but in both cases *BUG_ON() means that there is an
> unrecoverable problem that occured. The only difference between the
> two is that VM_BUG_ON() is not enabled when distros decide to reduce
> the size of their kernel and improve runtime performance by skipping
> some extra checking.
> 
> There is no logical separation between VM_BUG_ON and BUG_ON, there is
> been a lengthy discussion about this:

Actually I do want to mention one more thing about this, before we move
on to the next version of the patchset. The above is inaccurate. The
intent of VM_BUG_ON() and BUG_ON() is similar, but there is *definitely*
a logical separation between them: they do not behave the same at runtime.

Just because some distros enable VM_BUG_ON(), does not mean that we can
treat it the same as BUG_ON() in "both directions". From a "don't BUG()
crash the kernel unless really warranted", they are about the same, as
Linus keeps repeating. From the other direction, though ("I need to BUG()-
crash the kernel"), they are NOT the same. BUG_ON() is more reliably
available.

And that's the essence of my object to treating this as if you have
reliably stopped the kernel with a VM_BUG_ON(). It's not really the same!


thanks,
-- 
John Hubbard
NVIDIA
