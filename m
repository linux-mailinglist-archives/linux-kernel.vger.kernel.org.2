Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7343A32DE9C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 01:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbhCEAwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 19:52:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:39054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231719AbhCEAw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 19:52:28 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6A9565010;
        Fri,  5 Mar 2021 00:52:27 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1lHyhe-001sTk-AT; Thu, 04 Mar 2021 19:52:26 -0500
Message-ID: <20210305005201.588505771@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 04 Mar 2021 19:52:01 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/3] More tracing fixes for 5.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Functional fix:

 - Memory leak in __create_synth_event()

 - Skip selftests if tracing is disabled

Non functional fix:

 - Fix stale comment about the trace_event_call flags.

Steven Rostedt (VMware) (2):
      tracing: Skip selftests if tracing is disabled
      tracing: Fix comment about the trace_event_call flags

Vamshi K Sthambamkadi (1):
      tracing: Fix memory leak in __create_synth_event()

----
 include/linux/trace_events.h      | 11 ++---------
 kernel/trace/trace.c              |  6 ++++++
 kernel/trace/trace_events_synth.c |  4 +++-
 3 files changed, 11 insertions(+), 10 deletions(-)
