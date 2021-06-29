Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B873C3B718D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 13:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbhF2LvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 07:51:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:34934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233540AbhF2LvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 07:51:19 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 126B561D22;
        Tue, 29 Jun 2021 11:48:52 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1lyCEU-000SX7-Uj; Tue, 29 Jun 2021 07:48:50 -0400
Message-ID: <20210629114811.473560262@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 29 Jun 2021 07:48:11 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/6] tracing: Minor fixes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: b62613b431bdababc90bf1440b2c7427172d94f4


Colin Ian King (1):
      tracing: Fix spelling in osnoise tracer "interferences" -> "interference"

Daniel Bristot de Oliveira (4):
      trace/osnoise: Fix 'no previous prototype' warnings
      trace/osnoise: Make interval u64 on osnoise_main
      trace/osnoise: Fix return value on osnoise_init_hotplug_support
      Documentation: Fix a typo on trace/osnoise-tracer

Steven Rostedt (VMware) (1):
      tracing: Have osnoise_main() add a quiescent state for task rcu

----
 Documentation/trace/osnoise-tracer.rst |  2 +-
 arch/x86/kernel/trace.c                |  3 ---
 include/linux/trace.h                  |  2 ++
 include/trace/events/osnoise.h         |  2 +-
 kernel/trace/trace_osnoise.c           | 29 +++++++++++++++++------------
 5 files changed, 21 insertions(+), 17 deletions(-)
