Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A10837ECCF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 00:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344066AbhELUAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 16:00:17 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38525 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244510AbhELSXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 14:23:01 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2601:646:8602:8be0:7285:c2ff:fefb:fd4])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 14CILhci2815104
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Wed, 12 May 2021 11:21:43 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 14CILhci2815104
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021042801; t=1620843704;
        bh=ekZSPls2yDO4DPwHF1C5XdT0UihMAICV+Xpliib4mw4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Fe+dexuQJoM//2USjEyZGbce02RNdj1qDpLvqifCgq7mPxxFmPFO2qO+menyZhpC0
         TFsieAyRGL6B94SF6jSaSRoO24M0smeAlnd+eveVlDNsxQ4YnT+e8BlQvQIYJUCz6g
         hivhTQjIWZgexjxihVkEgZ9QnFO1oWlY3cNnml7J4Rj/rzn2MvIwMbxNTsoeYlUOJY
         3tFtlkSo9acqCmtoOlVC70YHSEYmKCfW5C/DKX7T3nWUfZOMIjWCwaHOH15YjHVrdv
         xZ1OkjbrIs4TFmxdhlpxBrnj6NU8frBiIn8oaWGPZOkgidt/FM6+zpReg/WodfRNfn
         Cpc5KtdKYelXw==
Subject: Re: [RFC v2 PATCH 7/7] x86/entry: use int for syscall number; handle
 all invalid syscall nrs
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <871racf928.ffs@nanos.tec.linutronix.de>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <60495dd3-ea68-4db3-47ad-b7b45796bf76@zytor.com>
Date:   Wed, 12 May 2021 11:21:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <871racf928.ffs@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/21 5:09 AM, Thomas Gleixner wrote:
> 
>> index 1d9db15fdc69..85f04ea0e368 100644
>> --- a/arch/x86/entry/entry_64.S
>> +++ b/arch/x86/entry/entry_64.S
>> @@ -108,7 +108,7 @@ SYM_INNER_LABEL(entry_SYSCALL_64_after_hwframe, SYM_L_GLOBAL)
>>   
>>   	/* IRQs are off. */
>>   	movq	%rsp, %rdi
>> -	movq	%rax, %rsi
>> +	movslq	%eax, %rsi
> 
> This is wrong.
> 
>    syscall(long number,...);
> 
> So the above turns syscall(UINT_MAX + N, ...) into syscall(N, ...).
> 

That is intentional, as (again) system calls are int. As stated in my 
reply to Ingo, I'll clean the various descriptions and try to capture 
the discussion better.

	-hpa

