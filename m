Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADB13C2C04
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 02:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbhGJAYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 20:24:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:45806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230280AbhGJAYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 20:24:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1B3DA61375;
        Sat, 10 Jul 2021 00:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625876506;
        bh=6rpgsXcYHXTRiRxbsoV4Xmj8XUN/0RGWjpURDGJOTU0=;
        h=From:To:Cc:Subject:Date:From;
        b=khpmeHzHN9ANnhwgb/6Hh+zDei/BGn1Yv6fWJvX9q+xdlxcyuI6aJ0M7MMJ33DFy6
         xMKaA1pmznYabKV1vi96XwpCw6LLEMzrtOWHBJnC/XR2dEsdGctle2dbM0sdMGM9gH
         szJv+Z/b7+yy1f2mTapBPl6L7uwGgPvA0/BmtOtQH0jpnf4qu5ZtY6t7vdvgu1y1Vu
         lVGfQREyLTfsZ+h8AXFShiT97BMhYG+oNgqrmlaOYeSSmRYRIryKlrvi//CztYEk7A
         gt9hAqe2wcnBztBRBDciLTlrUccsEY560yhwScNcxXkgtbxX0BEHfttWWPhCJTLRD9
         j3YLbFmfOj4YQ==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao.yu@linux.dev>,
        Chao Yu <chao@kernel.org>, 5kft <5kft@5kft.org>
Subject: [PATCH] f2fs: compress: fix to set zstd compress level correctly
Date:   Sat, 10 Jul 2021 08:21:41 +0800
Message-Id: <20210710002141.25086-1-chao@kernel.org>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As 5kft reported in [1]:

set_compress_context() should set compress level into .i_compress_flag
for zstd as well as lz4hc, otherwise, zstd compressor will still use
default zstd compress level during compression, fix it.

[1] https://lore.kernel.org/linux-f2fs-devel/8e29f52b-6b0d-45ec-9520-e63eb254287a@www.fastmail.com/T/#u

Fixes: 3fde13f817e2 ("f2fs: compress: support compress level")
Reported-by: 5kft <5kft@5kft.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/f2fs.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 5099652c260b..4bc89dd9487e 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4160,7 +4160,8 @@ static inline void set_compress_context(struct inode *inode)
 				1 << COMPRESS_CHKSUM : 0;
 	F2FS_I(inode)->i_cluster_size =
 			1 << F2FS_I(inode)->i_log_cluster_size;
-	if (F2FS_I(inode)->i_compress_algorithm == COMPRESS_LZ4 &&
+	if ((F2FS_I(inode)->i_compress_algorithm == COMPRESS_LZ4 ||
+		F2FS_I(inode)->i_compress_algorithm == COMPRESS_ZSTD) &&
 			F2FS_OPTION(sbi).compress_level)
 		F2FS_I(inode)->i_compress_flag |=
 				F2FS_OPTION(sbi).compress_level <<
-- 
2.22.1

