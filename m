Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECA13827EF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 11:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236092AbhEQJP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 05:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235926AbhEQJLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 05:11:08 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FAA9C061763
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:09:52 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id m190so4221603pga.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h+Aa0Uk9nuGsTzdkqGHjK7puGuRuX9seCaxiKLJa2BE=;
        b=AcJrpzueKOT0u4amPtwtBwzuCp6VDlYyVRIEdJTAIWammU3W6pAAc4rRONhlsNG9Gv
         1/V/Ak5U7yQ7rLnYBCq8yh5B25VWyDimUbrIW+rpDvEgMJrvzLPxDptLf/AFkeOz7q0g
         D/zu5a3GrmWcyxl6pvrPIr8fYzu1PB/do/s0mxhZnQfMBbdSNVMRsSWGel3y4Ql7qlo5
         A0YTct6Jg6cMzwzVf68QThM9pSxCiYmG/TtyotBP6dMrq8vvpCvITtwIhl1aL2e+uRlX
         D0HtRW7YZXatSuCSDQr/ppOGN5XA2QcBKM3q8UvCJaKNqRGmAAgP7hOfl/V+3MZ8g062
         IG8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h+Aa0Uk9nuGsTzdkqGHjK7puGuRuX9seCaxiKLJa2BE=;
        b=HCvhwRezsqF+t5RCBg3zO1lg0MfCUSSRAkgTblgkVpowY7NvzTig0TQgpBqElSFubf
         5lXrsUaUDGFBkhnRdautgmzmeBKJUwFuRPSBDajpCzwIXZAHuSLBipdw7EagVNBE9woc
         eYu6CmJodfKcBX05zzLjI36ADbWDPg1dAz6UmVmG+opvX1TbNTZ4jQ7+4s9fB/O9C8Sd
         Jo4iC2W/1p4z4wUAk8FWa5u3P5VAfAOa6CsDb2t92xfRK7Qma+su9sujdpznoYBjKPHW
         s2U/FgJLIpkvKkX5j2Dl4LvrBjxoA9NO/tuEzaQDl+yEAa1szDdXZ5D2tN5Es2AuciGA
         Yx/g==
X-Gm-Message-State: AOAM530LlNg8Gl0fnOoyVPBkgVnitMWMCcbliQW4MHtUyVVchtx+h1AT
        KBTVA8Nl6mKDlzmKj2XuqKMv
X-Google-Smtp-Source: ABdhPJzLj/C5eD+IjImaTtRsjiwSPwk3SXj9BKf1WqEHfyKILvXQtZ3VKqyniZTOLr3hOa5/rzbI6Q==
X-Received: by 2002:a63:9c7:: with SMTP id 190mr10210076pgj.149.1621242592174;
        Mon, 17 May 2021 02:09:52 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id 6sm9661465pjm.21.2021.05.17.02.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:09:51 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com
Cc:     amit@kernel.org, arei.gonglei@huawei.com, airlied@linux.ie,
        kraxel@redhat.com, dan.j.williams@intel.com,
        johannes@sipsolutions.net, ohad@wizery.com,
        bjorn.andersson@linaro.org, david@redhat.com, vgoyal@redhat.com,
        miklos@szeredi.hu, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 14/17] virtio_mem: Remove unused used length
Date:   Mon, 17 May 2021 17:08:33 +0800
Message-Id: <20210517090836.533-15-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517090836.533-1-xieyongji@bytedance.com>
References: <20210517090836.533-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The used length is not used. Let's drop it and
pass NULL to virtqueue_get_buf() instead.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/virtio/virtio_mem.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 10ec60d81e84..32a8e359a5c3 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -1256,7 +1256,6 @@ static uint64_t virtio_mem_send_request(struct virtio_mem *vm,
 					const struct virtio_mem_req *req)
 {
 	struct scatterlist *sgs[2], sg_req, sg_resp;
-	unsigned int len;
 	int rc;
 
 	/* don't use the request residing on the stack (vaddr) */
@@ -1277,7 +1276,7 @@ static uint64_t virtio_mem_send_request(struct virtio_mem *vm,
 	virtqueue_kick(vm->vq);
 
 	/* wait for a response */
-	wait_event(vm->host_resp, virtqueue_get_buf(vm->vq, &len));
+	wait_event(vm->host_resp, virtqueue_get_buf(vm->vq, NULL));
 
 	return virtio16_to_cpu(vm->vdev, vm->resp.type);
 }
-- 
2.11.0

