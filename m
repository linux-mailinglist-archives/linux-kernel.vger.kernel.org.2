Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B296B393F2C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 11:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236383AbhE1JGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 05:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234255AbhE1JGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 05:06:42 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4263FC061761
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 02:05:07 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id v12so2523706wrq.6
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 02:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JAwi1fvjZmfmHFU/F6uA+Qzc/x3DLxFoaVN4fZrMnzo=;
        b=Oj0wzej15Xoct5UZ2mjnHXTrGKuTad6tmzynF96sXczOpjSFEMctdQYP6Re9pQfDoG
         pGUXM+s5rEQNIEv4+iikWel7kkPS60OrTcBdFfce9NtVB2Wk+2DGlvMYIp9ZOYnoFIRf
         SDxjOdP3Q0WgwhbbeVj+i/bw9QhG5YiJwWDikUelfaSRcCAVra8qO+Q99eI4fOV9uXoo
         60AC1elrDytFsZ2Y9cuGqldp7BfJ6BP89w/mU2XzqwrNgzrZXxaftnrGbxBd1gWTGQhP
         ghs+Qei4HJMl0JaaehcCZjGPITn4ZM5SWN2Dehc+dAIVKmKcPRvDgHWZzx6ZTAW9Xwnk
         4vXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JAwi1fvjZmfmHFU/F6uA+Qzc/x3DLxFoaVN4fZrMnzo=;
        b=epYMG+xU+UKDdKHdBiaiIflcUduKzHAVk4pH9bdo1AnqlW6sYgSiJXoUbj+6oySRWS
         2DN9hBsKxSqGucHdTQZtcu8AK/EXrqxnHxtifF0dQ5TW8XxtHPSLTbJRZ6tljz4Jf7/m
         wP5dPytaclLtqQAgiPe6Zx6uAAXmh3Na6miYtR8uJVvwNZYV5uoFH5YGghgkiaZdMhSO
         uLz6parM5Y8te2opG7hbc4ra4BeppjEeIAMMVXxMbGTpCmBUlNfnXX1F42oz/n3nKDx0
         Yap/hdvUp5xNeUZ9b5b2ZJVA9mYPooyAnQaBlh5BM/10rVQj4GXzu2SjLA0eR38+sQ7f
         THxQ==
X-Gm-Message-State: AOAM532c+clRtLvcrXAxLoXj3QbHYFCbqcZK+mucN6osXHH9Pgl1pvK9
        cQ+idiu/ggdLevUdKnCCLW7EVAI+QDOeKQ==
X-Google-Smtp-Source: ABdhPJz8sOCHaHAk0qYyz9z+PXHXWTfZ+Im+qFLXOZieArTHZ76zLSgQz8Baq+DN3y11wEPFBpz4cw==
X-Received: by 2002:a05:6000:114c:: with SMTP id d12mr7421963wrx.265.1622192705833;
        Fri, 28 May 2021 02:05:05 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id q11sm7193937wrx.80.2021.05.28.02.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 02:05:05 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Mark Lord <mlord@pobox.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
Subject: [PATCH 01/11] ata: include: libata: Move fields commonly over-written to separate MACRO
Date:   Fri, 28 May 2021 10:04:52 +0100
Message-Id: <20210528090502.1799866-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210528090502.1799866-1-lee.jones@linaro.org>
References: <20210528090502.1799866-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a pre-cursor to some upcoming W=1 fix-ups.

Fixes the following W=1 kernel build warning(s):

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Mark Lord <mlord@pobox.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 include/linux/libata.h | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/linux/libata.h b/include/linux/libata.h
index 5f550eb27f811..3fcd24236793e 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1397,25 +1397,28 @@ extern struct device_attribute *ata_common_sdev_attrs[];
 	ATA_SCSI_COMPAT_IOCTL					\
 	.queuecommand		= ata_scsi_queuecmd,		\
 	.dma_need_drain		= ata_scsi_dma_need_drain,	\
-	.can_queue		= ATA_DEF_QUEUE,		\
-	.tag_alloc_policy	= BLK_TAG_ALLOC_RR,		\
 	.this_id		= ATA_SHT_THIS_ID,		\
 	.emulated		= ATA_SHT_EMULATED,		\
 	.proc_name		= drv_name,			\
-	.slave_configure	= ata_scsi_slave_config,	\
 	.slave_destroy		= ata_scsi_slave_destroy,	\
 	.bios_param		= ata_std_bios_param,		\
 	.unlock_native_capacity	= ata_scsi_unlock_native_capacity
 
-#define ATA_BASE_SHT(drv_name)					\
+#define ATA_SUBBASE_SHT(drv_name)				\
 	__ATA_BASE_SHT(drv_name),				\
+	.can_queue		= ATA_DEF_QUEUE,		\
+	.tag_alloc_policy	= BLK_TAG_ALLOC_RR,		\
+	.slave_configure	= ata_scsi_slave_config
+
+#define ATA_BASE_SHT(drv_name)					\
+	ATA_SUBBASE_SHT(drv_name),				\
 	.sdev_attrs		= ata_common_sdev_attrs
 
 #ifdef CONFIG_SATA_HOST
 extern struct device_attribute *ata_ncq_sdev_attrs[];
 
 #define ATA_NCQ_SHT(drv_name)					\
-	__ATA_BASE_SHT(drv_name),				\
+	ATA_SUBBASE_SHT(drv_name),				\
 	.sdev_attrs		= ata_ncq_sdev_attrs,		\
 	.change_queue_depth	= ata_scsi_change_queue_depth
 #endif
-- 
2.31.1

