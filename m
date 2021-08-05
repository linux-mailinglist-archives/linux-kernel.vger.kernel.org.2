Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 911753E18A5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242377AbhHEPtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:49:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:51710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242016AbhHEPtv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:49:51 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D933260234;
        Thu,  5 Aug 2021 15:49:36 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mBfcl-0037v6-H8; Thu, 05 Aug 2021 11:49:35 -0400
Message-ID: <20210805154336.208362117@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 05 Aug 2021 11:43:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/6] tracing: Fixes for 5.14-rc4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various tracing fixes:

- Fix NULL pointer dereference caused by an error path

- Give histogram calculation fields a size, otherwise it breaks synthetic
  creation based on them.

- Reject strings being used for number calculations.

- Fix recordmcount.pl warning on llvm building RISC-V allmodconfig

- Fix the draw_functrace.py script to handle the new trace output

- Fix warning of smp_processor_id() in preemptible code


Hui Su (1):
      scripts/tracing: fix the bug that can't parse raw_trace_func

Kamal Agrawal (1):
      tracing: Fix NULL pointer dereference in start_creating

Masami Hiramatsu (1):
      tracing: Reject string operand in the histogram expression

Nathan Chancellor (1):
      scripts/recordmcount.pl: Remove check_objcopy() and $can_use_local

Steven Rostedt (VMware) (2):
      tracing / histogram: Give calculation hist_fields a size
      tracing: Quiet smp_processor_id() use in preemptable warning in hwlat

----
 Makefile                          |  1 -
 kernel/trace/trace.c              |  4 +++-
 kernel/trace/trace_events_hist.c  | 24 ++++++++++++++++++++++-
 kernel/trace/trace_hwlat.c        |  2 +-
 scripts/recordmcount.pl           | 40 ---------------------------------------
 scripts/tracing/draw_functrace.py |  6 +++---
 6 files changed, 30 insertions(+), 47 deletions(-)
