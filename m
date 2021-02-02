Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61F4930B89D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 08:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbhBBHY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 02:24:28 -0500
Received: from ozlabs.ru ([107.174.27.60]:49276 "EHLO ozlabs.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231419AbhBBHYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 02:24:19 -0500
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
        by ozlabs.ru (Postfix) with ESMTP id 23B62AE80014;
        Tue,  2 Feb 2021 02:23:30 -0500 (EST)
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Ingo Molnar <mingo@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH kernel] tracepoint: Fix race between tracing and removing tracepoint
Date:   Tue,  2 Feb 2021 18:23:26 +1100
Message-Id: <20210202072326.120557-1-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When executing a tracepoint, the tracepoint's func is dereferenced twice -
in __DO_TRACE() (where the returned pointer is checked) and later on in
__traceiter_##_name where the returned pointer is dereferenced without
checking which leads to races against tracepoint_removal_sync() and
crashes.

This adds a check before referencing the pointer in tracepoint_ptr_deref.

Fixes: d25e37d89dd2f ("tracepoint: Optimize using static_call()")
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

This is in reply to https://lkml.org/lkml/2021/2/1/868

Feel free to change the commit log. Thanks!

Fixing it properly is rather scary :)
I tried passing it_func_ptr to it_func but this change triggered way too
many prototypes changes such as __bpf_trace_##call().

---
 include/linux/tracepoint.h | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 0f21617f1a66..966ed8980327 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -307,11 +307,13 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 									\
 		it_func_ptr =						\
 			rcu_dereference_raw((&__tracepoint_##_name)->funcs); \
-		do {							\
-			it_func = (it_func_ptr)->func;			\
-			__data = (it_func_ptr)->data;			\
-			((void(*)(void *, proto))(it_func))(__data, args); \
-		} while ((++it_func_ptr)->func);			\
+		if (it_func_ptr) {					\
+			do {						\
+				it_func = (it_func_ptr)->func;		\
+				__data = (it_func_ptr)->data;		\
+				((void(*)(void *, proto))(it_func))(__data, args); \
+			} while ((++it_func_ptr)->func);		\
+		}							\
 		return 0;						\
 	}								\
 	DEFINE_STATIC_CALL(tp_func_##_name, __traceiter_##_name);
-- 
2.17.1

