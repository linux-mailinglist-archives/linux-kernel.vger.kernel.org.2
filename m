Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B459243D877
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 03:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbhJ1BWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 21:22:52 -0400
Received: from mail-bn7nam10on2082.outbound.protection.outlook.com ([40.107.92.82]:20447
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229505AbhJ1BWt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 21:22:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J5w3BkQ9FBPNtShHuyGjqzS3euFqappAkQB0ibsiJZig4zNu4K8YTc9NTrR8YG4hshlct5cpBFxi3huE98LcoXiJrRnNgbxGKU7SZDyIvC54m1YjGmGOjTeADZkDQaoMX1fT993VZxYvcgKCHSH+Cs8Ly8cLj7V9gLuZF9yzL4mSCPxIgbFK0/VvQhjyfpLJ0FzVtake77vPnlytlKlkiGF5DbtLjeJt5Ht7JQKL6oRzQ4lRNgUCDyHWWyRJSW1kw7NJtHO8xvVBGnAEjbLrtoiNRkFtlA25TL+K1yhT5uLSLh/Z7rqxwRVmv2vy6Pxt93SYQgrQThLXdLCfSbNRAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hmm1YUTuphqvGSM8yZ2ORon1ZTJzmURlDsEmFtAIwA8=;
 b=hrHjNegYAWdWXTW7dWn4yrzTX703PAQFn0r3YkfBNokvdcXJIG0P0TBMSRhKoXoqEenSLC61fvwzBuOd5ZIpdTPvOCbW2hJv+PaorsHJ9tQmsD52G8MNCWAhfoczGj+doIz2sbb7McLtrzUZ64kJBw8pLYCdkMovU7a/qG+vLmYSoKzdscN6Ro0mPc+sa8zHgjVb6R2qOBTyknc0QJ9MRHmV/77sJni40M2cjZhdOVzzPWIQiN0ounMDp2p7tS9cFaf7WEj/RdI3jOOisvXM2f/YOLbZ+EEfcr96KrLgaJVqFtxdOvNpH6PIvorTLQJShQklHU7VJcwkD0A9Ha7Amg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hmm1YUTuphqvGSM8yZ2ORon1ZTJzmURlDsEmFtAIwA8=;
 b=jZE9mx15VWvWHURmkV7NUpx1xKIRbdOHyZRGa9+421dfVP3PMdJt65UJ5Q5s6j+AXoY4k9pjRA7o2n2bLWSPEWeYjv11gO3e5UwUi/ASE7BIQj5miHKBKZS97aHjdG1yK5Y3xyXALf55iPDvaRxd4RzfPD0Bk0zPF1N2LeUJKIx6D1FWichZ8MMHR1AmxDdKnj2W9LnqKzdEsR3fx8U5V05cL6yjUsrtlAzRMzCS+oV60SsN0VuSJYfBY84qwWBv8/cVh2DGlqUWxoHpg6anAJRkhZGgNFsMmvL83cW/oOEmCJ2I4r1OS4h5c4oiljDdRzY0fLwp88yp8T1ZtnbYEg==
Authentication-Results: soleen.com; dkim=none (message not signed)
 header.d=none;soleen.com; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BYAPR12MB3240.namprd12.prod.outlook.com (2603:10b6:a03:136::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Thu, 28 Oct
 2021 01:20:19 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::a0ac:922f:1e42:f310]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::a0ac:922f:1e42:f310%4]) with mapi id 15.20.4649.014; Thu, 28 Oct 2021
 01:20:19 +0000
Message-ID: <19d16b40-355f-3f79-dcba-e1d8d2216d33@nvidia.com>
Date:   Wed, 27 Oct 2021 18:20:18 -0700
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
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <CA+CK2bBiomTe-vOuxM_R+0CMAippyrfZ6AgpXQGqps3ZFQCtRA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0054.namprd11.prod.outlook.com
 (2603:10b6:a03:80::31) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
