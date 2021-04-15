Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6B5360233
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 08:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbhDOGPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 02:15:40 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:31334 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbhDOGPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 02:15:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618467314; x=1650003314;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=99YqRFeFwdpr17CrSNx90Z9RrdjLX1ZBgCLkO2RczNA=;
  b=VRhMJog2/40gkS89+7R9R42KC/4Zqpv2TRmjVSe7zJl18BKInaaq0/vk
   0IYoMlkGVhO0HI2go/HacBvkQCuYvvgdTuFjjyr2RElZhheSEbghc+FU5
   VIoAVcYnOKOK0yP6KF1JrXcJveJztLe8t3v8s7v+uZ/lefAWRU1bM5ii4
   ZWnpkZI3d5IWKzZBdYax6+oJzgzuTkwIQcv5OU6rC+6ylLJDAeJWrwty9
   DwqtqB2oobS00RteyMNhNVgcZXO4/m/wdoQZKTgVgR8JcqQJblK/14Xt/
   dQsveeO/4xnm8W0cD6e+JFI79sKRdehw1ypjdv7RgxgIEgQSMvENtUPP9
   Q==;
IronPort-SDR: PxX3TaOybyGY6v0mHu54/9OrBYy8vzQUyORB7AQ7udNaReBRqR5U4uDKRUi7bKX8StjcKejEo3
 g9+IyFd6EAAEqwMFINuWl18KNC2a3uTtpm2iaO594r03FJqyhbm+x732HHrt2nMe27vyG8Fpuh
 iKTY0YgvEG22KyjRmvktsTqVf9qRARh7uV07Ga9xGb8A6dH3e0Q/w7KO+bDu3bZeuINgMyK/NN
 MvUEfGxscs7azUwCr2S2WzO1afbX6f75eBFF8pJsheQdrO/ZJ+bt8CdDKa83LyAtkYLLvaFbks
 +oI=
X-IronPort-AV: E=Sophos;i="5.82,223,1613404800"; 
   d="scan'208";a="164846903"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Apr 2021 14:15:12 +0800
IronPort-SDR: SpUsvoPhRrOXT0Fs2yFjbJRBkJxnflyh/hT/4qUNUeb2K+selqteCV+ZSbbWc5Ohwm3yq3+PYE
 MDheOyYlhv20aLMdOB6UazhrqaXaUKpdbSUnfCgfAtbVeVRrrJTyrduJ0IIF24t0cFbYsTCZf4
 1oJn0HDjHYFr7N0I4/JUjPL364PkdUhAu003mr6JHUdUIJYcW5VwYT+z000Nwxqr14IAPR7O78
 s3U5JE+tEC7MTTmzoRXwHg92QL+TYamZGaNYi/lDRYzKFoIIxA20h3Vv5XZfYK+eOiLchu5KAH
 1EqkIOQWNzWYXvs2Im9AnqJz
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 22:56:09 -0700
IronPort-SDR: ENfL3KYS42ufbWY1UVWeZgsh5THbCn08O/380jE8JNKmNqJ3J5o5DYOWvlbb73BgO1r0T0x4i/
 eD+glBm+9naTQOZzYV+Lg4C9GApCMVycrfJ8r8mojOuv5wLrhc6428ZGUF9erwX7Kb2ROc9xbP
 1f1sukAGDB5sGI8e8q97ShYImlJoySUixATh3nDRR+g4JuWU8NuAZcgXcLLDPG6Xcjyx0Vlz8I
 mKhzXlz/fznfeWm9bVs4cN1PIdMdHOjKDNatoLyiEXNuSk9NgKqMlZsKPzLEaad9s+b0/vT3jE
 C0s=
WDCIronportException: Internal
Received: from unknown (HELO twashi.fujisawa.hgst.com) ([10.225.163.118])
  by uls-op-cesaip02.wdc.com with ESMTP; 14 Apr 2021 23:15:11 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     uclinux-dev@uclinux.org, ugerg@linux-m68k.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
Cc:     Max Filippov <jcmvbkbc@gmail.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Anup Patel <anup.patel@wdc.com>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 1/2] binfmt_flat: allow not offsetting data start
Date:   Thu, 15 Apr 2021 15:15:01 +0900
Message-Id: <20210415061502.7248-2-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210415061502.7248-1-damien.lemoal@wdc.com>
References: <20210415061502.7248-1-damien.lemoal@wdc.com>
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
Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
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

