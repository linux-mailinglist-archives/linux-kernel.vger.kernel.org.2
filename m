Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A11F3FCC8A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 19:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240497AbhHaRvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 13:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240501AbhHaRvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 13:51:37 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4819DC061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 10:50:42 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id t1so17545060pgv.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 10:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qdb32U8Gd8SJ4dGxwfbTzoAZGekY2T3buKbiAPh7r3Q=;
        b=q9r1CnGTeTXpwiRSsk1EL+Z+s8oF1K1iT7EX+pUbhnaLjk+/lRL7ugk6Vhc3EvclTJ
         qmtiDfqNhoLU8rfRBXQHSKwWpuebcwKETCWC1cO+/tXVyfMKTBPwQD7jKAugXDzUNQt/
         3ssI3e9I/JK3+bAIuO2ZtRpQDOoeEphoqNPjNwVzStPHVkXmFu+Svivc4BQvoV19KkF7
         YyKWU6l8OwXE1YUj3x20ArHtD4ktliMx3qmNt3xyfmawFZnb1Wj4wbFEIzON+YRzBIHJ
         U0yslS7jRQLDb8QvIot5RZUFardlSuLnjB2VBJKs7R5M8R+K14iq/Iks8YXgW17YWAtt
         McUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qdb32U8Gd8SJ4dGxwfbTzoAZGekY2T3buKbiAPh7r3Q=;
        b=AIKPNTfmNxIVP30w6z7BrxqKDG7Pq/iP1CDgGpubwfkODtyeyig/XNdmsOFA9rn05g
         cOQR5K6fjqXEgukYw2AVOjLEaF3YekHFz+7ehGMjMAGRP07nBl9HTkC4CBHgDjtq3qco
         w9JXEauXLGwajZ/vXh1ImeidyIb0CwZ529zKUnAp/D3V98VCNfhOnUxGxqTjgwjS+6gF
         vvDLmpPyzTciCmovSE9u0pYmNJh8j1X8lGB8ODRigsc2zEadXiBEgIwW6WdNHMoz0k7W
         ZCe3oAn7/Ei7EL5FHFglM73srWAsqjsOJBWbIKsa323m+LKLx4eh7ToWz67UkqRrIWUW
         KmGw==
X-Gm-Message-State: AOAM5324mhJL+JNRptUjbzfihrgWFfLpa8eSMNxeK1qE29GuXHoiNv/Y
        cRB0hjOz0BX/Oolr/5r25cviBqxlsz8=
X-Google-Smtp-Source: ABdhPJz9vzAwI4J2n22HmVniAYLD4kbD58fYXUg27Q2OskmSzJLdbBxxtp3suK5cwRUUUBbdA+OudA==
X-Received: by 2002:a63:4206:: with SMTP id p6mr27375563pga.449.1630432240408;
        Tue, 31 Aug 2021 10:50:40 -0700 (PDT)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id e16sm15863834pfc.214.2021.08.31.10.50.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Aug 2021 10:50:39 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Joerg Roedel <jroedel@suse.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Chester Lin <clin@suse.com>, Juergen Gross <jgross@suse.com>
Subject: [PATCH 02/24] x86/traps: Move arch/x86/kernel/traps.c to arch/x86/entry/
Date:   Wed,  1 Sep 2021 01:50:03 +0800
Message-Id: <20210831175025.27570-3-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210831175025.27570-1-jiangshanlai@gmail.com>
References: <20210831175025.27570-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

traps.c handles works for entries.  It is very close to the code in
arch/x86/entry/.  So we move traps.c to arch/x86/entry/.

It is also prepared for later patches that implements C version of
the entry code in traps.c.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/Makefile            | 5 ++++-
 arch/x86/{kernel => entry}/traps.c | 0
 arch/x86/kernel/Makefile           | 5 +----
 3 files changed, 5 insertions(+), 5 deletions(-)
 rename arch/x86/{kernel => entry}/traps.c (100%)

diff --git a/arch/x86/entry/Makefile b/arch/x86/entry/Makefile
index 7fec5dcf6438..4e26248cea33 100644
--- a/arch/x86/entry/Makefile
+++ b/arch/x86/entry/Makefile
@@ -11,8 +11,11 @@ CFLAGS_REMOVE_common.o		= $(CC_FLAGS_FTRACE)
 
 CFLAGS_common.o			+= -fno-stack-protector
 
+CFLAGS_REMOVE_traps.o		= -fstack-protector -fstack-protector-strong
+CFLAGS_traps.o			+= -fno-stack-protector
+
 obj-y				:= entry_$(BITS).o thunk_$(BITS).o syscall_$(BITS).o
-obj-y				+= common.o
+obj-y				+= common.o traps.o
 
 obj-y				+= vdso/
 obj-y				+= vsyscall/
diff --git a/arch/x86/kernel/traps.c b/arch/x86/entry/traps.c
similarity index 100%
rename from arch/x86/kernel/traps.c
rename to arch/x86/entry/traps.c
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 21aa164cece2..5ba80522f5da 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -48,14 +48,11 @@ KCOV_INSTRUMENT		:= n
 
 CFLAGS_head$(BITS).o	+= -fno-stack-protector
 
-CFLAGS_REMOVE_traps.o		= -fstack-protector -fstack-protector-strong
-CFLAGS_traps.o			+= -fno-stack-protector
-
 CFLAGS_irq.o := -I $(srctree)/$(src)/../include/asm/trace
 
 obj-y			:= process_$(BITS).o signal.o
 obj-$(CONFIG_COMPAT)	+= signal_compat.o
-obj-y			+= traps.o idt.o irq.o irq_$(BITS).o dumpstack_$(BITS).o
+obj-y			+= idt.o irq.o irq_$(BITS).o dumpstack_$(BITS).o
 obj-y			+= time.o ioport.o dumpstack.o nmi.o
 obj-$(CONFIG_MODIFY_LDT_SYSCALL)	+= ldt.o
 obj-y			+= setup.o x86_init.o i8259.o irqinit.o
-- 
2.19.1.6.gb485710b

