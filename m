Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D65A3DC473
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 09:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbhGaHbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 03:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbhGaHbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 03:31:15 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C494AC06175F
        for <linux-kernel@vger.kernel.org>; Sat, 31 Jul 2021 00:31:08 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id k1so13738416plt.12
        for <linux-kernel@vger.kernel.org>; Sat, 31 Jul 2021 00:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ixvu1XEGmErQ2qL4BETMLAH7Hfa5i4XGX4pSY/08eRM=;
        b=UVOfiyFjSOPhnd9YgU/y8Vy0AyLJkmUoykGQbUzZ/svRuCPBrMJUwoLwDEEd9fuDT/
         aKlkORWilmFJHRWejoKVMotXNvoRVlXTMTwecaAR/9leo9iqbOzCIZIAoeEZ3p2N7n4e
         ypriOK9bR3/koVtfejTDMaqGQeLXMd2RnG7Hz+X6ErgDRpSzh1ljLojsMNwj+eMLzNug
         4cTrV2g/jUWu2pgFoQnfD+t7VDvULn/2h4CFSxTSHmdUXuF36V6rmlHlg1j/pXgBwnhx
         l/9k2PtPFixDDXy7+eT/2Fhy2aarEa8MScmHcezb0Yc63fr3RuO3Toy68OH/0C4940NG
         1tWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ixvu1XEGmErQ2qL4BETMLAH7Hfa5i4XGX4pSY/08eRM=;
        b=uDUjBs5uwGEVMIx7U7qLHWvEfwhT8g/djm4S19f04QmwouQJUno5ak9F3ieacNFlOU
         aTDQ+h2p4OCNIdl5qGaSYDFWsEAhPv3VqjKBM3fI9lwjmFh+mQNTgKo0l9wQq3K3L/pN
         WgB8Nx7/REZ8xk2Y4xtcC2c5iz+OHw8UWofzz0gFCDl6BPwZcSiCJBm0OU7ceaPMQcFN
         kMPGXiawqUGLUfhOYyZ4BzllZdRsfzC+ra2Yw+v6u8ZnhJMW1sgsg7AoZEIO1oi/1cdN
         uptnozNrjnIiUX+yqj+3Monvi9pn+6v5/WRZexxrM34nBAxmWsi98sTxNJG3teFT2+1Z
         iByA==
X-Gm-Message-State: AOAM533RFOp+arNJyvM3aaZZ6+gKKek9UN/iqVVH+qWaH+HO/W80tZPd
        YmNaa0J16GzIxo2BJDiG8MQ=
X-Google-Smtp-Source: ABdhPJyfOctsm0ZR+7H0I0bz01K3VNl0dsYentIfKEybvfc+6f+QvMe9y33bXwk5ETdtZcLqtLobFQ==
X-Received: by 2002:a63:1d41:: with SMTP id d1mr5703450pgm.199.1627716668396;
        Sat, 31 Jul 2021 00:31:08 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.29])
        by smtp.gmail.com with ESMTPSA id z124sm5411949pgb.6.2021.07.31.00.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 00:31:07 -0700 (PDT)
From:   Tuo Li <islituo@gmail.com>
To:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        baijiaju1990@gmail.com, Tuo Li <islituo@gmail.com>,
        TOTE Robot <oslab@tsinghua.edu.cn>
Subject: [PATCH] lightnvm: fix possible uninitialized-variable access in nvme_nvm_submit_user_cmd()
Date:   Sat, 31 Jul 2021 00:30:42 -0700
Message-Id: <20210731073042.49139-1-islituo@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable metadata_dma is not initialized at the beginning of the
function nvme_nvm_submit_user_cmd(). If the parameter ubuf is NULL, it
remains uninitialized at the label err_meta. However, it is accessed
through the function dma_pool_free() if meta_buf is not NULL and
meta_len is not zero. In fact, ubuf, meta_buf and meta_len can come from
user space which indicates this can happen.

To fix this possible bug, only when ubuf and meta_buf are not NULL, and
bufflen and meta_len are not zero, the function dma_pool_free() is
called.

Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
Signed-off-by: Tuo Li <islituo@gmail.com>
---
 drivers/nvme/host/lightnvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index e9d9ad47f70f..3d9fd098bd83 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -835,7 +835,7 @@ static int nvme_nvm_submit_user_cmd(struct request_queue *q,
 			ret = -EFAULT;
 	}
 err_meta:
-	if (meta_buf && meta_len)
+	if (ubuf && bufflen && meta_buf && meta_len)
 		dma_pool_free(dev->dma_pool, metadata, metadata_dma);
 err_map:
 	if (bio)
-- 
2.25.1

