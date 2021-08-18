Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 869363F080E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 17:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239225AbhHRPbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 11:31:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:54228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233436AbhHRPbO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 11:31:14 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CCDF6108D;
        Wed, 18 Aug 2021 15:30:40 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mGNWY-004ZGP-Ka; Wed, 18 Aug 2021 11:30:38 -0400
Message-ID: <20210818152449.512418563@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 18 Aug 2021 11:24:49 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Deepthi Dhulipalla <dedhul@microsoft.com>,
        Carlos Cardenas <Carlos.Cardenas@microsoft.com>,
        Beau Belgrave <beaub@microsoft.com>
Subject: [RFC][PATCH 0/2] tracefs/tracing: Remove "other" permission from tracefs
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently tracefs is mounted with just 0700, keeping anyone that is not root
from accessing it. But tracefs is like any other file system, where its
permissions can be modified via chmod, chgrp, chown commands. Admins can
change the permission of the file system for their own needs. Of course,
because tracefs is a pseudo file system, a reboot will remove any updates an
admin makes.

There really is no reason why any of the files in tracefs should allow any
permission for the "other" group. Thus, make it so that, by default, all the
files created in tracefs do not have any permission bits set for other. An
admin can still change it to allow other to have permission to access
tracefs, but then they get to own the fallout that creates.


Steven Rostedt (VMware) (2):
      tracefs: Have tracefs directories not set OTH permission bits by default
      tracing: Disable "other" permission bits in the tracefs files

----
 fs/tracefs/inode.c                    |  3 +-
 kernel/trace/ftrace.c                 | 23 +++++------
 kernel/trace/trace.c                  | 73 ++++++++++++++++++-----------------
 kernel/trace/trace.h                  |  3 ++
 kernel/trace/trace_dynevent.c         |  2 +-
 kernel/trace/trace_events.c           | 42 ++++++++++----------
 kernel/trace/trace_events_synth.c     |  4 +-
 kernel/trace/trace_functions_graph.c  |  2 +-
 kernel/trace/trace_hwlat.c            |  6 +--
 kernel/trace/trace_kprobe.c           |  8 ++--
 kernel/trace/trace_osnoise.c          | 14 +++----
 kernel/trace/trace_printk.c           |  2 +-
 kernel/trace/trace_recursion_record.c |  4 +-
 kernel/trace/trace_stack.c            |  6 +--
 kernel/trace/trace_stat.c             |  6 +--
 kernel/trace/trace_uprobe.c           |  4 +-
 16 files changed, 105 insertions(+), 97 deletions(-)
