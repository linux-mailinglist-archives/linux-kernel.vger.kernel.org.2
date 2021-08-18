Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB2683F0DFB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 00:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234436AbhHRWTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 18:19:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:48186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234537AbhHRWTR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 18:19:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A9B766103A;
        Wed, 18 Aug 2021 22:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629325122;
        bh=KOCNCGojM0O4SwxHOYxviS4ZUt0Y0JF+AQd++GCqAlI=;
        h=Date:From:To:Cc:Subject:From;
        b=SFp6eQ+6hDi/yXdwmyXgKyDYTQ9ioFLmFf+oqJ9DITCzQey1WzJm72NBrJ7U1RyW3
         E+ZUY+m10ivFV+wzX0LtnY5YrlQlP+HdTUFRhuS2AflluOog4FQmGxZ24AYZjtXU3g
         sab8Xd/qC5/C8fTgOHLzSGbev52KgVON6AE9oxJV+vaOuRmtlMkf7OBMCud/TIDbLK
         JJj5SPKneo0Q57QnXbBjj+ZojpSbke4PvXGdaFL551kwNyOqtTbcmKVou01k+9raPQ
         wW4tcAPxDCtd5/dFT23V4jjn1ETRSpD13NzijwGjriLpBCESnq0VlbFty3a/rDFo3m
         6Wg4lbsSeqtWw==
Date:   Wed, 18 Aug 2021 17:21:46 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] fs/ntfs3: Fix fall-through warnings for Clang
Message-ID: <20210818222146.GA312859@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following fallthrough warnings:

fs/ntfs3/inode.c:1792:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
fs/ntfs3/index.c:178:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]

This helps with the ongoing efforts to globally enable
-Wimplicit-fallthrough for Clang.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 fs/ntfs3/index.c | 1 +
 fs/ntfs3/inode.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 6aa9540ece47..76eae60b7fce 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -175,6 +175,7 @@ static inline NTFS_CMP_FUNC get_cmp_func(const struct INDEX_ROOT *root)
 		default:
 			break;
 		}
+		break;
 	default:
 		break;
 	}
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index bf51e294432e..a573c6e98cb8 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -1789,6 +1789,7 @@ int ntfs_unlink_inode(struct inode *dir, const struct dentry *dentry)
 	switch (err) {
 	case 0:
 		drop_nlink(inode);
+		break;
 	case -ENOTEMPTY:
 	case -ENOSPC:
 	case -EROFS:
-- 
2.27.0

