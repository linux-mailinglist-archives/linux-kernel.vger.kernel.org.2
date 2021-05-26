Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF9BE391854
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 15:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234215AbhEZNCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 09:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234399AbhEZNCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 09:02:23 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA78EC061760
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 06:00:50 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id n4so1058523wrw.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 06:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wClzZvICbZY1gDqbs5K+gmqfI5n/KTxqQt4Q33U0XvY=;
        b=VpxrOtJd113lP+VjeEIN7iNWNT3vxTAUF/jCgeAQmbLtvfWY4e+ytfafM1dhU/m4DT
         UUSP1iUSbi3bMSzTAoliO7w/28GG32EaQ1/GzU8XPedUzVFsLnO2c8n2WKb8L64VIEA7
         uT2zbHKlwICxHjmng6VP3DR2bD1esx2/dTBOuZTZuR0dKbrXspv8IO/7hDq7FDieTRrs
         hJqhs7qXUDi0ZTeQOkJqEje+VxTUNisS4FOilETg5sVs3QJBPOG2MCzhgXQzhHcw2kUt
         AazbdNLuCeDfe2UhzBs+pn4z51NFipJnhA9p3WP4UMy+pXKS2vJ7hKeVtQvoyt7LWkKD
         ibRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wClzZvICbZY1gDqbs5K+gmqfI5n/KTxqQt4Q33U0XvY=;
        b=fu7FS/qMF5dISzzwduaJfj0F4FlgRL9I/E2Vvux5WxFQ/Wywn06irXP5QQfUkr+YXz
         jmTj5w5qL1rsU+MMLl0Jo3GLNEpjmcn2RqomVyiB5GKDvy0c4txJ8J3jjOidnP/aeUZs
         1S8gmFp7PIR5CGj5wWfE2uoqSGPAeLjjepXYIKPYAB7npR/fcd2HBKJayx5CNbmPpZfB
         A7PKxn7qdTw8Jblf9zac4G0DP/RWVPf8UXvsUk98Jouhm3zzCjqIcBU/OpUvcZ9+VU7a
         HDQNK1wcYZeR5wYd6SaoK8br+4ZUvh9yQ4xj4ScRn8k04yyE9wgDI6ZmcIvAaeuYJEpH
         YIug==
X-Gm-Message-State: AOAM533NeFUG/p3RGmkDbOMO398/5FPvIZF4Bz4KlWpQovYyb3E30NwH
        ZM0Sh5cYyEKOEyb05joQiYSaew==
X-Google-Smtp-Source: ABdhPJzyC5CuTPA/mddKYnxBk2ZuzkwnF05QXDPiw/dHSZafcLnBzSwjlhOjPo4pUYzR2+8v9voY3A==
X-Received: by 2002:adf:d4c7:: with SMTP id w7mr32509687wrk.35.1622034049311;
        Wed, 26 May 2021 06:00:49 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id y14sm6430036wmj.37.2021.05.26.06.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 06:00:48 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: [PATCH 03/24] usb: common: ulpi: Add leading underscores for function name '__ulpi_register_driver()'
Date:   Wed, 26 May 2021 14:00:16 +0100
Message-Id: <20210526130037.856068-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526130037.856068-1-lee.jones@linaro.org>
References: <20210526130037.856068-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/usb/common/ulpi.c:151: warning: expecting prototype for ulpi_register_driver(). Prototype was for __ulpi_register_driver() instead

Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/common/ulpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/common/ulpi.c b/drivers/usb/common/ulpi.c
index ce5e6f6711f79..7e13b74e60e5a 100644
--- a/drivers/usb/common/ulpi.c
+++ b/drivers/usb/common/ulpi.c
@@ -141,7 +141,7 @@ static const struct device_type ulpi_dev_type = {
 /* -------------------------------------------------------------------------- */
 
 /**
- * ulpi_register_driver - register a driver with the ULPI bus
+ * __ulpi_register_driver - register a driver with the ULPI bus
  * @drv: driver being registered
  * @module: ends up being THIS_MODULE
  *
-- 
2.31.1

