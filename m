Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E64D338275A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 10:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235693AbhEQIrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 04:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235643AbhEQIry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 04:47:54 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307CAC061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 01:46:38 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id cu11-20020a17090afa8bb029015d5d5d2175so2461159pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 01:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sLXeBQQWNddU3paGe6TIgPMxeP94ZGWLCjcCxIFW8uQ=;
        b=1KnDZ9uvm8py1bNkurV0Cy1pu8uUrxCBrWZ1rJL/WtWTUUNe3Kf31gxPhtHNJJl8mX
         5EFyckAdodf3ju2OCfpcPkaoDMsa/gLQ9Suxq1qEupF1wz0uWq9Bi5m9i7SE8w7ng9OI
         1ge/VB0/YazwIqR1QDONHfhT9JiJXlHakGBbtgeq+cN4WBSIIVuCcQUkEpIgERB3LzWi
         VmTyegozR1gjrSBLrYaqhT47++09djUklII1mn2lfjKFlLoBxP1HTtifwYyyHhE3uAAu
         1rjPymqn/KHbDU9wOq+sdj06sGp0OH4dWEPbeIh1BUhiAL/JygiS3hCrDEUo15nHFIq0
         kZug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sLXeBQQWNddU3paGe6TIgPMxeP94ZGWLCjcCxIFW8uQ=;
        b=E0YUpKBLPDQTar5WeftEhyTP5R+P6Zl+uZYYH6AvLqyGtQaTWIZG5pCjq2hwwc2YnT
         w+33G9+JG2H7ZdJuyDSUZcpWUZFbQFBRDmGWBTRgs9ZRFwzyGlZMlZ9G5VjBKoa64we6
         qnrZUJMdrb8BKpjKHrqP40NNohoRSpkM5xMMbBvWmS0fUKoBexAVARla3OdIcpKG7vSM
         aXlv8zYdzLNUOAxjwhJiKPCGpnt4OavY6B6ZzYBACSMkho8Wxoi1MC9hyjlg3J48OUmL
         Ljf+Wae0K5N+B2FryFN2yV9quutuT6ULqrgacEHZYOQ4CbwVkgAZO3szGodQKCS6mrN4
         DMOg==
X-Gm-Message-State: AOAM531HBEH38qgTj4bjwAFLkQy6POkBHsCGqcuhAMd7hAq2oZ2bx4SC
        7Ls0n4eY8IpoH5P4RARE9kqo
X-Google-Smtp-Source: ABdhPJxU8ZlEVgUkvasetoWUr1ahQFgEH/ad/4xpqkLRvV7aewN79NnT6BWe33RrHm7ekvkcKShVdQ==
X-Received: by 2002:a17:90a:6e03:: with SMTP id b3mr1777539pjk.12.1621241197799;
        Mon, 17 May 2021 01:46:37 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id 11sm4792063pfh.182.2021.05.17.01.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 01:46:37 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] virtio_net: Fix error handling in virtnet_restore()
Date:   Mon, 17 May 2021 16:45:16 +0800
Message-Id: <20210517084516.332-1-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do some cleanups in virtnet_restore() when virtnet_cpu_notif_add() failed.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/net/virtio_net.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7be93ca01650..5ca7d6780add 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3250,8 +3250,11 @@ static __maybe_unused int virtnet_restore(struct virtio_device *vdev)
 	virtnet_set_queues(vi, vi->curr_queue_pairs);
 
 	err = virtnet_cpu_notif_add(vi);
-	if (err)
+	if (err) {
+		virtnet_freeze_down(vdev);
+		remove_vq_common(vi);
 		return err;
+	}
 
 	return 0;
 }
-- 
2.11.0

