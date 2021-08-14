Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE493EC021
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 06:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236878AbhHNDq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 23:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236466AbhHNDq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 23:46:28 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9684BC061756
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 20:45:52 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id l11so14518539plk.6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 20:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f7Q3hi4vJ9mQSFnT2XmEnl79wviaaPF5gP4vrjyGOKU=;
        b=o9y0F50buXejeFnjZeqEWM2fZ+DulGOJG1vkHkaZepbiIM7V1Iprd3Tvks6PVtiuKw
         zAFhQETY2+fNtSwkhBxdG72cOKa77OZMJLfeEsRv90H36agExrJ8CnMC49PrYzDhlaIb
         UxoXEzvpXiEPx0zhLQqJK3C7+skxU72mZ0beKZWwFVLuOlBz5ZyWMQJFDiXw+Bg3C69M
         HLF95G/O8Y4z4nyHcXlslkfCPCy+XIZBS4yiAaExMnahifHRg7Si7LwztItnFgtQkRXF
         l4WyKsaTS9yoBt2tv4pdmeaYNdbB7aDNfgF+oZjMLYvOTSnSgMna9u85u4hT4pHxBF3b
         //Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f7Q3hi4vJ9mQSFnT2XmEnl79wviaaPF5gP4vrjyGOKU=;
        b=IgXSTusj/KH5JOYO7HC84QfeB6ftxumej4OQCiBrmU2cfh+Ub8A/lgamouSo2mS2iE
         H01UXM4iBXrnsl1NBpxbp/2ZGQ8DWC+SEaIHaLlC+H5UG3Dm4Oad/48XkK18bWQ1btjo
         /GWjzlcNPxnE7dHz4WUG0CmJE60bZ9LKwFT5mmQ60SrdXK+GhQmnXfCmAAADPafzpOvX
         9hpVJmzHyYMGdcDP6+7hBFEhu7QHAf5xbzMA99/Y+vl9+wfkLwa+BUqzoE+JI/IVl0p6
         /Y56NCwPrITPjGSHB+8xVal1reA0x9ieL7N+C8ePDtBwR9BuTsAwfkj9LZujFMiFL3ty
         UgCQ==
X-Gm-Message-State: AOAM532TCVlHcpiX6S4fRo+EUrN6cYpLh4iHj4nH+dNppMSQTcn059Km
        fMnHfofYapI60mGdasrXljaoHxM6+g==
X-Google-Smtp-Source: ABdhPJyDxjElBQlFT41kSp2WACl8eyRckHLrjxKmPMPLizAfSNBkZwS9Hj4UqhBRttTR8ZDhzbgRBg==
X-Received: by 2002:a17:90a:5305:: with SMTP id x5mr5490466pjh.135.1628912751417;
        Fri, 13 Aug 2021 20:45:51 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id e31sm3239930pjk.19.2021.08.13.20.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 20:45:50 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH] tracing/trace: apply filters on all output channels
Date:   Sat, 14 Aug 2021 11:45:38 +0800
Message-Id: <20210814034538.8428-1-kernelfans@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The event filters are not applied on all of the output, which results in
the flood of printk when using tp_printk. Unfolding
event_trigger_unlock_commit_regs() into trace_event_buffer_commit(), so
the filters can be applied on every output.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
To: linux-kernel@vger.kernel.org
---
 kernel/trace/trace.c | 18 +++++++++++++++---
 kernel/trace/trace.h | 32 --------------------------------
 2 files changed, 15 insertions(+), 35 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 33899a71fdc1..a1adb29ef5c1 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2897,14 +2897,26 @@ int tracepoint_printk_sysctl(struct ctl_table *table, int write,
 
 void trace_event_buffer_commit(struct trace_event_buffer *fbuffer)
 {
+	enum event_trigger_type tt = ETT_NONE;
+	struct trace_event_file *file = fbuffer->trace_file;
+
+	if (__event_trigger_test_discard(file, fbuffer->buffer, fbuffer->event,
+			fbuffer->entry, &tt))
+		goto discard;
+
 	if (static_key_false(&tracepoint_printk_key.key))
 		output_printk(fbuffer);
 
 	if (static_branch_unlikely(&trace_event_exports_enabled))
 		ftrace_exports(fbuffer->event, TRACE_EXPORT_EVENT);
-	event_trigger_unlock_commit_regs(fbuffer->trace_file, fbuffer->buffer,
-				    fbuffer->event, fbuffer->entry,
-				    fbuffer->trace_ctx, fbuffer->regs);
+
+	trace_buffer_unlock_commit_regs(file->tr, fbuffer->buffer,
+			fbuffer->event, fbuffer->trace_ctx, fbuffer->regs);
+
+discard:
+	if (tt)
+		event_triggers_post_call(file, tt);
+
 }
 EXPORT_SYMBOL_GPL(trace_event_buffer_commit);
 
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index a180abf76d4e..4a0e693000c6 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1389,38 +1389,6 @@ event_trigger_unlock_commit(struct trace_event_file *file,
 		event_triggers_post_call(file, tt);
 }
 
-/**
- * event_trigger_unlock_commit_regs - handle triggers and finish event commit
- * @file: The file pointer associated with the event
- * @buffer: The ring buffer that the event is being written to
- * @event: The event meta data in the ring buffer
- * @entry: The event itself
- * @trace_ctx: The tracing context flags.
- *
- * This is a helper function to handle triggers that require data
- * from the event itself. It also tests the event against filters and
- * if the event is soft disabled and should be discarded.
- *
- * Same as event_trigger_unlock_commit() but calls
- * trace_buffer_unlock_commit_regs() instead of trace_buffer_unlock_commit().
- */
-static inline void
-event_trigger_unlock_commit_regs(struct trace_event_file *file,
-				 struct trace_buffer *buffer,
-				 struct ring_buffer_event *event,
-				 void *entry, unsigned int trace_ctx,
-				 struct pt_regs *regs)
-{
-	enum event_trigger_type tt = ETT_NONE;
-
-	if (!__event_trigger_test_discard(file, buffer, event, entry, &tt))
-		trace_buffer_unlock_commit_regs(file->tr, buffer, event,
-						trace_ctx, regs);
-
-	if (tt)
-		event_triggers_post_call(file, tt);
-}
-
 #define FILTER_PRED_INVALID	((unsigned short)-1)
 #define FILTER_PRED_IS_RIGHT	(1 << 15)
 #define FILTER_PRED_FOLD	(1 << 15)
-- 
2.29.2

