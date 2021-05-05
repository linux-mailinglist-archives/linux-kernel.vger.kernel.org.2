Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4F1C373ECE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 17:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbhEEPqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 11:46:25 -0400
Received: from foss.arm.com ([217.140.110.172]:46518 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233466AbhEEPqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 11:46:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 337AC1FB;
        Wed,  5 May 2021 08:45:26 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.28.242])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BDFDA3F718;
        Wed,  5 May 2021 08:45:23 -0700 (PDT)
Date:   Wed, 5 May 2021 16:45:21 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
Message-ID: <20210505154521.GD5605@C02TD0UTHF1T.local>
References: <cover.1620186182.git.jpoimboe@redhat.com>
 <5ba93cdbf35ab40264a9265fc24575a9b2f813b3.1620186182.git.jpoimboe@redhat.com>
 <20210505142542.GC5605@C02TD0UTHF1T.local>
 <ae4ca10422824546bca3a184a280a308@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae4ca10422824546bca3a184a280a308@AcuMS.aculab.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 05, 2021 at 02:49:53PM +0000, David Laight wrote:
> From: Mark Rutland
> > Sent: 05 May 2021 15:26
> ...
> > > +/*
> > > + * Sanitize a user pointer such that it becomes NULL if it's not a valid user
> > > + * pointer.  This prevents speculatively dereferencing a user-controlled
> > > + * pointer to kernel space if access_ok() speculatively returns true.  This
> > > + * should be done *after* access_ok(), to avoid affecting error handling
> > > + * behavior.
> > > + */
> > > +#define mask_user_ptr(ptr)						\
> > > +({									\
> > > +	unsigned long _ptr = (__force unsigned long)ptr;		\
> > > +	unsigned long mask;						\
> > > +									\
> > > +	asm volatile("cmp %[max], %[_ptr]\n\t"				\
> > > +		     "sbb %[mask], %[mask]\n\t"				\
> > > +		     : [mask] "=r" (mask)				\
> > > +		     : [_ptr] "r" (_ptr),				\
> > > +		       [max] "r" (TASK_SIZE_MAX)			\
> > > +		     : "cc");						\
> > > +									\
> > > +	mask &= _ptr;							\
> > > +	((typeof(ptr)) mask);						\
> > > +})
> > 
> > On arm64 we needed to have a sequence here because the addr_limit used
> > to be variable, but now that we've removed set_fs() and split the
> > user/kernel access routines we could simplify that to an AND with an
> > immediate mask to force all pointers into the user half of the address
> > space. IIUC x86_64 could do the same, and I think that was roughly what
> > David was suggesting.
> 
> Something like that :-)
> 
> For 64bit you can either unconditionally mask the user address
> (to clear a few high bits) or mask with a calculated value
> if the address is invalid.
> The former is almost certainly better.

Sure; I was thinking of the former as arm64 does the latter today.

> The other thing is that a valid length has to be less than
> the TASK_SIZE_MAX.
> Provided there are 2 zero bits at the top of every user address
> you can check 'addr | size < limit' and know that 'addr + size'
> won't wrap into kernel space.

I see. The size concern is interesting, and I'm not sure whether it
practically matters. If the size crosses the user/kernel gap, then for
this to (potentially) be a problem the CPU must speculate an access past
the gap before it takes the exception for the first access that hits the
gap. With that in mind:

* If the CPU cannot wildly mispredict an iteration of a uaccess loop
  (e.g. issues iterations in-order), then it would need to speculate
  accesses for the entire length of the gap without having raised an
  exception. For arm64 that's at least 2^56 bytes, which even with SVE's
  256-bit vectors that's 2^40 accesses. I think it's impractical for a
  CPU to speculate a window this large before taking an exception.

* If the CPU can wildly mispredict an iteration of a uaccess loop (e.g.
  do this non-sequentially and generate offests wildly), then it can go
  past the validated size boundary anyway, and we'd have to mask the
  pointer immediately prior to the access. Beyond value prediction, I'm
  not sure how this could happen given the way we build those loops.

... so for architectures with large user/kernel gaps I'm not sure that
it's necessary to check the size up-front.

On arm64 we also have a second defence as our uaccess primitives use
"unprivileged load/store" instructions LDTR and STTR, which use the user
permissions even when executed in kernel mode. So on CPUs where
permissions are respected under speculation these cannot access kernel
memory.

Thanks,
Mark.
