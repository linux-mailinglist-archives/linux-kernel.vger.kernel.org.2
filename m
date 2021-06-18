Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEE33AC4FD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 09:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbhFRH2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 03:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhFRH2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 03:28:41 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF34FC061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 00:26:32 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id l11so899582pji.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 00:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NaPLJv2BzEhUsPaQAxy+48N9VrDocNOsqp86ck4l+9g=;
        b=kl+eAGY0bop1gtMFvXFFw7wgabA5Jjlg8lyakABqaX4uB9chpzr/uypn6MMmG5S1r4
         elH5N8rBNLKlXp8EELQ84Rs5/4bZXnZkAGNYSLj3PTzs/iQYl0Sn9L79U44NH921ltup
         4gjtaAsKTKijnc3Stm730QKRJJb90f/kQXBxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NaPLJv2BzEhUsPaQAxy+48N9VrDocNOsqp86ck4l+9g=;
        b=qITWeEaGFv/kDxr/M/o0z7FX4nJozLJUvUiK9Fy2QwXSjwNOwdr+F7oAPXHhGwikA/
         8wF19tRR8E133Q9yhghh+b72dgoGdTfDxD3yB3humg6mV5NSXyR+8sYQIFm34qlBQwd3
         kDtGWboBCl051JZQXfIKQO2dkRPMku3Z0P43U44qF0Yn5TvsyqdpLELzARCtEoSuBLDi
         iOk7nFjyKexH7o+ky1xjv5HX3AIyQlefTpIpi92PnTNKUOYh+pUxlpDC7lh5XnicGQdV
         ezRTeJGyrUxepyq3OmL4qwgRpK7Y9NgxyumY0HONjZLzzzv7yrEUSegm21XybjL9APmr
         Zbeg==
X-Gm-Message-State: AOAM533qMcWn3xzOnWCuoSwYVMCphIwDNGuckdrrmuFanfbntNyYh/Mg
        r2OvHGnL9cFzrYBQWpJDQtypFw==
X-Google-Smtp-Source: ABdhPJy1Gu/L82SBitygYFdu94e/0KikikH2dMJHjLkia1iRelC4nycssz+PMsEZNGz+rnswbaFFGA==
X-Received: by 2002:a17:90a:3c8d:: with SMTP id g13mr2795447pjc.229.1624001192365;
        Fri, 18 Jun 2021 00:26:32 -0700 (PDT)
Received: from keiichiw1.tok.corp.google.com ([2401:fa00:8f:203:4a7c:6717:f2ac:491e])
        by smtp.gmail.com with ESMTPSA id v15sm8249986pgf.26.2021.06.18.00.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 00:26:31 -0700 (PDT)
From:   Keiichi Watanabe <keiichiw@chromium.org>
To:     netdev@vger.kernel.org
Cc:     chirantan@chromium.org, "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Keiichi Watanabe <keiichiw@chromium.org>
Subject: [PATCH] virtio_net: Enable MSI-X vector for ctrl queue
Date:   Fri, 18 Jun 2021 16:26:25 +0900
Message-Id: <20210618072625.957837-1-keiichiw@chromium.org>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we use vhost-user backend on the host, MSI-X vector should be set
so that the vmm can get an irq FD and send it to the backend device
process with vhost-user protocol.
Since whether the vector is set for a queue is determined depending on
the queue has a callback, this commit sets an empty callback for
virtio-net's control queue.

Signed-off-by: Keiichi Watanabe <keiichiw@chromium.org>
---
 drivers/net/virtio_net.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 11f722460513..002e3695d4b3 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2696,6 +2696,11 @@ static void virtnet_del_vqs(struct virtnet_info *vi)
 	virtnet_free_queues(vi);
 }
 
+static void virtnet_ctrlq_done(struct virtqueue *rvq)
+{
+	/* Do nothing */
+}
+
 /* How large should a single buffer be so a queue full of these can fit at
  * least one full packet?
  * Logic below assumes the mergeable buffer header is used.
@@ -2748,7 +2753,7 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
 
 	/* Parameters for control virtqueue, if any */
 	if (vi->has_cvq) {
-		callbacks[total_vqs - 1] = NULL;
+		callbacks[total_vqs - 1] = virtnet_ctrlq_done;
 		names[total_vqs - 1] = "control";
 	}
 
-- 
2.32.0.288.g62a8d224e6-goog

