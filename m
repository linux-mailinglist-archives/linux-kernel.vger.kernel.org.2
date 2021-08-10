Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 361513E50E7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 04:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237401AbhHJCHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 22:07:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:50876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237364AbhHJCHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 22:07:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 85C3861051;
        Tue, 10 Aug 2021 02:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628561228;
        bh=ohI1wuBAqtsyYAj8yxhwmAvEM/GPvJlP7tpikIeTGIU=;
        h=From:To:Cc:Subject:Date:From;
        b=uVWggwGY7RzxR00Ef8ZIeMPLzP9MO910MqLX6vdHCduNkYal/zs4rVOYg3KRuzdbz
         Ewj4lvp780mnYwefl4jBkHy2SSRj46m90naqYf2wDYIV1WKzQ8NeCtt9fEngj9Op/7
         vpaDgQKT7GfXpZYXUkcqf8J1FxaoVAd3lst1WK0UEnvesd8o7LuqvIHHWPKi8YVNuw
         Yu6NyNc5KZ8fmMj8IST/mnx7T/bEuTGbP5ULScGh6rjfNjYQBu0PU089IA7mEoxwtf
         PsXu8U+A/kI6uaOE+QaJawHJI8zTuyabye3UDVZLA1lc+LVpRf5d0aR7xu7JSTxC5V
         gNnMwh3I/PiAQ==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v4 00/10] tracing/boot: Add histogram syntax support in boot-time tracing
Date:   Tue, 10 Aug 2021 11:07:05 +0900
Message-Id: <162856122550.203126.17607127017097781682.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is the 4th version of boot-time tracing to add histogram
syntax extension with a bugfix related hist-trigger.

The last version is here (NOTE: the subject version was wrong)
  https://lore.kernel.org/lkml/162852406891.143877.12110677006587392853.stgit@devnote2/

This version fixes build warnings and some issues;

Changes from v3:
 [2/10] - Add 'const' qualifier for @str parameter of append_str_nospace().
 [5/10] - Fix to add braces for if block.
 [8/10] - Fix to remove spaces in the expression for the variables.

Changes from v2:
 [1/10] - Use IS_ENABLED() instead of #ifdef and show an error.
 [2/10] - Allow var expression includes spaces.
 [4/10] - Fixes a build error when CONFIG_HIST_TRIGGERS=n.
 [10/10] - Newly added.


'Histogram' options
-------------------
Currently, the boot-time tracing only supports per-event actions
for setting trigger actions. This is enough for short actions
like 'traceon', 'traceoff', 'snapshot' etc. However, it is not good
for the 'hist' trigger action because it is usually too long to write
it in a single string especially if it has an 'onmatch' action.

Here is the new syntax.

    ftrace[.instance.INSTANCE].event.GROUP.EVENT.hist[.N] {
         keys = <KEY>[,...]
         values = <VAL>[,...]
         sort = <SORT-KEY>[,...]
         size = <ENTRIES>
         name = <HISTNAME>
         var { <VAR> = <EXPR> ... }
         pause|continue|clear
         onmax|onchange[.M] { var = <VAR>, <ACTION> [= <PARAM>] }
         onmatch[.M] { event = <EVENT>, <ACTION> [= <PARAM>] }
         filter = <FILTER>
    }
    
Where <ACTION> is one of below;
    
    trace = <EVENT>, <ARG1>[, ...]
    save = <ARG1>[, ...]
    snapshot

And "N" and "M" are digit started strings for multiple histograms
and actions.

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


Thank you,

---

Masami Hiramatsu (10):
      tracing/boot: Fix a hist trigger dependency for boot time tracing
      tracing/boot: Add per-event histogram action options
      tracing/boot: Support multiple handlers for per-event histogram
      tracing/boot: Support multiple histograms for each event
      tracing/boot: Show correct histogram error command
      Documentation: tracing: Add histogram syntax to boot-time tracing
      tools/bootconfig: Support per-group/all event enabling option
      tools/bootconfig: Add histogram syntax support to bconf2ftrace.sh
      tools/bootconfig: Use per-group/all enable option in ftrace2bconf script
      bootconfig/tracing/ktest: Update ktest example for boot-time tracing


 Documentation/trace/boottime-trace.rst             |   85 +++++-
 kernel/trace/trace_boot.c                          |  302 ++++++++++++++++++++
 tools/bootconfig/scripts/bconf2ftrace.sh           |  101 +++++++
 tools/bootconfig/scripts/ftrace2bconf.sh           |   24 +-
 tools/bootconfig/scripts/xbc.sh                    |    4 
 .../ktest/examples/bootconfigs/boottrace.bconf     |   20 +
 .../ktest/examples/bootconfigs/verify-boottrace.sh |    2 
 7 files changed, 513 insertions(+), 25 deletions(-)

-- 
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
