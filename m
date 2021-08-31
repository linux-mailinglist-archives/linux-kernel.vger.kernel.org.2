Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEA33FC5F7
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 13:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241156AbhHaKic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 06:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241088AbhHaKiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 06:38:04 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB4FC061764
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 03:37:08 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id y23so16203432pgi.7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 03:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9VYKP4BtY52G/QfxOL4ci9LsSwqIuUiAxga6ojIUWhM=;
        b=GRqzs++JfJ/YbVycJKzsl230H9LBdcktSOMS0CRM7Z9csGboLrEDaTHS5mpZ9R6W/Q
         h0yUebb0vnRiVhQovGlWZ4qHObLreAQwGxubBzLmX2VpvriR9tTYILs/hWcaIMuq02Ju
         yxmfLSeC0NhVfNEgU1etpXijn0DhnNH9psTW5aD6mhU5ZMkXucGvNU4iy5HTuVHhQQ37
         vN7Cdj/LUB/OZgH70gNMN0CSQQC2g5vU52gKzZiimqROPIjpuhS+RRG+BNYAm0p/s9Dg
         dpiWnWnDnoLVFJ4avE1AGnTW5nXyqjeVKRFFFQW+l5X6R3F25kk7ys29KnpYZo3mRaip
         ZtNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9VYKP4BtY52G/QfxOL4ci9LsSwqIuUiAxga6ojIUWhM=;
        b=Y4/UH4x3VGyjJWoSnDeSXhriZSCpZ8gUoxon+8FjbHTWAJ3oT004JqKQAgvdzqn9OU
         xbyY7WPKN7GOQAkr5aNT6P0eUHb2XpqVgXqZbVd6SzV8Sh3vqWp1Fg4luG87/7LRwcwt
         gkfJPum2/rSakFd64TenF9RoQdm/g6DYkU6grTTKb8o6j4AJd6avtaglk/4qiTmcNiRE
         6+vCx3If/T+CPbctvCnZycoj+ychkLw/w7a6NHT75FTNvbrVx8aOZi450nYkuciAuIEH
         pnKQUgLS0zkco2Djy1BFiNUDSRT2OxL1z9DO3Czeib6Ccbm7Zc+nj28zSHPjGItn8Gf4
         57AQ==
X-Gm-Message-State: AOAM533zrtGE9HVwXyFsB39XkNqFRF23pGyUApc5GhXj/NQrsYPCMfXI
        NwBfZQQ/HcLj06sGD8xvQjbp
X-Google-Smtp-Source: ABdhPJzpvfEiCfyYs8u6SCKIdTO4CD049HKvMqgA1U1TZMFAFKWKT3f3sGm3+cCwAkY6T6H/ysn9yQ==
X-Received: by 2002:a65:44c3:: with SMTP id g3mr26055726pgs.233.1630406228042;
        Tue, 31 Aug 2021 03:37:08 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id p24sm16129455pfh.136.2021.08.31.03.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 03:37:07 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
        christian.brauner@canonical.com, rdunlap@infradead.org,
        willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
        bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
        dan.carpenter@oracle.com, joro@8bytes.org,
        gregkh@linuxfoundation.org, zhe.he@windriver.com,
        xiaodong.liu@intel.com, joe@perches.com, robin.murphy@arm.com,
        will@kernel.org, john.garry@huawei.com
Cc:     songmuchun@bytedance.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v13 01/13] iova: Export alloc_iova_fast() and free_iova_fast()
Date:   Tue, 31 Aug 2021 18:36:22 +0800
Message-Id: <20210831103634.33-2-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210831103634.33-1-xieyongji@bytedance.com>
References: <20210831103634.33-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export alloc_iova_fast() and free_iova_fast() so that
some modules can make use of the per-CPU cache to get
rid of rbtree spinlock in alloc_iova() and free_iova()
during IOVA allocation.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Acked-by: Will Deacon <will@kernel.org>
---
 drivers/iommu/iova.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index b6cf5f16123b..3941ed6bb99b 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -521,6 +521,7 @@ alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
 
 	return new_iova->pfn_lo;
 }
+EXPORT_SYMBOL_GPL(alloc_iova_fast);
 
 /**
  * free_iova_fast - free iova pfn range into rcache
@@ -538,6 +539,7 @@ free_iova_fast(struct iova_domain *iovad, unsigned long pfn, unsigned long size)
 
 	free_iova(iovad, pfn);
 }
+EXPORT_SYMBOL_GPL(free_iova_fast);
 
 #define fq_ring_for_each(i, fq) \
 	for ((i) = (fq)->head; (i) != (fq)->tail; (i) = ((i) + 1) % IOVA_FQ_SIZE)
-- 
2.11.0

