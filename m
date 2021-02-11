Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2F5931923F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 19:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbhBKS3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 13:29:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:55276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231499AbhBKS1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 13:27:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C2E5764E15;
        Thu, 11 Feb 2021 18:26:52 +0000 (UTC)
Date:   Thu, 11 Feb 2021 18:26:50 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Will Deacon <will@kernel.org>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 1/9] mm, arm64: Update PR_SET/GET_TAGGED_ADDR_CTRL interface
Message-ID: <20210211182649.GB5238@arm.com>
References: <20210205151631.43511-1-kirill.shutemov@linux.intel.com>
 <20210205151631.43511-2-kirill.shutemov@linux.intel.com>
 <20210211165748.GA5238@arm.com>
 <03b0f7d0-6b67-c48c-9250-ff4eadc221f2@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03b0f7d0-6b67-c48c-9250-ff4eadc221f2@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On Thu, Feb 11, 2021 at 09:06:12AM -0800, Dave Hansen wrote:
> I noticed there are some ELF bits for ARM's BTI feature:
> 
> 	GNU_PROPERTY_AARCH64_FEATURE_1_BTI
> 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/uapi/linux/elf.h#n453
> 
> There's been talk of needing a similar set of bits on x86 for tagged
> pointers (LAM).  Do you have any plans to do something similar (ELF
> property bits) for any of the pointer tagging features?

Not at the moment but see below.

Tagged addresses were supported on arm64 from day 0, though they were
not used much (I think some JITs attempted to encode pointer types in
the top byte). Until recently, we haven't allowed such tagged pointers
as syscall arguments.

The need for wider use of tagged pointers and the syscall ABI relaxation
came from the ASan/HWASan work on LLVM and the subsequent Memory Tagging
Extensions (MTE). With the latter, the user code doesn't need to be
recompiled, only the right heap allocator to be loaded. So you could do
an LD_PRELOAD to override malloc/free to return tagged pointers (I did
this in the past to run a standard Debian + LTP testing). So we decided
that it's easier for the C library to invoke a prctl() if needed rather
than having some ELF property.

MTE also requires additional control (like synchronous/asynchronous tag
checking) which we added to the same prctl() to be done in a single
call. That's, again, the decision of the C library together with using
mmap(PROT_MTE) for the heap regions.

That said, since HWASan requires code instrumentation, it would have
been nice if some GNU property was present as not to mix&match such
objects. I guess since it's mostly a debug feature, people didn't
bother but it would probably fall apart if you mix it with MTE.

With MTE, at some point we may deploy stack tagging which requires
instrumentation of the function prologue/epilogue and mapping the stack
with PROT_MTE. That's not widely used at the moment since such
instructions are undef on previous CPU implementations. We may end up
with an ELF annotation to distinguish such objects but I think that's
still up for discussion.

The reason for the BTI property was static binaries that needed PROT_BTI
on their exec sections to be set by the kernel. MTE did not have such
need (the C library would pass PROT_MTE explicitly on heap allocations)
and neither did the top-byte-ignore feature.

For the LAM feature, if the code is identical (e.g. it's the C library
deciding whether malloc() returns tagged pointers), I don't see much use
for an ELF annotation. However, if the plan is for something similar to
HWASan with different code generation, it may be safer to just add a
GNU note.

-- 
Catalin
