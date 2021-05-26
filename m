Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E003A391241
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 10:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbhEZI0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 04:26:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22977 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232918AbhEZI0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 04:26:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622017488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o40Fmid6nNIkbFe8iYePDZhpBrn8pMAYTwjh787uFdE=;
        b=UrltD6GGCKogpgJmWsl/tvfqjsF7qxh0oHrLwDBnktnS8fYMP5+vXD+FQi7gq8eDIORynj
        lDs0TbKAPDsmMsDtwjH2dZB6x3vg1rLihRQMB3c8GKGGaLJL9bMzLZffupEykz+CfjaTHT
        0DAxdl3cTMobY3PaDUpvmhquX6UzIlk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-Tvqqyt16MACINWfpNKFkHw-1; Wed, 26 May 2021 04:24:47 -0400
X-MC-Unique: Tvqqyt16MACINWfpNKFkHw-1
Received: by mail-wm1-f69.google.com with SMTP id 19-20020a05600c2313b0290193637766d9so20579wmo.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:24:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o40Fmid6nNIkbFe8iYePDZhpBrn8pMAYTwjh787uFdE=;
        b=CRhrxuXA2XnUBvFLEf5Vp/9O6MQrrAB/s0Hl9NFTXIcV2IKsEQDHwF5VZi5oP5++Uf
         /EvZT2XXklWwvhSAYWYviqLVyEqCNoAzotP9bjMmIf4tvWcGFx8P1MlHlgJpsmWDWhFe
         gZOj+6gjxqCi2aMEhEYnZmqaFU4sgt/S34hLiP/WhNjAa04PuwLWViXcngLBQoOhJepb
         WVa1rPkTr0ZCRHlH3MCT3ZDDgxQqICWW95384fXYGKRmJJpwKlF08aaS1CGu15tnQwaP
         UozXodOHZkGv366uzwPT4pQDdQJLf9/7tdlyTbx7UFl0BtnlmgCn1l/Gh/Vwf10SGyI1
         /Y3Q==
X-Gm-Message-State: AOAM530JjyU8W/7yH+EVTSz0gehXswF5nYUU2wm/HJddlC/EAOpXkjpE
        JCq44a8YdTDKjwhmlTtuLTH0nnfxIiF3yfmP8YoaSrxEgCiKdjYbbujIxGU5+i719ltiScYbzbV
        iitbTl1br67goWugvTe6loBcXAzbqZB1lnLAWLg8mCYWMYY988+tzawJTmKt/wjs+CrOHzw==
X-Received: by 2002:a1c:f303:: with SMTP id q3mr2246266wmq.9.1622017485603;
        Wed, 26 May 2021 01:24:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy3YaY8d7OxUasPPsyIXLBzSHdDVjW4txQgjFtjWKP91pjY4SLYxtZjAEHxMjzrOAh+TdWZzQ==
X-Received: by 2002:a1c:f303:: with SMTP id q3mr2246253wmq.9.1622017485441;
        Wed, 26 May 2021 01:24:45 -0700 (PDT)
Received: from redhat.com ([2a10:8006:fcda:0:90d:c7e7:9e26:b297])
        by smtp.gmail.com with ESMTPSA id l188sm769420wmf.27.2021.05.26.01.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 01:24:45 -0700 (PDT)
Date:   Wed, 26 May 2021 04:24:43 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jakub Kicinski <kuba@kernel.org>, Wei Wang <weiwan@google.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>,
        virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH v3 4/4] virtio_net: disable cb aggressively
Message-ID: <20210526082423.47837-5-mst@redhat.com>
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

There are currently two cases where we poll TX vq not in response to a
callback: start xmit and rx napi.  We currently do this with callbacks
enabled which can cause extra interrupts from the card.  Used not to be
a big issue as we run with interrupts disabled but that is no longer the
case, and in some cases the rate of spurious interrupts is so high
linux detects this and actually kills the interrupt.

Fix up by disabling the callbacks before polling the tx vq.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/net/virtio_net.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index c29f42d1e04f..a83dc038d8af 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1433,7 +1433,10 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
 		return;
 
 	if (__netif_tx_trylock(txq)) {
-		free_old_xmit_skbs(sq, true);
+		do {
+			virtqueue_disable_cb(sq->vq);
+			free_old_xmit_skbs(sq, true);
+		} while (unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
 
 		if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
 			netif_tx_wake_queue(txq);
@@ -1605,12 +1608,17 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct netdev_queue *txq = netdev_get_tx_queue(dev, qnum);
 	bool kick = !netdev_xmit_more();
 	bool use_napi = sq->napi.weight;
+	unsigned int bytes = skb->len;
 
 	/* Free up any pending old buffers before queueing new ones. */
-	free_old_xmit_skbs(sq, false);
+	do {
+		if (use_napi)
+			virtqueue_disable_cb(sq->vq);
 
-	if (use_napi && kick)
-		virtqueue_enable_cb_delayed(sq->vq);
+		free_old_xmit_skbs(sq, false);
+
+	} while (use_napi && kick &&
+	       unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
 
 	/* timestamp packet in software */
 	skb_tx_timestamp(skb);
-- 
MST

