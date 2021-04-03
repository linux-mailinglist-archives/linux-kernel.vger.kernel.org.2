Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44280353454
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 16:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236675AbhDCOeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 10:34:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:52430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236431AbhDCOef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 10:34:35 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2F4D6125F;
        Sat,  3 Apr 2021 14:34:32 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1lShM7-0040EL-FC; Sat, 03 Apr 2021 10:34:31 -0400
Message-ID: <20210403143347.409590683@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 03 Apr 2021 10:33:47 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/4] tracing: More updates for 5.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: ceaaa12904df07d07ea8975abbf04c4d60e46956


Linus Torvalds (1):
      ftrace: Store the order of pages allocated in ftrace_page

Steven Rostedt (VMware) (1):
      ftrace: Simplify the calculation of page number for ftrace_page->records some more

Wan Jiabing (1):
      tracing: Remove duplicate struct declaration in trace_events.h

Yordan Karadzhov (VMware) (1):
      tracing: Remove unused argument from "ring_buffer_time_stamp()

----
 include/linux/ring_buffer.h  |  2 +-
 include/linux/trace_events.h |  1 -
 kernel/trace/ftrace.c        | 45 +++++++++++++++++++-------------------------
 kernel/trace/ring_buffer.c   |  2 +-
 kernel/trace/trace.c         |  8 ++++----
 5 files changed, 25 insertions(+), 33 deletions(-)
