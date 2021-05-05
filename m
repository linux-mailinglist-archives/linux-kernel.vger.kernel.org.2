Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26425373DA2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 16:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbhEEO0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 10:26:45 -0400
Received: from foss.arm.com ([217.140.110.172]:45544 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232706AbhEEO0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 10:26:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4741ED1;
        Wed,  5 May 2021 07:25:46 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.28.242])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A9193F718;
        Wed,  5 May 2021 07:25:44 -0700 (PDT)
Date:   Wed, 5 May 2021 15:25:42 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        David Laight <David.Laight@aculab.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v4 3/4] x86/uaccess: Use pointer masking to limit uaccess
 speculation
Message-ID: <20210505142542.GC5605@C02TD0UTHF1T.local>
References: <cover.1620186182.git.jpoimboe@redhat.com>
 <5ba93cdbf35ab40264a9265fc24575a9b2f813b3.1620186182.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ba93cdbf35ab40264a9265fc24575a9b2f813b3.1620186182.git.jpoimboe@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Josh, David,

On Tue, May 04, 2021 at 10:54:31PM -0500, Josh Poimboeuf wrote:
> The x86 uaccess code uses barrier_nospec() in various places to prevent
> speculative dereferencing of user-controlled pointers (which might be
> combined with further gadgets or CPU bugs to leak data).
> 
> There are some issues with the current implementation:
> 
> - The barrier_nospec() in copy_from_user() was inadvertently removed
>   with: 4b842e4e25b1 ("x86: get rid of small constant size cases in
>   raw_copy_{to,from}_user()")
> 
> - copy_to_user() and friends should also have a speculation barrier,
>   because a speculative write to a user-controlled address can still
>   populate the cache line with the original data.
> 
> - The LFENCE in barrier_nospec() is overkill, when more lightweight user
>   pointer masking can be used instead.
> 
> Remove existing barrier_nospec() usage, and instead do user pointer
> masking, throughout the x86 uaccess code.  This is similar to what arm64
> is already doing with uaccess_mask_ptr().

> +/*
> + * Sanitize a user pointer such that it becomes NULL if it's not a valid user
> + * pointer.  This prevents speculatively dereferencing a user-controlled
> + * pointer to kernel space if access_ok() speculatively returns true.  This
> + * should be done *after* access_ok(), to avoid affecting error handling
> + * behavior.
> + */
> +#define mask_user_ptr(ptr)						\
> +({									\
> +	unsigned long _ptr = (__force unsigned long)ptr;		\
> +	unsigned long mask;						\
> +									\
> +	asm volatile("cmp %[max], %[_ptr]\n\t"				\
> +		     "sbb %[mask], %[mask]\n\t"				\
> +		     : [mask] "=r" (mask)				\
> +		     : [_ptr] "r" (_ptr),				\
> +		       [max] "r" (TASK_SIZE_MAX)			\
> +		     : "cc");						\
> +									\
> +	mask &= _ptr;							\
> +	((typeof(ptr)) mask);						\
> +})

On arm64 we needed to have a sequence here because the addr_limit used
to be variable, but now that we've removed set_fs() and split the
user/kernel access routines we could simplify that to an AND with an
immediate mask to force all pointers into the user half of the address
space. IIUC x86_64 could do the same, and I think that was roughly what
David was suggesting.

That does mean that you could still speculatively access user memory
erroneously other than to NULL, but that's also true for speculated
pointers below TASK_SIZE_MAX when using the more complex sequence.

Thanks,
Mark.
