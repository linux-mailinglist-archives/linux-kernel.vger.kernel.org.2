Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9F8A388797
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 08:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236491AbhESGf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 02:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbhESGf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 02:35:27 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64AB1C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 23:34:08 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id gm21so6800043pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 23:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lGu0VVk51fONvP7iU9c3NW3ucSj/BYjyWQl2dyiDI9g=;
        b=DMx1/yIfUgN2/TlIOG9+lSXdRkgQa3VaViBNPsHVsbVnjFeMnU1bWtLlQLhoJnDDDT
         P7LHGyinFAq5s/jMF3bqKkammFQ6fd/FqHEFmwNNW3WYHGi9l4G8JamD9nGBdxYc+Ut6
         zY87TxRnDB672+/QVN913L572veYFwEiXGA0Sc1QfXuZr6HOtyHF36fdRG2P8L/4bWCG
         iPhIs/zoqgdHek4P+8JEnWL7H+ESGnl6sXBUZGx0VjimNN0gaROl1r/VbKCXlcDKOWfM
         qHx2foFP5Cq0DRwha5OUE+XSjQCzloEgGc5WX8ol3DdSKsJakeekZFSqJBKm3iWwv9EO
         SXWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lGu0VVk51fONvP7iU9c3NW3ucSj/BYjyWQl2dyiDI9g=;
        b=WITjiuhHpcUJYrItCZ4rsHt1zapOMT7CVInFqq68z2kDqeUmG/xdCp5ynWozbaU8gL
         LBgsgIrS8DQhnOXGjfhvCTsPySAVxV8nQ6+hfeJsAeSM/NS+B18a3D4pye1mEkyqMUEv
         o3eqM/Yc/rUpNsl3W8fxz+bDCjDhQrJQCgjqjdbJ+MGgVHUI5VBRivoFzbDsVD0cbXiE
         YjZwfA2o4WhThdzsdP0ToyjmI3ukyZ/skKUy2u/ggISbCD8MzG2ZPxcvhOhd7E3Tf7HZ
         /J7vxmqdV4OmJNwL9gmjoZsrZYAHFpQzDcT+D0qkCNplMllNyDSU+rotsw4IVNFjTizW
         S2pg==
X-Gm-Message-State: AOAM530SUFVpwb9LgMsCItzeQekxXIG2p3WTqccJJlzkqIUu4hyy3wog
        I8qqmXv6aAJ6a4WK3D/GNpE=
X-Google-Smtp-Source: ABdhPJzk810sFZW7FfTOrU/oYQ9ENf/tnBLDbQ61vjk0kWoYKM3WNo9ESLPr6n5TOBF/R5WdEm8PyQ==
X-Received: by 2002:a17:902:9685:b029:ef:70fd:a5a2 with SMTP id n5-20020a1709029685b02900ef70fda5a2mr9201212plp.20.1621406047994;
        Tue, 18 May 2021 23:34:07 -0700 (PDT)
Received: from Ruifeng.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id y1sm137053pfn.13.2021.05.18.23.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 23:34:07 -0700 (PDT)
From:   Ruifeng Zhang <ruifeng.zhang0110@gmail.com>
To:     pmladek@suse.com, senozhatsky@chromium.org, rostedt@goodmis.org,
        john.ogness@linutronix.de
Cc:     linux-kernel@vger.kernel.org, ruifeng.zhang1@unisoc.com,
        nianfu.bai@unisoc.com, orson.zhai@unisoc.com
Subject: [PATCH v1 1/1] printk: always output coreid in caller information
Date:   Wed, 19 May 2021 14:33:55 +0800
Message-Id: <20210519063355.5147-1-ruifeng.zhang0110@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ruifeng Zhang <ruifeng.zhang1@unisoc.com>

Sometimes we want to know which cpu the process is running
on when the log output, rather than the thread id.  So add
the processor id output always in the caller information.

caller_id bitmap:
[63:32] thread_id
[31]    flags of in thread context
[30:0]  processor id

About the output format, reserve 5 bits for thread id and
2 bits for processor id.

e.g.
Before:
[    0.000000][    T0] Booting Linux on physical CPU 0x0
[    0.109338][    T1] smp: Bringing up secondary CPUs ...
[    0.115831][    T0] CPU1: thread 0, cpu 1, socket 0, mpidr 81000100
[    0.117051][    T0] CPU2: thread 0, cpu 2, socket 0, mpidr 81000200
[    0.118207][    T0] CPU3: thread 0, cpu 3, socket 0, mpidr 81000300
[  114.112319][T25122] binder:

