Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD7C4364851
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 18:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239316AbhDSQeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 12:34:21 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38544 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238974AbhDSQeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 12:34:15 -0400
Received: from mail-ej1-f71.google.com ([209.85.218.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lYWqH-00029C-8v
        for linux-kernel@vger.kernel.org; Mon, 19 Apr 2021 16:33:45 +0000
Received: by mail-ej1-f71.google.com with SMTP id ne22-20020a1709077b96b02903803a047edeso2538631ejc.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 09:33:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tffa8FxLRD95q68BP7WAuHuH/QuQK9CLj68muj3l3Us=;
        b=cosJc+uLxsC6doV8rktWFMwuwmcpZiohEYnn/qJNx2Mr99Qx2QE06LpHO0xEBkYQHq
         FqvWIg0p2E92pRSkYSc9kBVip/Bs0t3WOUWvNCxnRVKKLI0jp45se+1+PLLj16tK6Z0n
         ga2KLyZIwCkBYoRdmA+++Ogb7a41fmu9c15Fv/rGqIDPJBvL1f28D+KYJic+95jSiw1V
         NBqI+1f7T7TVX2wB4S3cohzhxay0P7KYrO242hoWMb2AjBwkZIoVTyHOvjPP3pf9bCSY
         bRrqflGb2YBFPHgGq9ynDpS+RftsEOwVY7erSt38L2EX7stjMce76WCwYlachR8KSqaC
         lKzA==
X-Gm-Message-State: AOAM532pSIJqINjbmzso1mlryMSsXMn4jEIWOJnTxrlSGmFv8tNP4P/w
        di0aEBrX3nfA/ogN6itynN4T+XK0d8U4AQzsVRXOXyqWIASOIpwQBH2reijJgZAUB/BUa9RePbC
        hVIWRvxCgswRbDvei4BZjjsrDm5GoNqLnHLv4G2baxQ==
X-Received: by 2002:a17:906:8407:: with SMTP id n7mr22280295ejx.264.1618850025027;
        Mon, 19 Apr 2021 09:33:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwIPWR8ANiEgnuHcBPUQLALdaXMV0Sh7rj34LKbSDdNWxalGwJMT5vUSg1W9Vn8ufz87Al0uQ==
X-Received: by 2002:a17:906:8407:: with SMTP id n7mr22280287ejx.264.1618850024906;
        Mon, 19 Apr 2021 09:33:44 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-180-75.adslplus.ch. [188.155.180.75])
        by smtp.gmail.com with ESMTPSA id d10sm10884257ejw.125.2021.04.19.09.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 09:33:44 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] power: supply: bq256xx: add kerneldoc for structure members
Date:   Mon, 19 Apr 2021 18:33:36 +0200
Message-Id: <20210419163336.64075-5-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210419163336.64075-1-krzysztof.kozlowski@canonical.com>
References: <20210419163336.64075-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document members of structure to fix W=1 warnings like:

  drivers/power/supply/bq256xx_charger.c:240: warning:
    Function parameter or member 'charger' not described in 'bq256xx_device'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/power/supply/bq256xx_charger.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/supply/bq256xx_charger.c b/drivers/power/supply/bq256xx_charger.c
index 2ab5ba4af92b..f501ecd49202 100644
--- a/drivers/power/supply/bq256xx_charger.c
+++ b/drivers/power/supply/bq256xx_charger.c
@@ -202,6 +202,8 @@ enum bq256xx_id {
  * @client: i2c client structure
  * @regmap: register map structure
  * @dev: device structure
+ * @charger: power supply registered for the charger
+ * @battery: power supply registered for the battery
  * @lock: mutex lock structure
  *
  * @usb2_phy: usb_phy identifier
-- 
2.25.1

