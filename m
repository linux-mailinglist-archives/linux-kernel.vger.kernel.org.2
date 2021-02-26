Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D814326737
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 20:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbhBZTHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 14:07:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:39004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230131AbhBZTHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 14:07:47 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23E5D64F2B;
        Fri, 26 Feb 2021 19:07:07 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1lFiS9-0017WS-Ls; Fri, 26 Feb 2021 14:07:05 -0500
Message-ID: <20210226185909.100032746@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 26 Feb 2021 13:59:09 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jacob Wen <jian.w.wen@oracle.com>
Subject: [PATCH 0/2] tracing: Detect unsafe dereferencing of pointers from trace events
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


After seeing that an unsafe string dereference in a trace event made
it into the kernel, I decided it's time to add some sanity checks to
catch these cases without needing me to supervise.

The first patch scans the print fmts of the trace events looking for
dereferencing pointers from %p*, and making sure that they refer back
to the trace event itself.

The second patch handles strings "%s", as there are cases that are
fine with dereferencing the string outside the trace event. On reading
of the trace file, the %s is looked for and when found, the logic checks
the pointer that it is about to be dereferenced to see if it is a
valid location. This check would have caught the last unsafe dereference
committed into the kernel.


Steven Rostedt (VMware) (2):
      tracing: Add check of trace event print fmts for dereferencing pointers
      tracing: Add a verifier to check string pointers for trace events

----
 kernel/trace/trace.c        | 148 +++++++++++++++++++++++++++++++++
 kernel/trace/trace.h        |   2 +
 kernel/trace/trace_events.c | 198 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/trace/trace_output.c |   2 +-
 4 files changed, 349 insertions(+), 1 deletion(-)
