Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9D1A3CC264
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 12:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbhGQKMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 06:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232993AbhGQKM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 06:12:26 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FDCC06175F
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 03:09:29 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id g4-20020a17090ace84b029017554809f35so10288460pju.5
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 03:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=83GbSGpZBfJHGXq15Yg2ngQ7/7/5XwVRHY0b6SDhljI=;
        b=uyXB+/16nvqrz8OL63K/aowqr/Mq1BwOMmDr72vNEAEScOUTTnm6SSGvF+7rT2Dgcc
         KAaxegtG0c2E5MqZqFgrQi7mXbG5gTKdIXV1ewE+kqwHm3m/31T6RjUeyzLSEfrgQGe5
         oU2E1Ke4aSeZ7P9uNVPxWhRRkcmgVn5AOjrOhRcbVyzcHmjyuipoRoWPK2E2yeYBVvJ/
         etVdo8RG4HSWZRau145JybWep6I7xLI1pw+NdAK3m+Wtt6J7Rp4CkKv9NC05XatnC9Xx
         h9x+XMC3KoTFBdcQQJmkO8uX/FzxE6AUsCeCST/DmMtSIFch2SlP5QpbALz0/ExX+yo7
         feOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=83GbSGpZBfJHGXq15Yg2ngQ7/7/5XwVRHY0b6SDhljI=;
        b=P8wp2PComu6OS25xiKdFpTzYH92QVs+STO47Q4n8+mZuVYtFzEJc7mTvqrFH0xqdSH
         ibn0knTHxoEPMbO6UmjQDWqUOrkjkqvcwxKCk2xMpVd/8M1EsdCVSy5O/rRRZBKWXV0e
         lMUm9KmIBdsI2ACw6+nmAylQKUeYLoXVUVQApFK92kge+Lpb2P88rpdR6cJYZPrbhUK1
         BZCT+gdhXnANv7NEgLNbfSxV6xu6rh5p/AHHnHMKesF7zGYyUWKTjxB5L3hz9AT7XCVw
         94wVo0CiOU6Hqqp9goFVKxL45i003Nn70jnZZ22g48FJCACaGtcXkJTbQOLSBoH6UUnk
         2RIw==
X-Gm-Message-State: AOAM531tfIdfGVnTMN+gck/PXO9PGCPduQ6U/n166v3htS46glAqS9YE
        L9J2ziYlkbU9E7RxK0rBU1VF7lejrgCZqFKdT3A=
X-Google-Smtp-Source: ABdhPJzLcYMp6ta5QAnBuXu8Uqc4NgXwYejLU9B7Rfgy3g02aqr/l8DR6Z3DASRCSSw/6zqZKTBXUQ==
X-Received: by 2002:a17:902:9a8c:b029:113:d891:2eaf with SMTP id w12-20020a1709029a8cb0290113d8912eafmr11286452plp.61.1626516568517;
        Sat, 17 Jul 2021 03:09:28 -0700 (PDT)
Received: from localhost.localdomain ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id p24sm13487926pfh.17.2021.07.17.03.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 03:09:27 -0700 (PDT)
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Hillf Danton <hdanton@sina.com>
Subject: [PATCH] mtd: fix lock hierarchy in deregister_mtd_blktrans
Date:   Sat, 17 Jul 2021 18:07:19 +0800
Message-Id: <20210717100719.728829-1-desmondcheongzx@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a lock hierarchy of major_names_lock --> mtd_table_mutex. One
existing chain is as follows:

1. major_names_lock --> loop_ctl_mutex (when blk_request_module calls
loop_probe)

2. loop_ctl_mutex --> bdev->bd_mutex (when loop_control_ioctl calls
loop_remove, which then calls del_gendisk)

3. bdev->bd_mutex --> mtd_table_mutex (when blkdev_get_by_dev calls
__blkdev_get, which then calls blktrans_open)

Since unregister_blkdev grabs the major_names_lock, we need to call it
outside the critical section for mtd_table_mutex, otherwise we invert
the lock hierarchy.

Reported-by: Hillf Danton <hdanton@sina.com>
Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
---
 drivers/mtd/mtd_blkdevs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
index 7d26cfe24d05..87e26788ef60 100644
--- a/drivers/mtd/mtd_blkdevs.c
+++ b/drivers/mtd/mtd_blkdevs.c
@@ -563,8 +563,8 @@ int deregister_mtd_blktrans(struct mtd_blktrans_ops *tr)
 	list_for_each_entry_safe(dev, next, &tr->devs, list)
 		tr->remove_dev(dev);
 
-	unregister_blkdev(tr->major, tr->name);
 	mutex_unlock(&mtd_table_mutex);
+	unregister_blkdev(tr->major, tr->name);
 
 	BUG_ON(!list_empty(&tr->devs));
 	return 0;
-- 
2.25.1

