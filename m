Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D00B6356B9C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 13:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351932AbhDGL5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 07:57:12 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:26386 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351925AbhDGL5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 07:57:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1617796621; x=1649332621;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TyfOh8mJ7OPn6qhfH6Ryl1SvZ+awCxnRWrTwDJ9ElKQ=;
  b=IN4/A6HW1bEe3qz5a4HVFruResBfMTDxuJTJcT+iEeym/N9UMT9osIGA
   kvNVaREHAcEvth+zsEKLpxD15+0dm3lrGszQZg935k0EU/p1ilgxtr1/+
   ITQTZdcNpibHbl0nGk27GIkKNpoFSSF0RNXR3/mGtC3Wfykt447udqmQP
   6VUT1Jm/muVWNbvZgeh2Vwvl/pcCrOS7FuNKITLp55KTPnbnr/Kmv0Y9f
   Mmhuv+AQ6bJTch/sOtTtd/gGC9IOAxgTE46PVwENnAKiQ5XJ8m8y7/L0L
   10fu30S8v5Rj3zZAtiU2WtzUQlkv4EoMq0No3pY1pEtouuCV/wCodrQJv
   A==;
IronPort-SDR: fepby/UFf/ANbqAkLj37c7TTSw/xC/bOa2PYtAXGf2C5/OlT9XNKlrfn23S/ip6FoWIshodqPr
 h5RNAWwfZFokVFmxkss+55eqqLHf2QPui9RmBJ8X0mZJnGcXGsZce6urlr77fbXfVMQFlFkNdO
 xbBPOcfwuwbWX7MbvcsuKe88jojXowz3/5Kb+qD2BLlLAt1XqwR2C/oW5hSuGIdTfg+2HmAAWC
 W564e7Kmnmnpqfq696Dh7Nq9xyf6F8WoXWad5dxftoBJ32SpKUvF43ZOpij85k2hfHN1UGjicX
 UUc=
X-IronPort-AV: E=Sophos;i="5.82,203,1613404800"; 
   d="scan'208";a="164998595"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Apr 2021 19:56:53 +0800
IronPort-SDR: uQD/n7QgPB6iB5sJJTgW5PDETJrB0mXZgIepjJ3bliwyXzC3kgRSAIRbf+lOsKUE2yohUE5nbU
 /Xr0SdlQVU8L2ZO72NIXPLjLJo2QgBYU+MMXMwbXcEmpyQz77rEhbQ+JQ8G5WR8urU5swQyzkk
 pryMiO3s1o+addDEVjRMW/RD1ii3AVNno0r4RkY9NccHBIMtOr1XDq+1JW7CNqupTP8o9i5jgu
 o5zoi3hAGO+6Ho076J542VVlYhTWy6xE122DKcHGSKP1HcuwplKAf5VNHSpnOFkwfiCJb5mEcE
 K2FNB7qfEV2evPm9/6vlNWW5
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 04:36:30 -0700
IronPort-SDR: vvzMd1q7ccIG2Fj24WATyo39smazcLM+7q6JNW/spiaEZLmVJJUp5t73mIwIMZ6RCmoxoj1IEW
 ZJXBdOmPgEN9QD7VDjxuh+8ZCMP5tBBwuQttdhzQOMpHIYqRcBO+STn1zczJcbdlTXtv5qFY5B
 T82CXEgiNkSu6CywTyCoSqjBdU0ypnibeohraiigdxAgBW490UYvoz9SXiormPT0/0qhI9gSbB
 C9fU9vnEQpSX/ce7x7eaVwTW4phW3R5hSVgPtbFJoDXq5+hMxE+TkAlzsu8sn8UTi/TncktR9q
 MSA=
WDCIronportException: Internal
Received: from unknown (HELO twashi.fujisawa.hgst.com) ([10.225.163.90])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Apr 2021 04:56:45 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
Cc:     Max Filippov <jcmvbkbc@gmail.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Anup Patel <anup.patel@wdc.com>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/2] binfmt_flat: allow not offsetting data start
Date:   Wed,  7 Apr 2021 20:56:37 +0900
Message-Id: <20210407115638.1055824-2-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210407115638.1055824-1-damien.lemoal@wdc.com>
References: <20210407115638.1055824-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 2217b9826246 ("binfmt_flat: revert "binfmt_flat: don't offset
the data start"") restored offsetting the start of the data section by
a number of words defined by MAX_SHARED_LIBS. As a result, since
MAX_SHARED_LIBS is never 0, a gap between the text and data sections
always exist. For architecture which cannot support a such gap between
the text and data sections (e.g. riscv nommu), flat binary programs
cannot be executed.

