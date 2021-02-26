Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81B80325C61
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 05:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbhBZEJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 23:09:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbhBZEJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 23:09:54 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DA9C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 20:09:12 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d11so4604204plo.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 20:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sS7O64Dax1Oof6uU+LILebhJ2b6dwBPbMV6PckIKTic=;
        b=SBfjWgcX7J4qKX7Tx/bBySKwNSomYsKyezXTnuznVIVzwnGIJhBnf+Q6aKLZklE010
         piLfpJ38GSZPZ04u3WRoGx6Dx/iXambXNJlWc10p5BJu0BkQisRIGletv6H5lAFWrucj
         gzU9iSRDzzcenUY9x2wowgr0zRYUXiLTv44+BLxGLx0Xor+xXaqi2N6H2iv+SGv2Z4ZC
         rmt4QWoPPXQy9J2PVfp7jFSeS9EwqLsqmOcBzHKTz4T1Tuo5q9paDQmHdhaz7ePPAh3y
         UlzVxEERei8fpd1u1UXtchb1bQ9knVi+9o4h85Hfpt2HGT3rdWg5NU5k/+WS71bPE4o+
         XYpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sS7O64Dax1Oof6uU+LILebhJ2b6dwBPbMV6PckIKTic=;
        b=MK6l/HP8/DMWVhYZ/xPLfN5bt/Bzr8ZRD8pAbfdzcYIQWReskSXWt7D8X0qV/KuDBV
         M1ML6E39+N+tX4AbwVLpiiqZpFfxJGJY6RSydxWMLOSluMiljRhVSThK+9HNndJ3l4PC
         a3goFhuezKQQqlZJ7EdJb4NTOaAmFhzM+B7Ey0LY11BaUfsykV4eCytqf1IDk4miY41i
         gyO+68D93syfmzr4PN3Us/DvjXaZLfv0ZttQnDjkwL0zr9sGcuggmR8tQMDXuOzYZOV3
         jxuMMXU0ZeGq7z9F5Nvz5C14IaKVNcCNQtJ4t502qPJhFLvGdK2Puq72Lit1Oixb5Ubl
         51vg==
X-Gm-Message-State: AOAM533QORr99qceqDU3PfVawv39DBF3C2o7WJ4dumQHQrsE3hJkKVpU
        ZgI11teRvmIp7bfiqYOCiu0IBNlsJaDpTQ==
X-Google-Smtp-Source: ABdhPJzoeipTVrF8IbTxJwEupx0T2MyCKRlMEoY2FfiRRoVqjyRaqdsS61hiZWm94ZbjbWhgc9g5IQ==
X-Received: by 2002:a17:902:a985:b029:e3:8796:a128 with SMTP id bh5-20020a170902a985b02900e38796a128mr1326366plb.81.1614312551589;
        Thu, 25 Feb 2021 20:09:11 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id z2sm7792202pfc.8.2021.02.25.20.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 20:09:10 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christian Koenig <christian.koenig@amd.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Chris Goldsworthy <cgoldswo@codeaurora.org>,
        Laura Abbott <labbott@kernel.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Daniel Mentz <danielmentz@google.com>,
        =?UTF-8?q?=C3=98rjan=20Eide?= <orjan.eide@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Simon Ser <contact@emersion.fr>,
        James Jones <jajones@nvidia.com>, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] dma-buf: heaps: Set VM_PFNMAP in mmap for system and cma heaps
Date:   Fri, 26 Feb 2021 04:09:08 +0000
Message-Id: <20210226040908.3274666-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per discussion and patches here:
  https://lore.kernel.org/dri-devel/20210223105951.912577-1-daniel.vetter@ffwll.ch/

Daniel is planning on making VM_PFNMAP required on dmabufs.

Thus to avoid the warn_on noise, set the VM_PFNMAP in the
system and cma heap's mmap handler.

Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Liam Mark <lmark@codeaurora.org>
Cc: Chris Goldsworthy <cgoldswo@codeaurora.org>
Cc: Laura Abbott <labbott@kernel.org>
Cc: Brian Starkey <Brian.Starkey@arm.com>
Cc: Hridya Valsaraju <hridya@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Sandeep Patil <sspatil@google.com>
Cc: Daniel Mentz <danielmentz@google.com>
Cc: Ørjan Eide <orjan.eide@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Ezequiel Garcia <ezequiel@collabora.com>
Cc: Simon Ser <contact@emersion.fr>
Cc: James Jones <jajones@nvidia.com>
Cc: linux-media@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/dma-buf/heaps/cma_heap.c    | 1 +
 drivers/dma-buf/heaps/system_heap.c | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/dma-buf/heaps/cma_heap.c b/drivers/dma-buf/heaps/cma_heap.c
index 364fc2f3e499..34bc3987f942 100644
--- a/drivers/dma-buf/heaps/cma_heap.c
+++ b/drivers/dma-buf/heaps/cma_heap.c
@@ -185,6 +185,7 @@ static int cma_heap_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma)
 
 	vma->vm_ops = &dma_heap_vm_ops;
 	vma->vm_private_data = buffer;
+	vma->vm_flags |= VM_PFNMAP;
 
 	return 0;
 }
diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
index 3548b20cb98c..8995e3cbfcaf 100644
--- a/drivers/dma-buf/heaps/system_heap.c
+++ b/drivers/dma-buf/heaps/system_heap.c
@@ -228,8 +228,10 @@ static int system_heap_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma)
 			return ret;
 		addr += PAGE_SIZE;
 		if (addr >= vma->vm_end)
-			return 0;
+			break;
 	}
+
+	vma->vm_flags |= VM_PFNMAP;
 	return 0;
 }
 
-- 
2.25.1

