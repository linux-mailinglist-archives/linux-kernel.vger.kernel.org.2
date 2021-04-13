Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDAB335D773
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 07:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344615AbhDMFsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 01:48:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52109 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344626AbhDMFsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 01:48:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618292877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6jg8BCGbpMnOAIkNzLWva23V8vKuJlUTOTl6SMonbbA=;
        b=fCcIv0LYgGUpI8R06kINj2Jh34BmCIIfIuoetroiTYty4A2JGQtDL4igiaQWCwOQEFArjc
        bCobrZCu35REpTam5WI06+FGj6zHGb2FaJ2X/fhzEwJma83X87OOoLYSRImFMsHym8QE8W
        ZMcfzjjLtaQ9xTVWJ5VZvR7eGINma8M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-597-i1lePNbiPquKNemhZgov1Q-1; Tue, 13 Apr 2021 01:47:56 -0400
X-MC-Unique: i1lePNbiPquKNemhZgov1Q-1
Received: by mail-wr1-f71.google.com with SMTP id j4so304526wru.20
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 22:47:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6jg8BCGbpMnOAIkNzLWva23V8vKuJlUTOTl6SMonbbA=;
        b=K0ff6xouLq0tqrgoHSPtu0CQIfZe97tVb390oz1nRbylfvQESBw7ODMqlN9wzL+rFL
         HdoJQkHrpddYlOyS2OuUPD7zli1mcRcgLraM01oYGpU3Q0aeyEyNoZNR+aRU5LRAMAoN
         GLcPmUqsgGT5AY74K9lmYkVgKKyZXsV7kukpIe/v18xV4R6lZpH3ObEKjrCONJNkRtgX
         tGjmdewWvjcQEZ50fhQytH/mxkkm26mcuJzVAUX4H/5sVxY7sjzleqJc8ATI/6oBQVvS
         W3HolmMCzIqEv34S0QPPMScaHSjgE439aCvSorksT9sNBeEbnmKazIybNWRxLxmTYxy+
         MeLA==
X-Gm-Message-State: AOAM533wHOCF9b0corJcVAdP6QF3pjqfzU9l78T0eaSG70c/IOgEoadQ
        2PMHMW5Qpnea6JoUKS3xP0D4VGtLf4TuFW00CkTCLLHw5yMEVc3HHSLlKj/1ZVTdiRu0ZL1jg6u
        hVm4Cu9g4p8wUiaiB9pgT9fNFr8J9VyaCz/gtICDysrRIMVRP7/oc81G+w/sqBJJpwJVL5A==
X-Received: by 2002:a5d:4e08:: with SMTP id p8mr35572390wrt.4.1618292874845;
        Mon, 12 Apr 2021 22:47:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwlOFgyL/tLR6N8M+xp6zE98QryIgkrAWDLF0SSu1myLxGcVLWj/Riydxj6MeQAxcymfF/BrA==
X-Received: by 2002:a5d:4e08:: with SMTP id p8mr35572375wrt.4.1618292874631;
        Mon, 12 Apr 2021 22:47:54 -0700 (PDT)
Received: from redhat.com ([2a10:8006:2281:0:1994:c627:9eac:1825])
        by smtp.gmail.com with ESMTPSA id i4sm1264707wmq.12.2021.04.12.22.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 22:47:54 -0700 (PDT)
Date:   Tue, 13 Apr 2021 01:47:52 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jakub Kicinski <kuba@kernel.org>, Jason Wang <jasowang@redhat.com>,
        Wei Wang <weiwan@google.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH RFC v2 3/4] virtio_net: move tx vq operation under tx queue
 lock
Message-ID: <20210413054733.36363-4-mst@redhat.com>
References: <20210413054733.36363-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210413054733.36363-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's unsafe to operate a vq from multiple threads.
Unfortunately this is exactly what we do when invoking
clean tx poll from rx napi.
As a fix move everything that deals with the vq to under tx lock.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/net/virtio_net.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 16d5abed582c..460ccdbb840e 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1505,6 +1505,8 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
 	struct virtnet_info *vi = sq->vq->vdev->priv;
 	unsigned int index = vq2txq(sq->vq);
 	struct netdev_queue *txq;
+	int opaque;
+	bool done;
 
 	if (unlikely(is_xdp_raw_buffer_queue(vi, index))) {
 		/* We don't need to enable cb for XDP */
@@ -1514,10 +1516,28 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
 
 	txq = netdev_get_tx_queue(vi->dev, index);
 	__netif_tx_lock(txq, raw_smp_processor_id());
+	virtqueue_disable_cb(sq->vq);
 	free_old_xmit_skbs(sq, true);
+
+	opaque = virtqueue_enable_cb_prepare(sq->vq);
+
+	done = napi_complete_done(napi, 0);
+
+	if (!done)
+		virtqueue_disable_cb(sq->vq);
+
 	__netif_tx_unlock(txq);
 
-	virtqueue_napi_complete(napi, sq->vq, 0);
+	if (done) {
+		if (unlikely(virtqueue_poll(sq->vq, opaque))) {
+			if (napi_schedule_prep(napi)) {
+				__netif_tx_lock(txq, raw_smp_processor_id());
+				virtqueue_disable_cb(sq->vq);
+				__netif_tx_unlock(txq);
+				__napi_schedule(napi);
+			}
+		}
+	}
 
 	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
 		netif_tx_wake_queue(txq);
-- 
MST

