Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2853B66A1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 18:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbhF1QZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 12:25:06 -0400
Received: from foss.arm.com ([217.140.110.172]:35140 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231472AbhF1QZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 12:25:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81BA41042;
        Mon, 28 Jun 2021 09:22:38 -0700 (PDT)
Received: from [10.57.8.89] (unknown [10.57.8.89])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7846F3F718;
        Mon, 28 Jun 2021 09:22:36 -0700 (PDT)
Subject: Re: [BUG] arm64: an infinite loop in generic_perform_write()
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Chen Huang <chenhuang5@huawei.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
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
 <e8e87aba-22f7-d039-ceaa-a93591b04b1e@arm.com>
 <20210625103905.GA20835@arm.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <7f14271a-9b2f-1afc-3caf-c4e5b36efa73@arm.com>
Date:   Mon, 28 Jun 2021 17:22:30 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210625103905.GA20835@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-25 11:39, Catalin Marinas wrote:
> On Thu, Jun 24, 2021 at 09:36:54PM +0100, Robin Murphy wrote:
>> On 2021-06-24 19:55, Catalin Marinas wrote:
>>> On Thu, Jun 24, 2021 at 04:27:17PM +0000, Al Viro wrote:
>>>> On Thu, Jun 24, 2021 at 02:22:27PM +0100, Robin Murphy wrote:
>>>>> FWIW I think the only way to make the kernel behaviour any more robust here
>>>>> would be to make the whole uaccess API more expressive, such that rather
>>>>> than simply saying "I only got this far" it could actually differentiate
>>>>> between stopping due to a fault which may be recoverable and worth retrying,
>>>>> and one which definitely isn't.
>>>>
>>>> ... and propagate that "more expressive" information through what, 3 or 4
>>>> levels in the call chain?
>>>>
>>>>   From include/linux/uaccess.h:
>>>>
>>>>    * If raw_copy_{to,from}_user(to, from, size) returns N, size - N bytes starting
>>>>    * at to must become equal to the bytes fetched from the corresponding area
>>>>    * starting at from.  All data past to + size - N must be left unmodified.
>>>>    *
>>>>    * If copying succeeds, the return value must be 0.  If some data cannot be
>>>>    * fetched, it is permitted to copy less than had been fetched; the only
>>>>    * hard requirement is that not storing anything at all (i.e. returning size)
>>>>    * should happen only when nothing could be copied.  In other words, you don't
>>>>    * have to squeeze as much as possible - it is allowed, but not necessary.
>>>>
>>>> arm64 instances violate the aforementioned hard requirement.
>>>
>>> After reading the above a few more times, I think I get it. The key
>>> sentence is: not storing anything at all should happen only when nothing
>>> could be copied. In the MTE case, something can still be copied.
>>>
>>>> Please, fix
>>>> it there; it's not hard.  All you need is an exception handler in .Ltiny15
>>>> that would fall back to (short) byte-by-byte copy if the faulting address
>>>> happened to be unaligned.  Or just do one-byte copy, not that it had been
>>>> considerably cheaper than a loop.  Will be cheaper than propagating that extra
>>>> information up the call chain, let alone paying for extra ->write_begin()
>>>> and ->write_end() for single byte in generic_perform_write().
>>>
>>> Yeah, it's definitely fixable in the arch code. I misread the above
>>> requirements and thought it could be fixed in the core code.
>>>
>>> Quick hack, though I think in the actual exception handling path in .S
>>> more sense (and it needs the copy_to_user for symmetry):
>>
>> Hmm, if anything the asm version might be even more straightforward; I think
>> it's pretty much just this (untested):
> 
> That's what I thought but it was too late in the day to think in asm.
> 
>> diff --git a/arch/arm64/lib/copy_to_user.S b/arch/arm64/lib/copy_to_user.S
>> index 043da90f5dd7..632bf1f9540d 100644
>> --- a/arch/arm64/lib/copy_to_user.S
>> +++ b/arch/arm64/lib/copy_to_user.S
>> @@ -62,6 +62,9 @@ EXPORT_SYMBOL(__arch_copy_to_user)
>>
>>          .section .fixup,"ax"
>>          .align  2
>> -9998:  sub     x0, end, dst                    // bytes not copied
>> +9998:  ldrb    w7, [x1]
>> +USER(9997f,    sttrb   w7, [x0])
>> +       add     x0, x0, #1
>> +9997:  sub     x0, end, dst                    // bytes not copied
>>          ret
>>          .previous
>>
>> If we can get away without trying to finish the whole copy bytewise, (i.e.
>> we don't cause any faults of our own by knowingly over-reading in the
>> routine itself), I'm more than happy with that.
> 
> I don't think we over-read/write in the routine itself as this is based
> on the user memcpy() which can't handle faults. And since we got a fault
> before the end of the copy, we have at least one byte left in the
> buffer (which may or may not trigger a fault).
> 
> I wonder whether we should skip the extra byte copy if something was
> copied, i.e. start the exception handler with:
> 
> 	cmp	dstin, dst
> 	b.ne	9997f
> 
> That said, the fall-back to bytewise copying may have some advantage. I
> think we still have the issue where we copy some data to user but report
> less (STP failing on the second 8-byte when the first had been already
> written first 8). A byte copy loop would solve this, unless we pass the
> fault address to the exception handler (I thought you had some patch for
> this at some point).

OK, this is the quick-fix patch I've ended up with - I'll send it
properly at rc1. It makes both copy_from_user and copy_to_user behave
reasonably in Catalin's MTE-based test-case, so I figure copy_in_user
must be OK too (I keep hoping it might have gone away by now...)

Robin.

----->8-----
From: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH] arm64: Avoid premature usercopy failure

