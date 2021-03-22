Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6060E343FF3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 12:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhCVLfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 07:35:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:41528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230233AbhCVLei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 07:34:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA9D06198B;
        Mon, 22 Mar 2021 11:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616412878;
        bh=WOJn3MilWpAvLS3chkKdd2cGjmreOdFbGDpQTcekL6k=;
        h=From:To:Cc:Subject:Date:From;
        b=lJSs0aAy+xIkv/NifyM67kYKGfafnVHmdY8oNXXd7mVd7LfBpylUFh7IgFFjgW9AR
         A5MsiQ23qPVM7v7LAMjLCoajVmAd0bPfM7dC9JJSMVnW2uS+xPPCpt9a06Sq+2R041
         xG5ATl8kLn/oMQ/AkDnh9wuN2zE8NoxmIcRMVvykSy9L+BVmDqG2k9XT0xPNcQED1/
         E51Egkp+kICTwFPqZgv13fFb8ckPffG2GxKJCSJXdWDmkd/7fRKcMPqArKBA8lbRoA
         MJI6DdsZ0G9C3/uh7mFTZv+JD7dWANRjZgq5ER1YMdf9ROhEDTaYGx1L9GI1KVGTv5
         Frmnf0XZm0DpQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] jffs2: avoid Wempty-body warnings
Date:   Mon, 22 Mar 2021 12:34:29 +0100
Message-Id: <20210322113434.3068844-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Building with W=1 shows a few warnings for empty macros:

fs/jffs2/scan.c: In function 'jffs2_scan_xattr_node':
fs/jffs2/scan.c:378:66: error: suggest braces around empty body in an 'if' statement [-Werror=empty-body]
  378 |                 jffs2_sum_add_xattr_mem(s, rx, ofs - jeb->offset);
      |                                                                  ^
fs/jffs2/scan.c: In function 'jffs2_scan_xref_node':
fs/jffs2/scan.c:434:65: error: suggest braces around empty body in an 'if' statement [-Werror=empty-body]
  434 |                 jffs2_sum_add_xref_mem(s, rr, ofs - jeb->offset);
      |                                                                 ^
fs/jffs2/scan.c: In function 'jffs2_scan_eraseblock':
fs/jffs2/scan.c:893:88: error: suggest braces around empty body in an 'if' statement [-Werror=empty-body]
  893 |                                 jffs2_sum_add_padding_mem(s, je32_to_cpu(node->totlen));
      |                                                                                        ^

Change all these macros to 'do { } while (0)' statements to avoid the
warnings and make the code a little more robust.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/jffs2/summary.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/jffs2/summary.h b/fs/jffs2/summary.h
index e4131cb1f1d4..36d9a1280770 100644
--- a/fs/jffs2/summary.h
+++ b/fs/jffs2/summary.h
@@ -194,18 +194,18 @@ int jffs2_sum_scan_sumnode(struct jffs2_sb_info *c, struct jffs2_eraseblock *jeb
 
 #define jffs2_sum_active() (0)
 #define jffs2_sum_init(a) (0)
-#define jffs2_sum_exit(a)
+#define jffs2_sum_exit(a) do { } while (0)
 #define jffs2_sum_disable_collecting(a)
 #define jffs2_sum_is_disabled(a) (0)
-#define jffs2_sum_reset_collected(a)
+#define jffs2_sum_reset_collected(a) do { } while (0)
 #define jffs2_sum_add_kvec(a,b,c,d) (0)
-#define jffs2_sum_move_collected(a,b)
+#define jffs2_sum_move_collected(a,b) do { } while (0)
 #define jffs2_sum_write_sumnode(a) (0)
-#define jffs2_sum_add_padding_mem(a,b)
-#define jffs2_sum_add_inode_mem(a,b,c)
-#define jffs2_sum_add_dirent_mem(a,b,c)
-#define jffs2_sum_add_xattr_mem(a,b,c)
-#define jffs2_sum_add_xref_mem(a,b,c)
+#define jffs2_sum_add_padding_mem(a,b) do { } while (0)
+#define jffs2_sum_add_inode_mem(a,b,c) do { } while (0)
+#define jffs2_sum_add_dirent_mem(a,b,c) do { } while (0)
+#define jffs2_sum_add_xattr_mem(a,b,c) do { } while (0)
+#define jffs2_sum_add_xref_mem(a,b,c) do { } while (0)
 #define jffs2_sum_scan_sumnode(a,b,c,d,e) (0)
 
 #endif /* CONFIG_JFFS2_SUMMARY */
-- 
2.29.2

