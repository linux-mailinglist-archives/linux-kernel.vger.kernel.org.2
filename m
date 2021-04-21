Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3AA1366F61
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 17:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243970AbhDUPq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 11:46:29 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:33372 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240962AbhDUPqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 11:46:24 -0400
Received: by mail-ot1-f49.google.com with SMTP id 92-20020a9d02e50000b029028fcc3d2c9eso16844826otl.0;
        Wed, 21 Apr 2021 08:45:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6szp+K/skstRZ22g2HkIN/dwWJKe6yh8+ljhvoOIFsI=;
        b=Kt/WMVrbsHgoJEGqr9vwueru42daxd9Sv74uSUJRUDnc766pVmbxb2FK0r6YqVHGhy
         rBcK+YPWs8/GhW3E1c5FbG/KGSkII9hToxE2TBkmMEEsA5NitLGTJQkBp9EVnHOAQiD4
         +ldEDTRiA4W8+XNFlEN0WiS6Cni9g087vYu0Fufm0exkYbCpzImm/AK36tArFUNQWHYg
         mB2k90Yrh1+zN7TiJ25IZl15iN1rBrfxHn4BUJ8TgeoWbt/ZMyYnB6IR4Vxtuj+a10rG
         LuD6PmwfKJjiq4TL1K6+rYn3iCjV76TZH7ZwO5CUWq8bU1mc/H0z5cnVaXKF4q/TKXYD
         7P3Q==
X-Gm-Message-State: AOAM530oxA3yhQ3p76wSsL+hmj1T9R6wQNJQRArYVMIUWPg3EtSUogdB
        o4haF0/qIK2klaDvKWwoetEVSte88Q==
X-Google-Smtp-Source: ABdhPJxrY+4y5kCxDwL2hl7IEcxYxMcWj3M3NguFPeIndRClkk0+br8zBnH3nJzwU9o3KpNicPDwnA==
X-Received: by 2002:a9d:5f1:: with SMTP id 104mr7706859otd.306.1619019950473;
        Wed, 21 Apr 2021 08:45:50 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id g16sm519050oof.43.2021.04.21.08.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 08:45:49 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH] of: overlay: Fix kerneldoc warning in of_overlay_remove()
Date:   Wed, 21 Apr 2021 10:45:48 -0500
Message-Id: <20210421154548.1192903-1-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'*ovcs_id' causes a warning because '*' is treated as bold markup:

Documentation/devicetree/kernel-api:56: ../drivers/of/overlay.c:1184: WARNING: Inline emphasis start-string without end-string.

Fix this to use the normal '@' markup for function parameters.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Frank Rowand <frowand.list@gmail.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/of/overlay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index d241273170fd..67c9aa6f14da 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -1181,7 +1181,7 @@ static int overlay_removal_is_ok(struct overlay_changeset *remove_ovcs)
  * If an error is returned by an overlay changeset post-remove notifier
  * then no further overlay changeset post-remove notifier will be called.
  *
- * Return: 0 on success, or a negative error number.  *ovcs_id is set to
+ * Return: 0 on success, or a negative error number.  @ovcs_id is set to
  * zero after reverting the changeset, even if a subsequent error occurs.
  */
 int of_overlay_remove(int *ovcs_id)
-- 
2.27.0

