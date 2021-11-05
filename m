Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95832446A7C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 22:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233905AbhKEVXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 17:23:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:55538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233897AbhKEVXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 17:23:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1051A61101;
        Fri,  5 Nov 2021 21:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636147220;
        bh=XdP5fImKLYZtWvVQRdwYFGiHmNWZXEQGIZlU0/e78jM=;
        h=From:To:Cc:Subject:Date:From;
        b=XR11xfJw5qDMrFOSv/rw9sOVwuphGbQTboPpeLgZ2anUj3EHGpjgvaKDnr98wdQS/
         l0Q8Hl3gX/8S0symA44ZHm9HCnaSpbTULrFp46SIwY/NsKEDrWk9jtNCpJn7f1ZF9a
         cg+WVgr9QLp+KVsd8HTCzT/qrbeBPN7gZVvPf47CzYALM/XOQyviOHPDBVzGD4GdY+
         W34TJE2CrZkzdd9BrdGfBWW22aNEBjwOghtwbB94uxhhD3pt6yEmFEKcNnZZwKRbXI
         SvACpgsIkJS1gnXCNO5KKQ3B5IIjgLOr+lGS/2FV0Xpxd0MdvRGyzkCVySbZsKol5b
         ViP9riohX8n9Q==
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] tracing: Add and use event_command parsing func helpers
Date:   Fri,  5 Nov 2021 16:20:14 -0500
Message-Id: <cover.1636146732.git.zanussi@kernel.org>
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

Tom

The following changes since commit 67d4f6e3bf5dddced226fbf19704cdbbb0c98847:

  ftrace/samples: Add missing prototype for my_direct_func (2021-11-01 20:56:51 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git ftrace/cleanup-hist-func-v1

Tom Zanussi (2):
  tracing: Add helper functions to simplify event_command callback
    handling
  tracing: Have existing event_command implementations use helpers

 kernel/trace/trace.h                |  21 ++
 kernel/trace/trace_events_hist.c    |  52 ++---
 kernel/trace/trace_events_trigger.c | 312 +++++++++++++++++-----------
 3 files changed, 226 insertions(+), 159 deletions(-)

-- 
2.17.1

