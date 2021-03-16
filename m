Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A25EA33DDAD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 20:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240500AbhCPTif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 15:38:35 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:59913 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234578AbhCPTiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 15:38:24 -0400
Received: from debian.home (lfbn-lyo-1-457-219.w2-7.abo.wanadoo.fr [2.7.49.219])
        (Authenticated sender: alex@ghiti.fr)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 30ACF240006;
        Tue, 16 Mar 2021 19:38:21 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH] driver: of: Properly truncate command line if too long
Date:   Tue, 16 Mar 2021 15:38:20 -0400
Message-Id: <20210316193820.3137-1-alex@ghiti.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case the command line given by the user is too long, warn about it
and truncate it to the last full argument.

This is what efi already does in commit 80b1bfe1cb2f ("efi/libstub:
Don't parse overlong command lines").

Reported-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 drivers/of/fdt.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index dcc1dd96911a..de4c6f9bac39 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -25,6 +25,7 @@
 #include <linux/serial_core.h>
 #include <linux/sysfs.h>
 #include <linux/random.h>
+#include <linux/ctype.h>
 
 #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
 #include <asm/page.h>
@@ -1050,9 +1051,27 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
 
 	/* Retrieve command line */
 	p = of_get_flat_dt_prop(node, "bootargs", &l);
-	if (p != NULL && l > 0)
+	if (p != NULL && l > 0) {
 		strlcpy(data, p, min(l, COMMAND_LINE_SIZE));
 
+		/*
+		 * If the given command line size is larger than
+		 * COMMAND_LINE_SIZE, truncate it to the last complete
+		 * parameter.
+		 */
+		if (l > COMMAND_LINE_SIZE) {
+			char *cmd_p = (char *)data + COMMAND_LINE_SIZE - 1;
+
+			while (!isspace(*cmd_p))
+				cmd_p--;
+
+			*cmd_p = '\0';
+
+			pr_err("Command line is too long: truncated to %d bytes\n",
+			       (int)(cmd_p - (char *)data + 1));
+		}
+	}
+
 	/*
 	 * CONFIG_CMDLINE is meant to be a default in case nothing else
 	 * managed to set the command line, unless CONFIG_CMDLINE_FORCE
-- 
2.20.1

