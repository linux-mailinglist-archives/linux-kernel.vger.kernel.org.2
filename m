Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 490ED4291F5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 16:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237247AbhJKOgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 10:36:23 -0400
Received: from pv50p00im-ztdg10021201.me.com ([17.58.6.45]:53192 "EHLO
        pv50p00im-ztdg10021201.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229824AbhJKOgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 10:36:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1633962858; bh=FpaFBzvGELmDenSoiEWg7C6khvBd8mZLDt8PAvrNQPk=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=M9tY9Y+zmHCJqIeUveVVttLWg0yPrLJUerGc9HZkb9ALP4g+na/cmY+iZ1rtrgUVP
         a4UI6ymxraCcFA8TZ04y5pzC4gOUAuZX+t/PLO85D4nuwR7lpJA8aREI+uU6F5WKjI
         7lDkAsmcb1BNd3GfHQhmRJVNqVubJTWI7rzKdF1lTrpdpqCneL/FBd8j072xbCV05h
         TXHxb4Y2Huf8ISL588L3ZTg+1D+QurkTLED9UcUX/HudCk9qgl+HbCCCK8+3AByAn7
         lDnhLzsPI5XP7rPg1+Dz+ZlINCvu3lmuhjhKtrnkXw+3B5vpL7RD4J+0rDT2gza5lv
         ct7HfM9lsYlIA==
Received: from xiongwei.. (unknown [120.245.2.114])
        by pv50p00im-ztdg10021201.me.com (Postfix) with ESMTPSA id 92BADA40283;
        Mon, 11 Oct 2021 14:34:08 +0000 (UTC)
From:   sxwjean@me.com
To:     linux-mm@kvack.org, x86@kernel.org
Cc:     Xiongwei Song <sxwjean@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Huang Rui <ray.huang@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Balbir Singh <sblbir@amazon.com>,
        "David S. Miller" <davem@davemloft.net>, sxwjean@me.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] mm/util: Support CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES
Date:   Mon, 11 Oct 2021 22:31:47 +0800
Message-Id: <20211011143150.318239-4-sxwjean@me.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211011143150.318239-1-sxwjean@me.com>
References: <20211011143150.318239-1-sxwjean@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.790
 definitions=2021-10-11_05:2021-10-07,2021-10-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=914 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2110110085
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiongwei Song <sxwjean@gmail.com>

With CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES enabled, archs can support 64bit
process invoke 32bit syscall via compatible mmap(), which uses
mmap_compat_base and mmap_compat_legacy_base of mm_struct, which only
x86 uses so far.

Here we assume other archs will support CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES
as well.

Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
---
 arch/x86/include/asm/processor.h |  4 ++++
 mm/util.c                        | 21 +++++++++++++++++++--
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 577f342dbfb2..fb7a4f21d412 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -787,6 +787,10 @@ extern void start_thread(struct pt_regs *regs, unsigned long new_ip,
 #define __TASK_UNMAPPED_BASE(task_size)	(PAGE_ALIGN(task_size / 3))
 #define TASK_UNMAPPED_BASE		__TASK_UNMAPPED_BASE(TASK_SIZE_LOW)
 
+#ifdef CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES
+#define TASK_UNMAPPED_COMPAT_BASE __TASK_UNMAPPED_BASE(task_size_32bit())
+#endif
+
 #define KSTK_EIP(task)		(task_pt_regs(task)->ip)
 
 /* Get/set a process' ability to use the timestamp counter instruction */
diff --git a/mm/util.c b/mm/util.c
index 38326ef21a3b..ab3711c445e6 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -357,8 +357,9 @@ unsigned long arch_mmap_rnd(void)
 {
 	unsigned long rnd;
 
-#ifdef CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS
-	if (is_compat_task())
+#if defined(CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS) \
+	|| defined(CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES)
+	if (is_compat_task() || in_compat_syscall())
 		rnd = get_random_long() & ((1UL << mmap_rnd_compat_bits) - 1);
 	else
 #endif /* CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS */
@@ -422,6 +423,22 @@ void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
 		mm->mmap_base = mmap_base(random_factor, STACK_TOP, rlim_stack);
 		mm->get_unmapped_area = arch_get_unmapped_area_topdown;
 	}
+#ifdef CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES
+	/*
+	 * The mmap syscall mapping base decision depends solely on the
+	 * syscall type (64-bit or compat). This applies for 64bit
+	 * applications and 32bit applications. The 64bit syscall uses
+	 * mmap_base, the compat syscall uses mmap_compat_base.
+	 */
+	if (mmap_is_legacy(rlim_stack)) {
+		mm->mmap_compat_legacy_base =
+			TASK_UNMAPPED_COMPAT_BASE + random_factor;
+		mm->mmap_compat_base = mm->mmap_compat_legacy_base;
+	} else {
+		mm->mmap_compat_base = mmap_base(random_factor,
+				       task_size_32bit(), rlim_stack);
+	}
+#endif
 }
 #elif defined(CONFIG_MMU) && !defined(HAVE_ARCH_PICK_MMAP_LAYOUT)
 void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
-- 
2.30.2

