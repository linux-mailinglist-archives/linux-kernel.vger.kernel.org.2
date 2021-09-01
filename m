Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0943FD047
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 02:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241430AbhIAAYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 20:24:06 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:41340 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231249AbhIAAYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 20:24:04 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UmncIwp_1630455786;
Received: from C02XQCBJJG5H.local(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0UmncIwp_1630455786)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 01 Sep 2021 08:23:07 +0800
Subject: Re: [PATCH 05/24] x86/entry: Introduce __entry_text for entry code
 written in C
To:     Peter Zijlstra <peterz@infradead.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
References: <20210831175025.27570-1-jiangshanlai@gmail.com>
 <20210831175025.27570-6-jiangshanlai@gmail.com>
 <20210831193430.GL4353@worktop.programming.kicks-ass.net>
From:   Lai Jiangshan <laijs@linux.alibaba.com>
Message-ID: <75312407-36e9-b3da-f7a3-0aabe09ed1ae@linux.alibaba.com>
Date:   Wed, 1 Sep 2021 08:23:06 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210831193430.GL4353@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/9/1 03:34, Peter Zijlstra wrote:
> On Wed, Sep 01, 2021 at 01:50:06AM +0800, Lai Jiangshan wrote:
>> From: Lai Jiangshan <laijs@linux.alibaba.com>
>>
>> Some entry code will be implemented in traps.c.  We need __entry_text
>> to set them in .entry.text section.
>>
>> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
>> ---
>>   arch/x86/entry/traps.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/x86/entry/traps.c b/arch/x86/entry/traps.c
>> index f71db7934f90..ef07ae5fb3a0 100644
>> --- a/arch/x86/entry/traps.c
>> +++ b/arch/x86/entry/traps.c
>> @@ -69,6 +69,11 @@
>>   extern unsigned char native_irq_return_iret[];
>>   extern unsigned char asm_load_gs_index_gs_change[];
>>   
>> +/* Entry code written in C. Must be only used in traps.c */
>> +#define __entry_text							\
>> +	noinline notrace __attribute((__section__(".entry.text")))	\
>> +	__no_kcsan __no_sanitize_address __no_profile __no_sanitize_coverage
> 
> Urgh, that's bound to get out of sync with noinstr.. How about you make
> noinstr something like:
> 
> #define __noinstr_section(section) \
> 	noinline notrace __attribute((__section__(section)))	\
> 	__no_kcsan __no_sanitize_address __no_profile __no_sanitize_coverage
> 
> #define noinstr __noinstr_section(".noinstr.text")
> 
> and then write the above like:
> 
> #define __entry_text __noinstr_section(".entry.text")

It is a good idea.  There was no "__no_profile __no_sanitize_coverage"
when I first made the patch several month ago.  I added it after I recheck
the definition of "noinstr" yesterday which means we really need __noinstr_section()
to keep them sync.

> 
