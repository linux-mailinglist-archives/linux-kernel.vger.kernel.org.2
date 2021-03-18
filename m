Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A43F534073F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 14:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbhCRNwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 09:52:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25726 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231331AbhCRNw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 09:52:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616075547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KZCIq9RCVA/LhZZybw/IDEY9VFO9OybHtvKKFSQDODc=;
        b=IhHelAar6n/r0Nv1l9x4PekF7zWAZJKMgZVYtHxTBESgdDnw9c8nFtZ27xSxiZHcecT8eO
        vlyQTQWyv9ofJSDCpyPn+880ta9hqej2GTAA9c7BVPWjbsgDjqjp+WyjG1a947fcp18VUv
        8Wb9FleHb69JBhvVW7Nx+JUIuKup4ec=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-xQbeB6CvPwWDri__XdXMCQ-1; Thu, 18 Mar 2021 09:52:26 -0400
X-MC-Unique: xQbeB6CvPwWDri__XdXMCQ-1
Received: by mail-oi1-f197.google.com with SMTP id f22so4293301oiw.14
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 06:52:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KZCIq9RCVA/LhZZybw/IDEY9VFO9OybHtvKKFSQDODc=;
        b=lyhpDlXziA1klTuyCzlMEK5vAXKcJ9T8UvqpDDHROdzldKMbaXGjUwneKGE5CgM1Jl
         vM2/2CwwTz0g6LdELg776Z83ir694KSqEeOPwwVSOjfmCPbr+I/XHZyNHu15lH/qf9hx
         O04IN6FbSOPDNiODCMRB2Z9n6/FEeh5ZunErKd5lx9TFLU3eLQUCm5XsgVBMpYJ30w8/
         DjQBD/gdFVo9plArNLlxt8BVYx1zTWkPrJL8J0cBkaMpaElGlomsILqWwAt9aftBom2S
         6tzyhpxfY5EgJnwb7PwQhqLQNoUda40sbvoHWV32YMD3hImPRZ/Ubn0y87+ZqrDZsLUX
         8Uuw==
X-Gm-Message-State: AOAM532qT7stDmtOdOxYoF7QVzY9Et7UKESe8A3oNBsLynlsxFWcEqy6
        eP2aMMMsind+bfe3KnikHGijszFoWCShF5mc6MmejtfSDzC5uqwWd19IqJXbM1ctZ7C9J0RcuuU
        2BO9dnBJ7sqjZjVKnpTL4giXK
X-Received: by 2002:a9d:22e2:: with SMTP id y89mr6976501ota.15.1616075545473;
        Thu, 18 Mar 2021 06:52:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzlV7yBVJ92mx1O4uvhGF7xfvktWRWK93SIED8PCL9825ewwMwqCY6O8lf7z9dfuq601lL4IA==
X-Received: by 2002:a9d:22e2:: with SMTP id y89mr6976491ota.15.1616075545332;
        Thu, 18 Mar 2021 06:52:25 -0700 (PDT)
Received: from redhat.redhat.com (ip68-103-222-6.ks.ok.cox.net. [68.103.222.6])
        by smtp.gmail.com with ESMTPSA id i11sm465342otp.76.2021.03.18.06.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 06:52:24 -0700 (PDT)
From:   Connor Kuehl <ckuehl@redhat.com>
To:     virtio-fs@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, stefanha@redhat.com,
        vgoyal@redhat.com, miklos@szeredi.hu, jasowang@redhat.com,
        mst@redhat.com
Subject: [PATCH 1/3] virtio_ring: always warn when descriptor chain exceeds queue size
Date:   Thu, 18 Mar 2021 08:52:21 -0500
Message-Id: <20210318135223.1342795-2-ckuehl@redhat.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210318135223.1342795-1-ckuehl@redhat.com>
References: <20210318135223.1342795-1-ckuehl@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From section 2.6.5.3.1 (Driver Requirements: Indirect Descriptors)
of the virtio spec:

  "A driver MUST NOT create a descriptor chain longer than the Queue
  Size of the device."

This text suggests that the warning should trigger even if
indirect descriptors are in use.

Reported-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Connor Kuehl <ckuehl@redhat.com>
---
 drivers/virtio/virtio_ring.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 71e16b53e9c1..1bc290f9ba13 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -444,11 +444,12 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 
 	head = vq->free_head;
 
+	WARN_ON_ONCE(total_sg > vq->split.vring.num);
+
 	if (virtqueue_use_indirect(_vq, total_sg))
 		desc = alloc_indirect_split(_vq, total_sg, gfp);
 	else {
 		desc = NULL;
-		WARN_ON_ONCE(total_sg > vq->split.vring.num && !vq->indirect);
 	}
 
 	if (desc) {
@@ -1118,6 +1119,8 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 
 	BUG_ON(total_sg == 0);
 
+	WARN_ON_ONCE(total_sg > vq->packed.vring.num);
+
 	if (virtqueue_use_indirect(_vq, total_sg))
 		return virtqueue_add_indirect_packed(vq, sgs, total_sg,
 				out_sgs, in_sgs, data, gfp);
@@ -1125,8 +1128,6 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 	head = vq->packed.next_avail_idx;
 	avail_used_flags = vq->packed.avail_used_flags;
 
-	WARN_ON_ONCE(total_sg > vq->packed.vring.num && !vq->indirect);
-
 	desc = vq->packed.vring.desc;
 	i = head;
 	descs_used = total_sg;
-- 
2.30.2

