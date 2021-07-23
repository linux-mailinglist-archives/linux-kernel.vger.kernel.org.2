Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1759F3D3849
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 12:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbhGWJUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 05:20:23 -0400
Received: from outbound-smtp20.blacknight.com ([46.22.139.247]:50629 "EHLO
        outbound-smtp20.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231749AbhGWJUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 05:20:22 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp20.blacknight.com (Postfix) with ESMTPS id 1058D1C4972
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 11:00:55 +0100 (IST)
Received: (qmail 9118 invoked from network); 23 Jul 2021 10:00:54 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPA; 23 Jul 2021 10:00:54 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>, Linux-MM <linux-mm@kvack.org>,
        Linux-RT-Users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 1/2] preempt: Provide preempt_*_(no)rt variants
Date:   Fri, 23 Jul 2021 11:00:33 +0100
Message-Id: <20210723100034.13353-2-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210723100034.13353-1-mgorman@techsingularity.net>
References: <20210723100034.13353-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

RT needs a few preempt_disable/enable points which are not necessary
otherwise. Implement variants to avoid #ifdeffery.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 include/linux/preempt.h | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 9881eac0698f..3434f4618178 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -184,7 +184,11 @@ do { \
 	preempt_count_dec(); \
 } while (0)
 
-#define preempt_enable_no_resched() sched_preempt_enable_no_resched()
+#ifdef CONFIG_PREEMPT_RT
+# define preempt_enable_no_resched() sched_preempt_enable_no_resched()
+#else
+# define preempt_enable_no_resched() preempt_enable()
+#endif
 
 #define preemptible()	(preempt_count() == 0 && !irqs_disabled())
 
@@ -278,6 +282,18 @@ do { \
 		set_preempt_need_resched(); \
 } while (0)
 
+#ifdef CONFIG_PREEMPT_RT
+# define preempt_disable_rt()		preempt_disable()
+# define preempt_enable_rt()		preempt_enable()
+# define preempt_disable_nort()		barrier()
+# define preempt_enable_nort()		barrier()
+#else
+# define preempt_disable_rt()		barrier()
+# define preempt_enable_rt()		barrier()
+# define preempt_disable_nort()		preempt_disable()
+# define preempt_enable_nort()		preempt_enable()
+#endif
+
 #ifdef CONFIG_PREEMPT_NOTIFIERS
 
 struct preempt_notifier;
-- 
2.26.2

