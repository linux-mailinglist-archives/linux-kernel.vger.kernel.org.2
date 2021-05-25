Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C71038F9B7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 06:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbhEYE6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 00:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhEYE6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 00:58:47 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B723EC061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 21:57:16 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 27so20461421pgy.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 21:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MVbtYXsbtb58fofYDvlHmSwMl/WUynL1P4kD0egGRoM=;
        b=nKCDRI62VfmTotncwa/GaUORw6rjovSULKpffiFrjTnlKGB/C57pD/jMMe5zo8t/z4
         2eZ+s10/ZwA5RPhO3lr0ZKYpT6Icj/KUxd3FsVXVJAOMI1rZU7C1j5OiCrsj9PhZSb3t
         w26prgQiUq4gITsi0EZcZZ6F9MOd2Xky9gh/OiA6HvDIM55smxkWQdfVKr4D5zuJgamj
         /uSAcfdcmMEgCIIYx8zhQALcOJE061nN7nZzKkiqQwrXcIKtMvymhOjosPPd5iwVDBU2
         v8ulII1NReNpIlO/oryuk/hipC/ar5Y2mHIZOAbpzIZmfsU9RvP2hCofePttFkr/QUHN
         EIew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MVbtYXsbtb58fofYDvlHmSwMl/WUynL1P4kD0egGRoM=;
        b=K7hzqHFR9eIAunQpKOcIRTKSC7VYdvncBSBpux+dS//E/l2xi38TKwuNhVBqVFzmGj
         2fz8TjrnKsMLAHoupAYzcmbfOYbzMrsfGP72BUjU9bqMmO5UtLdDJHxTxD4YVQ3mDDnG
         LQ/pczZ4Y0ykGBOQ42YnOUQ6Cc464YPUHolQdR1zcVwzpChXQlNyg9xBcBEXwSG5nw51
         vYxyXLi2DlkGtVEyGnIwddWnD5lz6XcL1fFTa7RvturiaUdR9EkB8qAe7QNNX6irIeFC
         cC5g7/IJJl8+MCBRyIcqpQh6dxdHfrk4neY4alAdlcs0bFMaGjDl6+dKuhNYhjJxBHyk
         3tOw==
X-Gm-Message-State: AOAM5301UBp3s4Anhzym24Nl/10JAEaM0eMGZ5Gnfw4FgR56VyxE9d1s
        9rh36tcPBqpRWH7b55Imj6NX
X-Google-Smtp-Source: ABdhPJxDZ3WIYe92xcVocAerwlrWbOHR2d30JW2mnnK5/jrV73Ufd1cSZ7XvpDO67SWGO3flN85Khw==
X-Received: by 2002:aa7:874a:0:b029:2e7:8407:f8f3 with SMTP id g10-20020aa7874a0000b02902e78407f8f3mr14060907pfo.53.1621918636166;
        Mon, 24 May 2021 21:57:16 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id d22sm12467546pgb.15.2021.05.24.21.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 21:57:15 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     amit@kernel.org, mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] virtio_console: Assure used length from device is limited
Date:   Tue, 25 May 2021 12:53:04 +0800
Message-Id: <20210525045304.1085-1-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The buf->len might come from an untrusted device. This
ensures the value would not exceed the size of the buffer
to avoid data corruption or loss.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/char/virtio_console.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 1c40ca6d76ba..598863e6daf8 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -475,7 +475,7 @@ static struct port_buffer *get_inbuf(struct port *port)
 
 	buf = virtqueue_get_buf(port->in_vq, &len);
 	if (buf) {
-		buf->len = len;
+		buf->len = min(len, buf->size);
 		buf->offset = 0;
 		port->stats.bytes_received += len;
 	}
@@ -1709,7 +1709,7 @@ static void control_work_handler(struct work_struct *work)
 	while ((buf = virtqueue_get_buf(vq, &len))) {
 		spin_unlock(&portdev->c_ivq_lock);
 
-		buf->len = len;
+		buf->len = min(len, buf->size);
 		buf->offset = 0;
 
 		handle_control_message(vq->vdev, portdev, buf);
-- 
2.11.0

