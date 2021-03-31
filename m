Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAE4A34F2A9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 22:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbhC3U6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 16:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbhC3U56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 16:57:58 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDCAC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 13:57:56 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id x26so13029042pfn.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 13:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uk0/1LocoDticB91SF6FsgWpOKPsEr1Pb6N+E6L28KI=;
        b=VEbugQSfiOADsXzibGQhy5NOUchekygaO5w+6aKv6mqyA4ZN905sZ3owmH5AiDEAWr
         y1WGVRmoaiaTXLZw321i7qk6pkHyhNFc2ebrQQ9viIxgTTISjvfl3iT2WLVNayRJuoPG
         sJuIKeFRY9nWrNFtLzOixlEPRhRvLB5pYBi6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uk0/1LocoDticB91SF6FsgWpOKPsEr1Pb6N+E6L28KI=;
        b=QChfT6GWSnpxDAJvVGHbUNKtR+S3+UWIQ5dPbogJP1Mu/78MVqiVYvLIx7tTLFUmwD
         xS1ln6XK+rajIGhBDlcdj8sLqTbWuMfNQKIil9q0pfSn3AtCahhcU+tonTLfonm1dSfR
         HIBWvpKkJZPoLjAvH8wpg5Emh+jVYk7If0OTHXH/nGWsUKHq2pWf68dGrO7iYa4hBE8e
         Kk26R4uGn8Bwh/xByzprK1KTi6uZvLC7ECOr14Z48tGinOTLvOYIlnPN4CIiO86qvLrv
         mGHuoLSzYKQwJI/tNasM/GFfQlV/Ld8+w6yHucu+9FB4aOHfPJE/iTootnvWucPi1QFz
         U94Q==
X-Gm-Message-State: AOAM532D5t47oYYWqGeynQO5/hrhhQ3fbA+P0ofYYBdwb1eO3uTJqosC
        WUl3S19fo6qXaFVASpuXtOXvXw==
X-Google-Smtp-Source: ABdhPJyU4QoLUAtSD+TbLRFmZhWwHD39ZMTbzgcT3JSLcSiG1GLO7ZUHccc4rKehrDRN8oWr8gFqDA==
X-Received: by 2002:a63:5444:: with SMTP id e4mr38308pgm.426.1617137876539;
        Tue, 30 Mar 2021 13:57:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 82sm21209086pfv.19.2021.03.30.13.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 13:57:55 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
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
Subject: [PATCH v8 6/6] lkdtm: Add REPORT_STACK for checking stack offsets
Date:   Tue, 30 Mar 2021 13:57:50 -0700
Message-Id: <20210330205750.428816-7-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210330205750.428816-1-keescook@chromium.org>
References: <20210330205750.428816-1-keescook@chromium.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=fb815901a1ccc1d9c4ca5c3e3cd3729b7f382fe2; i=b69wRsxT78r/3tM1mGa7N6ME6+rlXyFg15giRWRwPAQ=; m=aFqgiEE+nAZdug79A1F+fVTg9ZceUb0WPE8cbHqssVg=; p=ZQ32/kILkW5AD3nBZHO0VMTp4prIPkm7+DdhCHX8KdA=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmBjkM0ACgkQiXL039xtwCYfLRAAs6I uoWwWDp21BaGNMZo2SuY7bzLTQ4wBsh1OJpZI9l3CnXGSdw3rjz7jQr547uKC02JBkmMzEZ8erZZc OXm9KVlfJUxNAf1Xj1ZCOTuB3x9+E+0QA7hUMrZqjcs42ZBPBNkSPjV9A25U9YqznQ5f+qpoKAWEj hxxEXcX+z7qRe6bJas/EC7OMxjIrCaX9Fzf9HOwub9cZbtwx0dPTxKVeITndj71Nd+oDj/2XxQI+X 9hTzBdUHech+9e7EsTReekwPnRwNq+MAzoYB3JZVfZwT7ewjdvO5Iv6CVMthHmHgut+PjTN00vPS4 OhUYWoQNcsKUhGXXhCoZZ2/MHnjMSsLG8Vpgrb3tQXhiSoeMFXtnamdiasKXt7Jc76LttUOUKyHJo ZHT6pvTFlA8E+uzixb92yFkxiRzqIEGMdMQ3OBJfI2tcnS1KMzsv+Jt1VxL3ySC4aMLFFmM2y1UeI n8OdvXvEabfQwKXEvpIfbAZ6Qm1p7zhujxc9Me7VDJ48cNcSHTtxsNzNXWsEe6PpclfeDU0SglY7l phqtiLzuKHVpdfej4wAJbkaGgOs57NUEso25NbDIc7ZM2syVxWrdxxlP4zgxViiuIq6Yr4W/79kHB 93gnDuL1EJ0D3ib6Nvf+fYfybxPTOR9bKJ+jfn7yAh++prlwwWMuNlPcPXQ0yLfA=
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

