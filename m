Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6536F3FCBFF
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 19:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240163AbhHaRDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 13:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232509AbhHaRDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 13:03:54 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A94C061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 10:02:59 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id k12-20020a05620a0b8c00b003d5c8646ec2so2953377qkh.20
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 10:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:cc;
        bh=g8lY3yuhge4SRook/yGWV7kL5YSEDsu9mSGrR5Y9scA=;
        b=kt6ekm9T+vWkJ8q0edC27hme2qMrVnaFZLAbhawe6zbXaUsECF/QCwz/8bw0gYjMbJ
         MRfRbbw+/eyf9sm9HJTxivTkeEC/wKeYceKTApzMJB9Ipa6RSF+ftxg8ZjsrvhIqc9Uu
         /yUzLTwr3u0n/Cv59LKIfw5VmeZV+sPt/uP9dt+kvWwY973s7+R64dXLxsDLNoUUmJsH
         2qsUQPeYUa/EyfYPlsBWxevqylze6ebN3LrlnHDzun9k2uqxxFh1F/8cFMlhJkBbnqUX
         e3arpB0XRXauZ5IOBKn5zWJmRYG2XJTTK0iuiR7u59miy5/C7pxw9cRJHW490PMRdax+
         gbUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=g8lY3yuhge4SRook/yGWV7kL5YSEDsu9mSGrR5Y9scA=;
        b=gMZONAjzpSVUoiRCPE3x32HdNgmuOFiIE0fnKwFtf3mElsL40rZ26UB/NJ8i/9j9Co
         OEH36MXQ/DwwEHMyWrJXlZyezcK0srXYBL3X4Z5I7TGJUN56BqqzxPKs6LVr/pnjB5oM
         gAnc2N40AarTEihl7Gfj1p2kB2a97DsxWIbetvioWLT9jpFKNn6XJU+4+L1f+DluKVqZ
         zatsyfGYSjJahi6CmmfiyMZwjDQlbK23odIRmRgaPGDbFD9YkzuMBXsbDcPPPEOBuDHc
         C5FzXQRNcW/Du9iB3mRhEyiLa60V2NQGbuumFPUCEixWDM2c0JwbkFpLhkJbJ4mT3bCm
         4kYw==
X-Gm-Message-State: AOAM531DR52B5Hi4cTiyCsDjtLSdaGlD4eDpNscfdeEvQl+neonycu1y
        hD+ZEptGhbSt/j3TAc/B4d4JTSBiiEydcWEL9Q==
X-Google-Smtp-Source: ABdhPJwCf3Cu7g4PmQSnZJgkn4wuD7Lo+AaxU2pZ6uElWFd42D/y42xyxtqfRfSENfX+fiBJOXU+pO9LUuntCuFf4w==
X-Received: from kaleshsingh.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2145])
 (user=kaleshsingh job=sendgmr) by 2002:a0c:ac4a:: with SMTP id
 m10mr29926257qvb.37.1630429378671; Tue, 31 Aug 2021 10:02:58 -0700 (PDT)
Date:   Tue, 31 Aug 2021 17:02:29 +0000
Message-Id: <20210831170233.1409537-1-kaleshsingh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
Subject: [RESEND v2] tracing/gpu: Add imported size to gpu_mem_imported tracepoint
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     surenb@google.com, hridya@google.com, gregkh@linuxfoundation.org,
        john.reitan@arm.com, orjan.eide@arm.com, mark.underwood@arm.com,
        gary.sweet@broadcom.com, stephen.mansfield@imgtec.com,
        kernel-team@android.com, Kalesh Singh <kaleshsingh@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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
 include/trace/events/gpu_mem.h | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/include/trace/events/gpu_mem.h b/include/trace/events/gpu_mem.h
index 26d871f96e94..ae6fab6bab7b 100644
--- a/include/trace/events/gpu_mem.h
+++ b/include/trace/events/gpu_mem.h
@@ -15,7 +15,7 @@
 
 /*
  * The gpu_memory_total event indicates that there's an update to either the
- * global or process total gpu memory counters.
+ * global or process total and imported gpu memory counters.
  *
  * This event should be emitted whenever the kernel device driver allocates,
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
 
-	TP_PROTO(uint32_t gpu_id, uint32_t pid, uint64_t size),
+	TP_PROTO(uint32_t gpu_id, uint32_t pid, uint64_t size, uint64_t imported_size),
 
-	TP_ARGS(gpu_id, pid, size),
+	TP_ARGS(gpu_id, pid, size, imported_size),
 
 	TP_STRUCT__entry(
 		__field(uint32_t, gpu_id)
 		__field(uint32_t, pid)
 		__field(uint64_t, size)
+		__field(uint64_t, imported_size)
 	),
 
 	TP_fast_assign(
 		__entry->gpu_id = gpu_id;
 		__entry->pid = pid;
 		__entry->size = size;
+		__entry->imported_size = imported_size;
 	),
 
-	TP_printk("gpu_id=%u pid=%u size=%llu",
+	TP_printk("gpu_id=%u pid=%u size=%llu imported_size=%llu",
 		__entry->gpu_id,
 		__entry->pid,
-		__entry->size)
+		__entry->size,
+		__entry->imported_size)
 );
 
 #endif /* _TRACE_GPU_MEM_H */

base-commit: 9c849ce86e0fa93a218614eac562ace44053d7ce
-- 
2.33.0.259.gc128427fd7-goog

