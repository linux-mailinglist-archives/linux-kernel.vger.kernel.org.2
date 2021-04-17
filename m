Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7ED362C9E
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 03:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235415AbhDQBKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 21:10:45 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:36051 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235334AbhDQBKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 21:10:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618621818; x=1650157818;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ONje5diYFTfuoHw7Q91T2ek/0x57ALfBBrINovIdSps=;
  b=VUlF9+Q1HO/FLl853hdYrjcl6+ERfeOownElhcDD1c4nlKd3c+zx/K+i
   Hn0gSrF5vuvMgP4zA/nX3SO70x5X85HYFBM0evuKFLJNcd+3je6QZ2ZKF
   Lrx0GFJoH4mDa5jlju7qDPMXqlxaQX+dxoL8ioETxTDH5Elg0T91EF5Dv
   DkfKVqvSqx8c1ogkLrFAwhBK4vKn1uVt6ZN5NTgQqkWIA9VL4GsFGkfz2
   LMFULZSZPs+DXO7wkERocyfIaNuKnItWHFmcNqyVPVIwdRuOujpXP1/DQ
   3R5/RMMk5LR8RBlRwM+xo7x67Yb6dS2iQPDLA3h4nLuIyvLblZ1Px+DMs
   g==;
IronPort-SDR: 37Z4wWjoehYYmIqBL2KYU+2zZElTalRREsBvlD5Y9YCoeSRysyQBvQEdq2ooSQJisxhzHGchkf
 iHzY1yjI0TOEcUbo18EWDveDeH8wAL9e1/dco0DjQpO+v/FsLzxKlL2XDGR+kZwMDFceNWsvgs
 D5GojeZUy9Nhc5AE61E04a2cehqJacGxXR8pdu7QyJYh6YiVmeEuOLkwiiKot5Ca7ogrRpBzTi
 AHYY9CAsqXXMAbwfDDnT+Q4sjJQmW7cb2v94A+hoAHA3fM89+mlRrRqO+iQ/KNbSGn/aHLvl2l
 ihY=
X-IronPort-AV: E=Sophos;i="5.82,228,1613404800"; 
   d="scan'208";a="165185058"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Apr 2021 09:10:17 +0800
IronPort-SDR: ab2CEn8g67/KRhTNEqv7JVfR/IyYydtPYHtdTQuUteJXrhEnWu0tCKGqSP+UG9aI1ArXY/SP6A
 2GBlVaRyHF1nFcU5kHIlO6CMx6cdbhhASweYpJpj7mg0/8rEw2dKCBDJdXakn6Okkw7QBy7TxB
 s/qfo1KNbuOKkc43N6rUvu9P0FUOxLfzfu1u2pZUeyKFVFtZcYz1JxFj5dnxfykVzgXziwQjCf
 OqiQKu5dryLOHyI1phzHLIhh5B4yT0Wb5703d6c779v5229VdnhpGMKiqD/e7hlFi3DG7SCF+Q
 dhK6jGpyWF1+krHR1a4yKKJ7
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 17:51:06 -0700
IronPort-SDR: /Mpcyl00NWrrMVw8jjb+KQQpaXYt2uHMvilpjvH+sh0oGNKNXGXWtcNNdz5nIzOnFpY1ENd+iI
 um12RaVkSGx8uC/+4QWQG2o/14uHCMNJbfE37OCBdAdYc4cO7YCQhRBHlEbjl8Jivvl5C+4Hqd
 008sngSKp6/xskw9zNJsYd2wOOh78pW9QWpzdRIqvqeOZFKWhKurLQ6p3vHAK2C7vNp/4mHDAY
 LMxqPyoCGgfoY2ZlOTFY3iSMbEGnxnYXIiKkK4qRMj8czsWvffQVF3EEgS8Su+i8xIrv/Iqr/3
 T7Q=
WDCIronportException: Internal
Received: from unknown (HELO twashi.fujisawa.hgst.com) ([10.225.163.5])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Apr 2021 18:10:17 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     uclinux-dev@uclinux.org, Greg Ungerer <gerg@linux-m68k.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Anup Patel <anup.patel@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v4 1/2] binfmt_flat: allow not offsetting data start
Date:   Sat, 17 Apr 2021 10:10:08 +0900
Message-Id: <20210417011009.54569-2-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210417011009.54569-1-damien.lemoal@wdc.com>
References: <20210417011009.54569-1-damien.lemoal@wdc.com>
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

