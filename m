Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1496F3D3AB8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 14:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235266AbhGWMQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 08:16:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:40126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235110AbhGWMQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 08:16:01 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2842660E8C;
        Fri, 23 Jul 2021 12:56:35 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1m6ujC-001hi1-6C; Fri, 23 Jul 2021 08:56:34 -0400
Message-ID: <20210723125634.028254509@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 23 Jul 2021 08:54:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 4/7] tracing: Clean up alloc_synth_event()
References: <20210723125454.570472450@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Link: https://lkml.kernel.org/r/20210721195341.29bb0f77@oasis.local.home

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
2.30.2
