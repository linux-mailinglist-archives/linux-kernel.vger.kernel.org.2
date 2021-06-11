Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A322F3A3E20
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 10:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbhFKIhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 04:37:15 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:40751 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbhFKIhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 04:37:12 -0400
Received: by mail-wr1-f47.google.com with SMTP id y7so5106975wrh.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 01:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k3MEjdeVHn7sFWERR8smEux1izWnO8FFbeYR5RZ6n3E=;
        b=VOD58DJ/AjE4BVJ0SAFaAzgxkgXL06VOagBnYO19EK66eySu0ck5Z5t7D5gnAs42y4
         os+idR0aebvvUlYHaw30tPUhCMGZS/VSHXyWvJk9ppuiJmz/ty19bnC8TZLntPWEOQ6z
         65VZrTbQ4L4t54isCBp4nC5pSCQM2rRNRT/bq53O51h3F3IFVbcMsyj1QaKYK95m6AOP
         dYjs/e/aoD0e1WfeLSVEHER3Z1Sqai4RJcoLGG+Ha+2iPSIEyh//rtQ3BkYddQN1IVBJ
         CTip6uWthfmiaJq36PkdhCvKlTGl8492yBuKPTeI8QyqJ1guzaJ8KE5phO+nybn6GyU0
         IF4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k3MEjdeVHn7sFWERR8smEux1izWnO8FFbeYR5RZ6n3E=;
        b=LUk9PyJg6NJnRzQTPlgoswUdgQfo3c3JB/7Kn4yLDDjp7h7bNDUL6tCs+tTez7nDWR
         jsXW/+g2xl4P+hJnBEF7i1ECvo7zB3+9kv6BL1zXTLsT+hxXN9xtbY+vATDOn9WR1sY0
         JstIpFbU+oe9BRvZqrIA46ta7rd2DA196fMpEo+Kfo0e3CSSoQnbFOddl7Dlknugm5UR
         GfH+g5Ag2e9kQKVH/+mNaa1t7T+daUKEeEMOjKjzVbrE8cFr8UEbamAhDntGzSCSDbHa
         p0IEwLAx2J9TCZbbHtEfdnkNCZRSJ+qMzjrYdlH9D0s2wKpoU7Z4U2IXI4vs75QKLKpi
         Pimw==
X-Gm-Message-State: AOAM533hU6RpAmb3t3OucSn3ojilpy2/sPmfBMDFvNnmHaUmaapOcQ5L
        rugWP9HZw4yrs2IX7XtsJDrwdA==
X-Google-Smtp-Source: ABdhPJwXIzjRW/ZJ2n/5Jknq26tz5weMTJUhd3zFngiVOo68kyjiTrPN5tDKDlRNhC/xkEJzK+Zybw==
X-Received: by 2002:adf:ee85:: with SMTP id b5mr2671496wro.95.1623400441559;
        Fri, 11 Jun 2021 01:34:01 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id n42sm11547428wms.29.2021.06.11.01.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 01:34:01 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Joe Perches <joe@perches.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 9/9] nvmem: qfprom: Improve the comment about regulator setting
Date:   Fri, 11 Jun 2021 09:33:48 +0100
Message-Id: <20210611083348.20170-10-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210611083348.20170-1-srinivas.kandagatla@linaro.org>
References: <20210611083348.20170-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Douglas Anderson <dianders@chromium.org>

In review feedback Joe Perches found the existing comment
confusing. Let's use something based on the wording proposed by Joe.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/qfprom.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvmem/qfprom.c b/drivers/nvmem/qfprom.c
index 1ba666bcb900..81fbad5e939d 100644
--- a/drivers/nvmem/qfprom.c
+++ b/drivers/nvmem/qfprom.c
@@ -196,9 +196,9 @@ static int qfprom_enable_fuse_blowing(const struct qfprom_priv *priv,
 	}
 
 	/*
-	 * Hardware requires a min voltage for fuse blowing; this may be
-	 * a rail shared do don't specify a max--regulator constraints
-	 * will handle.
+	 * Hardware requires a minimum voltage for fuse blowing.
+	 * This may be a shared rail so don't specify a maximum.
+	 * Regulator constraints will cap to the actual maximum.
 	 */
 	ret = regulator_set_voltage(priv->vcc, qfprom_blow_uV, INT_MAX);
 	if (ret) {
-- 
2.21.0

