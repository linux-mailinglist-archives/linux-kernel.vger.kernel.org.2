Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCED63828E7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 11:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236197AbhEQJ5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 05:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236078AbhEQJ5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 05:57:16 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB278C061760
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:56:00 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id h7so2852535plt.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ygd6Y3pMMIE3RUljThmAuE4r52Kqy5h8O2JQV7ru1VE=;
        b=CfGZ0PIMRYu4HZPQTqyHPr1YCzbRVLXIMfeN4edm7scYV+U9MYChU0jqbjBaSYww8W
         x34cC9/BMlqozDzEDG8ux9bhvujMR9dQUSals7Y5Q6Z1Ic9ux5H7kh6skw81G6vCSEuj
         qvAj7zfktNXLCd1rUIgxI87C26tOnzC7+pVGuD1g/0Lv5qn8oiSuf1+7+eWR6D+6V+Us
         mf1DA4vTKCekvwxQldEXP7DGoACUCXG3tr2GgElhChFw367kHCgwfpQSfxiMYchniS3x
         3QikwhZOKWcBciqgNHjjH9ktT79H4PFjZ9sUPr0lm6w4kGIx2J2u98pIhDIqi7lIhPpV
         gsYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ygd6Y3pMMIE3RUljThmAuE4r52Kqy5h8O2JQV7ru1VE=;
        b=oACogU76/OCFbxLtlDHnBZGcRVF0dGmRW/IsgSNQzeNFcDWwmNaw+ucW31xOP7krcY
         8KyA73TekEfV2GSsUI2T0YUV2PAzNXYhr7CEQdowEwzP1m26UvSDEoaW0Xt2fodEs9pZ
         14d7NKxiIuZFQBqm0QiVDrCAV0MKK3Kri+Erib39PqYiLJDdsSw7u657woXzy/wsovEC
         YdddTAfzyFtQSFewOtB0ihaywtlHjwgBo7zSUc0CUdFFlduLKjlXfOz/v3kkDyTncJun
         QgdRduraezcGx6dfKbQahLQ0UF43DXjM3t38gkZzfnaKgARD4pGLNQnHTLbOafB+ew4c
         ef0g==
X-Gm-Message-State: AOAM530hDoJzbu6frwgS9fhRERpCO9obdKVNPd8Ry+Zq+GUaKtdxRaxs
        wBmMBnc24WFLdR7yOfUPsQeQ
X-Google-Smtp-Source: ABdhPJxcu8VbEVbQ6UidxIbU5FzeWTHg5acjJx2pdfr2qW4l4EQrVjPUuXEDDezt/Znh1VwtXb7+/w==
X-Received: by 2002:a17:90a:6c23:: with SMTP id x32mr30960965pjj.228.1621245360342;
        Mon, 17 May 2021 02:56:00 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id q24sm10233373pjp.6.2021.05.17.02.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:56:00 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
        christian.brauner@canonical.com, rdunlap@infradead.org,
        willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
        bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
        dan.carpenter@oracle.com, joro@8bytes.org
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 01/12] iova: Export alloc_iova_fast()
Date:   Mon, 17 May 2021 17:55:02 +0800
Message-Id: <20210517095513.850-2-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517095513.850-1-xieyongji@bytedance.com>
References: <20210517095513.850-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export alloc_iova_fast() so that some modules can use it
to improve iova allocation efficiency.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/iommu/iova.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index e6e2fa85271c..317eef64ffef 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -450,6 +450,7 @@ alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
 
 	return new_iova->pfn_lo;
 }
+EXPORT_SYMBOL_GPL(alloc_iova_fast);
 
 /**
  * free_iova_fast - free iova pfn range into rcache
-- 
2.11.0

