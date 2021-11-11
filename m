Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 269EA44CEC0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 02:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbhKKB0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 20:26:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:46830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232723AbhKKB0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 20:26:04 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A02D61105;
        Thu, 11 Nov 2021 01:23:16 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1mkyo6-000Aec-HK;
        Wed, 10 Nov 2021 20:23:14 -0500
Message-ID: <20211111012254.044048524@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 10 Nov 2021 20:22:54 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/2] tracing: A couple of fixes for 5.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: 2e6e9058d13a22a6fdd36a8c444ac71d9656003a


Jiri Olsa (1):
      ftrace/direct: Fix lockup in modify_ftrace_direct_multi

Steven Rostedt (VMware) (1):
      ring-buffer: Protect ring_buffer_reset() from reentrancy

----
 kernel/trace/ftrace.c      | 3 ++-
 kernel/trace/ring_buffer.c | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)
