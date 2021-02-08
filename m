Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 078C6312B5D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 09:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbhBHIB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 03:01:28 -0500
Received: from outbound-gw.openxchange.ahost.me ([94.136.40.163]:51106 "EHLO
        outbound-gw.openxchange.ahost.me" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230104AbhBHIBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 03:01:09 -0500
Received: from localhost ([127.0.0.1] helo=outbound-gw.openxchange.ahost.me)
        by outbound-gw.openxchange.ahost.me with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1l9146-0007w8-2z; Mon, 08 Feb 2021 07:34:34 +0000
Date:   Mon, 8 Feb 2021 07:34:33 +0000 (GMT)
From:   Phillip Lougher <phillip@squashfs.org.uk>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Message-ID: <344389784.754551.1612769674031@webmail.123-reg.co.uk>
Subject: [PATCH V2 1/4] Squashfs: avoid out of bounds writes in
 decompressors
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.3-Rev30
X-Originating-IP: 82.69.79.175
X-Originating-Client: com.openexchange.ox.gui.dhtml
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a regression introduced by the patch "migrate from ll_rw_block
usage to BIO".

Sysbot/Syskaller has reported a number of "out of bounds writes" and
"unable to handle kernel paging request in squashfs_decompress" errors
which have been identified as a regression introduced by the above patch.

Specifically, the patch removed the following sanity check

if (length < 0 || length > output->length ||
		(index + length) > msblk->bytes_used)

This check did two things:

1. It ensured any reads were not beyond the end of the filesystem

2. It ensured that the "length" field read from the filesystem
   was within the expected maximum length.  Without this any
   corrupted values can over-run allocated buffers.

Reported-by: syzbot+6fba78f99b9afd4b5634@syzkaller.appspotmail.com
Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>
Cc: stable@vger.kernel.org
---
 fs/squashfs/block.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/squashfs/block.c b/fs/squashfs/block.c
index 8a19773b5a0b..45f44425d856 100644
--- a/fs/squashfs/block.c
+++ b/fs/squashfs/block.c
@@ -196,9 +196,15 @@ int squashfs_read_data(struct super_block *sb, u64 index, int length,
 		length = SQUASHFS_COMPRESSED_SIZE(length);
 		index += 2;
 
-		TRACE("Block @ 0x%llx, %scompressed size %d\n", index,
+		TRACE("Block @ 0x%llx, %scompressed size %d\n", index - 2,
 		      compressed ? "" : "un", length);
 	}
+	if (length < 0 || length > output->length ||
+			(index + length) > msblk->bytes_used) {
+		res = -EIO;
+		goto out;
+	}
+
 	if (next_index)
 		*next_index = index + length;
 
-- 
2.20.1
