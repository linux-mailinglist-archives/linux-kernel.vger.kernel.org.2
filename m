Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD3B350899
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 22:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbhCaUzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 16:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbhCaUzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 16:55:07 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A6CC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 13:55:07 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id s11so9361460pfm.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 13:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uk0/1LocoDticB91SF6FsgWpOKPsEr1Pb6N+E6L28KI=;
        b=nMBirdlJwaYEBDE8wICv0IcZbYumBG5x88i0jDmsPtEGCWerkbUkn/zXjtlou+AAnB
         CdCWfgp1k4EvjGaJ2pw+8HaBQeHDD+DkwHQbkP6CfxrFShjNk6a9uKNXN3ySmAr3ly/v
         g28hvtAPNP3f2K6+JoZ04rIfIXHvlInu+TnD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uk0/1LocoDticB91SF6FsgWpOKPsEr1Pb6N+E6L28KI=;
        b=YvjByJPq21cubpek5F+5XtdYScjv9W8hLLkt+IvyAsS0P22aRyvG5zbZMujtLdd9PY
         6P4oexcVONKk01Eyo83s7jlqWDN/IrWYOd5Uco4Xc3dk2qs7ug4QV3kNtxv7UfIMcHL0
         ckbsQicZIBVqrLmpRwJezkuUZRUd78AaAh9BJTlUaBH7mK/t9AGcF2swbWEV+0Kup4zq
         QlwXgjFQ4EKYTZ2aS0PUSmAiDS4jTDK55IGH870pWQGZKDMeVSGp1zc3OIa5X8cOUcFg
         4hCeHfZWq2BNhbN47OvimBbAzQtGCMIGHJUDQuZ12O4p8L7iGP6F+wXotRbfKgQ0bIYS
         J1+A==
X-Gm-Message-State: AOAM531VW3Ctw7k563LCFAGeZMpp/Ya3hSxIx/ylWZLiwC+K1UQaWjLh
        XRl7spJQdc74mRY/yC1tCFg5Dg==
X-Google-Smtp-Source: ABdhPJxuZ4BQCPoxOylqJ3K76DbwLF1JG4WceF9FhoFaFhbPpIbgQh3MG6jfYpIbOhAacKq366q+2w==
X-Received: by 2002:a63:4d0:: with SMTP id 199mr4929010pge.304.1617224106706;
        Wed, 31 Mar 2021 13:55:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k3sm3300550pgq.21.2021.03.31.13.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 13:55:06 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Potapenko <glider@google.com>,
        Alexander Popov <alex.popov@linux.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jann Horn <jannh@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 6/6] lkdtm: Add REPORT_STACK for checking stack offsets
Date:   Wed, 31 Mar 2021 13:54:58 -0700
Message-Id: <20210331205458.1871746-7-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210331205458.1871746-1-keescook@chromium.org>
References: <20210331205458.1871746-1-keescook@chromium.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=fb815901a1ccc1d9c4ca5c3e3cd3729b7f382fe2; i=b69wRsxT78r/3tM1mGa7N6ME6+rlXyFg15giRWRwPAQ=; m=aFqgiEE+nAZdug79A1F+fVTg9ZceUb0WPE8cbHqssVg=; p=ZQ32/kILkW5AD3nBZHO0VMTp4prIPkm7+DdhCHX8KdA=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmBk4aIACgkQiXL039xtwCbSHQ/9GzS gwvyLm8xntGCfjZejzEAhSquCH/XGhwif40B/hY9NAzXrbKiOwzU378qbpWgxBePgTlGb3sKLB76C BHzMBpf5qbdOAWFHSbdkoLA6VoZ1Kc3Dv9lcZSpDekbhvjLhR4V2Up7yRhqEThy93+6AVcwGzBeac 6QWH01G3TAAqKsFLpV9ZjQOFxfS/obFaV/xK3RDHbKoY2jf6sGJnK2Y9hxRZMfyEnp2BFg0kdKSUr 0z5xDyHM3Xb+7TwBGwqGzP+TwPUBrXWtXKAjslca0S4ZQE/HBo8zsilyPvfhCl2T+esWB9qNJZbtx F6wRFNO6xcNLkF9VMP+8KyI2ikBpFMuEDmouAY3QkyENQiacPe4k9q5vDMvoe3EU/3NbOlJaO/0pw zbKdqFzN5b1HaJ3rgpeElBRbDH+CwqFTApO1mqZoi7KDqHaTym70Phz2P6Sovw36ctUn239DBf3Oi pEGi7NduC0vXBzrKcsFkivSl3imbBCo8t+qK+Ah4Nauc16qTQzMXY/twnQTuci/QVKWeq2BFnxBRK aOqgMXU7IVl7fXQL3QqIPaOez0kfnckLCHLNHqYEqVW1Zzgv+3gmrg12l5NAMYP2S2yWkU60izEcP dZeEdUXsNKOPqT0E3QzWksz9tPpec3mAH42JwcVawRfuRleF4XoNyiqWIrkXk9is=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For validating the stack offset behavior, report the offset from a given
process's first seen stack address. A quick way to measure the entropy:

