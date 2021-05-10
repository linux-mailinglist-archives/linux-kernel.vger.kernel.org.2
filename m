Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9B97377F81
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 11:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbhEJJkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 05:40:20 -0400
Received: from foss.arm.com ([217.140.110.172]:50434 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230093AbhEJJkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 05:40:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 495A211B3;
        Mon, 10 May 2021 02:39:13 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1CFA23F73B;
        Mon, 10 May 2021 02:39:09 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org, will@kernel.org,
        boqun.feng@gmail.com, peterz@infradead.org
Cc:     aou@eecs.berkeley.edu, arnd@arndb.de, bcain@codeaurora.org,
        benh@kernel.crashing.org, chris@zankel.net, dalias@libc.org,
        davem@davemloft.net, deanbo422@gmail.com, deller@gmx.de,
        geert@linux-m68k.org, green.hu@gmail.com, guoren@kernel.org,
        ink@jurassic.park.msu.ru, James.Bottomley@HansenPartnership.com,
        jcmvbkbc@gmail.com, jonas@southpole.se, ley.foon.tan@intel.com,
        linux@armlinux.org.uk, mark.rutland@arm.com, mattst88@gmail.com,
        monstr@monstr.eu, mpe@ellerman.id.au, nickhu@andestech.com,
        palmer@dabbelt.com, paulus@samba.org, paul.walmsley@sifive.com,
        rth@twiddle.net, shorne@gmail.com,
        stefan.kristiansson@saunalahti.fi, tsbogend@alpha.franken.de,
        vgupta@synopsys.com, ysato@users.sourceforge.jp
Subject: [PATCH 02/33] locking/atomic: net: use linux/atomic.h for xchg & cmpxchg
Date:   Mon, 10 May 2021 10:37:22 +0100
Message-Id: <20210510093753.40683-3-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210510093753.40683-1-mark.rutland@arm.com>
References: <20210510093753.40683-1-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As xchg*() and cmpxchg*() may be instrumented by atomic-instrumented.h,
it's necessary to include <linux/atomic.h> to use these, rather than
<asm/cmpxchg.h>, which is effectively an arch-internal header.

In a couple of places we include <asm/cmpxchg.h>, but get away with this
as <linux/atomic.h> gets pulled in inidrectly by another include. Before
we convert more architectures to use atomic-instrumented.h, let's fix
these up to use <linux/atomic.h> so that we don't make things more
fragile.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
---
 net/core/filter.c          | 2 +-
 net/sunrpc/xprtmultipath.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index cae56d08a670..ce4ae1a19a71 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -17,6 +17,7 @@
  * Kris Katterjohn - Added many additional checks in bpf_check_classic()
  */
 
+#include <linux/atomic.h>
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/mm.h>
@@ -41,7 +42,6 @@
 #include <linux/timer.h>
 #include <linux/uaccess.h>
 #include <asm/unaligned.h>
-#include <asm/cmpxchg.h>
 #include <linux/filter.h>
 #include <linux/ratelimit.h>
 #include <linux/seccomp.h>
diff --git a/net/sunrpc/xprtmultipath.c b/net/sunrpc/xprtmultipath.c
index 78c075a68c04..1b4073131c6f 100644
--- a/net/sunrpc/xprtmultipath.c
+++ b/net/sunrpc/xprtmultipath.c
@@ -7,13 +7,13 @@
  * Trond Myklebust <trond.myklebust@primarydata.com>
  *
  */
+#include <linux/atomic.h>
 #include <linux/types.h>
 #include <linux/kref.h>
 #include <linux/list.h>
 #include <linux/rcupdate.h>
 #include <linux/rculist.h>
 #include <linux/slab.h>
-#include <asm/cmpxchg.h>
 #include <linux/spinlock.h>
 #include <linux/sunrpc/xprt.h>
 #include <linux/sunrpc/addr.h>
-- 
2.11.0

