Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64B2E39329E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 17:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235338AbhE0PpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 11:45:14 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41359 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235163AbhE0PpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 11:45:07 -0400
Received: from mail-vs1-f70.google.com ([209.85.217.70])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lmIAX-0000cA-2n
        for linux-kernel@vger.kernel.org; Thu, 27 May 2021 15:43:33 +0000
Received: by mail-vs1-f70.google.com with SMTP id v15-20020a67c00f0000b029023607a23f3dso335421vsi.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 08:43:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZQVWtV7m0NLkPzzJ083vgY3XbeH21bsEYpj4swSqtgE=;
        b=MP+FZb6jr1C6kKKuyZGt4jo9QtR58nVlmXQ5ht3Iky+Re0K9eKAaRNHIsTZa7keYz5
         /xy6DXwmgQ7uPKUYRdy0H9i/yXRL35YmwGC5g0oUlQOGG9p/HqySVbL1rrBTE8VneSu4
         C/uGVxhNUWyxxno2yl3zFFtM/57kR6olFSF5BrEr5tItGUSCuvjD1R/rAeJmhM+B3hEx
         9Pf0sLyvSEWbS1TN0jRsrPBZM0iwvccCk0gJXOcv4GmKifs2m/q/VX3EqcZJUruYXFcw
         C5zeOJsGKNJYzse+6YH1N1i1xGoD+v+jyu8GdTKlfKmXn/KuyAQJGdLmJu045EUqr6ak
         IBtA==
X-Gm-Message-State: AOAM530HwG7aHRHTMxeuwKCDIgDjSgb59M7Qk7KMrRYRbz+Osqyn0oTT
        3YUyIjqnKEF8+8oyda8cXJyQRiOmDf2XKOpJQGmS2nI9+sdE5/Cn6goDVc62PjzIO9U0R3/hiNW
        dEvBzC9IqO78eBWD5ayjVh+NeR1gz1nQQn4mPW4Pjzg==
X-Received: by 2002:a1f:6dc6:: with SMTP id i189mr3061835vkc.19.1622130212144;
        Thu, 27 May 2021 08:43:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxqhubj6sAjCI4/OmdOi9osEhG9hLl4OeTQ6vESKVLwJUmPVXgMoiqWaugmhKr68ST2iflsBg==
X-Received: by 2002:a1f:6dc6:: with SMTP id i189mr3061813vkc.19.1622130211957;
        Thu, 27 May 2021 08:43:31 -0700 (PDT)
Received: from localhost.localdomain ([45.237.48.6])
        by smtp.gmail.com with ESMTPSA id m27sm339087vsj.4.2021.05.27.08.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 08:43:31 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Liu Shuo <b35362@freescale.com>,
        Prabhakar Kushwaha <prabhakar@freescale.com>,
        Li Yang <leoyang.li@nxp.com>,
        Dipen Dudhat <Dipen.Dudhat@freescale.com>,
        linux-kernel@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        kernel test robot <lkp@intel.com>
Subject: [RFT PATCH v2 1/2] memory: fsl_ifc: fix leaking IO mapping on probe failure
Date:   Thu, 27 May 2021 11:43:21 -0400
Message-Id: <20210527154322.81253-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On probe error the driver should unmap the IO memory.  Smatch reports:

  drivers/memory/fsl_ifc.c:298 fsl_ifc_ctrl_probe() warn: 'fsl_ifc_ctrl_dev->gregs' not released on lines: 298.

Fixes: a20cbdeffce2 ("powerpc/fsl: Add support for Integrated Flash Controller")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

Only build tested.

Changes since v1:
1. None
---
 drivers/memory/fsl_ifc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/memory/fsl_ifc.c b/drivers/memory/fsl_ifc.c
index 89f99b5b6450..a6324044a085 100644
--- a/drivers/memory/fsl_ifc.c
+++ b/drivers/memory/fsl_ifc.c
@@ -219,8 +219,7 @@ static int fsl_ifc_ctrl_probe(struct platform_device *dev)
 	fsl_ifc_ctrl_dev->gregs = of_iomap(dev->dev.of_node, 0);
 	if (!fsl_ifc_ctrl_dev->gregs) {
 		dev_err(&dev->dev, "failed to get memory region\n");
-		ret = -ENODEV;
-		goto err;
+		return -ENODEV;
 	}
 
 	if (of_property_read_bool(dev->dev.of_node, "little-endian")) {
@@ -295,6 +294,7 @@ static int fsl_ifc_ctrl_probe(struct platform_device *dev)
 	free_irq(fsl_ifc_ctrl_dev->irq, fsl_ifc_ctrl_dev);
 	irq_dispose_mapping(fsl_ifc_ctrl_dev->irq);
 err:
+	iounmap(fsl_ifc_ctrl_dev->gregs);
 	return ret;
 }
 
-- 
2.27.0

