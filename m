Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9077F30AA21
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 15:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbhBAOoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 09:44:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbhBAOmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 09:42:13 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C47C061226
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 06:40:02 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id m13so16834373wro.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 06:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c13mHJ9q4khjz3HwzXj0RVixkGCKPHZCZNKDXnyAPKA=;
        b=WH4TudRdMpbtfWTgz3kZxyfD4xxbcAxrnxExnwv52RKJdsQciElU5atM3mvLIWKCo4
         akyCXc3l1pwmQHiKrQ1TdBh5FirhGwBrhP/08yHl5/WYFOd3wQrynGBQ4WeiFchqLKEY
         6SjClh99xFLDo7kGMUePuwCZx7K5wTVc/gs6LkO3Vays5jjTblnbgTSlsOiV0UNQHtWE
         z8mpj0GpZ/3CkH2EA9oQNpMxR/SSTV6h9aDEAN4sqXNaIOBfdaCNeZbHR9UKsidX+Mkz
         /lMM3WCQG2VuEqh9R61Ikh4k0eLqx0vatbWNy8P/xz4XQjGmQiCk57gTguUZQMGYskzJ
         K0lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c13mHJ9q4khjz3HwzXj0RVixkGCKPHZCZNKDXnyAPKA=;
        b=brr2DjvhoohlYK7QSHudY63pWNvHtBniKd4VGJkxgdfz5ioaAyjCp/ohg0OWXJRhDF
         RPXkpSNRKIcNKE6H8kQyrRP44jvvTIXugjVxITv26CMKsKV3egpk4QKnZ3t9qy1pfdsF
         UMKBpwT/5YBqekpDtRynAmsqd94VTDr6uaCinTs6pevuce2yDsx9CmhUefRfFqsOK/Y/
         ZM5MFcu35uMGf0GmRlvCcNjjrCmyIxNvuBw/kOOD2OGb5uWnPQ6yg4vC+RiQyVQDasMN
         xr+/2x837mWbQukZNBLiPO4laUMhmGSnkfvJUHlc39LEmW75yG0GWjMccvkMr6WXl7Pu
         6keg==
X-Gm-Message-State: AOAM531rI3r9nxqPFX/YJfPe9Jqw44W4EAdKiAZn8GtUZKfLs4D7PyHt
        JP3DQ3AhHVJPpfKplTAUUEkrhw==
X-Google-Smtp-Source: ABdhPJxmGE3JK7wr0XyMbiF60DgeRRAUKAjBPS36IT8pEnVa6IVYU7eGywYdD12qP9vrfvp1AAtmqw==
X-Received: by 2002:a05:6000:234:: with SMTP id l20mr18427477wrz.212.1612190401316;
        Mon, 01 Feb 2021 06:40:01 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id h15sm27301359wrt.10.2021.02.01.06.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 06:40:00 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Andre Hedrick <andre@linux-ide.org>, linux-ide@vger.kernel.org
Subject: [PATCH 16/20] ata: pata_hpt3x2n: Fix possible doc-rotted function name
Date:   Mon,  1 Feb 2021 14:39:36 +0000
Message-Id: <20210201143940.2070919-17-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201143940.2070919-1-lee.jones@linaro.org>
References: <20210201143940.2070919-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ata/pata_hpt3x2n.c:247: warning: expecting prototype for hpt3x2n_bmdma_end(). Prototype was for hpt3x2n_bmdma_stop() instead

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Andre Hedrick <andre@linux-ide.org>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/pata_hpt3x2n.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_hpt3x2n.c b/drivers/ata/pata_hpt3x2n.c
index 9cb2d50db8768..48eef338e0507 100644
--- a/drivers/ata/pata_hpt3x2n.c
+++ b/drivers/ata/pata_hpt3x2n.c
@@ -237,7 +237,7 @@ static void hpt3x2n_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 }
 
 /**
- *	hpt3x2n_bmdma_end		-	DMA engine stop
+ *	hpt3x2n_bmdma_stop		-	DMA engine stop
  *	@qc: ATA command
  *
  *	Clean up after the HPT3x2n and later DMA engine
-- 
2.25.1

