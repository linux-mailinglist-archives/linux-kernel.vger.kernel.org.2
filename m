Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC3F63268D6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 21:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhBZUn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 15:43:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhBZUn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 15:43:57 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FF0C061574
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 12:43:16 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id t5so16823pjd.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 12:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=DjkABc/OrXr8QjcZaprFmzWxTwEQ/zHy8u2omy8POmg=;
        b=zowYW6nU870PkXyJEWKxYwMkVXvCQmERBSR7yQEzP3x4YmDyeE+D+PUHwLd0tBzJUO
         csllc0+dw4DKDJckvgn4ZJE8GE4b++qwxtFnuDE6YBElc1SExvk4zj3cpHIGig3ov4Xr
         DedJtacOjIJb/pG34eSKpVt8K+3ZGH9EvjEjyD2DHQ/oVCdEXJLen12Z4n8d3USbJR3M
         /J7qtBxHf9O7miy5E7pfVEXDS/gIgR8a5PLxtwC/RDaq0V28YSvOd2I1NH3YzvmxSFmo
         uUJlab8Ch+6CFRxSndFLXCRJSCCORT66WJbRlr2vu9krmkCRJo3/6DZWjH+FKRsi9isu
         ul6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DjkABc/OrXr8QjcZaprFmzWxTwEQ/zHy8u2omy8POmg=;
        b=EtRjtdPQ5+Xs3M2UpqIkYYDZmLQkfgp3HHMw2uX4kM7yxLpfQxc+5B93iNPyl25DrX
         GrZ03RJUtGdIMafWJI9t9lnZAvHkDgFDU6VA1d2fgrL4mCiE3HwUMQG23wVN/ph4Bd6B
         VD/SXUDAIriNn6Z4mUm9spDRAANo9s5MgGfjrOETYNoNOpO5xgqYi5fUC61Y6szdnP32
         8719UGEb9tTyCgrFmKuYxu9Lf/ytfoAcsOUkpucqfXnZ27yOOOmxyqPnIgfb+k0Qq7yk
         wLXJQR7mBP1u/g8JeU3+oYBXBt9gCEWxLIBNVJp5JiT2+QbjR6qiG1AR3Hrm4WmWBdWc
         j6nA==
X-Gm-Message-State: AOAM532pAKLBb13y2AV1HWh3eQWh5zTSfwQz+VLIlLHQtzQY0GwuZOZv
        /2yWQEglG06ERYOoKSR68vKWHw==
X-Google-Smtp-Source: ABdhPJzjzqiHIv4+yUWP+WA0WN/MTXBOLzoRuGrZRv7N77mEeO4AUum/AX28N3PrfSWigvvHfUqBmw==
X-Received: by 2002:a17:90a:3d47:: with SMTP id o7mr5108364pjf.149.1614372195936;
        Fri, 26 Feb 2021 12:43:15 -0800 (PST)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id s196sm8576588pfc.185.2021.02.26.12.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 12:43:15 -0800 (PST)
From:   Brad Larson <brad@pensando.io>
To:     hch@lst.de, konrad.wilk@oracle.com, m.szyprowski@samsung.com,
        robin.murphy@arm.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     Brad Larson <brad@pensando.io>
Subject: [PATCH] swiotlb: swiotlb_tbl_map_single() kernel BUG in iommu-helper.h:30
Date:   Fri, 26 Feb 2021 12:43:07 -0800
Message-Id: <20210226204307.50413-1-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel Oops introduced in next-20210222 due to get_max_slots return arg size.
In the function find_slots() variable max_slots is zero when boundary_mask is
0xffffffffffffffff.

[    0.242119] kernel BUG at ./include/linux/iommu-helper.h:30!
[    0.247793] Internal error: Oops - BUG: 0 [#1] SMP
[    0.252595] Modules linked in:
[    0.255657] CPU: 0 PID: 93 Comm: kworker/0:1 Not tainted 5.11.0-next-20210224+ #25
[    0.263245] Hardware name: Elba ASIC Board (DT)
[    0.267784] Workqueue: events_freezable mmc_rescan
[    0.272592] pstate: 60000085 (nZCv daIf -PAN -UAO -TCO BTYPE=--)
[    0.278612] pc : swiotlb_tbl_map_single+0x2b0/0x6a0
[    0.283505] lr : swiotlb_tbl_map_single+0x440/0x6a0
[    0.288395] sp : ffffffc0122736b0
[    0.291713] x29: ffffffc0122736b0 x28: ffffffc010e30000
[    0.297039] x27: 00000000bbf58000 x26: 0000000000000000
[    0.302364] x25: 0000000000000000 x24: 0000000000000001
[    0.307689] x23: 0000000000000000 x22: 0000000000000000
[    0.313013] x21: 0000000000000000 x20: 0000000000000000
[    0.318338] x19: 0000001241fd4600 x18: ffffffc010d288c8
[    0.323662] x17: 0000000000000007 x16: 0000000000000001
[    0.328987] x15: ffffffc092273367 x14: 3a424c54204f4920
[    0.334311] x13: 6572617774666f73 x12: 20726e2030207865
[    0.339636] x11: 646e692078787820 x10: 3062653737317830
[    0.344960] x9 : 2074666968732031 x8 : ffffff977cf82368
[    0.350285] x7 : 0000000000000001 x6 : c0000000ffffefff
[    0.355609] x5 : 0000000000017fe8 x4 : 0000000000000000
[    0.360934] x3 : 0000000000000000 x2 : 18b0d50da009d000
[    0.366258] x1 : 0000000000000000 x0 : 0000000000000042
[    0.371583] Call trace:
[    0.374032]  swiotlb_tbl_map_single+0x2b0/0x6a0
[    0.378573]  swiotlb_map+0xa8/0x2b0

Signed-off-by: Brad Larson <brad@pensando.io>
---
 kernel/dma/swiotlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 369e4c3a0f2b..c10e855a03bc 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -534,7 +534,7 @@ static int find_slots(struct device *dev, phys_addr_t orig_addr,
 	unsigned long boundary_mask = dma_get_seg_boundary(dev);
 	dma_addr_t tbl_dma_addr =
 		phys_to_dma_unencrypted(dev, io_tlb_start) & boundary_mask;
-	unsigned int max_slots = get_max_slots(boundary_mask);
+	unsigned long max_slots = get_max_slots(boundary_mask);
 	unsigned int iotlb_align_mask =
 		dma_get_min_align_mask(dev) & ~(IO_TLB_SIZE - 1);
 	unsigned int nslots = nr_slots(alloc_size), stride;
-- 
2.17.1

