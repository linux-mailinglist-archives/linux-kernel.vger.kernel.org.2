Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9D8245ADA1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 21:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239134AbhKWU5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 15:57:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:36932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232689AbhKWU5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 15:57:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8E82A60FBF;
        Tue, 23 Nov 2021 20:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637700839;
        bh=MFdbRlCK68ZN3DYMTpZPI0jDdpdkpo1V/Loq2M5bVeQ=;
        h=From:To:Cc:Subject:Date:From;
        b=gRwwE0CIu+/cIEzPvR8o7GgVayqgW7LmD8fNn7tNKBO7AlZ4m+aiAoCvnRWuebdS2
         rW6PfKvW90qDaPJRQ9zVh3rMYCPpUcqI5ckizTacx+h/LdbrNUCuh/KjCNXsjBWWjx
         sMOrwbbTk6hAvhv4MFjHASwnyEPQQA9ptetJ1m7EufLr5IbIn+pFMWYHvGnh8DzPFO
         w+UA0UfSabA42lMc36ba2ARFMt691oGM9JuS4qGGLfomMur4zaYbtYNCGUCc+h0SV/
         uDm8twtOZQ9qZvMifeFSnP7xDSq1iOG9zGpD6Ee85fRHD/CqIohxmRQXL9+wBUqc07
         NfdU6WDGDaBzw==
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] tracing: Add and use event_command parsing func helpers
Date:   Tue, 23 Nov 2021 14:53:52 -0600
Message-Id: <cover.1637700535.git.zanussi@kernel.org>
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

v3: broke up event_trigger_check() into smaller functions instead of
    parameterizing it, and added function documentation.

v2: removed unused event_trigger_remove(). No change in functionality.

The following changes since commit 67d4f6e3bf5dddced226fbf19704cdbbb0c98847:

  ftrace/samples: Add missing prototype for my_direct_func (2021-11-01 20:56:51 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git ftrace/cleanup-hist-func-v3

Tom Zanussi (2):
  tracing: Add helper functions to simplify event_command callback
    handling
  tracing: Have existing event_command implementations use helpers

 kernel/trace/trace.h                |  23 ++
 kernel/trace/trace_events_hist.c    |  51 +---
 kernel/trace/trace_events_trigger.c | 439 ++++++++++++++++++++--------
 3 files changed, 361 insertions(+), 152 deletions(-)

-- 
2.17.1

