Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4E235F431
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 14:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347216AbhDNMqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 08:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233671AbhDNMqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 08:46:15 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94728C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 05:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QDlL+offzqBR8/8ljKZKG+TOPSgr5bGaMNneqpmzy3Q=; b=gMyW7TA5Mnl7S70eeXJzae4bD4
        PatUg9WGAhao4nhRO91GNw1b9rXEvksVWPhUvNwwUWJ+bYyOyLR+eVont2+XK20jLNQA5Hq5X/5ma
        hjOq5sP7To3cco8+Z+DGi8bMwR6OWO5ttk3fHqOyyxzfHwryEMVrUm4728vcQCd+3lljcOSCGtbel
        db6hG/UUEePBMbcHlwErkZPdxv60M7lGa2G18ag/beDBvxYN7Na3hhnjZCNFxhoaRT1x0ElVCYFkS
        k7gGnhBOMN0emJvMXVNqN7OJG7qLooa0TaD9h6QsLwC4+OmChPFxGDzCHN49hYzCcENFdDhRSCuK/
        GrrhQaKg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lWets-00Ccwo-Eh; Wed, 14 Apr 2021 12:45:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 88DDF30015A;
        Wed, 14 Apr 2021 14:45:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4DF3F203CF7D2; Wed, 14 Apr 2021 14:45:43 +0200 (CEST)
Date:   Wed, 14 Apr 2021 14:45:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     Christoph =?iso-8859-1?Q?M=FCllner?= <christophm30@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, shorne@gmail.com
Subject: Re: [RFC][PATCH] locking: Generic ticket-lock
Message-ID: <YHbj987Ks0JOKw/X@hirez.programming.kicks-ass.net>
References: <CAHB2gtS9J09VaY9ZxDJYVo2fTgS-u6p7e89aLCnwOHnYEOJR=g@mail.gmail.com>
 <mhng-03d1655e-090e-4afb-a4e3-12b4b8f0e6bf@palmerdabbelt-glaptop>
 <CAHB2gtS6x25Oquf6W4Hhh-diUuZk1GJHTD2DjrffHo93nWbUYw@mail.gmail.com>
 <YHVQNSfblP6G0Kgl@hirez.programming.kicks-ass.net>
 <YHVTgfCpxpINc8sM@hirez.programming.kicks-ass.net>
 <CAJF2gTQaF8wBCp-L6vgJPcu6EnFRWmh_qZMX2PiEfj0Z70-Ykg@mail.gmail.com>
 <YHaU4uxr6emrivuu@hirez.programming.kicks-ass.net>
 <YHawVOIHmDPbTmoB@hirez.programming.kicks-ass.net>
 <YHbBBuVFNnI4kjj3@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHbBBuVFNnI4kjj3@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 12:16:38PM +0200, Peter Zijlstra wrote:
> On Wed, Apr 14, 2021 at 11:05:24AM +0200, Peter Zijlstra wrote:
> 
> > That made me look at the qspinlock code, and queued_spin_*lock() uses
> > atomic_try_cmpxchg_acquire(), which means any arch that uses qspinlock
> > and has RCpc atomics will give us massive pain.
> > 
> > Current archs using qspinlock are: x86, arm64, power, sparc64, mips and
> > openrisc (WTF?!).
> > 
> > Of those, x86 and sparc are TSO archs with SC atomics, arm64 has RCsc
> > atomics, power has RCtso atomics (and is the arch we all hate for having
> > RCtso locks).
> > 
> > Now MIPS has all sorts of ill specified barriers, but last time looked
> > at it it didn't actually use any of that and stuck to using smp_mb(), so
> > it will have RCsc atomics.
> > 
> > /me goes look at wth openrisc is..  doesn't even appear to have
> > asm/barrier.h :-/ Looking at wikipedia it also doesn't appear to
> > actually have hardware ...
> 
> FWIW this is broken, anything SMP *MUST* define mb(), at the very least.

As near as I can tell this should do. The arch spec only lists this one
instruction and the text makes it sound like a completion barrier.

---
 arch/openrisc/include/asm/barrier.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/openrisc/include/asm/barrier.h b/arch/openrisc/include/asm/barrier.h
new file mode 100644
index 000000000000..7538294721be
--- /dev/null
+++ b/arch/openrisc/include/asm/barrier.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_BARRIER_H
+#define __ASM_BARRIER_H
+
+#define mb() asm volatile ("l.msync" ::: "memory")
+
+#include <asm-generic/barrier.h>
+
+#endif /* __ASM_BARRIER_H */
