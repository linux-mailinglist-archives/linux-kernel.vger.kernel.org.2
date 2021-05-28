Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F4214393F38
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 11:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236468AbhE1JHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 05:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236342AbhE1JGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 05:06:45 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9F6C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 02:05:10 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso6379952wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 02:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZHd78hRSkMzuohg5J3tzRz48OXEcvuzZqwhJwyMkBCw=;
        b=wD3jASsKf47ADb/cQ6s+gUIahaxifDyockRP1XMmKAeQ3V9G/Zv0IUyryXAVWpO1fy
         WZ33oMxOFXrMsq/KA5yLUcwHffr1RCh+s4ihw1HTM3D5yKsy0ztllL4DFoXrnaUefWh7
         1gkqr331hL0ZEzQW3vV5LAh5xEjJSvmVdig60CGOxevPIH/2zyZOUk4RI36Q3OTnDslP
         TI9Jd5ZEc9ULvxxJd06SiLGl8bptmpvTJVXgmlV4ra529TBljZjfVrEaPoEQCXa4uNKb
         WX1itQvfrQtfN7+X5fkJyrImAFIoSnVKY9+n2PkIoYH6BLKIP1W0UeVb121kwwKYd1Nm
         8pWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZHd78hRSkMzuohg5J3tzRz48OXEcvuzZqwhJwyMkBCw=;
        b=ZNdv2rhLZNQ5uoZZ9Qb53MrL6Qku3NyAAFQ3p0kGV7IettBCK6MwayMx3Ng/CFWrE6
         2nJ0jlA6krxwyJ14FHIVgjliHCRmfMropIArAqVsocJlmiedLyyiZcMTDgN2Wef/y+Oe
         NYmm6g8LhkdX/kav5/y0k+HTlLP9YnbpBWALGTUb+LReK2nAjVo+7t5QbuvKEXvBcYCA
         2efNqdoMChpJSJZCinFYTgrXVxggvKZKGMsl9bKem4Tf6kXE6PMqPkT8IHzH8yl7Jkx+
         kBRunuRJvxoIGCKqGwW4iyL9rjE9B6NvrLSBM33TXlbJm9AxAW9VlVe+6xMF3XL8jUVZ
         6TMQ==
X-Gm-Message-State: AOAM531LJs4wNShrRMooU9/lxVL+6NzqFwrVtSRoFSvg3J6fyquMrTZw
        d5q6h0iruxeiYUDumv7Y8jCfsQ==
X-Google-Smtp-Source: ABdhPJz7oPUrqLGppxgr5fJU3aFUM3mla0OIMhHa6HERtpy9ScnCBl0ZZyTaytq7qkALkKkjadk8pw==
X-Received: by 2002:a05:600c:4f95:: with SMTP id n21mr12358979wmq.74.1622192708815;
        Fri, 28 May 2021 02:05:08 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id q11sm7193937wrx.80.2021.05.28.02.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 02:05:08 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Mark Lord <mlord@pobox.com>,
        ALWAYS copy <linux-ide@vger.kernel.org>
Subject: [PATCH 04/11] ata: sata_mv: Do not over-write initialise fields in 'mv6_sht'
Date:   Fri, 28 May 2021 10:04:55 +0100
Message-Id: <20210528090502.1799866-5-lee.jones@linaro.org>
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

 drivers/ata/sata_mv.c:670:16: warning: initialized field overwritten [-Woverride-init]
 drivers/ata/sata_mv.c:670:16: note: (near initialization for ‘mv6_sht.can_queue’)

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Mark Lord <mlord@pobox.com>
Cc: ALWAYS copy <linux-ide@vger.kernel.org>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/sata_mv.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index c8867c12c0b86..9d86203e1e7a1 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -666,10 +666,14 @@ static struct scsi_host_template mv5_sht = {
 };
 #endif
 static struct scsi_host_template mv6_sht = {
-	ATA_NCQ_SHT(DRV_NAME),
+	__ATA_BASE_SHT(DRV_NAME),
 	.can_queue		= MV_MAX_Q_DEPTH - 1,
 	.sg_tablesize		= MV_MAX_SG_CT / 2,
 	.dma_boundary		= MV_DMA_BOUNDARY,
+	.sdev_attrs             = ata_ncq_sdev_attrs,
+	.change_queue_depth	= ata_scsi_change_queue_depth,
+	.tag_alloc_policy	= BLK_TAG_ALLOC_RR,
+	.slave_configure	= ata_scsi_slave_config
 };
 
 static struct ata_port_operations mv5_ops = {
-- 
2.31.1

