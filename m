Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9414291F4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 16:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbhJKOgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 10:36:10 -0400
Received: from pv50p00im-ztdg10021201.me.com ([17.58.6.45]:52522 "EHLO
        pv50p00im-ztdg10021201.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236647AbhJKOgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 10:36:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1633962845; bh=JRB2I0DdtVVtDX+M6k5hW9hyckKkPozCFhvu4peWiT8=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=VMxjjtqCM5srj67fJKgnJyWGKg27FMpkMeOLKe4kY37aHDbmRB2ngM1+AOoUMMKbI
         twQM9stdCuNtEblaSRuC6WaBFelH55ItmSNls8wtqMwKAWXv1cAo8e5Xuu84lIwlRm
         35lJ3IzmLoDkg2b6mAgHSgPdDgXZSagDc4GnSp63Qj0Yl6UaxOqxdAd2qZoZhu0y1b
         GykPUbsXEHU5LmPkgyK8w3PyE5kalUF8dsX6ynuBzkK/ni4D1hJGLkuYlBd0A3CQ6T
         sx5villyGhAdo97VtdUtPtwYzrQpkjN+t1J5HVdeqVqpSpnFQs23sfN/Sl55V+BrLP
         AT4GG98aivFjw==
Received: from xiongwei.. (unknown [120.245.2.114])
        by pv50p00im-ztdg10021201.me.com (Postfix) with ESMTPSA id B1049A405D9;
        Mon, 11 Oct 2021 14:33:56 +0000 (UTC)
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
Subject: [PATCH v2 2/6] mm/util: Allow to pass a specific task size when getting mmapping base
Date:   Mon, 11 Oct 2021 22:31:46 +0800
Message-Id: <20211011143150.318239-3-sxwjean@me.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211011143150.318239-1-sxwjean@me.com>
References: <20211011143150.318239-1-sxwjean@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.790
 definitions=2021-10-11_05:2021-10-07,2021-10-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=715 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2110110085
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiongwei Song <sxwjean@gmail.com>

In x86, a 64bit task may invoke a 32 bit syscall, which is in compat
syscall. Then we have to provide 32bit mapping base.

Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
---
 mm/util.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/util.c b/mm/util.c
index 40b1a8837c0b..38326ef21a3b 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -385,14 +385,15 @@ static int mmap_is_legacy(struct rlimit *rlim_stack)
 #define MIN_GAP		(SZ_128M)
 #define MAX_GAP		(STACK_TOP / 6 * 5)
 
-static unsigned long mmap_base(unsigned long rnd, struct rlimit *rlim_stack)
+static unsigned long mmap_base(unsigned long rnd, unsigned long task_size,
+			       struct rlimit *rlim_stack)
 {
 	unsigned long gap = rlim_stack->rlim_cur;
 	unsigned long pad = stack_guard_gap;
 
 	/* Account for stack randomization if necessary */
 	if (current->flags & PF_RANDOMIZE)
-		pad += (STACK_RND_MASK << PAGE_SHIFT);
+		pad += (in_compat_syscall() ? 0x7ff : STACK_RND_MASK) << PAGE_SHIFT;
 
 	/* Values close to RLIM_INFINITY can overflow. */
 	if (gap + pad > gap)
@@ -403,7 +404,7 @@ static unsigned long mmap_base(unsigned long rnd, struct rlimit *rlim_stack)
 	else if (gap > MAX_GAP)
 		gap = MAX_GAP;
 
-	return PAGE_ALIGN(STACK_TOP - gap - rnd);
+	return PAGE_ALIGN(task_size - gap - rnd);
 }
 
 void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
@@ -418,7 +419,7 @@ void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
 		mm->mmap_base = mm->mmap_legacy_base;
 		mm->get_unmapped_area = arch_get_unmapped_area;
 	} else {
-		mm->mmap_base = mmap_base(random_factor, rlim_stack);
+		mm->mmap_base = mmap_base(random_factor, STACK_TOP, rlim_stack);
 		mm->get_unmapped_area = arch_get_unmapped_area_topdown;
 	}
 }
-- 
2.30.2

