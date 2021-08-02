Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 432093DD1B0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 10:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbhHBIFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 04:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232743AbhHBIFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 04:05:47 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78074C06179C
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 01:05:37 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id a26so32123382lfr.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 01:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NHo68a2gjl1rMFsLz5JF9TFUzXkHfrX9hWwZv2Cz1bk=;
        b=HhiFKRGi1BirY/qoanCTPc5/PJ8nWEch6tLrPZWgYy2+rq1fVXzH3WBN3iwkyWqdOU
         46/2TPbonNSr5veBUxt035sKTWTAITrN9cTV4XXe2wVAgTE2+TdxmPwP5/U5+GgR+goG
         RgT+ixXC3YFkDBKWU9IB48eoJefMEhpTSelZk5/93CIpeKhtn6afSuXQUNHGupkiGrSP
         REcgFmDr86/RxXJR/jt8GJmnYOSpNU6cqiwNG0gqTtJMMrayWVJOJzlEyNeXtslkHsLm
         GKoj3I48Zrgiyxjw4bK+dBrwhAI8cvMx3f8KS/cOmhjdJtgfLt9sceSM6pyiW6YjfY3H
         x1ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NHo68a2gjl1rMFsLz5JF9TFUzXkHfrX9hWwZv2Cz1bk=;
        b=Byu4eDCoiKfwXzLK56tOIWGLWv9ClpR5zBOUSH8nTmB/eI5Imb5IjoKx+klx4kG4Ya
         hvtLf9GVTXSIVBicgFqnW9SHka8HFkm+29MMN43NdOnR1cBKt5iBGPSnrMfkUipEk6gm
         1AjQi51CWCeQKy9nOTjneHIAS3bnEGOyAfZX6PLemnIXuniFAu63A5qZinJWnCb8CHkz
         6s8SOOgh5Ius3gXu3c97LBFouUuWaubkDgspSUzIxohWcHXmVgpGzL+btS/SUNq3m01f
         iNlBIwg0nLbbsHCmtifvUpvUu8LEW8PzMcO7IrjD2d9BTtGuySwau1JIXP8pwuw3EzOc
         cS8g==
X-Gm-Message-State: AOAM530Lip5UU6JnGBMjWRDxUgrd9pESpQ18hZxxhIxIk17KpXNjRLGi
        GIPEY19mGpHQ4HV28F3jOORlCg==
X-Google-Smtp-Source: ABdhPJzOypnLuMmyB5gs6j1mHp3oo+g7a0VFt/pl04iTRQG7HHH6KmXp/WQ/Dzc95ARjh0BxO2OW6w==
X-Received: by 2002:ac2:484c:: with SMTP id 12mr3190458lfy.31.1627891534380;
        Mon, 02 Aug 2021 01:05:34 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id a6sm640553lfr.127.2021.08.02.01.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 01:05:34 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] mfd: db8500-prcmu: Rename register header
Date:   Mon,  2 Aug 2021 10:03:32 +0200
Message-Id: <20210802080332.3172856-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the ambition to support dbx500, the other SoCs in this series
were never deleted and the support for them has been deleted.
DB8500 is what we support.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mfd/{dbx500-prcmu-regs.h => db8500-prcmu-regs.h} | 0
 drivers/mfd/db8500-prcmu.c                               | 2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/mfd/{dbx500-prcmu-regs.h => db8500-prcmu-regs.h} (100%)

diff --git a/drivers/mfd/dbx500-prcmu-regs.h b/drivers/mfd/db8500-prcmu-regs.h
similarity index 100%
rename from drivers/mfd/dbx500-prcmu-regs.h
rename to drivers/mfd/db8500-prcmu-regs.h
diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index ca1145f1a11a..75049cf38832 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -37,7 +37,7 @@
 #include <linux/regulator/db8500-prcmu.h>
 #include <linux/regulator/machine.h>
 #include <linux/platform_data/ux500_wdt.h>
-#include "dbx500-prcmu-regs.h"
+#include "db8500-prcmu-regs.h"
 
 /* Index of different voltages to be used when accessing AVSData */
 #define PRCM_AVS_BASE		0x2FC
-- 
2.31.1

