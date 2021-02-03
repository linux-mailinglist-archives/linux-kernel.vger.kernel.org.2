Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D56EC30D7A8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 11:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233857AbhBCKgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 05:36:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233782AbhBCKf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 05:35:59 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8D9C0613ED
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 02:35:18 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id l12so27671516ljc.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 02:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jvFZh+9sq3EVUiluhTslZPK6kn/ZGqF1TeBKf+Rojcw=;
        b=YiILlAmfZ3yy+1B/8bwJ3zLup/iLDn4rbqi25FoNOnOg0bn0iB4io6oVPCZgmSKCGu
         av5hBwJC4n2jKCCA+OuStPnb6TyxQg5Ko3n3WfCCrNMq++8a8kpL/7tRgBqSmtxB9hRX
         mq/DG2kFVJGp8fSASnJfT0Ma5BW6m7aCbTpJATX/jYOx0cy9pYLqA7yaIPgA8UTWNY+j
         iP/Wwa3p86mcyAuUPsAyt899SxH8Bo0dX2T4/w/mT9ltOCPsf19OHHAkHCnx5koCtyxm
         HWbZuU0W7dPfIUfHA1cKxSAqEBjAIKOh3MFJe4fUhoS+4qoqHFpUiQ4S7ndg4eZh2EhJ
         WeZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jvFZh+9sq3EVUiluhTslZPK6kn/ZGqF1TeBKf+Rojcw=;
        b=EcBSzsQRDI3Fis5zhQWPa9/3JkwghtNW2Iv2Vwb3388Fe/123yA+3xD/ykKvrBgYix
         5hWKJxTBwc4igZNQKSqZFbe4YG1F0HgnjN7WoVmAf++anmca3jJ6ziSZg31kneD4j33N
         3+xSCOBmEr0/G5ZifKoDnLR00j7d0GEdA//NKG4Ai9NHWDOBIiy4oS9KhlMeQXa7yEzC
         GEPGeZX+ss/7+tAOIihO0Ai3Y+GNTTsdzekXJw4nClVO8UolbqF0KMtqGG6btgOXM7mz
         GsKZTW7KAvr1b1XnzfwFS7UMbME8N6Fc/Gf1XxRbDeQMy/exUjYPPEU9sSpdxLPSAS0O
         Eq+w==
X-Gm-Message-State: AOAM5308w/2b7jUMzBNxKBmpqZ8tUTDxJZiHodm0OJ0nMJJRt6Crp7I3
        jGoEeShKM7Up2UtwQYns9/WUFZ2J6sf4bXYF
X-Google-Smtp-Source: ABdhPJzuVt4hHInKhBix3eeSvYdG1aAU8uIJMHvVibyL6XIv9gBLN7+as/YfXE0Ba0OjS69589hRDQ==
X-Received: by 2002:a2e:9893:: with SMTP id b19mr1288102ljj.317.1612348517264;
        Wed, 03 Feb 2021 02:35:17 -0800 (PST)
Received: from localhost.localdomain ([146.158.65.228])
        by smtp.googlemail.com with ESMTPSA id f6sm207558lje.127.2021.02.03.02.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 02:35:16 -0800 (PST)
From:   Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To:     phillip@squashfs.org.uk
Cc:     linux-kernel@vger.kernel.org,
        syzbot+2ccea6339d368360800d@syzkaller.appspotmail.com
Subject: [PATCH] fs/squashfs: restrict length of xattr_ids in read_xattr_id_table
Date:   Wed,  3 Feb 2021 16:35:13 +0600
Message-Id: <20210203103513.1510005-1-snovitoll@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot found WARNING in squashfs_read_table [1] when length of xattr_ids
exceeds KMALLOC_MAX_SIZE in squashfs_read_table() for kmalloc().

For other squashfs tables, currently such as boundary is checked with
another table's boundaries. Xattr table is the last one, so there is
no defined limit. But to avoid order >= MAX_ORDER warning condition,
we should restrict SQUASHFS_XATTR_BLOCK_BYTES(*xattr_ids) to
KMALLOC_MAX_SIZE, and it gives 1024 pages in squashfs_read_table via
(length + PAGE_SIZE - 1) >> PAGE_SHIFT.

[1]
Call Trace:
 alloc_pages_current+0x18c/0x2a0 mm/mempolicy.c:2267
 alloc_pages include/linux/gfp.h:547 [inline]
 kmalloc_order+0x2e/0xb0 mm/slab_common.c:916
 kmalloc_order_trace+0x14/0x120 mm/slab_common.c:932
 kmalloc include/linux/slab.h:559 [inline]
 squashfs_read_table+0x43/0x1e0 fs/squashfs/cache.c:413
 squashfs_read_xattr_id_table+0x191/0x220 fs/squashfs/xattr_id.c:81

Reported-by: syzbot+2ccea6339d368360800d@syzkaller.appspotmail.com
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
 fs/squashfs/xattr_id.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/squashfs/xattr_id.c b/fs/squashfs/xattr_id.c
index d99e08464554..6bb51cd3d5c1 100644
--- a/fs/squashfs/xattr_id.c
+++ b/fs/squashfs/xattr_id.c
@@ -78,5 +78,8 @@ __le64 *squashfs_read_xattr_id_table(struct super_block *sb, u64 start,
 
 	TRACE("In read_xattr_index_table, length %d\n", len);
 
+	if (len > KMALLOC_MAX_SIZE)
+		return -ENOMEM;
+
 	return squashfs_read_table(sb, start + sizeof(*id_table), len);
 }
-- 
2.25.1

