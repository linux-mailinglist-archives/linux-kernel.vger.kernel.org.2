Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E525F37EBA3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 00:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381627AbhELTeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 15:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350518AbhELRvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 13:51:10 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D2EC06138C
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 10:49:58 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id l4so36250154ejc.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 10:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MlVahHcRzJl/OmCKvY8N8NXLgxaRCwf7xRO5a1v6DG4=;
        b=ARiwzjzixi6kh5+4cwI0MVWB0GweYEnmFJ2+cGNn+FZTzgODruNy6osicsuDPE3nE4
         4rjOlH2wXakFQgZyYyO7Yn1lgsTLMIKgLQYVsPfi4N2z2pydUd83fC78WrcA0NZPJRx5
         HW6NAS2hVe4/dlf0qSQsoscJZ3UQ5x2lxG7S+Y0N6Q/whgA7CALQn52psQ3AfPM8QSbE
         /zS6RNtTWyDdlhVzd5Aa/8nYX7/Ksr+VfUZcBDXkS3B+mGfqbhJIlpsie7wfGxSzAANA
         xhxVI4O19Oa/Scyk3vDeTMBFy2dL+cbUG174pRmWdYPnD7WSon1Cz0QeHCRcQx/e+hSl
         fZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MlVahHcRzJl/OmCKvY8N8NXLgxaRCwf7xRO5a1v6DG4=;
        b=H7YlnQA0PA6Es7j4Kl0dyqsTQbzxRWTQfS5EAbAyjM23Hmsb6RublYgn9hP20etT18
         lKRamQCKVpryL/zuFmtLHJ8aMm6bWzLIByhN5hI1RpGvHvRMdAocKAt3lxx73YqNwqSL
         +lzK60Caa1wjpAVdFmM9ZQ+GIFjgkS/z6aj6kvf4pQa5iULHC2GS7A3lE90jQ7+UUkiF
         UnVd/TgfrKoiXl6Dp/C4UlN9g+M22mW4MmlOg5sx/IwayZ3tNk2UHuen1wrZrmw/ut0C
         Y0TjEgobWTMx0OIHgevCTDxEnMd2XQA7p47ISFegnMFa6XJz7QMlCCPvBRCbTgP+5Yh7
         auOQ==
X-Gm-Message-State: AOAM530TUryi0tuiyL3A6v68lWNGMpk00Lg0gNa5lUfIHZSS/Sqs91pu
        eu+ubhkpWQbm7ypoHY45JqBkbQ==
X-Google-Smtp-Source: ABdhPJzo7tmImWNPOb4Lq7Z3+yra7hePoowXdeUssxDVr3PJD3+Y/BkCZA1BuGocp2anTSOX9BNOfg==
X-Received: by 2002:a17:907:3da4:: with SMTP id he36mr38201476ejc.308.1620841797674;
        Wed, 12 May 2021 10:49:57 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id r16sm338058edq.87.2021.05.12.10.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 10:49:57 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Jonathan.Cameron@huawei.com,
        alexandru.tachici@analog.com, linux@deviqon.com,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH v3 02/12] iio: adc: ad7124: Fix potential overflow due to non sequential channel numbers
Date:   Wed, 12 May 2021 20:49:04 +0300
Message-Id: <20210512174914.10549-3-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512174914.10549-1-aardelean@deviqon.com>
References: <20210512174914.10549-1-aardelean@deviqon.com>
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

