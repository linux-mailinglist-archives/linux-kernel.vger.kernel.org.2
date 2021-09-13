Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 230A84099D8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 18:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239870AbhIMQru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 12:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239542AbhIMQrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 12:47:32 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD81C061762
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 09:46:16 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id t20so6761847pju.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 09:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WyFI22XceY8sGAgVwRnjjZbEi+n4Q35oKOBHLHyUQYI=;
        b=T048dSMyPD3UXEfoKYL1hQcBcS9At3mPGkvSyVewCDauTy5g91EhR2AyKcB2/5dNJ0
         FYjQegIUuc6HeUsZkqDl+Vd64vmbdkDGmJuFE6AAFPm1G+oR3FkDve9yZ5jIsLII8LQ1
         kw2USumd0jKeMNIGlyxmz0LaKHlL7e7uX2gXOEngDwD22LxOQP6wIRnjZvVquhfGBEeu
         M53B9B7/t16KzpD8h2J95OWKz8NMb9bgDCTi23aydm7rxCpCLhB3tyUm64l/KdICxFmU
         H1fpw5jdRlS6fMlpu/4eDjJU8BNzSW/qwQM01UHl8xGnnzrbY3AWKnQe1yLQIYYCM3DT
         Safg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WyFI22XceY8sGAgVwRnjjZbEi+n4Q35oKOBHLHyUQYI=;
        b=IWgv5DlGntmem8dikf8Xift1OnXqtlI8RjwBC7BI5xH4HMckWs7z17xgQwSHKVRw9U
         fzoYyhfGvC8hThD5Jfhs2pHiN17+ZsctWKr4x4lWOiL/aLMCLpE4QaRFUC1pyRcXyYRO
         oFoMFKuxxjIr2sQhvyOoIqiEcFoBSMsFKObLcQeGrB8flZs8cTxIZXuzF6mCaJrTiwL5
         PCZxa+rC/P2syiO8UdwWzL4l6QKICelvzNUK6AU/6zd+a+A+I7eMRe0sbicAT3DCiUJM
         uAut+pVf/eLcJH+MM6FWP85mW0A84BWnGmCbZApONUIDcP4lCbIzcxP+JHzOeTXjcx8r
         COZQ==
X-Gm-Message-State: AOAM531sWT765fsp4pIxf3n6GvZ3w3K5QkT1PdUFPdL43XL0NqrvYDBt
        c9/zbNZCCU+194hBu15qrTt0RQ==
X-Google-Smtp-Source: ABdhPJzUklGwe8EI/hASvCXBM94ZWyNGh574K4yTLUwm5RSfbMYYF8DB3XbqcXwySka3vhLR/vW2mQ==
X-Received: by 2002:a17:903:1c9:b0:13b:f43a:41b8 with SMTP id e9-20020a17090301c900b0013bf43a41b8mr1545685plh.69.1631551576266;
        Mon, 13 Sep 2021 09:46:16 -0700 (PDT)
Received: from p14s.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id g3sm7615572pfi.197.2021.09.13.09.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 09:46:15 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     jiancai@google.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] coresight: syscfg: Fix compiler warning
Date:   Mon, 13 Sep 2021 10:46:13 -0600
Message-Id: <20210913164613.1675791-2-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210913164613.1675791-1-mathieu.poirier@linaro.org>
References: <20210913164613.1675791-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian Cai <jiancai@google.com>

This fixes warnings with -Wimplicit-function-declaration, e.g.

drivers/hwtracing/coresight/coresight-syscfg.c:455:15: error:
implicit declaration of function 'kzalloc' [-Werror,
-Wimplicit-function-declaration]
        csdev_item = kzalloc(sizeof(struct cscfg_registered_csdev),
                             GFP_KERNEL);

Fixes: 85e2414c518a ("coresight: syscfg: Initial coresight system configuration")
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Jian Cai <jiancai@google.com>
Link: https://lore.kernel.org/r/20210830172820.2840433-1-jiancai@google.com
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-syscfg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwtracing/coresight/coresight-syscfg.c b/drivers/hwtracing/coresight/coresight-syscfg.c
index fc0760f55c53..43054568430f 100644
--- a/drivers/hwtracing/coresight/coresight-syscfg.c
+++ b/drivers/hwtracing/coresight/coresight-syscfg.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/platform_device.h>
+#include <linux/slab.h>
 
 #include "coresight-config.h"
 #include "coresight-etm-perf.h"
-- 
2.25.1

