Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1663570F9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 17:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245125AbhDGPus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 11:50:48 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:39409 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353953AbhDGPtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 11:49:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1617810574; x=1649346574;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8bPZB2L7R8T1buTkfeAuMShi0HneoMFPN1eodPMED7Q=;
  b=GzVMUEsiUMow3/V8TS+ZWJSQ+PaC/hA6KfF3zhQtXn8ABxih9Av2sMIx
   VNwWVtybZNsecr8LJJgBbuKGcLb1QHpjlBj1JnOljgPElrLIjs8lu/JT7
   FyRT5Qhw+/vwc0iemCFT3UrQhtMcDsfgJP2Ueih5QDFIOkEhIqjHVNhUB
   q2yvIJlDlaR+K3+8fIfuOmVgKEBNRQV/NuL5aZhyPyDj/scjKeQyyAxkY
   bsujLvyCmurzMf9wt6F+n/izCA9A8NcPoQssyCCAjWGvgxj6B/7obqYhk
   O/8TrTM+B+zUrtwy6br+gNd87BBugHGuZdA3Xa4vqXQJsOXrG1gcHRAmS
   Q==;
IronPort-SDR: Xux64IaaIWym8hxEh6qHXYKz74msagwvjuqtRPcciutrHQr7KudOZLi+/cJDSfv+EBXUT+7nWE
 gss6B3CB9DBIbQdoP4NpmDKZtsQcsDCA1DuVsGn9g4j0jUUDHbQ/YXF33cgA6FTrXDszaKKbls
 uL56+dZmHVz+bZpcoHsnmj3Qw2kPioSAb49bO0IZ+sjGczNpdBSupyOms78f2UKyjFp7AcUB+y
 c4bT+EdY1RxvXIFSzfQjzwvqH/DSWFB8V5IKjXCNPZRzfTvYNxvt+rrzDYk6VPJVgmrEt6K8dx
 Vkk=
X-IronPort-AV: E=Sophos;i="5.82,203,1613404800"; 
   d="scan'208";a="274931686"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Apr 2021 23:49:32 +0800
IronPort-SDR: hUaXHJIfu3oO7/otbyEatIpki4roEy3Z4heGMv21m0wtRDb0kuupK6qVDR/67cj0aTfF7Qhf1m
 VkDp8sbHuQYSSWYCbdg8Sg9xK3yptexWVudZNb+dpauDzIpWxIVGrDjcIh2arWNeSVAmVK7ec+
 2WfLdfwF7mD3+IjRJ95azDf3VQuEwls1T709HadBr8EjbWsJxsAS11C1aP1EGT1oqeJwyUXZYB
 4vY4EWbYffs/f7RSS6DA7go0cfn6T9JkkXs/L14+oRL3uFWPTXKiiq80E3R+Fh7wkpaq4uQveO
 QqVnviZEtB5yLTQj6lWnuGTR
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 08:30:51 -0700
IronPort-SDR: XDqFuqXsTFsEzpoFJzIGKLZmNG5O14ubW4TIYD+RljgELR7moJ3bqrV6xZmHZD5ZMFa7O9QJbt
 cB/lPo7rcuB/2GKL5mqn7lfnEUV8hlvwRHTeuw591XN2+LDfABn5s2IxKKvrd+bA91KeuBslqe
 x4juyDYvE4MC5kz9AKm2TQZ5++HBeNZh7n34bzVDMeTiPRbRcUzwDDJJpOsnxbSd5Y8Kvlh2+E
 A7TFcs/86pxa9KpsYvtoavvmaApGdfewJiCqs5vMu34Zp02up07LqfL28k/hPdihiPWHIKZq3+
 YOQ=
WDCIronportException: Internal
Received: from unknown (HELO twashi.fujisawa.hgst.com) ([10.225.163.90])
  by uls-op-cesaip01.wdc.com with ESMTP; 07 Apr 2021 08:49:31 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
Cc:     Max Filippov <jcmvbkbc@gmail.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Anup Patel <anup.patel@wdc.com>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 1/2] binfmt_flat: allow not offsetting data start
Date:   Thu,  8 Apr 2021 00:49:23 +0900
Message-Id: <20210407154924.1557489-2-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210407154924.1557489-1-damien.lemoal@wdc.com>
References: <20210407154924.1557489-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 2217b9826246 ("binfmt_flat: revert "binfmt_flat: don't offset
the data start"") restored offsetting the start of the data section by
a number of words defined by MAX_SHARED_LIBS. As a result, since
MAX_SHARED_LIBS is never 0, a gap between the text and data sections
always exists. For architectures which cannot support a such gap
between the text and data sections (e.g. riscv nommu), flat binary
programs cannot be executed.

To allow an architecture to request contiguous text and data sections,
introduce the config option CONFIG_BINFMT_FLAT_NO_TEXT_DATA_GAP.
Using this new option, the macro DATA_GAP_WORDS is conditionally
defined in binfmt_flat.c to MAX_SHARED_LIBS for architectures
tolerating the text-to-data gap (CONFIG_BINFMT_FLAT_NO_TEXT_DATA_GAP
disabled case) and to 0 when CONFIG_BINFMT_FLAT_NO_TEXT_DATA_GAP is
enabled. DATA_GAP_WORDS is used in load_flat_file() to calculate the
data section length and start position.

