Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C46703B8AD9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 01:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236528AbhF3XVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 19:21:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:38916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235699AbhF3XUw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 19:20:52 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CE016145E;
        Wed, 30 Jun 2021 23:18:23 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1lyjTK-000ZC7-0L; Wed, 30 Jun 2021 19:18:22 -0400
Message-ID: <20210630231758.861158022@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 30 Jun 2021 19:17:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/5] tracing: A few more fixes before sending to 5.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: 78c14b385c195d4f25ab7c19186b8897a5b9ae3f


Austin Kim (1):
      tracing: Change variable type as bool for clean-up

Daniel Bristot de Oliveira (2):
      trace/osnoise: Make 'noise' variable s64 in run_osnoise()
      trace/timerlat: Fix indentation on timerlat_main()

Joe Perches (1):
      treewide: Add missing semicolons to __assign_str uses

Steven Rostedt (VMware) (1):
      tracepoint: Add tracepoint_probe_register_may_exist() for BPF tracing

----
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h          | 14 ++++----
 drivers/gpu/drm/lima/lima_trace.h                  |  2 +-
 drivers/infiniband/hw/hfi1/trace_misc.h            |  4 +--
 drivers/infiniband/hw/hfi1/trace_rc.h              |  4 +--
 drivers/infiniband/hw/hfi1/trace_tid.h             |  6 ++--
 drivers/infiniband/hw/hfi1/trace_tx.h              |  8 ++---
 drivers/infiniband/sw/rdmavt/trace_cq.h            |  4 +--
 drivers/infiniband/sw/rdmavt/trace_mr.h            |  2 +-
 drivers/infiniband/sw/rdmavt/trace_qp.h            |  4 +--
 drivers/infiniband/sw/rdmavt/trace_rc.h            |  2 +-
 drivers/infiniband/sw/rdmavt/trace_tx.h            |  4 +--
 drivers/misc/mei/mei-trace.h                       |  6 ++--
 .../net/ethernet/marvell/octeontx2/af/rvu_trace.h  | 12 +++----
 drivers/net/fjes/fjes_trace.h                      |  4 +--
 drivers/usb/cdns3/cdnsp-trace.h                    |  2 +-
 fs/nfs/nfs4trace.h                                 |  6 ++--
 fs/nfs/nfstrace.h                                  |  4 +--
 include/linux/tracepoint.h                         | 10 ++++++
 include/trace/events/btrfs.h                       |  2 +-
 include/trace/events/dma_fence.h                   |  4 +--
 include/trace/events/rpcgss.h                      |  4 +--
 include/trace/events/sunrpc.h                      | 40 +++++++++++-----------
 kernel/trace/bpf_trace.c                           |  3 +-
 kernel/trace/trace_osnoise.c                       | 11 +++---
 kernel/trace/trace_sched_wakeup.c                  | 24 ++++++-------
 kernel/tracepoint.c                                | 33 ++++++++++++++++--
 26 files changed, 129 insertions(+), 90 deletions(-)
