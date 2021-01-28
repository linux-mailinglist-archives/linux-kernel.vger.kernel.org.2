Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E73F5307D7E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 19:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbhA1SKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 13:10:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbhA1SFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 13:05:14 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287C8C061224
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 10:03:00 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id 7so6362195wrz.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 10:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0PbmlJv/q/qmETwokGHFJjxp6oe2rW16X/lQKCZKsiQ=;
        b=aq2rx7gWn31iQw3uOa+4G2xrcd0Ag4/SNRBj05WKYiunjcU1KlddQNhyZ1fcQ/dtoB
         SPO9bBPkOGwQtiKibTcbhvJs60PbSDUmp0VRcawAh2W6A1zoP/LJc5//u/q4/hLW12V8
         5vZIAkfYlWeqXL4YzNjdfH6o13EoReLKM3Gt/K1bg9dq7e4d0LyTayz48f9xi2vmQ7UF
         GvdeGkq9Ul9LXP7TJX7ASnm4uACJAP3JvF1sk+FlvcS6C5gdWV4Ac8Q4eOg863EAlE6F
         7JGV178gMSQLFb8H6FGx/SUCWBEfAffcpxrilkZeg6M2qYftLplKDfo5u+/uE2inU4W/
         IkMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0PbmlJv/q/qmETwokGHFJjxp6oe2rW16X/lQKCZKsiQ=;
        b=mdEWlzw5D6rXBXdFl5scyXWznOX4iXl3ra7QWxgejFcoI9bSpQofS6HnkS+zd3WgNH
         3Z+odioRmWLpxNfCVBk/s8QLWFulLdoQVZ4DzhQTBHLQQrrBN5aYiqxHenajsKlG2Cmr
         9mqDN6qQKJjh4KWOfjPfhdzDdqnlNWFOKdNaZ4llVsUwVN+U/O3dVpKk2xd75SlqGaUA
         GQN5LrfLo8gZkvj9L4NDM3W4j0cOspuKHbfBWUZXJV9Me0A06Lyltx44C8pCM8YrVBwa
         pjrVWqEezgwZ5GdB1sqR/t1tMnqIFNwCatkqlOiqCR3BF2gPMj6ojfglne4rFY1RogB/
         l3rQ==
X-Gm-Message-State: AOAM5329vcIF03Te+XuJIThGvhTmeec4JV5rxzcCWU7w1XE2uImQ/Ofl
        G5oa2UBYGdv7XvtLIkzqoLBpJA==
X-Google-Smtp-Source: ABdhPJyEcDd7yiOxUxD1pLbTrCZvB+TDHAxJTgsLzlGu6YxDq6qnzCZCrM8xJAD9ArHOrLI/HJAyUw==
X-Received: by 2002:adf:f28b:: with SMTP id k11mr304880wro.418.1611856978969;
        Thu, 28 Jan 2021 10:02:58 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id u6sm8280794wro.75.2021.01.28.10.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 10:02:58 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Andre Hedrick <andre@linux-ide.org>, linux-ide@vger.kernel.org
Subject: [PATCH 13/20] ata: pata_hpt37x: Fix some function misnaming and missing param issues
Date:   Thu, 28 Jan 2021 18:02:32 +0000
Message-Id: <20210128180239.548512-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210128180239.548512-1-lee.jones@linaro.org>
References: <20210128180239.548512-1-lee.jones@linaro.org>
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

