Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65B8A3827E3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 11:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235969AbhEQJNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 05:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235882AbhEQJK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 05:10:59 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11F3C061763
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:09:41 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id j12so4205793pgh.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K5lvNGCvreyFNw7w2Phu0xiDtZw/B1kqMJpSyt5QzAw=;
        b=nx8FIM6SkXfkrwWog65rvg5UAgAOqv7selptn8sRyXHn5H43K08pWLq2zHLUyf5kKH
         Bs4oau1YnowCMj7CChI7esvmjF74hTbqeUHD5/Dm0fu270tVkOGj6710IfbsxMzS7LT0
         eZ3REu2b8L3qfx7kjv7AsvH5fiTUwAxUV86IAp7jFTn7arurZIioGKwdOnoD6iBxnHv1
         mo9P9zsU+O3dOFtcjHF1VFC4yT8qq0rmOGVt5Ko51ufUHCwQYXbaRqGE2V2LwBLdVeBK
         GlEm8farmRy6MUALfzP+fjG1eBLGB/+2Qh5DzJLkvRR/aYZa0J56kpBgrkbgb2iBNrZp
         OBBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K5lvNGCvreyFNw7w2Phu0xiDtZw/B1kqMJpSyt5QzAw=;
        b=axgu0G1RXyI0mQyr+FFeL3BDCGXKNW2sGzfuoAP3IHvA0xBodkyUs0j8X+ZaX5AvZf
         lxZOPkXZqYuDx5N3F09Dx7xduy2Sq4t3PKFjAdB0glJD8xeNGZA0oiWu/bj6ahqWWmK2
         CG+HBXdtT/lTIbmp+cldmQ1YPTlRvOJ0ExSJlALCCxD8M0AxhxTXKCoRrh25LzQ81w9S
         N2viDfPj/VF6wG0tD/wrej/BwiLfw+FciNl7Gctm6Dhuqx/Z+M3CSn961ZmlLhgiHk8v
         PR0ZhLXxBAm+yse2aveMV+wjTEEhuXa2kLTBAGdvItvHRVXOEW/ArRs3Z3EEzOMlR5Tc
         wd5w==
X-Gm-Message-State: AOAM531VaFyYCsquEUzcApQhhKRZW3BTTiHa4EpgMxPHsh9NmJE6+E/g
        JZm7S7Ssx+uqiSi3I676SvHU
X-Google-Smtp-Source: ABdhPJzPHGfmFzEzXiF7aaPx+DXAhLHO9/Uc/AMEo5GtJ7OPe2etIeRPAPeu9urDvBSukodepQLaPA==
X-Received: by 2002:a63:4c41:: with SMTP id m1mr9317666pgl.394.1621242581459;
        Mon, 17 May 2021 02:09:41 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id b12sm6811187pjd.22.2021.05.17.02.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:09:41 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com
Cc:     amit@kernel.org, arei.gonglei@huawei.com, airlied@linux.ie,
        kraxel@redhat.com, dan.j.williams@intel.com,
        johannes@sipsolutions.net, ohad@wizery.com,
        bjorn.andersson@linaro.org, david@redhat.com, vgoyal@redhat.com,
        miklos@szeredi.hu, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 11/17] virtio_scsi: Remove unused used length
Date:   Mon, 17 May 2021 17:08:30 +0800
Message-Id: <20210517090836.533-12-xieyongji@bytedance.com>
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
 drivers/scsi/virtio_scsi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index b9c86a7e3b97..0ebf23ec844b 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -173,14 +173,13 @@ static void virtscsi_vq_done(struct virtio_scsi *vscsi,
 			     void (*fn)(struct virtio_scsi *vscsi, void *buf))
 {
 	void *buf;
-	unsigned int len;
 	unsigned long flags;
 	struct virtqueue *vq = virtscsi_vq->vq;
 
 	spin_lock_irqsave(&virtscsi_vq->vq_lock, flags);
 	do {
 		virtqueue_disable_cb(vq);
-		while ((buf = virtqueue_get_buf(vq, &len)) != NULL)
+		while ((buf = virtqueue_get_buf(vq, NULL)) != NULL)
 			fn(vscsi, buf);
 
 		if (unlikely(virtqueue_is_broken(vq)))
-- 
2.11.0