Al reminds us that the usercopy API must only return complete failure
if absolutely nothing could be copied. Currently, if userspace does
something silly like giving us an unaligned pointer to Device memory,
or a size which overruns MTE tag bounds, we may fail to honour that
requirement when faulting on a multi-byte access even though a smaller
access could have succeeded.

Add a mitigation to the fixup routines to fall back to a single-byte
copy if we faulted on a larger access before anything has been written
to the destination, to guarantee making *some* forward progress. We
needn't be too concerned about the overall performance since this should
only occur when callers are doing something a bit dodgy in the first
place. Particularly broken userspace might still be able to trick
generic_perform_write() into an infinite loop by targeting write() at
an mmap() of some read-only device register where the fault-in load
succeeds but any store synchronously aborts such that copy_to_user() is
genuinely unable to make progress, but, well, don't do that...

Reported-by: Chen Huang <chenhuang5@huawei.com>
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
  arch/arm64/lib/copy_from_user.S | 14 +++++++++++---
  arch/arm64/lib/copy_in_user.S   | 21 ++++++++++++++-------
  arch/arm64/lib/copy_to_user.S   | 14 +++++++++++---
  3 files changed, 36 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/lib/copy_from_user.S b/arch/arm64/lib/copy_from_user.S
index 95cd62d67371..5b720a29a242 100644
--- a/arch/arm64/lib/copy_from_user.S
+++ b/arch/arm64/lib/copy_from_user.S
@@ -29,7 +29,7 @@
  	.endm
  
  	.macro ldrh1 reg, ptr, val
-	user_ldst 9998f, ldtrh, \reg, \ptr, \val
+	user_ldst 9997f, ldtrh, \reg, \ptr, \val
  	.endm
  
  	.macro strh1 reg, ptr, val
@@ -37,7 +37,7 @@
  	.endm
  
  	.macro ldr1 reg, ptr, val
-	user_ldst 9998f, ldtr, \reg, \ptr, \val
+	user_ldst 9997f, ldtr, \reg, \ptr, \val
  	.endm
  
  	.macro str1 reg, ptr, val
@@ -45,7 +45,7 @@
  	.endm
  
  	.macro ldp1 reg1, reg2, ptr, val
-	user_ldp 9998f, \reg1, \reg2, \ptr, \val
+	user_ldp 9997f, \reg1, \reg2, \ptr, \val
  	.endm
  
  	.macro stp1 reg1, reg2, ptr, val
@@ -53,8 +53,10 @@
  	.endm
  
  end	.req	x5
+srcin	.req	x15
  SYM_FUNC_START(__arch_copy_from_user)
  	add	end, x0, x2
+	mov	srcin, x1
  #include "copy_template.S"
  	mov	x0, #0				// Nothing to copy
  	ret
@@ -63,6 +65,12 @@ EXPORT_SYMBOL(__arch_copy_from_user)
  
  	.section .fixup,"ax"
  	.align	2
+9997:	cmp	dst, dstin
+	b.ne	9998f
+	// Before being absolutely sure we couldn't copy anything, try harder
+USER(9998f, ldtrb tmp1w, [srcin])
+	strb	tmp1w, [dstin]
+	add	dst, dstin, #1
  9998:	sub	x0, end, dst			// bytes not copied
  	ret
  	.previous
