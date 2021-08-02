Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8284E3DDC76
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 17:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234928AbhHBPab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 11:30:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:42272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234751AbhHBPaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 11:30:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 316B4604D7;
        Mon,  2 Aug 2021 15:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627918214;
        bh=qTL3fKMvcvS40WDwqbwMDWQjS5x1kaBcz2ly6CesCmk=;
        h=From:To:Cc:Subject:Date:From;
        b=UvfKWROiUuOplSW3okifOpltNeJLCw/WB+pH7I2fsFTd24JhWZdFoF0WPLk2fLGo/
         iQ8ZSrnUcqX7iPh05s3ia/Jfa1ZFsFiTBvtTC6wR83jKz5KaDSZrvemim6327GCH9E
         9Rx66e636koc5W+3XjjBk4815VNxNViuKeqHKA4i8uYLOAb3i7VbHu3jA5hOdHldqP
         WFVNejxPrkbsjYt8BoE7ulg1xdIhFB70yDRYdT+pN0G6aH1rIsgt/C2oi1JBxOQdjh
         z2rLOJW6YF8wAbMSItGfYosJyIEVvGb7vCnKFPZVphlZZc5d1qKWMJjq93jGPu8/zn
         0UuEsPgjGCSWg==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [RFC PATCH 0/3] tracing/boot: Add histogram syntax support in boot-time tracing
Date:   Tue,  3 Aug 2021 00:30:10 +0900
Message-Id: <162791821009.552329.4358174280895732459.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is a series of patches for boot-time tracing to add histogram
syntax extension and fixes a build issue.

Currently, the boot-time tracing only supports per-event actions
for setting trigger actions. This is enough for short actions
like 'traceon', 'traceoff', 'snapshot' etc. However, it is not good
for the 'hist' trigger action because it is usually too long to write
it in a single string especially if it has an 'onmatch' action.

Here is the new syntax.

    ftrace.[instance.INSTANCE.]event.GROUP.EVENT.hist {
         keys = <KEY>[,...]
         values = <VAL>[,...]
         sort = <SORT-KEY>[,...]
         size = <ENTRIES>
         name = <HISTNAME>
         var { <VAR> = <EXPR> ... }
         pause|continue|clear
         onmax|onchange { var = <VAR>, <ACTION> [= <PARAM>] }
         onmatch { event = <EVENT>, <ACTION> [= <PARAM>] }
         filter = <FILTER>
    }
    
Where <ACTION> is one of below;
    
    trace = <EVENT>, <ARG1>[, ...]
    save = <ARG1>[, ...]
    snapshot

For example,

initcall.initcall_finish.actions =
"hist:keys=func:lat=common_timestamp.usecs-$ts0:onmatch(initcall.initcall_start).trace(initcall_latency,func,$lat)"

This can be written as below;

initcall.initcall_finish.hist {
    keys = func
    var.lat = common_timestamp.usecs-$ts0
    onmatch {
        event = initcall.initcall_start
        trace = initcall_latency, func, $lat
    }
}

Also, you can add comments for each options.


TODO
====
- This version doesn't support multiple histograms on an event. For
  that purpose, you still need to use per-event 'actions' option.
  Maybe it can be extended to support multiple instance by adding
  '_#NUM' subkey, e.g. "hist._1.keys = ...; hist._2.keys = ...".
- This also doesn't support multiple 'onmatch'/'onmax'/'onchange'
  handler actions.
- Need to expand ktest testcase for checking this syntax.

Tom, this version doesn't make pause/continue/clear mutually exclusive.
And onmatch/onmax/onchange, too. As far as I can see the code, those
can be set on one histogram. But maybe I'm wrong. Please tell me if
there is some limitations or exclusiveness among those options.

Thank you,

---

Masami Hiramatsu (3):
      tracing/boot: Fix a hist trigger dependency for boot time tracing
      tracing/boot: Add per-event histogram action options
      Documentation: tracing: Add histogram syntax to boot-time tracing


 Documentation/trace/boottime-trace.rst |   81 ++++++++++++-
 kernel/trace/trace_boot.c              |  203 ++++++++++++++++++++++++++++++++
 2 files changed, 278 insertions(+), 6 deletions(-)

-- 
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
