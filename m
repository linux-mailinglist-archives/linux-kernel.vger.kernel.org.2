Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABCF0309C70
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 15:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbhAaNri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 08:47:38 -0500
Received: from esa1.hc3370-68.iphmx.com ([216.71.145.142]:24806 "EHLO
        esa1.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbhAaLbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 06:31:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1612092706;
  h=subject:to:cc:references:from:message-id:date:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Pp4U8aQAWkcr0hz5qUaaMSCSOfKtNu+fzejUVCwBPZk=;
  b=IB9AhkBl/oyDhkwVbaLnBM/dVxY2+y9oaV8v4uq6w+EhtBDFMG26LTRZ
   cmEZ7Fxpc/TaMvAuWzlXzpyaEaqvszWMVjMdgQCKmr+AXx/OWl3FmqDOY
   VHSuol+HhUPGAFOvnTrrYUETopd0KVJcBmaeBjLIOWhh7a57xFwrmw0u6
   0=;
Authentication-Results: esa1.hc3370-68.iphmx.com; dkim=pass (signature verified) header.i=@citrix.onmicrosoft.com
IronPort-SDR: A7akvDjExkyJCPO0MNIcaAUxxOLq3Y5o6ynNW53KV4pGr+NofxjRTY1rGJjbxuoTlvn3Evf3jg
 npYgGNY4UTYS9yVeKRGg7Xn6aqdX6C+nKITrb5x8+5cEPCIOs9CIghzqUnvOGGzj24nIxdffMn
 5hejfkl8t+eNrmFVYJBx0IpmV7oTJG83sCpoNEJUxNxFOoVfgrk3pcxhbF/uA5X3cS40dilhbL
 TJavGI/OGhpLoJfojoXmaSWfIg9CUx/1ciCxAc3ESEtrJdE/a9z9QOmbN4E9gIJl7mx8kO7wbl
 I9E=
X-SBRS: 5.2
X-MesageID: 36605780
X-Ironport-Server: esa1.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.83
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.79,390,1602561600"; 
   d="scan'208";a="36605780"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RPpd+4H4x+p7IjdXxM6ZYXnw43tMbtzw+kZLLPMx81fIeGQkeb5a4WPGMFRP9Y6UEZWgHB5ISIqrUx49iFD6sv1l+yT9O7MH6n+N3yGXr/nWrei45YG58SFirUpliYnVcLc1gDuh6cWWxeurkN9TwIEEdnPyyn16L1NID1P5RAmWtfBOZzfFEY/TGycrJeGhbhMrJEKBlhS7G+q0Fil+PIKgm6qzToDVMT/u21img+/B5lTBFl6HNxV03cuUuO5NU31DhO8EWSV3r8DWM3mXrOfu4Xt7bLZSpuwpOZHKzffxjzNGcIo32v3TkEkLWJkhmWeRqEi6Vhwk3cz+SsYY3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aDYUVEO8ZnEn/OWP6xDzjERKJNpJZHNoEPb4Qque+Yw=;
 b=ZD0QfCuY1O8xDqP2MgJ5Efvro27VRJ+3yqoAGGGY8fh1i8e0nGCPmumtUHUeKK8fmBg5QaV/8ACltW3ZKuItdyJuovbg1MbMsZVfSzSji9XxBeEONsQLrDGsZtdRyJ0orCOlJorH7FCVj+ACydZkvpB41bTAzcQWAKQeF8HptjxE/BM8hYysz1muyafGafFY2mGm88Clqpa+lxn0Ptnwf8JcyqE1K3stkCVckcDU00hqxPsDj9qQoGEYVfTu65hUBvpNyR8gHUuaElOyifaLiUOaTrV59gCKJowY/8wlP6D0skiNqM4aXuQ53f6jzpONAMFbBUfsKkvhQjl7vWod5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aDYUVEO8ZnEn/OWP6xDzjERKJNpJZHNoEPb4Qque+Yw=;
 b=ObqBAi+fXtGrDlItMPNXDjAjLh8ufgAEIilvnRkW1klkULkm1P1PZb6v48YZtpOrxa+UUusj1C79fS9ocM21b6P1DBG/CyzLXffXzra/peQkwT3wTprtGdzDkBr+CaqNUuhP4JLkTho+ilrudgR5M5wVkrEgUql2q0I6sG/5Dfk=
Subject: Re: [RFC 03/20] mm/mprotect: do not flush on permission promotion
To:     Andy Lutomirski <luto@kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>
CC:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>, X86 ML <x86@kernel.org>
References: <20210131001132.3368247-1-namit@vmware.com>
 <20210131001132.3368247-4-namit@vmware.com>
 <CALCETrWxyMsD5zEoaFS-aVfkV=QiVWa7pCU_JE3AYDEEU8Hqvg@mail.gmail.com>
 <68D3C593-A88C-4100-90E9-E90F7733344F@gmail.com>
 <CALCETrVnLe6wf+nD-PDfKQAmJhcQm674iCHPiEWW0kiDucqk9g@mail.gmail.com>
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Message-ID: <e7ed0b21-f63d-21fc-f519-cc2cf0d465a2@citrix.com>
Date:   Sun, 31 Jan 2021 11:30:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <CALCETrVnLe6wf+nD-PDfKQAmJhcQm674iCHPiEWW0kiDucqk9g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: LO4P123CA0480.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::17) To BYAPR03MB4728.namprd03.prod.outlook.com
 (2603:10b6:a03:13a::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9051119c-1042-4227-06dc-08d8c5db94d5
X-MS-TrafficTypeDiagnostic: BY5PR03MB5062:
X-Microsoft-Antispam-PRVS: <BY5PR03MB5062059A7E5D184D528EECDBBAB79@BY5PR03MB5062.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VPj6RJwj06GrH9cQ0zHiEo2vDwvYOi53S+WVpCBgvcObDM4BMu8/pHJYkayv4lttXwWuUKdBJUsd75Q+YlBEIOQsdGcONF3L3hjLE2a4D4WQi0qmo7foYn++jPnhW7P22ohLUliE2U9ED0R/I4f2Btm7Uym/gJVELvJjNIEf5CXCdldjDFTLOvlVCRWZl68Z3qTqnlh6R4n6zLdAbCxEVsXMqaxOZRdccmZlw8VIGFxHnXUgndU6x07d/WEHfz06tXWTBMoe5pUlHwtnQTWXdbyfN6iejzQ6//zlhU0bfYvAyu9NAnvwz+HaJB+9d60hMobkFX6T9ZGnRoqu5ztJwXMIN2SlpaYUmjgDUqSXXLALZM3TQzE+C1nXJERXXYV1ILUi6RhGa4XVUF7NQ7WYnkLq4gj+LE4hlMVYDVNBz+iSg0LTAg/kkr9bXWbRg6lQ/w4YENOrb4u6U0V15I4KaUlnnciv8kWZKsCF1j8kzFr0CQdAzy5+q3j5qxV275sPXwfJp7RbYP8SKGEFFtvMSb+tLeiL+dYXcBsyR8PWeF/zZFXLaMyW1XS7CEG63D0LmI+rLmo8nZLCwI3/rTVaIlUS9ryQUwrdpH4fy+QZNys=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB4728.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(39840400004)(396003)(136003)(31696002)(86362001)(36756003)(66476007)(8676002)(66556008)(5660300002)(66946007)(83380400001)(2906002)(54906003)(110136005)(6486002)(316002)(31686004)(2616005)(8936002)(956004)(4326008)(16576012)(53546011)(478600001)(26005)(16526019)(186003)(6666004)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?a1VsK3laVWovUitTUWFXR2tidEFUM1pOVnRpNjlJTTIzQXpiOVpUdS94WUds?=
 =?utf-8?B?ZkxSeVFoS3FzM3E4cWdENXdRdmJjMTNsaC9KeXhpdG0zU2ZCTWljYU1pcHlW?=
 =?utf-8?B?STM2N2VoQWYwbGxHdWQ2RjllMmhwWFBYU0R5aFpqeHRPMzFrbzczVVlPZVo4?=
 =?utf-8?B?QU9ZNy9sb3c1QWpvOFZHMzVMeUh1YlBISmVUVTVURnFaNHIva3A5SWZodVUy?=
 =?utf-8?B?cVliL1R5WU5kTDI3N0s4SnEwM2R6MUVqZ2JQYlNFSUtSd3FxR3U1eVN4OHV2?=
 =?utf-8?B?L0VIcUJWZmwyWGRVck5kV3JrVisxbEtxNXZKUDh6V1VZYXo2Y0hScEdZaGxn?=
 =?utf-8?B?akExS3YzZmp5emhwbXhnUlI4UVdFWGsrUDZQWjNnRjgzSGJoSkxQd0hLdm5G?=
 =?utf-8?B?QzBVUkVJMm5XL2dSR2ZDbXNuZWYrRVc4SjRQZGFjUlJCQzFlWVdaZURhVzZG?=
 =?utf-8?B?cGxnTTRlQzRRN0tveW5OZFZKNTRDdVliMC9SMVB2NUkvZU9HU1FnMTFRYWcy?=
 =?utf-8?B?aHRGYXE1T2hqVDJRdkMvOVlmYmpnVEhKRFNiZ085eW1NaFIwdXVIVEEvQUNU?=
 =?utf-8?B?amR1QkVOa2M3QnZMVXdWOGRoZkNxMlRHL0tUSGk4SWV4U1ZUTDlZRTBFUi9X?=
 =?utf-8?B?T2ZmMTdzY1VxbWV6d2JjN1J6ZGlqVDJRQzRkKzUzcU5ieTdTMmJtQUY2aUFv?=
 =?utf-8?B?MjNkWUR2MC9GNkI3Uk4zbXJabGRhT3hDQVEwZ2l6b2R4K2I2TTNFY2xtMWpa?=
 =?utf-8?B?cjlLRlJhZ0MvdVdPUGFhRXBPcE5TcFRsdW9Sb0dXU0o4K3JUblYwR3hBZ2xE?=
 =?utf-8?B?SzdaYlFiUnp5MGhhc1VQb2J1OEIzNmNQQkVwVnI0dTUzMkE2dk1lSE90K1lq?=
 =?utf-8?B?K20zdy9TOG1XSXFCTHV2TklMMWlZdVNMclk4aGhmUTl6RFYrTGxkbmIwZ28z?=
 =?utf-8?B?ZU9neEhWMHBXMmEwYk1YUlpnVjNuTGk5L1pTZTMzQUh3SVlVSHQ5T3ZZQUVZ?=
 =?utf-8?B?YWNSUjd1alhNcHZtQW9FQ0Q3Qkp2WWZlYjZOY1RlMW1tekExd0RPNks5bWE2?=
 =?utf-8?B?cFNtWURPQVcrMUlZSUhBN0tLRkNaTEhwVy9HMDZLK2JHVEY4b0Fka09uZ2w4?=
 =?utf-8?B?OUEwRERoMXpDN0Zuc2pIVlRsMzU3aElyRk9CbkNZK3lkMUhEeFRFSE5xWW5S?=
 =?utf-8?B?Ty9mS09mUS9tTW1XTy8xQ1NZUC9zQ0VzUVNrbUh4eEJYbTd6MjNZVzZTQnpp?=
 =?utf-8?B?SXlQcTRoeU8xSTQyMU5RZTFGaUo5bzJ3WndGa0tpYzJDMk41WTdhUXMrdmYx?=
 =?utf-8?B?cklSTjBXSDRaYklCYWhic3luQ3hoYWl3U2hJZWlIRnhMak05MHJDVXlydzFT?=
 =?utf-8?B?UkM2UVFhdGtFQzhSRE1zVUoxandwT1B6bmlkMWVmNnFGN1lYQjZja3JUUkM5?=
 =?utf-8?Q?ib7oH7FQ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9051119c-1042-4227-06dc-08d8c5db94d5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB4728.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2021 11:30:16.0762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jjhtwOXrs97PYqZKTm1D5LqN0BPHHH/aZGwKOSXXDn/e+YgQNHlA+GC3/0u1wkloBifXUvBBe4jygDFhI2XGZXvEUeHVwm9lA03H0HIBrz8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5062
X-OriginatorOrg: citrix.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/01/2021 02:59, Andy Lutomirski wrote:
>>>> diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
>>>> index 8c87a2e0b660..a617dc0a9b06 100644
>>>> --- a/arch/x86/include/asm/tlbflush.h
>>>> +++ b/arch/x86/include/asm/tlbflush.h
>>>> @@ -255,6 +255,50 @@ static inline void arch_tlbbatch_add_mm(struct arch_tlbflush_unmap_batch *batch,
>>>>
>>>> extern void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch);
>>>>
>>>> +static inline bool pte_may_need_flush(pte_t oldpte, pte_t newpte)
>>>> +{
>>>> +       const pteval_t ignore_mask = _PAGE_SOFTW1 | _PAGE_SOFTW2 |
>>>> +                                    _PAGE_SOFTW3 | _PAGE_ACCESSED;
>>> Why is accessed ignored?  Surely clearing the accessed bit needs a
>>> flush if the old PTE is present.
>> I am just following the current scheme in the kernel (x86):
>>
>> int ptep_clear_flush_young(struct vm_area_struct *vma,
>>                            unsigned long address, pte_t *ptep)
>> {
>>         /*
>>          * On x86 CPUs, clearing the accessed bit without a TLB flush
>>          * doesn't cause data corruption. [ It could cause incorrect
>>          * page aging and the (mistaken) reclaim of hot pages, but the
>>          * chance of that should be relatively low. ]
>>          *
> If anyone ever implements the optimization of skipping the flush when
> unmapping a !accessed page, then this will cause data corruption.
>
> If nothing else, this deserves a nice comment in the new code.

Architecturally, access bits get as part of a pagewalk, and before the
TLB entry is made.  Once an access bit has been set, you know for
certain that a mapping for the address is, or was, present in a TLB
somewhere.

I can't help but feel that this "optimisation" is shooting itself in the
foot.  It does cause incorrect page aging, and TLBs are getting bigger,
so the chance of reclamating hot pages is getting worse and worse.

~Andrew
