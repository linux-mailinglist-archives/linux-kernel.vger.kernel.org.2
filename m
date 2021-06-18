Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D10123ACC0B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 15:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233624AbhFRNXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 09:23:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:59984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232678AbhFRNXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 09:23:35 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDE99613D1;
        Fri, 18 Jun 2021 13:21:26 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1luER3-003VDt-Is; Fri, 18 Jun 2021 09:21:25 -0400
Message-ID: <20210618132046.600413369@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 18 Jun 2021 09:20:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/4] tracing: Some fixes for 5.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Tracing fixes for 5.13:

 - Have recordmcount check for valid st_shndx otherwise some archs may have
   invalid references for the mcount location.

 - Two fixes done for mapping pids to task names. Traces were not showing
   the names of tasks when they should have.

 - Fix to trace_clock_global() to prevent it from going backwards

Peter Zijlstra (1):
      recordmcount: Correct st_shndx handling

Steven Rostedt (VMware) (3):
      tracing: Do not stop recording cmdlines when tracing is off
      tracing: Do not stop recording comms if the trace file is being read
      tracing: Do no increment trace_clock_global() by one

----
 kernel/trace/trace.c       | 11 -----------
 kernel/trace/trace_clock.c |  6 +++---
 scripts/recordmcount.h     | 15 ++++++++++-----
 3 files changed, 13 insertions(+), 19 deletions(-)
