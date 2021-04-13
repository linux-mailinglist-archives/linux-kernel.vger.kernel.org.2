Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B67CA35D775
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 07:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344092AbhDMFs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 01:48:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44834 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344637AbhDMFsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 01:48:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618292880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QGJBfGcLgKMi1+/2KjTQyyM9awqMoNgF1ipdHiAyD40=;
        b=KFJmODUs9bg1g3CTvYREH5ojlYv8wpBMibY4n03+MGDQ4x0ZdfqW2aB6oa1tIU6xyz6xZC
        hqI/ORvv2kDqBkdIhbCEDrE7DlARI3ZcZjeHl7R/owlg0xPQte02Xc718/0c7sb8RiAFFr
        Z96hXkDFThtaBW/x4RSb0adlP3OD5Ck=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-r68-Ak5ePCiSTZxsQ7R27w-1; Tue, 13 Apr 2021 01:47:58 -0400
X-MC-Unique: r68-Ak5ePCiSTZxsQ7R27w-1
Received: by mail-wr1-f72.google.com with SMTP id a15so303673wrf.19
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 22:47:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QGJBfGcLgKMi1+/2KjTQyyM9awqMoNgF1ipdHiAyD40=;
        b=HHCwGyM9pYl/CyxUnukp9c5eMCJguEWXtJZ83jv8cgksW/o0XUbB6PPiAAvGgOLdh7
         4RR+Kydtm4nXB6YT6XjqiuiqDEnCAUE0bgUOMlp84yssp2yoRVVE3pECLvtif+4fKwq4
         txtjpg6b+Dkio8XRVtMXdPx+GrNbY2PZj7u6ZJ0jDNUtqiqxjyrgLCpJrZQulQJgX/e8
         IBNFuVABOp/RpPwCcNb2HNO6Ilu7MO3XhYVkSfiI0VgR2OQn/Lku2O/crWuBV6DAcNTt
         LdhjcfIw+34XFyLw81NJ3i/2f3baNOOMrLqayZ4yTOk2t/wbML5xDFtOUDQuuRZKV5r/
         A8Kg==
X-Gm-Message-State: AOAM531dnEGGfm+8hB/SARFYuoue9oa8rQzWOdoOPPMK/kjGQS8M4DSr
        bBD7gxMYpKhiSYrs9bvcqD/b7sc38qbNnIAWxPI83R8t7qdmsnCBS/akSvTJCSrggD/dIKmOvZe
        /Gnwlo5mZUjN468HyACqNUtI/9x4jyRAm9sZmeS6dF8sFAGsr4SLsT5cKNrefTe3bfPnYdA==
X-Received: by 2002:a1c:6a06:: with SMTP id f6mr2254275wmc.179.1618292877213;
        Mon, 12 Apr 2021 22:47:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwW5ocyM6oF51LY1hu/Bl53XZpnXsl6/4JelfE4ZTpiVul59teVVfXyx5S11Km6LpSBfopV3w==
X-Received: by 2002:a1c:6a06:: with SMTP id f6mr2254249wmc.179.1618292877015;
        Mon, 12 Apr 2021 22:47:57 -0700 (PDT)
Received: from redhat.com ([2a10:8006:2281:0:1994:c627:9eac:1825])
        by smtp.gmail.com with ESMTPSA id a8sm20895382wrh.91.2021.04.12.22.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 22:47:56 -0700 (PDT)
Date:   Tue, 13 Apr 2021 01:47:54 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jakub Kicinski <kuba@kernel.org>, Jason Wang <jasowang@redhat.com>,
        Wei Wang <weiwan@google.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH RFC v2 4/4] virtio_net: move txq wakeups under tx q lock
Message-ID: <20210413054733.36363-5-mst@redhat.com>
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

We currently check num_free outside tx q lock
which is unsafe: new packets can arrive meanwhile
and there won't be space in the queue.
Thus a spurious queue wakeup causing overhead
and even packet drops.

Move the check under the lock to fix that.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/net/virtio_net.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 460ccdbb840e..febaf55ec1f6 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1431,11 +1431,12 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
 	if (__netif_tx_trylock(txq)) {
 		virtqueue_disable_cb(sq->vq);
 		free_old_xmit_skbs(sq, true);
+
+		if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
+			netif_tx_wake_queue(txq);
+
 		__netif_tx_unlock(txq);
 	}
-
-	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
-		netif_tx_wake_queue(txq);
 }
 
 static int virtnet_poll(struct napi_struct *napi, int budget)
@@ -1519,6 +1520,9 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
 	virtqueue_disable_cb(sq->vq);
 	free_old_xmit_skbs(sq, true);
 
+	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
+		netif_tx_wake_queue(txq);
+
 	opaque = virtqueue_enable_cb_prepare(sq->vq);
 
 	done = napi_complete_done(napi, 0);
@@ -1539,9 +1543,6 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
 		}
 	}
 
-	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
-		netif_tx_wake_queue(txq);
-
 	return 0;
 }
 
-- 
MST

