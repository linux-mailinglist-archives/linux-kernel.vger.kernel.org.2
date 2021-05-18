Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD193874BC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 11:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347791AbhERJJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 05:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347725AbhERJI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 05:08:28 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D6EC061345
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 02:07:10 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id v12so9329551wrq.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 02:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9rGi608qIyo5wwTAfm/9KSh42lmNIqRVhptkNqcqKak=;
        b=boNwMh1++w7TDzmUAg3tAWQaAtUpXq0nkaVL4P8ywlxWnnj3GizxF9D5FCopHzYH0l
         M392UtjwRQdiPZV4Nn5JI2GOdJ+18ZnwwY/Yc6DCynMepnDHLpTnHR3bvKPB7oR+QqB3
         NBfxlbpLCIbfsyf5AfcoHUKdJmvEg7e3mj7gSeG+XZjVzDwRkLWQrIb6xdqcAXzDQK9C
         2W6K257G0wB0LkXgThuBcB8JyHIKqqpKgI0qn8GOQ1KhMSM5Vqr5kOxyNL290VammKg/
         t4LRWs1m68gYzNU0jl8giZsH9bb5PWDXWl4afmWTENaBJ7sJmnugegUMu/LWG9Hs/JXo
         7tow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9rGi608qIyo5wwTAfm/9KSh42lmNIqRVhptkNqcqKak=;
        b=cMtsA/rFIyPHpHuI0AOpCGwMhwwJHMeIV7/BW7viVefqJndyF+Nyj/BLsrE048eG7w
         85Lj3/onpx+BeCd+yVRzXrb/sKIaE1Koo2fI36x9UAv/74ZQ/QSeKucKl+gAb9hu+ZmI
         TheEE6KwcOpv3jTEIHX43RypyqamH/KoZWYETRyYiWstF89u7hNArZsUcO5fWlf22ZZ2
         /6/kcctSvBNo9jEnCncTR/0zmjq7aqurFSxlgsXVcmMyr63dvgk3Jc2zxVIue4CPBwtt
         3Tu/cUrkU4ZSHcYAdsbkmwd85gvMQHHINb3tZzkLEWg4Ac8Z+q6z/JHZBJ1MAgFIBncx
         kzMA==
X-Gm-Message-State: AOAM5317JXsi8ZNXi0E0pM+BkOhjGI0KRqQPUOttBoCXPADfXwN3Blxl
        UfCxKuFfbh9W1CwtzA8Gp4gOyHNvv2rnS7g+
X-Google-Smtp-Source: ABdhPJwS9MdO+Qwxpqf9XZbH6OCB7DYTmx7uZPYqKcZVbpPMaJnWz94YV9xSRF/j8QdMOHfyvwkbnw==
X-Received: by 2002:a5d:658e:: with SMTP id q14mr5355475wru.81.1621328829488;
        Tue, 18 May 2021 02:07:09 -0700 (PDT)
Received: from amanieu-laptop.home ([2a00:23c6:f081:f801:91cf:b949:c46c:f5a9])
        by smtp.gmail.com with ESMTPSA id z17sm7520306wrt.81.2021.05.18.02.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 02:07:08 -0700 (PDT)
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
Subject: [RESEND PATCH v4 3/8] mm: Support mmap_compat_base with the generic layout
Date:   Tue, 18 May 2021 10:06:53 +0100
Message-Id: <20210518090658.9519-4-amanieu@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210518090658.9519-1-amanieu@gmail.com>
References: <20210518090658.9519-1-amanieu@gmail.com>
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

