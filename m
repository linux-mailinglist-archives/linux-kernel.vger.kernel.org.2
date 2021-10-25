Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A55EC439DCF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 19:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234291AbhJYRpc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 25 Oct 2021 13:45:32 -0400
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:34451 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234338AbhJYRpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 13:45:12 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-3-_tFsGSOWiLRiOUbSyQ-Q-1; Mon, 25 Oct 2021 13:42:44 -0400
X-MC-Unique: 3-_tFsGSOWiLRiOUbSyQ-Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1704D8018AC;
        Mon, 25 Oct 2021 17:42:43 +0000 (UTC)
Received: from x1.com (unknown [10.22.9.145])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C1D405C1CF;
        Mon, 25 Oct 2021 17:42:39 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V5 18/20] rtla: Add rtla timerlat documentation
Date:   Mon, 25 Oct 2021 19:40:43 +0200
Message-Id: <27fb29dae0d383b70f1a79ba7e308aa99cd335e4.1635181938.git.bristot@kernel.org>
In-Reply-To: <cover.1635181938.git.bristot@kernel.org>
References: <cover.1635181938.git.bristot@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=bristot@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Man page for rtla timerlat tool.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Tom Zanussi <zanussi@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: John Kacur <jkacur@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: linux-rt-users@vger.kernel.org
Cc: linux-trace-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 .../rtla/common_timerlat_description.rst      | 10 ++++
 Documentation/tools/rtla/rtla-timerlat.rst    | 57 +++++++++++++++++++
 2 files changed, 67 insertions(+)
 create mode 100644 Documentation/tools/rtla/common_timerlat_description.rst
 create mode 100644 Documentation/tools/rtla/rtla-timerlat.rst

diff --git a/Documentation/tools/rtla/common_timerlat_description.rst b/Documentation/tools/rtla/common_timerlat_description.rst
new file mode 100644
index 000000000000..321201cb8597
--- /dev/null
+++ b/Documentation/tools/rtla/common_timerlat_description.rst
@@ -0,0 +1,10 @@
+The **rtla timerlat** tool is an interface for the *timerlat* tracer. The
+*timerlat* tracer dispatches a kernel thread per-cpu. These threads
+set a periodic timer to wake themselves up and go back to sleep. After
+the wakeup, they collect and generate useful information for the
+debugging of operating system timer latency.
+
+The *timerlat* tracer outputs information in two ways. It periodically
+prints the timer latency at the timer *IRQ* handler and the *Thread*
+handler. It also enable the trace of the most relevant information via
+**osnoise:** tracepoints.
diff --git a/Documentation/tools/rtla/rtla-timerlat.rst b/Documentation/tools/rtla/rtla-timerlat.rst
new file mode 100644
index 000000000000..44a49e6f302b
--- /dev/null
+++ b/Documentation/tools/rtla/rtla-timerlat.rst
@@ -0,0 +1,57 @@
+================
+rtla-timerlat
+================
+-------------------------------------------
+Measures the operating system timer latency
+-------------------------------------------
+
+:Manual section: 1
+
+SYNOPSIS
+========
+**rtla timerlat** [*MODE*] ...
+
+DESCRIPTION
+===========
+
+.. include:: common_timerlat_description.rst
+
+The *timerlat* tracer outputs information in two ways. It periodically
+prints the timer latency at the timer *IRQ* handler and the *Thread* handler.
+It also provides information for each noise via the **osnoise:** tracepoints.
+The **rtla timerlat top** mode displays a summary of the periodic output
+from the *timerlat* tracer. The **rtla hist hist** mode displays a histogram
+of each tracer event occurrence. For further details, please refer to the
+respective man page.
+
+MODES
+=====
+**top**
+
+        Prints the summary from *timerlat* tracer.
+
+**hist**
+
+        Prints a histogram of timerlat samples.
+
+If no *MODE* is given, the top mode is called, passing the arguments.
+
+OPTIONS
+=======
+**-h**, **--help**
+
+        Display the help text.
+
+For other options, see the man page for the corresponding mode.
+
+SEE ALSO
+========
+**rtla-timerlat-top**\(1), **rtla-timerlat-hist**\(1)
+
+*timerlat* tracer documentation: <https://www.kernel.org/doc/html/latest/trace/timerlat-tracer.html>
+
+AUTHOR
+======
+Written by Daniel Bristot de Oliveira <bristot@kernel.org>
+
+.. include:: common_appendix.rst
-- 
2.31.1

