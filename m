Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE62230ABA8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 16:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbhBAPkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 10:40:39 -0500
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155]:63429 "EHLO
        esa3.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbhBAPkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 10:40:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1612194003;
  h=subject:to:cc:references:from:message-id:date:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yG+7p6mu7TVfBJ9SLWRYbLGUyfTgQb278/0jMMGowqY=;
  b=e4T9GtStULYhGhj7ze6roCbRRpszifYlhPzR6OE8C1u3ZGmlkUp5DyX5
   wE28lpy6R6I5EToqUXeGIn8boum9qkK1NTRETtU+O3n4f1abXaYy5LmU/
   LnypFUl5iRBAd4HO0Affg1cv8UpF1aPHCFBTrHJjjBSSHV16WwMBMIkqH
   8=;
Authentication-Results: esa3.hc3370-68.iphmx.com; dkim=pass (signature verified) header.i=@citrix.onmicrosoft.com
IronPort-SDR: Xd5GkA2PCy5dSuPtBiw8j2rOyhlJP6TUta1/UZWckqq7NLNEpSgypNd6ERDDFdsGt6kzWx8hkk
 b3+923+9m/KEhICQM3j529DftTjPNoSdakIZKfFwpDEvwzxgw+vo3kV87pCFrQpjt8WT2Aq2YO
 OrwEkFYiSB/aWTH9b8h0cBEJ0AkLUtVbh48qHatZW6NQBDOmmOtO8x5/KndA0Wr8LMAn3xSj34
 2sqqfHNzf0Ce8e/idEMKqqBQDMC9dlhEUiSvA6Z7MJ5t8CpECFbHS9dJqwsZ10h7IT6nrpGQz+
 4JA=
X-SBRS: 5.2
X-MesageID: 36284328
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.83
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.79,392,1602561600"; 
   d="scan'208";a="36284328"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eQgKdUbhas4LR7GP83tNlvioKhdNQA1f5OBj6/1oZJyiOfltPSyWOAmK3jsJiy6meF3+7S3QCQVokxWrqn0kYymWp/r8ERmdJYbQRNwe4hnJBirAc8VO/OCKvmGz41Yb29KREiTBIQbqhpFqdGmV3wT+8XdwLYmNzn2X5ZCCboZpHZ88swrOqiXE17bt96TBwdax3oRgG1+gyKBxs02rsGtotlGq5z2Yt1WyVRpbCDcwdcnEsUxSlPFrJ347xFzH+Tz7V5pXQx5G0SQ/iKrUCZR6Tdos06SH0jDbSWKfzZppE54NGlKr65YbdBh8FJIFXPZS2rksuEZVCXLOSmlATw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IS7Dp5lrBEMf8PlBBtT2fd4tDeuXlq4tJdVadPkwEoY=;
 b=LWWfNCDzTlxAFVDNB2C4CIeVW1yc1+nEzeuLahGAvWzjAeLSmSRpQ6Vv9l5uM9RkiUstJs8inArd7X1HwQ/gH2NX6prOcaNwdGut+vjQb+a92Suhct/Tji+PWY0R0bKzWmUk+cpIlFQdB2h1XSvtAF+4or90SSbwTXvZQ0O2BPhAR4yRz/v53eDf+yiBfyrC+pM05hDP4Pat516NnXbdNRHTgKYiq6NvLM75cbI326lPY2Sq6yV8L+KuOR8ihRcVtESW0XdopXYhYHxZ6Nz/D9wZ/+CFp7wbpYeqvDy9RfA16CMIotnWvQ7RQXXA2XvvIa+98wfY7NxMCm738ergzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IS7Dp5lrBEMf8PlBBtT2fd4tDeuXlq4tJdVadPkwEoY=;
 b=wDC+0/EzZzpJC6nmXM30pT4jr1ZW8dBghytgneRAPRAeOPSisE97wD4mjWQyxluppHfnbolAnIjQnWQNd1YO7H9LGcJ1jJFgwjZ23j0WXedRwZNMRpS4K7lykoXJ4eUxgYvjPYMNvV9eZ6cL7DTGJaG/dKnzlYTKOGtf7MAuehs=
