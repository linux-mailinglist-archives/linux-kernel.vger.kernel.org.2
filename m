Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5EC40A7B9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 09:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241010AbhINHiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 03:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241028AbhINHhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:37:38 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8324C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 00:35:26 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id v19so5562379pjh.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 00:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yn4GjbGKOalkp7KyXghKb9kUqc+WdE7xPBBNtSw49kg=;
        b=npB+pVn/vbn0eNYwtlSthJv7NBkOrOYMdLVzNAnEHX0BsO73iZoa66jGaFaG5addC0
         cgJiTpm3Pv92k7hEjsZ05n4vWim9yUjZaflyMTHnB+SIxMH42+iuoY6FtWyfDm6T6uZM
         /SvJYTj0xZW4myvwa7ToEcgOpprF6LR7VMWYknvR26p0Qu6ZqxtY5e15cZta8W3aeblP
         Pu8Gyt1UcMCae2DKj9uC8co129TdSbpSUsUFBHsAv3ASerGOo92IyrNVp7P5ai0EDton
         KJkkOJDmM35KKrYqDrF7k790Srij5c5bn1mgnYI3eLrodF7RbhmMbZFUPZCbau4exCN+
         lHWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yn4GjbGKOalkp7KyXghKb9kUqc+WdE7xPBBNtSw49kg=;
        b=mkyxctzWUCNoB2qT0Iyq9QK+n0nJbfLD4y916zvpD8f7ZskgXX9jUH9RMjZ8UQk7xi
         Jpb5OUdpEHUeC0yo1CB2uLFKy4NQ+aXkRyb7Vm1yLVDOH+6UhmYv5ND0de0Gc7EH+LY3
         PHag/mOX1Zvl+0nUHX3/paB6j3Cs5KMhLuXAv2zy9IEc0qo+7ZffKkusuPEuCooCz0zu
         Yd+3/5+bt0d+QVA3bGRmv6QLJzDuAwo8oSYEe2p8gAOktpu6HeXop7LMLX9OrsTBOBsE
         uM3aFoVVQ72MetQy5+fQUQuP6PShe1k87qDJ/XKpdNI3pydpT/7VwjppKiAGP/KfmzuT
         e1Mw==
X-Gm-Message-State: AOAM5316EEe682daLCCUocPJfxeH/2Bc/UDOdl+1kWgAWCKynhgaitFm
        g+fnIsCkLByuVVq9eRJ83I+5Yg==
X-Google-Smtp-Source: ABdhPJxy4IufRBKzjD8wBmIhR6AaKyadsNj889rMyLOVXLMf+K5MDbdlRVSNpKLlmHyPRl+ICj25uQ==
X-Received: by 2002:a17:90b:1bcf:: with SMTP id oa15mr479092pjb.58.1631604926427;
        Tue, 14 Sep 2021 00:35:26 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.35.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:35:26 -0700 (PDT)
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
Subject: [PATCH v3 21/76] coda: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:28:43 +0800
Message-Id: <20210914072938.6440-22-songmuchun@bytedance.com>
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
 fs/coda/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/coda/inode.c b/fs/coda/inode.c
index d9f1bd7153df..2185328b65c7 100644
--- a/fs/coda/inode.c
+++ b/fs/coda/inode.c
@@ -43,7 +43,7 @@ static struct kmem_cache * coda_inode_cachep;
 static struct inode *coda_alloc_inode(struct super_block *sb)
 {
 	struct coda_inode_info *ei;
-	ei = kmem_cache_alloc(coda_inode_cachep, GFP_KERNEL);
+	ei = alloc_inode_sb(sb, coda_inode_cachep, GFP_KERNEL);
 	if (!ei)
 		return NULL;
 	memset(&ei->c_fid, 0, sizeof(struct CodaFid));
-- 
2.11.0

