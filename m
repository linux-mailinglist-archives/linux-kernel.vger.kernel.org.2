Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0B1B3B3660
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 20:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbhFXS6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 14:58:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:46854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232596AbhFXS6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 14:58:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EACB1613CC;
        Thu, 24 Jun 2021 18:55:56 +0000 (UTC)
Date:   Thu, 24 Jun 2021 19:55:54 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
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
Subject: Re: [BUG] arm64: an infinite loop in generic_perform_write()
Message-ID: <20210624185554.GC25097@arm.com>
References: <da9c2fa9-a545-0c48-4490-d6134cc31425@huawei.com>
 <20210623132223.GA96264@C02TD0UTHF1T.local>
 <1c635945-fb25-8871-7b34-f475f75b2caf@huawei.com>
 <YNP6/p/yJzLLr8M8@casper.infradead.org>
 <YNQuZ8ykN7aR+1MP@infradead.org>
 <YNRpYli/5/GWvaTT@casper.infradead.org>
 <27fbb8c1-2a65-738f-6bec-13f450395ab7@arm.com>
 <YNSyZaZtPTmTa5P8@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNSyZaZtPTmTa5P8@zeniv-ca.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 04:27:17PM +0000, Al Viro wrote:
> On Thu, Jun 24, 2021 at 02:22:27PM +0100, Robin Murphy wrote:
> > FWIW I think the only way to make the kernel behaviour any more robust here
> > would be to make the whole uaccess API more expressive, such that rather
> > than simply saying "I only got this far" it could actually differentiate
> > between stopping due to a fault which may be recoverable and worth retrying,
> > and one which definitely isn't.
> 
> ... and propagate that "more expressive" information through what, 3 or 4
> levels in the call chain?  
> 
> From include/linux/uaccess.h:
> 
>  * If raw_copy_{to,from}_user(to, from, size) returns N, size - N bytes starting
>  * at to must become equal to the bytes fetched from the corresponding area
>  * starting at from.  All data past to + size - N must be left unmodified.
>  *
>  * If copying succeeds, the return value must be 0.  If some data cannot be
>  * fetched, it is permitted to copy less than had been fetched; the only
>  * hard requirement is that not storing anything at all (i.e. returning size)
>  * should happen only when nothing could be copied.  In other words, you don't
>  * have to squeeze as much as possible - it is allowed, but not necessary.
> 
> arm64 instances violate the aforementioned hard requirement.

After reading the above a few more times, I think I get it. The key
sentence is: not storing anything at all should happen only when nothing
could be copied. In the MTE case, something can still be copied.

> Please, fix
> it there; it's not hard.  All you need is an exception handler in .Ltiny15
> that would fall back to (short) byte-by-byte copy if the faulting address
> happened to be unaligned.  Or just do one-byte copy, not that it had been
> considerably cheaper than a loop.  Will be cheaper than propagating that extra
> information up the call chain, let alone paying for extra ->write_begin()
> and ->write_end() for single byte in generic_perform_write().

Yeah, it's definitely fixable in the arch code. I misread the above
requirements and thought it could be fixed in the core code.

Quick hack, though I think in the actual exception handling path in .S
more sense (and it needs the copy_to_user for symmetry):

diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index b5f08621fa29..903f8a2a457b 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -415,6 +415,15 @@ extern unsigned long __must_check __arch_copy_from_user(void *to, const void __u
 	uaccess_ttbr0_enable();						\
 	__acfu_ret = __arch_copy_from_user((to),			\
 				      __uaccess_mask_ptr(from), (n));	\
+	if (__acfu_ret == n) {						\
+		int __cfu_err = 0;					\
+		char __cfu_val;						\
+		__raw_get_mem("ldtr", __cfu_val, (char *)from, __cfu_err);\
+		if (!__cfu_err) {					\
+			*(char *)to = __cfu_val;			\
+			__acfu_ret--;					\
+		}							\
+	}								\
 	uaccess_ttbr0_disable();					\
 	__acfu_ret;							\
 })

Of course, it only fixes the MTE problem, I'll ignore the MMIO case
(though it may work in certain configurations like synchronous faults).

-- 
Catalin
