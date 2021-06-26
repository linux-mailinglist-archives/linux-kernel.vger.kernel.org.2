Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13CA83B4E97
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 15:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhFZNIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 09:08:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:33894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230041AbhFZNH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 09:07:58 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89D3561C34;
        Sat, 26 Jun 2021 13:05:36 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1lx807-000EgV-I4; Sat, 26 Jun 2021 09:05:35 -0400
Message-ID: <20210626130535.404127908@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 26 Jun 2021 09:04:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 05/24] bootconfig: Share the checksum function with tools
References: <20210626130404.033700863@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Move the checksum calculation function into the header for sharing it
with tools/bootconfig.

Link: https://lkml.kernel.org/r/162262197470.264090.16325743685807878807.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/bootconfig.h | 20 ++++++++++++++++++++
 init/main.c                | 12 +-----------
 tools/bootconfig/main.c    | 15 ++-------------
 3 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
index e49043ac77c9..6bdd94cff4e2 100644
--- a/include/linux/bootconfig.h
+++ b/include/linux/bootconfig.h
@@ -16,6 +16,26 @@
 #define BOOTCONFIG_ALIGN	(1 << BOOTCONFIG_ALIGN_SHIFT)
 #define BOOTCONFIG_ALIGN_MASK	(BOOTCONFIG_ALIGN - 1)
 
+/**
+ * xbc_calc_checksum() - Calculate checksum of bootconfig
+ * @data: Bootconfig data.
+ * @size: The size of the bootconfig data.
+ *
+ * Calculate the checksum value of the bootconfig data.
+ * The checksum will be used with the BOOTCONFIG_MAGIC and the size for
+ * embedding the bootconfig in the initrd image.
+ */
+static inline __init u32 xbc_calc_checksum(void *data, u32 size)
+{
+	unsigned char *p = data;
+	u32 ret = 0;
+
+	while (size--)
+		ret += *p++;
+
+	return ret;
+}
+
 /* XBC tree node */
 struct xbc_node {
 	u16 next;
diff --git a/init/main.c b/init/main.c
index e9c42a183e33..7b150f0501e2 100644
--- a/init/main.c
+++ b/init/main.c
@@ -386,16 +386,6 @@ static char * __init xbc_make_cmdline(const char *key)
 	return new_cmdline;
 }
 
-static u32 boot_config_checksum(unsigned char *p, u32 size)
-{
-	u32 ret = 0;
-
-	while (size--)
-		ret += *p++;
-
-	return ret;
-}
-
 static int __init bootconfig_params(char *param, char *val,
 				    const char *unused, void *arg)
 {
@@ -439,7 +429,7 @@ static void __init setup_boot_config(void)
 		return;
 	}
 
-	if (boot_config_checksum((unsigned char *)data, size) != csum) {
+	if (xbc_calc_checksum(data, size) != csum) {
 		pr_err("bootconfig checksum failed\n");
 		return;
 	}
diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index 62a3b5064b17..f45fa992e01d 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -126,17 +126,6 @@ static void xbc_show_list(void)
 	}
 }
 
-/* Simple real checksum */
-static int checksum(unsigned char *buf, int len)
-{
-	int i, sum = 0;
-
-	for (i = 0; i < len; i++)
-		sum += buf[i];
-
-	return sum;
-}
-
 #define PAGE_SIZE	4096
 
 static int load_xbc_fd(int fd, char **buf, int size)
@@ -232,7 +221,7 @@ static int load_xbc_from_initrd(int fd, char **buf)
 		return ret;
 
 	/* Wrong Checksum */
-	rcsum = checksum((unsigned char *)*buf, size);
+	rcsum = xbc_calc_checksum(*buf, size);
 	if (csum != rcsum) {
 		pr_err("checksum error: %d != %d\n", csum, rcsum);
 		return -EINVAL;
@@ -381,7 +370,7 @@ static int apply_xbc(const char *path, const char *xbc_path)
 		return ret;
 	}
 	size = strlen(buf) + 1;
-	csum = checksum((unsigned char *)buf, size);
+	csum = xbc_calc_checksum(buf, size);
 
 	/* Backup the bootconfig data */
 	data = calloc(size + BOOTCONFIG_ALIGN +
-- 
2.30.2
