Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54EBB3F1B36
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 16:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240424AbhHSOH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 10:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240164AbhHSOH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 10:07:56 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19E8C061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 07:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=S0FZZ5/lZzCX4aQ9sITjKGFa72MmFpBA5rGEDVDo6u4=; b=S0QT7ZtoPC1R3wSM5HFK8wOYBI
        pUVVp2gWORVRdlRaGNkt6ZR4/UsA5FzaaA8yeTLRBb4fUlzawlja2+o9oAV3BFvYx25n+1feTQCOj
        rRaaCnhVZFwGSFsOw3uurENk4jZvHK85hc5JIZxyWqNR3So6KUxfz+mjlXSmI5pjCtsILg7NswK3c
        e81l6mYLE2Orzx/RejA9t1THcT4rRuBU4zCGB820PV4ZvOW9Lc/xUAlIK2drkOxITV+A6dfgT0b/W
        CZmTOuZ+ntBR71furUZtXAHQr+lLB//dF1rFvHbatPWLMlOpLOYLsZNIt/afjBHrKqcfNKeWJ9x4H
        w/2UYuPQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGigy-00B7Y2-M7; Thu, 19 Aug 2021 14:06:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2C17B3004B2;
        Thu, 19 Aug 2021 16:06:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 110372CDB99DE; Thu, 19 Aug 2021 16:06:45 +0200 (CEST)
Date:   Thu, 19 Aug 2021 16:06:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, bp@alien8.de,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Alistair Popple <apopple@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        yuanxzhang@fudan.edu.cn, Xin Tan <tanxin.ctf@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        dhowells@redhat.com
Subject: Re: [PATCH] mm/rmap: Convert from atomic_t to refcount_t on
 anon_vma->refcount
Message-ID: <YR5ldaQvAnCKMnkk@hirez.programming.kicks-ass.net>
References: <1626665029-49104-1-git-send-email-xiyuyang19@fudan.edu.cn>
 <20210720160127.ac5e76d1e03a374b46f25077@linux-foundation.org>
 <20210819132131.GA15779@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210819132131.GA15779@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 02:21:32PM +0100, Will Deacon wrote:

> I suppose the sanitisers might contribute a fair bit to the cmpxchg() loops
> in the allmodconfig case, but looking at how defconfig affects mm/rmap.o the
> *big* difference there seems to be due to the dec_and_test() operation:
> 
> atomic_dec_and_test() looks like:
> 
> 	lock decl (%rdi)
> 	sete   %al
> 	retq
> 
> whereas refcount_dec_and_test() looks like:
> 
> 	push   %r12
> 	mov    $0xffffffff,%eax
> 	lock xadd %eax,(%rdi)
> 	cmp    $0x1,%eax
> 	je     97d
> 	xor    %r12d,%r12d
> 	test   %eax,%eax
> 	jle    989
> 	mov    %r12d,%eax
> 	pop    %r12
> 	retq
> 	mov    $0x1,%r12d
> 	mov    %r12d,%eax
> 	pop    %r12
> 	retq
> 	mov    $0x3,%esi
> 	callq  993
> 	mov    %r12d,%eax
> 	pop    %r12
> 	retq
> 
> which is a monster by comparison!
> 
> This is because refcount_dec_and_test() wraps __refcount_sub_and_test(),
> which is necessary so that we can look at the old value:
> 
>   (1) If it was equal to 1, then ensure we have acquire semantics and
>       return true.
> 
>   (2) If it was < 0 or the new value written is < 0, then saturate (UAF)
>
> However, talking to Peter and Boris, we may be able to achieve the same
> thing by looking at the flags after a DECL instruction:
> 
>   * We can implement (1) by checking if we hit zero (ZF=1)
>   * We can implement (2) by checking if the new value is < 0 (SF=1).
>     We then need to catch the case where the old value was < 0 but the
>     new value is 0. I think this is (SF=0 && OF=1).
> 
> So maybe the second check is actually SF != OF? I could benefit from some
> x86 expertise here, but hopefully you get the idea.

Right, so the first condition is ZF=1, we hit zero.
The second condition is SF=1, the result is negative.

I'm not sure we need OF, if we hit that condition we've already lost.
But it's easy enough to add I suppose.

> We could do something similar for refcount_dec() and refcount_inc(),
> although commit a435b9a14356 ("locking/refcount: Provide __refcount API
> to obtain the old value") add versions which return the old value,
> which we can't reconstruct from the flags. Since nobody is using these
> variants, I suggest we remove them.

dhowells asked for them... he was very adamand they were required. David?

> Thoughts?

Something like so?

---
 arch/x86/include/asm/refcount.h | 29 +++++++++++++++++++++++++++++
 include/linux/refcount.h        |  6 +++++-
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/refcount.h b/arch/x86/include/asm/refcount.h
new file mode 100644
index 000000000000..bbc0d4835bbb
--- /dev/null
+++ b/arch/x86/include/asm/refcount.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_REFCOUNT_H
+#define _ASM_X86_REFCOUNT_H
+
+#define refcount_dec_and_test refcount_dec_and_test
+static inline bool refcount_dec_and_test(refcount_t *r)
+{
+	asm_volatile_goto (LOCK_PREFIX "decl %[var]\n\t"
+			   "jz %l[cc_zero]\n\t"
+			   "js %l[cc_fail]\n\t"
+			   "jo %l[cc_fail]"
+			   : : [var] "m" (r->refs.counter)
+			   : "memory" : cc_zero, cc_fail);
+
+	if (0) {
+cc_zero:
+		smp_acquire__after_ctrl_dep();
+		return true;
+	}
+
+	if (0) {
+cc_fail:
+		refcount_warn_saturate(r, REFCOUNT_SUB_UAF);
+	}
+
+	return false;
+}
+
+#endif /* _ASM_X86_REFCOUNT_H */
diff --git a/include/linux/refcount.h b/include/linux/refcount.h
index b8a6e387f8f9..42e987549d1f 100644
--- a/include/linux/refcount.h
+++ b/include/linux/refcount.h
@@ -117,7 +117,7 @@ typedef struct refcount_struct {
 #define REFCOUNT_SATURATED	(INT_MIN / 2)
 
 enum refcount_saturation_type {
-	REFCOUNT_ADD_NOT_ZERO_OVF,
+	REFCOUNT_ADD_NOT_ZERO_OVF = 0,
 	REFCOUNT_ADD_OVF,
 	REFCOUNT_ADD_UAF,
 	REFCOUNT_SUB_UAF,
@@ -126,6 +126,8 @@ enum refcount_saturation_type {
 
 void refcount_warn_saturate(refcount_t *r, enum refcount_saturation_type t);
 
+#include <asm/refcount.h>
+
 /**
  * refcount_set - set a refcount's value
  * @r: the refcount
@@ -328,10 +330,12 @@ static inline __must_check bool __refcount_dec_and_test(refcount_t *r, int *oldp
  *
  * Return: true if the resulting refcount is 0, false otherwise
  */
+#ifndef refcount_dec_and_test
 static inline __must_check bool refcount_dec_and_test(refcount_t *r)
 {
 	return __refcount_dec_and_test(r, NULL);
 }
+#endif
 
 static inline void __refcount_dec(refcount_t *r, int *oldp)
 {
