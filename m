Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2B343A110A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 12:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238821AbhFIK07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 06:26:59 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:38489 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238805AbhFIK0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 06:26:52 -0400
Received: by mail-lj1-f170.google.com with SMTP id s22so10545872ljg.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 03:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7RcDq8BcfTAWvH1WjeQwKK7cYkn1EkqelTe3jQATvG4=;
        b=ozpM35nWXWBjw5iUr59+oW0hcacsvLGFrjStft3HGELn8/8ScTMkxs4XPjEmtlo/BN
         ZUyvZD+GH0yxF8V9U8dQnKU8fPdl+wun5GkDI0U2GJt0Xv92w9xAo9PWaAi0VHA8PXW+
         I6A6fYa98bjoZ563pMDdIzgn/Ta76RMVZQ7T4kINmT1u2SAYW/SkhEF09H1UI6SF+QTY
         w0P85B/IPraoS/NZEmjn8As+YnIg7xiqoOyRilivQ3E7U9qsItvotMr6vqzUXe2p72Dx
         ZuZLGwsyOTZMi+GOI0cDJeYJHZLoTWlt7/ldmiprb7nEoIfghaB/w77zPbo9PDbEpG69
         aRwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7RcDq8BcfTAWvH1WjeQwKK7cYkn1EkqelTe3jQATvG4=;
        b=kQZY/OG215YPWFcrrEbG7w1DVYeTh6SbPa7KfOQvdulf5o2Hhu9c2seViOV0OaLfYQ
         yVwDD6o2Z9XUGPOKtjLWB1v6ycGtNH/fBy+jZhY91898Q4waqigq4ZhfKUU5/2BbPSNq
         erYiHpFXd6G3N0rIQoWYcc/fUZSx4MwQp7/w4XoQuRX3IenhvIqNYi+PNdSVhmCdCgRz
         zLRM8TSZ+E3NZLmzQ21eeUiLox/4IAl4dCIy2bEo0EZK740cHUerjLBoKhNQm7XxSh2q
         jeN3kzJ8TSRkbtnI28kcJ99o5lZW459XWhDI5YIVn6jjdEoDe+iaIA+CYW0cpj4W+/Eb
         OJQg==
X-Gm-Message-State: AOAM533+CGCaplIABaE+1lVDSdwczuxXlLe8WBHekQf234b+ruL16LvO
        ol0gY0blzaY+K5EaC8vPs/dJl9QLArZ/YZlq
X-Google-Smtp-Source: ABdhPJzF0zg4WbIXADx/FTVUlCvDWQq7mIP7AFvOez86MvdSJywFf7MGKKUVQv0m6jWAIfrQN8y1wA==
X-Received: by 2002:a2e:9c08:: with SMTP id s8mr22318777lji.64.1623234220060;
        Wed, 09 Jun 2021 03:23:40 -0700 (PDT)
Received: from jade.urgonet (h-79-136-85-3.A175.priv.bahnhof.se. [79.136.85.3])
        by smtp.gmail.com with ESMTPSA id m4sm302966ljp.9.2021.06.09.03.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 03:23:39 -0700 (PDT)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Thirupathaiah Annapureddy <thiruan@microsoft.com>,
        Vikas Gupta <vikas.gupta@broadcom.com>,
        "David S . Miller" <davem@davemloft.net>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH 3/7] tee: add tee_shm_alloc_kernel_buf()
Date:   Wed,  9 Jun 2021 12:23:20 +0200
Message-Id: <20210609102324.2222332-4-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210609102324.2222332-1-jens.wiklander@linaro.org>
References: <20210609102324.2222332-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a new function tee_shm_alloc_kernel_buf() to allocate shared memory
from a kernel driver. This function can later be made more lightweight
by unnecessary dma-buf export.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/tee_shm.c   | 18 ++++++++++++++++++
 include/linux/tee_drv.h |  1 +
 2 files changed, 19 insertions(+)

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index b9dbf4bce149..63fce8d39d8b 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -192,6 +192,24 @@ struct tee_shm *tee_shm_alloc(struct tee_context *ctx, size_t size, u32 flags)
 }
 EXPORT_SYMBOL_GPL(tee_shm_alloc);
 
+/**
+ * tee_shm_alloc_kernel_buf() - Allocate shared memory for kernel buffer
+ * @ctx:	Context that allocates the shared memory
+ * @size:	Requested size of shared memory
+ *
+ * The returned memory registered in secure world and is suitable to be
+ * passed as a memory buffer in parameter argument to
+ * tee_client_invoke_func(). The memory allocated is later freed with a
+ * call to tee_shm_free().
+ *
+ * @returns a pointer to 'struct tee_shm'
+ */
+struct tee_shm *tee_shm_alloc_kernel_buf(struct tee_context *ctx, size_t size)
+{
+	return tee_shm_alloc(ctx, size, TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
+}
+EXPORT_SYMBOL_GPL(tee_shm_alloc_kernel_buf);
+
 struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
 				 size_t length, u32 flags)
 {
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index 62b7c7a55743..58b319766f8e 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -282,6 +282,7 @@ void *tee_get_drvdata(struct tee_device *teedev);
  * @returns a pointer to 'struct tee_shm'
  */
 struct tee_shm *tee_shm_alloc(struct tee_context *ctx, size_t size, u32 flags);
+struct tee_shm *tee_shm_alloc_kernel_buf(struct tee_context *ctx, size_t size);
 
 /**
  * tee_shm_register() - Register shared memory buffer
-- 
2.31.1

