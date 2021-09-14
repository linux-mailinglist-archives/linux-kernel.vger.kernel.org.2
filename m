Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC7840A85C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 09:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237157AbhINHqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 03:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233456AbhINHo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:44:57 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F14C0617AE
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 00:40:44 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d17so7593371plr.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 00:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LCwWaL4B2Y5pE/9Q4T3Fxn54/Jx/rWqz+WBfjzit2GM=;
        b=mhdStjDOqRSJkQrrdwVXkGXjVKmevOem1ZTDInLWzcmNqeGwJm2VQX19TPsL1zL43f
         2AjCb4MH6OoEYJQX14SqSruOEC7quL4zifuPxlcC5/O20YbnwUhTQsLGZKbhTiYZmYqn
         s5EK2BNREI6iSxwugCEZBG7auTi6fzFAcaFCtqMJL++xHIFJRVmHlFR+mBQLyzgHZZ52
         euUtJ4O+jTQu+O3POFpUbqno0ZNkGTI/9nyQtHB/6hwqgAdQBKeYld65ISbzW3G6T6dj
         Tks3ZyPskug8Q6GTwD1zAbGdXX66xv5Btdi82RVsBeWh1An8m40/rOUxgbluWjdBDhdz
         JEXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LCwWaL4B2Y5pE/9Q4T3Fxn54/Jx/rWqz+WBfjzit2GM=;
        b=2MKAhU6qT6O3gsULjukCWpYGUOVpyMs+w6vhiVYgRORHQZQpYzADS9WbynZYcCVUBS
         e0WM3InYvr3NWymen5VJngcqqrKFFWZojBvtFtso/M23Uy5L15ihEo2UJnNCf0TF2xSk
         NDlFBUTeRnQjVWl9PlOD/oohn2YwX5JiKtcWPUQ6TEZvX3wg/BhTKC8qOtPskr4MqkCu
         kGM6hpHH9ygvqbbdznmavxkyYksFpjWCscpA3HzG9Mhej6pBpgP4xF5tRlgBMeZ8CVAz
         R1cn3DDio/CNTGRL11X4S4cAq//UMT14p5mKGmrTzV5ymn+PuwjS5qsUgLblmVramtXm
         j5hg==
X-Gm-Message-State: AOAM533Hw3Ctlh8fKfSms01PdRUlJOsXEt/CIk4RCbit7clDJJtKRDkH
        ejkqaTr0b42k1G3d6VpDkSPdmQ==
X-Google-Smtp-Source: ABdhPJwZfRb+vBHxjmhzQv2etUWugNveqRS2L/ODQLoA6V4l5IFWyDxrLgFwb8ZuAlSJAvpkyeeMQw==
X-Received: by 2002:a17:903:1251:b0:13a:1f5e:20da with SMTP id u17-20020a170903125100b0013a1f5e20damr13984599plh.75.1631605244305;
        Tue, 14 Sep 2021 00:40:44 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.40.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:40:44 -0700 (PDT)
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
Subject: [PATCH v3 65/76] f2fs: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:29:27 +0800
Message-Id: <20210914072938.6440-66-songmuchun@bytedance.com>
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
 fs/f2fs/super.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 78ebc306ee2b..20e335f50219 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1306,8 +1306,12 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
 {
 	struct f2fs_inode_info *fi;
 
-	fi = f2fs_kmem_cache_alloc(f2fs_inode_cachep,
-				GFP_F2FS_ZERO, false, F2FS_SB(sb));
+	if (time_to_inject(F2FS_SB(sb), FAULT_SLAB_ALLOC)) {
+		f2fs_show_injection_info(F2FS_SB(sb), FAULT_SLAB_ALLOC);
+		return NULL;
+	}
+
+	fi = alloc_inode_sb(sb, f2fs_inode_cachep, GFP_F2FS_ZERO);
 	if (!fi)
 		return NULL;
 
-- 
2.11.0

