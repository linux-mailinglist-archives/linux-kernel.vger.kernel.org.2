Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 391E533B2AC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 13:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbhCOM0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 08:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbhCOM0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 08:26:09 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605E1C061574;
        Mon, 15 Mar 2021 05:26:09 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id t9so5586776wrn.11;
        Mon, 15 Mar 2021 05:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OGtlc8c4S3KD8tus9t3HydkaPfEfvyPfR1Hv2y1FzZw=;
        b=IX6mTFbCXkuco7A1Rg/XWkFdtJAL3DF8iAj043sw2278Kot/5A8aws5S0fH3bZzQIs
         tNWJ5cBjoBrwIq/zHkfp/9mSKk1f5SZ9XlDsEfmuEtnENU51n5hPQSfkEVsKl3jpulgL
         vNQQ7KqZR5/SlCUlJ1jtokGaj0WigXmmRug5ayzrg0+dy/NtifMW5tFof7bsK9qk6P9m
         lDO6W9l0BA8yku2Jt5OfVYkgkj1vzEhuSfFt2BwJtMZA5QwgLSgSyh1JKtCK61b9qSDm
         P93AdLQ5Z8kT+npvOJ7ZBJ6e3lw3aLqibVJIJ61nKopKXPMs43yAXJUhEFA7HcOn4d2t
         JXdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OGtlc8c4S3KD8tus9t3HydkaPfEfvyPfR1Hv2y1FzZw=;
        b=cWo5EkEgR6GNU3y7tTQM0jWuMd/kNAdbRPyXStbI0mhsMtyFncJhoJ2xIiJJ8piN2F
         c/HSJwgyqO50nJFm1OXRb+a7+B8WOAMceAaK3FW0Y8rF8v+BTl8yBZutPxdnRMasz2K8
         8HDaPW0UwhHwiXknBI46o1AxjWImISuSA+/oFg62HLskGRf5X0iGbGOXSL1fcfDfGCym
         BoQU9bPDTukbra1pOiEBz+LsfVlTPJJNWA6gAXIG2KvaxE0Qctbhl6D93ZIQfMFwFpME
         2hTw3bdt9liPoM2b4FtePMNlDt9HOL4JZsNuj1GbPGxfakanP7pomT6tV3XWzSzwnfez
         FfmQ==
X-Gm-Message-State: AOAM533mRa2SI8WAISGROcHdEDvjXlC6k2u54b/gstVg+l/6JAZPE570
        VSiYPmo6cb16M5EhYjokk54=
X-Google-Smtp-Source: ABdhPJy1IAUZ1fPAY233A3at4rZ9rX0T/CuPah7233IIFCHU2JkWGnvzo34Vl7VKV+twzHfcyvBWLw==
X-Received: by 2002:adf:f587:: with SMTP id f7mr27244970wro.147.1615811168113;
        Mon, 15 Mar 2021 05:26:08 -0700 (PDT)
Received: from skynet.lan ([80.31.204.166])
        by smtp.gmail.com with ESMTPSA id o7sm18317851wrs.16.2021.03.15.05.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 05:26:07 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     jonas.gorski@gmail.com,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Maxime Ripard <maxime@cerno.tech>,
        =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>, Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/4] dt-bindings: clk: add BCM63268 timer clock definitions
Date:   Mon, 15 Mar 2021 13:26:02 +0100
Message-Id: <20210315122605.28437-2-noltari@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210315122605.28437-1-noltari@gmail.com>
References: <20210315122605.28437-1-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing timer clock definitions for BCM63268.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 v2: change commit title, as suggested by Stephen Boyd

 include/dt-bindings/clock/bcm63268-clock.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/dt-bindings/clock/bcm63268-clock.h b/include/dt-bindings/clock/bcm63268-clock.h
index da23e691d359..dea8adc8510e 100644
--- a/include/dt-bindings/clock/bcm63268-clock.h
+++ b/include/dt-bindings/clock/bcm63268-clock.h
@@ -27,4 +27,17 @@
 #define BCM63268_CLK_TBUS	27
 #define BCM63268_CLK_ROBOSW250	31
 
+#define BCM63268_TCLK_EPHY1		0
+#define BCM63268_TCLK_EPHY2		1
+#define BCM63268_TCLK_EPHY3		2
+#define BCM63268_TCLK_GPHY1		3
+#define BCM63268_TCLK_DSL		4
+#define BCM63268_TCLK_WAKEON_EPHY	6
+#define BCM63268_TCLK_WAKEON_DSL	7
+#define BCM63268_TCLK_FAP1		11
+#define BCM63268_TCLK_FAP2		15
+#define BCM63268_TCLK_UTO_50		16
+#define BCM63268_TCLK_UTO_EXTIN		17
+#define BCM63268_TCLK_USB_REF		18
+
 #endif /* __DT_BINDINGS_CLOCK_BCM63268_H */
-- 
2.20.1

