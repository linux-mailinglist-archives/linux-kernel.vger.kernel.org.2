Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAE224390BA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 09:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbhJYIB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 04:01:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20570 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232090AbhJYIBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 04:01:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635148741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=dK/mYm1FrF9rRdNv3QxeLeadP1lFYA8IS+ck5qZJT8M=;
        b=TnyIkr8dRwM4IeAHeo0Qwwz44gNu6UdKT/86OyET9aRzgfK/Xq40zYqxlryAvs3s9mqM0+
        k92mPScp+UZBMbky+AKuyKD4dcJkMMcBBuk1iPyjqn4CmdHzR7+NR3v2eRHSWFSvoiy9kg
        HSOf3Fax+slYyZ6ir3JbkE93eNnbgU8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-eSZqebFIPqiXe6xxXKd5eg-1; Mon, 25 Oct 2021 03:59:00 -0400
X-MC-Unique: eSZqebFIPqiXe6xxXKd5eg-1
Received: by mail-ed1-f71.google.com with SMTP id c25-20020a056402143900b003dc19782ea8so9131285edx.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 00:58:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=dK/mYm1FrF9rRdNv3QxeLeadP1lFYA8IS+ck5qZJT8M=;
        b=TaOlOR6ansWoJ4/eH5oogZI/0tyBLD8GZgRDT7MsC0dYbqnx+i7RmPJGlmPiVf1Rp7
         pWuD+x60AiqJAMiVi+0VQrA+9rYux0kxMkqQ8W/IEpwhG0xZCZ32W9CYo7IungWpMYRv
         YaXkcqLuvImfPGyBPfV3p2vHaRJAaEihirSLCQQb+EUFQZIJZGV2BBghzf+o378UZ9C9
         YVmJTdwR8vdLN+c1qXGDKekw4tDwUTVGplaR62oyyWRBVQjhD5jj+JiRT7My6qRYtrpC
         VeqKX6XBu/GMSxK5aMxnLa/XiKcqqd0JyFuFSmM19t8wtqwhK08uaRiXaf8e5xvqTEuc
         RCjA==
X-Gm-Message-State: AOAM532DdPssmCmQjMrj21t/PMtj+AXw+L04iz9m7mTAGwQzmFfRvxUC
        /+YtvVd08S3v3F4WpA3RRpRN1x5gt9IboICrqaYDbUsN9nKGcU0v13LgoJ/s9RiUt7Ogzxb7v5K
        ftm6ms0WGm6ZEI8Mv/PmEHQpFP7GN0AEAXD4uFDB3FuQ/dPekpJSMv83JFRRU+5XdTdUnQQ==
X-Received: by 2002:a17:906:2a06:: with SMTP id j6mr20748797eje.401.1635148738358;
        Mon, 25 Oct 2021 00:58:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8iS3IW2Yyq5Wb5XfIh0GRJczmyMiooQOgTEZEvApX2TIFLEIbhNiwxogw2Hx7VOkTSCCg/A==
X-Received: by 2002:a17:906:2a06:: with SMTP id j6mr20748761eje.401.1635148738124;
        Mon, 25 Oct 2021 00:58:58 -0700 (PDT)
Received: from redhat.com ([2.55.151.113])
        by smtp.gmail.com with ESMTPSA id u14sm8581172edj.74.2021.10.25.00.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 00:58:57 -0700 (PDT)
Date:   Mon, 25 Oct 2021 03:58:54 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Feng Li <lifeng1519@gmail.com>,
        Israel Rukshin <israelr@nvidia.com>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: [PATCH] virtio_blk: corrent types for status handling
Message-ID: <20211025075825.1603118-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

virtblk_setup_cmd returns blk_status_t in an int, callers then assign it
back to a blk_status_t variable. blk_status_t is either u32 or (more
typically) u8 so it works, but is inelegant and causes sparse warnings.

Pass the status in blk_status_t in a consistent way.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: b2c5221fd074 ("virtio-blk: avoid preallocating big SGL for data")
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/block/virtio_blk.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index c336d9bb9105..c7d05ff24084 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -208,8 +208,9 @@ static void virtblk_cleanup_cmd(struct request *req)
 		kfree(bvec_virt(&req->special_vec));
 }
 
-static int virtblk_setup_cmd(struct virtio_device *vdev, struct request *req,
-		struct virtblk_req *vbr)
+static blk_status_t virtblk_setup_cmd(struct virtio_device *vdev,
+				      struct request *req,
+				      struct virtblk_req *vbr)
 {
 	bool unmap = false;
 	u32 type;
@@ -317,14 +318,15 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
 	unsigned long flags;
 	unsigned int num;
 	int qid = hctx->queue_num;
-	int err;
 	bool notify = false;
+	blk_status_t status;
+	int err;
 
 	BUG_ON(req->nr_phys_segments + 2 > vblk->sg_elems);
 
-	err = virtblk_setup_cmd(vblk->vdev, req, vbr);
-	if (unlikely(err))
-		return err;
+	status = virtblk_setup_cmd(vblk->vdev, req, vbr);
+	if (unlikely(status))
+		return status;
 
 	blk_mq_start_request(req);
 
-- 
MST

