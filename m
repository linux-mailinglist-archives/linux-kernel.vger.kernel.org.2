Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83751445299
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 13:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbhKDMGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 08:06:13 -0400
Received: from nautica.notk.org ([91.121.71.147]:34255 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229505AbhKDMGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 08:06:12 -0400
Received: by nautica.notk.org (Postfix, from userid 108)
        id 94EECC01B; Thu,  4 Nov 2021 13:03:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1636027413; bh=xEp8eFxtEqQ43xgpMlcvKwbaMDG5dHvhWTnvg8NkLBw=;
        h=From:To:Cc:Subject:Date:From;
        b=DBioh2kBx6je4xU5+OgqXNFWzSjw79Xsx0zjPANwMBeA2Ng2KvVEf62E3GRbKHMYn
         aZgPaHFw/JJxOUfwpqdhrSJTEg7KC0K3tarzpjrwU9W9u//kTXKR6+wJ5IabYj9c05
         KFHm87wASIlDv+SNer4blwYIbBudpRnRYKGwiIngpQnyq0+xxToiXCBrL9dc66JGFI
         OeLCuZpUifIGL7IfkG8bt+L/BLT4YsXDdpR6HdBnuT/qydd7HfoNLwz1rTSQhD09ft
         s3q4Pc0GCiyEHq5sRz7h6Tq+Mu6BJrGEBEJBbrYSMyugLkaA8PxHpXnlaSTmBKqnMg
         d6igRQkCvyg3w==
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on nautica.notk.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=UNPARSEABLE_RELAY
        autolearn=unavailable version=3.3.2
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 2F842C009;
        Thu,  4 Nov 2021 13:03:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1636027412; bh=xEp8eFxtEqQ43xgpMlcvKwbaMDG5dHvhWTnvg8NkLBw=;
        h=From:To:Cc:Subject:Date:From;
        b=HiYHZzGwd0llRNmCIWnxzCGSuip8RAMEY2pKPvXvtE+nHShoQBGO5TKng2Ls+KWhA
         nj10x0d4LTLtGvpn819JD3JVlB6OXovKoZAUCueEY784x168gwJPX/mU2YIBO37MDb
         d8WOarI02Pb2G7lS6AgAOzAbU0lLss1aoxNh6r6rBA6Ph+2sN5Nrm6Ci9GJQ9QnH0X
         z0bmYtkRiZkcscOOwXx/n5eurvXu3kIptQaCxY9UwPFW4dcIqPeDjhnCNGTcDmwqJy
         ygqbmWKT5KyA8aXhbwyf6zRej+Hsi6w+goOCNv4oxN7QWNfor3poDIBcYLp4pBbM9t
         /HNuxPGK59LGg==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id ffda33dd;
        Thu, 4 Nov 2021 12:03:27 +0000 (UTC)
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     v9fs-developer@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, Latchesar Ionkov <lucho@ionkov.net>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH] 9p: set readahead and io size according to maxsize
Date:   Thu,  4 Nov 2021 21:03:23 +0900
Message-Id: <20211104120323.2189376-1-asmadeus@codewreck.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

having a readahead of 128k with a msize of 128k (with overhead) lead to
reading 124+4k everytime, making two roundtrips needlessly.

tune readahead according to msize when cache is enabled for better
performance

Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
 fs/9p/vfs_super.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index c6028af51925..b0632f4e337f 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -79,6 +79,9 @@ v9fs_fill_super(struct super_block *sb, struct v9fs_session_info *v9ses,
 	if (!v9ses->cache) {
 		sb->s_bdi->ra_pages = 0;
 		sb->s_bdi->io_pages = 0;
+	} else {
+		sb->s_bdi->ra_pages = v9ses->maxdata >> PAGE_SHIFT;
+		sb->s_bdi->io_pages = v9ses->maxdata >> PAGE_SHIFT;
 	}
 
 	sb->s_flags |= SB_ACTIVE | SB_DIRSYNC;
-- 
2.31.1

