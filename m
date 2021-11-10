Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C35FC44C161
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 13:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbhKJMhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 07:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbhKJMhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 07:37:03 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1816C061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 04:34:15 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id o6-20020a17090a0a0600b001a64b9a11aeso1561183pjo.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 04:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5jRsQ3VQaNdp85wx1DEq7F8BKrVOfMFzK/yJr2JbIW4=;
        b=RuMAP1dpeI94WRFRciRPRwcMXYWGawUZO8iOw3xz7ylcln9BAhhUfmbTwWI1K6hRRS
         vZombMINtZuJbJJToC2EKFFiYOB0f4gIpMOQBovq68UtTzhaaUFZhCSNWMZfHGKDfZiN
         nv0vCmIfF7McZlGZKelq/JYWDqxk+DQo09fX6Q+WC18M9hBNWeeJ3plxMzddV6Qq0XkA
         3o4gYYL8f1wrHiBbnZqK6lf4XU5bU+KEPR6E/W1c5SkOo6TV79kky75M+pJitT7x/PQN
         02jonffOYpZGOXE1hFF8f60XjVcHFmpSS35KQ+0iYQ4HOqjfIDvnjFRekLiAq1bJfWFG
         0tdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5jRsQ3VQaNdp85wx1DEq7F8BKrVOfMFzK/yJr2JbIW4=;
        b=ySbkrxdrzQcfTAG/AY6GeAZGtbAAppwu+LfxjGSx8myVWl/5tyHBW3QF0edtf/lgxc
         gVgVAL5blGOaQicusyd3SgcOtUOBcI6qPwxe9V/n5takqkJFEIkltXQ8m62YjRy2PsEl
         2Rdgi96I7y9NeLI2yGS1pgfeYkbmFbAqTdnBOA//XrlsgUB6qsNBlBdZ54Cwaf/Ub/Hs
         X4Z+3MTz1eGHdXxQG30lvpnFENFJtfZBLhYoIEvE5cWifrhOl1pJ6fD//5GIhX87n0n7
         k67qdsdl57S3/BCRjKt5Crnb/xqzm9xmaMr46VeR46dt2/ufcOheP6sTmZ4rnU1wE6HS
         euYw==
X-Gm-Message-State: AOAM5319p9DZT9hvhDTfgJyVPzzhQeCb6vQaYhulBf4vLjIAlRoY0R2G
        EQufPQdgZYi0VyNUEnteJrK5qg==
X-Google-Smtp-Source: ABdhPJwdOrXQktkXI0n1bEneVvX8Ox90jMXATUwdV3A0oyh6eGBV+9j4c+behAcrikXoqrcbXufYng==
X-Received: by 2002:a17:90b:4b09:: with SMTP id lx9mr16597722pjb.100.1636547655264;
        Wed, 10 Nov 2021 04:34:15 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id d15sm25174816pfu.12.2021.11.10.04.34.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Nov 2021 04:34:14 -0800 (PST)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, peterz@infradead.org, mingo@redhat.com,
        david@redhat.com, kirill@shutemov.name, peterx@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        songmuchun@bytedance.com, zhouchengming@bytedance.com,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH] mm: remove redundant check about FAULT_FLAG_ALLOW_RETRY bit
Date:   Wed, 10 Nov 2021 20:33:58 +0800
Message-Id: <20211110123358.36511-1-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 4064b9827063 ("mm: allow VM_FAULT_RETRY for multiple times")
allow VM_FAULT_RETRY for multiple times, the FAULT_FLAG_ALLOW_RETRY bit
of fault_flag will not be changed in the page fault path, so the
following check no longer be needed:

	flags & FAULT_FLAG_ALLOW_RETRY

So just remove it.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 arch/alpha/mm/fault.c      | 16 +++++++---------
 arch/arc/mm/fault.c        |  3 +--
 arch/arm/mm/fault.c        |  2 +-
 arch/arm64/mm/fault.c      |  6 ++----
 arch/hexagon/mm/vm_fault.c |  8 +++-----
 arch/ia64/mm/fault.c       | 16 +++++++---------
 arch/m68k/mm/fault.c       | 22 ++++++++++------------
 arch/microblaze/mm/fault.c | 22 ++++++++++------------
 arch/mips/mm/fault.c       | 19 +++++++++----------
 arch/nds32/mm/fault.c      | 18 ++++++++----------
 arch/nios2/mm/fault.c      | 18 ++++++++----------
 arch/openrisc/mm/fault.c   | 18 ++++++++----------
 arch/parisc/mm/fault.c     | 18 ++++++++----------
 arch/powerpc/mm/fault.c    |  6 ++----
 arch/riscv/mm/fault.c      |  2 +-
 arch/s390/mm/fault.c       | 26 ++++++++++++--------------
 arch/sh/mm/fault.c         | 20 +++++++++-----------
 arch/sparc/mm/fault_32.c   | 16 +++++++---------
 arch/sparc/mm/fault_64.c   | 16 +++++++---------
 arch/um/kernel/trap.c      |  8 +++-----
 arch/x86/mm/fault.c        |  3 +--
 arch/xtensa/mm/fault.c     | 17 ++++++++---------
 22 files changed, 132 insertions(+), 168 deletions(-)

