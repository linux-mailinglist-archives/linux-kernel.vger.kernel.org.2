Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCED6305970
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 12:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236096AbhA0LTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 06:19:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:36998 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236024AbhA0Kl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 05:41:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7E5BCAD26;
        Wed, 27 Jan 2021 10:41:16 +0000 (UTC)
Date:   Wed, 27 Jan 2021 11:41:10 +0100
From:   Borislav Petkov <bp@suse.de>
To:     "Bae, Chang Seok" <chang.seok.bae@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86-ml <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 07/21] x86/fpu/xstate: Introduce helpers to manage
 dynamic xstate buffers
Message-ID: <20210127104110.GB8115@zn.tnic>
References: <20201223155717.19556-1-chang.seok.bae@intel.com>
 <20201223155717.19556-8-chang.seok.bae@intel.com>
 <20210126201746.GB9662@zn.tnic>
 <80003059-987E-4FFA-8F9D-6A480192BE5D@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <80003059-987E-4FFA-8F9D-6A480192BE5D@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 01:23:57AM +0000, Bae, Chang Seok wrote:
> The xstate buffer may expand on the fly. The size has to be correctly
> calculated if needed. CPUID provides essential information for the
> calculation. Instead of reading CPUID repeatedly, store them -- the offset and
> size are already stored here. The 64B alignment looks to be missing, so added
> here.

/me goes and digs into the SDM.

Do you mean this:

"Bit 01 is set if, when the compacted format of an XSAVE area is used,
this extended state component located on the next 64-byte boundary
following the preceding state component (otherwise, it is located
immediately following the preceding state component)."

So judging by your variable naming, you wanna record here whether the
buffer aligns on 64 bytes.

Yes, no?

How about a comment over that variable so that people reading the code,
know what it records and do not have to open the SDM each time.

> How about:
>     “With the given mask, no relevant size is found so far. So, calculate it by
>      summing up each state size."

Yap, better.

> Maybe:
>     "When the buffer is more than this size, the current mechanism is
>      potentially marginal to support the allocations."

Where do you get those formulations?!

Are you simply trying to say that for buffers larger than 64K, the
kernel needs "a more sophisticated allocation scheme"?

I'd suggest you try simple formulations first.

And why does it need a more sophisticated allocation scheme? Is 64K
magical?

Also, I'm assuming here - since you're using vmalloc - that XSAVE* can
handle virtually contiguous memory. SDM says it saves to "mem" and
doesn't specify so it sounds like it does but let's have a confirmation
here pls.

> 
> >> +#define XSTATE_BUFFER_MAX_BYTES		(64 * 1024)
> > 
> > What's that thing for when we have fpu_kernel_xstate_max_size too?
> 
> The threshold size is what the current mechanism can comfortably allocate
> (maybe at most). The warning is left when the buffer size goes beyond the 
> threshold. Then, we may need to consider a better allocation mechanism.

As above, why?

> Although a warning is given, vmalloc() may manage to allocate this size. So,
> it was not considered a hard hit yet. vmalloc() failure will return an error
> later.

And that warning is destined for whom, exactly?

When can that state become more than 64K?

What is that artificial limit for?

A whole lot of questions...

> Okay, the first question is whether this is an error. Well, with such too-much
> size though, the buffer can still store the states. So, give a warning at
> least. Perhaps, a similar case is when the calculated size is unmatched with
> the CPUID-provided [3]. We give a warning, not an error there, maybe assuming
> the calculated is larger.
> 
> But if it should be considered an error, maybe return -EINVAL.

I have no clue what that means...

> 
> >> +	}
> >> +
> >> +	/* We need 64B aligned pointer, but vmalloc() returns a page-aligned address. */
> > 
> > So this comment is useless, basically...
> 
> Okay, removed.
> 
> >> +	state_ptr = vmalloc(newsz);
> >> +	if (!state_ptr) {
> >> +		trace_x86_fpu_xstate_alloc_failed(fpu);
> > 
> > WTH is that tracepoint here for?
> 
> While it returns an error, this function can be on the path of NMI handling.

How?

You're allocating an xstate buffer in NMI context?!

> Then, likely only with the “unexpected #NM exception” message. So, logging a
> tracepoint can provide evidence of the allocation failure in that case.

Who's going to see that tracepoint, people who are tracing the system
but not normal users.

> PATCH9 introduces a wrapper that determines which to take. It simply returns
> state_ptr when not a null pointer. So, the logic is to use the dynamic buffer
> when available.

Why not allocate the xstate buffer by default instead of being embedded
in struct fpu?

You're already determining its max_size and you can use that to do the
allocation. Two buffers is calling for trouble.


> [1] https://lore.kernel.org/lkml/69721125-4e1c-ca9c-ff59-8e1331933e6c@intel.com/#t

Ok, I read that subthread.

The reasoning *why* we're using vmalloc() needs to be explained in a
comment over alloc_xstate_buffer() otherwise we will forget and that is
important.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
