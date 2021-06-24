Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3916E3B37F2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 22:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbhFXUjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 16:39:21 -0400
Received: from foss.arm.com ([217.140.110.172]:38262 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229525AbhFXUjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 16:39:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB24A1042;
        Thu, 24 Jun 2021 13:37:00 -0700 (PDT)
Received: from [10.57.9.136] (unknown [10.57.9.136])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF4683F694;
        Thu, 24 Jun 2021 13:36:58 -0700 (PDT)
Subject: Re: [BUG] arm64: an infinite loop in generic_perform_write()
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Chen Huang <chenhuang5@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Randy Dunlap <rdunlap@infradead.org>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>
References: <da9c2fa9-a545-0c48-4490-d6134cc31425@huawei.com>
 <20210623132223.GA96264@C02TD0UTHF1T.local>
 <1c635945-fb25-8871-7b34-f475f75b2caf@huawei.com>
 <YNP6/p/yJzLLr8M8@casper.infradead.org> <YNQuZ8ykN7aR+1MP@infradead.org>
 <YNRpYli/5/GWvaTT@casper.infradead.org>
 <27fbb8c1-2a65-738f-6bec-13f450395ab7@arm.com>
 <YNSyZaZtPTmTa5P8@zeniv-ca.linux.org.uk> <20210624185554.GC25097@arm.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <e8e87aba-22f7-d039-ceaa-a93591b04b1e@arm.com>
Date:   Thu, 24 Jun 2021 21:36:54 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210624185554.GC25097@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-24 19:55, Catalin Marinas wrote:
> On Thu, Jun 24, 2021 at 04:27:17PM +0000, Al Viro wrote:
>> On Thu, Jun 24, 2021 at 02:22:27PM +0100, Robin Murphy wrote:
>>> FWIW I think the only way to make the kernel behaviour any more robust here
>>> would be to make the whole uaccess API more expressive, such that rather
>>> than simply saying "I only got this far" it could actually differentiate
>>> between stopping due to a fault which may be recoverable and worth retrying,
>>> and one which definitely isn't.
>>
>> ... and propagate that "more expressive" information through what, 3 or 4
>> levels in the call chain?
>>
>>  From include/linux/uaccess.h:
>>
>>   * If raw_copy_{to,from}_user(to, from, size) returns N, size - N bytes starting
>>   * at to must become equal to the bytes fetched from the corresponding area
>>   * starting at from.  All data past to + size - N must be left unmodified.
>>   *
>>   * If copying succeeds, the return value must be 0.  If some data cannot be
>>   * fetched, it is permitted to copy less than had been fetched; the only
>>   * hard requirement is that not storing anything at all (i.e. returning size)
>>   * should happen only when nothing could be copied.  In other words, you don't
>>   * have to squeeze as much as possible - it is allowed, but not necessary.
>>
>> arm64 instances violate the aforementioned hard requirement.
> 
> After reading the above a few more times, I think I get it. The key
> sentence is: not storing anything at all should happen only when nothing
> could be copied. In the MTE case, something can still be copied.
> 
>> Please, fix
>> it there; it's not hard.  All you need is an exception handler in .Ltiny15
>> that would fall back to (short) byte-by-byte copy if the faulting address
>> happened to be unaligned.  Or just do one-byte copy, not that it had been
>> considerably cheaper than a loop.  Will be cheaper than propagating that extra
>> information up the call chain, let alone paying for extra ->write_begin()
>> and ->write_end() for single byte in generic_perform_write().
> 
> Yeah, it's definitely fixable in the arch code. I misread the above
> requirements and thought it could be fixed in the core code.
> 
> Quick hack, though I think in the actual exception handling path in .S
> more sense (and it needs the copy_to_user for symmetry):

Hmm, if anything the asm version might be even more straightforward; I 
think it's pretty much just this (untested):

diff --git a/arch/arm64/lib/copy_to_user.S b/arch/arm64/lib/copy_to_user.S
index 043da90f5dd7..632bf1f9540d 100644
--- a/arch/arm64/lib/copy_to_user.S
+++ b/arch/arm64/lib/copy_to_user.S
@@ -62,6 +62,9 @@ EXPORT_SYMBOL(__arch_copy_to_user)

         .section .fixup,"ax"
         .align  2
-9998:  sub     x0, end, dst                    // bytes not copied
+9998:  ldrb    w7, [x1]
+USER(9997f,    sttrb   w7, [x0])
+       add     x0, x0, #1
+9997:  sub     x0, end, dst                    // bytes not copied
         ret
         .previous

If we can get away without trying to finish the whole copy bytewise, 
(i.e. we don't cause any faults of our own by knowingly over-reading in 
the routine itself), I'm more than happy with that.

Robin.

> diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
> index b5f08621fa29..903f8a2a457b 100644
> --- a/arch/arm64/include/asm/uaccess.h
> +++ b/arch/arm64/include/asm/uaccess.h
> @@ -415,6 +415,15 @@ extern unsigned long __must_check __arch_copy_from_user(void *to, const void __u
>   	uaccess_ttbr0_enable();						\
>   	__acfu_ret = __arch_copy_from_user((to),			\
>   				      __uaccess_mask_ptr(from), (n));	\
> +	if (__acfu_ret == n) {						\
> +		int __cfu_err = 0;					\
> +		char __cfu_val;						\
> +		__raw_get_mem("ldtr", __cfu_val, (char *)from, __cfu_err);\
> +		if (!__cfu_err) {					\
> +			*(char *)to = __cfu_val;			\
> +			__acfu_ret--;					\
> +		}							\
> +	}								\
>   	uaccess_ttbr0_disable();					\
>   	__acfu_ret;							\
>   })
> 
> Of course, it only fixes the MTE problem, I'll ignore the MMIO case
> (though it may work in certain configurations like synchronous faults).
> 
