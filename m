Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2981137A09C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 09:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbhEKHTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 03:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbhEKHTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 03:19:45 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B07C061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 00:18:39 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id j10so1178503ejb.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 00:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nkXARO+FVrewyUKtJO4CN2s0umqdJR4fAYNaOAsTCV0=;
        b=sw7IA3puMIZUCEHNi/9LZInTcptD0kkIuSCOJNgIf1DHv0/VOBUca/sjpXjo/3rR3u
         YuCI8JAkzMPgGtTejq3tEfvbPbTp+oxrvOfWmhH+weCE/vX51SL74NCf4972gplf4aOU
         VTwIN6FQHFxix43Z17ovCx8rdeiP9jSCnGXh2MkLnMJe2FxssXOwBmhUOyQ3L9ANuKQl
         Gvu2Iz7kKunrNZroipn1VYNjxtyEeGvJHUDiIsvPU1yva3dCY4Ai3oHuGe9qJmnWLTvb
         yReCqJAW2u6GUN4U4IZNDJOgB3Ka8BccjxvuQXqrKN3pdtugPazj3BPEDt8BASGoG6S9
         gltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nkXARO+FVrewyUKtJO4CN2s0umqdJR4fAYNaOAsTCV0=;
        b=ZMO3WFoF6NIFKnHfj1pEzE7G0fkgIj1FJ8hgN6dw2bv4vN12JgD59RBIlhsfNOZvQT
         bUudDncxVeKypIx6+o8A2Eqv6fRvhS+zw8t4WbefZ2YGKD7DJoCmw2b/UizdzVR4MOLq
         9q/VYzmBkz/8IsyuogY/aGiO1OSgT3GrE1qg9jpN5yNgJFBHMy14rNlJb11BrxNkNpbD
         pzUA8BFjVgy8iaiiGnHkRtsZTvqYtzyTybQPkJL6UQO7d24QMMrwf6Dk0AHKQ+IacUOr
         4gH13kvf0Bl248r1CBq+uerFOqXph6iddevrDtoytsveM6A/EUlBoahCsUiTySJkSuQs
         FHHQ==
X-Gm-Message-State: AOAM533Jfy80PV0lX0CudW2Cds6ZUrZzDa8JdS2oK1nknEmtnlTWUZGs
        7Eo4YoHHuhc5Np3NoAih4Jd4Lg==
X-Google-Smtp-Source: ABdhPJzepc5AHcq7Rr6OJegiCXqwNOmhwBiIycp3MzqQZ6A3yUR4YpZ1jvKxntP5YyR/I5VH/UDd8g==
X-Received: by 2002:a17:906:e118:: with SMTP id gj24mr30587048ejb.205.1620717518423;
        Tue, 11 May 2021 00:18:38 -0700 (PDT)
Received: from neptune.. ([188.27.131.122])
        by smtp.gmail.com with ESMTPSA id i6sm13871558eds.83.2021.05.11.00.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 00:18:38 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Jonathan.Cameron@huawei.com,
        alexandru.tachici@analog.com, linux@deviqon.com,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH v2 03/12] iio: adc: ad7192: Avoid disabling a clock that was never enabled.
Date:   Tue, 11 May 2021 10:18:22 +0300
Message-Id: <20210511071831.576145-4-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210511071831.576145-1-aardelean@deviqon.com>
References: <20210511071831.576145-1-aardelean@deviqon.com>
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

