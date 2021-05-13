Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF19737F789
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 14:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233735AbhEMMK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 08:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233683AbhEMMJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 08:09:13 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BD2C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 05:08:01 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id df21so3467856edb.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 05:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MlVahHcRzJl/OmCKvY8N8NXLgxaRCwf7xRO5a1v6DG4=;
        b=j/pXCq7yyKY2f3i6cvIOBs189d76MN7wr/olH2qy9H1hTBYAcVTHQcKa/pAa+1yG2W
         CX9v59oLtDFskHC8wxRmy1SvnGLLcMA+Sw8etHN0ynspW5m/I3p8vYC0a9YYcc8eM8Tz
         zpFeZ/O/btnvhlQCqlw/vRa18JWZi8QYUCTkrjHXBdqNnFBEpPyHU1+MUBxyepj2rGnU
         fnlNflUysjK70JdP0wIH1MWyW5xmyGMShICoo8YPQs49x3erVZ7KOb/bZDTJDS1maw9g
         AliHKRjfuieLfpAUTRG+nHYl6YqwKrZ9y5PDTmtcgx4Uf6VVLSq58lRKKOCpuTwvoxzW
         OZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MlVahHcRzJl/OmCKvY8N8NXLgxaRCwf7xRO5a1v6DG4=;
        b=VjePa8+J/HvAvjLFQxf4iMfQBdKy6qS+PubWO5kTPN+saQ2sdEP8MHnnolBz8pSQcH
         7sPaa7nXbnmq8rsfsaASXPiZM4DdjQyxjJzzuIVxcquP6elBQ71OIIsiDLqaMwygCWJ5
         dYJ1SSPciBNET/D412ImVJq7eJ84LHdla7yR+krirBLD8cK0lickyMvVPebgtqidLEpA
         FVzvtFMS0HeITNzFHQABstwNXWTiqs/qogs3QZo6LC51/E3KPRTiOpk4cT7OOSAFx5RW
         DNHZFPof1c4CeOv4NX8kwbQK+4/QcesLSAvmHyziqMmlM8fJ0ncP9Xih3cwUhXSx5Z1y
         rvJQ==
X-Gm-Message-State: AOAM533vuZtzuEWtrm7gWe2UhVaO5bHDik2b9Awze+YwnGG6bK+kl9+J
        IRVDnWpE8d86PmXLiU4ko3bYXg==
X-Google-Smtp-Source: ABdhPJwNq7I8jELq7dfbQ11I6wg8a3GyeI0wPZA/knJ9SF0Qv+Uhj7wnbgGccesdRxFEKOqjXow5bw==
X-Received: by 2002:aa7:d6c6:: with SMTP id x6mr49115549edr.193.1620907680776;
        Thu, 13 May 2021 05:08:00 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id ga28sm1717809ejc.20.2021.05.13.05.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 05:08:00 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Jonathan.Cameron@huawei.com,
        alexandru.tachici@analog.com, linux@deviqon.com,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH v4 02/12] iio: adc: ad7124: Fix potential overflow due to non sequential channel numbers
Date:   Thu, 13 May 2021 15:07:42 +0300
Message-Id: <20210513120752.90074-3-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210513120752.90074-1-aardelean@deviqon.com>
References: <20210513120752.90074-1-aardelean@deviqon.com>
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

