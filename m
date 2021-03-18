Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 257E834014F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 09:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbhCRIwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 04:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbhCRIv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 04:51:58 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F8FC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 01:51:58 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id v11so4599923wro.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 01:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZhbJedmQUxP+5l1CY/WvdMVn4GmUSphVJyAa3aPfYeY=;
        b=g+524pjB68OpStk2UTz5JvSpTr+nqBKHyf+sbLG5h3xinlzB1qYw/BDf0CV5IJB7f3
         Je6HUBlzu8AGeogtjbF+4M3Lx9k38MBfudzqwwzyjK7DcUuewOKhqZSNDCiFtUUoilkc
         Z1T7/eKcGfrbBTktlmmyMS3bTqEzcjP6/TjrqcHDh06V82+833PLPGehUpvySSbdb/fU
         IcHyiD4WOB+hPF0OJd3nyBQGl/psuEsnOwuvmhrJxSkAmWHSmnBSWZNOiUsbAHMcE00r
         0xa/0CMbAPbwSlPH6IgZPo3ujcXka+oHRaa1Dd1fZvOV147iXX7K5HyTIwzzOqXgaV/q
         30eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZhbJedmQUxP+5l1CY/WvdMVn4GmUSphVJyAa3aPfYeY=;
        b=dN5XG4+m8sEF5YjzuLYISBss40xJAuwSFUn+O8WNO69/QnwPENxRpqfbBbg4cok+0z
         JZt3SMGvs7yJyEYEmtZ1Etk4KHi0z6UNqrc+yP21HIKJOT29uLYoEQcrBUChITQQvWpX
         vbzVXPmHFTL5tU81d6vdpc3Klw2vMW6VSr+M7QoLplUofUZsOUD4jEUZzywhvbfQ7Bw0
         c8A3SOUGNXR2UGT3YhkR4NNSNCdJ2bsskTaoEq/W3G/1We7FgI+KMaYkK/XNJks+plNR
         mKFmvAbspe7BZD8+Kx3k1uYfSjBG6bwUcaYJNPMTVNuhXJn+hA+8xSx5I6DzypFVLp6J
         fysQ==
X-Gm-Message-State: AOAM530ziUW9GpO/WPut6XEkJLYJzSpePsuVAYWch1rS/tm4hDb9yp6O
        2lkb0+M3uwn57/QMZZrZyJ5bu4ZszxxA2w==
X-Google-Smtp-Source: ABdhPJz/I4x45NEO7/hE6qMgwqk8vHb2i0yKi8wYMdR5K6R/bTbkCOE7MNAMxfoKdLVMiIix8y3Z8w==
X-Received: by 2002:a5d:468e:: with SMTP id u14mr8554111wrq.359.1616057517086;
        Thu, 18 Mar 2021 01:51:57 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id w131sm1526868wmb.8.2021.03.18.01.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 01:51:56 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org
Subject: [PATCH 05/15] ata: pata_it821x: Fix possible doc-rotted function names
Date:   Thu, 18 Mar 2021 08:51:40 +0000
Message-Id: <20210318085150.3131936-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210318085150.3131936-1-lee.jones@linaro.org>
References: <20210318085150.3131936-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ata/pata_it821x.c:346: warning: expecting prototype for it821x_passthru_dma_start(). Prototype was for it821x_passthru_bmdma_start() instead
 drivers/ata/pata_it821x.c:369: warning: expecting prototype for it821x_passthru_dma_stop(). Prototype was for it821x_passthru_bmdma_stop() instead

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/pata_it821x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_it821x.c b/drivers/ata/pata_it821x.c
index 9bac79edbc2ce..0e2265978a34e 100644
--- a/drivers/ata/pata_it821x.c
+++ b/drivers/ata/pata_it821x.c
@@ -334,7 +334,7 @@ static void it821x_passthru_set_dmamode(struct ata_port *ap, struct ata_device *
 }
 
 /**
- *	it821x_passthru_dma_start	-	DMA start callback
+ *	it821x_passthru_bmdma_start	-	DMA start callback
  *	@qc: Command in progress
  *
  *	Usually drivers set the DMA timing at the point the set_dmamode call
@@ -357,7 +357,7 @@ static void it821x_passthru_bmdma_start(struct ata_queued_cmd *qc)
 }
 
 /**
- *	it821x_passthru_dma_stop	-	DMA stop callback
+ *	it821x_passthru_bmdma_stop	-	DMA stop callback
  *	@qc: ATA command
  *
  *	We loaded new timings in dma_start, as a result we need to restore
-- 
2.27.0

