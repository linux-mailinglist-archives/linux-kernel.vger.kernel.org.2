Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 560CA393F3C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 11:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236539AbhE1JHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 05:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236390AbhE1JGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 05:06:50 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0C1C06138E
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 02:05:14 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id q5so2537271wrs.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 02:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LMvYDOyB4q/E0pHYpqQ2C8W3ut3TbG5YnHO9reTpRZ8=;
        b=qPwRtiIf356iO0N+o9+zvphIFonH4vM3b0l/Wm8lkkXPMvtKqTx7RrFhPVxumltpXR
         VF9TrkdFn28SjLwsutgtc05Tv26h2BxpulbdyjwiP4gmJ+adG0gauJa0WphZ+X1VS1sv
         1I5S+ZWRTHIYmss1XIadDgwugFsSHevT3Nd9pIY+98oy3O6Lh6wcn32HVpY1s0gCCd4H
         BO8VM07NAgAPdUeobdNXSJ8vmTG6swKG3Xuh1vsBWvzpnREcxfP7mt12WNGzMVSRlVie
         c9jctBZyXuyLvfNIYCTr7UXReGFGA8MSVxace6YmgQJ9d6b2InxEuZm81AU0rYmSG66t
         yaLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LMvYDOyB4q/E0pHYpqQ2C8W3ut3TbG5YnHO9reTpRZ8=;
        b=S07tiODi3V69mXwKuG527S/9FtGesgcaeLHuQZIIPpzzwdcZehocQMt3Cw4qo+DqdN
         H8yMo5EtUdnhIt/LTpzGBtjl10hKSfhX7awceaSN4vXeTPjVrHy23JJkw42E6ENWD9Q8
         EJ7AIsDZI1163xS7yIGq+Au4WVqt5+IdItXnJlmaGhl3rrcmZO8mPC4FOKx8JYBJewMd
         FE3Wh1w1zEpVknY2z1GqLinJbV0scmNy25DCBzHF+2P0eBc0C4Fket7Pzou1O2ip0VNQ
         dnPaBlu9TWStywX2SEoTmgECsn8X4LEsxZ8QfL5xK6Vxe72apNe+dGOxolD41qYBGBNt
         /hCg==
X-Gm-Message-State: AOAM532dDHCKKq5yT/tOxvRccdVc9/qVbdveGzAz/z6Jc5s1zmS1jAUb
        H0nB10LFRDb4O3D1GcmzcbIQGw==
X-Google-Smtp-Source: ABdhPJyKTUIMwgZkSCn1R0n+vDSqNCDl85dzoFS0BmFDVM3BYet+SaT4QFvnV2pRfb5VNTpQg8ZnQA==
X-Received: by 2002:a5d:4304:: with SMTP id h4mr7872787wrq.210.1622192712642;
        Fri, 28 May 2021 02:05:12 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id q11sm7193937wrx.80.2021.05.28.02.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 02:05:12 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org
Subject: [PATCH 08/11] ata: pata_cs5530: Avoid overwriting initialised field in 'cs5530_sht'
Date:   Fri, 28 May 2021 10:04:59 +0100
Message-Id: <20210528090502.1799866-9-lee.jones@linaro.org>
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

 drivers/ata/pata_cs5530.c:151:18: warning: initialized field overwritten [-Woverride-init]
 drivers/ata/pata_cs5530.c:151:18: note: (near initialization for ‘cs5530_sht.sg_tablesize’)

Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/pata_cs5530.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/pata_cs5530.c b/drivers/ata/pata_cs5530.c
index a1b4aaccaa50a..d5b7ac14e78f5 100644
--- a/drivers/ata/pata_cs5530.c
+++ b/drivers/ata/pata_cs5530.c
@@ -147,8 +147,9 @@ static unsigned int cs5530_qc_issue(struct ata_queued_cmd *qc)
 }
 
 static struct scsi_host_template cs5530_sht = {
-	ATA_BMDMA_SHT(DRV_NAME),
+	ATA_BASE_SHT(DRV_NAME),
 	.sg_tablesize	= LIBATA_DUMB_MAX_PRD,
+	.dma_boundary	= ATA_DMA_BOUNDARY,
 };
 
 static struct ata_port_operations cs5530_port_ops = {
-- 
2.31.1

