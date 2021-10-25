Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20088438CCD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 02:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbhJYAhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 20:37:19 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:40945 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229668AbhJYAhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 20:37:18 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R651e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UtUKHVr_1635122094;
Received: from C02XQCBJJG5H.local(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0UtUKHVr_1635122094)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 25 Oct 2021 08:34:55 +0800
Subject: Re: [PATCH V3 32/49] x86/entry: Add the C version ist_restore_cr3()
To:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20211014031413.14471-1-jiangshanlai@gmail.com>
 <20211014034121.17025-1-jiangshanlai@gmail.com>
From:   Lai Jiangshan <laijs@linux.alibaba.com>
Message-ID: <5591e2b1-5701-80da-557a-899fd3158697@linux.alibaba.com>
Date:   Mon, 25 Oct 2021 08:34:54 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211014034121.17025-1-jiangshanlai@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/10/14 11:41, Lai Jiangshan wrote:
>
>   static __always_inline void switch_to_kernel_cr3(void)
>   {
>   	if (static_cpu_has(X86_FEATURE_PTI))
> @@ -49,9 +70,34 @@ static __always_inline unsigned long ist_switch_to_kernel_cr3(void)
>   
>   	return cr3;
>   }
> +
> +static __always_inline void ist_restore_cr3(unsigned long cr3)
> +{
> +	if (!static_cpu_has(X86_FEATURE_PTI))
> +		return;
> +
> +	if (unlikely(cr3 & PTI_USER_PGTABLE_MASK)) {
> +		pti_switch_to_user_cr3(cr3);
> +		return;
> +	}

The C code is semantically copied from ASM.

The ASM code is from the commit 21e9445911025("x86/mm: Optimize RESTORE_CR3")
which still keeps the older behavior of writing to CR3 unconditionally
even the saved CR3 is kernel CR3.

Is there any special reason that the CR3 needs to be written for kernel CR3?

I would add a commit to change it in ASM code by skipping cr3 write when
it is kernel CR3, and then make the C code as the same as new ASM code.

> +
> +	/*
> +	 * KERNEL pages can always resume with NOFLUSH as we do
> +	 * explicit flushes.
> +	 */
> +	if (static_cpu_has(X86_FEATURE_PCID))
> +		cr3 |= X86_CR3_PCID_NOFLUSH;
> +
> +	/*
> +	 * The CR3 write could be avoided when not changing its value,
> +	 * but would require a CR3 read.
> +	 */
> +	native_write_cr3(cr3);
> +}
>   #else
>   static __always_inline void switch_to_kernel_cr3(void) {}
>   static __always_inline unsigned long ist_switch_to_kernel_cr3(void) { return 0; }
> +static __always_inline void ist_restore_cr3(unsigned long cr3) {}
>   #endif
>   
>   /*
> 
