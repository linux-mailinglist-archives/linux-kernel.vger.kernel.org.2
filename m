Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 620853EF24A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 20:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbhHQSzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 14:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbhHQSzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 14:55:46 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F08EC061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 11:55:13 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id e75-20020a25374e000000b00597165a06d2so112799yba.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 11:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:cc
         :content-transfer-encoding;
        bh=8ZZ9t8Kv7ESy90Lud9XEzupxDq2fgECGEzS6jKjUj5k=;
        b=c2Ufw8WAP/YxQA/ekgr2+8jQKHg+8ky3N7jSimDLYk9MCGQxLLbdKYgMEq4+qj9e/9
         RylFiPLGgmQeBsd97ThahZqoOMeZ2b5wvPjVXo/0SrWwxvGvX5oKauj515a5a5eV/DRP
         hyUaCIZOlQG7gF7x1vZ5S2QlWvrM6sO04WuWg8QGiVOxmQJDsXmUPbQJuaAuov4Sbvgk
         aqqRzbKnFUJujxRhaL6LSkUitJSfaUdXozEptAJAzZ6afeMKKk0JWfJgns8650ssOlyQ
         Hs97vN1gCnVs8UDZ3UQKMK+1IarijR+7KW3nC8+hDPvXUwh4+0ta8oUHRxBevYxw49ya
         lVEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc
         :content-transfer-encoding;
        bh=8ZZ9t8Kv7ESy90Lud9XEzupxDq2fgECGEzS6jKjUj5k=;
        b=gXGKFg/HMgRC2Swa7kTeRKN5G9t4HAHt8aTgoTYORAA3pxsj0tEV9RvXJfzkxrH9Ru
         pNCnulT30MWFaZfikjw4je7rRvX9y4qaXUyXDXPpYX/2i1lgNXx/sEYJIou8Rm/yn3Ds
         1GaXYXZFcuQH8CZC1gGxJ5i/cDgO8Yg86JXbhdIvXn11sRfwgkhN6OnvfNAcPLwv8bok
         5buIG6DZp5AUOkA0iTKIpQEath8vQEG6TifzPKU+G/gelnY2fOu7D80KE1j8Rz1Y8TO7
         DeqyVfjWxz+lzt175CcuqG35trMFH5X3kybe2VoXkcE4zEzFYYBzeM/bdF4i/aZrncRK
         wMVw==
X-Gm-Message-State: AOAM531WRCij4jFoske6lZyklUKUc+34uFQZTOQoR16eKXCJhyz7OG1r
        qtdaILfTLx5S90lVLn3HDykotSrSUaDfKacoqA==
X-Google-Smtp-Source: ABdhPJxv+WkdSBy7ZJWA9+on0b4x0lVVcOvv1IQhTvN1Yf271uFVhIfXXRZS4cC6ittgvs3x6izRzHqgbLVMa2TLBQ==
X-Received: from kaleshsingh.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2145])
 (user=kaleshsingh job=sendgmr) by 2002:a25:8489:: with SMTP id
 v9mr6291240ybk.477.1629226512401; Tue, 17 Aug 2021 11:55:12 -0700 (PDT)
Date:   Tue, 17 Aug 2021 18:52:52 +0000
Message-Id: <20210817185256.3787878-1-kaleshsingh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH v2] tracing/gpu: Add imported size to gpu_mem_imported tracepoint
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     surenb@google.com, hridya@google.com, gregkh@linuxfoundation.org,
        john.reitan@arm.com, orjan.eide@arm.com, mark.underwood@arm.com,
        gary.sweet@broadcom.com, stephen.mansfield@imgtec.com,
        kernel-team@android.com, Kalesh Singh <kaleshsingh@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing gpu_mem_total tracepoint provides GPU drivers a uniform way
to report the per-process and system-wide GPU memory usage. This
tracepoint reports a single total of the GPU private allocations and the
imported memory. [1]

To allow distinguishing GPU private vs imported memory, add an
imported_size field to the gpu_mem_total tracepoint. GPU drivers can use
this new field to report the per-process and global GPU-imported memory
in a uniform way.

User space tools can detect and handle the old vs new gpu_mem_total
format via the gpu_mem/gpu_mem_total/format file.

[1] https://lore.kernel.org/r/20200302234840.57188-1-zzyiwei@google.com/

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
Changes in v2:
  - Add imported_size field to track imported memory instead of a
    separate tracepoint, per =C3=98rjan

v1 of this patch can be found at:
https://lore.kernel.org/r/20210726164135.1745059-1-kaleshsingh@google.com/

 include/trace/events/gpu_mem.h | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/include/trace/events/gpu_mem.h b/include/trace/events/gpu_mem.=
h
index 26d871f96e94..ae6fab6bab7b 100644
--- a/include/trace/events/gpu_mem.h
+++ b/include/trace/events/gpu_mem.h
@@ -15,7 +15,7 @@
=20
 /*
  * The gpu_memory_total event indicates that there's an update to either t=
he
- * global or process total gpu memory counters.
+ * global or process total and imported gpu memory counters.
  *
  * This event should be emitted whenever the kernel device driver allocate=
s,
  * frees, imports, unimports memory in the GPU addressable space.
@@ -24,31 +24,36 @@
  *
  * @pid: Put 0 for global total, while positive pid for process total.
  *
- * @size: Size of the allocation in bytes.
+ * @size: Total size of allocated and imported memory in bytes.
+ *
+ * @imported_size: Total size of imported memory in bytes.
  *
  */
 TRACE_EVENT(gpu_mem_total,
=20
-	TP_PROTO(uint32_t gpu_id, uint32_t pid, uint64_t size),
+	TP_PROTO(uint32_t gpu_id, uint32_t pid, uint64_t size, uint64_t imported_=
size),
=20
-	TP_ARGS(gpu_id, pid, size),
+	TP_ARGS(gpu_id, pid, size, imported_size),
=20
 	TP_STRUCT__entry(
 		__field(uint32_t, gpu_id)
 		__field(uint32_t, pid)
 		__field(uint64_t, size)
+		__field(uint64_t, imported_size)
 	),
=20
 	TP_fast_assign(
 		__entry->gpu_id =3D gpu_id;
 		__entry->pid =3D pid;
 		__entry->size =3D size;
+		__entry->imported_size =3D imported_size;
 	),
=20
-	TP_printk("gpu_id=3D%u pid=3D%u size=3D%llu",
+	TP_printk("gpu_id=3D%u pid=3D%u size=3D%llu imported_size=3D%llu",
 		__entry->gpu_id,
 		__entry->pid,
-		__entry->size)
+		__entry->size,
+		__entry->imported_size)
 );
=20
 #endif /* _TRACE_GPU_MEM_H */

base-commit: a2824f19e6065a0d3735acd9fe7155b104e7edf5
--=20
2.33.0.rc1.237.g0d66db33f3-goog

