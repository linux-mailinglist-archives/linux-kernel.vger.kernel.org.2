Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7475A3D1A8A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 01:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhGUXNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 19:13:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:36932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229700AbhGUXNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 19:13:12 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC28E61177;
        Wed, 21 Jul 2021 23:53:47 +0000 (UTC)
Date:   Wed, 21 Jul 2021 19:53:41 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] tracing: Clean up alloc_synth_event()
Message-ID: <20210721195341.29bb0f77@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

alloc_synth_event() currently has the following code to initialize the
event fields and dynamic_fields:

	for (i = 0, j = 0; i < n_fields; i++) {
		event->fields[i] = fields[i];

		if (fields[i]->is_dynamic) {
			event->dynamic_fields[j] = fields[i];
			event->dynamic_fields[j]->field_pos = i;
			event->dynamic_fields[j++] = fields[i];
			event->n_dynamic_fields++;
		}
	}

1) It would make more sense to have all fields keep track of their
   field_pos.

2) event->dynmaic_fields[j] is assigned twice for no reason.

3) We can move updating event->n_dynamic_fields outside the loop, and just
   assign it to j.

This combination makes the code much cleaner.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_synth.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 2ac75eb6aa86..9315fc03e303 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -893,15 +893,13 @@ static struct synth_event *alloc_synth_event(const char *name, int n_fields,
 	dyn_event_init(&event->devent, &synth_event_ops);
 
 	for (i = 0, j = 0; i < n_fields; i++) {
+		fields[i]->field_pos = i;
 		event->fields[i] = fields[i];
 
-		if (fields[i]->is_dynamic) {
-			event->dynamic_fields[j] = fields[i];
-			event->dynamic_fields[j]->field_pos = i;
+		if (fields[i]->is_dynamic)
 			event->dynamic_fields[j++] = fields[i];
-			event->n_dynamic_fields++;
-		}
 	}
+	event->n_dynamic_fields = j;
 	event->n_fields = n_fields;
  out:
 	return event;
-- 
2.31.1

