Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27784398118
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 08:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbhFBG1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 02:27:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:56486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231253AbhFBG1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 02:27:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3DE2961242;
        Wed,  2 Jun 2021 06:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622615120;
        bh=CN8Scw9JiOUjDS8oyeIUr7XIx5aiC/gWsMtxKDZjltE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AWumsQOQE8xEDlCg8ICPEX8ajmMPVgLrJNE6DiPUCpyweW5UdKS6e4ux90OkPK/mn
         BKExYH8RJtR3UMr4JNg8e9PznzaYoLsEbvRy0+aqy0p/7+LEz5865SiGiaU5UVqBdw
         eQfGI4AHIwgIs8q7PynOHGvMKl20+ZPM+HjrUPtBcG18ePUxP1aTDzKXoffVjLKdtO
         6xH3W5E3nLKWIajNsDA2vuOG0wXqRNrHEhBehj14JjFlhP0Ipf7026mJidaEBagvdW
         ddjbuYT6yYpF3Ob1lH60Kw+N5b2dQx1/VJInLt+qf3yVN501xiPAzLG7oROiN4BG2d
         TM6YlRCB5A6KQ==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Devin Moore <devinmoore@google.com>
Subject: [PATCH v3 6/6] bootconfig: Share the checksum function with tools
Date:   Wed,  2 Jun 2021 15:25:17 +0900
Message-Id: <162261511700.255316.7845877611885532107.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <162261506232.255316.12147562546699211199.stgit@devnote2>
References: <162261506232.255316.12147562546699211199.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the checksum calculation function into the header for sharing it
with tools/bootconfig.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/bootconfig/main.c |   15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

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
index eb01e121d2f1..43914e675421 100644
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
index 5441b254eb7c..9e2c6eedacb1 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -128,17 +128,6 @@ static void xbc_show_list(void)
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
@@ -234,7 +223,7 @@ static int load_xbc_from_initrd(int fd, char **buf)
 		return ret;
 
 	/* Wrong Checksum */
-	rcsum = checksum((unsigned char *)*buf, size);
+	rcsum = xbc_calc_checksum(*buf, size);
 	if (csum != rcsum) {
 		pr_err("checksum error: %d != %d\n", csum, rcsum);
 		return -EINVAL;
@@ -383,7 +372,7 @@ static int apply_xbc(const char *path, const char *xbc_path)
 		return ret;
 	}
 	size = strlen(buf) + 1;
-	csum = checksum((unsigned char *)buf, size);
+	csum = xbc_calc_checksum(buf, size);
 
 	/* Backup the bootconfig data */
 	data = calloc(size + BOOTCONFIG_ALIGN +

