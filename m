Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE5D332A5B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 16:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbhCIPZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 10:25:26 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:37913 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231909AbhCIPZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 10:25:18 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R411e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0UR9HgFO_1615303514;
Received: from localhost(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0UR9HgFO_1615303514)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 09 Mar 2021 23:25:14 +0800
From:   Xunlei Pang <xlpang@linux.alibaba.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shu Ming <sming56@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Wen Yang <wenyang@linux.alibaba.com>,
        James Wang <jnwang@linux.alibaba.com>,
        Xunlei Pang <xlpang@linux.alibaba.com>
Subject: [PATCH v3 3/4] percpu: Export per_cpu_sum()
Date:   Tue,  9 Mar 2021 23:25:11 +0800
Message-Id: <1615303512-35058-4-git-send-email-xlpang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1615303512-35058-1-git-send-email-xlpang@linux.alibaba.com>
References: <1615303512-35058-1-git-send-email-xlpang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

per_cpu_sum() is useful, and deserves to be exported.

Tested-by: James Wang <jnwang@linux.alibaba.com>
Signed-off-by: Xunlei Pang <xlpang@linux.alibaba.com>
---
 include/linux/percpu-defs.h   | 10 ++++++++++
 kernel/locking/percpu-rwsem.c | 10 ----------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
index dff7040..0e71b68 100644
--- a/include/linux/percpu-defs.h
+++ b/include/linux/percpu-defs.h
@@ -220,6 +220,16 @@
 	(void)__vpp_verify;						\
 } while (0)
 
+#define per_cpu_sum(var)						\
+({									\
+	typeof(var) __sum = 0;						\
+	int cpu;							\
+	compiletime_assert_atomic_type(__sum);				\
+	for_each_possible_cpu(cpu)					\
+		__sum += per_cpu(var, cpu);				\
+	__sum;								\
+})
+
 #ifdef CONFIG_SMP
 
 /*
diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
index 70a32a5..0980e51 100644
--- a/kernel/locking/percpu-rwsem.c
+++ b/kernel/locking/percpu-rwsem.c
@@ -178,16 +178,6 @@ bool __percpu_down_read(struct percpu_rw_semaphore *sem, bool try)
 }
 EXPORT_SYMBOL_GPL(__percpu_down_read);
 
-#define per_cpu_sum(var)						\
-({									\
-	typeof(var) __sum = 0;						\
-	int cpu;							\
-	compiletime_assert_atomic_type(__sum);				\
-	for_each_possible_cpu(cpu)					\
-		__sum += per_cpu(var, cpu);				\
-	__sum;								\
-})
-
 /*
  * Return true if the modular sum of the sem->read_count per-CPU variable is
  * zero.  If this sum is zero, then it is stable due to the fact that if any
-- 
1.8.3.1

