Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 428F9373C7A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 15:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbhEENhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 09:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233055AbhEENhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 09:37:52 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D6EC061574;
        Wed,  5 May 2021 06:36:54 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id d11so1873161wrw.8;
        Wed, 05 May 2021 06:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rNTXDn4ge2gh9B+JxTu2omSu9nx8xaipdR+RDydJzAc=;
        b=O0JIP/vYGAX/BAGR+1uhpSRtankJG4Ky7M+9tD9hI9vG5c5N+bgLL8+EtV4qsW2sGp
         OO+PqYWUuoD2LnSAdr+PPgqVZ7pnkJGmpkleCSC+JpZY8cBusN7cudiYjjiqwZKDjnfL
         JaabvCffQY9+awxQbhLmZlVtaMIIKdhc5tu2jZHhsYmQtOtp1lcy/zPlNVd7mEY2YJqU
         8zaP+sSTLB4du7sRvW4wij4KLC06mwhD7JNgW9Fm7GFla04nPbj7meCwUianm9FAPFFS
         Sx2qXcY8xLOqNivIUsP71MXUuf7y3T9IyTX3OSzejklW80XCrB8UKVjsZ+9hIIu9kGtk
         yL4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rNTXDn4ge2gh9B+JxTu2omSu9nx8xaipdR+RDydJzAc=;
        b=UoTsr06wDOszCEUtM0T7wRXpk0mQuxMEra9/Nj6mc957ExLRGpFS78wKS3WD+HlCAh
         rj3kuUUoE90mwBohSkhXXD7/jfQ3w1KHH1lCUq8K+mK2Y4pTPyE74Bf4zJODnqOxX98I
         V4ZLohnOPxAm8Etzf0dNKrUYUy4edzBxGipDxdVnDb2HyTqYMD8dnzl0P/nJYyKdSuXY
         v9gR/E/bxhzofuRi9NHSaFvCbxKTQT+0vZgz/LrJVX6VzK7xNrfq01WrK2jifiGjJ1oN
         dY3YVPpTgOgkOubmX/boXCx9gjT8BVF5EMPVlmKsvW7BK66srhjxFKr9IterwM/CF1Uf
         HwLw==
X-Gm-Message-State: AOAM530Bsci35T46yFwlIad5yUNnd+6f42k5WtK4yxIbYZG4PcQNdM6A
        Ba2coWvxzHYw9z+oB6e817g=
X-Google-Smtp-Source: ABdhPJzldufq5H8qDMGi7w5Wwl0mMi7Y8NpcGSmUc08PHKlXmP/C0I6AbrWz8WU8yXu7txxnBZeyUQ==
X-Received: by 2002:a5d:6352:: with SMTP id b18mr38614581wrw.76.1620221813515;
        Wed, 05 May 2021 06:36:53 -0700 (PDT)
Received: from xws.localdomain ([37.58.58.229])
        by smtp.gmail.com with ESMTPSA id w22sm6030584wmc.13.2021.05.05.06.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 06:36:53 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <mgross@linux.intel.com>,
        Tian Tao <tiantao6@hisilicon.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/surface: aggregator: Do not mark interrupt as shared
Date:   Wed,  5 May 2021 15:36:35 +0200
Message-Id: <20210505133635.1499703-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having both IRQF_NO_AUTOEN and IRQF_SHARED set causes
request_threaded_irq() to return with -EINVAL (see comment in flag
validation in that function). As the interrupt is currently not shared
between multiple devices, drop the IRQF_SHARED flag.

Fixes: 507cf5a2f1e2 ("platform/surface: aggregator: move to use request_irq by IRQF_NO_AUTOEN flag")
Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 drivers/platform/surface/aggregator/controller.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/platform/surface/aggregator/controller.c b/drivers/platform/surface/aggregator/controller.c
index 69e86cd599d3..8a70df60142c 100644
--- a/drivers/platform/surface/aggregator/controller.c
+++ b/drivers/platform/surface/aggregator/controller.c
@@ -2483,8 +2483,7 @@ int ssam_irq_setup(struct ssam_controller *ctrl)
 	 * interrupt, and let the SAM resume callback during the controller
 	 * resume process clear it.
 	 */
-	const int irqf = IRQF_SHARED | IRQF_ONESHOT |
-			 IRQF_TRIGGER_RISING | IRQF_NO_AUTOEN;
+	const int irqf = IRQF_ONESHOT | IRQF_TRIGGER_RISING | IRQF_NO_AUTOEN;
 
 	gpiod = gpiod_get(dev, "ssam_wakeup-int", GPIOD_ASIS);
 	if (IS_ERR(gpiod))
-- 
2.31.1

