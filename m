Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E15E3AB1E6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 13:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbhFQLHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 07:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbhFQLHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 07:07:37 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388FCC06175F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 04:05:28 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id n7so6301255wri.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 04:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qOyMMWhfP6MWOMw5YpJV2nOghpwWcvUPkfKCZHt0P9Y=;
        b=Rgdx1B8vPPqCsga5Zdv5K2+aZJ1JH+riMhs0hBlai/LfZ1iIJBiOS9W2lRMgHznuWu
         rtWHKaLdpFLDzpW5htir1wpQz+AQLbLGnh8uhoWugEJP8F5YxOqojpS3y8uFxZWpW3fY
         stWflfYf5mFQcuab5W+yWK1/n58vV3Q1m+hLgsSA32zFY/xIFSngmAeCqIPOIxou8jf6
         igsuNEJpc9pBBfjIyJtm1l2c0qCOTjxzG1iAuOpAsoeWyFi0Ic0x0Ro2hrMNU8Z+VWgY
         SsIlgxwhPvJFTRQ4tAB9h9CCBT0nkJVwHwIxbIrCbeUle/fJ+sXoffSKyfU+AaC0oPBc
         CW+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qOyMMWhfP6MWOMw5YpJV2nOghpwWcvUPkfKCZHt0P9Y=;
        b=lLrdSQf04IBrUR83+mjVPp4jHKJXZcmLXkhD+J2BsRvDBIX0JlNK5sBo3JZuQbmMXm
         QDs/J1ioAEX19a9sN8qdPic1rXvoukcG7THRjQBIikrAapWKSzj5kADvy72YjyGeGp5S
         I2/BhiHOdZ433ZICSpVElFA//WcH9QriyTh6aeHfGX0/zgBXDElvC0gzZVYJ9/ntrOcf
         mCJ5Zbz0R0jk5hWiugSBGepZ766kPGeDbh2ZPy3FzCHWQ67BhJAAymcl1SvE7T61R4O4
         jJryQz7amKiyCj2cwnfRJXs9jY3DhZKbzlaBJ84briuBqczNYIXNBQ2syDGQXfgo6TBN
         mNtw==
X-Gm-Message-State: AOAM532WCjAUklHpudJfgIYeNdKReS2OjqLhj7AuuQ2kAM4BOOYvFIU5
        dDbpgCeAsd76s8m4He46uIXHDw==
X-Google-Smtp-Source: ABdhPJx5yFP7d4NQEOhnnQWJ0nKS/7qT5YFxRgXwq9Cvxl0ab3E6ORI+wa5aPNLCKTET0CDNeLY/qg==
X-Received: by 2002:a5d:47cf:: with SMTP id o15mr5048726wrc.6.1623927926856;
        Thu, 17 Jun 2021 04:05:26 -0700 (PDT)
Received: from dell.default ([91.110.221.170])
        by smtp.gmail.com with ESMTPSA id v18sm5249487wrb.10.2021.06.17.04.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 04:05:26 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Stuart Yoder <stuyoder@gmail.com>,
        German Rivera <German.Rivera@freescale.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH 5/8] bus: fsl-mc: dprc-driver: Fix some missing/incorrect function parameter descriptions
Date:   Thu, 17 Jun 2021 12:04:57 +0100
Message-Id: <20210617110500.15907-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210617110500.15907-1-lee.jones@linaro.org>
References: <20210617110500.15907-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/bus/fsl-mc/dprc-driver.c:360: warning: Function parameter or member 'alloc_interrupts' not described in 'dprc_scan_container'
 drivers/bus/fsl-mc/dprc-driver.c:383: warning: Function parameter or member 'irq_num' not described in 'dprc_irq0_handler'
 drivers/bus/fsl-mc/dprc-driver.c:383: warning: Excess function parameter 'irq' description in 'dprc_irq0_handler'
 drivers/bus/fsl-mc/dprc-driver.c:394: warning: Function parameter or member 'irq_num' not described in 'dprc_irq0_handler_thread'
 drivers/bus/fsl-mc/dprc-driver.c:394: warning: Excess function parameter 'irq' description in 'dprc_irq0_handler_thread'

Cc: Stuart Yoder <stuyoder@gmail.com>
Cc: German Rivera <German.Rivera@freescale.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Reviewed-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/bus/fsl-mc/dprc-driver.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/fsl-mc/dprc-driver.c b/drivers/bus/fsl-mc/dprc-driver.c
index e3e2ae41c22b3..315e830b6ecda 100644
--- a/drivers/bus/fsl-mc/dprc-driver.c
+++ b/drivers/bus/fsl-mc/dprc-driver.c
@@ -350,7 +350,8 @@ int dprc_scan_objects(struct fsl_mc_device *mc_bus_dev,
  * dprc_scan_container - Scans a physical DPRC and synchronizes Linux bus state
  *
  * @mc_bus_dev: pointer to the fsl-mc device that represents a DPRC object
- *
+ * @alloc_interrupts: if true the function allocates the interrupt pool,
+ *                    otherwise the interrupt allocation is delayed
  * Scans the physical DPRC and synchronizes the state of the Linux
  * bus driver with the actual state of the MC by adding and removing
  * devices as appropriate.
@@ -373,10 +374,11 @@ int dprc_scan_container(struct fsl_mc_device *mc_bus_dev,
 	return error;
 }
 EXPORT_SYMBOL_GPL(dprc_scan_container);
+
 /**
  * dprc_irq0_handler - Regular ISR for DPRC interrupt 0
  *
- * @irq: IRQ number of the interrupt being handled
+ * @irq_num: IRQ number of the interrupt being handled
  * @arg: Pointer to device structure
  */
 static irqreturn_t dprc_irq0_handler(int irq_num, void *arg)
@@ -387,7 +389,7 @@ static irqreturn_t dprc_irq0_handler(int irq_num, void *arg)
 /**
  * dprc_irq0_handler_thread - Handler thread function for DPRC interrupt 0
  *
- * @irq: IRQ number of the interrupt being handled
+ * @irq_num: IRQ number of the interrupt being handled
  * @arg: Pointer to device structure
  */
 static irqreturn_t dprc_irq0_handler_thread(int irq_num, void *arg)
-- 
2.32.0

