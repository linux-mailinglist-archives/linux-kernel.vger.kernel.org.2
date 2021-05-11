Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6648937A09A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 09:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbhEKHTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 03:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbhEKHTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 03:19:45 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9080FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 00:18:38 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id n2so28231312ejy.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 00:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MlVahHcRzJl/OmCKvY8N8NXLgxaRCwf7xRO5a1v6DG4=;
        b=BtT9If2o8biK/TQo2D8iH5bLbUNr2OSpCmPrMkG7+9NX0wPnU577xaNxF6GxpWPkOT
         WcKmoisQKH7iGLvW+j2yD81ooRu/VTCEhGr/WKvQjpREbjgAQvalT9/lo1e6DxHwruW9
         JwUH9rcmjoEv4hANcCcOj/Pi2fEJjHICQISZ0bOX7RJO2Ydnp+zhGoHwjNGhZUdLfX7u
         G6EHOORr98nJSTWOj2OT+TjSgqD3kLDlfGpDmEf9QKjk02vacPFrNKsL2nguL2ZvSThb
         SJeKYo34GoQcDorGwmJvL1CUz2mMoBdtITAoUEud3dPiF1rnhXqDNIag/X5TuDeKKRWN
         7YfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MlVahHcRzJl/OmCKvY8N8NXLgxaRCwf7xRO5a1v6DG4=;
        b=Rd/pp6R41WnXHef43rfA8eaqYOfzpKFlLsVO+0q+HGlPyfJSzVs0U+eczat10WeHZ7
         aKlWdaFaJNepA3hN9lmDFyZeGuUYeUj1Ek+gzKmrAfmMNdqEXgxLLyqKjk/DWYkSgZwc
         SsthCap/lk3cdAgIbQU2EpWgVrAcny3wA19Q7zC3xDbXRkuz1RxLL6D2tQdkxeR1trCE
         3eo9wo+wG5nvE12syB9ygkOpRqT0hF17xI9WopzKrVROFHihB8rkez4V5M8prX/GcCY9
         ykvoHfSCwDTvs0LDVnCpahaQp4MSoyQ3l3YGgzMmpdMkUOnuf0z6tOYiVGvMlyjPN7vW
         bUgw==
X-Gm-Message-State: AOAM530rTnIu0FI+e0W9ZbSnsTS437427V3lnvsZLkWbg+KZe12jZw3k
        QV6uKNjGsUvvz+S9GTXqWG8VXw==
X-Google-Smtp-Source: ABdhPJzZng0DRdVx9nvvyxFhc+bf78j3QPK4vbwrrKHyqn36fRx84GO3udQzPeta72P+WJJt7+gWaQ==
X-Received: by 2002:a17:906:2da1:: with SMTP id g1mr30189831eji.47.1620717517277;
        Tue, 11 May 2021 00:18:37 -0700 (PDT)
Received: from neptune.. ([188.27.131.122])
        by smtp.gmail.com with ESMTPSA id i6sm13871558eds.83.2021.05.11.00.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 00:18:37 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Jonathan.Cameron@huawei.com,
        alexandru.tachici@analog.com, linux@deviqon.com,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH v2 02/12] iio: adc: ad7124: Fix potential overflow due to non sequential channel numbers
Date:   Tue, 11 May 2021 10:18:21 +0300
Message-Id: <20210511071831.576145-3-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210511071831.576145-1-aardelean@deviqon.com>
References: <20210511071831.576145-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Channel numbering must start at 0 and then not have any holes, or
it is possible to overflow the available storage.  Note this bug was
introduced as part of a fix to ensure we didn't rely on the ordering
of child nodes.  So we need to support arbitrary ordering but they all
need to be there somewhere.

Note I hit this when using qemu to test the rest of this series.
Arguably this isn't the best fix, but it is probably the most minimal
option for backporting etc.

Fixes: d7857e4ee1ba6 ("iio: adc: ad7124: Fix DT channel configuration")
Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/adc/ad7124.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 437116a07cf1..a27db78ea13e 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -771,6 +771,13 @@ static int ad7124_of_parse_channel_config(struct iio_dev *indio_dev,
 		if (ret)
 			goto err;
 
+		if (channel >= indio_dev->num_channels) {
+			dev_err(indio_dev->dev.parent,
+				"Channel index >= number of channels\n");
+			ret = -EINVAL;
+			goto err;
+		}
+
 		ret = of_property_read_u32_array(child, "diff-channels",
 						 ain, 2);
 		if (ret)
-- 
2.31.1

