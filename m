Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6C5731C2AE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 20:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbhBOT4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 14:56:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:48874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230000AbhBOT4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 14:56:39 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB91664E1E;
        Mon, 15 Feb 2021 19:55:58 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1lBjyP-0009SE-N3; Mon, 15 Feb 2021 14:55:57 -0500
Message-ID: <20210215195533.101751000@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 15 Feb 2021 14:55:33 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/5] tracing: Last minute updates for 5.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masami Hiramatsu (3):
      tracing: Show real address for trace event arguments
      tracing: Update the stage 3 of trace event macro comment
      tracing: Add ptr-hash option to show the hashed pointer value

Steven Rostedt (VMware) (1):
      tracing: Make hash-ptr option default

Viktor Rosendahl (1):
      tracing/tools: Add the latency-collector to tools directory

----
 Documentation/trace/ftrace.rst            |    6 +
 include/linux/trace_events.h              |    4 +
 include/trace/trace_events.h              |   31 +-
 kernel/trace/trace.c                      |   77 +-
 kernel/trace/trace.h                      |    3 +
 kernel/trace/trace_output.c               |   12 +-
 tools/Makefile                            |   14 +-
 tools/tracing/Makefile                    |   19 +
 tools/tracing/latency/.gitignore          |    2 +
 tools/tracing/latency/Makefile            |   24 +
 tools/tracing/latency/latency-collector.c | 2108 +++++++++++++++++++++++++++++
 11 files changed, 2281 insertions(+), 19 deletions(-)
 create mode 100644 tools/tracing/Makefile
 create mode 100644 tools/tracing/latency/.gitignore
 create mode 100644 tools/tracing/latency/Makefile
 create mode 100644 tools/tracing/latency/latency-collector.c
