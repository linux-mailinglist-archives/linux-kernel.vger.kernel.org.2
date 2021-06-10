Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB9E3A217B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 02:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhFJAjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 20:39:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:55998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229557AbhFJAjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 20:39:32 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B762613F1;
        Thu, 10 Jun 2021 00:37:37 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1lr8hT-002b51-W5; Wed, 09 Jun 2021 20:37:35 -0400
Message-ID: <20210610003344.783752614@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 09 Jun 2021 20:33:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Liangyan <liangyan.peng@linux.alibaba.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Zhen Lei <thunder.leizhen@huawei.com>
Subject: [for-linus][PATCH 0/5] tracing: Fixes for 5.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tracing fixes for 5.13:

 - Fix the length check in the temp buffer filter

 - Fix record mcount handling of st_shndx

 - Fix build failure in bootconfig tools for "fallthrough"

 - Fix error return of bootconfig apply_xbc() routine

Liangyan (1):
      tracing: Correct the length check which causes memory corruption

Masami Hiramatsu (1):
      tools/bootconfig: Fix a build error accroding to undefined fallthrough

Peter Zijlstra (1):
      recordmcount: Correct st_shndx handling

Steven Rostedt (VMware) (1):
      ftrace: Do not blindly read the ip address in ftrace_bug()

Zhen Lei (1):
      tools/bootconfig: Fix error return code in apply_xbc()

----
 kernel/trace/ftrace.c                       |  8 +++++++-
 kernel/trace/trace.c                        |  2 +-
 scripts/recordmcount.h                      | 13 +++++++++----
 tools/bootconfig/include/linux/bootconfig.h |  4 ++++
 tools/bootconfig/main.c                     |  1 +
 5 files changed, 22 insertions(+), 6 deletions(-)
