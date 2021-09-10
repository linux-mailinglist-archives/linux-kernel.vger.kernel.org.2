Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F080406B58
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 14:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbhIJM0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 08:26:47 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:39008
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232876AbhIJM0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 08:26:46 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id E2DB53F224;
        Fri, 10 Sep 2021 12:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631276734;
        bh=S5A5gVxFvNReba+sgmKpBhRQvbi0HishvH1Pn0fy9V0=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=v+ZTMRGFzHJB+bxVdKXF4l5ly6MyYjdY8uqXPC7bCBiVzpkLD4lsmVT4k+t424lvI
         ClPHaUSXDEE2YVKE12C5Jyv/Gncqdxrt10t9MwRkdDY8R2xtLSCMloodi96R0oTdQy
         yYurP++OzKFFubBDpvG5trls2dyubFgpqKiPq6djZcDhJSDNuKvCna0YiZp+EEKgXO
         L9hzNfI9GUpmd6fRnR3tEHgtf9zkfQgMjhEoOx2OYFagtR2cqd/jHXwfG8/cBvk9fN
         6nsj+Jmo52yzFLZe5yI5WN5blkz1qSrhRxY+vcW8pgrZYifhTzo0I7chhw1dFx+G33
         VhQwkK5xYiurA==
From:   Colin King <colin.king@canonical.com>
To:     Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        devel@lists.orangefs.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] orangefs: Remove redundant initialization of variable ret
Date:   Fri, 10 Sep 2021 13:25:34 +0100
Message-Id: <20210910122534.51449-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable ret is being initialized with a value that is never read, it
is being updated later on. The assignment is redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/orangefs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/orangefs/super.c b/fs/orangefs/super.c
index 2f2e430461b2..897fb6c3f161 100644
--- a/fs/orangefs/super.c
+++ b/fs/orangefs/super.c
@@ -475,7 +475,7 @@ struct dentry *orangefs_mount(struct file_system_type *fst,
 			   const char *devname,
 			   void *data)
 {
-	int ret = -EINVAL;
+	int ret;
 	struct super_block *sb = ERR_PTR(-EINVAL);
 	struct orangefs_kernel_op_s *new_op;
 	struct dentry *d = ERR_PTR(-EINVAL);
-- 
2.32.0

