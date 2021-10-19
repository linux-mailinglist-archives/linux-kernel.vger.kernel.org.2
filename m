Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A86D94336D0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 15:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235838AbhJSNT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 09:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235828AbhJSNTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 09:19:54 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7589CC061765
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 06:17:41 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id a25so12733272edx.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 06:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fVwmCQe1Imk01zVn1XGf4Bgbl7TXtX3AHgpVKUdqV64=;
        b=ST3pve/0QlrMuEbgKABJjXfLo42Qd+a53fnDzzVj9AE/zpYv88IEh4W3G8YvTWuPt/
         3XSHXX/cJ+JxhCNsWHRxUF5BIUhjNJ+TH+LC1Bvx/ibreBorIJfps+YwXCmkCRnicSjv
         yC5q1h6iihDGhhV6lFELl1TMNcu4UpUqhcrIqx7hytZ2Rk7rq8uI5tT1PXGqBNj6xYPk
         iNhLImzJ5XKfhW0qEgy4aFXSQLL8DEtrVxRqMfpi4BLzj1KprDkhBmFHCI3sRvVkSbb+
         lNHCHP5ZKcpe1MI5kpwFWO/6fVybZl9G4g3lRDswu0iikoM2M7yPVtouvHwXnS0KHchG
         1oKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fVwmCQe1Imk01zVn1XGf4Bgbl7TXtX3AHgpVKUdqV64=;
        b=LiXr8E/xDlTdzt6x6BzYE3jMDLm++8OgQY/3H7S/qJv/T97STuCZOklnBB3oIzoodM
         QUHgbm8MejR1iuVLnIMcE19YnkiZD9Z6YeQ++L4JQje+yjwt+dcyInMS76whKvkl5uDH
         B/IQv+i8YtBiXtgdUQuzQLtwTiUG3TYNePoSJhzxsN6oWNRiQg3qG7VmDq8CHtz3c+xd
         h3MUYmFXgUABXvoSRHtAuXvui1waoOGE9y/3+VzR2ZgvwT1aUUEpWNzHwWSKtM+heBCN
         QQuydqxS9LL8qIT9pY6owxMAhZxha4Lk3sjdeDwCezuAsDoRaNehVfW9M8WboD2Xyzhu
         rluQ==
X-Gm-Message-State: AOAM530d/9a70cicMnVud7PNlIxgJMJu3ewRHzd93OoThAvksKMY40Mr
        Ze0uryg0/r3tVYBMKq4YTfMbEA==
X-Google-Smtp-Source: ABdhPJxHpjVbKzi+3gjGSMjnf9tMaqp16jK7/fWlsQgqmLcR5Yz8Wq3iH0ERFpFpw5GAOvuk5ox58Q==
X-Received: by 2002:a17:907:d1e:: with SMTP id gn30mr37726126ejc.272.1634649450063;
        Tue, 19 Oct 2021 06:17:30 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id e22sm12192568edu.35.2021.10.19.06.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 06:17:29 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-rtc@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] rtc: s3c: Add time range
Date:   Tue, 19 Oct 2021 16:17:22 +0300
Message-Id: <20211019131724.3109-3-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211019131724.3109-1-semen.protsenko@linaro.org>
References: <20211019131724.3109-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This RTC driver only accepts dates from 2000 to 2099 year. It starts
counting from 2000 to avoid Y2K problem, and S3C RTC only supports 100
years range. Provide this info to RTC framework.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/rtc/rtc-s3c.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
index 10e591794276..d9994efd70ef 100644
--- a/drivers/rtc/rtc-s3c.c
+++ b/drivers/rtc/rtc-s3c.c
@@ -454,6 +454,8 @@ static int s3c_rtc_probe(struct platform_device *pdev)
 	}
 
 	info->rtc->ops = &s3c_rtcops;
+	info->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
+	info->rtc->range_max = RTC_TIMESTAMP_END_2099;
 
 	ret = devm_rtc_register_device(info->rtc);
 	if (ret)
-- 
2.30.2