After:
[    0.000000][     T0:C0] Booting Linux on physical CPU 0x0
[    0.114549][     T1:C0] smp: Bringing up secondary CPUs ...
[    0.121377][     T0:C1] CPU1: thread 0, cpu 1, socket 0, mpidr 81000100
[    0.122606][     T0:C2] CPU2: thread 0, cpu 2, socket 0, mpidr 81000200
[    0.123758][     T0:C3] CPU3: thread 0, cpu 3, socket 0, mpidr 81000300
[   43.260158][        C1] Irq_monitor:Irq
[  112.862589][ T21442:C5] binder:

Signed-off-by: Ruifeng Zhang <ruifeng.zhang1@unisoc.com>
---
 kernel/printk/printk.c            | 36 +++++++++++++++++++++----------
 kernel/printk/printk_ringbuffer.h |  2 +-
 2 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 421c35571797..8ef4acefce19 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -331,7 +331,7 @@ static int console_msg_format = MSG_FORMAT_DEFAULT;
  *   record.info.facility           = 0 (LOG_KERN)
  *   record.info.flags              = 0
  *   record.info.level              = 3 (LOG_ERR)
- *   record.info.caller_id          = 299 (task 299)
+ *   record.info.caller_id          = 1286342705152 ([63:32]=299 [31]=1 [30:0]=0)
  *   record.info.dev_info.subsystem = "pci" (terminated)
  *   record.info.dev_info.device    = "+pci:0000:00:01.0" (terminated)
  *
@@ -559,10 +559,15 @@ static ssize_t info_print_ext_header(char *buf, size_t size,
 	u64 ts_usec = info->ts_nsec;
 	char caller[20];
 #ifdef CONFIG_PRINTK_CALLER
-	u32 id = info->caller_id;
+	u64 id = info->caller_id;
 
-	snprintf(caller, sizeof(caller), ",caller=%c%u",
-		 id & 0x80000000 ? 'C' : 'T', id & ~0x80000000);
+	if (id & 0x80000000)
+		snprintf(caller, sizeof(caller), ",caller=T%u:C%u",
+			 (u32)(id >> 32),
+			 (u32)(id & ~0x80000000));
+	else
+		snprintf(caller, sizeof(caller), ",caller=C%u",
+			 (u32)(id & ~0x80000000));
 #else
 	caller[0] = '\0';
 #endif
@@ -1273,9 +1278,15 @@ static size_t print_caller(u32 id, char *buf)
 {
 	char caller[12];
 
-	snprintf(caller, sizeof(caller), "%c%u",
-		 id & 0x80000000 ? 'C' : 'T', id & ~0x80000000);
-	return sprintf(buf, "[%6s]", caller);
+	if (id & 0x80000000)
+		snprintf(caller, sizeof(caller), "T%u:C%u",
+			 (u32)(id >> 32),
+			 (u32)(id & ~0x80000000));
+	else
+		snprintf(caller, sizeof(caller), "C%u",
+			 (u32)(id & ~0x80000000));
+
+	return sprintf(buf, "[%10s]", caller);
 }
 #else
 #define print_caller(id, buf) 0
@@ -1954,10 +1965,13 @@ static inline void printk_delay(void)
 	}
 }
 
-static inline u32 printk_caller_id(void)
+static inline u64 printk_caller_id(void)
 {
-	return in_task() ? task_pid_nr(current) :
-		0x80000000 + raw_smp_processor_id();
+	if (in_task())
+		return (u64)task_pid_nr(current) << 32 |
+			0x80000000 + raw_smp_processor_id();
+	else
+		return raw_smp_processor_id();
 }
 
 /**
@@ -2036,7 +2050,7 @@ int vprintk_store(int facility, int level,
 		  const struct dev_printk_info *dev_info,
 		  const char *fmt, va_list args)
 {
-	const u32 caller_id = printk_caller_id();
+	const u64 caller_id = printk_caller_id();
 	struct prb_reserved_entry e;
 	enum log_flags lflags = 0;
 	struct printk_record r;
diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
index 73cc80e01cef..c0a3146c7ac2 100644
--- a/kernel/printk/printk_ringbuffer.h
+++ b/kernel/printk/printk_ringbuffer.h
@@ -19,7 +19,7 @@ struct printk_info {
 	u8	facility;	/* syslog facility */
 	u8	flags:5;	/* internal record flags */
 	u8	level:3;	/* syslog level */
-	u32	caller_id;	/* thread id or processor id */
+	u64	caller_id;      /* thread id or processor id */
 
 	struct dev_printk_info	dev_info;
 };
-- 
2.17.1

