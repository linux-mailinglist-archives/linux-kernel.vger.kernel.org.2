Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9D23DA6AC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 16:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237142AbhG2Okt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 10:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236316AbhG2Okr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 10:40:47 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041D8C061765
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 07:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=XXXGPVbUtM63Ir5TC4U5Jij2IbfjB6HVpTrUj382oIg=; b=AFc7WkG03Gg8NRhInaZtGoWbV/
        kCEn5jUnjl3TzXtZLkfEuAPX8MWwHwUbYtqhw3cgbtNw8p7s5FnbIyXX4kCxIM2F/mGdzgYQX8xGB
        FK60dBcOatKTLF+8/tJBydD+4+R3doQHBlulj8Ec/fK0C/Mkd64BGQOo0LEXbx1ouu1lrkaW2Tz/W
        Z9zu48jEvkI5qd4VJdX0TrkyuDJgUNxOXdGFZfo96rU/7Ct73kVOH8stFZOaugTPQkHwKxKn/F4Cn
        c0AKRulQpLUZj5/E9Lb7ubIAH+ww/uI3WiaCHWeCRt9ced+aOVf8sz+SWAKG+QkIvqnxVq6oQG3m2
        yf3HDr0A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m97Cr-003yzO-U9; Thu, 29 Jul 2021 14:40:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0AD12300215;
        Thu, 29 Jul 2021 16:40:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D063721396218; Thu, 29 Jul 2021 16:40:14 +0200 (CEST)
Date:   Thu, 29 Jul 2021 16:40:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, paulmck@kernel.org,
        akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
        chenhuacai@gmail.com, guoren@kernel.org, geert@linux-m68k.org,
        chenhuacai@loongson.cn, mingo@redhat.com, arnd@arndb.de,
        wangrui@loongson.cn, lixuefeng@loongson.cn, jiaxun.yang@flygoat.com
Subject: [PATCH] Documentation/atomic_t: Document forward progress
 expectations
Message-ID: <YQK9ziyogxTH0m9H@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Add a few words on forward progress; there's been quite a bit of
confusion on the subject.

Specifically, more complex locking primitives (ticket/qspinlock) require
forward progress from their consituent operations in order to provide
better/more guarantees than TaS locks.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Will Deacon <will@kernel.org>
Acked-by: Boqun Feng <boqun.feng@gmail.com>
---
--- a/Documentation/atomic_t.txt
+++ b/Documentation/atomic_t.txt
@@ -312,3 +312,56 @@ Both provide the same functionality, but
 
 NB. try_cmpxchg() also generates better code on some platforms (notably x86)
 where the function more closely matches the hardware instruction.
+
+
+FORWARD PROGRESS
+----------------
+
+In general strong forward progress is expected of all unconditional atomic
+operations -- those in the Arithmetic and Bitwise classes and xchg(). However
+a fair amount of code also requires forward progress from the conditional
+atomic operations.
+
+Specifically 'simple' cmpxchg() loops are expected to not starve one another
+indefinitely. However, this is not evident on LL/SC architectures, because
+while an LL/SC architecure 'can/should/must' provide forward progress
+guarantees between competing LL/SC sections, such a guarantee does not
+transfer to cmpxchg() implemented using LL/SC. Consider:
+
+  old = atomic_read(&v);
+  do {
+    new = func(old);
+  } while (!atomic_try_cmpxchg(&v, &old, new));
+
+which on LL/SC becomes something like:
+
+  old = atomic_read(&v);
+  do {
+    new = func(old);
+  } while (!({
+    volatile asm ("1: LL  %[oldval], %[v]\n"
+                  "   CMP %[oldval], %[old]\n"
+                  "   BNE 2f\n"
+                  "   SC  %[new], %[v]\n"
+                  "   BNE 1b\n"
+                  "2:\n"
+                  : [oldval] "=&r" (oldval), [v] "m" (v)
+		  : [old] "r" (old), [new] "r" (new)
+                  : "memory");
+    success = (oldval == old);
+    if (!success)
+      old = oldval;
+    success; }));
+
+However, even the forward branch from the failed compare can cause the LL/SC
+to fail on some architectures, let alone whatever the compiler makes of the C
+loop body. As a result there is no guarantee what so ever the cacheline
+containing @v will stay on the local CPU and progress is made.
+
+Even native CAS architectures can fail to provide forward progress for their
+primitive (See Sparc64 for an example).
+
+Such implementations are strongly encouraged to add exponential backoff loops
+to a failed CAS in order to ensure some progress. Affected architectures are
+also strongly encouraged to inspect/audit the atomic fallbacks, refcount_t and
+their locking primitives.
