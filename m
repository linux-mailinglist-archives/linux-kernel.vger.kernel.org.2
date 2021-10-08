Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEE2426671
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 11:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237411AbhJHJQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 05:16:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38811 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236658AbhJHJQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 05:16:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633684467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aMLlR2SzoNjOmv5PwyT5gjKRoe76WYTK4npUjuAglpY=;
        b=DruIj8GO1QHQgEY4+gJywUw62sMNEM051XZ/KNcus5kVv9qdvYJ8WTdLAwaj6OuTS/NdBP
        uvkxhFKSp3fSOF4QpSFzgP4LQ+BusZq+m4HxvQhd3zcMjFxEwREOZhbbwuQcf7KD4uN2x0
        vSpnbuihWGPZQ91QetQEkLE66nEieqw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-YM4u4bM3OyOG2G1lHEKmFw-1; Fri, 08 Oct 2021 05:14:26 -0400
X-MC-Unique: YM4u4bM3OyOG2G1lHEKmFw-1
Received: by mail-wr1-f71.google.com with SMTP id e12-20020a056000178c00b001606927de88so6787147wrg.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 02:14:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aMLlR2SzoNjOmv5PwyT5gjKRoe76WYTK4npUjuAglpY=;
        b=2y/HpPve22oMMI1OnzjetMa06KN4M3NBto7I2LTe3BEchdgt2da9qcaDAT/TCHyqjL
         j8DWSZDtSmQXwQi04sSl5P7ZnrKqkoOeTdAGQ3FDbZDUvpZaYpTpRHlwzwj0cQqcWvAG
         OCCtID/BpuarXYRfbi7mXSUG4132S+hgnWfEuCoQhGZ8GEnxSIz/AnN/nXl7HgDWXN2W
         DFv4pbu4QGTRwTiUXiK8ALOxpd2EOp4p9222tP+0PISjK2jM3iUQ07zJze8hUL6GgkTb
         99n8wGP05vhwXJ9wZi+Rg9zSXA1RmAbTwmK73kBQzWyhfLFMcg3ZGkvIv/5ToSkk4AEm
         fpYg==
X-Gm-Message-State: AOAM531biIJCVpfbsgfyOHfJIo+zWEVfJ/kGEp1/q9r+z/i8+9HMHUfJ
        DiZkpngD6RwVPCsE34FEdaDEy6iqn+MJwGHfGC0y7WkJ/Hv0o/lVzBJzpR78KAodWNWR5B6xw+7
        pNWH1rVfD7qd4E2TyTidGCA8B
X-Received: by 2002:a1c:f705:: with SMTP id v5mr2170521wmh.18.1633684465596;
        Fri, 08 Oct 2021 02:14:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz6GIVVwRsyGduGMdmAo2Z9uL4etWtj7XIEnA3tDdBWwJS4LKVXzwWWpvrqQgMbPnFVV8FHtA==
X-Received: by 2002:a1c:f705:: with SMTP id v5mr2170500wmh.18.1633684465393;
        Fri, 08 Oct 2021 02:14:25 -0700 (PDT)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id z8sm608721wrq.16.2021.10.08.02.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 02:14:25 -0700 (PDT)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH 8/8] ftrace/samples: Add multi direct interface test module
Date:   Fri,  8 Oct 2021 11:13:36 +0200
Message-Id: <20211008091336.33616-9-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211008091336.33616-1-jolsa@kernel.org>
References: <20211008091336.33616-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding simple module that uses multi direct interface:

  register_ftrace_direct_multi
  unregister_ftrace_direct_multi

The init function registers trampoline for 2 functions,
and exit function unregisters them.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 samples/ftrace/Makefile              |  1 +
 samples/ftrace/ftrace-direct-multi.c | 52 ++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)
 create mode 100644 samples/ftrace/ftrace-direct-multi.c

diff --git a/samples/ftrace/Makefile b/samples/ftrace/Makefile
index 4ce896e10b2e..ab1d1c05c288 100644
--- a/samples/ftrace/Makefile
+++ b/samples/ftrace/Makefile
@@ -3,6 +3,7 @@
 obj-$(CONFIG_SAMPLE_FTRACE_DIRECT) += ftrace-direct.o
 obj-$(CONFIG_SAMPLE_FTRACE_DIRECT) += ftrace-direct-too.o
 obj-$(CONFIG_SAMPLE_FTRACE_DIRECT) += ftrace-direct-modify.o
+obj-$(CONFIG_SAMPLE_FTRACE_DIRECT) += ftrace-direct-multi.o
 
 CFLAGS_sample-trace-array.o := -I$(src)
 obj-$(CONFIG_SAMPLE_TRACE_ARRAY) += sample-trace-array.o
diff --git a/samples/ftrace/ftrace-direct-multi.c b/samples/ftrace/ftrace-direct-multi.c
new file mode 100644
index 000000000000..2a5b1fb7ac14
--- /dev/null
+++ b/samples/ftrace/ftrace-direct-multi.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/module.h>
+
+#include <linux/mm.h> /* for handle_mm_fault() */
+#include <linux/ftrace.h>
+#include <linux/sched/stat.h>
+
+void my_direct_func(unsigned long ip)
+{
+	trace_printk("ip %lx\n", ip);
+}
+
+extern void my_tramp(void *);
+
+asm (
+"	.pushsection    .text, \"ax\", @progbits\n"
+"	.type		my_tramp, @function\n"
+"	.globl		my_tramp\n"
+"   my_tramp:"
+"	pushq %rbp\n"
+"	movq %rsp, %rbp\n"
+"	pushq %rdi\n"
+"	movq 8(%rbp), %rdi\n"
+"	call my_direct_func\n"
+"	popq %rdi\n"
+"	leave\n"
+"	ret\n"
+"	.size		my_tramp, .-my_tramp\n"
+"	.popsection\n"
+);
+
+static struct ftrace_ops direct;
+
+static int __init ftrace_direct_multi_init(void)
+{
+	ftrace_set_filter_ip(&direct, (unsigned long) wake_up_process, 0, 0);
+	ftrace_set_filter_ip(&direct, (unsigned long) schedule, 0, 0);
+
+	return register_ftrace_direct_multi(&direct, (unsigned long) my_tramp);
+}
+
+static void __exit ftrace_direct_multi_exit(void)
+{
+	unregister_ftrace_direct_multi(&direct, (unsigned long) my_tramp);
+}
+
+module_init(ftrace_direct_multi_init);
+module_exit(ftrace_direct_multi_exit);
+
+MODULE_AUTHOR("Jiri Olsa");
+MODULE_DESCRIPTION("Example use case of using register_ftrace_direct_multi()");
+MODULE_LICENSE("GPL");
-- 
2.31.1

