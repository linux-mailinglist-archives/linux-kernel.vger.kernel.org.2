Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8987D32BE0A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237203AbhCCQ4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 11:56:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377150AbhCCMWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 07:22:32 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC5DC061794
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 04:20:56 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id e7so36798940lft.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 04:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=soyM9wPlLASUiUbmRQQtsdUjbF417QlwKml+91jIMqs=;
        b=H8fTVYBkdNNsM4NQ2zrh58J24JrxnUp/sbzJz+tslBM2fXthmdZg8PunTTxX5PeqZS
         wYB0hPGkc8fGLG2e26Y2ceHPXGShqZJ3egDGkhZUZ/fb72ew+VImxGywy/Jb7PiTCliF
         pW+kFtx3NpztdYl7ku0T3Q0A+CqiXg5nQJ0DIofQX1XrBw82M4XifHsHgHtqZVIF1tFh
         96lG5SdY/uKjKkP+p7vcTIpNCU00AWHHGaSNr/9RlrczOeG2/ftzIfZRBarbCI1KI2Vs
         Zu6roEFOCAYzwiYyRpMY58cJ+d5uzvVprYR7BFzeOsJTBJnANQkM+jZJEMgbix0QKwvx
         MyOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=soyM9wPlLASUiUbmRQQtsdUjbF417QlwKml+91jIMqs=;
        b=SxS4ldJ3z4C77A44CsQWIpZ7T3GDURt9ij9/wZSNCBUIsBQMkHSg7Duhby6kKihiHR
         AYYPERz3KfPjBLhvQEyRBFHF1JbpD+hZEs3S4TVZIXnOuz4Osidu3ViLcKN+8iGtUbDN
         NlX9VxT78uzeqeOv9m6WivCDZ38Nn2uRm+BTF7TFw+FmpIdRoJ/msGkpj911xpHRTa7h
         RNcSXeGaDdrlPPVY67/YkK4JNNrvvfK0K1u0SqmU5k5wvFgMSr49AaZBgxTRxVb4PoK7
         /7zo52aMQ26hs2lRbN45/YR8/NRTC4T2EOLXcQ+bAtjXNDIjajfPJjArwjx21vCQ3rd3
         jUNA==
X-Gm-Message-State: AOAM532Dmy1SA9vzKtrHm1fIo143OMD3skkLvwRxrnnY5tFM6cQrmPkm
        OTqi3lsxRMFKEdRtJNJl62g+vA==
X-Google-Smtp-Source: ABdhPJxhQ8IEPAejaPoXzG/IU+//OTOpt03Evjcamw7wzwgLwru5/CGFu9Rsa774rOsyYUKUJqMmIA==
X-Received: by 2002:ac2:5e21:: with SMTP id o1mr14773513lfg.435.1614774055042;
        Wed, 03 Mar 2021 04:20:55 -0800 (PST)
Received: from localhost.localdomain (h-155-4-129-234.NA.cust.bahnhof.se. [155.4.129.234])
        by smtp.gmail.com with ESMTPSA id d3sm811519lfq.249.2021.03.03.04.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 04:20:54 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] mmc: block: Drop use of unlikely() in mmc_blk_probe()
Date:   Wed,  3 Mar 2021 13:20:47 +0100
Message-Id: <20210303122049.151986-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210303122049.151986-1-ulf.hansson@linaro.org>
References: <20210303122049.151986-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mmc_blk_probe() isn't a hotpath, which makes it's questionable to use
unlikely(). Therefore let's simply drop it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 8e6a623b35de..dc6b2e8f4f95 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2888,7 +2888,7 @@ static int mmc_blk_probe(struct mmc_card *card)
 
 	card->complete_wq = alloc_workqueue("mmc_complete",
 					WQ_MEM_RECLAIM | WQ_HIGHPRI, 0);
-	if (unlikely(!card->complete_wq)) {
+	if (!card->complete_wq) {
 		pr_err("Failed to create mmc completion workqueue");
 		return -ENOMEM;
 	}
-- 
2.25.1

