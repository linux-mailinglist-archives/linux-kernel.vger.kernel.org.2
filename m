Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3E88383C4E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 20:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237087AbhEQSdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 14:33:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:39898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237050AbhEQSc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 14:32:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DE86960FD8;
        Mon, 17 May 2021 18:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621276302;
        bh=Fxpe+QB7sQgi1r4WTLIIc0qePivJrHj1sVwQWdo0XlA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=kuH/HHRw116WwoMW9lKI8H1aP/GF0MCSyvx1/MH9CoZLQqUywVAWvP1l6T7NvCMkM
         dTCShO4ZcZiL9i3vh4L20E+g2e70sHpsUUtYCIqbFdlg6b/h3QARhBwCr8Seka5qSO
         3kBEpaRiS+TWsGWb0qCw1merxLwqY/IEAvCIkqdv6loqP7oYQ8uLiY6ZJBxcKJkIcn
         Tp0edXOOJbx7og1puIA+jYY1yXwOpENZfI0E1grMpSph0ASbMdQOqd1CbD7g+XryEI
         SP3YFld0m7gOdyeRdeKsW/rCXOTIXHypV+YjsDGLb5/VipnIIpUysjBjJHFhXBdiKZ
         jTsSC1skfxLRA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A18F95C00C6; Mon, 17 May 2021 11:31:42 -0700 (PDT)
Date:   Mon, 17 May 2021 11:31:42 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Manfred Spraul <manfred@colorfullife.com>
Cc:     kasan-dev <kasan-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>, 1vier1@web.de
Subject: Re: ipc/sem, ipc/msg, ipc/mqueue.c kcsan questions
Message-ID: <20210517183142.GB2013824@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <a9b36c77-dc42-4ab2-9740-f27b191dd403@colorfullife.com>
 <20210512201743.GW975577@paulmck-ThinkPad-P17-Gen-1>
 <343390da-2307-442e-8073-d1e779c85eeb@colorfullife.com>
 <20210513190201.GE975577@paulmck-ThinkPad-P17-Gen-1>
 <9c9739ec-1273-5137-7b6d-00a27a22ffca@colorfullife.com>
 <20210514184455.GJ975577@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514184455.GJ975577@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 11:44:55AM -0700, Paul E. McKenney wrote:
> On Fri, May 14, 2021 at 07:41:02AM +0200, Manfred Spraul wrote:
> > On 5/13/21 9:02 PM, Paul E. McKenney wrote:
> > > On Thu, May 13, 2021 at 08:10:51AM +0200, Manfred Spraul wrote:
> > > > On 5/12/21 10:17 PM, Paul E. McKenney wrote:

[ . . . ]

> > > > > 	int foo;
> > > > > 	DEFINE_RWLOCK(foo_rwlock);
> > > > > 
> > > > > 	void update_foo(int newval)
> > > > > 	{
> > > > > 		write_lock(&foo_rwlock);
> > > > > 		foo = newval;
> > > > > 		do_something(newval);
> > > > > 		write_unlock(&foo_rwlock);
> > > > > 	}
> > > > > 
> > > > > 	int read_foo(void)
> > > > > 	{
> > > > > 		int ret;
> > > > > 
> > > > > 		read_lock(&foo_rwlock);
> > > > > 		do_something_else();
> > > > > 		ret = foo;
> > > > > 		read_unlock(&foo_rwlock);
> > > > > 		return ret;
> > > > > 	}
> > > > > 
> > > > > 	int read_foo_diagnostic(void)
> > > > > 	{
> > > > > 		return data_race(foo);
> > > > > 	}
> > > > The text didn't help, the example has helped:
> > > > 
> > > > It was not clear to me if I have to use data_race() both on the read and the
> > > > write side, or only on one side.
> > > > 
> > > > Based on this example: plain C may be paired with data_race(), there is no
> > > > need to mark both sides.
> > > Actually, you just demonstrated that this example is quite misleading.
> > > That data_race() works only because the read is for diagnostic
> > > purposes.  I am queuing a commit with your Reported-by that makes
> > > read_foo_diagnostic() just do a pr_info(), like this:
> > > 
> > > 	void read_foo_diagnostic(void)
> > > 	{
> > > 		pr_info("Current value of foo: %d\n", data_race(foo));
> > > 	}
> > > 
> > > So thank you for that!
> > 
> > I would not like this change at all.
> > Assume you chase a rare bug, and notice an odd pr_info() output.
> > It will take you really long until you figure out that a data_race() mislead
> > you.
> > Thus for a pr_info(), I would consider READ_ONCE() as the correct thing.
> 
> It depends, but I agree with a general preference for READ_ONCE() over
> data_race().
> 
> However, for some types of concurrency designs, using a READ_ONCE()
> can make it more difficult to enlist KCSAN's help.  For example, if this
> variable is read or written only while holding a particular lock, so that
> read_foo_diagnostic() is the only lockless read, then using READ_ONCE()
> adds a concurrent read.  In RCU, the updates would now need WRITE_ONCE(),
> which would cause KCSAN to fail to detect a buggy lockless WRITE_ONCE().
> If data_race() is used, then adding a buggy lockless WRITE_ONCE() will
> cause KCSAN to complain.
> 
> Of course, you would be quite correct to say that this must be balanced
> against the possibility of a messed-up pr_info() due to compiler mischief.
> Tradeoffs, tradeoffs!  ;-)
> 
> I should document this tradeoff, shouldn't I?

