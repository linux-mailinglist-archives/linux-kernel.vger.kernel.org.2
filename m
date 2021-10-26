Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEDB443A9F3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 03:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233838AbhJZByX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 21:54:23 -0400
Received: from mail.loongson.cn ([114.242.206.163]:43198 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232670AbhJZByO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 21:54:14 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxj2okX3dh6gIgAA--.33960S6;
        Tue, 26 Oct 2021 09:51:39 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, mhiramat@kernel.org, rostedt@goodmis.org,
        mingo@redhat.com, corbet@lwn.net
Cc:     akpm@linux-foundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] MAINTAINERS: Update KPROBES and TRACING entries
Date:   Tue, 26 Oct 2021 09:51:31 +0800
Message-Id: <1635213091-24387-5-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1635213091-24387-1-git-send-email-yangtiezhu@loongson.cn>
References: <1635213091-24387-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9Dxj2okX3dh6gIgAA--.33960S6
X-Coremail-Antispam: 1UD129KBjvJXoW7WF1xCFyDCFy3XF4fZr1UJrb_yoW8Gw17pF
        4kGrn3Zr4rJr1rJw4qg3WSka4xZwn5ArsxuFn7K3sYyF1qvr1jqrs29rsFvFs2vrZ0qrWa
        yr1xZryj9ayxZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPCb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
        8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28C
        jxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI
        8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vE
        x4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFc
        xC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_
        Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2
        IY04v7MxkIecxEwVAFwVWkMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4U
        MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67
        AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z2
        80aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI
        43ZEXa7IU8g6pDUUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no git tree for KPROBES in MAINTAINERS, it is not convinent to
rebase, lib/test_kprobes.c and samples/kprobes belong to kprobe, so add
git tree and missing files for KPROBES, and also use linux-trace.git for
TRACING to avoid confusing.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 MAINTAINERS | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5b33791..8d26693 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10437,10 +10437,13 @@ M:	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
 M:	"David S. Miller" <davem@davemloft.net>
 M:	Masami Hiramatsu <mhiramat@kernel.org>
 S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
 F:	Documentation/trace/kprobes.rst
 F:	include/asm-generic/kprobes.h
 F:	include/linux/kprobes.h
 F:	kernel/kprobes.c
+F:	lib/test_kprobes.c
+F:	samples/kprobes
 
 KS0108 LCD CONTROLLER DRIVER
 M:	Miguel Ojeda <ojeda@kernel.org>
@@ -18967,7 +18970,7 @@ TRACING
 M:	Steven Rostedt <rostedt@goodmis.org>
 M:	Ingo Molnar <mingo@redhat.com>
 S:	Maintained
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
 F:	Documentation/trace/ftrace.rst
 F:	arch/*/*/*/ftrace.h
 F:	arch/*/kernel/ftrace.c
-- 
2.1.0

