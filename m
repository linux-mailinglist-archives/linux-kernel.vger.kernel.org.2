Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A26C30AA16
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 15:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhBAOmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 09:42:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbhBAOlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 09:41:09 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2B2C061794
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 06:39:50 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id q7so16801578wre.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 06:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MvoGC7duOzp4QbVV73i8hwf4OtQFHAIOE3fctv618Vg=;
        b=xVIql7+8TZzLoGu0iro7M7rirVPW9tOh49bUKNDnqpyfpS3Whpmo74e7k4lVX93ghK
         QVGYeqDOTJbMgRuJisjN6jlFYsAmrD+1P3mj9jsLVvBnWVm93kEo66OucYsaQBVYoZYr
         WM8V68r8BOc6HohzdC0WhjVN9tseqS2ku2aX7l+ITaO++9MncJahBMgIDGPEt2RxBtgS
         CXTLa4/2IRIAwYScQVkcvkn7w4U3ydCD0dC+OX0X9QNUjRy3cR/9kPWc4jgx/qNGvH+r
         /ADOr10H5E40G+f43FuGXghvCW2ZAX+RXgxPJkCGSOjZhjjynyC4OFLmSxqdBnpPZNr3
         XkeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MvoGC7duOzp4QbVV73i8hwf4OtQFHAIOE3fctv618Vg=;
        b=h9eP2qs6ld412j8zBSBOtbWCCOFQxGKURMQY/vOwmCyh9qL5kVg9G8EtiodjK4CutE
         rxGWQbW89osapIY0nmXyaRK3pxyswXUzh5YiwOY0xSvKXGh+qZwL0AhpiMzt62g0wJoM
         Kn4NAvfVgGvCWBnCdHr0p69LBAo0bcfi9M/lXl/R5Ap8jfkzH2Bu3v+SN4cCs8bnTHFT
         wCwPlOR77FyJRRr87/TuYnPgkqJV00C3jpILIRH20KYGkIDmnBxEa2MOepMKRTAzM7cR
         JJbW5G+G74trrIQ8ZwAil1Fh0LkAqnwqfHAoytqCpe/0BX9EsMPHQRvLkGS6e83shkGY
         6K+g==
X-Gm-Message-State: AOAM530WAwXWWdQ577tjQBy7fJdYjMhNPiGDMlqXhVIw8XkRwCQydZJL
        bFiexUTC5uJMv70aiGYWYJ89pQ==
X-Google-Smtp-Source: ABdhPJwqgKID1G0doaFBi2aHMNjBaJI2XDkLWh9DLrsoMChHmb+g5MausIaS5inHIRB+Z2DvD+UAaQ==
X-Received: by 2002:adf:e3c2:: with SMTP id k2mr18373016wrm.337.1612190389474;
        Mon, 01 Feb 2021 06:39:49 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id h15sm27301359wrt.10.2021.02.01.06.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 06:39:48 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Andre Hedrick <andre@linux-ide.org>,
        Thibaut VARENE <varenet@parisc-linux.org>,
        Alessandro Zummo <alessandro.zummo@towertech.it>,
        linux-ide@vger.kernel.org
Subject: [PATCH 05/20] ata: pata_artop: Fix a function name and parameter description
Date:   Mon,  1 Feb 2021 14:39:25 +0000
Message-Id: <20210201143940.2070919-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201143940.2070919-1-lee.jones@linaro.org>
References: <20210201143940.2070919-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ata/pata_artop.c:278: warning: expecting prototype for artop_6210_qc_defer(). Prototype was for artop6210_qc_defer() instead
 drivers/ata/pata_artop.c:359: warning: Function parameter or member 'id' not described in 'artop_init_one'
 drivers/ata/pata_artop.c:359: warning: Excess function parameter 'ent' description in 'artop_init_one'

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Andre Hedrick <andre@linux-ide.org>
Cc: Thibaut VARENE <varenet@parisc-linux.org>
Cc: Alessandro Zummo <alessandro.zummo@towertech.it>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/pata_artop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_artop.c b/drivers/ata/pata_artop.c
index 6bd2228bb6ffa..02e4fd5e3b934 100644
--- a/drivers/ata/pata_artop.c
+++ b/drivers/ata/pata_artop.c
@@ -344,7 +344,7 @@ static void atp8xx_fixup(struct pci_dev *pdev)
 /**
  *	artop_init_one - Register ARTOP ATA PCI device with kernel services
  *	@pdev: PCI device to register
- *	@ent: Entry in artop_pci_tbl matching with @pdev
+ *	@id: PCI device ID
  *
  *	Called from kernel PCI layer.
  *
-- 
2.25.1

