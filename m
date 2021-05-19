Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 331D1388CFE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 13:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351509AbhESLjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 07:39:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41164 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351378AbhESLjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 07:39:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621424274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mN6lsvqoIJHHmjvlYbEu+2eORcj6RsSudi3TiJSoxKA=;
        b=JcimuJ3F5cl105CbGBZAS+q+foPCCKbv4+HQNhBbYuicItUMt/KnbjwwIVzDOt423uz9IZ
        fijzQsantMpt6DqYh9PncsvnD0niTT8ZBsEk0GTuYHP2sjYbO6BagAdwCijbNkUlUEvy/v
        AlPQE8brHmlJXW6kuXwlXJsQ2dQL5wI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-ecJoPHPYNc2ufUkqOXql2A-1; Wed, 19 May 2021 07:37:52 -0400
X-MC-Unique: ecJoPHPYNc2ufUkqOXql2A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5FAD01927800;
        Wed, 19 May 2021 11:37:50 +0000 (UTC)
Received: from x1.com (ovpn-112-250.rdu2.redhat.com [10.10.112.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EE0CD77708;
        Wed, 19 May 2021 11:37:39 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
To:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Cc:     Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Kate Carcia <kcarcia@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Gabriele Paoloni <gabriele.paoloni@intel.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>, linux-doc@vger.kernel.org
Subject: [RFC PATCH 05/16] rv/include: Add tracing helper functions
Date:   Wed, 19 May 2021 13:36:26 +0200
Message-Id: <2a0d1fbc53e153d9ee8299740b643207f6fc0dc7.1621414942.git.bristot@redhat.com>
In-Reply-To: <cover.1621414942.git.bristot@redhat.com>
References: <cover.1621414942.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tracing helper functions to facilitate the instrumentation of
auto-generated RV monitors create by dot2k.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Gabriele Paoloni <gabriele.paoloni@intel.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
---
 include/rv/trace_helpers.h | 69 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 include/rv/trace_helpers.h

diff --git a/include/rv/trace_helpers.h b/include/rv/trace_helpers.h
new file mode 100644
index 000000000000..1a8b6f246d0d
--- /dev/null
+++ b/include/rv/trace_helpers.h
@@ -0,0 +1,69 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Helper functions to facilitate the instrumentation of auto-generated
+ * RV monitors create by dot2k.
+ *
+ * The dot2k tool is available at tools/tracing/rv/dot2/
+ *
+ * Copyright (C) 2019-2021 Daniel Bristot de Oliveira <bristot@redhat.com>
+ */
+
+#include <linux/ftrace.h>
+
+struct tracepoint_hook_helper {
+	struct tracepoint *tp;
+	void *probe;
+	int registered;
+	char *name;
+};
+
+static inline void thh_compare_name(struct tracepoint *tp, void *priv)
+{
+	struct tracepoint_hook_helper *thh  = priv;
+
+	if (!strcmp(thh->name, tp->name))
+		thh->tp = tp;
+}
+
+static inline bool thh_fill_struct_tracepoint(struct tracepoint_hook_helper *thh)
+{
+	for_each_kernel_tracepoint(thh_compare_name, thh);
+
+	return !!thh->tp;
+}
+
+static inline void thh_unhook_probes(struct tracepoint_hook_helper *thh, int helpers_count)
+{
+	int i;
+
+	for (i = 0; i < helpers_count; i++) {
+		if (!thh[i].registered)
+			continue;
+
+		tracepoint_probe_unregister(thh[i].tp, thh[i].probe, NULL);
+	}
+}
+
+static inline int thh_hook_probes(struct tracepoint_hook_helper *thh, int helpers_count)
+{
+	int retval;
+	int i;
+
+	for (i = 0; i < helpers_count; i++) {
+		retval = thh_fill_struct_tracepoint(&thh[i]);
+		if (!retval)
+			goto out_err;
+
+		retval = tracepoint_probe_register(thh[i].tp, thh[i].probe, NULL);
+
+		if (retval)
+			goto out_err;
+
+		thh[i].registered = 1;
+	}
+	return 0;
+
+out_err:
+	thh_unhook_probes(thh, helpers_count);
+	return -EINVAL;
+}
-- 
2.26.2

