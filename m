Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5128D32BCA6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243455AbhCCO2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 09:28:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1842960AbhCCKXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:23:02 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCFABC08ED35
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 02:15:31 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614766530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Or+eUVd+fYQqMYYcylVSOVem/7WNtb5N41BeW/Jkfn0=;
        b=CFto7vrpTQ4EktDWEQ8JBxAqXfOotfgpfhURFSR3NLFKnMdcluqzN3EqX19/n4cK+ui65I
        Mrfnzn9p0wKvGEmUw+lRG78TGtg8IoTtdrffU9V3CCFYY6m2SZqJDXkORYnKR3wckjNQMA
        MG9cxSOkZz1yUc9lTCBMDNC2ivjxIjojuTO3kTxi55Godrw7EWt0ufj1HPC+U6+XnH1TJd
        eO4SUxZQ93zQkaDBe/bq+I8E6gsjlgR0RLGtDwwyLpEIN7/Zy6U73mJo0z8/OM9hpaVlDJ
        5T+pBgkLpWQ+uUm7kS/683t9DvHnObn1W5EJe5+DPvCBGltPEydezuVtkhpdIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614766530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Or+eUVd+fYQqMYYcylVSOVem/7WNtb5N41BeW/Jkfn0=;
        b=QJsEIMTOiAT948IFzBXLOiq4bd0U/Yx9EWkSL32hSXQy9acbYV7TqdJ3QK5ssv8N+9K4dS
        IIvMqgPLNyR7gvAw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Meyer <thomas@m3y3r.de>, linux-um@lists.infradead.org
Subject: [PATCH next v4 01/15] um: synchronize kmsg_dumper
Date:   Wed,  3 Mar 2021 11:15:14 +0100
Message-Id: <20210303101528.29901-2-john.ogness@linutronix.de>
In-Reply-To: <20210303101528.29901-1-john.ogness@linutronix.de>
References: <20210303101528.29901-1-john.ogness@linutronix.de>
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
 arch/um/kernel/kmsg_dump.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/um/kernel/kmsg_dump.c b/arch/um/kernel/kmsg_dump.c
index 6516ef1f8274..a765d235e50e 100644
--- a/arch/um/kernel/kmsg_dump.c
+++ b/arch/um/kernel/kmsg_dump.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/kmsg_dump.h>
+#include <linux/spinlock.h>
 #include <linux/console.h>
 #include <linux/string.h>
 #include <shared/init.h>
@@ -9,8 +10,10 @@
 static void kmsg_dumper_stdout(struct kmsg_dumper *dumper,
 				enum kmsg_dump_reason reason)
 {
+	static DEFINE_SPINLOCK(lock);
 	static char line[1024];
 	struct console *con;
+	unsigned long flags;
 	size_t len = 0;
 
 	/* only dump kmsg when no console is available */
@@ -29,11 +32,16 @@ static void kmsg_dumper_stdout(struct kmsg_dumper *dumper,
 	if (con)
 		return;
 
+	if (!spin_trylock_irqsave(&lock, flags))
+		return;
+
 	printf("kmsg_dump:\n");
 	while (kmsg_dump_get_line(dumper, true, line, sizeof(line), &len)) {
 		line[len] = '\0';
 		printf("%s", line);
 	}
+
+	spin_unlock_irqrestore(&lock, flags);
 }
 
 static struct kmsg_dumper kmsg_dumper = {
-- 
2.20.1

