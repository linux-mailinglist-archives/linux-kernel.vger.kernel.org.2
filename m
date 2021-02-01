Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFE2130AB80
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 16:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbhBAPed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 10:34:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbhBAOlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 09:41:32 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0487AC061354
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 06:39:56 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id u14so12840263wml.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 06:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uUtjn0S2LB1hEBiPsRyILzvTGxsfFgJnwAguVJkwf8M=;
        b=vG3UQ+l+muIGDHGg3gEgTsa/CSGlQIvpCl4ZeEr0EUUKg3YWINzSdhoBAXfkpa2NA7
         k1N1BRCVDpz19btJTYIJ1WI9JUk2Kx9jISuQsSypXosLNdFcmohr7FzEVNgWrTz+UImc
         rDfla+w1wScD7ZvEd7gTr6eLiI+mt4KHtfV6HO++7kUqx0jCKprmVUoVvYzPfeiS+Erw
         sc/IiAWKSTXjbBXcFX6PK0E6y82cr57noddv08jT9SmQC9oETCriihIINqAtAH5Pn0WZ
         kBH8UEH/bl7hcokw0v6FJ2Oer4+orEg6AUzBVU6lv2PWvjWY/STzxRZZgU4YioNgH+FR
         1rkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uUtjn0S2LB1hEBiPsRyILzvTGxsfFgJnwAguVJkwf8M=;
        b=jjfyWajloAspoVCCl0uwOvtpqNhLyoSbUFrivY4dMY0YCBhNR9weJQ+PX9nyTKs6nN
         4NIv4niEt7O7COoxMFU2mmoUpbfaPZM9bhA/S2TwSXIERH9W9fSVXcBXrg57xPipLYjO
         8wNeaG/DKaJLK27jxUp1FiIjdzjIjn9XuXWHmLdSCT/RDiZBIc7/9kCSkc5YvgyzWcmL
         5+70FR7CaIo3aVIcKNFU7R6x9Z7SSipW68nBJmsxH1UhPqOiSIQqZJgUkOllk8Bk/ick
         xcjUHU32Ukj7p5vWU56rwwe67JZNsbA7yCk1YiOq5W3BsJQScpGX54elHwM5jh77w1Uc
         HrHQ==
X-Gm-Message-State: AOAM530xdmKymm6B89VD3gLGfre80cbn0eyDC7L+OI8g1OR/0USXUg5o
        4/S9Ocjmm1wjtl3yuVTeeAEvOA==
X-Google-Smtp-Source: ABdhPJxobTaw4erHEZXaTGvIHvRL7goO2idA9MkntLyU+8VAP9P3xHuQvw/0uWnOuztJqpKMs8DHBQ==
X-Received: by 2002:a7b:c196:: with SMTP id y22mr15365130wmi.91.1612190394771;
        Mon, 01 Feb 2021 06:39:54 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id h15sm27301359wrt.10.2021.02.01.06.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 06:39:54 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Mark Lord <mlord@pobox.com>,
        ALWAYS copy <linux-ide@vger.kernel.org>
Subject: [PATCH 10/20] ata: sata_mv: Fix worthy headers and demote others
Date:   Mon,  1 Feb 2021 14:39:30 +0000
Message-Id: <20210201143940.2070919-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201143940.2070919-1-lee.jones@linaro.org>
References: <20210201143940.2070919-1-lee.jones@linaro.org>
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

