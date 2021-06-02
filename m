Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A9C398641
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 12:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbhFBKU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 06:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbhFBKTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 06:19:41 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD640C06174A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 03:17:47 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id h12-20020a05600c350cb029019fae7a26cdso1321929wmq.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 03:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+NvljD9Coe3ImbVweUQhRVx0U62sw+qymnCXTI2Y/Fw=;
        b=Gc9btDcQSoeuLckJ3t8QvsF8N1XiFgL8Yc10DL7jwSYW5cVBidCVJWCiUbQE4cpQTe
         ABCaHy0bP7v8JrcR3tPLIWbA49QaqUN/UgeznpNE+or3KHcYsZDM8HK43mlpbFUMxuwd
         My623Iu3a4ApnfO9kDC8b7hvQhJjq3/1mvMT8jYAqR2rWNoqSe//YMUsP0/UZ6itFFKD
         Biro4D72WU95DpCGE+5osKehNHqaiqYSQE2XY3bsdSJiLI+49OwRQtJ8UKl0mFt8SKYv
         vjjYQCKvnfbGLqhULN13U6B/D7GVCrYG46OtlYXtQSD3ap/YIY1O7yuXaMnDHzsy1LWo
         LU3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+NvljD9Coe3ImbVweUQhRVx0U62sw+qymnCXTI2Y/Fw=;
        b=j6XRFzWhOECmGghUCI0ZiXEt80LeT4epls5/0fOfqXKHJP5RvoVyLmEI6wHiT2Qkxe
         dk3BPRakox2LGngS+8BsOB163NAWk0IYImnyyC2tNEXg9S2wSQGEML19pz2O5b8GZDWp
         NkNnmFNxBL0SLzdDQMx/LLQ8EWjsluUpkfwdta/zqQRsBFnxLDSaR6FI7OfEes+BvnQd
         59e10dA9cGh812KJ0ZTryB0L6h10qoCkpiehgoZTBiVjgD08DdnVx9AuZnxZr00eei6c
         fZIhcNDYf+9uvEhSbJK2a60rs5STgnvheszS/UtPciFLLDb/e7E/O5SwpzJ75UcRhMjb
         /73g==
X-Gm-Message-State: AOAM530TIP5duWd6HatmrHHB92pTmD56Ks7lVqEOHkBuFxQMBBzQP7mF
        uWIMAmEhLcTMDe0u/gb92/pq2w==
X-Google-Smtp-Source: ABdhPJwwcyUY7GSV9q5R5pikjcfL0GaGuqMxRtnHnBtiSkEpFd7Ggbu7+oBDJJL1GrZVcThFLxXdHg==
X-Received: by 2002:a1c:1b93:: with SMTP id b141mr20132118wmb.8.1622629066278;
        Wed, 02 Jun 2021 03:17:46 -0700 (PDT)
Received: from dell.default ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id q11sm1593265wmq.1.2021.06.02.03.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 03:17:45 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Andre Hedrick <andre@linux-ide.org>, linux-ide@vger.kernel.org
Subject: [PATCH 13/21] ide: siimage: Fix some incorrectly documented functions/params
Date:   Wed,  2 Jun 2021 11:17:14 +0100
Message-Id: <20210602101722.2276638-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602101722.2276638-1-lee.jones@linaro.org>
References: <20210602101722.2276638-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ide/siimage.c:115: warning: Function parameter or member 'drive' not described in 'siimage_seldev'
 drivers/ide/siimage.c:115: warning: Excess function parameter 'hwif' description in 'siimage_seldev'
 drivers/ide/siimage.c:196: warning: expecting prototype for sil_udma_filter(). Prototype was for sil_pata_udma_filter() instead

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andre Hedrick <andre@linux-ide.org>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ide/siimage.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ide/siimage.c b/drivers/ide/siimage.c
index c190dc6dfb50a..64fa6b253a824 100644
--- a/drivers/ide/siimage.c
+++ b/drivers/ide/siimage.c
@@ -103,7 +103,7 @@ static unsigned long siimage_selreg(ide_hwif_t *hwif, int r)
 
 /**
  *	siimage_seldev		-	return register base
- *	@hwif: interface
+ *	@drive: interface
  *	@r: config offset
  *
  *	Turn a config register offset into the right address in either
@@ -183,7 +183,7 @@ static void sil_iowrite32(struct pci_dev *dev, u32 val, unsigned long addr)
 }
 
 /**
- *	sil_udma_filter		-	compute UDMA mask
+ *	sil_pata_udma_filter		-	compute UDMA mask
  *	@drive: IDE device
  *
  *	Compute the available UDMA speeds for the device on the interface.
-- 
2.31.1