To allow an architecture to request contiguous text and data sections,
introduce the macro FLAT_TEXT_DATA_NO_GAP which can be defined by the
architecture in its asm/flat.h file. With this change, the macro
DATA_GAP_WORDS is conditionally defined in binfmt_flat.c to
MAX_SHARED_LIBS for architectures tolerating the gap
(FLAT_TEXT_DATA_NO_GAP undefined case) and to 0 when
FLAT_TEXT_DATA_NO_GAP is defined. DATA_GAP_WORDS is used in
load_flat_file() to calculate the data section length and start
position.

The definition of FLAT_TEXT_DATA_NO_GAP by an architecture also
prevents the use of the separate text/data load case (when
FLAT_FLAG_RAM and FLAT_FLAG_GZIP are not set with NOMMU kernels).

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 fs/binfmt_flat.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
index b9c658e0548e..2bfa05ac5cb4 100644
--- a/fs/binfmt_flat.c
+++ b/fs/binfmt_flat.c
@@ -74,6 +74,12 @@
 #define	MAX_SHARED_LIBS			(1)
 #endif
 
+#ifdef FLAT_TEXT_DATA_NO_GAP
+#define DATA_GAP_WORDS			(0)
+#else
+#define DATA_GAP_WORDS			(MAX_SHARED_LIBS)
+#endif
+
 struct lib_info {
 	struct {
 		unsigned long start_code;		/* Start of text segment */
@@ -437,7 +443,6 @@ static int load_flat_file(struct linux_binprm *bprm,
 	__be32 __user *reloc;
 	u32 __user *rp;
 	int i, rev, relocs;
-	loff_t fpos;
 	unsigned long start_code, end_code;
 	ssize_t result;
 	int ret;
@@ -560,6 +565,9 @@ static int load_flat_file(struct linux_binprm *bprm,
 	 * it all together.
 	 */
 	if (!IS_ENABLED(CONFIG_MMU) && !(flags & (FLAT_FLAG_RAM|FLAT_FLAG_GZIP))) {
+#ifndef FLAT_TEXT_DATA_NO_GAP
+		loff_t fpos;
+
 		/*
 		 * this should give us a ROM ptr,  but if it doesn't we don't
 		 * really care
@@ -576,7 +584,7 @@ static int load_flat_file(struct linux_binprm *bprm,
 			goto err;
 		}
 
-		len = data_len + extra + MAX_SHARED_LIBS * sizeof(unsigned long);
+		len = data_len + extra + DATA_GAP_WORDS * sizeof(unsigned long);
 		len = PAGE_ALIGN(len);
 		realdatastart = vm_mmap(NULL, 0, len,
 			PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE, 0);
@@ -591,7 +599,7 @@ static int load_flat_file(struct linux_binprm *bprm,
 			goto err;
 		}
 		datapos = ALIGN(realdatastart +
-				MAX_SHARED_LIBS * sizeof(unsigned long),
+				DATA_GAP_WORDS * sizeof(unsigned long),
 				FLAT_DATA_ALIGN);
 
 		pr_debug("Allocated data+bss+stack (%u bytes): %lx\n",
@@ -620,9 +628,14 @@ static int load_flat_file(struct linux_binprm *bprm,
 			(datapos + (ntohl(hdr->reloc_start) - text_len));
 		memp = realdatastart;
 		memp_size = len;
+#else
+		pr_err("Separate text/data loading not supported\n");
+		ret = -ENOEXEC;
+		goto err;
+#endif /* FLAT_TEXT_DATA_NO_GAP */
 	} else {
 
-		len = text_len + data_len + extra + MAX_SHARED_LIBS * sizeof(u32);
+		len = text_len + data_len + extra + DATA_GAP_WORDS * sizeof(u32);
 		len = PAGE_ALIGN(len);
 		textpos = vm_mmap(NULL, 0, len,
 			PROT_READ | PROT_EXEC | PROT_WRITE, MAP_PRIVATE, 0);
@@ -638,7 +651,7 @@ static int load_flat_file(struct linux_binprm *bprm,
 
 		realdatastart = textpos + ntohl(hdr->data_start);
 		datapos = ALIGN(realdatastart +
-				MAX_SHARED_LIBS * sizeof(u32),
+				DATA_GAP_WORDS * sizeof(u32),
 				FLAT_DATA_ALIGN);
 
 		reloc = (__be32 __user *)
@@ -714,7 +727,7 @@ static int load_flat_file(struct linux_binprm *bprm,
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

