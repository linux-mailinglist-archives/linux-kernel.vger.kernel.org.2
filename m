Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7280530AA0B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 15:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbhBAOlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 09:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbhBAOlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 09:41:09 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4E0C06178B
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 06:39:49 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id z6so16775451wrq.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 06:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lDwxjOTNwRK/jrgXFyt6Q5KAd5bTTyW5pp6F8HQ+RfM=;
        b=ra/HweOfs/gsoL7RyLujE631F/5dEYvUbwH3AyoP0y+0qLVXdfz9LBEfiacR6k0Uiv
         /hmLUtwrpWpF8pMBw/JnZJFgp3UrAG8o0tGYTfvesq3H+057BEMzHQDVk0Wr3l9jmSFC
         sQzdhrMyVmMfr3Ez5VoTReuvdHasOXOM/18O+D1LAzBmAXSRs8eO/N7sUd611slNq5SP
         N9HIlQNxRDHpL2M8WPcGlCx9Ea2ECGM94xa9XIVHyGxgO8jfqnoiQoX/e8iMriwr5voJ
         YLqbsL1SCCeUlEumVhEdHwbDxaC0y4iw28JMpVgAKglMmGIvkmJeRCLSmLOsfFoIJXCN
         AG5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lDwxjOTNwRK/jrgXFyt6Q5KAd5bTTyW5pp6F8HQ+RfM=;
        b=n3kPEurrBO9Fz6utvdLT7ryAXi1miudJk3SQCdm7OIdamu0U/gBFLGYDbpmsCNMKGn
         gtl7tZPTdKx07HkIX5m7WftCvZeGAn4OCwBU/hbR9OxW6fxFAs0hTNjjul6K+U98k2MF
         hQwOCKJsILvsaWVeCND3PE2bmaluHoe+qXukc2/Gri4h0IgUFv6sZSY+BjQgzLA56+ds
         0Y/IRI75tN3mPSh20C/kbzgQXPBYY1Un8w7sJ1grEkI+S7k4OGGKSE3d7wtH4JUWQF9K
         Vx8JLlHhWPee55yn9FS3ZMXTNvf+FyUYNt00Eo3kD+W7pc2rYIBMR0YadsVrqjgfSN7+
         7bjA==
X-Gm-Message-State: AOAM530aSJppbJlGKNzNixecf98qL4/EyHpOQ0NDpW7wQ4Dc1JLQGrda
        LLrdxf23EUlSyn4iyAOgBNFQKw==
X-Google-Smtp-Source: ABdhPJw4cRTTRwXoePbizxuey8YfKHu06X58Br5OOurPNGDHnCrrdn6vczKshahRCQ+oD4IRxt4AXg==
X-Received: by 2002:a05:6000:1202:: with SMTP id e2mr6890968wrx.328.1612190388422;
        Mon, 01 Feb 2021 06:39:48 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id h15sm27301359wrt.10.2021.02.01.06.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 06:39:47 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        CJ <cjtsai@ali.com.tw>, Andre Hedrick <andre@linux-ide.org>,
        Alan Cox <alan@redhat.com>,
        Clear Zhang <Clear.Zhang@ali.com.tw>,
        linux-ide@vger.kernel.org, and cc <htejun@gmail.com>
Subject: [PATCH 04/20] ata: pata_ali: Repair some misnamed kernel-doc issues
Date:   Mon,  1 Feb 2021 14:39:24 +0000
Message-Id: <20210201143940.2070919-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201143940.2070919-1-lee.jones@linaro.org>
References: <20210201143940.2070919-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ata/pata_ali.c:119: warning: Function parameter or member 'mask' not described in 'ali_20_filter'
 drivers/ata/pata_ali.c:119: warning: Excess function parameter 'ap' description in 'ali_20_filter'
 drivers/ata/pata_ali.c:322: warning: Function parameter or member 'qc' not described in 'ali_check_atapi_dma'
 drivers/ata/pata_ali.c:322: warning: Excess function parameter 'adev' description in 'ali_check_atapi_dma'

Cc: Jens Axboe <axboe@kernel.dk>
Cc: CJ <cjtsai@ali.com.tw>
Cc: Andre Hedrick <andre@linux-ide.org>
Cc: Alan Cox <alan@redhat.com>
Cc: Clear Zhang <Clear.Zhang@ali.com.tw>
Cc: linux-ide@vger.kernel.org
Cc: and cc <htejun@gmail.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/pata_ali.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_ali.c b/drivers/ata/pata_ali.c
index 0b122f903b8a8..e18aa02f89530 100644
--- a/drivers/ata/pata_ali.c
+++ b/drivers/ata/pata_ali.c
@@ -108,7 +108,7 @@ static int ali_c2_cable_detect(struct ata_port *ap)
 
 /**
  *	ali_20_filter		-	filter for earlier ALI DMA
- *	@ap: ALi ATA port
+ *	@adev: ATA device
  *	@adev: attached device
  *
  *	Ensure that we do not do DMA on CD devices. We may be able to
@@ -313,7 +313,7 @@ static void ali_lock_sectors(struct ata_device *adev)
 
 /**
  *	ali_check_atapi_dma	-	DMA check for most ALi controllers
- *	@adev: Device
+ *	@qc: Command to complete
  *
  *	Called to decide whether commands should be sent by DMA or PIO
  */
-- 
2.25.1

