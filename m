Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25294370244
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 22:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236006AbhD3UjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 16:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235988AbhD3UjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 16:39:00 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354E8C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 13:38:11 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id k128so38490025wmk.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 13:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9rGi608qIyo5wwTAfm/9KSh42lmNIqRVhptkNqcqKak=;
        b=CvdqY8NoDzxfaCjWuYW52uyx4VI6KnVFObEuc3VwxhMsaIB9+Yv4+tJ5vc+CKkqAqu
         DFkD9Wcz40fDhJ13BMexOvdyFJi/ugtuNbpRM/8SojpBgKf5T301Aj2LahPVu6h4woLr
         Z4SyIObMmCfvJyxIb5GJ/DCusmZsPi6dyAz06/2rJIErg6bJYwvf9+NnQbk3kd/iTePY
         PzvnOkdUkdlNid5s3MOumUi0p7ubnfX7B/yfi+1MBfOz8diWX973CqtmcNPRnEfws7jw
         tDB8391tY7H+oDnzgGjAlaDvbw55Cbo1Ci+hOxA8xaADWlH9cTu3BKhqLrlX93d0+t0Y
         eRjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9rGi608qIyo5wwTAfm/9KSh42lmNIqRVhptkNqcqKak=;
        b=hhURLD9bEXtRcVr9YUe9Gi2svBfn2K1HXnYoECzJch+ioviTH579Fo3VU/xvbhNyRg
         GCiHVCSn4+p1kMADErrvpTDwhO6QMjkcc+ZQOX89BXlp1s+qP25XsN1MJlC77kKXVgj5
         Rh8UB8EtuEwiRNQG2BzSMYg5jMrWh+xOSd+M0B4Cggf5BIR3wudQxaWWCGRnWoUjydCn
         AjikbJM8/XDnmNJTNr/j3o/8pm7ch3OUudhM+DRHemLMGExvTFCjsVVDdwsK6iryWjJB
         1C70EGUITfKRZBMkHEddNl4EvM1NuhEelZ3NjnMXY9OsrThkx4T2lq+44SZph5IW/5iO
         cqgQ==
X-Gm-Message-State: AOAM533C3+mX3DsnzJTg9JLx2+x/MMXjKkgL1uMD41VGk1PnWa/0weDk
        7VLrSV3y75yglv7zgjBUj1k=
X-Google-Smtp-Source: ABdhPJysbnsaEfcFI4I+IvQaI7Ctl179Unq6uDAJ8B1wNG4pOThSvlUXxu5oi9Ui1o6zwCcJ8cL5Eg==
X-Received: by 2002:a1c:7f4a:: with SMTP id a71mr18087171wmd.60.1619815089943;
        Fri, 30 Apr 2021 13:38:09 -0700 (PDT)
Received: from amanieu-desktop.home ([2a00:23c6:f081:f801:93ef:94e:9f8:1f0])
        by smtp.gmail.com with ESMTPSA id r5sm4384239wmh.23.2021.04.30.13.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 13:38:09 -0700 (PDT)
From:   Amanieu d'Antras <amanieu@gmail.com>
Cc:     Amanieu d'Antras <amanieu@gmail.com>,
        Ryan Houdek <Houdek.Ryan@fex-emu.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Steven Price <steven.price@arm.com>,
        Arnd Bergmann <arnd@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/8] mm: Support mmap_compat_base with the generic layout
Date:   Fri, 30 Apr 2021 21:37:52 +0100
Message-Id: <20210430203757.47653-2-amanieu@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210430202810.44092-1-amanieu@gmail.com>
References: <20210430202810.44092-1-amanieu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables architectures using the generic mmap layout to support
32-bit mmap calls from 64-bit processes and vice-versa.

Architectures using this must define separate 32-bit and 64-bit versions
of STACK_TOP, TASK_UNMAPPED_BASE and STACK_RND_MASK.

Signed-off-by: Amanieu d'Antras <amanieu@gmail.com>
Co-developed-by: Ryan Houdek <Houdek.Ryan@fex-emu.org>
Signed-off-by: Ryan Houdek <Houdek.Ryan@fex-emu.org>
---
 mm/util.c | 46 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 38 insertions(+), 8 deletions(-)

