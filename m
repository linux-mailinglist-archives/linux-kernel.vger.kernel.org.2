Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2CA3D64CA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 18:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239611AbhGZQGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 12:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234460AbhGZQD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 12:03:29 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C230C0617A4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 09:41:54 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id 18-20020a05620a0792b02903b8e915ccceso9413508qka.18
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 09:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:cc;
        bh=iy+FgxPIqQMebbqNO6x9BiRKdwKghY3PfMKdWbZu0bE=;
        b=cZfeKlqxYYhtiqC/pcd/VXc6opoDbk9MkNnAAjmzKxsrDR4XWjx8L39OtTViN2hLkA
         u1DMtGL13ct77LetPvcZ9wAfG1GCDZg6a3w6NmYqC/Tr+9jXXbPEY0KMji0wWfTB7sxd
         QUOgqXDr4RL3AeeqUMnCrM35QJDi+fO+l/0z9Ay4fapXHAs7RKkwnnXKFQTBGNs4tSgv
         MKQuR+RwiGVIraPdtZARPCEAZULot3Kh2AxAdTAnuUdG0sz+/h6d4ijZi7mMEXPWqbGQ
         bcVH6CVlESdMJ40HYJblbzPPF/jT8cy5RMniY7+ipYfoldZvRjpPLz45ZINolF+7VKTb
         8Frw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=iy+FgxPIqQMebbqNO6x9BiRKdwKghY3PfMKdWbZu0bE=;
        b=Qwp0DYtS/B6J4djfAJrWWB30+LaUGMeCwrf0yiboO0R0ZpaVtCwJMjDioyygAQOxZ5
         6dU1elHp96iAKCeqWkS/qo2fko+Kn2lJhEMS0cwKtXhDiTPwKNzk/5TcpzwIskqf2gBQ
         XR/J/9BCszaS1Z7flmTy16AJeloZBLaNJseN+aE6jWyPOa3AFZvqZiS6QAjcEgV3UHZL
         Ee9mtzqGVP5MobzRzb6MC2jfoBivjAZWT66yEtC2pIm5FQzrFNkz7hNAzZoGZZ8OaiRG
         KYtrQ626r+XOAqs1dhdfwjUjrKlpYd2CV9qXdFrERM7dOJeq2B328v2eukZ8f1Y8rtxD
         9JeQ==
X-Gm-Message-State: AOAM5327oGNWCIutXv2bYSaIeAXXB8Rxx1RiNNQauFegouk1WlKXt86P
        Wju6zr7mY81dCbLtbeDZblVDTN7ddC0mbnSKDQ==
X-Google-Smtp-Source: ABdhPJwPMEsWefYuus6LQ0248ZTE6kzd7riougai+4rMCYewuJ017Z/F0Quo8hJykpd8WhYiyS+0mecB5x6D0rPfnA==
X-Received: from kaleshsingh.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2145])
 (user=kaleshsingh job=sendgmr) by 2002:a05:6214:e83:: with SMTP id
 hf3mr18656634qvb.19.1627317713445; Mon, 26 Jul 2021 09:41:53 -0700 (PDT)
Date:   Mon, 26 Jul 2021 16:41:31 +0000
Message-Id: <20210726164135.1745059-1-kaleshsingh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH] tracing/gpu: Add gpu_mem_imported tracepoint
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     gregkh@linuxfoundation.org, surenb@google.com, hridya@google.com,
        john.reitan@arm.com, orjan.eide@arm.com, mark.underwood@arm.com,
        gary.sweet@broadcom.com, stephen.mansfield@imgtec.com,
        mbalci@quicinc.com, mkrom@qti.qualcomm.com,
        kernel-team@android.com, Kalesh Singh <kaleshsingh@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing gpu_mem_total tracepoint allows GPU drivers a unifrom way
to report the per-process and system-wide GPU memory usage. This
tracepoint reports a single total of the GPU private allocations and the
imported memory. [1]

To allow distinguishing GPU private vs imported memory, add
gpu_mem_imported tracepoint.

GPU drivers can use this tracepoint to report the per-process and global
GPU-imported memory in a uniform way.

For backward compatility with already existing implementations of
gpu_mem_total by various Android GPU drivers, this is proposed as a new
tracepoint rather than additional args to gpu_mem_total.

[1] https://lore.kernel.org/r/20200302234840.57188-1-zzyiwei@google.com/

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 include/trace/events/gpu_mem.h | 51 ++++++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 15 deletions(-)

diff --git a/include/trace/events/gpu_mem.h b/include/trace/events/gpu_mem.h
index 26d871f96e94..b9543abf1461 100644
--- a/include/trace/events/gpu_mem.h
+++ b/include/trace/events/gpu_mem.h
@@ -13,21 +13,7 @@
 
 #include <linux/tracepoint.h>
 
-/*
- * The gpu_memory_total event indicates that there's an update to either the
- * global or process total gpu memory counters.
- *
- * This event should be emitted whenever the kernel device driver allocates,
- * frees, imports, unimports memory in the GPU addressable space.
- *
- * @gpu_id: This is the gpu id.
- *
- * @pid: Put 0 for global total, while positive pid for process total.
- *
- * @size: Size of the allocation in bytes.
- *
- */
-TRACE_EVENT(gpu_mem_total,
+DECLARE_EVENT_CLASS(gpu_mem_template,
 
 	TP_PROTO(uint32_t gpu_id, uint32_t pid, uint64_t size),
 
@@ -51,6 +37,41 @@ TRACE_EVENT(gpu_mem_total,
 		__entry->size)
 );
 
+/*
+ * The gpu_memory_total event indicates that there's an update to either the
+ * global or process total gpu memory counters.
+ *
+ * This event should be emitted whenever the kernel device driver allocates,
+ * frees, imports, unimports memory in the GPU addressable space.
+ *
+ * @gpu_id: This is the gpu id.
+ *
+ * @pid: Put 0 for global total, while positive pid for process total.
+ *
+ * @size: Size of the allocation in bytes.
+ *
+ */
+DEFINE_EVENT(gpu_mem_template, gpu_mem_total,
+	TP_PROTO(uint32_t gpu_id, uint32_t pid, uint64_t size),
+	TP_ARGS(gpu_id, pid, size));
+
+/*
+ * The gpu_mem_imported event indicates that there's an update to the
+ * global or process imported gpu memory counters.
+ *
+ * This event should be emitted whenever the kernel device driver imports
+ * or unimports memory (allocated externally) in the GPU addressable space.
+ *
+ * @gpu_id: This is the gpu id.
+ *
+ * @pid: Put 0 for global total, while positive pid for process total.
+ *
+ * @size: Size of the imported memory in bytes.
+ */
+DEFINE_EVENT(gpu_mem_template, gpu_mem_imported,
+	TP_PROTO(uint32_t gpu_id, uint32_t pid, uint64_t size),
+	TP_ARGS(gpu_id, pid, size));
+
 #endif /* _TRACE_GPU_MEM_H */
 
 /* This part must be outside protection */

base-commit: ff1176468d368232b684f75e82563369208bc371
-- 
2.32.0.432.gabb21c7263-goog

