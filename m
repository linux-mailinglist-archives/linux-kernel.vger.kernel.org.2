Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 715843FC530
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 11:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240772AbhHaJw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 05:52:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33014 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240774AbhHaJwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 05:52:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630403471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AjVYZzchk8zj3iEUBSEoZP/smDG6NngufYLxpwikn0s=;
        b=FsXqkUy4GF5t6ns15KQ/03UOJpQ4brRcs44Fjr2W0kZZ9hZLIu9ia7N7JLnWIV3MBxQvvD
        U+wSXZOKNjptrCVgMZHlbONfR73Nq9qPYRfSssPzesGxougerkubFp/AvDhNR7UP1908qk
        46RWnfjWXPz1yizPdfaa6G0TI7/cnts=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-6ZFvuvtOMpu9spGD48jKkw-1; Tue, 31 Aug 2021 05:51:10 -0400
X-MC-Unique: 6ZFvuvtOMpu9spGD48jKkw-1
Received: by mail-wr1-f72.google.com with SMTP id z15-20020adff74f000000b001577d70c98dso3876286wrp.12
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 02:51:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AjVYZzchk8zj3iEUBSEoZP/smDG6NngufYLxpwikn0s=;
        b=I2n0vqvYxcOMiLpiD+9xdPm3EXjMWJV92x9YwTSrh6NBb3rrJM7ul70ZtriIEpWX8D
         8Q44MoMSd6dr+1lLY1V1puWqUfIhFY6UVfm07CXoK+JyzALGIskSG7fsK495wchN17rh
         E/M8hEiNQGdByR1WUfjtyIZZ3OdSXxchh7AYYM7uiBk0fw9QlofTLPEmWrurxKXlg7UU
         mOjSwjoCbnK80j5OwCkBUjLLJWMvdVW5wTDfEaYH1TmN2vsor8Z1qcVbFcKoCaFKG4JW
         Ad7FCUPFJAMivQtM4WHTKPieRmZsXxfGFEy5JLlQXVWYXDD+TK0Yug+CoQw7t979K4H4
         J1ug==
X-Gm-Message-State: AOAM532hnSAwVN3JY34PsYVqEb1iROf9RSgVZolT0h054zh4+trztwIf
        7+ARK0zWqIlEn6ctE+9kCwP+oHDGXmJd/U94m9h02viMx2A5NNh/b1qIffyF/KU8iMYUcDtAdDP
        YL9y6HxVfl+y2I4In5egokYpH
X-Received: by 2002:a1c:a9d2:: with SMTP id s201mr3166758wme.81.1630403469371;
        Tue, 31 Aug 2021 02:51:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxBBv+cAWt3n9YpUfaV64/t01+7Vy21+B6e6ffqZqyyGakQW3qOFiYCrsmEDUZPUlRX8Ea5mQ==
X-Received: by 2002:a1c:a9d2:: with SMTP id s201mr3166747wme.81.1630403469216;
        Tue, 31 Aug 2021 02:51:09 -0700 (PDT)
Received: from krava.redhat.com ([94.113.247.3])
        by smtp.gmail.com with ESMTPSA id j17sm17638724wrh.67.2021.08.31.02.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 02:51:09 -0700 (PDT)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH 8/8] ftrace/samples: Add multi direct interface test module
Date:   Tue, 31 Aug 2021 11:50:17 +0200
Message-Id: <20210831095017.412311-9-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210831095017.412311-1-jolsa@kernel.org>
References: <20210831095017.412311-1-jolsa@kernel.org>
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
index 000000000000..76b34d46d11c
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
+	unregister_ftrace_direct_multi(&direct);
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

