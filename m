Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47FC03F3F1B
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 13:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbhHVLuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 07:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbhHVLt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 07:49:59 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2749AC061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 04:49:19 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id x4so13912335pgh.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 04:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=pd41d9ozzT13Et9mqhXW/uLkG1Pg7swYhOyYwUuusqA=;
        b=I8Ri1XV54WwxQ6llO5Fjp5p0etHpDD6yONomif7Z28SWFmArIkp3tT0HO1tho0ONb9
         5ofeuwgp+C675l57Gs7a3Iokrwd5QMtHQg7Q0hszfEV+wQCmWk3VLzsPheUWwBPoh+uA
         AKfYY4hQWXGWoVErFTPPk9WmXUjAaFSh6DvojAZHOJ73TSsNj4KAbIzDr65XoqQF+KcU
         9yscrh0dmaVVERxU7IfyFEA95FU1Bt/sB/fHXCcwdkjE0AMnyjVM9EVJc/jf7IWlHdS/
         QEYfswhZbTWXfbhBBXOd1F/xDsGDmYjyWF85K1whGEfK8Bfqp0kQbTaK8lGjZtUiYKBX
         KuuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pd41d9ozzT13Et9mqhXW/uLkG1Pg7swYhOyYwUuusqA=;
        b=KquZcuYXnI3zwJ0oE1py3eKqvUSEsoWPErkAeRUALpfp6WhNdVNh5gEpD9wkrcdIjJ
         xKCbEqQffQAxmWz18PCGf/U0xnxAHOIq6T7a7Bn/yC7qojZvR6grxMDjYXP9kS7k+ARf
         fTwBKDJgZN/pxh4D+fiftlqKzmFUVAlED8tiA12/4LikwHHfwSJm0f+rZz5HBo7HQ0/d
         lurGox9xJfkz7WJ3VKqXPfg3ou7p2RiGo7wOouRS0yPwr+4FWQjz93abiQjFr+FKMmQE
         hxmRAlObDTFp1vxmcanaGXxJOmHN0dGFxY6rED6L6HcN2LH0TgcFnP5L6OtfqdFDtChN
         yIAg==
X-Gm-Message-State: AOAM533imT1e2/f5QFc0Ay2MEPBXJHA2BlKUTXi5GEuqZBFWpBTessqu
        Hx5C0ffn6gkTuKkaNDHmHzI=
X-Google-Smtp-Source: ABdhPJxFkUT0wNez4dMng/trKMU36qRV9Ls3M3OYF/c120GFc+9qgFgbTg1LLGo+asVtMWof5yZ5xg==
X-Received: by 2002:a05:6a00:16d2:b029:300:200b:6572 with SMTP id l18-20020a056a0016d2b0290300200b6572mr28972142pfc.62.1629632958566;
        Sun, 22 Aug 2021 04:49:18 -0700 (PDT)
Received: from localhost.localdomain ([129.226.66.100])
        by smtp.gmail.com with ESMTPSA id b15sm14671076pgj.60.2021.08.22.04.49.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Aug 2021 04:49:17 -0700 (PDT)
From:   sumiyawang@gmail.com
X-Google-Original-From: sumiyawang@tencent.com
To:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com
Cc:     nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
        lidongchen@tencent.com, sumiyawang <sumiyawang@tencent.com>
Subject: [PATCH] pmem: fix the crash when unbind namespaces
Date:   Sun, 22 Aug 2021 19:49:09 +0800
Message-Id: <1629632949-14749-1-git-send-email-sumiyawang@tencent.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: sumiyawang <sumiyawang@tencent.com>

kernel will crash when use after free the ioremap space,
which is triggered by ndctl destroy-namespace while some IO operations
exist.
The sequence of pmem driver release chain should be changed:
freeze the queue and wait io finished first, then iounmap. 

[47202.018374] BUG: unable to handle page fault for address: ffffc90080200000
[47202.018822] CPU: 36 PID: 9606 Comm: systemd-udevd 
[47202.020921] Call Trace:
[47202.020969]  ? pmem_do_bvec+0xf9/0x3a0
[47202.021036]  ? xas_alloc+0x55/0xd0
[47202.021094]  pmem_rw_page+0x4b/0x80
[47202.021159]  bdev_read_page+0x86/0xb0
[47202.021222]  do_mpage_readpage+0x5d4/0x7a0
[47202.021297]  ? lru_cache_add+0xe/0x10
[47202.021359]  mpage_readpages+0xf9/0x1c0
[47202.021428]  ? bd_link_disk_holder+0x1a0/0x1a0
[47202.021506]  blkdev_readpages+0x1d/0x20
[47202.021574]  read_pages+0x67/0x1a0

ndctl Call Trace in vmcore:
PID: 23473  TASK: ffff88c4fbbe8000  CPU: 1   COMMAND: "ndctl"
__schedule
schedule
blk_mq_freeze_queue_wait
blk_freeze_queue
blk_cleanup_queue
pmem_release_queue
devm_action_release
release_nodes
devres_release_all
device_release_driver_internal
device_driver_detach
unbind_store

At that time, the ioremap space is released

Signed-off-by: sumiyawang <sumiyawang@tencent.com>
Reviewed-by: yongduan <yongduan@tencent.com>
---
 drivers/nvdimm/pmem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 1e0615b..72de88f 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -450,11 +450,11 @@ static int pmem_attach_disk(struct device *dev,
 		pmem->pfn_flags |= PFN_MAP;
 		bb_range = pmem->pgmap.range;
 	} else {
+		addr = devm_memremap(dev, pmem->phys_addr,
+				pmem->size, ARCH_MEMREMAP_PMEM);
 		if (devm_add_action_or_reset(dev, pmem_release_queue,
 					&pmem->pgmap))
 			return -ENOMEM;
-		addr = devm_memremap(dev, pmem->phys_addr,
-				pmem->size, ARCH_MEMREMAP_PMEM);
 		bb_range.start =  res->start;
 		bb_range.end = res->end;
 	}
-- 
2.7.4

