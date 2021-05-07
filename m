Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA9C376C58
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 00:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbhEGWQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 18:16:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60691 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229524AbhEGWQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 18:16:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620425731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=jtUv57ArMiro4bTHhEhdlXIGNZ+0agUPq7/A51n97kU=;
        b=W2EKJwGqPbOnIF6JkCCOHaoOWcVps76qpIQlc6jtsH3TsHw6Noe+ZF220SLTSSH/o1P1P0
        C4fvUMbJMqfweCQIo/5kiQPBBOqD1WNPc1TZ9ne7Z859tUJBzD3xI0mYOEK6xYmw6BXR4t
        81VVrb43b2Szs8RFkxRefDVjcxsiUlc=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-PEg5I_7aND6NFaUGu8h9OA-1; Fri, 07 May 2021 18:15:30 -0400
X-MC-Unique: PEg5I_7aND6NFaUGu8h9OA-1
Received: by mail-ot1-f71.google.com with SMTP id f89-20020a9d2c620000b0290280d753a255so5888025otb.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 15:15:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jtUv57ArMiro4bTHhEhdlXIGNZ+0agUPq7/A51n97kU=;
        b=dCdLv9IZ10GxAdRfxYhzSmBqWEisT//e7IW8scw5QqYQBwK1wOQK+dx7apML5XPFvO
         nYdOlFMQI/8C4JNxYfqf5yWOvMxfEnEPaxgYqhNAw9/hIubAgPEmHrLbTcx6p13xqw+Z
         d0aER/KMhaPWG3ceU26U7LjzcNQinIfpsu5J2ZIKOMGqYvcpTSL7CERkQAyeiHRcT6ek
         OyrzsybPsJ7nDDFM+ubamhslAF4QYsUfFSwu/BxFnIKIj2XrO7jNc+pC7FGSz9DPUai8
         iX0I5wLY+WdNRbZ9mcYFG/N3LdAZX+wgMaFUmTMJSq4xYsF1ntl3aq1uofLPBggGOdXd
         +ksQ==
X-Gm-Message-State: AOAM5332Kw1WsVMfKMfTB+USCNC7tVEUFvpks7wjubFa8Cp/MC0Ar4nM
        nurUlBSJnvMVL/uOxUQwuCN5ZHWY4bj8dDVaARWUaVcjUDs3rDbEarv8TVj+V3XbsvHhKA9du1r
        FKXIKBO94rD5U5UrQe00JkO9T
X-Received: by 2002:aca:db05:: with SMTP id s5mr15825276oig.134.1620425729239;
        Fri, 07 May 2021 15:15:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxOP88BBurGoU0f7ioDsjdxBGt9XwNveg3axEkgvcGkjmkgo5INgRySJeIWZ/JqBdbZtM6hfA==
X-Received: by 2002:aca:db05:: with SMTP id s5mr15825262oig.134.1620425729104;
        Fri, 07 May 2021 15:15:29 -0700 (PDT)
Received: from redhat.redhat.com (ip68-103-222-6.ks.ok.cox.net. [68.103.222.6])
        by smtp.gmail.com with ESMTPSA id n37sm1464589otn.9.2021.05.07.15.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 15:15:28 -0700 (PDT)
From:   Connor Kuehl <ckuehl@redhat.com>
To:     virtio-fs@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Miklos Szeredi <miklos@szeredi.hu>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH] virtiofs: Enable multiple request queues
Date:   Fri,  7 May 2021 17:15:27 -0500
Message-Id: <20210507221527.699516-1-ckuehl@redhat.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Distribute requests across the multiqueue complex automatically based
on the IRQ affinity.

Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Connor Kuehl <ckuehl@redhat.com>
---
 fs/fuse/virtio_fs.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index bcb8a02e2d8b..dcdc8b7b1ad5 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -30,6 +30,10 @@
 static DEFINE_MUTEX(virtio_fs_mutex);
 static LIST_HEAD(virtio_fs_instances);
 
+struct virtio_fs_vq;
+
+DEFINE_PER_CPU(struct virtio_fs_vq *, this_cpu_fsvq);
+
 enum {
 	VQ_HIPRIO,
 	VQ_REQUEST
@@ -673,6 +677,7 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
 	struct virtqueue **vqs;
 	vq_callback_t **callbacks;
 	const char **names;
+	struct irq_affinity desc = { .pre_vectors = 1, .nr_sets = 1, };
 	unsigned int i;
 	int ret = 0;
 
@@ -681,6 +686,9 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
 	if (fs->num_request_queues == 0)
 		return -EINVAL;
 
+	fs->num_request_queues = min_t(unsigned int, nr_cpu_ids,
+				       fs->num_request_queues);
+
 	fs->nvqs = VQ_REQUEST + fs->num_request_queues;
 	fs->vqs = kcalloc(fs->nvqs, sizeof(fs->vqs[VQ_HIPRIO]), GFP_KERNEL);
 	if (!fs->vqs)
@@ -710,12 +718,24 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
 		names[i] = fs->vqs[i].name;
 	}
 
-	ret = virtio_find_vqs(vdev, fs->nvqs, vqs, callbacks, names, NULL);
+	ret = virtio_find_vqs(vdev, fs->nvqs, vqs, callbacks, names, &desc);
 	if (ret < 0)
 		goto out;
 
-	for (i = 0; i < fs->nvqs; i++)
+	for (i = 0; i < fs->nvqs; i++) {
+		const struct cpumask *mask;
+		unsigned int cpu;
+
 		fs->vqs[i].vq = vqs[i];
+		if (i == VQ_HIPRIO)
+			continue;
+
+		mask = vdev->config->get_vq_affinity(vdev, i);
+		for_each_cpu(cpu, mask) {
+			struct virtio_fs_vq **cpu_vq = per_cpu_ptr(&this_cpu_fsvq, cpu);
+			*cpu_vq = &fs->vqs[i];
+		}
+	}
 
 	virtio_fs_start_all_queues(fs);
 out:
@@ -877,8 +897,6 @@ static int virtio_fs_probe(struct virtio_device *vdev)
 	if (ret < 0)
 		goto out;
 
-	/* TODO vq affinity */
-
 	ret = virtio_fs_setup_dax(vdev, fs);
 	if (ret < 0)
 		goto out_vqs;
@@ -1225,7 +1243,6 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 static void virtio_fs_wake_pending_and_unlock(struct fuse_iqueue *fiq)
 __releases(fiq->lock)
 {
-	unsigned int queue_id = VQ_REQUEST; /* TODO multiqueue */
 	struct virtio_fs *fs;
 	struct fuse_req *req;
 	struct virtio_fs_vq *fsvq;
@@ -1245,7 +1262,8 @@ __releases(fiq->lock)
 		 req->in.h.nodeid, req->in.h.len,
 		 fuse_len_args(req->args->out_numargs, req->args->out_args));
 
-	fsvq = &fs->vqs[queue_id];
+	fsvq = this_cpu_read(this_cpu_fsvq);
+
 	ret = virtio_fs_enqueue_req(fsvq, req, false);
 	if (ret < 0) {
 		if (ret == -ENOMEM || ret == -ENOSPC) {
-- 
2.30.2

