Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 360BF3B0775
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 16:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbhFVOgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 10:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbhFVOgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 10:36:10 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06ADC061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 07:33:53 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id f15so8498904wro.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 07:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fWQ9fv5n80k6I/97HJjFfzjbazsp/7d3XmYJL594Tuo=;
        b=kQ8Mq8vXoY5Wmg2K7CVYjaod8o1tM5193Jbi18CO9v4H+tjVRS0HLtqpZII7go+mUD
         9SXZWCgiDl1rBpMhAn3PmhcEj3fsE/2VTu0h2agBqhfp68gxOryG/h9398VqDOBembyp
         eBRXVbk2t1VfboHZpiLpVX5y4VXCxcm6NjArJXvqcKoD5YB+jxYF4sgZRnYkkaZW0md/
         Y4QQ6XFpSTNyHy/7KVrR00xw6dK5lvIdvNjXMjeDPEpANcMzM1Etm1ReruPpk6j6Fam2
         1emOkBTLSjgZlVJqCRldXECbgHaAjzX+RfE7qNI/NIdyZO2NgXIr5oVrrIZqVoOt0s7j
         lBNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fWQ9fv5n80k6I/97HJjFfzjbazsp/7d3XmYJL594Tuo=;
        b=Ve1wGbS3Uc9wdHh/R9F1zFWgqBKGvaoRmyRKCsFBwYHxLFinHrAP/DIoKm2EIJTp5e
         aesu8WrF2EG/OI4n8PykqyegR3qr4kCgPbyRu8nTFkTFxYU/W3Z8n4Dr2c8IOTGYhZsf
         oKdEuKdE0L9KJxlP9Por+EEih53BO3rekyMIsVUb8hAd38YuiMLqCHFkzpvJ+CuWLb8m
         BAIDEVlgmOw90sokSAtIYmrsooyTvDc8stmINRRXDN8W+kRe0OroURL6h3lsNLQrZVXX
         omdeOZukewHp2F7JlXcEb7zlSsgUL+5ccmwt73Mc70q2/kJtDj7XCUUu/tMmRi2hADKf
         eO3w==
X-Gm-Message-State: AOAM532YeqCwDC92xm2gc15Agyf7wyDxvbLfEzn3eUjAkAh+x2ZFko3b
        AQN4497FPqOOJ5YS86zvYZcIqo0eNJXX1A+X
X-Google-Smtp-Source: ABdhPJxF8bAye5rjfV2vTT0yPF1VC4aRo9R8QbKPDnaMP+xQgz3fphd7jzFg/k0FQX3/ChUT67M8/A==
X-Received: by 2002:a5d:64c3:: with SMTP id f3mr5270596wri.263.1624372431967;
        Tue, 22 Jun 2021 07:33:51 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id z25sm3007714wmf.23.2021.06.22.07.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 07:33:51 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH] printk: Add CONFIG_CONSOLE_LOGLEVEL_PANIC
Date:   Tue, 22 Jun 2021 15:33:50 +0100
Message-Id: <20210622143350.1105701-1-dima@arista.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

console_verbose() increases console loglevel to CONSOLE_LOGLEVEL_MOTORMOUTH,
which provides more information to debug a panic/oops.

Unfortunately, in Arista we maintain some DUTs (Device Under Test) that
are configured to have 9600 baud rate. While verbose console messages
have their value to post-analyze crashes, on such setup they:
- may prevent panic/oops messages being printed
- take too long to flush on console resulting in watchdog reboot

In all our setups we use kdump which saves dmesg buffer after panic,
so in reality those extra messages on console provide no additional value,
but rather add risk of not getting to __crash_kexec().

Provide CONFIG_CONSOLE_LOGLEVEL_PANIC, which allows to choose how
verbose the kernel must be on oops/panic.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 include/linux/printk.h |  4 ++--
 lib/Kconfig.debug      | 13 +++++++++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index fe7eb2351610..5a65a719f917 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -76,8 +76,8 @@ static inline void console_silent(void)
 
 static inline void console_verbose(void)
 {
-	if (console_loglevel)
-		console_loglevel = CONSOLE_LOGLEVEL_MOTORMOUTH;
+	if (console_loglevel && (CONFIG_CONSOLE_LOGLEVEL_PANIC > 0))
+		console_loglevel = CONFIG_CONSOLE_LOGLEVEL_PANIC;
 }
 
 /* strlen("ratelimit") + 1 */
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 678c13967580..0c12cafd9d8b 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -61,6 +61,19 @@ config CONSOLE_LOGLEVEL_QUIET
 	  will be used as the loglevel. IOW passing "quiet" will be the
 	  equivalent of passing "loglevel=<CONSOLE_LOGLEVEL_QUIET>"
 
+config CONSOLE_LOGLEVEL_PANIC
+	int "panic console loglevel (1-15)"
+	range 0 15
+	default "15"
+	help
+	  loglevel to use in kernel panic or oopses.
+
+	  Usually in order to provide more debug information on console upon
+	  panic, one wants to see everything being printed (loglevel = 15).
+	  With an exception to setups with low baudrate on serial console,
+	  keeping this value high is a good choice.
+	  0 value is to keep the loglevel during panic/oops unchanged.
+
 config MESSAGE_LOGLEVEL_DEFAULT
 	int "Default message log level (1-7)"
 	range 1 7
-- 
2.31.1

