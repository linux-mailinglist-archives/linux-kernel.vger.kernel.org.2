Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44A2D38AE9B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbhETMmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238187AbhETMl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:41:26 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983F8C0611E9
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:00:52 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id y184-20020a1ce1c10000b02901769b409001so5069058wmg.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nw6y5j8qU4eges0MGOk6KmW889wb/0DapvaK8UiBK7s=;
        b=roecU/drLhH4IFhoHfGwrkR9tJfH5U6k2EwGXuwIZGhrVrKEqNJ8AW3hv0A17+3/XX
         Y7JHqhLSAYYa5zkpQWgjyZ3Gok2OQhQgRCm6Wrqz/fKLw1pi73WLbq/z5dOtoWDYYh4n
         HxXuQh3SRkdSBmbotRXYCy4PH+DrMm3KcV4JYFe+H6h15gZrEtJk011mP7fzxWc7XmKI
         npbrlQNanWVHsOawY12M81yDIESdjPuZtWTI4Lz/eKvGnsEKkmwfsPK+KwiBfQwTUCE6
         m9PTJeAOXhRR4blO0Hk/AqCC1q9u5CVFcyh+nW14NOo0Me55L0rrIoPxggNiGEnA/i78
         Iu3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nw6y5j8qU4eges0MGOk6KmW889wb/0DapvaK8UiBK7s=;
        b=pIpeY1LBWyWOLALiRIl63JTQZYHwVyXfYY8/uupwSEQ0BNaIkCr6hSgZJKljbCDgLV
         1VX1/gGCL46io4wSvZMvZ8bshB4AcmzixQErxqebQpEHvyr76ZxhvAg8tZeDOJy9ldTD
         Yz7r4XZmhn2g6czKz3no8HSpQrcvIXcb+xkmhjISj4HS05OSvJ/klpDt4zVJdSMlpaTB
         NKSEdNnsuYKAgQ0c1eEMGQelYdMgWs+iaSbOgT/uaM8OJisUqEWq8vQ30uySuCTkidTu
         5wq2DYdivse+CkC7QbouomvviTl7psz4YVsU9l56rJaULaAUGEq/9TxiZgW2Agdff9TQ
         1INQ==
X-Gm-Message-State: AOAM5327eM8ReUo1sWPGhK/4RkTQz9ezTOcXi0qgy7BfWXtaS6AV5X8+
        BUKiWfFsqdyC6tNJjNaBO0vvOw==
X-Google-Smtp-Source: ABdhPJxY0Iwx5yvyEzeodlC7iILYo6lkRltYLShJydLnWFBpgu4Q7LYdr7qqpG1Oo8gUwE32WThUFg==
X-Received: by 2002:a1c:c911:: with SMTP id f17mr3340871wmb.45.1621512051157;
        Thu, 20 May 2021 05:00:51 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id s199sm8848269wme.43.2021.05.20.05.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:00:50 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 06/15] fs: ntfs: dir: Supply missing descriptions for 'start' and 'end' and demote other headers
Date:   Thu, 20 May 2021 13:00:34 +0100
Message-Id: <20210520120043.3462759-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520120043.3462759-1-lee.jones@linaro.org>
References: <20210520120043.3462759-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 fs/ntfs/dir.c:21: warning: Incorrect use of kernel-doc format:  * The little endian Unicode string $I30 as a global constant.
 fs/ntfs/dir.c:23: warning: cannot understand function prototype: 'ntfschar I30[5] = '
 fs/ntfs/dir.c:1489: warning: Function parameter or member 'start' not described in 'ntfs_dir_fsync'
 fs/ntfs/dir.c:1489: warning: Function parameter or member 'end' not described in 'ntfs_dir_fsync'
 fs/ntfs/dir.c:1489: warning: Excess function parameter 'dentry' description in 'ntfs_dir_fsync'

Cc: Anton Altaparmakov <anton@tuxera.com>
Cc: linux-ntfs-dev@lists.sourceforge.net
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 fs/ntfs/dir.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/ntfs/dir.c b/fs/ntfs/dir.c
index cd96083a12c8e..35f301313e46b 100644
--- a/fs/ntfs/dir.c
+++ b/fs/ntfs/dir.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/**
+/*
  * dir.c - NTFS kernel directory operations. Part of the Linux-NTFS project.
  *
  * Copyright (c) 2001-2007 Anton Altaparmakov
@@ -17,7 +17,7 @@
 #include "debug.h"
 #include "ntfs.h"
 
-/**
+/*
  * The little endian Unicode string $I30 as a global constant.
  */
 ntfschar I30[5] = { cpu_to_le16('$'), cpu_to_le16('I'),
@@ -1462,7 +1462,8 @@ static int ntfs_dir_open(struct inode *vi, struct file *filp)
 /**
  * ntfs_dir_fsync - sync a directory to disk
  * @filp:	directory to be synced
- * @dentry:	dentry describing the directory to sync
+ * @start:	offset in bytes where the range starts
+ * @end:	offset in bytes where the range ends (inclusive)
  * @datasync:	if non-zero only flush user data and not metadata
  *
  * Data integrity sync of a directory to disk.  Used for fsync, fdatasync, and
-- 
2.31.1

