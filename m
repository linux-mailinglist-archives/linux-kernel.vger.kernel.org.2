Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB5344EDDE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 21:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235422AbhKLU0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 15:26:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:50630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230235AbhKLU0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 15:26:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 20220610D0;
        Fri, 12 Nov 2021 20:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636748623;
        bh=VIk6ub/vJ/ZXG7gf/Kx2J2c9zNoNj3SsrmhCKPmTD04=;
        h=From:To:Cc:Subject:Date:From;
        b=GtjbObMWiamQmqW4U1swcur75sMb1Z2b5mjkycjh7LGtqDGFo5Zbc11H/6rlDcyrk
         kuGfkP3LZkO7GGgjLLAX/KvMTxSZRUdxQb5FfT+V0dmGzqn6fdFQz0PGIl3TM9zQ00
         W8s9v+r3NA3llvrQ5bACalrtW3xe9t2fiu0b9KLuZ5XLXZ8iIAZzbpVVpzeTJxP2p6
         tNVCsvovmynPE/zGeRD7frUYu6lU3aL9WE/6BesG8vWHfSOp8FPe49U45X0kZstVDr
         JFjXz6Acgt8MlgjQ3tpEu6z+/iFtDZ3vHte46fqhnl17A2uVGvBuuKnf8A/kEhkuZ2
         a2UQa2WWyseHw==
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] tracing: Add and use event_command parsing func helpers
Date:   Fri, 12 Nov 2021 14:23:38 -0600
Message-Id: <cover.1636748267.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With more event commands being implemented, it's been pointed out that
it would make sense to clean up the existing ones and make it easier
to implement new ones without copying a lot of boilerplate.  The main
culprit here is the event_command.func() callback - the rest of the
event_command infrastructure has default implementations that work for
most implementations.  The func() callback is a little different in
that every new command needs to customize parsing to some extent.

This patchset attempts to help clean that up and make it easier for
new users to deal with.

v2: removed unused event_trigger_remove(). No change in functionality.

The following changes since commit 67d4f6e3bf5dddced226fbf19704cdbbb0c98847:

  ftrace/samples: Add missing prototype for my_direct_func (2021-11-01 20:56:51 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git ftrace/cleanup-hist-func-v2

Tom Zanussi (2):
  tracing: Add helper functions to simplify event_command callback
    handling
  tracing: Have existing event_command implementations use helpers

 kernel/trace/trace.h                |  21 ++
 kernel/trace/trace_events_hist.c    |  52 ++---
 kernel/trace/trace_events_trigger.c | 294 ++++++++++++++++------------
 3 files changed, 208 insertions(+), 159 deletions(-)

-- 
2.17.1

