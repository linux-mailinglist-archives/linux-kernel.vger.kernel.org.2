Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEAB63F6D1A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 03:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbhHYB3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 21:29:19 -0400
Received: from lgeamrelo13.lge.com ([156.147.23.53]:57085 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229800AbhHYB3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 21:29:17 -0400
Received: from unknown (HELO lgeamrelo02.lge.com) (156.147.1.126)
        by 156.147.23.53 with ESMTP; 25 Aug 2021 10:28:30 +0900
X-Original-SENDERIP: 156.147.1.126
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO X58A-UD3R) (10.177.222.33)
        by 156.147.1.126 with ESMTP; 25 Aug 2021 10:28:30 +0900
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
Date:   Wed, 25 Aug 2021 10:27:29 +0900
From:   Byungchul Park <byungchul.park@lge.com>
To:     torvalds@linux-foundation.org, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        rostedt@goodmis.org, joel@joelfernandes.org,
        alexander.levin@microsoft.com, daniel.vetter@ffwll.ch,
        chris@chris-wilson.co.uk, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
        willy@infradead.org, david@fromorbit.com, amir73il@gmail.com,
        bfields@fieldses.org, gregkh@linuxfoundation.org,
        kernel-team@lge.com
Subject: Re: [RFC] Cross-release versus a new tool
Message-ID: <20210825012729.GA21565@X58A-UD3R>
References: <20210803021611.GA28236@X58A-UD3R>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803021611.GA28236@X58A-UD3R>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2021 at 11:16:12AM +0900, Byungchul Park wrote:
> Hi folks,

Hi,

I understand you guys don't like the approach that introduces a new
implementation for now that Lockdep is quite mature enough, and at the
same time you might agree with the approach focusing on waiters than
lock acquisitions tho.

How do you think about that? I may develop the new tool in a separated
tree and make it mature enough for the mainline tree, or develop it in
the mainline tree as an experimental one, or rather focus on
re-introducing cross-release, or other options.

It would be appreciated to share opinions for that.

Thanks,
Byungchul

