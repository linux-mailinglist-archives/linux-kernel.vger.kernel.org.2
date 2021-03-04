Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C34032D533
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 15:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238406AbhCDOWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 09:22:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:45396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239961AbhCDOVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 09:21:53 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82AC864F49;
        Thu,  4 Mar 2021 14:20:32 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1lHoq7-001nxA-GP; Thu, 04 Mar 2021 09:20:31 -0500
Message-ID: <20210304142031.390073029@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 04 Mar 2021 09:19:57 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 5/5] ring-buffer: Add a little more information and a WARN when time stamp
 going backwards is detected
References: <20210304141952.446924335@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

When the CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is enabled, and the time
stamps are detected as not being valid, it reports information about the
write stamp, but does not show the before_stamp which is still useful
information. Also, it should give a warning once, such that tests detect
this happening.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 342f49c3ccc5..68744c51517e 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3318,9 +3318,13 @@ static void check_buffer(struct ring_buffer_per_cpu *cpu_buffer,
 			goto out;
 		}
 		atomic_inc(&cpu_buffer->record_disabled);
-		pr_warn("[CPU: %d]TIME DOES NOT MATCH expected:%lld actual:%lld delta:%lld after:%lld\n",
-		       cpu_buffer->cpu,
-		       ts + info->delta, info->ts, info->delta, info->after);
+		/* There's some cases in boot up that this can happen */
+		WARN_ON_ONCE(system_state != SYSTEM_BOOTING);
+		pr_warn("[CPU: %d]TIME DOES NOT MATCH expected:%lld actual:%lld delta:%lld before:%lld after:%lld%s\n",
+			cpu_buffer->cpu,
+			ts + info->delta, info->ts, info->delta,
+			info->before, info->after,
+			full ? " (full)" : "");
 		dump_buffer_page(bpage, info, tail);
 		atomic_dec(&ts_dump);
 		/* Do not re-enable checking */
-- 
2.30.0


