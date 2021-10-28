Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F14243D953
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 04:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbhJ1CcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 22:32:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:37496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229534AbhJ1CcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 22:32:13 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EB8C60F56;
        Thu, 28 Oct 2021 02:29:47 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1mfvAo-0010zN-I0;
        Wed, 27 Oct 2021 22:29:46 -0400
Message-ID: <20211028022915.320082859@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 27 Oct 2021 22:29:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [for-next][PATCH 0/3] tracing: More updates for 5.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: e531e90b5ab0f7ce5ff298e165214c1aec6ed187


Robin H. Johnson (2):
      tracing: Show size of requested perf buffer
      tracing: Increase PERF_MAX_TRACE_SIZE to handle Sentinel1 and docker together

Steven Rostedt (VMware) (1):
      bootconfig: Initialize ret in xbc_parse_tree()

----
 include/linux/trace_events.h    | 2 +-
 kernel/trace/trace_event_perf.c | 3 ++-
 lib/bootconfig.c                | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)
