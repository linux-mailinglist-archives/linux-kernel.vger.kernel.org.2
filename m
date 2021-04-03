Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B94D35335A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 12:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236325AbhDCKLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 06:11:20 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:54010 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235256AbhDCKLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 06:11:19 -0400
Received: from fsav110.sakura.ne.jp (fsav110.sakura.ne.jp [27.133.134.237])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 133ABFFJ043049;
        Sat, 3 Apr 2021 19:11:15 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav110.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav110.sakura.ne.jp);
 Sat, 03 Apr 2021 19:11:15 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav110.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 133ABEPr043042
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 3 Apr 2021 19:11:15 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: [PATCH] printk: Make multiple inclusion of kernel/printk/internal.h
 safe
To:     kernel test robot <lkp@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <20210403041444.4081-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <202104031438.RuTk02Vc-lkp@intel.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <ba17392d-6394-169a-cdcf-0d910ed06bd1@i-love.sakura.ne.jp>
Date:   Sat, 3 Apr 2021 19:11:14 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <202104031438.RuTk02Vc-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot reported that kernel/printk/internal.h is not ready
to be #include'd for multiple times, and that vprintk_func() for
CONFIG_PRINTK=n should be marked as "static inline".

Since "tty: use printk_safe context at tty_msg()" will make
kernel/printk/internal.h be #include'd for multiple times, let's fix
this problem first.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Fixes: 099f1c84c0052ec1 ("printk: introduce per-cpu safe_print seq buffer")
Cc: <stable@vger.kernel.org> # 4.11+
---
 kernel/printk/internal.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 3a8fd491758c..2119c546cba2 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -2,6 +2,10 @@
 /*
  * internal.h - printk internal definitions
  */
+
+#ifndef _KERNEL_PRINTK_INTERNAL_H
+#define _KERNEL_PRINTK_INTERNAL_H
+
 #include <linux/percpu.h>
 
 #ifdef CONFIG_PRINTK
@@ -56,7 +60,7 @@ void defer_console_output(void);
 
 #else
 
-__printf(1, 0) int vprintk_func(const char *fmt, va_list args) { return 0; }
+static inline __printf(1, 0) int vprintk_func(const char *fmt, va_list args) { return 0; }
 
 /*
  * In !PRINTK builds we still export logbuf_lock spin_lock, console_sem
@@ -72,3 +76,5 @@ __printf(1, 0) int vprintk_func(const char *fmt, va_list args) { return 0; }
 static inline void printk_safe_init(void) { }
 static inline bool printk_percpu_data_ready(void) { return false; }
 #endif /* CONFIG_PRINTK */
+
+#endif
-- 
2.18.4


