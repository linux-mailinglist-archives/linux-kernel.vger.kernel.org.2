Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8469D3A5FD8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 12:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbhFNKUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 06:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbhFNKUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 06:20:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A165C061574
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 03:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=64hwdugAIIv9kNHOATPjXIzNXpsGWBoWUpDeMqDSaN0=; b=RyUh4xEYN+8hlAaPXhDFHRA1OF
        NbKG0YTIS4CWXyAHTwlXPCtxJgvHNSUserDHrp5sJl34QnqU4y7dL4c3Vzq9yFkKqy6LCkI7QoTJD
        hXn0DtwoIBwmkgpZll5AAvRl4+3tesFjFuhD6mTs6VAEkcVuHNJf9P46kar7T8sAXB0dRLh1SOrmk
        ea10h3LwMX621mJDNLEVlDQSXgHThDTJJC4Gmtz/qJeUOT7SvqR1/0Sz1TuJHeRiE4UdGz9avfFc1
        d6MQSYp8FV0UUBQYwFRMdRhA+2aE9Sn251OhlpEzkmBXPgPOQX0SgwP1l3Lh8o2/0tk5ql9gcQVN4
        cb+Iz4YA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lsjen-005GD8-8v; Mon, 14 Jun 2021 10:17:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C838F3001E3;
        Mon, 14 Jun 2021 12:17:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9C7CE2027ABE6; Mon, 14 Jun 2021 12:17:21 +0200 (CEST)
Date:   Mon, 14 Jun 2021 12:17:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, oberpar@linux.ibm.com, linux-kernel@vger.kernel.org
Cc:     johannes.berg@intel.com, ndesaulniers@google.com,
        nathan@kernel.org, keescook@chromium.org, elver@google.com,
        mark.rutland@arm.com
Subject: [PATCH] gcov,x86: Mark GCOV broken for x86
Message-ID: <YMcssV/n5IBGv4f0@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


As recently discovered, there is no function attribute to disable the
-fprofile-generate instrumentation. As such, GCOV is fundamentally
incompatible with architectures that rely on 'noinstr' for correctness.

Until such time as that compilers have added a function attribute to
disable this instrumentation, mark GCOV as broken.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/Kconfig    | 2 +-
 kernel/gcov/Kconfig | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 86dae426798b..c0f8c9d4c31a 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -75,7 +75,7 @@ config X86
 	select ARCH_HAS_FAST_MULTIPLIER
 	select ARCH_HAS_FILTER_PGPROT
 	select ARCH_HAS_FORTIFY_SOURCE
-	select ARCH_HAS_GCOV_PROFILE_ALL
+	select ARCH_HAS_GCOV_BROKEN
 	select ARCH_HAS_KCOV			if X86_64 && STACK_VALIDATION
 	select ARCH_HAS_MEM_ENCRYPT
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
diff --git a/kernel/gcov/Kconfig b/kernel/gcov/Kconfig
index 58f87a3092f3..74b028a66ebe 100644
--- a/kernel/gcov/Kconfig
+++ b/kernel/gcov/Kconfig
@@ -1,10 +1,14 @@
 # SPDX-License-Identifier: GPL-2.0-only
 menu "GCOV-based kernel profiling"
 
+config ARCH_HAS_GCOV_BROKEN
+	def_bool n
+
 config GCOV_KERNEL
 	bool "Enable gcov-based kernel profiling"
 	depends on DEBUG_FS
 	depends on !CC_IS_CLANG || CLANG_VERSION >= 110000
+	depends on !ARCH_HAS_GCOV_BROKEN
 	select CONSTRUCTORS
 	default n
 	help
