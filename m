Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4329388CEE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 13:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbhESLio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 07:38:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28223 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240507AbhESLii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 07:38:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621424238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=0f8vP1rWZYglKzBrwMKgwIOO8/SUkZ27guvK+0A3NC0=;
        b=SNm9yUhcfIPDNr2w7Z6rAOOQHB3s9ARwEC2mBtckra9l1YvibOwDoWHnYUnOeN8ncP6/82
        PlwBMb1YZLIpHuNDvWmFhXx/QjHHJCCDB/JR8JCuKtDEwO9Vx2lWlmIBXm0qfK9mXIM6rk
        8nkdljB8DleAcpuGyTi+sQGzqKCw/Qw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-d2Ep16atNqyxNqn-eewLJA-1; Wed, 19 May 2021 07:37:13 -0400
X-MC-Unique: d2Ep16atNqyxNqn-eewLJA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 544586D585;
        Wed, 19 May 2021 11:37:11 +0000 (UTC)
Received: from x1.com (ovpn-112-250.rdu2.redhat.com [10.10.112.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6DFA6687D3;
        Wed, 19 May 2021 11:36:57 +0000 (UTC)
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
Subject: [RFC PATCH 00/16] The Runtime Verification (RV) interface
Date:   Wed, 19 May 2021 13:36:21 +0200
Message-Id: <cover.1621414942.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Over the last years, I've been exploring the possibility of
verifying the Linux kernel behavior using Runtime Verification.

Runtime Verification (RV) is a lightweight (yet rigorous) method that
complements classical exhaustive verification techniques (such as model
checking and theorem proving) with a more practical approach for complex
systems.

Instead of relying on a fine-grained model of a system (e.g., a
re-implementation a instruction level), RV works by analyzing the trace of the
system's actual execution, comparing it against a formal specification of
the system behavior.

The usage of deterministic automaton for RV is a well-established
approach. In the specific case of the Linux kernel, you can check how
to model complex behavior of the Linux kernel with this paper:

  DE OLIVEIRA, Daniel Bristot; CUCINOTTA, Tommaso; DE OLIVEIRA, Rômulo Silva.
  *Efficient formal verification for the Linux kernel.* In: International
  Conference on Software Engineering and Formal Methods. Springer, Cham, 2019.
  p. 315-332.

And how efficient is this approach here:

  DE OLIVEIRA, Daniel B.; DE OLIVEIRA, Rômulo S.; CUCINOTTA, Tommaso. *A thread
  synchronization model for the PREEMPT_RT Linux kernel.* Journal of Systems
  Architecture, 2020, 107: 101729.

tlrd: it is possible to model complex behaviors in a modular way, with
an acceptable overhead (even for production systems). See this
presentation at 2019's ELCE: https://www.youtube.com/watch?v=BfTuEHafNgg

Here I am proposing a more practical approach for the usage of deterministic
automata for runtime verification, and it includes:

	- An interface for controlling the verification.
	- A tool and set of headers that enables the automatic code
	  generation of the RV monitor (Monitor Synthesis).

Given that RV is a tracing consumer, the code is being placed inside the
tracing subsystem (Steven and I have been talking about it for a while).

In this RFC I am still not proposing any complex model. Instead, I am
presenting only simple monitors that help to illustrate the usage of
the automatic code generation and the RV interface. This is important to
enable other researchers and developers to start using/extending this method.

It is also worth mentioning that this work has been heavily motivated by
the usage of Linux on safety critical systems, mainly by the people
involved in the Elisa Project. Indeed, we will be talking about the
usage of RV in this field on today's presentation:

A Maintainable and Scalable Kernel Qualification Approach for Automotive
Gabriele Paoloni, Intel Corporation & Daniel Bristot de Oliveira, Red Hat

At the Elisa workshop.

The more academic concepts behind this approach have been discussed with
some researchers, including:

 - Romulo Silva de Oliveira - Universidade Federal de Santa Catarina
   (BR)
 - Tommaso Cucinotta - Scuola Superiore Sant'Anna (IT)
 - Srdan Krstic - ETH Zurich (CH)
 - Dmitriy Traytel - University of Copenhagen (DK)

Thanks!
Daniel Bristot de Oliveira (16):
  rv: Add Runtime Verification (RV) interface
  rv: Add runtime reactors interface
  rv/include: Add helper functions for deterministic automata
  rv/include: Add deterministic automata monitor definition via C macros
  rv/include: Add tracing helper functions
  tools/rv: Add dot2c
  tools/rv: Add dot2k
  rv/monitors: Add the wip monitor skeleton created by dot2k
  rv/monitors: wip instrumentation and Makefile/Kconfig entries
  rv/monitors: Add the wwnr monitor skeleton created by dot2k
  rv/monitors: wwnr instrumentation and Makefile/Kconfig entries
  rv/reactors: Add the printk reactor
  rv/reactors: Add the panic reactor
  rv/docs: Add a basic documentation
  rv/docs: Add deterministic automata monitor synthesis documentation
  rv/docs: Add deterministic automata instrumentation documentation

 Documentation/trace/index.rst                 |   1 +
 .../trace/rv/da_monitor_instrumentation.rst   | 230 ++++++
 .../trace/rv/da_monitor_synthesis.rst         | 286 +++++++
 Documentation/trace/rv/index.rst              |   9 +
 .../trace/rv/runtime-verification.rst         | 233 ++++++
 include/linux/rv.h                            |  31 +
 include/rv/automata.h                         |  52 ++
 include/rv/da_monitor.h                       | 336 +++++++++
 include/rv/trace_helpers.h                    |  69 ++
 kernel/trace/Kconfig                          |   2 +
 kernel/trace/Makefile                         |   2 +
 kernel/trace/rv/Kconfig                       |  60 ++
 kernel/trace/rv/Makefile                      |   8 +
 kernel/trace/rv/monitors/wip/model.h          |  38 +
 kernel/trace/rv/monitors/wip/wip.c            | 124 ++++
 kernel/trace/rv/monitors/wip/wip.h            |  64 ++
 kernel/trace/rv/monitors/wwnr/model.h         |  38 +
 kernel/trace/rv/monitors/wwnr/wwnr.c          | 122 +++
 kernel/trace/rv/monitors/wwnr/wwnr.h          |  70 ++
 kernel/trace/rv/reactors/panic.c              |  44 ++
 kernel/trace/rv/reactors/printk.c             |  43 ++
 kernel/trace/rv/rv.c                          | 700 ++++++++++++++++++
 kernel/trace/rv/rv.h                          |  50 ++
 kernel/trace/rv/rv_reactors.c                 | 478 ++++++++++++
 kernel/trace/trace.c                          |   4 +
 kernel/trace/trace.h                          |   2 +
 tools/tracing/rv/dot2/Makefile                |  26 +
 tools/tracing/rv/dot2/automata.py             | 179 +++++
 tools/tracing/rv/dot2/dot2c                   |  30 +
 tools/tracing/rv/dot2/dot2c.py                | 240 ++++++
 tools/tracing/rv/dot2/dot2k                   |  49 ++
 tools/tracing/rv/dot2/dot2k.py                | 184 +++++
 .../rv/dot2/dot2k_templates/main_global.c     |  96 +++
 .../rv/dot2/dot2k_templates/main_global.h     |  64 ++
 .../rv/dot2/dot2k_templates/main_per_cpu.c    |  96 +++
 .../rv/dot2/dot2k_templates/main_per_cpu.h    |  64 ++
 .../rv/dot2/dot2k_templates/main_per_task.c   |  96 +++
 .../rv/dot2/dot2k_templates/main_per_task.h   |  70 ++
 38 files changed, 4290 insertions(+)
 create mode 100644 Documentation/trace/rv/da_monitor_instrumentation.rst
 create mode 100644 Documentation/trace/rv/da_monitor_synthesis.rst
 create mode 100644 Documentation/trace/rv/index.rst
 create mode 100644 Documentation/trace/rv/runtime-verification.rst
 create mode 100644 include/linux/rv.h
 create mode 100644 include/rv/automata.h
 create mode 100644 include/rv/da_monitor.h
 create mode 100644 include/rv/trace_helpers.h
 create mode 100644 kernel/trace/rv/Kconfig
 create mode 100644 kernel/trace/rv/Makefile
 create mode 100644 kernel/trace/rv/monitors/wip/model.h
 create mode 100644 kernel/trace/rv/monitors/wip/wip.c
 create mode 100644 kernel/trace/rv/monitors/wip/wip.h
 create mode 100644 kernel/trace/rv/monitors/wwnr/model.h
 create mode 100644 kernel/trace/rv/monitors/wwnr/wwnr.c
 create mode 100644 kernel/trace/rv/monitors/wwnr/wwnr.h
 create mode 100644 kernel/trace/rv/reactors/panic.c
 create mode 100644 kernel/trace/rv/reactors/printk.c
 create mode 100644 kernel/trace/rv/rv.c
 create mode 100644 kernel/trace/rv/rv.h
 create mode 100644 kernel/trace/rv/rv_reactors.c
 create mode 100644 tools/tracing/rv/dot2/Makefile
 create mode 100644 tools/tracing/rv/dot2/automata.py
 create mode 100644 tools/tracing/rv/dot2/dot2c
 create mode 100644 tools/tracing/rv/dot2/dot2c.py
 create mode 100644 tools/tracing/rv/dot2/dot2k
 create mode 100644 tools/tracing/rv/dot2/dot2k.py
 create mode 100644 tools/tracing/rv/dot2/dot2k_templates/main_global.c
 create mode 100644 tools/tracing/rv/dot2/dot2k_templates/main_global.h
 create mode 100644 tools/tracing/rv/dot2/dot2k_templates/main_per_cpu.c
 create mode 100644 tools/tracing/rv/dot2/dot2k_templates/main_per_cpu.h
 create mode 100644 tools/tracing/rv/dot2/dot2k_templates/main_per_task.c
 create mode 100644 tools/tracing/rv/dot2/dot2k_templates/main_per_task.h

-- 
2.26.2

