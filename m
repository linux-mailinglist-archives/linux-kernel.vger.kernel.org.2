Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 438D53C7BE2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 04:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237635AbhGNCjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 22:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237608AbhGNCjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 22:39:13 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE58EC0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 19:36:21 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id m83so675178pfd.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 19:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xlJdpfYrsJIKfnucuosznO4/0QXLV8smxEHyNUyFy9c=;
        b=PAzN6QqBgB58ZiPctC9OxiGeH0GMimXU4onoY0i4KikiZWhkgD5Plekj9ZHV1rM5B/
         ACTEVna0jWymuh0rtnJ8H3dJGCat5NT+td+RoWlZmaxvmsztrWgbtYuwSGoHjVmTuK/8
         ANND404v1zp0umlg0NsQIFAy5IkCG4JXYZoBNLN8YvVUhi2/aQ37r4N43obWsPxz6OHx
         z+sKTYuJUOcoPrZBMOGeJozUc5Ig1fEj+LZMgH4CtaFmSwd7253KK/sYTYroO81s5TCm
         G1/ufHjittc2H3yyWK5zgwriryMePg7yo0Ra/PcIGmpBxI+XkBlnDyFmcl+fi/U5TEiK
         g58Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xlJdpfYrsJIKfnucuosznO4/0QXLV8smxEHyNUyFy9c=;
        b=MUPC1wyn+z/i/QckUerWHQIcwWp4Ib8DschpBOBXoWN3ZygRhuGls9reIBetJ2R3uF
         eFza8THnPnGrAGaA3fYNHxE3YKetDPtRZ8TIXbdFStmQlE0wI63+ARBwNz1/3okWMooY
         buhcIrJm77RDv6YfhnG8qHcRO/8vXyw2pEfGCqmpxvrwMCot62PPE8damz6DjeJ52/Jx
         NfLYCqf/wtGjFp1XLzHdBLRsISqB3Odor4DXfIeKyjcfhxMXJGiLfVfnebzRC8sNPbjU
         nsrJOTRn++X1L1oJ5p6yGR9VOww8EFGs9iju5aTE/fxOznrRYgibVv0pRzP3d8+CNqh6
         LGjw==
X-Gm-Message-State: AOAM533KD32dJl9DSwCjlnVRZjybaz2tTi9QbDXb/KpZKX8wGr4s9F0n
        CQeEBvc3uT1duPYgFz1Zpb8=
X-Google-Smtp-Source: ABdhPJzCpE3oydg5C22jmM7QM4Ygg3fgDYpMXhcjI1WOXo0gdq03NkVLQJQvHFQ8Gm5fJxnD0PH2qw==
X-Received: by 2002:a65:6497:: with SMTP id e23mr7111851pgv.43.1626230181186;
        Tue, 13 Jul 2021 19:36:21 -0700 (PDT)
Received: from localhost.localdomain (1-171-13-208.dynamic-ip.hinet.net. [1.171.13.208])
        by smtp.gmail.com with ESMTPSA id u16sm486022pfh.205.2021.07.13.19.36.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Jul 2021 19:36:20 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, cy_huang@richtek.com, axel.lin@ingics.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: rtq6752: Fix the typo for reg define and author name
Date:   Wed, 14 Jul 2021 10:36:10 +0800
Message-Id: <1626230170-13648-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Fix the typo for reg define and author name.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 drivers/regulator/rtq6752-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/rtq6752-regulator.c b/drivers/regulator/rtq6752-regulator.c
index fe31597..72a72aa 100644
--- a/drivers/regulator/rtq6752-regulator.c
+++ b/drivers/regulator/rtq6752-regulator.c
@@ -19,7 +19,7 @@ enum {
 #define RTQ6752_REG_PAVDD	0x00
 #define RTQ6752_REG_NAVDD	0x01
 #define RTQ6752_REG_PAVDDONDLY	0x07
-#define RTQ6752_REG_PAVDDSSTIME	0x07
+#define RTQ6752_REG_PAVDDSSTIME	0x08
 #define RTQ6752_REG_NAVDDONDLY	0x0D
 #define RTQ6752_REG_NAVDDSSTIME	0x0E
 #define RTQ6752_REG_OPTION1	0x12
@@ -280,6 +280,6 @@ static struct i2c_driver rtq6752_driver = {
 };
 module_i2c_driver(rtq6752_driver);
 
-MODULE_AUTHOR("ChiYuan Hwang <cy_huang@richtek.com>");
+MODULE_AUTHOR("ChiYuan Huang <cy_huang@richtek.com>");
 MODULE_DESCRIPTION("Richtek RTQ6752 Regulator Driver");
 MODULE_LICENSE("GPL v2");
-- 
2.7.4