> Lockdep is a great tool for detecting deadlock possibility, which was
> designed for detecting wrong usage of locking API esp. typical lock e.g.
> spinlock and mutex. However, when it comes to read lock or any other
> mechanisms than typical lock, Lockdep code has been getting tweaked and
> complicated to cover all of them. It'd be getting worse over time.
> 
> First of all, we should understand what a deadlock detection tool should
> do. Fundamentally, a deadlock is caused by "WAITER(S) ON ITS EVENT(S)
> THAT WILL NEVER HAPPEN" so the tool should focus on waiters and events.
> Otherwise, complexifying it just makes things worse.
> 
> (NOTE: I hope you guys distinguish between dependency checking feature
> and any other supports for lock usage. I'm gonna talk about the aspect
> of dependency checking feature only in this posting. The support for
> correctness check of lock usage should still be there as is.)
> 
> We can detect a deadlock by tracking waiters and its events. A deadlock
> detection tool should focus on waiters and events and its contexts, not
> specific cases like the order of acquisitions that Lockdep does, where
> waiters and its events *implicitly* exist there anyway. This way, the
> tool can be simple and straightforward, and able to cover all cases.
> 
> I understand all Linux kernel features should be mature enough. I think
> Lockdep is fairly so, thanks to the folks for many years. I partially
> agree with the opinion that Lockdep should be kept and new feautures for
> a better work should be stacked onto Lockdep if needed. However, it's
> a shame that the base that Lockdep was built on is not that nice.
> 
> The requirement we expect the tool should meet is, I think:
> 
>    R1. It should detect a deadlock caused by typical type of lock e.g.
>        spin lock and mutex lock.
> 
>        We acquire a lock before accessing a shared resource and release
>        the lock after using it, say, both the acquisition and release
>        happen at the *same context*. Using the fact so just tracking the
>        order of lock acquisitions, we can detect a deadlock.
> 
>    R2. It should detect a deadlock caused by other than typical type of
>        lock e.g. read lock.
> 
>        Read lock works in a different way from typical one because it
>        was introduced to avoid *wait* on contention between read locks.
>        Furthermore, they behave differently depending on if it's
>        recursive one or not. It's not easy to detect a deadlock with
>        focusing on the order unless focusing on the interesting waiters
>        and its events. Otherwise, the tool should be tweaked and getting
>        complicated to cover them, which is how Lockdep does :(
> 
>    R3. It should detect a deadlock caused by any waiter e.g. page lock
>        and wait_for_completion.
> 
>        Not only locks but also any waits can cause a deadlock. However,
>        Lockdep doesn't work for the cases because it wasn't designed
>        fot that. Instead, these cases have been covered by manually
>        adding Lockdep annotations like acquire/release, in case by case
>        manner when found the needs. It'd better be done automatically or
>        with simpler annotations, for example, wait/event annotation
>        instead of acquire/release.
> 
>    R4. Sychronization objects e.g. lock and wait_for_completion need to
>        be classified correctly as a prerequisite, minimizing the number
>        of false positives.
> 
>        A deadlock detection tool does not track all individual objects.
>        Instead, it works with *class* classified based on its code path
>        basically. Unfortunately, because not all the classification is
>        perfect, false alarms may raise. To avoid it, some classes that
>        were assigned automatically but incorrectly, have been reset by
>        the developers manually for many years.
> 
>    R5. It should not overwhelm the kernel message with meaningless
>        reports. But it should still report meaningful ones.
> 
>        Even though one problematic usage in terms of dependency can
>        cause more than one scenario leading deadlock, it would be
>        meaningless to report all of them because some may rather get in
>        the way when picking meaningful ones for analysis. However,
>        meaningful ones are still worth being reported.
> 
>    R6. It should be mature and stable enough to handle subtle issues
>        properly.
> 
>        There are a lot of subtle issues in Linux kernel. The more
>        primitives they are, the more subtle issues there might be. A
>        dependency checking tool is one of very primitives feature so
>        needs to be mature and stable enough.
> 
> Lockdep has been developed fairly great for many years - by intoducing
> dynamic class assignment feature, recursive read lock support lately and
> so on - so as to cover R1, R2, R4, partially R5 and R6 for now, but,
> with the code complicated and enlarged inevitably.
> 
> However, there is still a lack of R3 in the tool. I'm thinking we can
> choose one of two options to cover R3:
> 
>    1. Cross-release
> 
>    This feature was reverted due to a few false positive alarms in a
>    specific environment where more than one file system were stacked on
>    one another through loopback. At that time, it looked not easy to
>    assign proper classes to locks in each layer with a lack of dynamic
>    class assignment feature. Now it's been ready, I think it's worth
>    retrying to introduce Cross-release.
> 
>    We can keep the all advantages Lockdep already has, esp. R6 with this
>    option. At the same time, we would keep the problems too, Lockdep has
>    e.i. the code is going more complicated and getting bigger than what
>    it actually needs.
> 
>    2. A new tool
> 
>    I implemented a deadlock detection tool from the scratch by tracking
>    waits and event, not acquisition or release - it was inevitable to
>    rely on BFS as Lockdep does tho. I should admit this is not as mature
>    as Lockdep so needs to be improved more esp. stability. However, I'm
>    strongly convinced that it's the right way to go with and it does
>    exactly what a deadlock detection tool should do.
> 
>    However, again, the new tool has just been implemented so may not
>    cover R6 enough. So I need you guys to work together... FYI, see the
>    link, https://lkml.org/lkml/2020/11/23/236 for the patches. The work
>    is based on the mainline v5.9.
> 
>    NOTE: It's worth noting that the new tool is not perfect for now. For
>    example, it has yet to support non-recursive read lock depenency. It
>    would not be that hard work tho.
> 
> I've asked you for your opinion in https://lkml.org/lkml/2020/11/11/19
> one day, and someone answered like re-introducing Cross-release looks
> better. However, I decided to write this posting again and lastly
> because I thought I didn't explain the rationale, each pros and cons
> enough. Just this last time and then I'll stop asking any more.
> 
> It would not be that important to doing something onto the kernel code
> but the right direction definitely should be more important. I want to
> discuss the direction and decision wrt the tool based on the facts, good
> things, and bad things without bias. Whatever decision will be made, I'd
> like to go work with it and ask you for working together once it's made.
> 
> Either Cross-release or the new tool, let me go with any. Could you give
> your opinions? It would be appreciated.
> 
> Thank you!
> Byungchul
> 
> ---
> 
> P.S. Trivial thing... but I'd like to mention one thing. From what I
> heard, you got overwhelmed by a ton of reports when you allowed Lockdep
> to multi-report. It's because Lockdep is not designed to work nicely
> with irq related deadlock like "irq enable -> acqusition within the irq"
> cases. It's gonna certainly overwhelm kmsg with the current design.
> 
> When it comes to irq related deadlock, it would be a better decision to
> report only the shortest path in the dependency tree - assuming the tree
> reflects irq related dependencies as well - which means the most likely
> case. I tested the test case and found it didn't overwhelm even with
> multiple reporting on.
> 
> Multiple reporting with Dept looks quite helpful from my experience. If
> you doubt, I'd recommend to try to see what's gonna happen with Dept on
> v5.9 with your system. Refer to the link above for the patches.
