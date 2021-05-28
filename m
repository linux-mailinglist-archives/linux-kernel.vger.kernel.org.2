Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAD56393F37
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 11:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236450AbhE1JHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 05:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236330AbhE1JGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 05:06:44 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4808CC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 02:05:08 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v12so2523744wrq.6
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 02:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cWSksrnLWe4rDC76GwKSgT0nD4m0QGDvpuLUlTafu1Q=;
        b=kJXsfDn0XaU4cBTj1nb9UvuC8NlYm5WwSe0bvsqxaGAPcWn8DZNl+nxf201jW2NY/j
         de/HX/HtwUIlDjJwJ1VMJ/G1YciU8SmD2mvCR3xvAmUTYTRcA0fScrb9YwBt0uClAK7U
         bGnOgHgExwMDlOwD9TmJawkid80aeoc4BJMQ1XYUrvqcy4AGGW32xFUr/KYsoFr8xt96
         O/HXuDzhogExJdWWnZcOPpf/vfWByiBbmwp4Mv0D6LoNm2v1Inq8+OpQ39DWPCK+glKI
         POUq+yAs5ZEH4JRt7lkBPv49cVI+VMg0/Lhbn0zUyJAIwUqS9vWvfu9iCzpvA7IYda+s
         WR2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cWSksrnLWe4rDC76GwKSgT0nD4m0QGDvpuLUlTafu1Q=;
        b=bTerpepUp/lYELq19xbJB7nIuuQlcJp7DZKbsomhUgja6k2PlyPl1bDPGzAzxpAjZh
         Cd2ZxNo9KVL0AMQND+Q6UAukx+ll3+dFoz3n5gdBeacSo8D71rrrgUJuqn6KKdBT3FcZ
         veRaKwwoq/2mr993dq5RbPRTihh8PxBZZlttfIsHnwsbYJWDJYHu5blh+VypKAaGIcgM
         rcML/wjNCwskqr+zv8ETWODg9lxZaWvMurwDnrnnWvyi6OQUDc+rWqY+gColbhLdEFIc
         pS4ROQ6N4QJMi6AE3K9nA/lLdne2qrogPTpZ2NAJlD/TjilYro+Oqp+dRMGM4KoJ+79u
         Jczg==
X-Gm-Message-State: AOAM531i5kJF5NoyEEMfOKPCRSLOfqOYN1Tq9CkM6rQ7/9+Dq/NvpPsd
        Vu8ipSNWVPS/BDuJFrLjJPwTPQ==
X-Google-Smtp-Source: ABdhPJx0FrZCOBPidHiKTi8G58//zi9pKaWjPvkgzW/FrwQMwNICVMXLsnGsFZiRwlRTSCA9b+xAjg==
X-Received: by 2002:a5d:514b:: with SMTP id u11mr7541900wrt.350.1622192706896;
        Fri, 28 May 2021 02:05:06 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id q11sm7193937wrx.80.2021.05.28.02.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 02:05:06 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Tejun Heo <tj@kernel.org>,
        ALWAYS copy <linux-ide@vger.kernel.org>
Subject: [PATCH 02/11] ata: ahci: Ensure initialised fields are not overwritten in AHCI_SHT()
Date:   Fri, 28 May 2021 10:04:53 +0100
Message-Id: <20210528090502.1799866-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210528090502.1799866-1-lee.jones@linaro.org>
References: <20210528090502.1799866-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

  In file included from drivers/ata/ahci_platform.c:21:
  drivers/ata/ahci.h:388:16: warning: initialized field overwritten [-Woverride-init]
  drivers/ata/ahci_platform.c:40:2: note: in expansion of macro ‘AHCI_SHT’
  drivers/ata/ahci.h:388:16: note: (near initialization for ‘ahci_platform_sht.can_queue’)
  drivers/ata/ahci_platform.c:40:2: note: in expansion of macro ‘AHCI_SHT’
  drivers/ata/ahci.h:392:17: warning: initialized field overwritten [-Woverride-init]
  drivers/ata/ahci_platform.c:40:2: note: in expansion of macro ‘AHCI_SHT’
  drivers/ata/ahci.h:392:17: note: (near initialization for ‘ahci_platform_sht.sdev_attrs’)
  drivers/ata/ahci_platform.c:40:2: note: in expansion of macro ‘AHCI_SHT’
  In file included from drivers/ata/ahci_mtk.c:18:
  drivers/ata/ahci.h:388:16: warning: initialized field overwritten [-Woverride-init]
  drivers/ata/ahci_mtk.c:41:2: note: in expansion of macro ‘AHCI_SHT’
  drivers/ata/ahci.h:388:16: note: (near initialization for ‘ahci_platform_sht.can_queue’)
  drivers/ata/ahci_mtk.c:41:2: note: in expansion of macro ‘AHCI_SHT’
  drivers/ata/ahci.h:392:17: warning: initialized field overwritten [-Woverride-init]
  drivers/ata/ahci_mtk.c:41:2: note: in expansion of macro ‘AHCI_SHT’
  drivers/ata/ahci.h:392:17: note: (near initialization for ‘ahci_platform_sht.sdev_attrs’)
  drivers/ata/ahci_mtk.c:41:2: note: in expansion of macro ‘AHCI_SHT’
  In file included from drivers/ata/ahci_dm816.c:16:
  drivers/ata/ahci.h:388:16: warning: initialized field overwritten [-Woverride-init]
  drivers/ata/ahci_dm816.c:138:2: note: in expansion of macro ‘AHCI_SHT’
  drivers/ata/ahci.h:388:16: note: (near initialization for ‘ahci_dm816_platform_sht.can_queue’)
  drivers/ata/ahci_dm816.c:138:2: note: in expansion of macro ‘AHCI_SHT’
  drivers/ata/ahci.h:392:17: warning: initialized field overwritten [-Woverride-init]
  drivers/ata/ahci_dm816.c:138:2: note: in expansion of macro ‘AHCI_SHT’
  drivers/ata/ahci.h:392:17: note: (near initialization for ‘ahci_dm816_platform_sht.sdev_attrs’)
  drivers/ata/ahci_dm816.c:138:2: note: in expansion of macro ‘AHCI_SHT’

  NB: Snipped 150 lines of this for brevity!

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Tejun Heo <tj@kernel.org>
Cc: ALWAYS copy <linux-ide@vger.kernel.org>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/ahci.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index d1f284f0c83d9..2e89499bd9c3d 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -384,12 +384,15 @@ extern struct device_attribute *ahci_sdev_attrs[];
  * for ATA_BASE_SHT
  */
 #define AHCI_SHT(drv_name)						\
-	ATA_NCQ_SHT(drv_name),						\
+	__ATA_BASE_SHT(drv_name),					\
 	.can_queue		= AHCI_MAX_CMDS,			\
 	.sg_tablesize		= AHCI_MAX_SG,				\
 	.dma_boundary		= AHCI_DMA_BOUNDARY,			\
 	.shost_attrs		= ahci_shost_attrs,			\
-	.sdev_attrs		= ahci_sdev_attrs
+	.sdev_attrs		= ahci_sdev_attrs,			\
+	.change_queue_depth     = ata_scsi_change_queue_depth,		\
+	.tag_alloc_policy       = BLK_TAG_ALLOC_RR,             	\
+	.slave_configure        = ata_scsi_slave_config
 
 extern struct ata_port_operations ahci_ops;
 extern struct ata_port_operations ahci_platform_ops;
-- 
2.31.1

