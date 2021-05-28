Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6AE9393F3A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 11:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236521AbhE1JHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 05:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236366AbhE1JGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 05:06:48 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4C3C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 02:05:13 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id h3so1690412wmq.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 02:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cqNtuLDYrKvRNBVp3VSAfSB/yMTpSme5doamFgIXxy8=;
        b=pCHP+eJ93Zsu6Jmihy8fbe9klOotG1nugf7P6lL8GCE9XxOxZmDm+bE1SJVZUmmiH7
         HE7hjzyIqIo6oROqHxoLcBFhjv5+qjweXEHcDPqa3sALw4F2BhqG1kVAVvAQhbkK3aHl
         BITJRLKIZnlxy1a59hQKgiXd30jonzTIVQQmWVFKoaoJuUm2kvxNfCE0yDFTjXieB2Kz
         t+SfOt6Dw74PdI8mAobwKz+qntsal97GxggeGF7S6Oc7dxb4Sms0OBvXFMXIqtzFH7ES
         0MHB+JHnzj+iCFTO6287BoQqmcgVvVRr1PaTqykXw4HC4fHIrI+9Ux7xpimwh4PkbMlm
         2uMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cqNtuLDYrKvRNBVp3VSAfSB/yMTpSme5doamFgIXxy8=;
        b=CONFBBlJmvFfriYOLe0B4SUWsVKjPtuwQ4ASkPv4GeKfwfN+fT2/17TNVaxF8kMhbb
         g1eOhDUEyeWdWVTqTJBHaPmJRCuF760NQ5APiSUyZ7BNH/NIxCuyK1XPIuGmwuVY9iBU
         hYtcqPptW7LRi6uVQdS8wlYJ4GlVNfIOsmZuidlxyeVW6w74H92oSMLiCkUwKh9dGomI
         Ljzt0oxG9YNW5nioU2bBmfwz/O07gguje3NXGv/oiLV2ySfHjUVo6guLoVDcrA6yI/bz
         yXVMNu0FM8iGEr8jKDYIn8ztdnCSOwCD52YRRc1u7xn2g6XhA9UQMLthJbq1GoZWJSE0
         DC0A==
X-Gm-Message-State: AOAM533HmyFo7O3dlJR5UBuhhWB6fkYCnx2HMxtXrZEwDsJke8ksg1uP
        sfKzlZ18y31ORuq8yo345IyNYpByNTo1SQ==
X-Google-Smtp-Source: ABdhPJyFYyV65K75HWrpKoxF/h0k2JdSJZa3XOT1Hbbj2zyfEfXqWZncoCe6ZmvK+oqSz6Auq+lTaw==
X-Received: by 2002:a05:600c:218c:: with SMTP id e12mr12657564wme.16.1622192711854;
        Fri, 28 May 2021 02:05:11 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id q11sm7193937wrx.80.2021.05.28.02.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 02:05:11 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org
Subject: [PATCH 07/11] ata: pata_cs5520: Avoid overwriting initialised field in 'cs5520_sht'
Date:   Fri, 28 May 2021 10:04:58 +0100
Message-Id: <20210528090502.1799866-8-lee.jones@linaro.org>
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

 drivers/ata/pata_cs5520.c:99:19: warning: initialized field overwritten [-Woverride-init]
 drivers/ata/pata_cs5520.c:99:19: note: (near initialization for ‘cs5520_sht.sg_tablesize’)

Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/pata_cs5520.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/pata_cs5520.c b/drivers/ata/pata_cs5520.c
index d09d432d3c442..247c147026243 100644
--- a/drivers/ata/pata_cs5520.c
+++ b/drivers/ata/pata_cs5520.c
@@ -95,8 +95,9 @@ static void cs5520_set_piomode(struct ata_port *ap, struct ata_device *adev)
 }
 
 static struct scsi_host_template cs5520_sht = {
-	ATA_BMDMA_SHT(DRV_NAME),
+	ATA_BASE_SHT(DRV_NAME),
 	.sg_tablesize		= LIBATA_DUMB_MAX_PRD,
+	.dma_boundary		= ATA_DMA_BOUNDARY,
 };
 
 static struct ata_port_operations cs5520_port_ops = {
-- 
2.31.1

