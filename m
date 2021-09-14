Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F77040A80A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 09:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240926AbhINHlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 03:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241022AbhINHlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:41:16 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05A8C0611C6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 00:37:53 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id dw14so7336652pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 00:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PmuZFesbpf8uQ/0U/I68C6j1VVIpTQ3yrDpf1uAvzL4=;
        b=bgSbC9nMXbIXpDtFIbUvIIBISucVdUce6cYRarD5Z+zO9DijpzRA0GAKx4Qr7XknRb
         IAa6m+MXFI0tcemn4JjcyIkXKnkn9KfmBAp/hMCGMwHnkAXA1BP6ikF+03Bm5Ofbae8/
         /nTLzMwKnBb/FfZARyMkXjPhVfl/+/uAtq93mA8m+ZMqy1vcfPbnhArVMb/QC4peXL87
         iq1K2GDZJvUR7B6LHv6aaUmHEYlmqlaAtPeJ5LVM/yKgO3U4JSdOOVUNKlESs8GBZJrc
         NWa/Tas0VNSeOvqaLMV2UYYE9Hu/CfqNNYdxpTPdtOZRg0ubamiyDOeOuH1ZgMlBLEUw
         D9Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PmuZFesbpf8uQ/0U/I68C6j1VVIpTQ3yrDpf1uAvzL4=;
        b=XSZOX+Mgpv+/4RW1kI6OYEgo4T6OWfRWcHBYNp49OeN3c41yBkFKiO9YlGEsDPZ9Pe
         vQWhmJj3SBZ9ZOQEeqTAQYcUBUzMMuweSTb9+VmJZ55kXQD7lmHOyj6BWAWdn66phcYw
         xLA6FrZ5ZnzNYmtA0p3fJHLV6ONnaNcM9NUcZdMltIZG9KubDPPZpyyUhhAVGnanX1BM
         aYavt82iEUsRqcrI4a/gQFcjK6bkuoL1yCUx2CBh3C7ECAqHf0iC/8bSP7i1l3vDRrnC
         IRWKN7bct6NbfuLGoV2r/8HiUqlTzejbeN6+Ucrnnky5nBHT5V4uvggBJlUkaTjh6IO9
         a0yA==
X-Gm-Message-State: AOAM532iem5xNf9Q3OYxfNDwkorkLCUlMC/LeFq3lZ8GgZmJg+tEroU5
        omT7gIq7wkV7LjjTXWQvR/Taog==
X-Google-Smtp-Source: ABdhPJw90nC1k6rLS9wrGcxTCSyCDkf3544V1/e7PHbcVflNDzWUqiUYKuHW04uAGZMqykcw6JX3Bw==
X-Received: by 2002:a17:90b:390c:: with SMTP id ob12mr567246pjb.196.1631605073432;
        Tue, 14 Sep 2021 00:37:53 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.37.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:37:53 -0700 (PDT)
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
Subject: [PATCH v3 41/76] nfs: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:29:03 +0800
Message-Id: <20210914072938.6440-42-songmuchun@bytedance.com>
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
 fs/nfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 853213b3a209..b759264885e9 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -2221,7 +2221,7 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 struct inode *nfs_alloc_inode(struct super_block *sb)
 {
 	struct nfs_inode *nfsi;
-	nfsi = kmem_cache_alloc(nfs_inode_cachep, GFP_KERNEL);
+	nfsi = alloc_inode_sb(sb, nfs_inode_cachep, GFP_KERNEL);
 	if (!nfsi)
 		return NULL;
 	nfsi->flags = 0UL;
-- 
2.11.0

