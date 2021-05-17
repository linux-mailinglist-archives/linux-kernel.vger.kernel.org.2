Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99E053827F0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 11:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236126AbhEQJQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 05:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235919AbhEQJLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 05:11:05 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E16C061761
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:09:49 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id gb21-20020a17090b0615b029015d1a863a91so5190751pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nl1RimdI/5nA8HoC7zyaJVa2ia5n9+cTuVMNw7l0PJA=;
        b=C1JDXziCuEO3afecOyNnPdzGMnfrmjKTF1WzXyVNSV4ZCHSAYWb1TCVOEyd+GRFe5e
         3o3AYpHHnQ7Ca4kwLy1vkEoADWxy5BqDRRT+M1L9tJB3loHGm75AOkrh+uWhy/+JXLUu
         oza4mjY8qJdEz3db5cH7F4RF2x5RtHkVYx7YRs82xgUBPokAO2lfs9z0X58jQOptHkXi
         a1+SFyK8+0mqY2/C1k2MhejaFPUlmu5p7ys26Zmbi5d4icjwT0HmlxBB6brHGUuh8zbR
         W7ciI/y5VbciNDEah9YeGKRiTT4oYMC5UXAWVg5jCLwJ43N51goxzVkeSAuDWmjq6r3d
         +Xwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nl1RimdI/5nA8HoC7zyaJVa2ia5n9+cTuVMNw7l0PJA=;
        b=VcoAFzztGORv+jACbCmPLT7A+QvxuPaZI6Pa1Jq3b4T29EMzgBitbXjqPlRq8npoLJ
         L+LgYaOBTAJGHurmOb/R6Z5hQii0NMbLMEe7X5BbzV+xqsNuUIOYx2lxJJGY1QXMmBro
         or9qt4v7P6hP07mnCuWLkayVlV0cbGNlni5kFa/blsu44/yNMXArk2vU1cscSwcJIpQH
         9FzrLUOgqNf6hT67kMGYb3T8JoNI+rODuMY0nc4qvsUnngiDWljBC8fOWIorrYCRu1al
         V095M+jFWqFt2ucC10ltarfcwJVFae1buezWskMDnvfYKh518DdlIms3Rwphm4F+Z7FW
         wlbA==
X-Gm-Message-State: AOAM530cRZ3qkmQe89HY77tEc8onCOuQhBL+am7qrJaJi8Hmb3ohfSUX
        koZ/96oxehqsQCexvBx9n9Cx
X-Google-Smtp-Source: ABdhPJxX40LBhRzbHmfqrLNQUOc2FXChqAUEU1PCqUe9biNF6dPvq8GIn0U5Nt6IpfelVBDfjzVmiA==
X-Received: by 2002:a17:90a:6d43:: with SMTP id z61mr25631473pjj.147.1621242588600;
        Mon, 17 May 2021 02:09:48 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id a9sm2765892pfl.57.2021.05.17.02.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:09:48 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com
Cc:     amit@kernel.org, arei.gonglei@huawei.com, airlied@linux.ie,
        kraxel@redhat.com, dan.j.williams@intel.com,
        johannes@sipsolutions.net, ohad@wizery.com,
        bjorn.andersson@linaro.org, david@redhat.com, vgoyal@redhat.com,
        miklos@szeredi.hu, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 13/17] virtio_input: Remove unused used length
Date:   Mon, 17 May 2021 17:08:32 +0800
Message-Id: <20210517090836.533-14-xieyongji@bytedance.com>
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
 drivers/virtio/virtio_input.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_input.c b/drivers/virtio/virtio_input.c
index ce51ae165943..f83f8e556fba 100644
--- a/drivers/virtio/virtio_input.c
+++ b/drivers/virtio/virtio_input.c
@@ -35,11 +35,10 @@ static void virtinput_recv_events(struct virtqueue *vq)
 	struct virtio_input *vi = vq->vdev->priv;
 	struct virtio_input_event *event;
 	unsigned long flags;
-	unsigned int len;
 
 	spin_lock_irqsave(&vi->lock, flags);
 	if (vi->ready) {
-		while ((event = virtqueue_get_buf(vi->evt, &len)) != NULL) {
+		while ((event = virtqueue_get_buf(vi->evt, NULL)) != NULL) {
 			spin_unlock_irqrestore(&vi->lock, flags);
 			input_event(vi->idev,
 				    le16_to_cpu(event->type),
@@ -108,10 +107,9 @@ static void virtinput_recv_status(struct virtqueue *vq)
 	struct virtio_input *vi = vq->vdev->priv;
 	struct virtio_input_event *stsbuf;
 	unsigned long flags;
-	unsigned int len;
 
 	spin_lock_irqsave(&vi->lock, flags);
-	while ((stsbuf = virtqueue_get_buf(vi->sts, &len)) != NULL)
+	while ((stsbuf = virtqueue_get_buf(vi->sts, NULL)) != NULL)
 		kfree(stsbuf);
 	spin_unlock_irqrestore(&vi->lock, flags);
 }
-- 
2.11.0

