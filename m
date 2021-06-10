Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8423A21B1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 03:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhFJBDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 21:03:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:38908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229507AbhFJBDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 21:03:53 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7400613FE;
        Thu, 10 Jun 2021 01:01:57 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1lr952-002bWY-PJ; Wed, 09 Jun 2021 21:01:56 -0400
Message-ID: <20210610010130.069460694@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 09 Jun 2021 21:01:30 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 00/11] tracing: Updates for 5.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Chunguang Xu (1):
      trace: replace WB_REASON_FOREIGN_FLUSH with a string

Colin Ian King (1):
      tracing: Remove redundant initialization of variable ret

Ed Tsai (1):
      sched/tracing: Remove the redundant 'success' in the sched tracepoint

Hyeonggon Yoo (1):
      tracing: Add WARN_ON_ONCE when returned value is negative

Jiapeng Chong (1):
      tracing: Remove redundant assignment to event_var

Joe Perches (1):
      treewide: Add missing semicolons to __assign_str uses

Masami Hiramatsu (2):
      tracing/boot: Add per-group/all events enablement
      Documentation: tracing: Add per-group/all events enablement desciption

Qiujun Huang (1):
      tracing: Fix set_named_trigger_data() kernel-doc comment

Wei Ming Chen (1):
      ring-buffer: Use fallthrough pseudo-keyword

zuoqilin (1):
      tools/bootconfig: Simplify expression

----
 Documentation/trace/boottime-trace.rst             |  6 ++++
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
 include/trace/events/btrfs.h                       |  2 +-
 include/trace/events/dma_fence.h                   |  4 +--
 include/trace/events/rpcgss.h                      |  4 +--
 include/trace/events/sched.h                       |  2 --
 include/trace/events/sunrpc.h                      | 40 +++++++++++-----------
 include/trace/events/writeback.h                   |  3 +-
 kernel/trace/ring_buffer.c                         |  2 +-
 kernel/trace/trace.c                               |  2 +-
 kernel/trace/trace_boot.c                          | 27 +++++++++++++--
 kernel/trace/trace_events_hist.c                   |  3 +-
 kernel/trace/trace_events_trigger.c                |  3 +-
 net/mac80211/trace.h                               |  2 +-
 tools/bootconfig/main.c                            |  4 +--
 31 files changed, 110 insertions(+), 82 deletions(-)
