Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEB7B37ECDD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 00:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384689AbhELUCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 16:02:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53288 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354186AbhELSfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 14:35:48 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620844479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KdNcJ8cEaSMgpbsP8tBqYM0z6corc8i7Q+IqLVoaSeI=;
        b=3x+cKd8kaBdN5LgKQSfI6isMBwiqQpyrzQri1RDEePZqtFMQda1NU3AzNJ5QQHoV0c4FQ8
        /jw6Vrjp4LDjimTKLPcjzjH1XRq9qqmaEiE1dbge+Qe0x3DRV/HSGE8R++Bk+zWTGskdEF
        hxmHa9XeUAahJFqheh1+1S0A/D1RGuPA3V3c+35FpjLi/EfLHWNVNcTJCNl4zFti7EkLZ/
        D1QT6NZMy3K3cr/wb0fw6K5dSPHTi2b+wm3sjUYPxAmWTH/U/1thh/tr5MDZl272BryNjv
        FSdpgfpBSvohUxvJafYVSXmx0OpHG3Xyj/6eV+yq6456C6w6aclMVHtTROl7fA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620844479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KdNcJ8cEaSMgpbsP8tBqYM0z6corc8i7Q+IqLVoaSeI=;
        b=q1pkZx2cjT1GVCWu62URddV0ZE8eU1Js6/RuUC9ttaZ8Jpm1689ri3E0prukrnU5xUoDZI
        WOxqEgX1qNXkxTAA==
To:     "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC v2 PATCH 7/7] x86/entry: use int for syscall number; handle all invalid syscall nrs
In-Reply-To: <60495dd3-ea68-4db3-47ad-b7b45796bf76@zytor.com>
References: <871racf928.ffs@nanos.tec.linutronix.de> <60495dd3-ea68-4db3-47ad-b7b45796bf76@zytor.com>
Date:   Wed, 12 May 2021 20:34:39 +0200
Message-ID: <87o8dfer7k.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12 2021 at 11:21, H. Peter Anvin wrote:
> On 5/12/21 5:09 AM, Thomas Gleixner wrote:
>> 
>>> index 1d9db15fdc69..85f04ea0e368 100644
>>> --- a/arch/x86/entry/entry_64.S
>>> +++ b/arch/x86/entry/entry_64.S
>>> @@ -108,7 +108,7 @@ SYM_INNER_LABEL(entry_SYSCALL_64_after_hwframe, SYM_L_GLOBAL)
>>>   
>>>   	/* IRQs are off. */
>>>   	movq	%rsp, %rdi
>>> -	movq	%rax, %rsi
>>> +	movslq	%eax, %rsi
>> 
>> This is wrong.
>> 
>>    syscall(long number,...);
>> 
>> So the above turns syscall(UINT_MAX + N, ...) into syscall(N, ...).
>> 
>
> That is intentional, as (again) system calls are int.

They are 'int' kernel internally, but _NOT_ at the user space visible
side. Again: man syscall

    syscall(long number,...);

So that results in a user ABI change.

> As stated in my reply to Ingo, I'll clean the various descriptions and
> try to capture the discussion better.

If we agree to go there then this wants to be a seperate commit which
does nothing else than changing this behaviour.

Thanks,

        tglx