diff --git a/arch/alpha/mm/fault.c b/arch/alpha/mm/fault.c
index eee5102c3d88..6c0a277388dd 100644
--- a/arch/alpha/mm/fault.c
+++ b/arch/alpha/mm/fault.c
@@ -165,17 +165,15 @@ do_page_fault(unsigned long address, unsigned long mmcsr,
 		BUG();
 	}
 
-	if (flags & FAULT_FLAG_ALLOW_RETRY) {
-		if (fault & VM_FAULT_RETRY) {
-			flags |= FAULT_FLAG_TRIED;
+	if (fault & VM_FAULT_RETRY) {
+		flags |= FAULT_FLAG_TRIED;
 
-			 /* No need to mmap_read_unlock(mm) as we would
-			 * have already released it in __lock_page_or_retry
-			 * in mm/filemap.c.
-			 */
+		/* No need to mmap_read_unlock(mm) as we would
+		 * have already released it in __lock_page_or_retry
+		 * in mm/filemap.c.
+		 */
 
-			goto retry;
-		}
+		goto retry;
 	}
 
 	mmap_read_unlock(mm);
diff --git a/arch/arc/mm/fault.c b/arch/arc/mm/fault.c
index 5787c261c9a4..dad27e4d69ff 100644
--- a/arch/arc/mm/fault.c
+++ b/arch/arc/mm/fault.c
@@ -149,8 +149,7 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
 	/*
 	 * Fault retry nuances, mmap_lock already relinquished by core mm
 	 */
-	if (unlikely((fault & VM_FAULT_RETRY) &&
-		     (flags & FAULT_FLAG_ALLOW_RETRY))) {
+	if (unlikely(fault & VM_FAULT_RETRY)) {
 		flags |= FAULT_FLAG_TRIED;
 		goto retry;
 	}
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index bc8779d54a64..c7326a521a69 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -312,7 +312,7 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 		return 0;
 	}
 
-	if (!(fault & VM_FAULT_ERROR) && flags & FAULT_FLAG_ALLOW_RETRY) {
+	if (!(fault & VM_FAULT_ERROR)) {
 		if (fault & VM_FAULT_RETRY) {
 			flags |= FAULT_FLAG_TRIED;
 			goto retry;
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 9ae24e3b72be..a8fb54fccde0 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -606,10 +606,8 @@ static int __kprobes do_page_fault(unsigned long far, unsigned int esr,
 	}
 
 	if (fault & VM_FAULT_RETRY) {
-		if (mm_flags & FAULT_FLAG_ALLOW_RETRY) {
-			mm_flags |= FAULT_FLAG_TRIED;
-			goto retry;
-		}
+		mm_flags |= FAULT_FLAG_TRIED;
+		goto retry;
 	}
 	mmap_read_unlock(mm);
 
diff --git a/arch/hexagon/mm/vm_fault.c b/arch/hexagon/mm/vm_fault.c
index ef32c5a84ff3..4fac4b9eb316 100644
--- a/arch/hexagon/mm/vm_fault.c
+++ b/arch/hexagon/mm/vm_fault.c
@@ -98,11 +98,9 @@ void do_page_fault(unsigned long address, long cause, struct pt_regs *regs)
 
 	/* The most common case -- we are done. */
 	if (likely(!(fault & VM_FAULT_ERROR))) {
-		if (flags & FAULT_FLAG_ALLOW_RETRY) {
-			if (fault & VM_FAULT_RETRY) {
-				flags |= FAULT_FLAG_TRIED;
-				goto retry;
-			}
+		if (fault & VM_FAULT_RETRY) {
+			flags |= FAULT_FLAG_TRIED;
+			goto retry;
 		}
 
 		mmap_read_unlock(mm);
diff --git a/arch/ia64/mm/fault.c b/arch/ia64/mm/fault.c
index 02de2e70c587..32417f49ad2f 100644
--- a/arch/ia64/mm/fault.c
+++ b/arch/ia64/mm/fault.c
@@ -156,17 +156,15 @@ ia64_do_page_fault (unsigned long address, unsigned long isr, struct pt_regs *re
 		BUG();
 	}
 
-	if (flags & FAULT_FLAG_ALLOW_RETRY) {
-		if (fault & VM_FAULT_RETRY) {
-			flags |= FAULT_FLAG_TRIED;
+	if (fault & VM_FAULT_RETRY) {
+		flags |= FAULT_FLAG_TRIED;
 
-			 /* No need to mmap_read_unlock(mm) as we would
-			 * have already released it in __lock_page_or_retry
-			 * in mm/filemap.c.
-			 */
+		/* No need to mmap_read_unlock(mm) as we would
+		 * have already released it in __lock_page_or_retry
+		 * in mm/filemap.c.
+		 */
 
-			goto retry;
-		}
+		goto retry;
 	}
 
 	mmap_read_unlock(mm);
diff --git a/arch/m68k/mm/fault.c b/arch/m68k/mm/fault.c
index ef46e77e97a5..53cfb9bc1066 100644
--- a/arch/m68k/mm/fault.c
+++ b/arch/m68k/mm/fault.c
@@ -153,18 +153,16 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 		BUG();
 	}
 
-	if (flags & FAULT_FLAG_ALLOW_RETRY) {
-		if (fault & VM_FAULT_RETRY) {
-			flags |= FAULT_FLAG_TRIED;
-
-			/*
-			 * No need to mmap_read_unlock(mm) as we would
-			 * have already released it in __lock_page_or_retry
-			 * in mm/filemap.c.
-			 */
-
-			goto retry;
-		}
+	if (fault & VM_FAULT_RETRY) {
+		flags |= FAULT_FLAG_TRIED;
+
+		/*
+		 * No need to mmap_read_unlock(mm) as we would
+		 * have already released it in __lock_page_or_retry
+		 * in mm/filemap.c.
+		 */
+
+		goto retry;
 	}
 
 	mmap_read_unlock(mm);
diff --git a/arch/microblaze/mm/fault.c b/arch/microblaze/mm/fault.c
index b3fed2cecf84..a9626e6a68af 100644
--- a/arch/microblaze/mm/fault.c
+++ b/arch/microblaze/mm/fault.c
@@ -232,18 +232,16 @@ void do_page_fault(struct pt_regs *regs, unsigned long address,
 		BUG();
 	}
 
-	if (flags & FAULT_FLAG_ALLOW_RETRY) {
-		if (fault & VM_FAULT_RETRY) {
-			flags |= FAULT_FLAG_TRIED;
-
-			/*
-			 * No need to mmap_read_unlock(mm) as we would
-			 * have already released it in __lock_page_or_retry
-			 * in mm/filemap.c.
-			 */
-
-			goto retry;
-		}
+	if (fault & VM_FAULT_RETRY) {
+		flags |= FAULT_FLAG_TRIED;
+
+		/*
+		 * No need to mmap_read_unlock(mm) as we would
+		 * have already released it in __lock_page_or_retry
+		 * in mm/filemap.c.
+		 */
+
+		goto retry;
 	}
 
 	mmap_read_unlock(mm);
diff --git a/arch/mips/mm/fault.c b/arch/mips/mm/fault.c
index e7abda9c013f..44f98100e84e 100644
--- a/arch/mips/mm/fault.c
+++ b/arch/mips/mm/fault.c
@@ -171,18 +171,17 @@ static void __kprobes __do_page_fault(struct pt_regs *regs, unsigned long write,
 			goto do_sigbus;
 		BUG();
 	}
-	if (flags & FAULT_FLAG_ALLOW_RETRY) {
-		if (fault & VM_FAULT_RETRY) {
-			flags |= FAULT_FLAG_TRIED;
 
-			/*
-			 * No need to mmap_read_unlock(mm) as we would
-			 * have already released it in __lock_page_or_retry
-			 * in mm/filemap.c.
-			 */
+	if (fault & VM_FAULT_RETRY) {
+		flags |= FAULT_FLAG_TRIED;
 
-			goto retry;
-		}
+		/*
+		 * No need to mmap_read_unlock(mm) as we would
+		 * have already released it in __lock_page_or_retry
+		 * in mm/filemap.c.
+		 */
+
+		goto retry;
 	}
 
 	mmap_read_unlock(mm);
diff --git a/arch/nds32/mm/fault.c b/arch/nds32/mm/fault.c
index 1d139b117168..636977a1c8b9 100644
--- a/arch/nds32/mm/fault.c
+++ b/arch/nds32/mm/fault.c
@@ -230,16 +230,14 @@ void do_page_fault(unsigned long entry, unsigned long addr,
 			goto bad_area;
 	}
 
-	if (flags & FAULT_FLAG_ALLOW_RETRY) {
-		if (fault & VM_FAULT_RETRY) {
-			flags |= FAULT_FLAG_TRIED;
-
-			/* No need to mmap_read_unlock(mm) as we would
-			 * have already released it in __lock_page_or_retry
-			 * in mm/filemap.c.
-			 */
-			goto retry;
-		}
+	if (fault & VM_FAULT_RETRY) {
+		flags |= FAULT_FLAG_TRIED;
+
+		/* No need to mmap_read_unlock(mm) as we would
+		 * have already released it in __lock_page_or_retry
+		 * in mm/filemap.c.
+		 */
+		goto retry;
 	}
 
 	mmap_read_unlock(mm);
diff --git a/arch/nios2/mm/fault.c b/arch/nios2/mm/fault.c
index 9476feecf512..a32f14cd72f2 100644
--- a/arch/nios2/mm/fault.c
+++ b/arch/nios2/mm/fault.c
@@ -149,18 +149,16 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long cause,
 		BUG();
 	}
 
-	if (flags & FAULT_FLAG_ALLOW_RETRY) {
-		if (fault & VM_FAULT_RETRY) {
-			flags |= FAULT_FLAG_TRIED;
+	if (fault & VM_FAULT_RETRY) {
+		flags |= FAULT_FLAG_TRIED;
 
-			/*
-			 * No need to mmap_read_unlock(mm) as we would
-			 * have already released it in __lock_page_or_retry
-			 * in mm/filemap.c.
-			 */
+		/*
+		 * No need to mmap_read_unlock(mm) as we would
+		 * have already released it in __lock_page_or_retry
+		 * in mm/filemap.c.
+		 */
 
-			goto retry;
-		}
+		goto retry;
 	}
 
 	mmap_read_unlock(mm);
diff --git a/arch/openrisc/mm/fault.c b/arch/openrisc/mm/fault.c
index f0fa6394a58e..80bb66ad42f6 100644
--- a/arch/openrisc/mm/fault.c
+++ b/arch/openrisc/mm/fault.c
@@ -177,18 +177,16 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long address,
 		BUG();
 	}
 
-	if (flags & FAULT_FLAG_ALLOW_RETRY) {
-		/*RGD modeled on Cris */
-		if (fault & VM_FAULT_RETRY) {
-			flags |= FAULT_FLAG_TRIED;
+	/*RGD modeled on Cris */
+	if (fault & VM_FAULT_RETRY) {
+		flags |= FAULT_FLAG_TRIED;
 
-			 /* No need to mmap_read_unlock(mm) as we would
-			 * have already released it in __lock_page_or_retry
-			 * in mm/filemap.c.
-			 */
+		/* No need to mmap_read_unlock(mm) as we would
+		 * have already released it in __lock_page_or_retry
+		 * in mm/filemap.c.
+		 */
 
-			goto retry;
-		}
+		goto retry;
 	}
 
 	mmap_read_unlock(mm);
diff --git a/arch/parisc/mm/fault.c b/arch/parisc/mm/fault.c
index 4a6221b869fd..360b627645cc 100644
--- a/arch/parisc/mm/fault.c
+++ b/arch/parisc/mm/fault.c
@@ -324,16 +324,14 @@ void do_page_fault(struct pt_regs *regs, unsigned long code,
 			goto bad_area;
 		BUG();
 	}
-	if (flags & FAULT_FLAG_ALLOW_RETRY) {
-		if (fault & VM_FAULT_RETRY) {
-			/*
-			 * No need to mmap_read_unlock(mm) as we would
-			 * have already released it in __lock_page_or_retry
-			 * in mm/filemap.c.
-			 */
-			flags |= FAULT_FLAG_TRIED;
-			goto retry;
-		}
+	if (fault & VM_FAULT_RETRY) {
+		/*
+		 * No need to mmap_read_unlock(mm) as we would
+		 * have already released it in __lock_page_or_retry
+		 * in mm/filemap.c.
+		 */
+		flags |= FAULT_FLAG_TRIED;
+		goto retry;
 	}
 	mmap_read_unlock(mm);
 	return;
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index a8d0ce85d39a..ebcc61e47d62 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -516,10 +516,8 @@ static int ___do_page_fault(struct pt_regs *regs, unsigned long address,
 	 * case.
 	 */
 	if (unlikely(fault & VM_FAULT_RETRY)) {
-		if (flags & FAULT_FLAG_ALLOW_RETRY) {
-			flags |= FAULT_FLAG_TRIED;
-			goto retry;
-		}
+		flags |= FAULT_FLAG_TRIED;
+		goto retry;
 	}
 
 	mmap_read_unlock(current->mm);
diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index aa08dd2f8fae..cae4b6363607 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -330,7 +330,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 	if (fault_signal_pending(fault, regs))
 		return;
 
-	if (unlikely((fault & VM_FAULT_RETRY) && (flags & FAULT_FLAG_ALLOW_RETRY))) {
+	if (unlikely(fault & VM_FAULT_RETRY)) {
 		flags |= FAULT_FLAG_TRIED;
 
 		/*
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index d30f5986fa85..43d79d051dd8 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -452,21 +452,19 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
 	if (unlikely(fault & VM_FAULT_ERROR))
 		goto out_up;
 
-	if (flags & FAULT_FLAG_ALLOW_RETRY) {
-		if (fault & VM_FAULT_RETRY) {
-			if (IS_ENABLED(CONFIG_PGSTE) && gmap &&
-			    (flags & FAULT_FLAG_RETRY_NOWAIT)) {
-				/* FAULT_FLAG_RETRY_NOWAIT has been set,
-				 * mmap_lock has not been released */
-				current->thread.gmap_pfault = 1;
-				fault = VM_FAULT_PFAULT;
-				goto out_up;
-			}
-			flags &= ~FAULT_FLAG_RETRY_NOWAIT;
-			flags |= FAULT_FLAG_TRIED;
-			mmap_read_lock(mm);
-			goto retry;
+	if (fault & VM_FAULT_RETRY) {
+		if (IS_ENABLED(CONFIG_PGSTE) && gmap &&
+			(flags & FAULT_FLAG_RETRY_NOWAIT)) {
+			/* FAULT_FLAG_RETRY_NOWAIT has been set,
+			 * mmap_lock has not been released */
+			current->thread.gmap_pfault = 1;
+			fault = VM_FAULT_PFAULT;
+			goto out_up;
 		}
+		flags &= ~FAULT_FLAG_RETRY_NOWAIT;
+		flags |= FAULT_FLAG_TRIED;
+		mmap_read_lock(mm);
+		goto retry;
 	}
 	if (IS_ENABLED(CONFIG_PGSTE) && gmap) {
 		address =  __gmap_link(gmap, current->thread.gmap_addr,
diff --git a/arch/sh/mm/fault.c b/arch/sh/mm/fault.c
index 1e1aa75df3ca..e175667b1363 100644
--- a/arch/sh/mm/fault.c
+++ b/arch/sh/mm/fault.c
@@ -485,17 +485,15 @@ asmlinkage void __kprobes do_page_fault(struct pt_regs *regs,
 		if (mm_fault_error(regs, error_code, address, fault))
 			return;
 
-	if (flags & FAULT_FLAG_ALLOW_RETRY) {
-		if (fault & VM_FAULT_RETRY) {
-			flags |= FAULT_FLAG_TRIED;
-
-			/*
-			 * No need to mmap_read_unlock(mm) as we would
-			 * have already released it in __lock_page_or_retry
-			 * in mm/filemap.c.
-			 */
-			goto retry;
-		}
+	if (fault & VM_FAULT_RETRY) {
+		flags |= FAULT_FLAG_TRIED;
+
+		/*
+		 * No need to mmap_read_unlock(mm) as we would
+		 * have already released it in __lock_page_or_retry
+		 * in mm/filemap.c.
+		 */
+		goto retry;
 	}
 
 	mmap_read_unlock(mm);
diff --git a/arch/sparc/mm/fault_32.c b/arch/sparc/mm/fault_32.c
index 90dc4ae315c8..ad569d9bd124 100644
--- a/arch/sparc/mm/fault_32.c
+++ b/arch/sparc/mm/fault_32.c
@@ -200,17 +200,15 @@ asmlinkage void do_sparc_fault(struct pt_regs *regs, int text_fault, int write,
 		BUG();
 	}
 
-	if (flags & FAULT_FLAG_ALLOW_RETRY) {
-		if (fault & VM_FAULT_RETRY) {
-			flags |= FAULT_FLAG_TRIED;
+	if (fault & VM_FAULT_RETRY) {
+		flags |= FAULT_FLAG_TRIED;
 
-			/* No need to mmap_read_unlock(mm) as we would
-			 * have already released it in __lock_page_or_retry
-			 * in mm/filemap.c.
-			 */
+		/* No need to mmap_read_unlock(mm) as we would
+		 * have already released it in __lock_page_or_retry
+		 * in mm/filemap.c.
+		 */
 
-			goto retry;
-		}
+		goto retry;
 	}
 
 	mmap_read_unlock(mm);
diff --git a/arch/sparc/mm/fault_64.c b/arch/sparc/mm/fault_64.c
index 9a9652a15fed..253e07043298 100644
--- a/arch/sparc/mm/fault_64.c
+++ b/arch/sparc/mm/fault_64.c
@@ -437,17 +437,15 @@ asmlinkage void __kprobes do_sparc64_fault(struct pt_regs *regs)
 		BUG();
 	}
 
-	if (flags & FAULT_FLAG_ALLOW_RETRY) {
-		if (fault & VM_FAULT_RETRY) {
-			flags |= FAULT_FLAG_TRIED;
+	if (fault & VM_FAULT_RETRY) {
+		flags |= FAULT_FLAG_TRIED;
 
-			/* No need to mmap_read_unlock(mm) as we would
-			 * have already released it in __lock_page_or_retry
-			 * in mm/filemap.c.
-			 */
+		/* No need to mmap_read_unlock(mm) as we would
+		 * have already released it in __lock_page_or_retry
+		 * in mm/filemap.c.
+		 */
 
-			goto retry;
-		}
+		goto retry;
 	}
 	mmap_read_unlock(mm);
 
diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
index c32efb09db21..193503484af5 100644
--- a/arch/um/kernel/trap.c
+++ b/arch/um/kernel/trap.c
@@ -87,12 +87,10 @@ int handle_page_fault(unsigned long address, unsigned long ip,
 			}
 			BUG();
 		}
-		if (flags & FAULT_FLAG_ALLOW_RETRY) {
-			if (fault & VM_FAULT_RETRY) {
-				flags |= FAULT_FLAG_TRIED;
+		if (fault & VM_FAULT_RETRY) {
+			flags |= FAULT_FLAG_TRIED;
 
-				goto retry;
-			}
+			goto retry;
 		}
 
 		pmd = pmd_off(mm, address);
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 4bfed53e210e..d0074c6ed31a 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1413,8 +1413,7 @@ void do_user_addr_fault(struct pt_regs *regs,
 	 * and if there is a fatal signal pending there is no guarantee
 	 * that we made any progress. Handle this case first.
 	 */
-	if (unlikely((fault & VM_FAULT_RETRY) &&
-		     (flags & FAULT_FLAG_ALLOW_RETRY))) {
+	if (unlikely(fault & VM_FAULT_RETRY)) {
 		flags |= FAULT_FLAG_TRIED;
 		goto retry;
 	}
diff --git a/arch/xtensa/mm/fault.c b/arch/xtensa/mm/fault.c
index fd6a70635962..06d0973a0d74 100644
--- a/arch/xtensa/mm/fault.c
+++ b/arch/xtensa/mm/fault.c
@@ -127,17 +127,16 @@ void do_page_fault(struct pt_regs *regs)
 			goto do_sigbus;
 		BUG();
 	}
-	if (flags & FAULT_FLAG_ALLOW_RETRY) {
-		if (fault & VM_FAULT_RETRY) {
-			flags |= FAULT_FLAG_TRIED;
 
-			 /* No need to mmap_read_unlock(mm) as we would
-			 * have already released it in __lock_page_or_retry
-			 * in mm/filemap.c.
-			 */
+	if (fault & VM_FAULT_RETRY) {
+		flags |= FAULT_FLAG_TRIED;
 
-			goto retry;
-		}
+		/* No need to mmap_read_unlock(mm) as we would
+		 * have already released it in __lock_page_or_retry
+		 * in mm/filemap.c.
+		 */
+
+		goto retry;
 	}
 
 	mmap_read_unlock(mm);
-- 
2.11.0