diff --git a/arch/arm64/lib/copy_in_user.S b/arch/arm64/lib/copy_in_user.S
index 1f61cd0df062..0abb24a01781 100644
--- a/arch/arm64/lib/copy_in_user.S
+++ b/arch/arm64/lib/copy_in_user.S
@@ -30,33 +30,34 @@
  	.endm
  
  	.macro ldrh1 reg, ptr, val
-	user_ldst 9998f, ldtrh, \reg, \ptr, \val
+	user_ldst 9997f, ldtrh, \reg, \ptr, \val
  	.endm
  
  	.macro strh1 reg, ptr, val
-	user_ldst 9998f, sttrh, \reg, \ptr, \val
+	user_ldst 9997f, sttrh, \reg, \ptr, \val
  	.endm
  
  	.macro ldr1 reg, ptr, val
-	user_ldst 9998f, ldtr, \reg, \ptr, \val
+	user_ldst 9997f, ldtr, \reg, \ptr, \val
  	.endm
  
  	.macro str1 reg, ptr, val
-	user_ldst 9998f, sttr, \reg, \ptr, \val
+	user_ldst 9997f, sttr, \reg, \ptr, \val
  	.endm
  
  	.macro ldp1 reg1, reg2, ptr, val
-	user_ldp 9998f, \reg1, \reg2, \ptr, \val
+	user_ldp 9997f, \reg1, \reg2, \ptr, \val
  	.endm
  
  	.macro stp1 reg1, reg2, ptr, val
-	user_stp 9998f, \reg1, \reg2, \ptr, \val
+	user_stp 9997f, \reg1, \reg2, \ptr, \val
  	.endm
  
  end	.req	x5
-
+srcin	.req	x15
  SYM_FUNC_START(__arch_copy_in_user)
  	add	end, x0, x2
+	mov	srcin, x1
  #include "copy_template.S"
  	mov	x0, #0
  	ret
@@ -65,6 +66,12 @@ EXPORT_SYMBOL(__arch_copy_in_user)
  
  	.section .fixup,"ax"
  	.align	2
+9997:	cmp	dst, dstin
+	b.ne	9998f
+	// Before being absolutely sure we couldn't copy anything, try harder
+USER(9998f, ldtrb tmp1w, [srcin])
+USER(9998f, sttrb tmp1w, [dstin])
+	add	dst, dstin, #1
  9998:	sub	x0, end, dst			// bytes not copied
  	ret
  	.previous
diff --git a/arch/arm64/lib/copy_to_user.S b/arch/arm64/lib/copy_to_user.S
index 043da90f5dd7..cfb598ae4812 100644
--- a/arch/arm64/lib/copy_to_user.S
+++ b/arch/arm64/lib/copy_to_user.S
@@ -32,7 +32,7 @@
  	.endm
  
  	.macro strh1 reg, ptr, val
-	user_ldst 9998f, sttrh, \reg, \ptr, \val
+	user_ldst 9997f, sttrh, \reg, \ptr, \val
  	.endm
  
  	.macro ldr1 reg, ptr, val
@@ -40,7 +40,7 @@
  	.endm
  
  	.macro str1 reg, ptr, val
-	user_ldst 9998f, sttr, \reg, \ptr, \val
+	user_ldst 9997f, sttr, \reg, \ptr, \val
  	.endm
  
  	.macro ldp1 reg1, reg2, ptr, val
@@ -48,12 +48,14 @@
  	.endm
  
  	.macro stp1 reg1, reg2, ptr, val
-	user_stp 9998f, \reg1, \reg2, \ptr, \val
+	user_stp 9997f, \reg1, \reg2, \ptr, \val
  	.endm
  
  end	.req	x5
+srcin	.req	x15
  SYM_FUNC_START(__arch_copy_to_user)
  	add	end, x0, x2
+	mov	srcin, x1
  #include "copy_template.S"
  	mov	x0, #0
  	ret
@@ -62,6 +64,12 @@ EXPORT_SYMBOL(__arch_copy_to_user)
  
  	.section .fixup,"ax"
  	.align	2
+9997:	cmp	dst, dstin
+	b.ne	9998f
+	// Before being absolutely sure we couldn't copy anything, try harder
+	ldrb	tmp1w, [srcin]
+USER(9998f, sttrb tmp1w, [dstin])
+	add	dst, dstin, #1
  9998:	sub	x0, end, dst			// bytes not copied
  	ret
  	.previous
-- 
2.25.1

