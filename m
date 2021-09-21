Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2C01412F8C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 09:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbhIUHgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 03:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbhIUHgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 03:36:04 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0478C061764
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 00:34:34 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id k23-20020a17090a591700b001976d2db364so1891107pji.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 00:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lNkTYEXPIHbmXpekiqOnuAZdI8FohljR3op2nnwnxx0=;
        b=DWAoq5cGqkbp1FF7x8O2eZiQADrE6eqcBzUE4TnIDGBmr65wpiEtWB0aVDexviKm8v
         vSJMBsRaoytKLDYmvPuVMZPASYnQOzkywQlsyHdsy3vR/b6ows4/2SoM6yzQSetAH41u
         N7Z56p9LGdLmbEyIqEb8cZWCIn6RIpNH9ORcR5Asypg9LPO99AOl9+ssWF+1vMDnvOmt
         gzl4pkoNZofQJqMTPYLUcYSZKNl8hYGkG/9jE+NjUakyMA/FjcaFTwaf4MZy4htrDiV9
         TuW4SaZ/FmlkptE9BwLzL/1XKHvtaXQrwdbkT/DMpi1pz58eyZE3FaggDOLZ7kTbl5z+
         f0mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lNkTYEXPIHbmXpekiqOnuAZdI8FohljR3op2nnwnxx0=;
        b=TqtFGPIFH8rvev3I+4FdlBbk2EO/KbjPb0D90/3kPOF1XLszkv3wCOYEk2RlP6BNR8
         yNGUhbB779PK5uxIRb7K1tV8vDHb6wuxCeDg8T6wTbo8EZyVQgSOo0q0RXpKP4HrZ5eU
         43nGbCa2Ng/KCb1eMlTkc2xE5agt2m0HASOZNSdStovdWIvh6kuWTD/8L0mJHUrc66wl
         8vv02NawjG6IHD5+kaFEbAJ20WF+AF27mO81dkfR9If1bbiyWHH4MfFPdsZXR8rEhX6o
         SfJVcRU8ZkBRCwBR6yH4hrjsShZ9E+3oFbVfEuvxPHSJH1wXvOx9Rp5hduZrYUlB/H7M
         WPtw==
X-Gm-Message-State: AOAM53174bTAWkYoR7uwL4jU/qAHTlrB7bhwvDwZCAx17/9WsVQ8aKEI
        ypOrOIODFy88JDURG0lmTx8=
X-Google-Smtp-Source: ABdhPJxQJTMFlUza/zA2xNAAjujLphEEfiSE60BOhQ7kccP1aA8GRIiiG+Rpi0IFsQsLhC9iuIdWiA==
X-Received: by 2002:a17:90b:38cc:: with SMTP id nn12mr3761588pjb.108.1632209674273;
        Tue, 21 Sep 2021 00:34:34 -0700 (PDT)
Received: from localhost.localdomain ([2402:e280:2130:198:9b25:1cfb:9ff3:2a8f])
        by smtp.gmail.com with ESMTPSA id x8sm16565957pfq.131.2021.09.21.00.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 00:34:34 -0700 (PDT)
From:   Benjamin Philip <benjamin.philip495@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Benjamin Philip <benjamin.philip495@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] staging: rts5208: remove unnecessary parentheses in rtsx_transport.c
Date:   Tue, 21 Sep 2021 13:03:45 +0530
Message-Id: <2fdcc64fbfa85482917d229163e4eb6c4094b789.1632209460.git.benjamin.philip495@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632209460.git.benjamin.philip495@gmail.com>
References: <cover.1632209460.git.benjamin.philip495@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit removes unnecessary parentheses, that have been flagged
by checkpatch.pl in rtsx_transport.c.

Signed-off-by: Benjamin Philip <benjamin.philip495@gmail.com>
---
 drivers/staging/rts5208/rtsx_transport.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rts5208/rtsx_transport.c b/drivers/staging/rts5208/rtsx_transport.c
index 909a3e663ef6..805dc18fac0a 100644
--- a/drivers/staging/rts5208/rtsx_transport.c
+++ b/drivers/staging/rts5208/rtsx_transport.c
@@ -326,7 +326,7 @@ static int rtsx_transfer_sglist_adma_partial(struct rtsx_chip *chip, u8 card,
 	struct scatterlist *sg_ptr;
 	u32 val = TRIG_DMA;
 
-	if (!sg || (num_sg <= 0) || !offset || !index)
+	if (!sg || num_sg <= 0 || !offset || !index)
 		return -EIO;
 
 	if (dma_dir == DMA_TO_DEVICE)
@@ -489,7 +489,7 @@ static int rtsx_transfer_sglist_adma(struct rtsx_chip *chip, u8 card,
 	long timeleft;
 	struct scatterlist *sg_ptr;
 
-	if (!sg || (num_sg <= 0))
+	if (!sg || num_sg <= 0)
 		return -EIO;
 
 	if (dma_dir == DMA_TO_DEVICE)
@@ -635,7 +635,7 @@ static int rtsx_transfer_buf(struct rtsx_chip *chip, u8 card, void *buf,
 	u32 val = BIT(31);
 	long timeleft;
 
-	if (!buf || (len <= 0))
+	if (!buf || len <= 0)
 		return -EIO;
 
 	if (dma_dir == DMA_TO_DEVICE)
-- 
2.31.1