To allow an architecture to request no data start offset to allow for
contiguous text and data sections for binaries flagged with
FLAT_FLAG_RAM, introduce the new config option
CONFIG_BINFMT_FLAT_NO_DATA_START_OFFSET. Using this new option, the
macro DATA_START_OFFSET_WORDS is conditionally defined in binfmt_flat.c
to MAX_SHARED_LIBS for architectures tolerating or needing the data
start offset (CONFIG_BINFMT_FLAT_NO_DATA_START_OFFSET disabled case)
and to 0 when CONFIG_BINFMT_FLAT_NO_DATA_START_OFFSET is enabled.
DATA_START_OFFSET_WORDS is used in load_flat_file() to calculate the
data section length and start position.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 fs/Kconfig.binfmt |  3 +++
 fs/binfmt_flat.c  | 19 ++++++++++++++-----
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
index c6f1c8c1934e..06fb7a93a1bd 100644
--- a/fs/Kconfig.binfmt
+++ b/fs/Kconfig.binfmt
@@ -112,6 +112,9 @@ config BINFMT_FLAT_ARGVP_ENVP_ON_STACK
 config BINFMT_FLAT_OLD_ALWAYS_RAM
 	bool
 
+config BINFMT_FLAT_NO_DATA_START_OFFSET
+	bool
+
 config BINFMT_FLAT_OLD
 	bool "Enable support for very old legacy flat binaries"
 	depends on BINFMT_FLAT
diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
index b9c658e0548e..1dc68dfba3e0 100644
--- a/fs/binfmt_flat.c
+++ b/fs/binfmt_flat.c
@@ -74,6 +74,12 @@
 #define	MAX_SHARED_LIBS			(1)
 #endif
 
+#ifdef CONFIG_BINFMT_FLAT_NO_DATA_START_OFFSET
+#define DATA_START_OFFSET_WORDS		(0)
+#else
+#define DATA_START_OFFSET_WORDS		(MAX_SHARED_LIBS)
+#endif
+
 struct lib_info {
 	struct {
 		unsigned long start_code;		/* Start of text segment */
@@ -560,6 +566,7 @@ static int load_flat_file(struct linux_binprm *bprm,
 	 * it all together.
 	 */
 	if (!IS_ENABLED(CONFIG_MMU) && !(flags & (FLAT_FLAG_RAM|FLAT_FLAG_GZIP))) {
+
 		/*
 		 * this should give us a ROM ptr,  but if it doesn't we don't
 		 * really care
@@ -576,7 +583,8 @@ static int load_flat_file(struct linux_binprm *bprm,
 			goto err;
 		}
 
-		len = data_len + extra + MAX_SHARED_LIBS * sizeof(unsigned long);
+		len = data_len + extra +
+			DATA_START_OFFSET_WORDS * sizeof(unsigned long);
 		len = PAGE_ALIGN(len);
 		realdatastart = vm_mmap(NULL, 0, len,
 			PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE, 0);
@@ -591,7 +599,7 @@ static int load_flat_file(struct linux_binprm *bprm,
 			goto err;
 		}
 		datapos = ALIGN(realdatastart +
-				MAX_SHARED_LIBS * sizeof(unsigned long),
+				DATA_START_OFFSET_WORDS * sizeof(unsigned long),
 				FLAT_DATA_ALIGN);
 
 		pr_debug("Allocated data+bss+stack (%u bytes): %lx\n",
@@ -622,7 +630,8 @@ static int load_flat_file(struct linux_binprm *bprm,
 		memp_size = len;
 	} else {
 
-		len = text_len + data_len + extra + MAX_SHARED_LIBS * sizeof(u32);
+		len = text_len + data_len + extra +
+			DATA_START_OFFSET_WORDS * sizeof(u32);
 		len = PAGE_ALIGN(len);
 		textpos = vm_mmap(NULL, 0, len,
 			PROT_READ | PROT_EXEC | PROT_WRITE, MAP_PRIVATE, 0);
@@ -638,7 +647,7 @@ static int load_flat_file(struct linux_binprm *bprm,
 
 		realdatastart = textpos + ntohl(hdr->data_start);
 		datapos = ALIGN(realdatastart +
-				MAX_SHARED_LIBS * sizeof(u32),
+				DATA_START_OFFSET_WORDS * sizeof(u32),
 				FLAT_DATA_ALIGN);
 
 		reloc = (__be32 __user *)
@@ -714,7 +723,7 @@ static int load_flat_file(struct linux_binprm *bprm,
 			ret = result;
 			pr_err("Unable to read code+data+bss, errno %d\n", ret);
 			vm_munmap(textpos, text_len + data_len + extra +
-				MAX_SHARED_LIBS * sizeof(u32));
+				  DATA_START_OFFSET_WORDS * sizeof(u32));
 			goto err;
 		}
 	}
-- 
2.30.2

