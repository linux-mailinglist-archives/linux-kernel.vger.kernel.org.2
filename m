Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFEDA31E834
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 10:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbhBRJbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 04:31:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbhBRITr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 03:19:47 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2013EC061797
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 00:18:26 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613636302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kc+0CbVZpOG9vn6O/gIVFLqAy93zyrZ18F7TF9AbwSY=;
        b=gEkReXYg1sRyPYtR5Y8SG/zMk7EMILAGB17Xc4yzDL4vvapjJ6l+FX41TZtsxOTWJ9PuAz
        apz5yWsj2WFa6Pvkl87x/ZDsHFqor5KFLhEdZq1qS/O75GUCb+CV5U39Nv5yag9Ivyen3m
        /47dfT6H9RRaMqsz84r/PZsSNXqFsz6J0bEOllGB17Pbu1S8GJXGGhTE0pNfQ8Oji0fNn4
        wm12PlMyrSBRbHb2tBIqmnuYOpZg7Rg3qubefo9XllnbrH5AlMW/+xPqHs5/LuiVeCMN74
        n+dB8n3Vz3d9OgW/OMuPp8hxtcP1K/0bYD1N/Sh4sGSnu/GAJkWfBvTE9BClPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613636302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kc+0CbVZpOG9vn6O/gIVFLqAy93zyrZ18F7TF9AbwSY=;
        b=Fk2Hbs+zb13O+FshiJj8DI1lXIiEtt0Yhqq4jxjDfVfbvS2nUeA5td3fR4cNiFtTW7H/iM
        xBZVNe7tzZ4iZWCg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH printk-rework 10/14] um: synchronize kmsg_dumper
Date:   Thu, 18 Feb 2021 09:18:13 +0100
Message-Id: <20210218081817.28849-11-john.ogness@linutronix.de>
In-Reply-To: <20210218081817.28849-1-john.ogness@linutronix.de>
References: <20210218081817.28849-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kmsg_dumper can be called from any context and CPU, possibly
from multiple CPUs simultaneously. Since a static buffer is used
to retrieve the kernel logs, this buffer must be protected against
simultaneous dumping.

Cc: Richard Weinberger <richard@nod.at>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 arch/um/kernel/kmsg_dump.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/um/kernel/kmsg_dump.c b/arch/um/kernel/kmsg_dump.c
index f38349ad00ea..173999422ed8 100644
--- a/arch/um/kernel/kmsg_dump.c
+++ b/arch/um/kernel/kmsg_dump.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/kmsg_dump.h>
+#include <linux/spinlock.h>
 #include <linux/console.h>
 #include <shared/init.h>
 #include <shared/kern.h>
@@ -9,8 +10,10 @@ static void kmsg_dumper_stdout(struct kmsg_dumper *dumper,
 				enum kmsg_dump_reason reason,
 				struct kmsg_dumper_iter *iter)
 {
+	static DEFINE_SPINLOCK(lock);
 	static char line[1024];
 	struct console *con;
+	unsigned long flags;
 	size_t len = 0;
 
 	/* only dump kmsg when no console is available */
@@ -25,11 +28,16 @@ static void kmsg_dumper_stdout(struct kmsg_dumper *dumper,
 	if (con)
 		return;
 
+	if (!spin_trylock_irqsave(&lock, flags))
+		return;
+
 	printf("kmsg_dump:\n");
 	while (kmsg_dump_get_line(iter, true, line, sizeof(line), &len)) {
 		line[len] = '\0';
 		printf("%s", line);
 	}
+
+	spin_unlock_irqrestore(&lock, flags);
 }
 
 static struct kmsg_dumper kmsg_dumper = {
-- 
2.20.1

