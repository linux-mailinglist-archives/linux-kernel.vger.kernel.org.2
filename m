Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2F6445D86E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 11:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350150AbhKYKw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 05:52:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346984AbhKYKux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 05:50:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0C5C061748
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 02:45:48 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637837144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a/5ioNz2eZoyujBuJczRG3UiiWN+u5gYNuKMcwYJIgw=;
        b=mZabj9PYJelcKAHCPkyFxAJ38yrbXl05VXRQiWP4ug+9k70/lgkbWOkQY4AVthY16EJ+iu
        EqD3hYscpdKOpB3uoRndEVgbKzn/wb8GzCQl7w2lJ31ziHQ/cVS7yEYpLyw1xs6qNhrw5F
        Hh6qql4n8NVGMSJzv811qFBKjuqBGnJTJRT/In6AE7Mn9N/8gel6013ACc+1ZQQu+7bteS
        AWB5nkL0Z0MiOYf1E0LL6USINpRLZAju9T91QhXplGp4dq9wE2YTq0FSPxnEV+M8Z0zouu
        /jZVMXS+iozOMMMyyPHFn1wYz7UF5f9HRPbWu8Bjeve3Hua8MSASfss0H+mnRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637837144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a/5ioNz2eZoyujBuJczRG3UiiWN+u5gYNuKMcwYJIgw=;
        b=9g1gSg5T1oW2PIqM0/wXxOjehTx+t6z2VEPqLjD/X5Yw0CAo1ufJej7laQF3DT/zvnSyYh
        Z6MKvNkLJeb8qiCw==
To:     Muchun Song <songmuchun@bytedance.com>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Anvin <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [RFC PATCH] x86/fault: move might_sleep() out of mmap read lock
In-Reply-To: <CAMZfGtVDgbLAS3uyB0QPHpDsA8Mam0sVYFdq9HhU4rSjqZG0qw@mail.gmail.com>
References: <20211119065831.31406-1-songmuchun@bytedance.com>
 <396ef026-c299-6560-fe7c-7b9932164fe3@intel.com>
 <CAMZfGtVDgbLAS3uyB0QPHpDsA8Mam0sVYFdq9HhU4rSjqZG0qw@mail.gmail.com>
Date:   Thu, 25 Nov 2021 11:45:44 +0100
Message-ID: <87a6hsms2v.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Muchun, Dave!

On Mon, Nov 22 2021 at 14:59, Muchun Song wrote:
> On Fri, Nov 19, 2021 at 11:04 PM Dave Hansen <dave.hansen@intel.com> wrote:
>> >
>> > +     might_sleep();
>> > +
>> >       /*
>> >        * Kernel-mode access to the user address space should only occur
>> >        * on well-defined single instructions listed in the exception
>> > @@ -1346,13 +1348,6 @@ void do_user_addr_fault(struct pt_regs *regs,
>> >               }
>> >  retry:
>> >               mmap_read_lock(mm);
>> > -     } else {
>> > -             /*
>> > -              * The above down_read_trylock() might have succeeded in
>> > -              * which case we'll have missed the might_sleep() from
>> > -              * down_read():
>> > -              */
>> > -             might_sleep();
>> >       }
>> >
>> >       vma = find_vma(mm, address);
>>
>> The comment is stale, which isn't great.  The might_sleep() is already
>> in the fast path.  So, moving it up above makes a lot of sense just in
>> terms of simplicity.

I don't think so. The point is:

	if (unlikely(!mmap_read_trylock(mm))) {
		if (!user_mode(regs) && !search_exception_tables(regs->ip)) {
			/*
			 * Fault from code in kernel from
			 * which we do not expect faults.
			 */
			bad_area_nosemaphore(regs, error_code, address);
			return;
		}

Moving it up will make the might_sleep() splat more important than an
unexpected fault when the unexpected fault happens in e.g. a preemption
disabled region. That's wrong because the important information in this
case is not the might sleep splat. The important information is the
fault itself.

But moving it up is even more wrong for spurious faults which are
correctly handled in that case via:

     bad_area_nosemaphore()
       __bad_area_nosemaphore()
         kernelmode_fixup_or_oops()
            handle(AMD erratum #91)
              is_prefetch()

So if such a spurious fault happens in a condition which would trigger
the might_sleep() splat then moving might_sleep() before the trylock()
will cause false positives. So, no. It's going to stay where it is.

> Without this patch, I didn't see the might_sleep() in the fast path. What
> am I missing here?

I have no idea what you are doing. If the trylock() succeeds and the
fault happened in e.g. a preemption disabled region then the
might_sleep() in the else path will trigger no matter what.

Thanks,

        tglx
