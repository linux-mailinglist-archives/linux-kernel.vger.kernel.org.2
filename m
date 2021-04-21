Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2AC5366455
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 06:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235018AbhDUEWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 00:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234734AbhDUEV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 00:21:58 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEEDBC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 21:21:24 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id w10so28551754pgh.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 21:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UFoByzns0zKKR0s/VA5elIm+z4agHNvAR8nRlMenl+0=;
        b=HXpye8TnFDEPX1Pim8Xayxqx78v/A8trwzZlMbGikEEtr18/JENjNcc2wK3zGfD0yz
         ilDiMpQ9iOBvsvPyt7ToBL+GXzidnH8B5rxqrlQLuLQvZcZ8BoLtZoyhOQCGjWdB2eDv
         4EZm4aBGtHYKMfOuliWzxbr1ajk0PmJO7uG0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UFoByzns0zKKR0s/VA5elIm+z4agHNvAR8nRlMenl+0=;
        b=Gzi81EF8Vt+hgkehAyNF0GHgHNpzxyB37fj34hzpFGusBKvj9zKmbDbG8Z6NJ9hJ13
         2TIJuak91z/aBuoOzi17ADySqtha1UCvn6dsexyJWuMjOu7bqtQPlnJhU2tL1sTyPTdL
         OIP9UAg646SPUaergd8QUNf1tjrWzENv1oWY3SIs3KnRH+it3F5iviUC4nrzTlM2kh7o
         9Taaq+W/Ap/pWi7zh7VSaYfEza6/d6J5WpmOkqOkpKwNcGuYP7Tg8ChqFu9zjIjbzQoc
         POPekLOHYzbeAMX5TYnGqDdyJn7GavO/NN3D9Sb/cASjRPREoNvGBmbjys5pRZKLWKIK
         DOZQ==
X-Gm-Message-State: AOAM533nc7ya+K4vMfOBEXUrga6hVXcBxtf23KeEikENQZn9QNwvQnsE
        TeErEXa/v/1FFcMU8Px2Bzg9GoIKELZ4kQ==
X-Google-Smtp-Source: ABdhPJzXTXoNbdq5q7jVWShrjmDOOiit0BUedppoNgGA1XupmG0rmqSA4wDRu+XK0v/zTpB6egqtrQ==
X-Received: by 2002:a17:90b:e8b:: with SMTP id fv11mr8836631pjb.66.1618978884316;
        Tue, 20 Apr 2021 21:21:24 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:d3d3:f8d5:d9e2:fa85])
        by smtp.gmail.com with ESMTPSA id n20sm576661pjq.45.2021.04.20.21.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 21:21:23 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH] platform/chrome: cros_ec_typec: Add DP mode check
Date:   Tue, 20 Apr 2021 21:21:09 -0700
Message-Id: <20210421042108.2002-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are certain transitional situations where the dp_mode field in the
PD_CONTROL response might not be populated with the right DP pin
assignment value yet. Add a check for that to avoid sending an invalid
value to the Type C mode switch.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_ec_typec.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index d3df1717a5fd..69646262fa9d 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -486,6 +486,11 @@ static int cros_typec_enable_dp(struct cros_typec_data *typec,
 		return -ENOTSUPP;
 	}
 
+	if (!pd_ctrl->dp_mode) {
+		dev_err(typec->dev, "No valid DP mode provided.\n");
+		return -EINVAL;
+	}
+
 	/* Status VDO. */
 	dp_data.status = DP_STATUS_ENABLED;
 	if (port->mux_flags & USB_PD_MUX_HPD_IRQ)
-- 
2.31.1.368.gbe11c130af-goog

