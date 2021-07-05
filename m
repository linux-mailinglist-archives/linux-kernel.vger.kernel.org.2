Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1298B3BBE9F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 17:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbhGEPKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 11:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbhGEPKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 11:10:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2786DC061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 08:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CJaGTLejQceouKSz1weNQHZfzVJHuKCqcLvhZOUbHCY=; b=cWiagAzmF51cTRNjI4ZpwPi+Wc
        odqxRIwBt19j2AkGO5Icbp3+pvrcvvw8gkiML2KzPzJV5lZtaTaf/bku+DCd/BDgX1NxiDZa3pIE9
        REtsrQjbIl1QwcFlQpfn9Dk5Zsw8PaBboCgL0rbuGTtAH2k1edbfRs2XkIFYxgdDzi2R5KO1ZfAup
        MdaQ+NFu7MFv7ZoFNUOnvoQoL/uAs1DCA4IJpZpQr1lG+9SwJ+pCsQmnv6Gy+THHCfmZsceSEMNOS
        sTjMDoSuEJB1rkE2ElNmJXy2q99iJDesV+jRSszayDemzEWIgKZw1xl/qU6rVomOH8nSurVpC6F/H
        sIOwtl0g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m0QCF-00ALSS-6J; Mon, 05 Jul 2021 15:07:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C09DB300056;
        Mon,  5 Jul 2021 17:07:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A99C8202436F3; Mon,  5 Jul 2021 17:07:41 +0200 (CEST)
Date:   Mon, 5 Jul 2021 17:07:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Xu, Yanfei" <yanfei.xu@windriver.com>
Cc:     mingo@redhat.com, longman@redhat.com, boqun.feng@gmail.com,
        will@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation/atomic_t: Document cmpxchg() vs try_cmpxchg()
Message-ID: <YOMgPeMOmmiK3tXO@hirez.programming.kicks-ass.net>
References: <20210630153516.832731403@infradead.org>
 <20210630154114.834438545@infradead.org>
 <cac55711-585a-4e08-3b5e-a6890e2f548d@windriver.com>
 <YOMQYQr1loxIuZbU@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOMQYQr1loxIuZbU@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 05, 2021 at 04:00:01PM +0200, Peter Zijlstra wrote:

> No, when try_cmpxchg() fails it will update oldp. This is the reason old
> is now a pointer too.

Since you're not the first person confused by this, does the below
clarify?

---
Subject: Documentation/atomic_t: Document cmpxchg() vs try_cmpxchg()
From: Peter Zijlstra <peterz@infradead.org>
Date: Mon Jul  5 17:00:24 CEST 2021

There seems to be a significant amount of confusion around the 'new'
try_cmpxchg(), despite this being more like the C11
atomic_compare_exchange_*() family. Add a few words of clarification
on how cmpxchg() and try_cmpxchg() relate to one another.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 Documentation/atomic_t.txt |   41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

--- a/Documentation/atomic_t.txt
+++ b/Documentation/atomic_t.txt
@@ -271,3 +271,44 @@ because it would not order the W part of
 			SC *y, t;
 
 is allowed.
+
+
+CMPXHG vs TRY_CMPXCHG
+---------------------
+
+  int atomic_cmpxchg(atomic_t *ptr, int old, int new);
+  bool atomic_try_cmpxchg(atomic_t *ptr, int *oldp, int new);
+
+Both provide the same functionality, but try_cmpxchg() can lead to more
+compact code. The functions relate like:
+
+  bool atomic_try_cmpxchg(atomic_t *ptr, int *oldp, int new)
+  {
+    int ret, old = *oldp;
+    ret = atomic_cmpxchg(ptr, old, new);
+    if (ret != old)
+      *oldp = ret;
+    return ret == old;
+  }
+
+and:
+
+  int atomic_cmpxchg(atomic_t *ptr, int old, int new)
+  {
+    (void)atomic_try_cmpxchg(ptr, &old, new);
+    return old;
+  }
+
+Usage:
+
+  old = atomic_read(&v);			old = atomic_read(&v);
+  for (;;) {					do {
+    new = func(old);				  new = func(old);
+    tmp = atomic_cmpxchg(&v, old, new);		} while (!atomic_try_cmpxchg(&v, &old, new));
+    if (tmp == old)
+      break;
+    old = tmp;
+  }
+
+NB. try_cmpxchg() also generates better code on some platforms (notably x86)
+where the function more closely matches the hardware instruction.