diff --git a/mm/util.c b/mm/util.c
index 54870226cea6..37bd764174b5 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -353,12 +353,12 @@ unsigned long arch_randomize_brk(struct mm_struct *mm)
 	return randomize_page(mm->brk, SZ_1G);
 }
 
-unsigned long arch_mmap_rnd(void)
+static unsigned long mmap_rnd(bool compat)
 {
 	unsigned long rnd;
 
 #ifdef CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS
-	if (is_compat_task())
+	if (compat)
 		rnd = get_random_long() & ((1UL << mmap_rnd_compat_bits) - 1);
 	else
 #endif /* CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS */
@@ -367,6 +367,11 @@ unsigned long arch_mmap_rnd(void)
 	return rnd << PAGE_SHIFT;
 }
 
+unsigned long arch_mmap_rnd(void)
+{
+	return mmap_rnd(is_compat_task());
+}
+
 static int mmap_is_legacy(struct rlimit *rlim_stack)
 {
 	if (current->personality & ADDR_COMPAT_LAYOUT)
@@ -383,16 +388,17 @@ static int mmap_is_legacy(struct rlimit *rlim_stack)
  * the face of randomisation.
  */
 #define MIN_GAP		(SZ_128M)
-#define MAX_GAP		(STACK_TOP / 6 * 5)
+#define MAX_GAP		(stack_top / 6 * 5)
 
-static unsigned long mmap_base(unsigned long rnd, struct rlimit *rlim_stack)
+static unsigned long mmap_base(unsigned long rnd, struct rlimit *rlim_stack,
+	unsigned long stack_top, unsigned long stack_rnd_mask)
 {
 	unsigned long gap = rlim_stack->rlim_cur;
 	unsigned long pad = stack_guard_gap;
 
 	/* Account for stack randomization if necessary */
 	if (current->flags & PF_RANDOMIZE)
-		pad += (STACK_RND_MASK << PAGE_SHIFT);
+		pad += (stack_rnd_mask << PAGE_SHIFT);
 
 	/* Values close to RLIM_INFINITY can overflow. */
 	if (gap + pad > gap)
@@ -403,21 +409,45 @@ static unsigned long mmap_base(unsigned long rnd, struct rlimit *rlim_stack)
 	else if (gap > MAX_GAP)
 		gap = MAX_GAP;
 
-	return PAGE_ALIGN(STACK_TOP - gap - rnd);
+	return PAGE_ALIGN(stack_top - gap - rnd);
 }
 
 void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
 {
 	unsigned long random_factor = 0UL;
+#ifdef CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES
+	unsigned long compat_random_factor = 0UL;
+#endif
 
-	if (current->flags & PF_RANDOMIZE)
+	if (current->flags & PF_RANDOMIZE) {
+#ifdef CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES
+		random_factor = mmap_rnd(false);
+		compat_random_factor = mmap_rnd(true);
+#else
 		random_factor = arch_mmap_rnd();
+#endif
+	}
 
 	if (mmap_is_legacy(rlim_stack)) {
+#ifdef CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES
+		mm->mmap_base = TASK_UNMAPPED_BASE_64 + random_factor;
+		mm->mmap_compat_base =
+			TASK_UNMAPPED_BASE_32 + compat_random_factor;
+#else
 		mm->mmap_base = TASK_UNMAPPED_BASE + random_factor;
+#endif
 		mm->get_unmapped_area = arch_get_unmapped_area;
 	} else {
-		mm->mmap_base = mmap_base(random_factor, rlim_stack);
+#ifdef CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES
+		mm->mmap_base = mmap_base(random_factor, rlim_stack,
+					  STACK_TOP_64, STACK_RND_MASK_64);
+		mm->mmap_compat_base = mmap_base(compat_random_factor,
+						 rlim_stack, STACK_TOP_32,
+						 STACK_RND_MASK_32);
+#else
+		mm->mmap_base = mmap_base(random_factor, rlim_stack, STACK_TOP,
+					  STACK_RND_MASK);
+#endif
 		mm->get_unmapped_area = arch_get_unmapped_area_topdown;
 	}
 }
-- 
2.31.1

