Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88251340140
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 09:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbhCRIwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 04:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbhCRIvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 04:51:55 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1620C061760
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 01:51:54 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id v11so4599752wro.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 01:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ystH3myeToYGZd9BOxHc1y/jrK48gikwMGVDRc5Ve78=;
        b=WvZ4yc83cLyyR8aCuTFUcfCIK/bNibqruWRisk+DMhXqt/psnvrO5+YG+tRKf+5Aot
         GsZxB3nikqN3W1lknbIYCXEW9JHbPu5KMAida6CNgoG0tCR2of0UuMlgHNPCJnmEjysz
         jOpTvluwFF3ERzUJCtNtbyqtxjEYFUPSNvH5Te+ykWyNgi8k4Rid7nX+qj9CsNZwnYEZ
         fsQocuR+ElhekSUXRkwdEJZ/7C857jYelmfjGrbgD+l35eOesr7+06mgJjZesbY/qGoY
         1uph666BM+419FSsvemt7gyjVOON5MToMYyyluQrV6yqrAzy91RVDzNKRZMngMmDTQUg
         MduQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ystH3myeToYGZd9BOxHc1y/jrK48gikwMGVDRc5Ve78=;
        b=j2WkE1qefeGzphEHoikAzi6EgW3LLDKRUDlANXlXlspYJwcejgT4BcW7c6c58QTdLD
         08v/LzHtW60DwD+IOkyEnj6FGgot5xYKzggv4KX3r16hoqCkQ7qWGgSyDs+d8TEv8Fov
         8eOZPTbC818HwHJykZD29hZELbCmyMbzWv++ob0WNxsB8FnZyut7Y7PxKWkgnPNmX7HT
         Kjdcr5h8gT3JxQl1ZEJsV++HDvy9lROrChSh3Xn6SspHViFYUQNIULjmvCYFjZuVuUJr
         mxNRM7mcVgzNthkKVsSJmnAiPUOrCQG0o1EwUHfOBS1cFqS0XyGWBXp7a+cbkjKfUQLI
         KNfg==
X-Gm-Message-State: AOAM530SBjIby1uj+yEFEKL2tjHChUUSJlN12e0Ho4XFHA4L61HaJ3UW
        d7LsUj/q8Kd18ykjdVNQIuJLgiOQEB/9Lg==
X-Google-Smtp-Source: ABdhPJxo8bV03/lAPsmphEXIb5LOtTF/A8T+YRXITJthCNS8OTQ2s0J5hMPfg+088GXYb3TJUXSkKA==
X-Received: by 2002:a5d:560e:: with SMTP id l14mr8436423wrv.10.1616057513665;
        Thu, 18 Mar 2021 01:51:53 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id w131sm1526868wmb.8.2021.03.18.01.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 01:51:53 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org
Subject: [PATCH 01/15] ata: pata_pdc202xx_old: Fix some incorrectly named functions
Date:   Thu, 18 Mar 2021 08:51:36 +0000
Message-Id: <20210318085150.3131936-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210318085150.3131936-1-lee.jones@linaro.org>
References: <20210318085150.3131936-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ata/pata_pdc202xx_old.c:127: warning: expecting prototype for pdc202xx_configure_dmamode(). Prototype was for pdc202xx_set_dmamode() instead
 drivers/ata/pata_pdc202xx_old.c:228: warning: expecting prototype for pdc2026x_bmdma_end(). Prototype was for pdc2026x_bmdma_stop() instead

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/pata_pdc202xx_old.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_pdc202xx_old.c b/drivers/ata/pata_pdc202xx_old.c
index 378ed9ea97e90..0c5cbcd28d0db 100644
--- a/drivers/ata/pata_pdc202xx_old.c
+++ b/drivers/ata/pata_pdc202xx_old.c
@@ -115,7 +115,7 @@ static void pdc202xx_set_piomode(struct ata_port *ap, struct ata_device *adev)
 }
 
 /**
- *	pdc202xx_configure_dmamode	-	set DMA mode in chip
+ *	pdc202xx_set_dmamode	-	set DMA mode in chip
  *	@ap: ATA interface
  *	@adev: ATA device
  *
@@ -214,7 +214,7 @@ static void pdc2026x_bmdma_start(struct ata_queued_cmd *qc)
 }
 
 /**
- *	pdc2026x_bmdma_end		-	DMA engine stop
+ *	pdc2026x_bmdma_stop		-	DMA engine stop
  *	@qc: ATA command
  *
  *	After a DMA completes we need to put the clock back to 33MHz for
-- 
2.27.0

