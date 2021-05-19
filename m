Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C379388CFC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 13:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351247AbhESLjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 07:39:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53572 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351378AbhESLi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 07:38:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621424258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o6y+X5ZTlu8HONAGShzkVeiKiAGf4j48jcAkpWyjLEg=;
        b=ObB4VF73hLnshUhpo8sv8r0cNzyUJqJZZUud9RQFmx9IGMNUH1vZbRGMyX3L0YKAijwKKo
        pbptfzi/CSwdD4GpVkPUwqOGyITUPnp2IBxKS80kQtXObqyqP+9+NTdY7zsyCu01X1kdQx
        ik+pkBpnlm7gKcwL8ncXohb91kGY8SU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-saBc7kh5OXeRnG5Q306ZPw-1; Wed, 19 May 2021 07:37:36 -0400
X-MC-Unique: saBc7kh5OXeRnG5Q306ZPw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1B531927804;
        Wed, 19 May 2021 11:37:34 +0000 (UTC)
Received: from x1.com (ovpn-112-250.rdu2.redhat.com [10.10.112.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BDD746090F;
        Wed, 19 May 2021 11:37:21 +0000 (UTC)
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
Subject: [RFC PATCH 03/16] rv/include: Add helper functions for deterministic automata
Date:   Wed, 19 May 2021 13:36:24 +0200
Message-Id: <e30553f3d1f8840737c7179f228c95549b936300.1621414942.git.bristot@redhat.com>
In-Reply-To: <cover.1621414942.git.bristot@redhat.com>
References: <cover.1621414942.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formally, a deterministic automaton, denoted by G, is defined as a
quintuple:

  G = { X, E, f, x_0, X_m }

where:
	- X is the set of states;
	- E is the finite set of events;
	- x_0 is the initial state;
	- X_m (subset of X) is the set of marked states.
	- f : X x E -> X $ is the transition function. It defines the
	  state transition in the occurrence of a event from E in
	  the state X. In the special case of deterministic automata,
	  the occurence of the event in E in a state in X has a
	  deterministic next state from X.

An automaton can also be represented using a graphical format of
vertices (nodes) and edges. The open-source tool Graphviz can produce
this graphic format using the (textual) DOT language as the source code.

The dot2c tool presented in this paper:

DE OLIVEIRA, Daniel Bristot; CUCINOTTA, Tommaso; DE OLIVEIRA, Romulo
Silva. Efficient formal verification for the Linux kernel. In:
International Conference on Software Engineering and Formal Methods.
Springer, Cham, 2019. p. 315-332.

Translates a deterministic automaton in the DOT format into a C
source code representation that to be used for monitoring.

This header file implements helper functions to facilitate the usage
of the C output from dot2c for monitoring.

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
 include/rv/automata.h | 52 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 include/rv/automata.h

diff --git a/include/rv/automata.h b/include/rv/automata.h
new file mode 100644
index 000000000000..b95941bf78ac
--- /dev/null
+++ b/include/rv/automata.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Deterministic automata helper functions, to be used with the automata
+ * models in C generated by the dot2k tool.
+ *
+ * The dot2k tool is available at https://gitlab.com/linux-rv-tools/dot2/.
+ *
+ * Copyright (C) 2019-2021 Daniel Bristot de Oliveira <bristot@redhat.com>
+ */
+
+#define DECLARE_AUTOMATA_HELPERS(name, type)					\
+										\
+static inline void *model_get_model_##name(void)				\
+{										\
+	return (void *) &automaton_##name;					\
+}										\
+										\
+char *model_get_state_name_##name(enum states_##name state)			\
+{										\
+	return automaton_##name.state_names[state];				\
+}										\
+										\
+char *model_get_event_name_##name(enum events_##name event)			\
+{										\
+	return automaton_##name.event_names[event];				\
+}										\
+										\
+static inline type model_get_init_state_##name(void)				\
+{										\
+	return automaton_##name.initial_state;					\
+}										\
+										\
+static inline type 								\
+model_get_next_state_##name(enum states_##name curr_state,			\
+			    enum events_##name event)				\
+{										\
+	if ((curr_state < 0) || (curr_state > state_max))			\
+		return -1;							\
+										\
+	if ((event < 0) || (event > event_max))					\
+		return -1;							\
+										\
+	return automaton_##name.function[curr_state][event];			\
+}										\
+										\
+static inline bool model_is_final_state_##name(enum states_##name state)	\
+{										\
+	if ((state < 0) || (state > state_max))					\
+		return 0;							\
+										\
+	return !!automaton_##name.final_states[state];				\
+}
-- 
2.26.2

