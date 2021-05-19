Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 370BC388D18
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 13:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352022AbhESLlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 07:41:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42823 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352001AbhESLlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 07:41:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621424386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=URn7MWi/R9Q3K3e788yAjQiRxwoagRSsHU4hsK4JEhA=;
        b=YHIi4kbQr8CPEKW7lpdm7ZVstdV+FPGA7sRcYekQvOkTNQoQ7KsgzxAF5hjKhIC+ZwJz3E
        AH6O6qaGxiSqoPccZoSswDs6D14yMB27wzAnsRmpLREYDd6wl0avEHZR0uJFW+SOcZykTV
        T2VgKVrP7hgG8DdoPiMk31KOVJNt7Es=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-c9Ryo7b0Pv6tixMsetcxtg-1; Wed, 19 May 2021 07:39:44 -0400
X-MC-Unique: c9Ryo7b0Pv6tixMsetcxtg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 803F0107ACCA;
        Wed, 19 May 2021 11:39:42 +0000 (UTC)
Received: from x1.com (ovpn-112-250.rdu2.redhat.com [10.10.112.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 31134687E1;
        Wed, 19 May 2021 11:39:37 +0000 (UTC)
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
Subject: [RFC PATCH 15/16] rv/docs: Add deterministic automata monitor synthesis documentation
Date:   Wed, 19 May 2021 13:36:36 +0200
Message-Id: <49959c04157ecf7e972551555533b08d70d57bd7.1621414942.git.bristot@redhat.com>
In-Reply-To: <cover.1621414942.git.bristot@redhat.com>
References: <cover.1621414942.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the da_monitor_synthesis.rst introduces some concepts behind the
Deterministic Automata (DA) monitor synthesis and interface.

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
 .../trace/rv/da_monitor_synthesis.rst         | 286 ++++++++++++++++++
 1 file changed, 286 insertions(+)
 create mode 100644 Documentation/trace/rv/da_monitor_synthesis.rst

diff --git a/Documentation/trace/rv/da_monitor_synthesis.rst b/Documentation/trace/rv/da_monitor_synthesis.rst
new file mode 100644
index 000000000000..697eb5a45910
--- /dev/null
+++ b/Documentation/trace/rv/da_monitor_synthesis.rst
@@ -0,0 +1,286 @@
+Deterministic Automata Monitor Synthesis
+========================================
+
+The starting point for the application of runtime verification (RV) technics is
+the *specification* or *modeling* of the desired (or undesired) behavior of the
+system under scrutiny.
+
+The formal representation needs to be then *synthesized* into a *monitor* that
+can then be used in the analysis of the trace of the system. The *monitor*
+conects to the system via an *instrumentation* layer, that converts the events
+from the *system* to the events of the *specification*.
+
+This document introduces some concepts behind the **Deterministic Automata
+(DA)** monitor synthesis.
+
+DA monitor synthesis in a nutshell
+------------------------------------------------------
+
+The synthesis of automata-based models into the Linux *RV monitor* abstraction
+is automatized by a tool named "dot2k", and the "rv/da_monitor.h" provided
+by the RV interface.
+
+Given a file "wip.dot", representing a per-cpu monitor, with this content::
+
+  digraph state_automaton {
+	center = true;
+	size = "7,11";
+	rankdir = LR;
+	{node [shape = circle] "non_preemptive"};
+	{node [shape = plaintext, style=invis, label=""] "__init_preemptive"};
+	{node [shape = doublecircle] "preemptive"};
+	{node [shape = circle] "preemptive"};
+	"__init_preemptive" -> "preemptive";
+	"non_preemptive" [label = "non_preemptive"];
+	"non_preemptive" -> "non_preemptive" [ label = "sched_waking" ];
+	"non_preemptive" -> "preemptive" [ label = "preempt_enable" ];
+	"preemptive" [label = "preemptive"];
+	"preemptive" -> "non_preemptive" [ label = "preempt_disable" ];
+	{ rank = min ;
+		"__init_preemptive";
+		"preemptive";
+	}
+  }
+
+Run the dot2k tool with the model, specifying that it is a "per-cpu"
+model::
+
+  $ dot2k -d ~/wip.dot -t per_cpu
+
+This will create a directory named "wip/" with the following files:
+
+- model.h: the wip in C
+- wip.h: tracepoints that report the execution of the events by the
+  monitor
+- wip.c: the RV monitor
+
+The following line in the "wip.c" file is responsible for the monitor
+synthesis::
+
+  DECLARE_DA_MON_PER_CPU(wip, char);
+
+With that in place, the work left to be done is the *instrumentation* of
+the monitor, which is already initialized by dot2k.
+
+DA: Introduction and representation formats
+---------------------------------------------------------------
+
+Formally, a deterministic automaton, denoted by G, is defined as a quintuple:
+
+        *G* = { *X*, *E*, *f*, x\ :subscript:`0`, X\ :subscript:`m` }
+
+where:
+
+- *X* is the set of states;
+- *E* is the finite set of events;
+- x\ :subscript:`0` is the initial state;
+- X\ :subscript:`m` (subset of *X*) is the set of marked states.
+- *f* : *X* x *E* -> *X* $ is the transition function. It defines the state
+  transition in the occurrence of an event from *E* in the state *X*. In the
+  special case of deterministic automata, the occurrence of the event in *E*
+  in a state in *X* has a deterministic next state from *X*.
+
+One of the most evident benefits for the practical application of the automata
+formalism is its *graphic representation*, represented using vertices (nodes)
+and edges, which is very intuitive for *operating system* practitioners.
+
+For example, given an automata wip, with a regular representation of:
+
+- *X* = { ``preemptive``, ``non_preemptive``}
+- *E* = { ``preempt_enable``, ``preempt_disable``, ``sched_waking``}
+- x\ :subscript:`0` = ``preemptive``
+- X\ :subscript:`m` = {``preemptive``}
+- *f* =
+   - *f*\ (``preemptive``, ``preempt_disable``) = ``non_preemptive``
+   - *f*\ (``non_preemptive``, ``sched_waking``) = ``non_preemptive``
+   - *f*\ (``non_preemptive``, ``preempt_enable``) = ``preemptive``
+
+
+It can also be represented in a graphic format, without any loss, using this
+format::
+
+                       preempt_enable
+          +---------------------------------+
+          v                                 |
+        #============#  preempt_disable   +------------------+
+    --> H preemptive H -----------------> |  non_preemptive  |
+        #============#                    +------------------+
+                                            ^ sched_waking |
+                                            +--------------+
+
+The Graphviz open-source tool can produce this graphic format using the
+(textual) DOT language as the source code. The DOT format is widely
+used and can be converted to many other formats, including the ASCII art above.
+
+The dot2c tool presented in:
+
+  DE OLIVEIRA, Daniel Bristot; CUCINOTTA, Tommaso; DE OLIVEIRA, Rômulo
+  Silva. Efficient formal verification for the Linux kernel. In:
+  International Conference on Software Engineering and Formal Methods.
+  Springer, Cham, 2019. p. 315-332.
+
+Translates a deterministic automaton in the DOT format into a C source
+code. For instance, using the wip model as input for dot2c results in
+the following C representation::
+
+  enum states {
+	preemptive = 0,
+	non_preemptive,
+	state_max
+  };
+
+  enum events {
+	preempt_disable = 0,
+	preempt_enable,
+	sched_waking,
+	event_max
+  };
+
+  struct automaton {
+	char *state_names[state_max];
+	char *event_names[event_max];
+	char function[state_max][event_max];
+	char initial_state;
+	char final_states[state_max];
+  };
+
+  struct automaton aut = {
+	.state_names = {
+		"preemptive",
+		"non_preemptive"
+	},
+	.event_names = {
+		"preempt_disable",
+		"preempt_enable",
+		"sched_waking"
+	},
+	.function = {
+		{ non_preemptive,             -1,             -1 },
+		{             -1,     preemptive, non_preemptive },
+	},
+	.initial_state = preemptive,
+	.final_states = { 1, 0 },
+  };
+
+DA monitor synthesis for Linux
+------------------------------
+
+In Linux terms, the runtime verification monitors are encapsulated
+inside the "RV monitor" abstraction. The "RV monitor" includes a set
+of instances of the monitor (per-cpu monitor, per-task monitor, and
+so on), the helper functions that glue the monitor to the system
+reference model, and the trace output as a reaction for event parsing
+and exceptions, as depicted below::
+
+ Linux  +----- RV Monitor ----------------------------------+ Formal
+  Realm |                                                   |  Realm
+  +-------------------+     +----------------+     +-----------------+
+  |   Linux kernel    |     |     Monitor    |     |     Reference   |
+  |     Tracing       |  -> |   Instance(s)  | <-  |       Model     |
+  | (instrumentation) |     | (verification) |     | (specification) |
+  +-------------------+     +----------------+     +-----------------+
+         |                          |                       |
+         |                          V                       |
+         |                     +----------+                 |
+         |                     | Reaction |                 |
+         |                     +--+--+--+-+                 |
+         |                        |  |  |                   |
+         |                        |  |  +-> trace output ?  |
+         +------------------------|--|----------------------+
+                                  |  +----> panic ?
+                                  +-------> <user-specified>
+
+
+The dot2c tool works connecting the *Reference Model* to the *RV Monitor*
+abstraction by translating the *formal notation* into *code*.
+
+The "rv/da_monitor.h" header goes beyond dot2c, extending the code
+generation to the verification stage, generating the code to the *Monitor
+Instance(s)* level using C macros. The trace event code inspires this
+approach.
+
+The benefits of the usage of macro for monitor synthesis is 3-fold:
+
+- Reduces the code duplication;
+- Facilitates the bug fix/improvement;
+- Avoids the case of developers changing the core of the monitor code
+  to manipulate the model in a (let's say) non-standard way.
+
+This initial implementation presents two different types of monitor instances:
+
+- ``#define DECLARE_DA_MON_PER_CPU(name, type)``
+- ``#define DECLARE_DA_MON_PER_TASK(name, type)``
+
+The first declares the functions for deterministic automata monitor with
+per-cpu instances, and the second with per-task instances.
+
+In both cases, the name is a string that identifies the monitor, and the type
+is the data type used by dot2c/k on the representation of the model.
+
+For example, the "wip" model with two states and three events can be
+stored in a "char" type. Considering that the preemption control is a
+per-cpu behavior, the monitor declaration will be::
+
+  DECLARE_DA_MON_PER_CPU(wip, char);
+
+The monitor is executed by sending events to be processed via the functions
+presented below::
+
+  da_handle_event_$(MONITOR_NAME)($(event from event enum));
+  da_handle_init_event_$(MONITOR_NAME)($(event from event enum));
+
+The function ``da_handle_event_$(MONITOR_NAME)()`` is the regular case,
+while the function ``da_handle_init_event_$(MONITOR_NAME)()`` is a special
+case used to synchronize the system with the model.
+
+When a monitor is enabled, it is placed in the initial state of the automata.
+However, the monitor does not know if the system is in the *initial state*.
+Hence, the monitor ignores events sent by sent by
+``da_handle_event_$(MONITOR_NAME)()`` until the function
+``da_handle_init_event_$(MONITOR_NAME)()`` is called.
+
+The function ``da_handle_init_event_$(MONITOR_NAME)()`` should be used for
+the case in which the system generates the event is the one that returns
+the automata to the initial state.
+
+After receiving a ``da_handle_init_event_$(MONITOR_NAME)()`` event, the
+monitor will know that it is in sync with the system and hence will
+start processing the next events.
+
+Using the wip model as example, the events "preempt_disable" and
+"sched_waking" should be sent to to monitor, respectively, via::
+
+  da_handle_event_wip(preempt_disable);
+  da_handle_event_wip(sched_waking);
+
+While the event "preempt_enabled" will use::
+
+  da_handle_init_event_wip(preempt_enable);
+
+To notify the monitor that the system will be returning to the initial state,
+so the system and the monitor should be in sync.
+
+rv/da_monitor.h
+-------------------------------------------
+
+The "rv/da_monitor.h" is, mostly, a set of C macros that create function
+definitions based on the paremeters passed via ``DECLARE_DA_MON_*``.
+
+In fewer words, the declaration of a monitor generates:
+
+- Helper functions for getting information from the automata model generated
+  by dot2k.
+- Helper functions for the analysis of a deterministic automata model
+- Functions for the initialization of the monitor instances
+- The definition of the structure to store the monitor instances' data
+
+One important aspect is that the monitor does not call external functions
+for the handling of the events sent by the instrumentation, except for
+generating *tracing events* or *reactions*.
+
+Final remarks
+-------------
+
+With the monitor synthesis in place using, the "rv/da_monitor.h" and
+dot2k, the developer's work should be limited to the instrumentation
+of the system, increasing the confidence in the overall approach.
-- 
2.26.2

