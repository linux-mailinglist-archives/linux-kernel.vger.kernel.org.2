Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE86B38898B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 10:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245336AbhESIhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 04:37:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39603 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238704AbhESIhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 04:37:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621413356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kBWJsOxt7zpLvOsF815LxI3UC9m1OTmAuh6Ryt/JE9E=;
        b=aJiLDYoWln0YjONM3y6y9dgHjQC72HonGUEZeonmZDgXI3Z1nI+4Y8ZnOLlJWQiS5M6b1G
        0aq3Eyuq4P7EsuxdOaMBvUYU4xe1wsIHmxV3QTJUvrYw0fOSRwrgcBY9na8/O1mKrxc0ja
        xAugJs395DXwAgAU4Zf5GKyHA5UvXGc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-BXnwo6gUP8aqATrSWTbSrA-1; Wed, 19 May 2021 04:35:54 -0400
X-MC-Unique: BXnwo6gUP8aqATrSWTbSrA-1
Received: by mail-wr1-f71.google.com with SMTP id j33-20020adf91240000b029010e4009d2ffso6867199wrj.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 01:35:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kBWJsOxt7zpLvOsF815LxI3UC9m1OTmAuh6Ryt/JE9E=;
        b=gWLrkPNFRabDpuzk27zTBGqIud+961l1Hbj5zGBbMWDbbi+acWStMbloNyjNEWMxuf
         StTgJ3gghIQgX4YS1B2txM48MDCh2hDHBmzilvynTvYJpibunKzn5xYF0xyyPkLkmKo+
         Bj2s4hSUNp8qbd4PgenKkAmBN8Vei2Knn4rmnJa/k1BcTBLBpJfO81NL1q7j4/npZ6jk
         5PxtlkMTtw0hxPv+2tiBSqrWn2tLB7HsLOsixKaDACKAQMM0g2kjwNb3in4gfxOHUxnS
         VYEh0BN/7o6RGlyh6ZJ3M/Gyzj1XhkHFkARYQ1CWTfCECkHmSE71fSeDZJDURC2yJGds
         QmuA==
X-Gm-Message-State: AOAM531zEE9Vr0TegL9WUqn+32kB2YdjGZPab3l26G7bckLaIjFhfkAC
        gaHGYsJ2TifI91jP6cGlTxgqR9+CWJZiWarfyqK6fgfrgw3JOlphL6sH2XXhh/YfQo8XES93CXp
        rPkJMjVCXxUgkSMi9f3bn8EQG
X-Received: by 2002:a5d:438c:: with SMTP id i12mr12654209wrq.44.1621413352511;
        Wed, 19 May 2021 01:35:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnuhdYturThgXAIn2AgmdXSkMy9No+V7eGDQOMjqtANuqtHMvDVHRKxvBEyVM2mlWEq2nttw==
X-Received: by 2002:a5d:438c:: with SMTP id i12mr12654194wrq.44.1621413352319;
        Wed, 19 May 2021 01:35:52 -0700 (PDT)
Received: from redhat.com ([2a10:800c:1fa6:0:3809:fe0c:bb87:250e])
        by smtp.gmail.com with ESMTPSA id y2sm5892806wmq.45.2021.05.19.01.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 01:35:51 -0700 (PDT)
Date:   Wed, 19 May 2021 04:35:48 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Dave Taht <dave.taht@gmail.com>
Cc:     Xianting Tian <xianting.tian@linux.alibaba.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: virtio_net: BQL?
Message-ID: <20210519043201-mutt-send-email-mst@kernel.org>
References: <56270996-33a6-d71b-d935-452dad121df7@linux.alibaba.com>
 <CAA93jw6LUAnWZj0b5FvefpDKUyd6cajCNLoJ6OKrwbu-V_ffrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA93jw6LUAnWZj0b5FvefpDKUyd6cajCNLoJ6OKrwbu-V_ffrA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 11:43:43AM -0700, Dave Taht wrote:
> Not really related to this patch, but is there some reason why virtio
> has no support for BQL?

So just so you can try it out, I rebased my old patch.
XDP is handled incorrectly by it so we shouldn't apply it as is,
but should be good enough for you to see whether it helps.
Completely untested!

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>



diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7be93ca01650..4bfb682a20b2 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -556,6 +556,7 @@ static int virtnet_xdp_xmit(struct net_device *dev,
 			kicks = 1;
 	}
 out:
+	/* TODO: netdev_tx_completed_queue? */
 	u64_stats_update_begin(&sq->stats.syncp);
 	sq->stats.bytes += bytes;
 	sq->stats.packets += packets;
@@ -1376,7 +1377,7 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
 	return stats.packets;
 }
 
-static void free_old_xmit_skbs(struct send_queue *sq, bool in_napi)
+static void free_old_xmit_skbs(struct netdev_queue *txq, struct send_queue *sq, bool in_napi)
 {
 	unsigned int len;
 	unsigned int packets = 0;
@@ -1406,6 +1407,8 @@ static void free_old_xmit_skbs(struct send_queue *sq, bool in_napi)
 	if (!packets)
 		return;
 
+	netdev_tx_completed_queue(txq, packets, bytes);
+
 	u64_stats_update_begin(&sq->stats.syncp);
 	sq->stats.bytes += bytes;
 	sq->stats.packets += packets;
@@ -1434,7 +1437,7 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
 
 	if (__netif_tx_trylock(txq)) {
 		virtqueue_disable_cb(sq->vq);
-		free_old_xmit_skbs(sq, true);
+		free_old_xmit_skbs(txq, sq, true);
 
 		if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
 			netif_tx_wake_queue(txq);
@@ -1522,7 +1525,7 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
 	txq = netdev_get_tx_queue(vi->dev, index);
 	__netif_tx_lock(txq, raw_smp_processor_id());
 	virtqueue_disable_cb(sq->vq);
-	free_old_xmit_skbs(sq, true);
+	free_old_xmit_skbs(txq, sq, true);
 
 	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
 		netif_tx_wake_queue(txq);
@@ -1606,10 +1609,11 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct netdev_queue *txq = netdev_get_tx_queue(dev, qnum);
 	bool kick = !netdev_xmit_more();
 	bool use_napi = sq->napi.weight;
+	unsigned int bytes = skb->len;
 
 	/* Free up any pending old buffers before queueing new ones. */
 	virtqueue_disable_cb(sq->vq);
-	free_old_xmit_skbs(sq, false);
+	free_old_xmit_skbs(txq, sq, false);
 
 	if (use_napi && kick)
 		virtqueue_enable_cb_delayed(sq->vq);
@@ -1638,6 +1642,8 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 		nf_reset_ct(skb);
 	}
 
+	netdev_tx_sent_queue(txq, bytes);
+
 	/* If running out of space, stop queue to avoid getting packets that we
 	 * are then unable to transmit.
 	 * An alternative would be to force queuing layer to requeue the skb by
@@ -1653,7 +1659,7 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 		if (!use_napi &&
 		    unlikely(!virtqueue_enable_cb_delayed(sq->vq))) {
 			/* More just got used, free them then recheck. */
-			free_old_xmit_skbs(sq, false);
+			free_old_xmit_skbs(txq, sq, false);
 			if (sq->vq->num_free >= 2+MAX_SKB_FRAGS) {
 				netif_start_subqueue(dev, qnum);
 				virtqueue_disable_cb(sq->vq);

