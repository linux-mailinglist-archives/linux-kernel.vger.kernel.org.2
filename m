Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C25B30DF35
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 17:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234791AbhBCQII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 11:08:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:36034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234915AbhBCQHY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 11:07:24 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C5E964FA2;
        Wed,  3 Feb 2021 16:05:50 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1l7Kf7-009J7Z-En; Wed, 03 Feb 2021 11:05:49 -0500
Message-ID: <20210203160549.333398424@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 03 Feb 2021 11:05:22 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Qiujun Huang <hqjagain@gmail.com>
Subject: [for-next][PATCH 05/15] ring-buffer: Drop unneeded check in ring_buffer_resize()
References: <20210203160517.982448432@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiujun Huang <hqjagain@gmail.com>

Remove the cpumask check, as we has done it at the beginning of
the function.
Also fix a typo. s/also the on the/also on the/

Link: https://lkml.kernel.org/r/20201224144634.3210-1-hqjagain@gmail.com

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 8fccee76a5f3..b9dad3500041 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2059,10 +2059,6 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 
 		put_online_cpus();
 	} else {
-		/* Make sure this CPU has been initialized */
-		if (!cpumask_test_cpu(cpu_id, buffer->cpumask))
-			goto out;
-
 		cpu_buffer = buffer->buffers[cpu_id];
 
 		if (nr_pages == cpu_buffer->nr_pages)
@@ -2580,7 +2576,7 @@ rb_move_tail(struct ring_buffer_per_cpu *cpu_buffer,
 			 * have filled up the buffer with events
 			 * from interrupts and such, and wrapped.
 			 *
-			 * Note, if the tail page is also the on the
+			 * Note, if the tail page is also on the
 			 * reader_page, we let it move out.
 			 */
 			if (unlikely((cpu_buffer->commit_page !=
-- 
2.29.2


