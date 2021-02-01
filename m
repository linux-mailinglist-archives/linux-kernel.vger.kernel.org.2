Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 234BC30AA1B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 15:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbhBAOnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 09:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbhBAOl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 09:41:59 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2760AC061222
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 06:40:00 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id u14so13391665wmq.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 06:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9JDBMmgrFoXz6Tq0/RYZRCcswI9jrwMOoIxfQ3LDYhE=;
        b=nBNTL8NllFuSIqpu9W87YK9Jyo6ZKRW4b3Efot8Fbhi8ZYVkCfVHFFNUuk+wle657W
         VFaXvFYoaSgc4skwFELv1JFyX/Nf9mKDuV79+hTvtUqGbVQdl+ZPQJoFIxCIOe4axf1W
         JhLt4ECV+Gkth0ae5s6owEii/hMXqeTBeSzddcE3xqXL/lB2O2WMKCI1Ypt0t0JXi0+X
         AIli0lASNRDooifXIYIKbM+oh+KTi/abrUZ+TWb1zIkNe+a1SK7JB+KsWn6fU2SY47rc
         PqWP7DCpwPuIMieFkjDlFIASLzRa3fr6U1qaO0pdIcxP0uTC760nmaDel/fB0z15I5Jp
         rc1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9JDBMmgrFoXz6Tq0/RYZRCcswI9jrwMOoIxfQ3LDYhE=;
        b=gh4m9jV1mS3sIEyvFHzsok8Zn9mPANuVeHrFTVb4LErPDG4i+6ZrcjWB3/rm8fmXok
         jBkCaLbzJKeqmU89kviLmw2KeLGsLXXSZXpVBeTQ/fEMq2i8M6lQ3QFY7pDUBacfP01T
         E4vS5iiW8eQAN0GXAsTT4iRn6T4tj6D5Xy5q1EgB45rPJnSo704oq3SIZe8GWtvogbd9
         /ynWrI8alPHVcgwWkQatx2+Y1SjIY/vQzqO/169p2JTmoZEJc6VhlCwiAUVbEaQEaQAd
         vOYLyU5chKMQtCtx2NtzuYE+7SOwKOmO5B1bVmoWvN8OVrRDVLZPV+bU3OESHCQGOPfT
         Q0pA==
X-Gm-Message-State: AOAM532AanUuuTGQoRb0to2sXbEIyv8y4jRcgL+BAx0p2i8zoegR/M4/
        bnYa5XJYQ7Z4BDXo1AF5xe9btg==
X-Google-Smtp-Source: ABdhPJzETHP18h8WFbldkDtgdSCitWNoRnpxhK0ewYLbgWMleHO3cRkXllWdeuLFsAfYkmzie4btGA==
X-Received: by 2002:a05:600c:3504:: with SMTP id h4mr2789387wmq.168.1612190398918;
        Mon, 01 Feb 2021 06:39:58 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id h15sm27301359wrt.10.2021.02.01.06.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 06:39:58 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        ATI Inc <hyu@ati.com>, linux-ide@vger.kernel.org
Subject: [PATCH 14/20] ata: pata_atiixp: Fix a function name and supply description for 'pio'
Date:   Mon,  1 Feb 2021 14:39:34 +0000
Message-Id: <20210201143940.2070919-15-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201143940.2070919-1-lee.jones@linaro.org>
References: <20210201143940.2070919-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ata/pata_atiixp.c:103: warning: Function parameter or member 'pio' not described in 'atiixp_set_pio_timing'
 drivers/ata/pata_atiixp.c:241: warning: expecting prototype for atiixp_dma_stop(). Prototype was for atiixp_bmdma_stop() instead

Cc: Jens Axboe <axboe@kernel.dk>
Cc: ATI Inc <hyu@ati.com>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/pata_atiixp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/pata_atiixp.c b/drivers/ata/pata_atiixp.c
index c68aa3f585f22..d671d33ef2874 100644
--- a/drivers/ata/pata_atiixp.c
+++ b/drivers/ata/pata_atiixp.c
@@ -93,6 +93,7 @@ static int atiixp_prereset(struct ata_link *link, unsigned long deadline)
  *	atiixp_set_pio_timing	-	set initial PIO mode data
  *	@ap: ATA interface
  *	@adev: ATA device
+ *	@pio: Requested PIO
  *
  *	Called by both the pio and dma setup functions to set the controller
  *	timings for PIO transfers. We must load both the mode number and
@@ -227,7 +228,7 @@ static void atiixp_bmdma_start(struct ata_queued_cmd *qc)
 }
 
 /**
- *	atiixp_dma_stop	-	DMA stop callback
+ *	atiixp_bmdma_stop	-	DMA stop callback
  *	@qc: Command in progress
  *
  *	DMA has completed. Clear the UDMA flag as the next operations will
-- 
2.25.1