An architecture enabling CONFIG_BINFMT_FLAT_NO_TEXT_DATA_GAP also
prevents the use of the separate text/data load case (when the flat file
header flags FLAT_FLAG_RAM and FLAT_FLAG_GZIP are not set with NOMMU
kernels) and forces the use of a single RAM region for loading
(equivalent to FLAT_FLAG_RAM being set).

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 fs/Kconfig.binfmt |  3 +++
 fs/binfmt_flat.c  | 21 +++++++++++++++------
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
index c6f1c8c1934e..c6df931d5d45 100644
--- a/fs/Kconfig.binfmt
+++ b/fs/Kconfig.binfmt
@@ -112,6 +112,9 @@ config BINFMT_FLAT_ARGVP_ENVP_ON_STACK
 config BINFMT_FLAT_OLD_ALWAYS_RAM
 	bool
 
+config BINFMT_FLAT_NO_TEXT_DATA_GAP
+	bool
+
 config BINFMT_FLAT_OLD
 	bool "Enable support for very old legacy flat binaries"
 	depends on BINFMT_FLAT
diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
index b9c658e0548e..2be29bb964b8 100644
--- a/fs/binfmt_flat.c
+++ b/fs/binfmt_flat.c
@@ -74,6 +74,12 @@
 #define	MAX_SHARED_LIBS			(1)
 #endif
 
+#ifdef CONFIG_BINFMT_FLAT_NO_TEXT_DATA_GAP
+#define DATA_GAP_WORDS			(0)
+#else
+#define DATA_GAP_WORDS			(MAX_SHARED_LIBS)
+#endif
+
 struct lib_info {
 	struct {
 		unsigned long start_code;		/* Start of text segment */
@@ -559,7 +565,10 @@ static int load_flat_file(struct linux_binprm *bprm,
 	 * case,  and then the fully copied to RAM case which lumps
 	 * it all together.
 	 */
-	if (!IS_ENABLED(CONFIG_MMU) && !(flags & (FLAT_FLAG_RAM|FLAT_FLAG_GZIP))) {
+	if (!IS_ENABLED(CONFIG_MMU) &&
+	    !IS_ENABLED(CONFIG_BINFMT_FLAT_NO_TEXT_DATA_GAP) &&
+	    !(flags & (FLAT_FLAG_RAM|FLAT_FLAG_GZIP))) {
+
 		/*
 		 * this should give us a ROM ptr,  but if it doesn't we don't
 		 * really care
@@ -576,7 +585,7 @@ static int load_flat_file(struct linux_binprm *bprm,
 			goto err;
 		}
 
-		len = data_len + extra + MAX_SHARED_LIBS * sizeof(unsigned long);
+		len = data_len + extra + DATA_GAP_WORDS * sizeof(unsigned long);
 		len = PAGE_ALIGN(len);
 		realdatastart = vm_mmap(NULL, 0, len,
 			PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE, 0);
@@ -591,7 +600,7 @@ static int load_flat_file(struct linux_binprm *bprm,
 			goto err;
 		}
 		datapos = ALIGN(realdatastart +
-				MAX_SHARED_LIBS * sizeof(unsigned long),
+				DATA_GAP_WORDS * sizeof(unsigned long),
 				FLAT_DATA_ALIGN);
 
 		pr_debug("Allocated data+bss+stack (%u bytes): %lx\n",
@@ -622,7 +631,7 @@ static int load_flat_file(struct linux_binprm *bprm,
 		memp_size = len;
 	} else {
 
-		len = text_len + data_len + extra + MAX_SHARED_LIBS * sizeof(u32);
+		len = text_len + data_len + extra + DATA_GAP_WORDS * sizeof(u32);
 		len = PAGE_ALIGN(len);
 		textpos = vm_mmap(NULL, 0, len,
 			PROT_READ | PROT_EXEC | PROT_WRITE, MAP_PRIVATE, 0);
@@ -638,7 +647,7 @@ static int load_flat_file(struct linux_binprm *bprm,
 
 		realdatastart = textpos + ntohl(hdr->data_start);
 		datapos = ALIGN(realdatastart +
-				MAX_SHARED_LIBS * sizeof(u32),
+				DATA_GAP_WORDS * sizeof(u32),
 				FLAT_DATA_ALIGN);
 
 		reloc = (__be32 __user *)
@@ -714,7 +723,7 @@ static int load_flat_file(struct linux_binprm *bprm,
 			ret = result;
 			pr_err("Unable to read code+data+bss, errno %d\n", ret);
 			vm_munmap(textpos, text_len + data_len + extra +
-				MAX_SHARED_LIBS * sizeof(u32));
+				  DATA_GAP_WORDS * sizeof(u32));
 			goto err;
 		}
 	}
-- 
2.30.2

