Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4B140A7EE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 09:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241587AbhINHkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 03:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241592AbhINHkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:40:14 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F864C0613AD
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 00:37:04 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id n18so11906796pgm.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 00:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v0G9QgPg+hfzr8x+8Bx7OvscmO6lHALpSRI/OEyBuHk=;
        b=uATwrDbNiKHs9A7JcSMurQYgFjrqGaAO75qRq8TzmBt1Rpc2g67hGH2yRdHL4jZi4G
         hYnWKMCzOyhKim3DowkY0wtEoLF2nGbkmHrkrR5ZCNto7iZ31dVwTvv3/hGqSgD1On4O
         B0ZV5zdqMy/vIb9hXB4LxN/ZT7qcw3bhzAzXJa9xvIP26Fs0Z8oDVn2uERxib8SKqySV
         l1eNsBvpM1/48WN2d9Cvc6KA5W9rebm12c3l7Gp188hSoC4uzgVZJ5ENUmKoNfO2XC8w
         o29ubWCMaEQEPnOXZEBR+pzVqP9EuZu3b4YQRgUAbJYR7Twx1UOwT1Z04DCXTFSjcOzW
         KviQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v0G9QgPg+hfzr8x+8Bx7OvscmO6lHALpSRI/OEyBuHk=;
        b=ZiOTlNKaxrzWhh2QpvgTbxMBJ9xJ5cQ06TfjOpWv5tc93IBUm3YNK3aSmIfN17qq00
         1nNAcD5AJllF2RFObb6GWVabfwpyVLrgRQu3qI+S5rjtNdV1hRsjE79Mehgv9PCLi3nF
         NB4575/CDYh8vmDGKPDWxpnQKCuARFaMdh4ZVG1P4j9OIcUTE8LX14R7mYHeGSZeOoe+
         6/nxsbCVrqLDsHzrTyxbUUXI1u6iwK0kOpUc9d0WJSnstPmSTRdqdkmAYqdvOTlL05xX
         HcxGdzuUGb1dh51dypJqtOGovlZqOspDCKSiP5I+m7WzyzZZ1uL9ynpffPReYM6hSZ8k
         9vzQ==
X-Gm-Message-State: AOAM531kHwWwHo0EpNEbzLmqAaB3j5bg1hbV9Tlo3ag+mi+hSsNXYPg0
        2De/AQYSJOPMLXQ7McJ8YlghHQ==
X-Google-Smtp-Source: ABdhPJxFZacq7xaIgBaomiZ8xQ8HnyQqJjq+FaOSbVOzDFUzBUGypQEmmhDAS0VvitHHAR9ty4tO1Q==
X-Received: by 2002:a05:6a00:2a2:b0:43d:ea13:9c06 with SMTP id q2-20020a056a0002a200b0043dea139c06mr3386511pfs.37.1631605023758;
        Tue, 14 Sep 2021 00:37:03 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.36.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:37:03 -0700 (PDT)
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
Subject: [PATCH v3 34/76] hostfs: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:28:56 +0800
Message-Id: <20210914072938.6440-35-songmuchun@bytedance.com>
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
 fs/hostfs/hostfs_kern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index d5c9d886cd9f..2123d2bed55b 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -222,7 +222,7 @@ static struct inode *hostfs_alloc_inode(struct super_block *sb)
 {
 	struct hostfs_inode_info *hi;
 
-	hi = kmem_cache_alloc(hostfs_inode_cache, GFP_KERNEL_ACCOUNT);
+	hi = alloc_inode_sb(sb, hostfs_inode_cache, GFP_KERNEL_ACCOUNT);
 	if (hi == NULL)
 		return NULL;
 	hi->fd = -1;
-- 
2.11.0