Except that Marco Elver reminds me that there are two other possibilities:

1.	data_race(READ_ONCE(foo)), which both suppresses compiler
	optimizations and causes KCSAN to ignore the access.

2.	"void __no_kcsan read_foo_diagnostic(void)" to cause KCSAN to
	ignore the entire function, and READ_ONCE() on the access.

So things might be the way you want anyway.  Does the patch below work
for you?

							Thanx, Paul


------------------------------------------------------------------------

diff --git a/tools/memory-model/Documentation/access-marking.txt b/tools/memory-model/Documentation/access-marking.txt
index fe4ad6d12d24..e3012f666e62 100644
--- a/tools/memory-model/Documentation/access-marking.txt
+++ b/tools/memory-model/Documentation/access-marking.txt
@@ -279,19 +279,34 @@ tells KCSAN that data races are expected, and should be silently
 ignored.  This data_race() also tells the human reading the code that
 read_foo_diagnostic() might sometimes return a bogus value.
 
-However, please note that your kernel must be built with
-CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=n in order for KCSAN to
-detect a buggy lockless write.  If you need KCSAN to detect such a
-write even if that write did not change the value of foo, you also
-need CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY=n.  If you need KCSAN to
-detect such a write happening in an interrupt handler running on the
-same CPU doing the legitimate lock-protected write, you also need
-CONFIG_KCSAN_INTERRUPT_WATCHER=y.  With some or all of these Kconfig
-options set properly, KCSAN can be quite helpful, although it is not
-necessarily a full replacement for hardware watchpoints.  On the other
-hand, neither are hardware watchpoints a full replacement for KCSAN
-because it is not always easy to tell hardware watchpoint to conditionally
-trap on accesses.
+If it is necessary to suppress compiler optimization and also detect
+buggy lockless writes, read_foo_diagnostic() can be updated as follows:
+
+	void read_foo_diagnostic(void)
+	{
+		pr_info("Current value of foo: %d\n", data_race(READ_ONCE(foo)));
+	}
+
+Alternatively, given that KCSAN is to ignore all accesses in this function,
+this function can be marked __no_kcsan and the data_race() can be dropped:
+
+	void __no_kcsan read_foo_diagnostic(void)
+	{
+		pr_info("Current value of foo: %d\n", READ_ONCE(foo));
+	}
+
+However, in order for KCSAN to detect buggy lockless writes, your kernel
+must be built with CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=n.  If you
+need KCSAN to detect such a write even if that write did not change
+the value of foo, you also need CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY=n.
+If you need KCSAN to detect such a write happening in an interrupt handler
+running on the same CPU doing the legitimate lock-protected write, you
+also need CONFIG_KCSAN_INTERRUPT_WATCHER=y.  With some or all of these
+Kconfig options set properly, KCSAN can be quite helpful, although
+it is not necessarily a full replacement for hardware watchpoints.
+On the other hand, neither are hardware watchpoints a full replacement
+for KCSAN because it is not always easy to tell hardware watchpoint to
+conditionally trap on accesses.
 
 
 Lock-Protected Writes With Lockless Reads
