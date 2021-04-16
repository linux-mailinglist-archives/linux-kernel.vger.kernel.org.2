Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B14813626B8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 19:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241903AbhDPR1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 13:27:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:56190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241743AbhDPR1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 13:27:22 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C99A611AE;
        Fri, 16 Apr 2021 17:26:57 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1lXSF6-0069ii-8a; Fri, 16 Apr 2021 13:26:56 -0400
Message-ID: <20210416172612.086725495@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 16 Apr 2021 13:26:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
Subject: [for-next][PATCH 0/7] tracing: Add func_no_repeats option
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt (VMware) <rostedt@goodmis.org>, Yordan Karadzhov (VMware) <y.karadz@gmail.com>
  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: e1db6338d6fa0d409e45cf20ab5aeaca704f68e7


Steven Rostedt (VMware) (1):
      ftrace: Reuse the output of the function tracer for func_repeats

Yordan Karadzhov (VMware) (6):
      tracing: Define static void trace_print_time()
      tracing: Define new ftrace event "func_repeats"
      tracing: Add "last_func_repeats" to struct trace_array
      tracing: Add method for recording "func_repeats" events
      tracing: Unify the logic for function tracing options
      tracing: Add "func_no_repeats" option for function tracing

----
 kernel/trace/trace.c           |  35 +++++++
 kernel/trace/trace.h           |  19 ++++
 kernel/trace/trace_entries.h   |  22 ++++
 kernel/trace/trace_functions.c | 223 +++++++++++++++++++++++++++++++++++------
 kernel/trace/trace_output.c    |  91 ++++++++++++++---
 5 files changed, 346 insertions(+), 44 deletions(-)
