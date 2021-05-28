Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61F76393F3F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 11:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236200AbhE1JHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 05:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236416AbhE1JGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 05:06:53 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD5AC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 02:05:17 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id f11so2562768wrq.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 02:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FYwNHNrhbfh9CANgoPYUUc0JeKX9lP8oPhSc5WFJNEQ=;
        b=ZX38wE3i7apU5/duc7GW+BMobL+9wKiANk42JZTaCXJrhPeef2VoTcBCpAO37TEazY
         SU7icxq1P/BracR22EQYxyo47osE2Sps3QSY/1XxKZraPTimTkEc8RpWVJJS/ZFr2drw
         FjImleBL9XAJ/J402JNy9e2kBL6ZpYjLH56PH9xr89wsceD+wW98Fpe32yhpghexRGJz
         2wB9Vw3Xvu1jskZZtBRTgnEGVckIFuN/gBKgMuw6nB11i+RuyIWepbS4jNkRT96rOn/2
         FMbxwinxH65FcjBMcVx+s9XnS0UBXDLtcPWIJiPPyiJAyMcmnN3FwQ4yet3zGSlhw18b
         QBYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FYwNHNrhbfh9CANgoPYUUc0JeKX9lP8oPhSc5WFJNEQ=;
        b=J5PhqBZ0j0RoDKLSbvPamTt+L+2+HjnoA4KZpSY3O7drPCigw9/DLmCvYkTElO32jD
         PCvCAA6zJIvh/I+z3SQ9IhEpwyh8pu4uPl9UhX/+RbAnX1U10sVhA/l/kr5cTkNd4rxC
         DMLosmllI49qMfpoDr+T3O5puNPyVkkF83uW4oXz6klMZ/dl67xe7pVlvocMDxpd0OCK
         6uOh0QCa6Xc4Ar0mQeZCmaIFHBxkCkKJKIB90wn1+3zhojQNuzgOg5SJl+p9CQm/yUZe
         U0x5/04hOVhYEv5T9lv1L2kT583gZEIFWQfo95/8I4St8tLkJyrfg1dZCL8w7u6MVGNi
         EGsw==
X-Gm-Message-State: AOAM533EsJQAmHGhzbf6SKkZhf3zEWmX5IxuxnxuW15BZbXmDCHN4+Im
        5xBtYH84vzupFW7XFO8aB/n2AQ==
X-Google-Smtp-Source: ABdhPJxrDRvCtE+DWyEoqHgvQj097Jghqqs+XsQt5bmzubXXdYwa7DpNX15McFcRRHL7TMga/x2aTA==
X-Received: by 2002:a5d:5052:: with SMTP id h18mr7483627wrt.365.1622192715897;
        Fri, 28 May 2021 02:05:15 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id q11sm7193937wrx.80.2021.05.28.02.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 02:05:15 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        benh@kernel.crashing.org, linux-ide@vger.kernel.org
Subject: [PATCH 11/11] ata: pata_macio: Avoid overwriting initialised field in 'pata_macio_sht'
Date:   Fri, 28 May 2021 10:05:02 +0100
Message-Id: <20210528090502.1799866-12-lee.jones@linaro.org>
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

 drivers/ata/pata_macio.c:925:21: warning: initialized field overwritten [-Woverride-init]
 drivers/ata/pata_macio.c:925:21: note: (near initialization for ‘pata_macio_sht.slave_configure’)

Cc: Jens Axboe <axboe@kernel.dk>
Cc: benh@kernel.crashing.org
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/pata_macio.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/pata_macio.c b/drivers/ata/pata_macio.c
index e47a28271f5bb..be0ca8d5b3452 100644
--- a/drivers/ata/pata_macio.c
+++ b/drivers/ata/pata_macio.c
@@ -914,7 +914,7 @@ static int pata_macio_do_resume(struct pata_macio_priv *priv)
 #endif /* CONFIG_PM_SLEEP */
 
 static struct scsi_host_template pata_macio_sht = {
-	ATA_BASE_SHT(DRV_NAME),
+	__ATA_BASE_SHT(DRV_NAME),
 	.sg_tablesize		= MAX_DCMDS,
 	/* We may not need that strict one */
 	.dma_boundary		= ATA_DMA_BOUNDARY,
@@ -923,6 +923,9 @@ static struct scsi_host_template pata_macio_sht = {
 	 */
 	.max_segment_size	= MAX_DBDMA_SEG,
 	.slave_configure	= pata_macio_slave_config,
+	.sdev_attrs		= ata_common_sdev_attrs,
+	.can_queue		= ATA_DEF_QUEUE,
+	.tag_alloc_policy	= BLK_TAG_ALLOC_RR,
 };
 
 static struct ata_port_operations pata_macio_ops = {
-- 
2.31.1

