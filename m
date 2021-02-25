Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBF932578D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 21:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbhBYUZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 15:25:28 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38148 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbhBYUZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 15:25:22 -0500
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614284680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FvEugpmlewV9gebD1OmyfIYiNAiGiwjtgRLamPmBKRk=;
        b=rbvwFdFLGTQWpwqv3SpQcfJSrcNDWVIEeMjAoPk7uEWMiCvlAscCCO96sM/tPm9vpTBtN+
        oOeXz/znuzp7Cn+BN/ziace690e9SfEwZ33Y6LZxXn0SFyNoNf1DptRuJ71a31J257+5I5
        1QaV95+dluYFn6Fekcfy4tGfUVpvcj/niKYmMGLXom3irekHBLQj3Bm7Ft7FRQNrBv83kW
        iBajhDO8IvYUP9o55opRHJPcs051ZdXsCTOnfoR5H8A3SZxy9xi+d+8aUzVhYyX3P73spK
        CVVCyYH/FJWKHF9pRHRSsG5TF9Joq06NgGnUZsNRELc22s9ot/HdNFpHwHwfjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614284680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FvEugpmlewV9gebD1OmyfIYiNAiGiwjtgRLamPmBKRk=;
        b=tnyXn4ktKUVli67LkOUpVYzz6LC1Ugo4+7U7Pj2RsxmMKeFfEHdPiAnqVsTVCJwXfuRNWK
        +1NA+Og0m9aYDvDg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Thomas Meyer <thomas@m3y3r.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-um@lists.infradead.org
Subject: [PATCH next v3 01/15] um: synchronize kmsg_dumper
Date:   Thu, 25 Feb 2021 21:24:24 +0100
Message-Id: <20210225202438.28985-2-john.ogness@linutronix.de>
In-Reply-To: <20210225202438.28985-1-john.ogness@linutronix.de>
References: <20210225202438.28985-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kmsg_dumper can be called from any context and CPU, possibly
from multiple CPUs simultaneously. Since a static buffer is used
to retrieve the kernel logs, this buffer must be protected against
simultaneous dumping. Skip dumping if another context is already
dumping.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 arch/um/kernel/kmsg_dump.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/um/kernel/kmsg_dump.c b/arch/um/kernel/kmsg_dump.c
index 6516ef1f8274..4869e2cc787c 100644
--- a/arch/um/kernel/kmsg_dump.c
+++ b/arch/um/kernel/kmsg_dump.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/kmsg_dump.h>
+#include <linux/spinlock.h>
 #include <linux/console.h>
 #include <linux/string.h>
 #include <shared/init.h>
@@ -9,6 +10,7 @@
 static void kmsg_dumper_stdout(struct kmsg_dumper *dumper,
 				enum kmsg_dump_reason reason)
 {
+	static DEFINE_SPINLOCK(lock);
 	static char line[1024];
 	struct console *con;
 	size_t len = 0;
@@ -29,11 +31,16 @@ static void kmsg_dumper_stdout(struct kmsg_dumper *dumper,
 	if (con)
 		return;
 
+	if (!spin_trylock(&lock))
+		return;
+
 	printf("kmsg_dump:\n");
 	while (kmsg_dump_get_line(dumper, true, line, sizeof(line), &len)) {
 		line[len] = '\0';
 		printf("%s", line);
 	}
+
+	spin_unlock(&lock);
 }
 
 static struct kmsg_dumper kmsg_dumper = {
-- 
2.20.1

