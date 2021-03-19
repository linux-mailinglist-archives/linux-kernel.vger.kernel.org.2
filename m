Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 477073424D4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 19:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbhCSSiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 14:38:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:59312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230297AbhCSSiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 14:38:02 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CE7261985;
        Fri, 19 Mar 2021 18:38:02 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1lNK0X-0017lF-BS; Fri, 19 Mar 2021 14:38:01 -0400
Message-ID: <20210319183801.239519861@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 19 Mar 2021 14:34:34 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yordan Karadzhov <y.karadz@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Cao jin <jojing64@gmail.com>
Subject: [for-next][PATCH 08/13] bootconfig: Update prototype of setup_boot_config()
References: <20210319183426.840228082@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cao jin <jojing64@gmail.com>

Parameter "cmdline" has no use, drop it.

Link: https://lkml.kernel.org/r/20210311085213.27680-1-jojing64@gmail.com

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Cao jin <jojing64@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 init/main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/init/main.c b/init/main.c
index 53b278845b88..407976d8669e 100644
--- a/init/main.c
+++ b/init/main.c
@@ -405,7 +405,7 @@ static int __init bootconfig_params(char *param, char *val,
 	return 0;
 }
 
-static void __init setup_boot_config(const char *cmdline)
+static void __init setup_boot_config(void)
 {
 	static char tmp_cmdline[COMMAND_LINE_SIZE] __initdata;
 	const char *msg;
@@ -472,7 +472,7 @@ static void __init setup_boot_config(const char *cmdline)
 
 #else
 
-static void __init setup_boot_config(const char *cmdline)
+static void __init setup_boot_config(void)
 {
 	/* Remove bootconfig data from initrd */
 	get_boot_config_from_initrd(NULL, NULL);
@@ -872,7 +872,7 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
 	pr_notice("%s", linux_banner);
 	early_security_init();
 	setup_arch(&command_line);
-	setup_boot_config(command_line);
+	setup_boot_config();
 	setup_command_line(command_line);
 	setup_nr_cpu_ids();
 	setup_per_cpu_areas();
-- 
2.30.1


