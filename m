Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 569FF30AA1A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 15:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbhBAOnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 09:43:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbhBAOl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 09:41:28 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A54C061351
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 06:39:53 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id g10so16846942wrx.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 06:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0PbmlJv/q/qmETwokGHFJjxp6oe2rW16X/lQKCZKsiQ=;
        b=N14fXMdfJ2dY7UVo6YqvhbGGyRE7Akw/jRTJP4tcKHzwsHYQi8NDJqUkPOXyzSuN1+
         xEcc4Ay6vMNarhmuhQ/x57mdTja1HJlBVOU5YFqxXOTccKCiWebmJNiRTDden3uPxTt1
         2PvnirLGXFdSJISunOh5hfbJ7xpNpDlTA6NLZCou1Ce408pt5es0qNDWkWWQ+E2GAtEN
         O2lKyGmZHI3pC6QrW/kQ3iZdTmIn43oPXXHEtfK8ZBOz2m0tjwlF6Ln5V4jcJd+qp+9L
         SX/Zn458jPa2nQnbHUhYnyOpnsIXmPuxfdctiEM7cCY+gbAQIKMFjTRc6rvGQTWj4x7u
         U0cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0PbmlJv/q/qmETwokGHFJjxp6oe2rW16X/lQKCZKsiQ=;
        b=brT8xQe+K0TKkSt9WN8pJqj8SWY0VQQqjdSJnBhNsv7r43sWM+1+ypa0tamW99Wfis
         xUSK3F52YVk63j83FQgXCFyzmgqTvAYZE7cbD6d2jKI89tGIcZYnIbM0B5mLPoHYnR+Z
         7ANYxtttXRJN/qh79171FZhBtJDBUgSASTyWDGqAKU+Xy443GUyJvoGIEfS5KBmE0ghE
         M4a1G0aOys+jHzc9GTyOsHmQzAKmiO3RGm/geYfC5/AQVAQgEBMH9uA1RUAx4npGFM2U
         tQyfkqUPIhm3PrgUnoZLerJ2WBv5RbHrqlvDGRQsKVonyDM3DTT6U4Y1emLr4G0a5uOT
         tLcw==
X-Gm-Message-State: AOAM530cBwKfgc8nRDFrGPMS3MP+nv9TLOo+HKLjGEsvNqGlDYLDoRJG
        jA8qwHOxSTPNCc0/bXv5a1Mj1g==
X-Google-Smtp-Source: ABdhPJxWCUUYP+Zom+mOzHMrYuXDGlYfLGnUzNJnvCnLg7JI1fuFV8GAZT1yQ7wBEdpWmPWJ2R8dJg==
X-Received: by 2002:a05:6000:234:: with SMTP id l20mr18426866wrz.212.1612190392539;
        Mon, 01 Feb 2021 06:39:52 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id h15sm27301359wrt.10.2021.02.01.06.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 06:39:52 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Andre Hedrick <andre@linux-ide.org>, linux-ide@vger.kernel.org
Subject: [PATCH 08/20] ata: pata_hpt37x: Fix some function misnaming and missing param issues
Date:   Mon,  1 Feb 2021 14:39:28 +0000
Message-Id: <20210201143940.2070919-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201143940.2070919-1-lee.jones@linaro.org>
References: <20210201143940.2070919-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ata/pata_hpt37x.c:283: warning: Function parameter or member 'mask' not described in 'hpt370_filter'
 drivers/ata/pata_hpt37x.c:301: warning: Function parameter or member 'mask' not described in 'hpt370a_filter'
 drivers/ata/pata_hpt37x.c:473: warning: expecting prototype for hpt370_bmdma_end(). Prototype was for hpt370_bmdma_stop() instead
 drivers/ata/pata_hpt37x.c:567: warning: expecting prototype for hpt37x_bmdma_end(). Prototype was for hpt37x_bmdma_stop() instead

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Andre Hedrick <andre@linux-ide.org>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/pata_hpt37x.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_hpt37x.c b/drivers/ata/pata_hpt37x.c
index fad6c6a873130..f242157bc81bb 100644
--- a/drivers/ata/pata_hpt37x.c
+++ b/drivers/ata/pata_hpt37x.c
@@ -275,6 +275,7 @@ static const char * const bad_ata100_5[] = {
 /**
  *	hpt370_filter	-	mode selection filter
  *	@adev: ATA device
+ *	@mask: mode mask
  *
  *	Block UDMA on devices that cause trouble with this controller.
  */
@@ -293,6 +294,7 @@ static unsigned long hpt370_filter(struct ata_device *adev, unsigned long mask)
 /**
  *	hpt370a_filter	-	mode selection filter
  *	@adev: ATA device
+ *	@mask: mode mask
  *
  *	Block UDMA on devices that cause trouble with this controller.
  */
@@ -463,7 +465,7 @@ static void hpt370_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 }
 
 /**
- *	hpt370_bmdma_end		-	DMA engine stop
+ *	hpt370_bmdma_stop		-	DMA engine stop
  *	@qc: ATA command
  *
  *	Work around the HPT370 DMA engine.
@@ -557,7 +559,7 @@ static void hpt372_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 }
 
 /**
- *	hpt37x_bmdma_end		-	DMA engine stop
+ *	hpt37x_bmdma_stop		-	DMA engine stop
  *	@qc: ATA command
  *
  *	Clean up after the HPT372 and later DMA engine
-- 
2.25.1

