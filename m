Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4E133C3D46
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 16:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbhGKORv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 10:17:51 -0400
Received: from pv50p00im-zteg10011401.me.com ([17.58.6.41]:37527 "EHLO
        pv50p00im-zteg10011401.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232544AbhGKORu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 10:17:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1626012903; bh=TEgNLyQe8pPpf+r07PDaWGBpp8fBeT63R9xX5DrHj6Q=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=LB7UPOgyRhS9zKGBaX0xTkswUzk7z0jKUqbw4BJGTAPGA0a2AbclgOuf7o0MvvocI
         Vcas4Qt/LdvGJpPMBKV9IrQu8/bg+ioHFej6zDEhPXOmhab9JNs4+Z8BiV8M8cjzbt
         HJX0QkZ/fKos4uL6xMVTnLMKGMZd5Jzrc3RXo29/ualIpadauScQrP2G1uBlLsMKp5
         kEHkSkEGEHITQDiNBDAiHRFISm+OielySkTXxdtrwsCz96nT3YRHSoDoiCIZ1+VbdS
         XkVlmi0BsbMYG0peLFHbSf/2TzUxiU6giP1Br65pHjMSgijdNziB2e+FDerkJLLG8i
         7+4eGGFWgwuUQ==
Received: from xiongwei.. (unknown [120.245.2.75])
        by pv50p00im-zteg10011401.me.com (Postfix) with ESMTPSA id D918F90036B;
        Sun, 11 Jul 2021 14:15:00 +0000 (UTC)
From:   Xiongwei Song <sxwjean@me.com>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, Xiongwei Song <sxwjean@gmail.com>
Subject: [RFC PATCH v1 2/3] locking/lockdep: Unify the return values of check_wait_context()
Date:   Sun, 11 Jul 2021 22:14:29 +0800
Message-Id: <20210711141430.896595-2-sxwjean@me.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210711141430.896595-1-sxwjean@me.com>
References: <20210711141430.896595-1-sxwjean@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-11_09:2021-07-09,2021-07-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=951 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2107110118
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiongwei Song <sxwjean@gmail.com>

Unity the return values of check_wait_context() as check_prev_add(),
check_irq_usage(), etc. 1 means no bug, 0 means there is a bug.

The return values of print_lock_invalid_wait_context() are unnecessary,
remove them.

Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
---
 kernel/locking/lockdep.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index bf1c00c881e4..8b50da42f2c6 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4635,16 +4635,16 @@ static inline short task_wait_context(struct task_struct *curr)
 	return LD_WAIT_MAX;
 }
 
-static int
+static void
 print_lock_invalid_wait_context(struct task_struct *curr,
 				struct held_lock *hlock)
 {
 	short curr_inner;
 
 	if (!debug_locks_off())
-		return 0;
+		return;
 	if (debug_locks_silent)
-		return 0;
+		return;
 
 	pr_warn("\n");
 	pr_warn("=============================\n");
@@ -4664,8 +4664,6 @@ print_lock_invalid_wait_context(struct task_struct *curr,
 
 	pr_warn("stack backtrace:\n");
 	dump_stack();
-
-	return 0;
 }
 
 /*
@@ -4691,7 +4689,7 @@ static int check_wait_context(struct task_struct *curr, struct held_lock *next)
 	int depth;
 
 	if (!next_inner || next->trylock)
-		return 0;
+		return 1;
 
 	if (!next_outer)
 		next_outer = next_inner;
@@ -4723,10 +4721,12 @@ static int check_wait_context(struct task_struct *curr, struct held_lock *next)
 		}
 	}
 
-	if (next_outer > curr_inner)
-		return print_lock_invalid_wait_context(curr, next);
+	if (next_outer > curr_inner) {
+		print_lock_invalid_wait_context(curr, next);
+		return 0;
+	}
 
-	return 0;
+	return 1;
 }
 
 #else /* CONFIG_PROVE_LOCKING */
@@ -4962,7 +4962,7 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 #endif
 	hlock->pin_count = pin_count;
 
-	if (check_wait_context(curr, hlock))
+	if (!check_wait_context(curr, hlock))
 		return 0;
 
 	/* Initialize the lock usage bit */
-- 
2.30.2

