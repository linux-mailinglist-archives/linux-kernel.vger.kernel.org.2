Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D73A438961
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 15:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbhJXN60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 09:58:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59818 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231516AbhJXN6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 09:58:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635083764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=tewEIaGWIVgpjWlRNV0G2f4scnW96h9ilayJkc4j6ck=;
        b=dUbN2F1dBfEICNXE/Nt7sAqiXBkhTflM0dEnoo2mIRz9J3WJcR/9F+qcLS++oJUd05n6wF
        W3/J8DtZR1qMIEaJBfC7Gybq0jOtpe4NamFAphO0/Ka9GuwTgeF2Vuz9eIjgpY74+n93/K
        2HCLQkZtfW/4wKlU8MbdzKQivJY+OCw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-Wens4oHTMeCiLbn_aWKa9g-1; Sun, 24 Oct 2021 09:54:59 -0400
X-MC-Unique: Wens4oHTMeCiLbn_aWKa9g-1
Received: by mail-ed1-f72.google.com with SMTP id i9-20020a508709000000b003dd4b55a3caso1249020edb.19
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 06:54:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=tewEIaGWIVgpjWlRNV0G2f4scnW96h9ilayJkc4j6ck=;
        b=DnABESaFCC5QEY5fa/ckx5oLHvNANU2LTguhtG0I7CS4e31BlCyabS6dYcPLcj1hGz
         jbOhr7iwXsDTZHZUVmpj2xrwtLAZZHhS0GeZPw7YgnxTpuYjLEPoYD/AMBiorwhbq79r
         Co0Q2WnoIj8KICntJ9SEL0eQe4v+OgSHkvYU0MC2g2lK8GZWRpakjThRVrQlz4FnAuLs
         bQi8FlBQVV/xPyWyHAKXPS7Tq0T2knpy47Vs7Oz5oRJXD/moPFwIOCQ7g7+s1b4Yrh2e
         NHso7kQA+Yz/iQFtR6VeKKQoFaJJ2AJhu94ZK7U7M90qWY+wy3rEHlm6KsOQgUoMxCeb
         OGBQ==
X-Gm-Message-State: AOAM5317VYB8CKFLGwYDP2ERLgGWntHcGt8BditHL3+ZkgcebRaf/JRw
        YTSC2NH+UWsVT834xrCtb++ioDuCuq4oNyUVvy8RWM2RavRgMYVjSqK2b9d1/TVc+LKEKaWf7e8
        QuJD4GvAnWZGdKpN4DSMvvpoKZG6bqlCtXW+VjtX1voB4EWzHS6ZptVLVJdh4nnwPGaHvWQ==
X-Received: by 2002:aa7:de8f:: with SMTP id j15mr17998605edv.347.1635083697946;
        Sun, 24 Oct 2021 06:54:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJziB449a0jkGnMyxw5Nq/yiWf48HjGMENXG4KqcvYNiRPrUcOY/ICO7KLwSoXi1Wh6vBRnxxA==
X-Received: by 2002:aa7:de8f:: with SMTP id j15mr17998572edv.347.1635083697702;
        Sun, 24 Oct 2021 06:54:57 -0700 (PDT)
Received: from redhat.com ([2.55.151.113])
        by smtp.gmail.com with ESMTPSA id bx2sm1887573edb.44.2021.10.24.06.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Oct 2021 06:54:57 -0700 (PDT)
Date:   Sun, 24 Oct 2021 09:54:54 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Max Gurtovoy <mgurtovoy@nvidia.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: [PATCH] virtio_blk: allow 0 as num_request_queues
Message-ID: <20211024135412.1516393-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default value is 0 meaning "no limit". However if 0
is specified on the command line it is instead silently
converted to 1. Further, the value is already validated
at point of use, there's no point in duplicating code
validating the value when it is set.

Simplify the code while making the behaviour more consistent
by using plain module_param.

Fixes: 1a662cf6cb9a ("virtio-blk: add num_request_queues module parameter")
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/block/virtio_blk.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 6318134aab76..c336d9bb9105 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -30,20 +30,8 @@
 #define VIRTIO_BLK_INLINE_SG_CNT	2
 #endif
 
-static int virtblk_queue_count_set(const char *val,
-		const struct kernel_param *kp)
-{
-	return param_set_uint_minmax(val, kp, 1, nr_cpu_ids);
-}
-
-static const struct kernel_param_ops queue_count_ops = {
-	.set = virtblk_queue_count_set,
-	.get = param_get_uint,
-};
-
 static unsigned int num_request_queues;
-module_param_cb(num_request_queues, &queue_count_ops, &num_request_queues,
-		0644);
+module_param(num_request_queues, uint, 0644);
 MODULE_PARM_DESC(num_request_queues,
 		 "Limit the number of request queues to use for blk device. "
 		 "0 for no limit. "
-- 
MST

