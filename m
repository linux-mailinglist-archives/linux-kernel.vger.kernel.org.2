Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89E3D40A816
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 09:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbhINHmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 03:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241648AbhINHmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:42:20 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43EDC0611BE
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 00:38:37 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id nn5-20020a17090b38c500b0019af1c4b31fso1278804pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 00:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Qc/LiwupPFvLM5PjYz1016FD4bXKawBQsMG6Y+2qQc=;
        b=Vt4T+99aUqqmK/2gRbOdiuTv8LFaIEnqMYscXlXYrrXZ9klxmtSKfdh8ea2MgqYSfO
         NnQS/Nsp4yjEsHeMD1eoI39VwM+q+33icicv11HpoRFb92fPs0y5B0jTlqWXyroZTm5L
         27H0F/8ukxcLz+lzc4pkfDte0ofTVl1cM+AZck8nCWhKYWVMqez2otMrz/VdanyIjf6P
         6QRsryXSIR/it0XwcnDjVH9lS5nRcQ/gs/WzzyXrch/ehXNE2TQHcyzBGMzZgNgibUfn
         3a5saAN504MO3x0ZUlQR+AfRVeUKFLc+Up+oi5X5/beXqlWX1B/omQF66oO0u6ztjAJW
         zhzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Qc/LiwupPFvLM5PjYz1016FD4bXKawBQsMG6Y+2qQc=;
        b=sSxyr9cuTdoe8jujhnbeKzipKgrtjzm8FQgHPMJEAo7UolbKB6fxQ/0T2fk9h7UMZr
         aq/66qn2mIoTbfkCJAMfVbDRiVe0hsIWXbXsbxn/ityHYfdfadhDndJkI6vwARji+jWh
         I31sQZ14yHCnWn4hm4u8jFse9M7OAyJhPndIKKFfmXm0G8cU4NsYO40UwR6OTA2GXY0H
         6MC539enBcW68nN2phNlzKlcCezk088+OFRYZjVY+86WcUdHhTgF8hARGdJ7Tu9h4OIp
         aFfuf7LQ/c6b8gHHruueaf2+xpRPEQwQNQqNem6H2+md6yMimlu0seAbAeyy0gJJ2xSD
         HRpw==
X-Gm-Message-State: AOAM5313dp6unQ24+vW8sEF4EbYxf/WHGBLl8762rzRRlUw/cS1c//B2
        SHFzKc8yLJsTlKKJDVW+yBcYTA==
X-Google-Smtp-Source: ABdhPJwnBjb+nXzxqyWjL0Fk9lx/rUaL7hrM3TuzCo/oPyxIZ3sIl5O4e3jS1LKm/iLzXYJDQo/5GA==
X-Received: by 2002:a17:902:e0c1:b0:13b:76f5:c3b4 with SMTP id e1-20020a170902e0c100b0013b76f5c3b4mr13740150pla.85.1631605117505;
        Tue, 14 Sep 2021 00:38:37 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.38.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:38:37 -0700 (PDT)
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
Subject: [PATCH v3 47/76] overlayfs: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:29:09 +0800
Message-Id: <20210914072938.6440-48-songmuchun@bytedance.com>
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
 fs/overlayfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 178daa5e82c9..0e2a38a0b857 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -174,7 +174,7 @@ static struct kmem_cache *ovl_inode_cachep;
 
 static struct inode *ovl_alloc_inode(struct super_block *sb)
 {
-	struct ovl_inode *oi = kmem_cache_alloc(ovl_inode_cachep, GFP_KERNEL);
+	struct ovl_inode *oi = alloc_inode_sb(sb, ovl_inode_cachep, GFP_KERNEL);
 
 	if (!oi)
 		return NULL;
-- 
2.11.0

