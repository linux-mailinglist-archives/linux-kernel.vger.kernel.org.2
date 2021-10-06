Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39811424064
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 16:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239119AbhJFOuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 10:50:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:45420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238949AbhJFOuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 10:50:20 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 649B560F4C;
        Wed,  6 Oct 2021 14:48:28 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mY8Db-005Dxx-9D; Wed, 06 Oct 2021 10:48:27 -0400
Message-ID: <20211006144812.024405153@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 06 Oct 2021 10:48:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/2] tracing: Updates for 5.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: 8d6e90983ade25ec7925211ac31d9ccaf64b7edf


Steven Rostedt (VMware) (2):
      tracing: Place trace_pid_list logic into abstract functions
      tracing: Create a sparse bitmask for pid filtering

----
 kernel/trace/Makefile       |   1 +
 kernel/trace/ftrace.c       |   6 +-
 kernel/trace/pid_list.c     | 495 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/trace/pid_list.h     |  88 ++++++++
 kernel/trace/trace.c        |  78 +++----
 kernel/trace/trace.h        |  14 +-
 kernel/trace/trace_events.c |   6 +-
 7 files changed, 627 insertions(+), 61 deletions(-)
 create mode 100644 kernel/trace/pid_list.c
 create mode 100644 kernel/trace/pid_list.h
