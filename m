Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 100B5440EE0
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Oct 2021 15:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbhJaOpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 10:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhJaOpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 10:45:09 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299ABC061570
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 07:42:38 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id p20so8729414pfo.12
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 07:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uwHc5y/wIScBvEn6bCWIFA7yggj/JltDtCr4bDo6Y0g=;
        b=kj7gPQXHAooXNx1kSa8Aa7p+r94I7QxhXdyu33lPC/Ro8QQl2PAjMBw6EJFwSc9ZDJ
         UROzJT9KG0j5IY6GZcyWSXaN5LVytPfmgdlnsStHdnz8bbqTy/IsSHvidD2dc8b+2xE/
         FvFLdXF8oXCx+AadCWeMM1dx9Atzch4CDKiaYFjW9PZ8pYv22SeRsyT6FFxfliCuQpqV
         SYDEC0q7KfwCezat2WunuF3CBnUaz6Pgk/apx6yEZ1vfv/c9Qr4q4tP2AMCdlMqIze4i
         w6AMvLZmAqyJeti7Z6ni9BW/3uvhq1JazTmgg/xT796xY6r7aFK0nDb+rVKrx8whAIBB
         QMnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uwHc5y/wIScBvEn6bCWIFA7yggj/JltDtCr4bDo6Y0g=;
        b=w2vwUl0Z4/X7/G8URQJ0FjEOW2UIXU4mCmgd/RTZe+9FnDa6VWizticRsX7jrGVNVL
         Y6OLetXjzL3RPiZvR3lA3oCLcdhjWhgr2jBSgZy0SQExAY3jAVjGPN+3ZPn9JE2GcKg1
         rernrS14R3hBpjzwsjoqYUt3nyoXGmEWvvHM8yP/0dxpi8mkk+Z+za5K6TNayrtFh1AC
         rNj/FGMMkSbSE6F7/5so9c5QOaG3bwREasi80xqGG7ztMl6mu+QWMw8ws/uXTV4O/YfU
         M3L9IkGFNczTktBsr5UM7djWjb+m0HGLEJit7iNn/2qjw7xw3yS1ApfQHmVDXmKhQQ9y
         po4A==
X-Gm-Message-State: AOAM533Z5XpQW5tYx/1/HRSwcfR/sz+6pNkNc9w7MSqYVE7xaKhz6RSl
        Cy4dl03yTDsgKFd2PWmOtaGLpg==
X-Google-Smtp-Source: ABdhPJwNPl2Jf3gP+mXfhnUBrTAL3ug8leeRXwOWQD5KRvFzBPQaQOP2zw7n1DP9rckK8qKD3qFG6A==
X-Received: by 2002:a63:7506:: with SMTP id q6mr17315883pgc.349.1635691357679;
        Sun, 31 Oct 2021 07:42:37 -0700 (PDT)
Received: from localhost ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id e14sm9323996pga.76.2021.10.31.07.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Oct 2021 07:42:37 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 1/4] coresight: etm4x: Add lock for reading virtual context ID comparator
Date:   Sun, 31 Oct 2021 22:42:11 +0800
Message-Id: <20211031144214.237879-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211031144214.237879-1-leo.yan@linaro.org>
References: <20211031144214.237879-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When read the virtual context ID comparator value via sysfs node, the
driver firstly reads out the index, then reads the comparator value
based on index.

This patch adds the spinlock to protect the atomicity for up two steps.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm4x-sysfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index a0640fa5c55b..e4c8c44d04ef 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -2111,7 +2111,9 @@ static ssize_t vmid_val_show(struct device *dev,
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	struct etmv4_config *config = &drvdata->config;
 
+	spin_lock(&drvdata->spinlock);
 	val = (unsigned long)config->vmid_val[config->vmid_idx];
+	spin_unlock(&drvdata->spinlock);
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
-- 
2.25.1

