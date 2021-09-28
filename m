Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F08F741A715
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 07:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235142AbhI1F2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 01:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234177AbhI1F2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 01:28:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5648DC061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 22:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=VXTkG7WyK4HR97q5t2vIGpNmzXcP/ZNrx7eCf+fwBxk=; b=e669XIraTMlfSlv8haaYoypkdZ
        oGdufPrzZ1dColPzYgJeSktEFT25CTugLGGzJSBLYFvMIBCeVn5KDcwW1GBVR1Ap+weXGZZdbw0LE
        nViSfq8oV7zkYrz3fv78yatrbwuXikYyb1QkaIUiarr8UVNeqHyLlVXHumlIErYoyTVvuibEBxHSd
        lbayKxUhn21lghXaTGeK1gUhmwGu78B7eaJVnxDAY/ChxhpgNnVNCyFclYAoRDQx7FHxovxCw/CX5
        qKXRJcB71FUBwg3qHUp8Oj48XzJZsJfoUFhV6Z36KUOvMXduxCVHoKtI95jhOHCFCq2QfX3c5h8Bj
        mcfOYABQ==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mV5dr-005dZD-79; Tue, 28 Sep 2021 05:26:59 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>
Subject: [PATCH] NDS32: export __trace_hardirqs_on/_offf for entry/exit
Date:   Mon, 27 Sep 2021 22:26:57 -0700
Message-Id: <20210928052657.20909-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add exports for __trace_hardirqs_on/_off and use them in
kernel/ex-entry.S and kernel/ex-exit.S to fix build/linker errors.

nds32le-linux-ld: arch/nds32/kernel/ex-entry.o: in function `fucop_ctl_done':
(.text+0x12a): undefined reference to `__trace_hardirqs_off'
(.text+0x12a): relocation truncated to fit: R_NDS32_25_PCREL_RELA against undefined symbol `__trace_hardirqs_off'
nds32le-linux-ld: arch/nds32/kernel/ex-exit.o: in function `no_work_pending':
(.text+0xea): undefined reference to `__trace_hardirqs_off'
nds32le-linux-ld: (.text+0xee): undefined reference to `__trace_hardirqs_off'
nds32le-linux-ld: (.text+0xf2): undefined reference to `__trace_hardirqs_on'
nds32le-linux-ld: (.text+0xf6): undefined reference to `__trace_hardirqs_on'

Fixes: 0cde56e0280d ("nds32: Fix a kernel panic issue because of wrong frame pointer access.")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Nick Hu <nickhu@andestech.com>
Cc: Greentime Hu <green.hu@gmail.com>
Cc: Vincent Chen <deanbo422@gmail.com>
---
 arch/nds32/include/asm/ftrace.h |    3 +++
 arch/nds32/kernel/ex-entry.S    |    1 +
 arch/nds32/kernel/ex-exit.S     |    2 +-
 arch/nds32/kernel/ftrace.c      |    3 +++
 4 files changed, 8 insertions(+), 1 deletion(-)

--- linux-next-20210917.orig/arch/nds32/kernel/ftrace.c
+++ linux-next-20210917/arch/nds32/kernel/ftrace.c
@@ -276,8 +276,11 @@ noinline void __trace_hardirqs_off(void)
 {
 	trace_hardirqs_off();
 }
+EXPORT_SYMBOL(__trace_hardirqs_off);
+
 noinline void __trace_hardirqs_on(void)
 {
 	trace_hardirqs_on();
 }
+EXPORT_SYMBOL(__trace_hardirqs_on);
 #endif /* CONFIG_TRACE_IRQFLAGS */
--- linux-next-20210917.orig/arch/nds32/include/asm/ftrace.h
+++ linux-next-20210917/arch/nds32/include/asm/ftrace.h
@@ -15,6 +15,9 @@
 
 extern void _mcount(unsigned long parent_ip);
 
+extern void __trace_hardirqs_off(void);
+extern void __trace_hardirqs_on(void);
+
 #ifdef CONFIG_DYNAMIC_FTRACE
 
 #define FTRACE_ADDR ((unsigned long)_ftrace_caller)
--- linux-next-20210917.orig/arch/nds32/kernel/ex-entry.S
+++ linux-next-20210917/arch/nds32/kernel/ex-entry.S
@@ -8,6 +8,7 @@
 #include <asm/asm-offsets.h>
 #include <asm/page.h>
 #include <asm/fpu.h>
+#include <asm/ftrace.h>
 
 #ifdef CONFIG_HWZOL
 	.macro push_zol
--- linux-next-20210917.orig/arch/nds32/kernel/ex-exit.S
+++ linux-next-20210917/arch/nds32/kernel/ex-exit.S
@@ -9,7 +9,7 @@
 #include <asm/thread_info.h>
 #include <asm/current.h>
 #include <asm/fpu.h>
-
+#include <asm/ftrace.h>
 
 
 #ifdef CONFIG_HWZOL
