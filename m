Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0D653DFE20
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 11:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237122AbhHDJih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 05:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237101AbhHDJig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 05:38:36 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A83C0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 02:38:23 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id m10-20020a17090a34cab0290176b52c60ddso2703300pjf.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 02:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bl0ieZouGGJi4I0+W9jcvz9qeWKgk85otQ7ch4geD2Y=;
        b=m1wfGXeNE9PtDpOatM501OUFc1u0VjVa25Jpy2ocwDwjMPVdqb8S3Ka29328leMYlG
         x7RAwGbEyd1Kxrl6x4mP8ylQhoPSZqcH1XGdoUFWFSIZN5S9D4i5q8kM7O3vxKBMu625
         bXYMfZJgA37qFPyxTpjg0AecdjSDtpeVkJbXKzF7Zcvun4I81aM7jLoSWk/bMUPG7dZZ
         35MrMR7c/ZNcJ/7AsQe09lYrGhjfojoEvGxIKZerZVdprtWezL7t1b6YGxIP24WSybx+
         j61G9tjyZXwWqTQCsbmW4zWV4BB5XlRuw2QulPvnyNHsq2ZtFKG+2nDFArlujX9o7GSt
         r3Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bl0ieZouGGJi4I0+W9jcvz9qeWKgk85otQ7ch4geD2Y=;
        b=mzU1VQruDqj2v5CMk9Da0O/pTvvz7yhtjYGsRDWGcXVtHtEAgX9K+NEb3NXjYIxbgc
         mEbmNi3662myw0eprMLUUa1o2WW0oZXtY4zLo/A4SwOmES3wYP4Ideo5xiRR8eg/DASY
         3SgAxpCGfdCzFBBwf+B8pd8BhaydC/1PUGhwkSOXcOt0sFizg5byvk+Vp4yj4bYvGefk
         5ihvDPDKcWWMXXAs88LN5Gi8gXKbv3Y72TjTU9wDvUEFEIY7sOGF6W0Zg1I3KhOfdySG
         dH7feHABKV7+CF6PgZiN30kurN4kx0JOpgRrEX07inBK8u3BITXConT2FOv9XyOvyJgc
         7g3w==
X-Gm-Message-State: AOAM530mMKdCYr7IvdN4HA+nkNOhi0gMJBgG64ECSgLV+PkMAJpfXSBj
        3x2ZWgdoHRbUczVI4to6fng=
X-Google-Smtp-Source: ABdhPJzZGMAY6exXu9a62YhgjZ27P+pIHVLwCfdEcDzEjlZ/IEAoy5e7CYD3QMIAMCLIyjEqtMutOA==
X-Received: by 2002:a17:902:7885:b029:12c:437a:95eb with SMTP id q5-20020a1709027885b029012c437a95ebmr2020837pll.80.1628069902948;
        Wed, 04 Aug 2021 02:38:22 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id q14sm2088403pfn.73.2021.08.04.02.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 02:38:22 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: yong.yiran@zte.com.cn
To:     linux@armlinux.org.uk, yong.yiran@zte.com.cn
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] 'linux/tty.h' included in 'hackkit.c' is duplicated. It is also included in the 21th line.
Date:   Wed,  4 Aug 2021 02:39:07 -0700
Message-Id: <20210804093907.618719-1-yong.yiran@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: yong yiran <yong.yiran@zte.com.cn>

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: yong yiran <yong.yiran@zte.com.cn>
---
 arch/arm/mach-sa1100/hackkit.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-sa1100/hackkit.c b/arch/arm/mach-sa1100/hackkit.c
index 3085f1c2e586..3fe34ee7c0ab 100644
--- a/arch/arm/mach-sa1100/hackkit.c
+++ b/arch/arm/mach-sa1100/hackkit.c
@@ -18,7 +18,6 @@
 #include <linux/serial_core.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
-#include <linux/tty.h>
 #include <linux/gpio.h>
 #include <linux/leds.h>
 #include <linux/platform_device.h>
-- 
2.25.1

