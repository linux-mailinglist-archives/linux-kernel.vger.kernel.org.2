Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F25E13281DD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 16:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236932AbhCAPJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 10:09:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236894AbhCAPIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 10:08:46 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AD7C0617A7
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 07:07:25 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lGk8k-00AJOK-BM; Mon, 01 Mar 2021 16:07:18 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-um@lists.infradead.org
Cc:     Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 4/8] um: export signals_enabled directly
Date:   Mon,  1 Mar 2021 16:07:04 +0100
Message-Id: <20210301160501.0b9ff00679f4.I2a08cbe698fc23f1731e33e4f2582475290b90dc@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210301150708.244970-1-johannes@sipsolutions.net>
References: <20210301150708.244970-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Use signals_enabled instead of always jumping through
a function call to read it, there's not much point in
that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/include/asm/irqflags.h   | 10 +++++-----
 arch/um/include/shared/longjmp.h | 14 +++++++-------
 arch/um/include/shared/os.h      |  1 -
 arch/um/kernel/ksyms.c           |  2 +-
 arch/um/os-Linux/signal.c        |  7 +------
 5 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/arch/um/include/asm/irqflags.h b/arch/um/include/asm/irqflags.h
index 0642ad9035d1..dab5744e9253 100644
--- a/arch/um/include/asm/irqflags.h
+++ b/arch/um/include/asm/irqflags.h
@@ -2,15 +2,15 @@
 #ifndef __UM_IRQFLAGS_H
 #define __UM_IRQFLAGS_H
 
-extern int get_signals(void);
-extern int set_signals(int enable);
-extern void block_signals(void);
-extern void unblock_signals(void);
+extern int signals_enabled;
+int set_signals(int enable);
+void block_signals(void);
+void unblock_signals(void);
 
 #define arch_local_save_flags arch_local_save_flags
 static inline unsigned long arch_local_save_flags(void)
 {
-	return get_signals();
+	return signals_enabled;
 }
 
 #define arch_local_irq_restore arch_local_irq_restore
diff --git a/arch/um/include/shared/longjmp.h b/arch/um/include/shared/longjmp.h
index 85a1cc290ecb..bdb2869b72b3 100644
--- a/arch/um/include/shared/longjmp.h
+++ b/arch/um/include/shared/longjmp.h
@@ -5,6 +5,7 @@
 #include <sysdep/archsetjmp.h>
 #include <os.h>
 
+extern int signals_enabled;
 extern int setjmp(jmp_buf);
 extern void longjmp(jmp_buf, int);
 
@@ -12,13 +13,12 @@ extern void longjmp(jmp_buf, int);
 	longjmp(*buf, val);	\
 } while(0)
 
-#define UML_SETJMP(buf) ({ \
-	int n;	   \
-	volatile int enable;	\
-	enable = get_signals(); \
-	n = setjmp(*buf); \
-	if(n != 0) \
-		set_signals_trace(enable); \
+#define UML_SETJMP(buf) ({				\
+	int n, enable;					\
+	enable = *(volatile int *)&signals_enabled;	\
+	n = setjmp(*buf);				\
+	if(n != 0)					\
+		set_signals_trace(enable);		\
 	n; })
 
 #endif
diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index 13d86f94cf0f..f9fbbddc38bb 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -237,7 +237,6 @@ extern void send_sigio_to_self(void);
 extern int change_sig(int signal, int on);
 extern void block_signals(void);
 extern void unblock_signals(void);
-extern int get_signals(void);
 extern int set_signals(int enable);
 extern int set_signals_trace(int enable);
 extern int os_is_signal_stack(void);
diff --git a/arch/um/kernel/ksyms.c b/arch/um/kernel/ksyms.c
index 8ade54a86a7e..b1e5634398d0 100644
--- a/arch/um/kernel/ksyms.c
+++ b/arch/um/kernel/ksyms.c
@@ -7,7 +7,7 @@
 #include <os.h>
 
 EXPORT_SYMBOL(set_signals);
-EXPORT_SYMBOL(get_signals);
+EXPORT_SYMBOL(signals_enabled);
 
 EXPORT_SYMBOL(os_stat_fd);
 EXPORT_SYMBOL(os_stat_file);
diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index 96f511d1aabe..8c9d162e6c51 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -62,7 +62,7 @@ static void sig_handler_common(int sig, struct siginfo *si, mcontext_t *mc)
 #define SIGALRM_BIT 1
 #define SIGALRM_MASK (1 << SIGALRM_BIT)
 
-static int signals_enabled;
+int signals_enabled;
 static unsigned int signals_pending;
 static unsigned int signals_active = 0;
 
@@ -334,11 +334,6 @@ void unblock_signals(void)
 	}
 }
 
-int get_signals(void)
-{
-	return signals_enabled;
-}
-
 int set_signals(int enable)
 {
 	int ret;
-- 
2.26.2

