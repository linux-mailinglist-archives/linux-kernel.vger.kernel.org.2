Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB18139746D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 15:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbhFANhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 09:37:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44675 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234003AbhFANht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 09:37:49 -0400
Received: from mail-ed1-f71.google.com ([209.85.208.71])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lo4Yx-0005Ji-0S
        for linux-kernel@vger.kernel.org; Tue, 01 Jun 2021 13:36:07 +0000
Received: by mail-ed1-f71.google.com with SMTP id d8-20020a0564020008b0290387d38e3ce0so7837932edu.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 06:36:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KHWmh1TQs4IjrJsBdCyrsWcpBXc8c+PRPRjkAmTTzg0=;
        b=Xf/aMSuOvqMmgP9t9wks9hOqliUqQE31YvSspC5fsdDrOcaL3ItGSYnCjHMry16N5T
         48XwTnZemd6YU+eiZL+H4fEtk7JFd9nDwebD+71a3DitoQZpu9gmmuW++B4j8aZd6nlW
         qyaFVdx7DVWr8y9ab/RAULHpDa9soS4+xzO5eZavevNGGXOLj5GEzwLvB+HpdP3fk3xg
         lbIpnPPrmwhwVNuB4sgyPeDCNDArIitleLf9ORaCrC0kSdqLJ6KC7fDKz1HBCIX6QQGm
         6sKQ1fOffjw7K04JhsGhgGtAglZGqXNnfc6DTe/CSWRewlpq80iMJsEQCqxhxVwFKhif
         n6fg==
X-Gm-Message-State: AOAM530xvycpbZZ18IxPuLjT+UYteWzBGUkadgVfs+tuJsILX2uMTC1z
        +RinBa0PFlNxRRYyQ+T5k1/EvYvDe0YwgK9Nx3haOb7htHRbKGK1wNRPdPVpTwvVA5RNxPgq1lg
        bdKLNH8yg6TjOfiLhk8SFZVzGMYLdlcO1GWIRV38hOw==
X-Received: by 2002:a17:906:1299:: with SMTP id k25mr28989401ejb.139.1622554566541;
        Tue, 01 Jun 2021 06:36:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/VSMw2nbk3tEDQKwI/OYfBmyMHCXNfN4G1xSI/KwZZwFSS1p/ytfWzCAebqN51mY4eVfQbw==
X-Received: by 2002:a17:906:1299:: with SMTP id k25mr28989374ejb.139.1622554566352;
        Tue, 01 Jun 2021 06:36:06 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-185-9.adslplus.ch. [188.155.185.9])
        by smtp.gmail.com with ESMTPSA id p5sm7210941ejm.115.2021.06.01.06.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 06:36:06 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 1/2] power: ab8500: remove unused header
Date:   Tue,  1 Jun 2021 15:35:59 +0200
Message-Id: <20210601133600.285452-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ab8500.h header in linux/power is not referenced/included, so can be
safely removed.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 include/linux/power/ab8500.h | 16 ----------------
 1 file changed, 16 deletions(-)
 delete mode 100644 include/linux/power/ab8500.h

diff --git a/include/linux/power/ab8500.h b/include/linux/power/ab8500.h
deleted file mode 100644
index 51976b52f373..000000000000
--- a/include/linux/power/ab8500.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) ST-Ericsson 2013
- * Author: Hongbo Zhang <hongbo.zhang@linaro.com>
- */
-
-#ifndef PWR_AB8500_H
-#define PWR_AB8500_H
-
-extern const struct abx500_res_to_temp ab8500_temp_tbl_a_thermistor[];
-extern const int ab8500_temp_tbl_a_size;
-
-extern const struct abx500_res_to_temp ab8500_temp_tbl_b_thermistor[];
-extern const int ab8500_temp_tbl_b_size;
-
-#endif /* PWR_AB8500_H */
-- 
2.27.0

