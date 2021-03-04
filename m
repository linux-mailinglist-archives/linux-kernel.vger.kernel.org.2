Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3698732D52F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 15:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241830AbhCDOVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 09:21:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:44820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240295AbhCDOVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 09:21:12 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13DB864ED4;
        Thu,  4 Mar 2021 14:20:32 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1lHoq6-001nub-PR; Thu, 04 Mar 2021 09:20:30 -0500
Message-ID: <20210304141952.446924335@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 04 Mar 2021 09:19:52 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/5] Tracing fixes for 5.12:
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Functional fixes:

 - Fix big endian conversion for arg64 in recordmcount processing

 - Fix timestamp corruption in ring buffer on discarding events

Non-functional fixes:

 - Fix help text working in Kconfig

 - Remove duplicate prototype for trace_empty()

Self test update:

 - Add more information to the validation output of when a
   corrupt timestamp is found in the ring buffer, and also
   trigger a warning to make sure that tests catch it.

Chen Jun (1):
      ftrace: Have recordmcount use w8 to read relp->r_info in arm64_is_fake_mcount

Rolf Eike Beer (1):
      tracing: Fix help text of TRACEPOINT_BENCHMARK in Kconfig

Steven Rostedt (VMware) (2):
      ring-buffer: Force before_stamp and write_stamp to be different on discard
      ring-buffer: Add a little more information and a WARN when time stamp going backwards is detected

Yordan Karadzhov (VMware) (1):
      tracing: Remove duplicate declaration from trace.h

----
 kernel/trace/Kconfig       |  2 +-
 kernel/trace/ring_buffer.c | 21 ++++++++++++++++++---
 kernel/trace/trace.h       |  1 -
 scripts/recordmcount.c     |  2 +-
 4 files changed, 20 insertions(+), 6 deletions(-)
