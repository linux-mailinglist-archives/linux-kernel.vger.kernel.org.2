Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E197307D82
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 19:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbhA1SLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 13:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbhA1SG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 13:06:58 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB414C061A10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 10:03:05 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id d16so6299254wro.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 10:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uUtjn0S2LB1hEBiPsRyILzvTGxsfFgJnwAguVJkwf8M=;
        b=VOWAoFI7f87mmQpF61/B6XhrpLRiOTDKRgEzgQUruqg8nla/mCupvO58MKBvSqkMGg
         FCrwCgcHxom4YbO8EwoZlPubu2t9ejuP33iBOTlNe+632hC+nrhvzfROOAV0YUscqN4W
         ISmw/4ebKvXCCw5NgyawYbvhPd93k/VZ1bFBOGt+uv+BVbZ6DUnQ5KnQeZNmvfjlKpCy
         gJVhcZwkDBs2PWCHnFn9yo6716dRaWTOXvjY15FcC3PiYWhz4784EPLhTD+x4TwERxhA
         sxYlwlNERTo6gO3curiKUdKz4Egu2R4wdK3MnMBr0nS9F8YVS2Jm5RgqVuqxHQXQi6DT
         Xbcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uUtjn0S2LB1hEBiPsRyILzvTGxsfFgJnwAguVJkwf8M=;
        b=iA2aLZ+1uhJNpYaYK+lEtoExcPZoBJ9/VnOMNY7qNzeQXD8+HlN23IIBTRJHc2MtW4
         MMx6dKyuYkXeDF23v+AWegbWX0imT7Kf7cla89Q3iN0HEL85m32cEqaSO+e72p7ucGf8
         CiS/e3PagEEqWRzSznDaft8LsuUg2bZkKdteOH2Iv57spB0a0PblgT/nKqlfe7x6JZl9
         VfxxdDO8Y1uYUcGTGRM6yA7Ua+OZeMVs/2lbLIj3/nRhh6cEBsvLmrPt94zy7v3OyQRd
         cQDdOK3p3zTPGSSAU3/CFQ8x0khNnWNCgMbzO03MeZEaV4Z/05jphPLI+L5kY0yqy4Rc
         VSpw==
X-Gm-Message-State: AOAM531/Je6KHr5fPeh6ulzdeVNwX4L5caiWW6/3F9dNMMpCbl6DF/O1
        F8jQ1ewsTm8QbF6crFZlluwwtg==
X-Google-Smtp-Source: ABdhPJxPzc0IA9xahgijtPLfT9dZqdD9ejn57gN/lqF5wwV6CnFzhmlrLK3RGRvHy7StR5WPLMJ2jg==
X-Received: by 2002:adf:c109:: with SMTP id r9mr255640wre.261.1611856984478;
        Thu, 28 Jan 2021 10:03:04 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id u6sm8280794wro.75.2021.01.28.10.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 10:03:03 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Mark Lord <mlord@pobox.com>,
        ALWAYS copy <linux-ide@vger.kernel.org>
Subject: [PATCH 18/20] ata: sata_mv: Fix worthy headers and demote others
Date:   Thu, 28 Jan 2021 18:02:37 +0000
Message-Id: <20210128180239.548512-19-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210128180239.548512-1-lee.jones@linaro.org>
References: <20210128180239.548512-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ata/sata_mv.c:1162: warning: Function parameter or member 'ap' not described in 'mv_start_edma'
 drivers/ata/sata_mv.c:1162: warning: Function parameter or member 'port_mmio' not described in 'mv_start_edma'
 drivers/ata/sata_mv.c:1162: warning: Function parameter or member 'protocol' not described in 'mv_start_edma'
 drivers/ata/sata_mv.c:1162: warning: Excess function parameter 'base' description in 'mv_start_edma'
 drivers/ata/sata_mv.c:1535: warning: Function parameter or member 'enable_bmdma' not described in 'mv_bmdma_enable_iie'
 drivers/ata/sata_mv.c:1535: warning: expecting prototype for mv_bmdma_enable(). Prototype was for mv_bmdma_enable_iie() instead
 drivers/ata/sata_mv.c:1930: warning: Function parameter or member 'ap' not described in 'mv_bmdma_stop_ap'
 drivers/ata/sata_mv.c:1930: warning: expecting prototype for mv_bmdma_stop(). Prototype was for mv_bmdma_stop_ap() instead
 drivers/ata/sata_mv.c:2228: warning: Function parameter or member 'ap' not described in 'mv_send_fis'
 drivers/ata/sata_mv.c:3263: warning: Function parameter or member 'hpriv' not described in 'mv6_reset_hc'
 drivers/ata/sata_mv.c:3263: warning: Function parameter or member 'n_hc' not described in 'mv6_reset_hc'
 drivers/ata/sata_mv.c:3541: warning: Function parameter or member 'hpriv' not described in 'soc_is_65n'
 drivers/ata/sata_mv.c:3541: warning: expecting prototype for soc_is_65(). Prototype was for soc_is_65n() instead

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Mark Lord <mlord@pobox.com>
Cc: ALWAYS copy <linux-ide@vger.kernel.org>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/sata_mv.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 664ef658a955f..eafca46d8feb4 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -1146,9 +1146,8 @@ static void mv_set_irq_coalescing(struct ata_host *host,
 	spin_unlock_irqrestore(&host->lock, flags);
 }
 
-/**
+/*
  *      mv_start_edma - Enable eDMA engine
- *      @base: port base address
  *      @pp: port private data
  *
  *      Verify the local cache of the eDMA state is accurate with a
@@ -1519,7 +1518,7 @@ static void mv_60x1_errata_sata25(struct ata_port *ap, int want_ncq)
 		writel(new, hpriv->base + GPIO_PORT_CTL);
 }
 
-/**
+/*
  *	mv_bmdma_enable - set a magic bit on GEN_IIE to allow bmdma
  *	@ap: Port being initialized
  *
@@ -1919,7 +1918,7 @@ static void mv_bmdma_start(struct ata_queued_cmd *qc)
 
 /**
  *	mv_bmdma_stop - Stop BMDMA transfer
- *	@qc: queued command to stop DMA on.
+ *	@ap: port to stop
  *
  *	Clears the ATA_DMA_START flag in the bmdma control register
  *
@@ -2221,6 +2220,7 @@ static u8 mv_sff_check_status(struct ata_port *ap)
 
 /**
  *	mv_send_fis - Send a FIS, using the "Vendor-Unique FIS" register
+ *	@ap: ATA port to send a FIS
  *	@fis: fis to be sent
  *	@nwords: number of 32-bit words in the fis
  */
@@ -3249,7 +3249,7 @@ static void mv6_reset_flash(struct mv_host_priv *hpriv, void __iomem *mmio)
 	writel(tmp, mmio + GPIO_PORT_CTL);
 }
 
-/**
+/*
  *      mv6_reset_hc - Perform the 6xxx global soft reset
  *      @mmio: base address of the HBA
  *
@@ -3530,7 +3530,7 @@ static void mv_soc_65n_phy_errata(struct mv_host_priv *hpriv,
 	writel(reg, port_mmio + PHY_MODE9_GEN1);
 }
 
-/**
+/*
  *	soc_is_65 - check if the soc is 65 nano device
  *
  *	Detect the type of the SoC, this is done by reading the PHYCFG_OFS
-- 
2.25.1

