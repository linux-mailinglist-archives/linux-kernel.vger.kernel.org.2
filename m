Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F68241356C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 16:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233675AbhIUOgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 10:36:50 -0400
Received: from pv50p00im-ztdg10021801.me.com ([17.58.6.56]:37973 "EHLO
        pv50p00im-ztdg10021801.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233676AbhIUOgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 10:36:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1632234916; bh=nF4rPElvIlem61hyKWx0Vc237954X2JNlZJpztGylhA=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=o+DBgC3Y0ALSmGL3xb9zbKPNK077t0vU55uInaJZ+k1lxdDVoPg9p05RJ02dB2kcA
         qbCMDnZg02kCk6HhXcD68nccOfgLuXwuX7jjK6iCG1UGRwmKgR/MUf3WdsouMfIWWK
         tRqjq9JYIVnELC34wSkVuMOdijrbJp2v0zWxPrHJZW6ipqeCANFIkSgoJ6PKI2W7Xy
         B7IzHjiAUUDVol2hX5viQrVhp2Eol3A0KRjX4ZQT/LVfj1QZOgNFxY3kNj7bJb0flL
         2NF9pQaEs7SewjTBiBw2fN520e16osk2oRlkIhsPh96muJDDOD/I8x+0DIpM1Q47mt
         37eKjFT0x06WQ==
Received: from xiongwei.. (unknown [120.245.3.37])
        by pv50p00im-ztdg10021801.me.com (Postfix) with ESMTPSA id E3A34360379;
        Tue, 21 Sep 2021 14:35:05 +0000 (UTC)
From:   sxwjean@me.com
To:     x86@kernel.org, linux-mm@kvack.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        luto@kernel.org, krisman@collabora.com, chang.seok.bae@intel.com,
        viro@zeniv.linux.org.uk, nivedita@alum.mit.edu,
        adobriyan@gmail.com, oleg@redhat.com, sblbir@amazon.com,
        axboe@kernel.dk, laijs@linux.alibaba.com,
        dave.hansen@linux.intel.com, peterz@infradead.org,
        akpm@linux-foundation.org, arnd@arndb.de, davem@davemloft.net,
        keescook@chromium.org, kim.phillips@amd.com, yazen.ghannam@amd.com,
        dave@stgolabs.net, metze@samba.org, elver@google.com,
        ebiederm@xmission.com, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org, Xiongwei Song <sxwjean@gmail.com>
Subject: [PATCH RESEND 1/2] x86: Rename TIF_ADDR32 to TIF_32BIT
Date:   Tue, 21 Sep 2021 22:34:13 +0800
Message-Id: <20210921143414.70723-2-sxwjean@me.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210921143414.70723-1-sxwjean@me.com>
References: <20210921143414.70723-1-sxwjean@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-21_04:2021-09-20,2021-09-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=570 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2109210090
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiongwei Song <sxwjean@gmail.com>

In arm64 or powerpc or sparc, the 32 bits process in 64 bits kernel is set
flag TIF_32BIT. However in x86, that flag name is TIF_ADDR32. This patch
makes the flag name in x86 same as other archs.

Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
---
 arch/x86/include/asm/elf.h           | 2 +-
 arch/x86/include/asm/page_64_types.h | 6 +++---
 arch/x86/include/asm/thread_info.h   | 4 ++--
 arch/x86/kernel/process_64.c         | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index 29fea180a665..aa6ae2bc20bd 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -322,7 +322,7 @@ static inline int mmap_is_ia32(void)
 {
 	return IS_ENABLED(CONFIG_X86_32) ||
 	       (IS_ENABLED(CONFIG_COMPAT) &&
-		test_thread_flag(TIF_ADDR32));
+		test_thread_flag(TIF_32BIT));
 }
 
 extern unsigned long task_size_32bit(void);
diff --git a/arch/x86/include/asm/page_64_types.h b/arch/x86/include/asm/page_64_types.h
index a8d4ad856568..f4631bee9119 100644
--- a/arch/x86/include/asm/page_64_types.h
+++ b/arch/x86/include/asm/page_64_types.h
@@ -70,11 +70,11 @@
 #define IA32_PAGE_OFFSET	((current->personality & ADDR_LIMIT_3GB) ? \
 					0xc0000000 : 0xFFFFe000)
 
-#define TASK_SIZE_LOW		(test_thread_flag(TIF_ADDR32) ? \
+#define TASK_SIZE_LOW		(test_thread_flag(TIF_32BIT) ? \
 					IA32_PAGE_OFFSET : DEFAULT_MAP_WINDOW)
-#define TASK_SIZE		(test_thread_flag(TIF_ADDR32) ? \
+#define TASK_SIZE		(test_thread_flag(TIF_32BIT) ? \
 					IA32_PAGE_OFFSET : TASK_SIZE_MAX)
-#define TASK_SIZE_OF(child)	((test_tsk_thread_flag(child, TIF_ADDR32)) ? \
+#define TASK_SIZE_OF(child)	((test_tsk_thread_flag(child, TIF_32BIT)) ? \
 					IA32_PAGE_OFFSET : TASK_SIZE_MAX)
 
 #define STACK_TOP		TASK_SIZE_LOW
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index cf132663c219..9e768e7714cc 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -97,7 +97,7 @@ struct thread_info {
 #define TIF_FORCED_TF		24	/* true if TF in eflags artificially */
 #define TIF_BLOCKSTEP		25	/* set when we want DEBUGCTLMSR_BTF */
 #define TIF_LAZY_MMU_UPDATES	27	/* task is updating the mmu lazily */
-#define TIF_ADDR32		29	/* 32-bit address space on 64 bits */
+#define TIF_32BIT		29	/* 32-bit address space on 64 bits */
 
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
@@ -120,7 +120,7 @@ struct thread_info {
 #define _TIF_FORCED_TF		(1 << TIF_FORCED_TF)
 #define _TIF_BLOCKSTEP		(1 << TIF_BLOCKSTEP)
 #define _TIF_LAZY_MMU_UPDATES	(1 << TIF_LAZY_MMU_UPDATES)
-#define _TIF_ADDR32		(1 << TIF_ADDR32)
+#define _TIF_32BIT		(1 << TIF_32BIT)
 
 /* flags to check in __switch_to() */
 #define _TIF_WORK_CTXSW_BASE					\
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index ec0d836a13b1..a8a94f87548f 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -666,7 +666,7 @@ void set_personality_64bit(void)
 	/* inherit personality from parent */
 
 	/* Make sure to be in 64bit mode */
-	clear_thread_flag(TIF_ADDR32);
+	clear_thread_flag(TIF_32BIT);
 	/* Pretend that this comes from a 64bit execve */
 	task_pt_regs(current)->orig_ax = __NR_execve;
 	current_thread_info()->status &= ~TS_COMPAT;
@@ -721,7 +721,7 @@ static void __set_personality_ia32(void)
 void set_personality_ia32(bool x32)
 {
 	/* Make sure to be in 32bit mode */
-	set_thread_flag(TIF_ADDR32);
+	set_thread_flag(TIF_32BIT);
 
 	if (x32)
 		__set_personality_x32();
-- 
2.30.2