Received: from [10.2.57.12] (216.228.112.21) by BYAPR11CA0054.namprd11.prod.outlook.com (2603:10b6:a03:80::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend Transport; Thu, 28 Oct 2021 01:20:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 352bf833-b4bc-492c-1ec0-08d999b11b3c
X-MS-TrafficTypeDiagnostic: BYAPR12MB3240:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3240283869E8361EA3E88623A8869@BYAPR12MB3240.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HVVljqiJ3wt50VqNw1qtCECrS9D8KgGdKJSfp5Ehtx6PloCCeoM9KxNDgQvd5JDh8E31vucbbAZB8QSZs1NirdC1IQpnnKvfSd9JwaIcwiVYcyDxsBZGXjeKHrfHD2moYDdIF+03G4fFZMdIIoANHw8aa/gytk9sCkjaOMk2ReJXBV1XHEcW+xOPbqc1R1apt2ay9MO/wdLiMMH7j/leZUy6xF5wMxldcS067eJKhmbb2wwYGZL6djSTZv5oTid32irB8yB3/Ojh77J0HNSL5BIc0e4RKhWjBkhTuvtqBu5IB1lXGMwW8JDtYOXsxnNpVbepV7uGkHYm/XKqXO4hgff+5S4H3LbNlsIhIlTUb3Jl5MZl+Xp3rgrkYvogryhPeyT4v9ak7w94xyokhy7SFI6hA9csMUkuC2JAx+r1C4i7q+vmQV4L3kweE3DRQjbRhbejaXVmqfW9XKy1fboFqJrau3eqPLoYWjiLuzNmpoo7jmIBhHoGS2I+VM78tH1DFQaBbrwGC0ExcfWMJzqkqLBtvTwqbS0MdVu+kUJ4g35SJCKiHgVZ9tydC09PA2iHI4nXK8j6uHU6WKtPDRvPAQbCjfOk8dKRzCcSaNvrr4MQs+L67V5PFizQAnmEkVTr9VzlrTsO7jQLvQQCdGhz14nlVzD5I513Z8aiQPZSrgKeuy9/2D16TtcI8xCaBR98mPOpUFHe7a5a+LB9+tgwmHMgVlp2/9B2jlnMSLBGmRWCYqVZlUgIpuJk5dEqbRALvXvXCeYE7zRCypHhc5M7HfBwLVI3q3ob+NXYCE8Q3Rs4wp6wqNDS9J4GnN5klDqX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(7416002)(38100700002)(26005)(6916009)(16576012)(8936002)(36756003)(53546011)(4326008)(186003)(31686004)(956004)(966005)(5660300002)(2906002)(66476007)(66946007)(66556008)(2616005)(8676002)(54906003)(83380400001)(6486002)(316002)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlVFQjRFUENTa2JxWkpkTW1wNldrL29NWTJMTi9XSXJIUTVJWlFuYldpc3hx?=
 =?utf-8?B?bzYvL29kTDE4YVBDRnFHNThpWGc2N3JJWnYwdFBKSzR4aDBLN1E5RTMxVjJL?=
 =?utf-8?B?WUQ3TXRFWjN6QmRqdWdKWURZd04wRmhpcXo5THhGSk1MSERxUlo5SW5vbG90?=
 =?utf-8?B?WjJDSEtZcEVubmkxVTcrejJmMDBWek80emRUR0F0SnYrVzg5NnFhdTZBSXpj?=
 =?utf-8?B?L0IvdjVtSm8xTHY3b0t6RllZNHpBZUpzaUpkSU03VWpSNWp4dlI0ZUNDaHU3?=
 =?utf-8?B?cmJSeUlWVlRqUXhhajZBb21zSXJVQkh2enB4THpHUnBMbVJDUWoxcEUyWGYy?=
 =?utf-8?B?VCtOSW0xK1BabVNvU0xOQ0Y2QXU5MHFpN1Q3TWZXY0dIZTV3U3licHJYbjhl?=
 =?utf-8?B?bDRCMnhvVFVBZFBHSXgzMWtsWHF0MlEvODh2NXgwYlkwWVM4RThHTk53V3VI?=
 =?utf-8?B?SkZadTJoT3Y5MWliVHROcmNXaVl5RzJibjVWblZtWHhmZGJ4YlJXVkpNb29m?=
 =?utf-8?B?cmRsdE1CZ0hhS0FBSVVWN0dpMlY3OEVlZHRxS1BGTExTR2NJTm5qUnlPVjlx?=
 =?utf-8?B?OWhRQUVseFJqMjJWdHYzajlLV1F2ZVRmQUl2RVd2ZUVidUZpZitoYVdrQzlk?=
 =?utf-8?B?T1h3NGJjL1dIWDU0dGJkNlk0bWZ2RjhZbzhHRURoK2tDNDNFdkg1bVk2RGxq?=
 =?utf-8?B?eEFPci8vMHJWZzJhNXBPMmVwOWovTnlSbC9LRVNCbGw4dnU3S083TE8yR3Zs?=
 =?utf-8?B?amdzVStORTcyRitpTmh3QnlWeENXWnlwdjBseVgwS25SaGtXbkwyS3BZc2Rs?=
 =?utf-8?B?bUFKbGlYQ0tjRkdUZlk4Mm5GY0g4aVJtRnNSUkJrUVZMZjZucERERkQ4WXF1?=
 =?utf-8?B?UlJiN0tUY3djNU9Lb25WOWwyZ1lpQ0tQdnZRRkMyeGhBeXlXMnl4N1FuM0ZG?=
 =?utf-8?B?RWRibkYxaGRrSmNLcTlSdnEvVHNTektScU9jWWVvYkxCdHprOU5VL2JnN2Fh?=
 =?utf-8?B?cUdMMk1uTStDaG5TQnlRWkxJSmVSYmdXTENWQTlBYlNoV0J2djFERVJrS1VY?=
 =?utf-8?B?M3YwaUlGdWJ0NzNKeTVMR3Uxa3p2Z3dFb3REVTY5WXBZZkowVHAxaXBnMnlq?=
 =?utf-8?B?b2JaTWF4VkloczhvQmRibDgzSmxsRStoTTljakx3bUU5RGM1ZC81b0NxTTJR?=
 =?utf-8?B?L0doMTBqd2x5aXhFY1R6RkZuMlZJMmxDSGJaM1hQQWhCaGlrM09XOVAyeUdn?=
 =?utf-8?B?VStFbjQyOW13NHcrOWwvbDRoVHVER1BQYUdOK1hBTElXeGxFMUJwcTFZeEFU?=
 =?utf-8?B?N1orcmhYSW42QXVkZ3JkMEw4MklueWdaQlo5U3RxV2RGSXpGUGZzZGM2bWFN?=
 =?utf-8?B?bDNrZmRsNU1weDlTZXdwU3doOUVCeFBueVQ5WFoycjNRVlRJcVNzZHJveUxo?=
 =?utf-8?B?M1VRbTJWSmpuNTJVcXdhQmk0VDZqd0xkNkNDOXJ2ZW5SaGdLVkdjemthdzk2?=
 =?utf-8?B?NmFEU0x6TmNIdTgzNnpqUndYb0ttVGhMZE5uVUptYVErbyt1VE9wK1VrRUV0?=
 =?utf-8?B?R0pOTFdqb2ZpTERVRSswMEZhdmFCSmFGdXJ4dGZ4aEZvajE0MDJDeHZ2NWMr?=
 =?utf-8?B?dWtGa1NhaVQ5VjlYRjBlczVLT1dLT01XUDVmc1FyYytmdk9JWWVJQTBxNlNV?=
 =?utf-8?B?d2tuNlIwR0NDa2ozTUtHS2wvL2tHMDhVZEo1TFA0c3BtZVU2cldoSnl0Rmto?=
 =?utf-8?B?cEQwVkZNMWVvUlJ1dGthck5GM2V2TDZmN0Nya3JjRHk4KzJpSmJYdlJkMlNv?=
 =?utf-8?B?MmM5bTVGZjljcXBKZzkyM252alBkWXJuUjZKSTNjanVRZW9lQU82QVZUTjFI?=
 =?utf-8?B?RDZ3U21Td0VBRk5vb3pSZXNZcDFLNlU1bElpUk9Yc01vK1l5VUFOUTI4S0VH?=
 =?utf-8?B?RS9taXBTNFBOekNvczVNeFRuL21UbGZPQU42SWtNWXhoeW9zMzYvN3h0RmRp?=
 =?utf-8?B?WjBuRlBRTU5DVDB2OUJvY1NsMHBodXhUOUcva3RJck5VaEh3UFNBQzcrVjdI?=
 =?utf-8?B?emRvdmtNSUJ4R3lTMFJrWWhqU3NnM29mdkVhL0l6dWZDWEtnaURwVmhLaWRC?=
 =?utf-8?B?WkI0K1VJZmxHWGZkbklIZlYrVWVHRVhPaGg3SElDWlJ2eis3QnY2Snk2alpo?=
 =?utf-8?Q?NayRxPmjza8Hqdk5rnsiawo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 352bf833-b4bc-492c-1ec0-08d999b11b3c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 01:20:19.8266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JeYHuB+jkR5R04M03Vvmkk/mCjoZpw55EL1Fn94Hq7F42xnzF3EY3H9UvZEuoLrwwad6dmNQ9OQKaOCKPkj9IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3240
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/21 11:27, Pasha Tatashin wrote:
> On Wed, Oct 27, 2021 at 1:12 AM John Hubbard <jhubbard@nvidia.com> wrote:
>>
>> On 10/26/21 11:21, Pasha Tatashin wrote:
>>> It must return the same thing, if it does not we have a bug in our
>>> kernel which may lead to memory corruptions and security holes.
>>>
>>> So today we have this:
>>>      VM_BUG_ON_PAGE(page_ref_count(page), page); -> check ref_count is 0
>>>      < What if something modified here? Hmm..>
>>>      set_page_count(page, 1); -> Yet we reset it to 1.
>>>
>>> With my proposed change:
>>>      VM_BUG_ON_PAGE(page_ref_count(page), page); -> check ref_count is 0
>>>      refcnt = page_ref_inc_return(page);  -> ref_count better be 1.
>>>      VM_BUG_ON_PAGE(refcnt != 1, page); -> Verify that it is 1.
>>>
>>
>> Yes, you are just repeating what the diffs say.
>>
>> But it's still not good to have this function name doing something completely
>> different than its name indicates.
> 
> I see, I can rename it to: 'set_page_recounted/get_page_recounted' ?
> 

What? No, that's not where I was going at all. The function is already
named set_page_refcounted(), and one of the problems I see is that your
changes turn it into something that most certainly does not
set_page_refounted(). Instead, this patch *increments* the refcount.
That is not the same thing.

And then it uses a .config-sensitive assertion to "prevent" problems.
And by that I mean, the wording throughout this series seems to equate
VM_BUG_ON_PAGE() assertions with real assertions. They are only active,
however, in CONFIG_DEBUG_VM configurations, and provide no protection at
all for normal (most distros) users. That's something that the wording,
comments, and even design should be tweaked to account for.


>>
>>>>
>>>> I understand where this patchset is going, but this intermediate step is
>>>> not a good move.
>>>>
>>>> Also, for the overall series, if you want to change from
>>>> "set_page_count()" to "inc_and_verify_val_equals_one()", then the way to
>>>> do that is *not* to depend solely on VM_BUG*() to verify. Instead,
>>>> return something like -EBUSY if incrementing the value results in a
>>>> surprise, and let the caller decide how to handle it.
>>>
>>> Actually, -EBUSY would be OK if the problems were because we failed to
>>> modify refcount for some reason, but if we modified refcount and got
>>> an unexpected value (i.e underflow/overflow) we better report it right
>>> away instead of waiting for memory corruption to happen.
>>>
>>
>> Having the caller do the BUG() or VM_BUG*() is not a significant delay.
> 
> We cannot guarantee that new callers in the future will check return
> values, the idea behind this work is to ensure that we are always
> protected from refcount underflow/overflow and invalid refcount
> modifications by set_refcount.
> 

I don't have a problem with putting assertions closest to where they should
fire. That's a good thing. I'm looking here for ways to fix up the problems
listed in the points above, though.

And I do want to point out another thing, though, and that is: generally, we
don't have to program to quite the level of defensiveness you seem to be at.
If return values must be checked, they usually are in the kernel--and we even
have tooling to enforce it:

/*
  *   gcc: 
https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-warn_005funused_005fresult-function-attribute
  * clang: https://clang.llvm.org/docs/AttributeReference.html#nodiscard-warn-unused-result
  */
#define __must_check                    __attribute__((__warn_unused_result__))


Please take that into consideration when weighing tradeoffs, just sort of in
general.



thanks,
-- 
John Hubbard
NVIDIA
