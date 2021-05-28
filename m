Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7C8393F39
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 11:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236500AbhE1JHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 05:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236355AbhE1JGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 05:06:47 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88EFAC061760
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 02:05:11 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id m18so1726312wmq.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 02:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZsHhVHMMYIUUYCsqaGFFBiP85xJeW/vO/rf3whWDDj8=;
        b=SIcUru8N6ThJ47KmOebae2ZxgyMlirYEl5oYCYXI3f39QL5dEKUq6iGP213gEajmqt
         vFLw3dvcc0L0Wn/AvCNHCv1uqyZ+RcMndY9vwSI+Bu7Ugrd1PGVPWS9OdzlWjimQDSkM
         Tz6KWxf/teNDipZndHHzAarn4J+lhG1/K4CzzmvwvC6prVwx++46fca92QMTnlg682QG
         6I/lJFQ73Nsm5pLH5oTV2UuD9FOdmdkV+IvVDHv5ukCcEEFAgwJwWObg8+gZlWUufJQR
         phQZS/ZqEqrlwxvRQKKS9qo4EbcsD0f24h9vsywpBbzsJGIyYFCTZNJyheChmViUuUHc
         a77Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZsHhVHMMYIUUYCsqaGFFBiP85xJeW/vO/rf3whWDDj8=;
        b=TRVN7fysD5oMRakXX/Kww0SCgS7t+b/qDQOARavdwdMvhHtnODa/e1CRwvfuhUiENR
         V9fNyYpRT8GVaXu8/OkwKmGqrvslTRhrM35ZbUA748uO8GcG3t+jpM1HybYNXCVbMRaF
         anU3kWqAz6csEq0jqWhLx2mtWuBn331dT+DGiKYGlicOm42qNhyRT17P8Q0B8olI3Eoq
         GHAvhCxB9/yky8rff05vCpNuzOEImOQ55unwXaX98uR6eUpr3X4Gk+Eulc0xT0786laH
         k2kWZDXj983RfZdLl7LKUBXVb7JqFr04ggkZiFpPuCzq53z9Zchn4iw9X8YWMBK1uubs
         wKFA==
X-Gm-Message-State: AOAM533G9Z1icI1yE6gvOvPvtHWfTdVRQVkqkuxgQtv42P0kZUZNDQXh
        XQctbaH9YirvaQFp+N1vGrH1Ow==
X-Google-Smtp-Source: ABdhPJz/Wq66VAjAnT4wZ1Q2aaa/482ptBEHUsF/scU2EIAP/gUhIYAPl6l6JWEn8ew55cOgcTm3Uw==
X-Received: by 2002:a1c:4601:: with SMTP id t1mr7514479wma.27.1622192710115;
        Fri, 28 May 2021 02:05:10 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id q11sm7193937wrx.80.2021.05.28.02.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 02:05:09 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org
Subject: [PATCH 05/11] ata: sata_nv: Do not over-write initialise fields in 'nv_adma_sht' and 'nv_swncq_sht'
Date:   Fri, 28 May 2021 10:04:56 +0100
Message-Id: <20210528090502.1799866-6-lee.jones@linaro.org>
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

 drivers/ata/sata_nv.c:379:16: warning: initialized field overwritten [-Woverride-init]
 drivers/ata/sata_nv.c:379:16: note: (near initialization for ‘nv_adma_sht.can_queue’)
 drivers/ata/sata_nv.c:382:21: warning: initialized field overwritten [-Woverride-init]
 drivers/ata/sata_nv.c:382:21: note: (near initialization for ‘nv_adma_sht.slave_configure’)
 drivers/ata/sata_nv.c:387:16: warning: initialized field overwritten [-Woverride-init]
 drivers/ata/sata_nv.c:387:16: note: (near initialization for ‘nv_swncq_sht.can_queue’)
 drivers/ata/sata_nv.c:390:21: warning: initialized field overwritten [-Woverride-init]
 drivers/ata/sata_nv.c:390:21: note: (near initialization for ‘nv_swncq_sht.slave_configure’)

Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/sata_nv.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index de45045566692..c385d18ce87b7 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -375,19 +375,25 @@ static struct scsi_host_template nv_sht = {
 };
 
 static struct scsi_host_template nv_adma_sht = {
-	ATA_NCQ_SHT(DRV_NAME),
+	__ATA_BASE_SHT(DRV_NAME),
 	.can_queue		= NV_ADMA_MAX_CPBS,
 	.sg_tablesize		= NV_ADMA_SGTBL_TOTAL_LEN,
 	.dma_boundary		= NV_ADMA_DMA_BOUNDARY,
 	.slave_configure	= nv_adma_slave_config,
+	.sdev_attrs             = ata_ncq_sdev_attrs,
+	.change_queue_depth     = ata_scsi_change_queue_depth,
+	.tag_alloc_policy	= BLK_TAG_ALLOC_RR,
 };
 
 static struct scsi_host_template nv_swncq_sht = {
-	ATA_NCQ_SHT(DRV_NAME),
+	__ATA_BASE_SHT(DRV_NAME),
 	.can_queue		= ATA_MAX_QUEUE - 1,
 	.sg_tablesize		= LIBATA_MAX_PRD,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= nv_swncq_slave_config,
+	.sdev_attrs             = ata_ncq_sdev_attrs,
+	.change_queue_depth     = ata_scsi_change_queue_depth,
+	.tag_alloc_policy	= BLK_TAG_ALLOC_RR,
 };
 
 /*
-- 
2.31.1

