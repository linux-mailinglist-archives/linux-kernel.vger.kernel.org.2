Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C961937F788
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 14:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbhEMMKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 08:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233685AbhEMMJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 08:09:14 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12760C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 05:08:03 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id g14so30722387edy.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 05:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nkXARO+FVrewyUKtJO4CN2s0umqdJR4fAYNaOAsTCV0=;
        b=P+SgjrmYBqQ0rZ0mFyDg1f5A/hC9oEwgxN7MfLMZ+oL42m2KNxPOEqVmqgKSFvJkzb
         lUus8kWAEbJ21EjfXNp9d4ZZlz5BHaSm8C2LruPbbj63Hx+UkamvZGpfPyfyLmZbDoxb
         yN/k5DhCepeM4vEIJpwK674t6L1PvAd9f7qyXJEdaZbigJ9TrrSEhF34j+nB1G8vG8w1
         j/ZxkVa81qFZk2F21/G0pH31Uh6wAx2eBwz743DkZ/Sju/sf7vDdpH94msnZ3Sflic+5
         ScfK87fQuydxmeFk3+1N5whe04veqv8XybEiU+nQviKgocqdMvkSo8/mbEyTGQvFaGts
         MVHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nkXARO+FVrewyUKtJO4CN2s0umqdJR4fAYNaOAsTCV0=;
        b=qM7uzy8HmlKY0gy/mqsqPnK0g7CWnX+szdxtQNUZS4jaBKYI7nbpYHEUrBsu2vgmST
         EHvrzDIQ3/F2qZ00I1a/C70UN9faXKg9r2YYlsiD4gUIDX0LBawcY13PVPVO3sL0NSui
         RdjCrzFgC2skRvCZLYDdemsaJCb69lY/2W7p33kF4P87mY+uUuPdF+jpo6CUxg/E4kJE
         xQh6Y/i82eTuezmjoR7nPV8M0x6pb8pISlUv8coUFUs3Acf8KTLtdBH7UB88AePnl142
         w5yJaUZKXy+TTewXesvOmqsA3Y3S/mWQJoHxBIIS6EbhsdvbsFbo9gGv5KTeBB3mrcCP
         D7Rg==
X-Gm-Message-State: AOAM531ayYn/Ms5/KFL7e46j+yLgDC8v3V+DUr5gvErldwJKR1id0xCB
        //fNKD/rfV5/8z3PMpl0FQNXwYRSl14Myg==
X-Google-Smtp-Source: ABdhPJyIkT/ogJbSRjObXn+3wUE92nhhoORSTrArsHGYJUkPNOdItWFMkhsKNkU+Ba5KXYwxAIGvNQ==
X-Received: by 2002:aa7:d5c9:: with SMTP id d9mr50355348eds.153.1620907681870;
        Thu, 13 May 2021 05:08:01 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id ga28sm1717809ejc.20.2021.05.13.05.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 05:08:01 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Jonathan.Cameron@huawei.com,
        alexandru.tachici@analog.com, linux@deviqon.com,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH v4 03/12] iio: adc: ad7192: Avoid disabling a clock that was never enabled.
Date:   Thu, 13 May 2021 15:07:43 +0300
Message-Id: <20210513120752.90074-4-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210513120752.90074-1-aardelean@deviqon.com>
References: <20210513120752.90074-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Found by inspection.

If the internal clock source is being used, the driver doesn't
call clk_prepare_enable() and as such we should not call
clk_disable_unprepare()

Use the same condition to protect the disable path as is used
on the enable one.  Note this will all get simplified when
the driver moves over to a full devm_ flow, but that would make
backporting the fix harder.

Fix obviously predates move out of staging, but backporting will
become more complex (and is unlikely to happen), hence that patch
is given in the fixes tag.

Fixes: b581f748cce0 ("staging: iio: adc: ad7192: move out of staging")
Cc: Alexandru Tachici <alexandru.tachici@analog.com>
Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/adc/ad7192.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 2ed580521d81..d3be67aa0522 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -1014,7 +1014,9 @@ static int ad7192_probe(struct spi_device *spi)
 	return 0;
 
 error_disable_clk:
-	clk_disable_unprepare(st->mclk);
+	if (st->clock_sel == AD7192_CLK_EXT_MCLK1_2 ||
+	    st->clock_sel == AD7192_CLK_EXT_MCLK2)
+		clk_disable_unprepare(st->mclk);
 error_remove_trigger:
 	ad_sd_cleanup_buffer_and_trigger(indio_dev);
 error_disable_dvdd:
@@ -1031,7 +1033,9 @@ static int ad7192_remove(struct spi_device *spi)
 	struct ad7192_state *st = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
-	clk_disable_unprepare(st->mclk);
+	if (st->clock_sel == AD7192_CLK_EXT_MCLK1_2 ||
+	    st->clock_sel == AD7192_CLK_EXT_MCLK2)
+		clk_disable_unprepare(st->mclk);
 	ad_sd_cleanup_buffer_and_trigger(indio_dev);
 
 	regulator_disable(st->dvdd);
-- 
2.31.1

