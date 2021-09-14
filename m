Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26FDD40A7B0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 09:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241223AbhINHhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 03:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241201AbhINHhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:37:12 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876E2C0613A6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 00:34:58 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id 5so7596276plo.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 00:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ngaq8HeXVg0bDvfdB7FNpFgH1Z9L4n9AUAaT+A4ybEY=;
        b=TxlM/LNag+9j+pHHnzYxUIcqTnlG8CAktsmrXO0thXlgjt/0xKpEydfDbhVIhyLlSb
         8yaYLg0UVhsiS0IwI3D60wScJOYPe1zGXz1U4suUJ+i/6kRKVhMTFdS8ckWexTA4EE8h
         QEQyxDPXEneT65b4sX+iNOkGENj27L7Kwcfw3Y/ZG6i4O76WdoUR05MkcXlpMHaATepI
         4bx70VoM3TP7FMg4DKmNTasIjpr6AutJjLhrZtyNJyGSIDlLVAovGaPfa/HNI2TpR4Ae
         bQbYTzgj4IThGaUi5gXbrxK+V+eg2xuZdXHAOCxucXaqXGVpbLtTzUvJmXX4EK4DfMmn
         xE/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ngaq8HeXVg0bDvfdB7FNpFgH1Z9L4n9AUAaT+A4ybEY=;
        b=HjtNXz2wy5dP4uNAfjpw/xixkP5UMYaHnUt6gI+UtZwTLx8K+qAsreoMUc1ThhgNdo
         cYJh5AKH3XFbSM9yMLQWM1JEPl19LshNLdmhxgxha7kVCvU/NR14p3u73Cwf2ajus6e+
         3SUnE95d6gh5OqnJYveB8VlIZru63a3E4NohVr/L6TJG41peZvTy4J5Tv+GzTcZlZQ7N
         KSTzAJTGMHOOtwvBz/WNmRPNUqzOPmz8X0WK9+CGWEhg8VPq84xfBs+ZHc9eMy2GYIbI
         boqxG9+9wfd2yonNIkYwpLocpqa0aeehJ1z9V6i2Ok3ANipcHNbJIZauFJHOuoO3z/x8
         5+Fw==
X-Gm-Message-State: AOAM531SZm35srRV7dy16MR/pKgFE6x9mWVrk8kz5RYZb9+Wa8/dYwTV
        PmBGMu71mPqtq3lU7g8y194rvw==
X-Google-Smtp-Source: ABdhPJyCiB4o0BV2SmG7F/g3um9IpNXO0UQAa8xTk2H4jdGoOJfauoZeyXj54vI3CCV0Vr4LlpBBNA==
X-Received: by 2002:a17:90a:bd08:: with SMTP id y8mr523956pjr.123.1631604898107;
        Tue, 14 Sep 2021 00:34:58 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.34.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:34:57 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     willy@infradead.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        guro@fb.com, shy828301@gmail.com, alexs@kernel.org,
        richard.weiyang@gmail.com, david@fromorbit.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        zhengqi.arch@bytedance.com, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 17/76] block: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:28:39 +0800
Message-Id: <20210914072938.6440-18-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210914072938.6440-1-songmuchun@bytedance.com>
References: <20210914072938.6440-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The inode allocation is supposed to use alloc_inode_sb(), so convert
kmem_cache_alloc() to alloc_inode_sb().

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 fs/block_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 45df6cbccf12..1630458b3e98 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -799,7 +799,7 @@ static struct kmem_cache * bdev_cachep __read_mostly;
 
 static struct inode *bdev_alloc_inode(struct super_block *sb)
 {
-	struct bdev_inode *ei = kmem_cache_alloc(bdev_cachep, GFP_KERNEL);
+	struct bdev_inode *ei = alloc_inode_sb(sb, bdev_cachep, GFP_KERNEL);
 
 	if (!ei)
 		return NULL;
-- 
2.11.0

