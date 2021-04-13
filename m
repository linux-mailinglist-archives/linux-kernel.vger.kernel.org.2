Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 092ED35D770
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 07:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344654AbhDMFsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 01:48:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51055 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344616AbhDMFsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 01:48:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618292875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OW6XlN+3Md7fOqRvuUIIBXiaDESq3bj/UWHZYxmw3rg=;
        b=ClIRzwhreS7aZEKHt9mr1PUBsdXJvNs4EqpKWALiTzXBbuao9+9vw82RUaapQDga25Ti60
        jzRohc87eJ+blhmQ85bGmCt7Hagqhc+henjGQ7ZboZv7aDcMkhFpPWpkAfGFkvMJcmb/2L
        r3GZvp+EtAsWvw4C7c8dn3ZeNDW+5To=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-549-BGz2s0lAPPWtiGCJKucqZw-1; Tue, 13 Apr 2021 01:47:53 -0400
X-MC-Unique: BGz2s0lAPPWtiGCJKucqZw-1
Received: by mail-wr1-f69.google.com with SMTP id h16so314687wrq.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 22:47:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OW6XlN+3Md7fOqRvuUIIBXiaDESq3bj/UWHZYxmw3rg=;
        b=echBEqmE/rGNkMxmU5kltjh1x2/lz+8fq0ePZRFH3gormOU2OYxSRhul862SZep17n
         otlSellaJwVbq0Uh01tdTVWmB8oO7DNBjDVwZGx6+osZVk/LqkT3iB0ZAxQWB3F9ZdPt
         RIx3hlZ4RXLRVSsWZ4Uk5s0ce7GZ/X7+1AetxDuAgCtzqVTJ2SpBnjV3qvr5RGIuRDbq
         ibqPRXVm9ttCOsQiu/LO9nGoMRwrOIeT+/uQJJ8nv71Mtm6pLpaCoW7N1DWrpLpjgZz4
         sr3N1SlozTAqjcDd9p2qMLpg0Sf001sSxvi82GvJIoenB8zKxZkRqqXVLbhBbQJ8H/tK
         eGVg==
X-Gm-Message-State: AOAM5325WvI+n2uMLD9CpMxU6fO5dDWv3MNC+3XfDTNcketBu2LTdVds
        N+X8o+wn6tZqbvp+GblfWmuf5Ll1ZFWRqe+lhNrtTvAJrZ2amosz9x0plt45oZOfHgLd6sXZmL5
        cxwPJu6YP0js7Cr5RmpW/EuLiOfP/7WHuTrP9J2jvwtsGu6L+UFeohOcJ7+7EvbBl5anhhQ==
X-Received: by 2002:adf:a119:: with SMTP id o25mr3698470wro.36.1618292872382;
        Mon, 12 Apr 2021 22:47:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzugrMCgHzBRCH7TNerR9Wptk76ORGx3gbjK146NAkH2Klahpt7Wxc88266ddtl1FWE9ool+Q==
X-Received: by 2002:adf:a119:: with SMTP id o25mr3698453wro.36.1618292872241;
        Mon, 12 Apr 2021 22:47:52 -0700 (PDT)
Received: from redhat.com ([2a10:8006:2281:0:1994:c627:9eac:1825])
        by smtp.gmail.com with ESMTPSA id a7sm20378241wrn.50.2021.04.12.22.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 22:47:51 -0700 (PDT)
Date:   Tue, 13 Apr 2021 01:47:49 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jakub Kicinski <kuba@kernel.org>, Jason Wang <jasowang@redhat.com>,
        Wei Wang <weiwan@google.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH RFC v2 2/4] virtio_net: disable cb aggressively
Message-ID: <20210413054733.36363-3-mst@redhat.com>
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

There are currently two cases where we poll TX vq not in response to a
callback: start xmit and rx napi.  We currently do this with callbacks
enabled which can cause extra interrupts from the card.  Used not to be
a big issue as we run with interrupts disabled but that is no longer the
case, and in some cases the rate of spurious interrupts is so high
linux detects this and actually kills the interrupt.

Fix up by disabling the callbacks before polling the tx vq.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/net/virtio_net.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 82e520d2cb12..16d5abed582c 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1429,6 +1429,7 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
 		return;
 
 	if (__netif_tx_trylock(txq)) {
+		virtqueue_disable_cb(sq->vq);
 		free_old_xmit_skbs(sq, true);
 		__netif_tx_unlock(txq);
 	}
@@ -1582,6 +1583,7 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 	bool use_napi = sq->napi.weight;
 
 	/* Free up any pending old buffers before queueing new ones. */
+	virtqueue_disable_cb(sq->vq);
 	free_old_xmit_skbs(sq, false);
 
 	if (use_napi && kick)
-- 
MST

