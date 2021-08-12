Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89CC03E9BDD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 03:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbhHLBOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 21:14:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:38076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233128AbhHLBOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 21:14:24 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 851E4610FD;
        Thu, 12 Aug 2021 01:13:56 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mDzIB-003pI2-Ig; Wed, 11 Aug 2021 21:13:55 -0400
Message-ID: <20210812011355.421445007@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 11 Aug 2021 21:12:56 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrew Halaney <ahalaney@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-linus][PATCH 6/7] init: Suppress wrong warning for bootconfig cmdline parameter
References: <20210812011250.954353252@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Since the 'bootconfig' command line parameter is handled before
parsing the command line, it doesn't use early_param(). But in
this case, kernel shows a wrong warning message about it.

[    0.013714] Kernel command line: ro console=ttyS0  bootconfig console=tty0
[    0.013741] Unknown command line parameters: bootconfig

To suppress this message, add a dummy handler for 'bootconfig'.

Link: https://lkml.kernel.org/r/162812945097.77369.1849780946468010448.stgit@devnote2

Fixes: 86d1919a4fb0 ("init: print out unknown kernel parameters")
Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 init/main.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/init/main.c b/init/main.c
index f5b8246e8aa1..8d97aba78c3a 100644
--- a/init/main.c
+++ b/init/main.c
@@ -397,6 +397,12 @@ static int __init bootconfig_params(char *param, char *val,
 	return 0;
 }
 
+static int __init warn_bootconfig(char *str)
+{
+	/* The 'bootconfig' has been handled by bootconfig_params(). */
+	return 0;
+}
+
 static void __init setup_boot_config(void)
 {
 	static char tmp_cmdline[COMMAND_LINE_SIZE] __initdata;
@@ -475,9 +481,8 @@ static int __init warn_bootconfig(char *str)
 	pr_warn("WARNING: 'bootconfig' found on the kernel command line but CONFIG_BOOT_CONFIG is not set.\n");
 	return 0;
 }
-early_param("bootconfig", warn_bootconfig);
-
 #endif
+early_param("bootconfig", warn_bootconfig);
 
 /* Change NUL term back to "=", to make "param" the whole string. */
 static void __init repair_env_string(char *param, char *val)
-- 
2.30.2
