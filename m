Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 712C042CC2C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 22:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhJMU5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 16:57:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:34084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229496AbhJMU5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 16:57:38 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5C7761152;
        Wed, 13 Oct 2021 20:55:34 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1malHh-0069la-JS; Wed, 13 Oct 2021 16:55:33 -0400
Message-ID: <20211013205111.587708359@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 13 Oct 2021 16:51:11 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Yordan Karadzhov <y.karadz@gmail.com>
Subject: [PATCH v2 0/2] tracing: Fix removal of eprobes and add test
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When doing the following:

 # echo 'e:hrstate timer/hrtimer_cancel state=+0x38($hrtimer):u8' >> dynamic_events

 # echo '-:hrstate timer/hrtimer_cancel state=+0x38($hrtimer):u8' >> dynamic_events

It errors out with -ENOENT. This is because the "match" function does not
take into account the "timer/hrtimer_cancel" part. Fix it and also make it
work more genericly like kprobes and uprobes.

v1 at: https://lore.kernel.org/all/20211013234206.37dd18ffcc2a2cbf4493f125@kernel.org/

Changes since v1:
 - Instead of just fixing the missing system/event, have it be more like
   kprobes and uprobes.

Steven Rostedt (VMware) (2):
      tracing: Fix event probe removal from dynamic events
      selftests/ftrace: Update test for more eprobe removal process

----
 kernel/trace/trace_eprobe.c                        | 54 ++++++++++++++++++++--
 .../ftrace/test.d/dynevent/add_remove_eprobe.tc    | 54 +++++++++++++++++++++-
 2 files changed, 103 insertions(+), 5 deletions(-)
