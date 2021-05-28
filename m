Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4A9393F3B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 11:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236530AbhE1JHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 05:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236340AbhE1JGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 05:06:48 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43140C061761
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 02:05:12 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id f6-20020a1c1f060000b0290175ca89f698so4118094wmf.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 02:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q31aHu4d2EyGCNum2ZU2yD6ze38ZUxKCEqsQOMZ06Lw=;
        b=iHU4SmZtE0qceEDUVqwq0nooHVzMWLGqymHGWYwomhTQJQR+Wh9lEwitqZaNDTujXb
         YL+eLd3W0ZNq90heaVygzxuMYhQ6ksvqadoN75LjUvZWdHtaR+ZLlbhoz1aE/It5SYWE
         XnvSsgn+mqTByNkFXZEzNNiGo4wjaWGYrkCgI0XQlyX+yYQCexn6CvTXyt3w6HdSeFD1
         cBtAAst4erMizizLtAPP2GJZyadGgzfVEQaluAjV4l1zffplaMFZPKJmsNC49ACOoi5y
         tpev3tSwpxVBb/ErkeotHdN3dsjj3fkCNWPzCRudvWsotXrg4Jgwg7VA+tPpvf3cuHQv
         zqvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q31aHu4d2EyGCNum2ZU2yD6ze38ZUxKCEqsQOMZ06Lw=;
        b=i9fOGqJ33L3hcBi+Od7u4oCkgy7vjARy2E+76ZwZv4zFFCIq465Fmvy21dq9slMhl6
         gwwYxYm0B3JbV8o+4Q6kMMhtzd8n3fCiN7NzK1KkywheAwLl4rVJQlb/yzOr55kV5n+Z
         MFiCmock8VkeeGkeVcamBa6vk1u96NOyr69Eum/UAIbhUBJ9EnUvnd3B7lPhpUuC/+55
         zSCt6pIuhRUvB2YvYT4PnTQcKLe+rJJxjaX0m8ZzhfnSG8EYX5wOyXTYvBObSdxDzEw8
         WUbcPawagpMJuvPQon1lQBTalfziKFUFWTq4gMi/qPunVCuH5OLp19uMuoZ3Umd8xZHV
         HDkQ==
X-Gm-Message-State: AOAM533X3dLNJuIVz2T+bny/5nbleaKdCJHXPg3Efa/L05hrW+5Oo4Vl
        UMvKetxrcv7cuA1FoOQaL6fg0A==
X-Google-Smtp-Source: ABdhPJztjboOyPvoUhgaD1zdQe8HIPehEzyszSEHX6rN62P1I/Uqy+OvhLlZnpuYvbpKVFAHI4ZfoA==
X-Received: by 2002:a7b:cd83:: with SMTP id y3mr7622742wmj.155.1622192710912;
        Fri, 28 May 2021 02:05:10 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id q11sm7193937wrx.80.2021.05.28.02.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 02:05:10 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        ATI Inc <hyu@ati.com>, linux-ide@vger.kernel.org
Subject: [PATCH 06/11] ata: pata_atiixp: Avoid overwriting initialised field in 'atiixp_sht'
Date:   Fri, 28 May 2021 10:04:57 +0100
Message-Id: <20210528090502.1799866-7-lee.jones@linaro.org>
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

 drivers/ata/pata_atiixp.c:256:19: warning: initialized field overwritten [-Woverride-init]
 drivers/ata/pata_atiixp.c:256:19: note: (near initialization for ‘atiixp_sht.sg_tablesize’)

Cc: Jens Axboe <axboe@kernel.dk>
Cc: ATI Inc <hyu@ati.com>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/pata_atiixp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/pata_atiixp.c b/drivers/ata/pata_atiixp.c
index d671d33ef2874..c3a65ccd4b799 100644
--- a/drivers/ata/pata_atiixp.c
+++ b/drivers/ata/pata_atiixp.c
@@ -252,8 +252,9 @@ static void atiixp_bmdma_stop(struct ata_queued_cmd *qc)
 }
 
 static struct scsi_host_template atiixp_sht = {
-	ATA_BMDMA_SHT(DRV_NAME),
+	ATA_BASE_SHT(DRV_NAME),
 	.sg_tablesize		= LIBATA_DUMB_MAX_PRD,
+	.dma_boundary		= ATA_DMA_BOUNDARY,
 };
 
 static struct ata_port_operations atiixp_port_ops = {
-- 
2.31.1