Subject: Re: [RFC 03/20] mm/mprotect: do not flush on permission promotion
To:     Nadav Amit <namit@vmware.com>
CC:     Andy Lutomirski <luto@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>, X86 ML <x86@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>
References: <20210131001132.3368247-1-namit@vmware.com>
 <20210131001132.3368247-4-namit@vmware.com>
 <CALCETrWxyMsD5zEoaFS-aVfkV=QiVWa7pCU_JE3AYDEEU8Hqvg@mail.gmail.com>
 <7a6de15a-a570-31f2-14d6-a8010296e694@citrix.com>
 <B24BAD2A-6641-42E3-9098-3A41AA39D417@vmware.com>
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Message-ID: <c9f963fa-076e-2504-c001-da69315d3732@citrix.com>
Date:   Mon, 1 Feb 2021 15:38:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <B24BAD2A-6641-42E3-9098-3A41AA39D417@vmware.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: LO2P123CA0063.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::27) To BYAPR03MB4728.namprd03.prod.outlook.com
 (2603:10b6:a03:13a::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db715d8b-22d9-45db-3d9b-08d8c6c778ff
X-MS-TrafficTypeDiagnostic: BYAPR03MB4582:
X-Microsoft-Antispam-PRVS: <BYAPR03MB4582F151BD44CD68B26999C5BAB69@BYAPR03MB4582.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TW0JyUW9vH/FN0a1WPQp/i65GRIAU8zw5buH72wIb/w4hQzIryn629dvgC47jEI08sFWk87JgJ2ALnrdNYsQhHzDG7GwLvQGrqqtyCuY8GWfKpk5YenyNRTF5SKl/4TZRzBIPJdla69g80SdgTeaoNP3sOXmcd3cTxrBRVjh+MtjGvOokyXPjmIg6WUWrkYtKQEpQQydzrDZTDHiAKBTFJ5sReF5jH4taMEs0pyN75yCsnpI9xU1IWfDmSErAzuko5dcN8kWM2rZaCqvOKw/BKc059w6jzHtRmwXLh/vsLd4zSEx5s2eMA1ghYkVlK4mw5l8LIbABsozOLF+D14y3w24B61d0pA8XHuWK9DIOwLzGzq5nXLaCJHpxO+Xt/lGCh4fA0Buj93QOInJ0U9K1o6EgDQfQQJ2m32U3QuZSYM5llLFOfX04BcoUd9X0UBk07QorbteIm4Gpa60luEHmxgbRS3lVMLurr0+HjaKA2eUSikrzrcpPsZVWy/7WIG1Psk2c5jCSE1RuIQrLHfIVA6Khs7LNxV6DXEUOaW5xebw6f/RToW7a6jJhtXqB/xjCCvIkJoEMf2u8/hq/3PDUNOBUsEQugmcyJitV9xje1E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB4728.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(39860400002)(376002)(366004)(346002)(66556008)(66476007)(16576012)(316002)(4326008)(2906002)(66946007)(6916009)(8936002)(7416002)(6486002)(31686004)(31696002)(54906003)(86362001)(478600001)(36756003)(83380400001)(956004)(53546011)(26005)(16526019)(5660300002)(2616005)(186003)(6666004)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RlNmUjVsU3J4ZDZnUW13MEwzWWFCV0h3VUZubXdCSlBvV1E0N0QvRmFBdlVO?=
 =?utf-8?B?Yk1jYUVOeGtCRG5EOUxFeG1yRTlmNE05YmxWT0d1Mmo1ODVNdndJTEtVMGtK?=
 =?utf-8?B?NS9DL2FycCsrSFNwRmhiOGJwdW96c0FEK2RqNDlTV01kKzlySlZpVHdqQVJH?=
 =?utf-8?B?eFFUcWZGelVjTE9hYzFZMXp2SGZtVWUvN0pXVWNBeWlFTCtROFJtTW9DdHhO?=
 =?utf-8?B?dS9Bck9OZXZubWdtR1FvTHBzWll1bU9VNGlwdHRmd1ptUXpEYXlKaDlOWGpS?=
 =?utf-8?B?MWNVMlNjcXFsa1hZQUFsdnZ0WEU5RVJmVzdoNkFiSW9oQjQvcG9KbWFMK0ZV?=
 =?utf-8?B?Y1QySVlqTnVYOVVtc3RJWU1CRlYrWXpqTGVhV0dob1VCNzB3QlhJejFTOUxv?=
 =?utf-8?B?TDdacTk2RjF2N3JtUHNEakZCL3VwQ0luSHVnckU1UXhOZ1hFMFlFK29OaXpo?=
 =?utf-8?B?NTdRbFN4M3RISTRwekJJNHhNdm5ZRmt0Y2t3RWVtMkhOekgvaXNMOEc2MWM0?=
 =?utf-8?B?clh1Um9SSjZ1OG82UVZOZFhlRWxDVnZ0bGlNanJ5VzExMFE2MGNLOG1jbGZh?=
 =?utf-8?B?Nm9mM2l4Z09DZmhnV1R4MnRSOHU2c1dzT1JHSUttQXR3KytxaTRTeGtUNTF0?=
 =?utf-8?B?Qm10Zlo3N3dtK2NTanA5a1RkamhaL2VYVkRLd1NpanducHBiMFBVd282L2U4?=
 =?utf-8?B?NXZSTzYxdE5aTnVzOXdyQXllTUlKeHJjRVNTS1J4RnptWFd2Q1ZaeE1aeHc4?=
 =?utf-8?B?L1BEV1hMbS9UODNUTkl3MSs4dHpxQkpuZytFRDcydkpFZVRZM2hYdk5xd1pz?=
 =?utf-8?B?RjNaUjN4S0RRay9IbEYvSjJVTGUwam1RMzdaaWtmT0hVRWltTlNrNGU3TDhz?=
 =?utf-8?B?RmpCaUttSHoxZnJYNXJ5aTJiOUF0ZkIyM2FhbmxlRis4TzJmZTh0VDlNc1pz?=
 =?utf-8?B?d3JXY2h1Vko3WFhqbkZTaU8yZWU4ZUtxd2ZqNEE4di92cVpLL2FRUXlXSmlN?=
 =?utf-8?B?ZWxLd0w3ampZSFgveGFpYlF4amsyRmMxN1AwbVp3Q2tBMzJzUzM3eVZpZGpi?=
 =?utf-8?B?dEVudFFHV2dZRkp4QzR5OHpWWkFaQnFzSTg1aER5eEJReGhldSt4dzdsTWU1?=
 =?utf-8?B?UlozdXFMMnNhMGxEeTJ2M2xRS2lzdVdUYi9RajB5b09ldEk2b1ZCcjRkbTIz?=
 =?utf-8?B?VHBUZllyWUQ5M3Z0N0M5elg2NWpFVnhxbWx1ZjI4MU11RlV0Vkg5ejhyTHJa?=
 =?utf-8?B?WVVsQTI4cEpSRnFnYjFHMTRDYVAzVUpoK3dmbFNRVUMxQTZ0M0M3Y1pMSU92?=
 =?utf-8?B?VEt2VmJvcVlpdE5SQzVES1FlVlEwNG5BQ3M0Q2ZKakcramNocTJZckkzUUNF?=
 =?utf-8?B?SjQ1bStwMkViMFU4VTZNb1BHVDczb3UzVjdMcjZla2FlcVpCQUtVYXRJeUpN?=
 =?utf-8?B?SThzcUpTK0IxTFRHWVF1MDg5NCt6S2NaTTJDV0dBPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: db715d8b-22d9-45db-3d9b-08d8c6c778ff
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB4728.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2021 15:38:50.4909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KLuvEInNvnphFZQjsZSTq8XYkWi+37LHVB9KF3uNFb+l8qvu5GziAPWgOAAH+WRuaOUcXJp6R4iNJQ16B5xbc8aCV+wcmoPDNREtO+h6TDI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4582
X-OriginatorOrg: citrix.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/02/2021 05:58, Nadav Amit wrote:
>> On Jan 31, 2021, at 4:10 AM, Andrew Cooper <andrew.cooper3@citrix.com> wrote:
>>
>> On 31/01/2021 01:07, Andy Lutomirski wrote:
>>> Adding Andrew Cooper, who has a distressingly extensive understanding
>>> of the x86 PTE magic.
>> Pretty sure it is all learning things the hard way...
>>
>>> On Sat, Jan 30, 2021 at 4:16 PM Nadav Amit <nadav.amit@gmail.com> wrote:
>>>> diff --git a/mm/mprotect.c b/mm/mprotect.c
>>>> index 632d5a677d3f..b7473d2c9a1f 100644
>>>> --- a/mm/mprotect.c
>>>> +++ b/mm/mprotect.c
>>>> @@ -139,7 +139,8 @@ static unsigned long change_pte_range(struct mmu_gather *tlb,
>>>>                                ptent = pte_mkwrite(ptent);
>>>>                        }
>>>>                        ptep_modify_prot_commit(vma, addr, pte, oldpte, ptent);
>>>> -                       tlb_flush_pte_range(tlb, addr, PAGE_SIZE);
>>>> +                       if (pte_may_need_flush(oldpte, ptent))
>>>> +                               tlb_flush_pte_range(tlb, addr, PAGE_SIZE);
>> You're choosing to avoid the flush, based on A/D bits read ahead of the
>> actual modification of the PTE.
>>
>> In this example, another thread can write into the range (sets A and D),
>> and get a suitable TLB entry which goes unflushed while the rest of the
>> kernel thinks the memory is write-protected and clean.
>>
>> The only safe way to do this is to use XCHG/etc to modify the PTE, and
>> base flush calculations on the results.  Atomic operations are ordered
>> with A/D updates from pagewalks on other CPUs, even on AMD where A
>> updates are explicitly not ordered with regular memory reads, for
>> performance reasons.
> Thanks Andrew for the feedback, but I think the patch does it exactly in
> this safe manner that you describe (at least on native x86, but I see a
> similar path elsewhere as well):
>
> oldpte = ptep_modify_prot_start()
> -> __ptep_modify_prot_start()
> -> ptep_get_and_clear
> -> native_ptep_get_and_clear()
> -> xchg()
>
> Note that the xchg() will clear the PTE (i.e., making it non-present), and
> no further updates of A/D are possible until ptep_modify_prot_commit() is
> called.
>
> On non-SMP setups this is not atomic (no xchg), but since we hold the lock,
> we should be safe.
>
> I guess you are right and a pte_may_need_flush() deserves a comment to
> clarify that oldpte must be obtained by an atomic operation to ensure no A/D
> bits are lost (as you say).
>
> Yet, I do not see a correctness problem. Am I missing something?

No(ish) - I failed to spot that path.

But native_ptep_get_and_clear() is broken on !SMP builds.  It needs to
be an XCHG even in that case, to spot A/D updates from prefetch or
shared-virtual-memory DMA.

~Andrew