for i in $(seq 1 1000); do
	echo "REPORT_STACK" >/sys/kernel/debug/provoke-crash/DIRECT
done
offsets=$(dmesg | grep 'Stack offset' | cut -d: -f3 | sort | uniq -c | sort -n | wc -l)
echo "$(uname -m) bits of stack entropy: $(echo "obase=2; $offsets" | bc | wc -L)"

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/misc/lkdtm/bugs.c  | 17 +++++++++++++++++
 drivers/misc/lkdtm/core.c  |  1 +
 drivers/misc/lkdtm/lkdtm.h |  1 +
 3 files changed, 19 insertions(+)

diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
index 110f5a8538e9..0e8254d0cf0b 100644
--- a/drivers/misc/lkdtm/bugs.c
+++ b/drivers/misc/lkdtm/bugs.c
@@ -134,6 +134,23 @@ noinline void lkdtm_CORRUPT_STACK_STRONG(void)
 	__lkdtm_CORRUPT_STACK((void *)&data);
 }
 
+static pid_t stack_pid;
+static unsigned long stack_addr;
+
+void lkdtm_REPORT_STACK(void)
+{
+	volatile uintptr_t magic;
+	pid_t pid = task_pid_nr(current);
+
+	if (pid != stack_pid) {
+		pr_info("Starting stack offset tracking for pid %d\n", pid);
+		stack_pid = pid;
+		stack_addr = (uintptr_t)&magic;
+	}
+
+	pr_info("Stack offset: %d\n", (int)(stack_addr - (uintptr_t)&magic));
+}
+
 void lkdtm_UNALIGNED_LOAD_STORE_WRITE(void)
 {
 	static u8 data[5] __attribute__((aligned(4))) = {1, 2, 3, 4, 5};
diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
index b2aff4d87c01..8024b6a5cc7f 100644
--- a/drivers/misc/lkdtm/core.c
+++ b/drivers/misc/lkdtm/core.c
@@ -110,6 +110,7 @@ static const struct crashtype crashtypes[] = {
 	CRASHTYPE(EXHAUST_STACK),
 	CRASHTYPE(CORRUPT_STACK),
 	CRASHTYPE(CORRUPT_STACK_STRONG),
+	CRASHTYPE(REPORT_STACK),
 	CRASHTYPE(CORRUPT_LIST_ADD),
 	CRASHTYPE(CORRUPT_LIST_DEL),
 	CRASHTYPE(STACK_GUARD_PAGE_LEADING),
diff --git a/drivers/misc/lkdtm/lkdtm.h b/drivers/misc/lkdtm/lkdtm.h
index 5ae48c64df24..99f90d3e5e9c 100644
--- a/drivers/misc/lkdtm/lkdtm.h
+++ b/drivers/misc/lkdtm/lkdtm.h
@@ -17,6 +17,7 @@ void lkdtm_LOOP(void);
 void lkdtm_EXHAUST_STACK(void);
 void lkdtm_CORRUPT_STACK(void);
 void lkdtm_CORRUPT_STACK_STRONG(void);
+void lkdtm_REPORT_STACK(void);
 void lkdtm_UNALIGNED_LOAD_STORE_WRITE(void);
 void lkdtm_SOFTLOCKUP(void);
 void lkdtm_HARDLOCKUP(void);
-- 
2.25.1

