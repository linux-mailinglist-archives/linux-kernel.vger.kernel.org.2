Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3783393F3D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 11:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236543AbhE1JHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 05:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236397AbhE1JGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 05:06:51 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C83FC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 02:05:15 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id l18-20020a1c79120000b0290181c444b2d0so1945618wme.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 02:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qt1whjAB7B3KIqzNP8mB42+ojJZ8NO2eFQdyrF9/Hro=;
        b=V9Y8lSuMGMU3yqi01V/eDdLodPlG8RMYQHdQ/A3sATPU5XX24HQUwRpK7je3P0+yoR
         5BWByiLoRvY1dR6gkHKq82ZCY5A77LgxJRtu+nbANhCEkOlqIisclPj4sot0mrLNvRbI
         rh8vbGcRhYGSL442S/OKcDaC/poOcmdfwJWF5lsEiuI5ZyT+LMiAXA7rhJYNe9wf3HTX
         nAFLvMQ3+4psdoUNcEAmYm85yO4rVZBd3k/JmAZGM0fEopn50DG5PQ90sBalhL6TFT9U
         pXvBtK8XDpGGsiaudS+SSm4tXqe9MuwFGoGoD4mL36I2vDIlGSphVx1WboFN3MyoZPFl
         z3OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qt1whjAB7B3KIqzNP8mB42+ojJZ8NO2eFQdyrF9/Hro=;
        b=Vod2RcENdQh0IiuZeKi/I4tjT21ZnDJGn+TRG0PfOmQkt46EuQFT/BChK41J6KRHN8
         sEJujKL+SdjXU1rbx2xzi0Nyk1OLC7pU8EDI3BV7V6xyG5OBxAl5GrDdNgNsw0F6/kQQ
         kkfA5VItCIn8PNKjD25lZdAxnWmj+yUq1qFPCw+xV1WyXoDX7MelWtQZ/5eJ1lS+aQpP
         L1q9TPrVJnMuU6z/zoq4WcHB7ZUkKigK4AX9lql9SU1KLTTNAsfRnKt7xtSVa1zO9GRg
         cisJ7UEEIOqQ2g+UolfSgmM17BtxiepuBJHmLG/Ic5kUVZiAYWLRZCDpvvboRtoPdye9
         UYHw==
X-Gm-Message-State: AOAM533pO31otqeMX6vgk9rmbq9cEjhVRHiJ/IC64UWxoNmwo6RRIGnn
        fZ1pGcaIxI8hLbJQbEu3TafY+HSgBgbWcQ==
X-Google-Smtp-Source: ABdhPJz3EjGlpVSj2qf61StupfyMAlGqyKg+Maiz1smjHPwzTwf++AsVvBsw5JuEvP31tqKHaqYPwQ==
X-Received: by 2002:a05:600c:22cf:: with SMTP id 15mr1111078wmg.144.1622192713662;
        Fri, 28 May 2021 02:05:13 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id q11sm7193937wrx.80.2021.05.28.02.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 02:05:13 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Mark Lord <mlord@pobox.com>, linux-ide@vger.kernel.org
Subject: [PATCH 09/11] ata: pata_sc1200: sc1200_sht'Avoid overwriting initialised field in '
Date:   Fri, 28 May 2021 10:05:00 +0100
Message-Id: <20210528090502.1799866-10-lee.jones@linaro.org>
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

 drivers/ata/pata_sc1200.c:197:18: warning: initialized field overwritten [-Woverride-init]
 drivers/ata/pata_sc1200.c:197:18: note: (near initialization for ‘sc1200_sht.sg_tablesize’)

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mark Lord <mlord@pobox.com>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/pata_sc1200.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/pata_sc1200.c b/drivers/ata/pata_sc1200.c
index 3b8c111140bdb..f28daf62a37df 100644
--- a/drivers/ata/pata_sc1200.c
+++ b/drivers/ata/pata_sc1200.c
@@ -193,8 +193,9 @@ static int sc1200_qc_defer(struct ata_queued_cmd *qc)
 }
 
 static struct scsi_host_template sc1200_sht = {
-	ATA_BMDMA_SHT(DRV_NAME),
+	ATA_BASE_SHT(DRV_NAME),
 	.sg_tablesize	= LIBATA_DUMB_MAX_PRD,
+	.dma_boundary	= ATA_DMA_BOUNDARY,
 };
 
 static struct ata_port_operations sc1200_port_ops = {
-- 
2.31.1

