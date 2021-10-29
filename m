Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0251643FDD2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 16:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbhJ2OFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 10:05:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:60528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231676AbhJ2OFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 10:05:49 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 810AE61177;
        Fri, 29 Oct 2021 14:03:20 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1mgSTX-001ApE-G8;
        Fri, 29 Oct 2021 10:03:19 -0400
Message-ID: <20211029140208.987338181@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 29 Oct 2021 10:02:08 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/2] tracing: Comment fixes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some bots have informed me that some of the ftrace functions kernel-doc
has formatting issues.

Also, fix my snake instinct.

Steven Rostedt (VMware) (2):
      ftrace: Fix kernel-doc formatting issues
      tracing: Fix misspelling of "missing"

----
 kernel/trace/ftrace.c       | 18 ++++++++++--------
 kernel/trace/trace_eprobe.c |  2 +-
 2 files changed, 11 insertions(+), 9 deletions(-)
