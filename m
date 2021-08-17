Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2EE03EF2D6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 21:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234214AbhHQToZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 15:44:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:46566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233700AbhHQTnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 15:43:41 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 341D061078;
        Tue, 17 Aug 2021 19:43:07 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mG4zK-004TVk-8i; Tue, 17 Aug 2021 15:43:06 -0400
Message-ID: <20210817194306.106905566@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 17 Aug 2021 15:42:26 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 19/19] MAINTAINERS: Add an entry for os noise/latency
References: <20210817194207.947725935@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The "latency" tracers have some different requirements than normal
tracing, and also includes Daniel as a maintainer. Add a section in the
MAINTAINERS file to help direct patches and bug reports to these tracers
to the right people.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6c8be735cc91..4268644cf86a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18798,6 +18798,20 @@ F:	arch/x86/mm/testmmiotrace.c
 F:	include/linux/mmiotrace.h
 F:	kernel/trace/trace_mmiotrace.c
 
+TRACING OS NOISE / LATENCY TRACERS
+M:	Steven Rostedt <rostedt@goodmis.org>
+M:	Daniel Bristot de Oliveira <bristot@kernel.org>
+S:	Maintained
+F:	kernel/trace/trace_osnoise.c
+F:	include/trace/events/osnoise.h
+F:	kernel/trace/trace_hwlat.c
+F:	kernel/trace/trace_irqsoff.c
+F:	kernel/trace/trace_sched_wakeup.c
+F:	Documentation/trace/osnoise-tracer.rst
+F:	Documentation/trace/timerlat-tracer.rst
+F:	Documentation/trace/hwlat_detector.rst
+F:	arch/*/kernel/trace.c
+
 TRIVIAL PATCHES
 M:	Jiri Kosina <trivial@kernel.org>
 S:	Maintained
-- 
2.30.2
