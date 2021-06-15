Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F387B3A7C63
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 12:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbhFOKui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 06:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbhFOKuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 06:50:37 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6405AC06175F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 03:48:33 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id l184so11095640pgd.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 03:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WdD620LAuh+zdkdFnt6lNMuLD4Se0RjUXXyrRg3LSdI=;
        b=k6fGeowr5S4OWzFSVxVu59P3nQGVdL87Z7WC1vj3M4PC0ADAeYVb0bivQ+dXprQ2Uq
         zFlMKEt4IpTxgya9f5OMRAOhUsmtVH9VC2aB0ms7vdEi+ZJRkvTOPcT5xuozuunk8y1q
         27Cu3WdMSeW2e5ZENtq/2woUsfMHK4sxowmshZ/YA8eHHptU5nhyId9N14P/CNc8E8lv
         BKguteD9e1J/DposFfDT/Hb60fJ7NOnIzDAPQoS2nHdrvgLTfIVKuFSaNoangf0xzDXC
         KLsrTsw8h3TwNe34hivnGEi0jCDwfg3rGqfi6V/xa6EIHWWaYQns0Zle3wCgFmx0zUAL
         YCiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WdD620LAuh+zdkdFnt6lNMuLD4Se0RjUXXyrRg3LSdI=;
        b=ZOYbmU6e9z5+CINb/vjXbaA+FynILPvIRae9r7+vefvCG8SrhDMr3ciPYtFLE6dmGy
         e6O31fkuVr5iQKDoIy3uZ7ShLNLzs8UyxcuKtkb7u8yCpyvXPTyD5zX44jQaacr0fqPG
         AOLLQwwxlPq8Wy5XbBIM3KE4kPabY2NlvT0xts7GwOd+xFXHB69Y2b+SZsYrANb1Wnas
         O2upWlR/P80fIbxtDAiiLIkUKfVPx7iFhGblYCyeYJHGlwPLBa7etKmyoBdMW73g3jhz
         VfKnRKo/XvzZ/LCf6N20MXFq4+/gwb/y6xxs5k4REdqhhq8GbOauRCZSzNvwJxWnmWZf
         mUxQ==
X-Gm-Message-State: AOAM53216F/LEpRRBUAP0pVV+PhboKD0d4wWwSmOa/WSPp63H6Z00GPM
        EbEiia6fj2kYO5+yLdj5IyoF
X-Google-Smtp-Source: ABdhPJzl/nkn3/Z8TNrrue6WsPSXZp7LdC8FJV7fH6izqMFpnk1tNpG3TlfEYiBe6BYAWO5bg9lMqw==
X-Received: by 2002:a62:2c92:0:b029:2ef:6118:a934 with SMTP id s140-20020a622c920000b02902ef6118a934mr3912976pfs.80.1623754112819;
        Tue, 15 Jun 2021 03:48:32 -0700 (PDT)
Received: from localhost ([61.120.150.78])
        by smtp.gmail.com with ESMTPSA id w206sm15032759pff.1.2021.06.15.03.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 03:48:32 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        axboe@kernel.dk
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] virtio-blk: Add validation for block size in config space
Date:   Tue, 15 Jun 2021 18:48:10 +0800
Message-Id: <20210615104810.151-1-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This ensures that we will not use an invalid block size
in config space (might come from an untrusted device).

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/block/virtio_blk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index b9fa3ef5b57c..85ae3b27ea4b 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -827,7 +827,7 @@ static int virtblk_probe(struct virtio_device *vdev)
 	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_BLK_SIZE,
 				   struct virtio_blk_config, blk_size,
 				   &blk_size);
-	if (!err)
+	if (!err && blk_size >= SECTOR_SIZE && blk_size <= PAGE_SIZE)
 		blk_queue_logical_block_size(q, blk_size);
 	else
 		blk_size = queue_logical_block_size(q);
-- 
2.11.0

