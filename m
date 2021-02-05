Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 786AD310AF6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 13:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbhBEMQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 07:16:09 -0500
Received: from esa5.hc3370-68.iphmx.com ([216.71.155.168]:5674 "EHLO
        esa5.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbhBEMJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 07:09:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1612526975;
  h=subject:to:cc:references:from:message-id:date:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aSnjmMbhsgy/UYSm5oLB6HGGHkLrdVSLsHnSBhngVDM=;
  b=Loz6pV0JICgcq+3JPzTnO14R7T1tUGwTLDUBrb4x8o7NtSvIeEvVmBHU
   CvJSCQPml9tj+yIk8BEzfsE07M1PTWYAvIkYXOwCKANXaGT8I5tBCP6r5
   oOxALOS27Xbu9MN3z1YD5oEqu1KwcpOsLQmfB3c9UjKcBoVa3sG1cLPVj
   E=;
Authentication-Results: esa5.hc3370-68.iphmx.com; dkim=pass (signature verified) header.i=@citrix.onmicrosoft.com
IronPort-SDR: lyBbySM7E3QO9jZSgVkoyDwpVcSTUkQNFY0lH4f2DnvRWZSe/OkqFOHcAU0r8Yv6nCOu7U8fRN
 DDVFxStt7O+FpK6ibzjL4QQ2GO4j7nZt6Hkq4ZhKwo0r4pIC4wr6K0apIa2SXruqrp/i94G/GJ
 JiP09JQFnqKutNWOZMPRZ7ch6LKkA86ARaEuQ8fuJTuvJB3eBCYSesM/9tk5927qpxxAF+OE7Y
 HRc8z1A+fSoA7zBRYgXi+pT+E37Yuav7JrTqzUSu1e8Zw1taxltKqWuoyXJ4av4tTIbwkblo9R
 8Hc=
X-SBRS: 5.2
X-MesageID: 36587916
X-Ironport-Server: esa5.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.83
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.81,154,1610427600"; 
   d="scan'208";a="36587916"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S5wDrWOjn0BlhQAsxWNLT9UFiKw4cJ6AIoSdRaVWdmrNsm05Ovf/a4G9RsyAcJ15U/TYiyEE565VMrDbmWQ/D/hnL13jFn517XrCgRuHibsEEddwN1PdoBrVI66Zhnuik/TDlwMdD53Pnnf7S0gN4/qO4KWgzRa5l3ul9jkAjFD+6olT2Gd8x4SnvJp7aYXBAEXfIA0yjCjLpncPw6SiynxZLahbkYGBHFM87uOvKGh+0OSd8g1sZN3YvnsRJy6NC+aJqtRCqmSfVKbs4qMJMElRm5vIEd5BWly/7tRtUQlVf0qKIsetg4ejnGMzHq3cAOCn31vVtuCkIZ3hvIwhJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bO1UrkrfJerHd//jorp3x3WAk+hvNGSVxkSZnpNfgFg=;
 b=HUs/UbQEfFUr3J3kd9Ol9kyU9r/S4d9UygRYgQ4t1cyph0CjGJrar8HJYCQajyvgdUXCKeAR1kneDLH9nIiHg5Iy/SwcugnGDUQ+o4cfV139sfp0Is+zbprcCJ2qS1LvVfcwxqim/eLkgL3bGDwwhXiPDOaTlDfOdy9jkQEVY9uGCjZi1l8pRFOzqS+lnGPASXXqHNj/avLxT5ui4OvnX72RSSd+OfcCzPVRHdLj/IV1vhttr1qF4QvjYqVr0wYkrQCQc7YSGXCvS6eHiaOBiVbhmFQVa45oem+O4Gj9087suby5MtRUyCNABq47ZZlc1x9nWlFLsBFdn9TPoyOtHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bO1UrkrfJerHd//jorp3x3WAk+hvNGSVxkSZnpNfgFg=;
 b=M27x58JaBWSdd0+YmTRGZx+lltyOR/ovuSYVmuzKxUwJnO+MA3mkjtMAdO0F8QPBnDz6fq/hRSScmGhOV6G85bOuw2UzLirgqa4xuWS8nKiDPkwgZZWbnpFH1VawRleEjvUfUVE9kmZ1/N/ygJL9bG45C7/jGiacdxk//YxfTfk=
Subject: Re: [RFC][PATCH 2/2] x86: add extra serialization for non-serializing
 MSRs
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@amacapital.net>
CC:     "H. Peter Anvin" <h.peter.anvin@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Jan Kiszka" <jan.kiszka@siemens.com>, X86 ML <x86@kernel.org>
References: <20200305174706.0D6B8EE4@viggo.jf.intel.com>
 <20200305174708.F77040DD@viggo.jf.intel.com>
 <f37ecf01-3167-f12e-d9d0-b55c44b80c29@citrix.com>
 <CALCETrXMhe3ULF9UDc1=8CKVfKqneCxJ2wYmCdKPpntkkMNGWg@mail.gmail.com>
 <YB0XonRIr1GcCy6M@hirez.programming.kicks-ass.net>
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Message-ID: <6d6549e3-f85a-236c-4845-d54c068e3672@citrix.com>
Date:   Fri, 5 Feb 2021 12:08:04 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <YB0XonRIr1GcCy6M@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: LO3P265CA0012.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::17) To BYAPR03MB4728.namprd03.prod.outlook.com
 (2603:10b6:a03:13a::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8f0efe0-121b-48c3-1960-08d8c9ceb555
X-MS-TrafficTypeDiagnostic: BYAPR03MB4662:
X-Microsoft-Antispam-PRVS: <BYAPR03MB466252796556DDDE67F61224BAB29@BYAPR03MB4662.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GFPtssSMBlpyjS3uBLywVbpSau3Y6t66d/nxDtYlH5YSxytbsf1V316SSywyyyvIidwthq+Q/KVlFQdhOnkCfG6uQXMIOP7Yf8e+7yTVrohrXM0qioYnX6WszxAg2gg//5/jjThN2rh/FARGlmA+Lngni1rvp9WtF8v7jILHBLWRT1z4dSM59VrCk6M0sweOGV3OQRQNi94BbtMgKfohrkx0dCiqrrCtvbOXDBlxLVmqL7fjdsMlFdIuyINtMMHhSIoTSRtbIMFapIjS+4JYfhK59i6D/Gz+umquD2p8IesRHHHp0nKiCyUFsSYguO0G2UnjBxVhvp5qMr7o64cYFX1OGlHnimFBXDWhtIZnydpc2FFjMvpI0DgFhQULxZ2TlLkAeE6PCTErSk13i9VPzx0fFqJxuSOk5LXlE/nAOCLHfxzzYMW+lxJeh0lX6r1zG7oQs2gvSnfPqiVEmVq5r4qN2Cy6UGUJquDm4SLR2nP9NbyE2LcI6AsWKmoZZhWCsmRsz0XUVP9wlqGaxUPVXdoy5W2Xyh+U9h3XqUhAcRfTvjvCMYFn496YnLM8zZlMFRlb8qyPfJs7ibq1/9H6MMNGQOqjmKrIFARI0dHOqY0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB4728.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(136003)(366004)(376002)(16526019)(8936002)(8676002)(2906002)(186003)(2616005)(956004)(86362001)(4326008)(31686004)(6666004)(26005)(66946007)(53546011)(110136005)(6486002)(83380400001)(31696002)(36756003)(5660300002)(66556008)(478600001)(66476007)(54906003)(316002)(16576012)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eWJESFV3ZEdXWGNMV1BxQW4rYVBoemtKaXEwd3BHUjlBSkE3bUFsR3VGWTdt?=
 =?utf-8?B?TTlRNGFBdDRDMStOVXdyRFdDQlIyTmtzNCt0SXlDd1lwRmFrZ0JNTzFZNTdl?=
 =?utf-8?B?bU1tekhRaGdoZEJGYWp0S05OYnpzU1F5U3IxbkgrRGtRVnMzNU1SWnUvcitI?=
 =?utf-8?B?UGUyVnExWmxQOVp5VHp5SkNBVkhGQkthaDdadHdDT2E2TTJHcmlMRG50VzQv?=
 =?utf-8?B?T0kwK1BhbFBXUWxoL2VoaFEvZFFtOXRLV3VtenVrMUp6d1VQWTNhZnhHSmRE?=
 =?utf-8?B?VTczaWlHa1I0WlhKNEpLelkrNWZKN3ZhdlVHSUtxRENyUVVmZHlocHlGd2tY?=
 =?utf-8?B?RjBtUGs5SjhDdmxBaTU2WDYyOWRZejQvZ01QVDN6KzQwSjRvSC9Jb21uUGpq?=
 =?utf-8?B?YWxhOWYxL2Q2SnEyWXdhTk9VK0EyVmttRVc0dUJ1aVhuZEdZOHRiM2ViVElW?=
 =?utf-8?B?VEcrQWR5NzB2NllDeHhCaG9oQ29RNDNTekx5U2VNalZ0Sm1PUXZ1OHpzemx1?=
 =?utf-8?B?ekdUemJBaG13NmRmbFp0eldkQlRHRzlYQUdwaU5DL2x5d1F5cndpRDF6UHpI?=
 =?utf-8?B?WlFnT1J0eVhmOGxyYmNGQ0JwQlc1RnVUN2QyYWlESTcwbDFNTTZXWE9tUmlx?=
 =?utf-8?B?ZVFoK2QrNlBTTWUrQVFzc01XWVJFclZXdURSL1Vwdi9UQXRRZWkrbVliNTJH?=
 =?utf-8?B?Y05XcUxVZS9nNGs1NEo0dlhidnVycFhGNTdVa2JGOS9ZWlRvZlphUnZuTjRl?=
 =?utf-8?B?Qy9RQlBMd3VZUFVXdmE5cjFUeXBLZklBQXZPdDFqVkd2M3pzR3Z1RGkzdkxD?=
 =?utf-8?B?ZFdzT1Y0Z3hha0tLdHFUNGxUT1paTEZYQ1BFS1JtYnVtMXczOUJLT3BFQ1F6?=
 =?utf-8?B?enlxcCtRZ2lsYkdjcDZWRnU2aHpDdXFqYSs5cXljOFlFUVZObml2K2U1YnFm?=
 =?utf-8?B?djgrdVc2cTE0ZjV2ZHppYUl1dDFjNzZYT0VwV2tXTDZwdmxaUkJPYTRFNlRP?=
 =?utf-8?B?R2tzQnZHK0o2NVlYSGNiWXB6RWxWUzIzcXQ5UFI4TjMrU2lCbUR4a09lL1Rr?=
 =?utf-8?B?S2VlYUlQNXcxL01zazNIYTZ5SVloVUMxTElNMzYyS0pnNHp1OXIyL1lnRWJL?=
 =?utf-8?B?YWluUnNlRGd4bjBpK2FvZW9iOEhJbTY2a3BTM3Zxb3JNcThwTWViQ2k3ZWlC?=
 =?utf-8?B?TmpMYk5BV0o4bnlnTStEdHJWTHhUOG01T0xBZ2gxR3RJTC9zWjlHNGFqR3VZ?=
 =?utf-8?B?dkNLSkNIYWhXemN4M1FtaXFYVGZITmJLaEFZaTlJYlNUSCs5blNHYVovT1pF?=
 =?utf-8?B?UXBjUjc1cW5DYlFkSzJqQ3U2S3FycGd2dUk1M3ByTE1XYWpHR0xhZ1pQRnZy?=
 =?utf-8?B?M2tkYm05UUVOc0p4WnpJY01qN0dyQlc2WDhoM2tKaGJnbk5GcE1idnd0SEJG?=
 =?utf-8?B?L3NSTnl1L3JCR2pLTkgvTmNDc3AvbXd0ZU1VUWRnd1hPd3VORFYyZXkwbGR3?=
 =?utf-8?B?ZWRmTTR0bWIvS09RdTNjK2owdzFhRXl5WDJLYUR6bWNWTCtQeFZScElOVDFL?=
 =?utf-8?B?N3BQakRaMTVNN2RFd0dFa3pWa1V0a3JlMVZrWFpxQVNvUHh6N1pTOHFTL3Nl?=
 =?utf-8?B?RlIyVDlwVFFpQWsvZC9pakNHTkxxRnowVjVRRzI3U0ZtK3czSmRXUmJkeDJ6?=
 =?utf-8?B?Zzh3aUlucEhhU2NxcThQYkVuWUNzWVlMeFJJZTRVU3k3VUtSV2VGQkNjRUhK?=
 =?utf-8?Q?mKG46Fib2chMXlYKhmn9+rNcUyrkJqfphZ+iIfy?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a8f0efe0-121b-48c3-1960-08d8c9ceb555
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB4728.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2021 12:08:11.6943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M/9K+FvK4vuxvFjHzTOgkg6eXKaVOlrsksf1KBJ1WClEKl2ZasjqJ0yJxCs/MHU9JfddbkM7iItoUnh2miEEc1i1ANbjxmlcHqmtxQ+/BY8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4662
X-OriginatorOrg: citrix.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/2021 10:02, Peter Zijlstra wrote:
> On Thu, Feb 04, 2021 at 04:11:12PM -0800, Andy Lutomirski wrote:
>> I'm wondering if a more mild violation is possible:
>>
>> Initialize *addr = 0.
>>
>> mov $1, (addr)
>> wrmsr
>>
>> remote cpu's IDT vector:
>>
>> mov (addr), %rax
>> %rax == 0!
>>
>> There's no speculative-execution-becoming-visible-even-if-it-doesn't-retire
>> here -- there's just an ordering violation.  For Linux, this would
>> presumably only manifest as a potential deadlock or confusion if the
>> IPI vector code looks at the list of pending work and doesn't find the
>> expected work in it.
>>
>> Dave?  hpa?  What is the SDM trying to tell us?
> [ Big caveat, I've not spoken to any hardware people about this. The
> below is purely my own understanding. ]
>
> This is my interpretation as well. Without the MFENCE+LFENCE there is no
> guarantee the store is out of the store-buffer and the remote load isn't
> guaranteed to observe it.
>
> What I think the SDM is trying to tell us, is that the IPI, even if it
> goes on the same regular coherency fabric as memory transfers, is not
> subject to the regular memory ordering rules.
>
> Normal TSO rules tells us that when:
>
> P1() {
> 	x = 1;
> 	y = 1;
> }
>
> P2() {
> 	r1 = y;
> 	r2 = x;
> }
>
> r2 must not be 0 when r1 is 1. Because if we see store to y, we must
> also see store to x. But the IPI thing doesn't behave like a store. The
> (fast) wrmsr isn't even considered a memop.
>
> The thing is, the above ordering does not guarantee we have r2 != 0.
> r2==0 is allowed when r1==0. And that's an entirely sane outcome even if
> we run the instructions like:
>
> 		CPU1		CPU2
>
> cycle-1		mov $1, ([x])
> cycle-2		mov $1, ([y])
> cycle-3				mov ([y]), rax
> cycle-4				mov ([x]), rbx
>
> There is no guarantee _any_ of the stores will have made it out. And
> that's exactly the issue. The IPI might make it out of the core before
> any of the stores will.
>
> Furthermore, since there is no dependency between:
>
> 	mov	$1, ([x])
> 	wrmsr
>
> The CPU is allowed to reorder the execution and retire the wrmsr before
> the store. Very much like it would for normal non-dependent
> instructions.

Execution, sure (for details which don't escape the core, just like any
other speculative execution).  Retirement, surely not - it is inherently
tied to the program order of things.

Causality would also be broken if the WRMSR retired ahead of the MOV,
and an interrupt were to hit the boundary between them.

> And presumably it is still allowed to do that when we write it like:
>
> 	mov	$1, ([x])
> 	mfence
> 	wrmsr
>
> because, mfence only has dependencies to memops and (fast) wrmsr is not
> a memop.
>
> Which then brings us to:
>
> 	mov	$1, ([x])
> 	mfence
> 	lfence
> 	wrmsr
>
> In this case, the lfence acts like the newly minted ifence (see
> spectre), and will block execution of (any) later instructions until
> completion of all prior instructions. This, and only this ensures the
> wrmsr happens after the mfence, which in turn ensures the store to x is
> globally visible.

I understand that "what the architecture guarantees" differs from "how
parts behave in practice".

And I also understand the reasoning behind declaring that MFENCE;LFENCE
the only architecturally guaranteed way of ensuring all stores are
globally visible before the WRMSR starts.


However, what is missing is a explanation of how it is possible to build
a causality-preserving part where those fences (for plain stores) are
necessary in practice.

That sequence is a large set of pipeline stalls in practice for what
appears to a problem in theory only.

~Andrew
