Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6684039123A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 10:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbhEZI0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 04:26:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30090 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232412AbhEZI0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 04:26:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622017482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7hXo1aGEjC6ReUwtGmib1qGT2W6hQwxMtry8MQ3+Q5s=;
        b=hTx6rfxs2wewpZMYJhbtJuAYKzGMhgGGFzTMeLoTJ3rDD5OyKAsTc1jqbNJ9nw6BcYTgAG
        j/BWDZTwoTkAyCgjczrORk8nosJ4syUhcpFbWfOGHt155KU12YUlk89ZKtJn+0MJM8odMa
        yveD2wIPfYA2mYrieN2seDfExymYM6M=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-576-qAdkXDz5OHa-GfJQoysMug-1; Wed, 26 May 2021 04:24:40 -0400
X-MC-Unique: qAdkXDz5OHa-GfJQoysMug-1
Received: by mail-wr1-f72.google.com with SMTP id g3-20020adfd1e30000b02901122a4b850aso22797wrd.20
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:24:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7hXo1aGEjC6ReUwtGmib1qGT2W6hQwxMtry8MQ3+Q5s=;
        b=qIe1OGK+Xglrg27K41FT/yrk8wSKpRTBmgQ5GJOc9v/cMIKALGvg0YisSV6FFMDgLk
         xXfgnGq9be1PADm4tRCqaBqiNA1/t7VvTkd2miyxbRsvkuNUXsCth2mUQLxM3MsotNiE
         Wm8EXMpeZAPga6Qy0W83nR3ph/owcyFUkLY5gYcybdXa0IOwVv0UoCweCIh/JOY85KVG
         Zog9F2N60B7tJZfnp2G5BC0vwpJnphZltSvVAJgB6Z1nH5QhznzZUgqZzi6kzaMLWrfx
         NXtQLkuSvlEp9sOP4DbfpiDdHHbeyP6O2f8RYRZNaNPmEx5HMpKmGWTfDd1bWnwEXBpP
         sytQ==
X-Gm-Message-State: AOAM5326xk1YoeTWcNElT/h7Rl0JqxDc41Kub3pPhKmwsx5iKwhaQGEI
        bfAJtrnT1OTKJbZWCH0AHFHQYCTIIsh7GJUbTARUps1VUTK1dXeWhfBuPMWKiA+n5xxfLbTABGF
        wRG6WHC9SaKPUvf/UzEQdFTDGXTfFFJqXoKGBQs2HXFvODVJPgqNIIf6YeT/gxKoZk6P5kA==
X-Received: by 2002:a1c:3d05:: with SMTP id k5mr1578843wma.9.1622017477951;
        Wed, 26 May 2021 01:24:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxU85p8gyLrf0vuWCAB2u049QkVe1v5Zh6lkfS/y/mIz9iaRTlYd6RVbAfTvvyvkld+1u+lAw==
X-Received: by 2002:a1c:3d05:: with SMTP id k5mr1578819wma.9.1622017477718;
        Wed, 26 May 2021 01:24:37 -0700 (PDT)
Received: from redhat.com ([2a10:8006:fcda:0:90d:c7e7:9e26:b297])
        by smtp.gmail.com with ESMTPSA id g6sm5469484wmg.10.2021.05.26.01.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 01:24:37 -0700 (PDT)
Date:   Wed, 26 May 2021 04:24:35 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jakub Kicinski <kuba@kernel.org>, Wei Wang <weiwan@google.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>,
        virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH v3 1/4] virtio_net: move tx vq operation under tx queue lock
Message-ID: <20210526082423.47837-2-mst@redhat.com>
References: <20210526082423.47837-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526082423.47837-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's unsafe to operate a vq from multiple threads.
Unfortunately this is exactly what we do when invoking
clean tx poll from rx napi.
Same happens with napi-tx even without the
opportunistic cleaning from the receive interrupt: that races
with processing the vq in start_xmit.

As a fix move everything that deals with the vq to under tx lock.

Fixes: b92f1e6751a6 ("virtio-net: transmit napi")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/net/virtio_net.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index ac0c143f97b4..12512d1002ec 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1508,6 +1508,8 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
 	struct virtnet_info *vi = sq->vq->vdev->priv;
 	unsigned int index = vq2txq(sq->vq);
 	struct netdev_queue *txq;
+	int opaque;
+	bool done;
 
 	if (unlikely(is_xdp_raw_buffer_queue(vi, index))) {
 		/* We don't need to enable cb for XDP */
@@ -1517,10 +1519,28 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
 
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

