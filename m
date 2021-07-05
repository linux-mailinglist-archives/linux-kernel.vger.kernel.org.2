Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89BE43BBAB1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 12:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbhGEKDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 06:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbhGEKDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 06:03:40 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C54C061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 03:01:02 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id h6so8839807plf.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 03:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zPOrmC1RXgcNJnX31Ibadv5UuQd9PEZ0WGKKpWH0dQY=;
        b=CecTSE6KZsVLTnN0u8fmrWPe/xgLjU6zHobrJl+2rjWm7HX3HMGsn6A+uDgr0+mbC1
         NbfpMp9kQ3BkLhDtsFYhR8DjNIn6svn2+Ei2OheU4ZlrCkprEhA5GuHR/2ocyuaToFGJ
         +tppQnF9dPsY2Crq5b63AaeLMEQbpYbQJEodIg08UHnejItxDI6twSiyNGIehK2naIgC
         7LErc8V5x5EKE2SX3VrY3r80u2XIL8yJsS3ET5vNfdHuBTOZw+I9JUDryPf5+RqFW4uz
         J9DLwifnNrUDktJjG3cbx5UNGbKxN168793V0DrnCYA1LizlAvCAqwkbC1Q9xwBkCkOP
         s2BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zPOrmC1RXgcNJnX31Ibadv5UuQd9PEZ0WGKKpWH0dQY=;
        b=nbfbhW+g4bxespCB2InuhkjU3fjOcoJphf25QrmIUz6wAu/jf4oHfwcmVbT5VaBZu8
         rguHbfGgt32BqYZ6UOnCDpAlOREytFoYb6jSuBdPh4ypV8j/DYlHXLFQ5t2b1+9g+Skk
         qHv6DMPB1fvoOCqBcy/rUQO71eAE7OywelAS2OABbPWN6IW4p8Qnj1UjZjojHIqUG08o
         dA08BqtZJcLonNu84ZiqM3+QkcDTV5f6uFWQXODCmYTs5UY4L8rvcj5SMWOYsEnV4Ajm
         Cs8I9W8gZLZdD9sxbD/9PABz3kd4GecxLsoyJJFGt/+k/C+fBmdEFFqPnqxcpl+T5qKd
         HpeA==
X-Gm-Message-State: AOAM531K7IufVvUUQF9F3eqHGB+tYb3bdIM1uRg78DVjMsEahjH9HVTR
        WtH5ZwZ4fdxZP+zUBsfl5WRW
X-Google-Smtp-Source: ABdhPJzHbop2tIyt7b+CLnVYCy4yRROCsyMt4bNGBhnLwAxog31fNWlijaENvAL2w0znsqFJHNBCVw==
X-Received: by 2002:a17:90b:198a:: with SMTP id mv10mr14686315pjb.67.1625479262030;
        Mon, 05 Jul 2021 03:01:02 -0700 (PDT)
Received: from localhost ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id s6sm1287849pjp.45.2021.07.05.03.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 03:01:01 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        axboe@kernel.dk
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] virtio-blk: Add validation for block size in config space
Date:   Mon,  5 Jul 2021 18:00:06 +0800
Message-Id: <20210705100006.90-1-xieyongji@bytedance.com>
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
index e4bd3b1fc3c2..e9d7747c3cc0 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -819,7 +819,7 @@ static int virtblk_probe(struct virtio_device *vdev)
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

