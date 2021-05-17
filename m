Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFB43827D3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 11:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235852AbhEQJKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 05:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235760AbhEQJKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 05:10:31 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA13C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:09:05 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id i5so4246603pgm.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jhBni8X9QlkQeBD83OCCLKYlOWpAQU218tM5q8w0H+0=;
        b=zNeom1/c4JETV9Ylyw5hZIeynCnit4Wbt6c304XuokR0k+a45tZD2uBp9M/n2N3uPR
         oBjm53E1ySAaL558bAQ0BYVu8DPdQ6/nQ7w4DXMAcfFp9p5Ld7Guwong4ue91XQ58blM
         kSGxZHC0uD47KdXx2/3x3lhH0JcmilfY3sUJHo+J2sU4er1D6p8ecHzsbg8q1Dy6Ddee
         V3h9sLwoJ6GD4m7Zy5gO0hlWJ2RHlw40PRd70IMgro2mIKetn8C5wIKkonZFb6ftHrsr
         vdCMgkggSk6rwBMJzGkRKlvl3lpQRoOH3vl2usBrSHwQ/zeh1sev0K28fVvm7BfVq/YE
         jHLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jhBni8X9QlkQeBD83OCCLKYlOWpAQU218tM5q8w0H+0=;
        b=ajfjKVVwgezj+97zRRCjTJAtgfuldYLrU1V3BrnppXtt2QJV1KisgHUXOA+b6+DBre
         ojT3SjLfjmJRIH+rzFEyO0ZNo2J5PWApU7Nq0nUj5qcVQ2XfFzpWwJy+Wh6y1qp9AbZe
         EJEhxQmWOzF63JCdzPt2NsuJx8eTDoTMf1iy0QRw1npTW0/kjrxg8s5gmssM+Lg27U55
         i+AS6qkPGqibejUojfGWs95Y7HavgLydRCJr2DD4BlsaDTAILuAfrD4SInC4LJJaly+v
         Tu9WAjOOrN27nXJgBKRTZLehLl75KA0f0AzpICGaCEBLwXueo50FitDllCa0ijJbxyWX
         gcCQ==
X-Gm-Message-State: AOAM533+3UZupwe1bqtgvZz56kpktXpHOMRcxQU2f3DKg2zFhVPDkPyj
        HgucVwBcKgYoGjwitGqlRlGe
X-Google-Smtp-Source: ABdhPJy/hEKqaQGNe2OZcLBRD+qHcI1uhJO0z8QLc8+PhEyP7nCQSnHbBxvbObTjLSCaov+8hQeeVA==
X-Received: by 2002:aa7:95b6:0:b029:28e:aa31:dd3c with SMTP id a22-20020aa795b60000b029028eaa31dd3cmr59113227pfk.43.1621242545386;
        Mon, 17 May 2021 02:09:05 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id t7sm2956257pjr.29.2021.05.17.02.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:09:05 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com
Cc:     amit@kernel.org, arei.gonglei@huawei.com, airlied@linux.ie,
        kraxel@redhat.com, dan.j.williams@intel.com,
        johannes@sipsolutions.net, ohad@wizery.com,
        bjorn.andersson@linaro.org, david@redhat.com, vgoyal@redhat.com,
        miklos@szeredi.hu, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 01/17] virtio_ring: Avoid reading unneeded used length
Date:   Mon, 17 May 2021 17:08:20 +0800
Message-Id: <20210517090836.533-2-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517090836.533-1-xieyongji@bytedance.com>
References: <20210517090836.533-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If device driver doesn't need used length, it can pass a NULL
len in virtqueue_get_buf()/virtqueue_get_buf_ctx(). Then
we can avoid reading and validating the len value in used
ring entries.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/virtio/virtio_ring.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 54e12dd91310..d999a1d6d271 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -772,7 +772,8 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
 	last_used = (vq->last_used_idx & (vq->split.vring.num - 1));
 	i = virtio32_to_cpu(_vq->vdev,
 			vq->split.vring.used->ring[last_used].id);
-	*len = virtio32_to_cpu(_vq->vdev,
+	if (len)
+		*len = virtio32_to_cpu(_vq->vdev,
 			vq->split.vring.used->ring[last_used].len);
 
 	if (unlikely(i >= vq->split.vring.num)) {
@@ -1444,7 +1445,8 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
 
 	last_used = vq->last_used_idx;
 	id = le16_to_cpu(vq->packed.vring.desc[last_used].id);
-	*len = le32_to_cpu(vq->packed.vring.desc[last_used].len);
+	if (len)
+		*len = le32_to_cpu(vq->packed.vring.desc[last_used].len);
 
 	if (unlikely(id >= vq->packed.vring.num)) {
 		BAD_RING(vq, "id %u out of range\n", id);
-- 
2.11.0

