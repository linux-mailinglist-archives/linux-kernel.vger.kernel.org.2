Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5154F3C7BD6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 04:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237637AbhGNCcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 22:32:05 -0400
Received: from usmx01.baidu.com ([12.0.243.41]:36328 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237631AbhGNCcE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 22:32:04 -0400
Received: from BC-Mail-HQEX01.internal.baidu.com (unknown [172.31.51.57])
        by Forcepoint Email with ESMTPS id BC7D8C3915508456CFA2;
        Tue, 13 Jul 2021 19:29:09 -0700 (PDT)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-HQEX01.internal.baidu.com (172.31.51.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.10; Wed, 14 Jul 2021 10:29:07 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.4; Wed, 14 Jul 2021 10:29:07 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <sgarzare@redhat.com>, <mst@redhat.com>, <jasowang@redhat.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, Cai Huoqing <caihuoqing@baidu.com>
Subject: [PATCH 2/2] virtio_ring: fix error - 'prev' and 'head_flags' may be used uninitialized in this function
Date:   Wed, 14 Jul 2021 10:28:54 +0800
Message-ID: <20210714022854.1077-3-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210714022854.1077-1-caihuoqing@baidu.com>
References: <20210714022854.1077-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BJHW-Mail-Ex16.internal.baidu.com (10.127.64.39) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

when run "make virtio" in linux/tools,
the error: "'prev' and 'head_flags' may be used
uninitialized in this function" occurs

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/virtio/virtio_ring.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 89bfe46a8a7f..290bdf8a3d36 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -486,7 +486,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
        struct vring_virtqueue *vq = to_vvq(_vq);
        struct scatterlist *sg;
        struct vring_desc *desc;
-       unsigned int i, n, avail, descs_used, prev, err_idx;
+       unsigned int i, n, avail, descs_used, prev = 0, err_idx;
        int head;
        bool indirect;

@@ -1173,8 +1173,8 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
        struct vring_packed_desc *desc;
        struct scatterlist *sg;
        unsigned int i, n, c, descs_used, err_idx;
-       __le16 head_flags, flags;
-       u16 head, id, prev, curr, avail_used_flags;
+       __le16 head_flags = 0, flags;
+       u16 head, id, prev = 0, curr, avail_used_flags;

        START_USE(vq);

--
2.25.1

