Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04F663E1967
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 18:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhHEQZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 12:25:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:41690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229437AbhHEQZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 12:25:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E4430610CD;
        Thu,  5 Aug 2021 16:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628180723;
        bh=kjoyo7By9aAPYD8HyCQ+op278XxMffbnQN6NtG8ZAV8=;
        h=From:To:Cc:Subject:Date:From;
        b=PtK7178Mh3RqgA45Zyrn0HupM+lxeFd/6UsePHkGJAftEyXJEfh8NV+JmSM0joWi0
         RHqkdrL07naSJWrSVhkFEac0hh4AdS/eaM+lAh+oTiHYb6XLFroCM2vjr96JwbuNIo
         o6eV/ndHwoONA03OxyhNA9eiKajUFWwOoP/8vWoFxqqVRQGzrj276FheGdR+pGLm8j
         Mf2+H7OTG1zA4D3Jl3H97NPfQvbQNL7Xdm/QlHWr+F0fc1ydfyHFaNXSbjG0wWa6ki
         gTqKFqYHq+zksJXEg0RfiVW4fBOY4dTAbU4dz2JTIx7AV82EhRbMLs5OMUF2kev9Uz
         ixvmveIDWpCSA==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v2 0/9] tracing/boot: Add histogram syntax support in boot-time tracing
Date:   Fri,  6 Aug 2021 01:25:21 +0900
Message-Id: <162818072104.226227.18088999222035270055.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is the 2nd version of boot-time tracing to add histogram
syntax extension with a bugfix related hist-trigger.

In this version, I added multi-histograms and multi-hist-actions
support, and update bconf2ftrace.sh to support it. But the
ftrace2bconf.sh is still uses per-event "actions" option because
this "hist" syntax is for programming histogram on the bootconfig
from scratch.
This series also includes per-group/all event enable option
support in bconf2ftrace.sh and ftrce2bconf.sh.

Other changes in v2:
[2/9]: 
       - Cleanup code to add ':' as a prefix for each element
         instead of fixup the last ':'.
       - Fix syntax typo for handler actions.
       - Make pause|continue|clear mutual exclusive.
       - Add __printf() attribute to the append_printf().

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


TODO
====
- Need to expand ktest testcase for checking this syntax.

Thank you,

---

Masami Hiramatsu (9):
      tracing/boot: Fix a hist trigger dependency for boot time tracing
      tracing/boot: Add per-event histogram action options
      tracing/boot: Support multiple handlers for per-event histogram
      tracing/boot: Support multiple histograms for each event
      tracing/boot: Show correct histogram error command
      Documentation: tracing: Add histogram syntax to boot-time tracing
      tools/bootconfig: Support per-group/all event enabling option
      tools/bootconfig: Add histogram syntax support to bconf2ftrace.sh
      tools/bootconfig: Use per-group/all enable option in ftrace2bconf script


 tools/bootconfig/scripts/bconf2ftrace.sh |   97 ++++++++++++++++++++++++++++++
 tools/bootconfig/scripts/ftrace2bconf.sh |   24 ++++++-
 tools/bootconfig/scripts/xbc.sh          |    4 +
 3 files changed, 117 insertions(+), 8 deletions(-)

-- 
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
