Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAFF3403A7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 11:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbhCRKlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 06:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbhCRKku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 06:40:50 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80C9C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 03:40:49 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id n11-20020a05600c4f8bb029010e5cf86347so6674592wmq.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 03:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s/yHaiIW3zZWGJ7IRLS4o0qlm7CjCLAYQPe2urNviwU=;
        b=m2pcdvClE33ozLIPbSCd7+x7Q5KpPi5D4AaEREh1vozlK8Hd+MYr/QoN1Xh66Y8bGi
         fkNBubXz0/9Cn8Q4R795drJ4rXwaLj/joqxqx/njXrlYcjFlKkvkQoK5yMdO4Za08xQR
         v2mZJxqNqfXG28y5nllnqPk3Mb//QsIkRXsri40zEnTOLaauXjmmmo5YCQk0FtoON74j
         WzKF2gOqdse0xY9KkoXTFUrnGAp+f0ByCjaFYHEJmz98IeghfPymtgTjyfOtpDikLQl+
         sP5RN2cxVXPsCQEA7xXyuYfhEh4gzt0aSRm76gi5vM5znzdJj/zoJwGGYUCXmQgOvmgf
         U00w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s/yHaiIW3zZWGJ7IRLS4o0qlm7CjCLAYQPe2urNviwU=;
        b=GQmHE3wE6DhXWGaG7GAFdtIXt1b/vPx0Q/JdvYPOQCnQN+8Uxy7lHhcaXxl3/HeRi6
         K5azIDdP76QdPsfPcUTxuwUEiDKJoKxH6MMDXP48ARnmw9TMYTRXH2a1HPUKFEhtzkU2
         pUXBq53XVeK/N1mF/crBcJid0PnwdAMqExNuuwAjozSiobnjsgU/5TWeWF+NhzRsM5fL
         rXb4pFbIzL7WejHRZPtDwXyff8WF4hVg+pTMwvCZl6/qPT0R2IWtB80PbJfX4pf74R+T
         2f5jrrA028xPO3/MNn/99ddSv2SpodYVmNRF7M5SP9gmB/l4HitOK2x3uGBY6+a22vvF
         sLbw==
X-Gm-Message-State: AOAM532VlwR0WgqpYDxxDpDCjde8PTIHg8E0ASV01SYWuv1JJT9Q+Qrl
        KYeEQKi13iLgipT806kavS7VKA==
X-Google-Smtp-Source: ABdhPJw6V5oOhMmLLeGM1gmgu2LIqdAbHQZzvnxE9xL4JhW+pJnB4qvN1QvR6asUNlJLEJZOoSfilA==
X-Received: by 2002:a1c:1cc:: with SMTP id 195mr2969782wmb.41.1616064048713;
        Thu, 18 Mar 2021 03:40:48 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id z1sm2426033wru.95.2021.03.18.03.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 03:40:48 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, devicetree@vger.kernel.org
Subject: [PATCH 05/10] of: property: Provide missing member description and remove excess param
Date:   Thu, 18 Mar 2021 10:40:31 +0000
Message-Id: <20210318104036.3175910-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210318104036.3175910-1-lee.jones@linaro.org>
References: <20210318104036.3175910-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/of/property.c:1239: warning: Function parameter or member 'optional' not described in 'supplier_bindings'
 drivers/of/property.c:1366: warning: Excess function parameter 'dev' description in 'of_link_property'

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: devicetree@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/of/property.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 23816959c6966..c000ed01db018 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1225,6 +1225,7 @@ static struct device_node *parse_##fname(struct device_node *np,	     \
  * @parse_prop.prop_name: Name of property holding a phandle value
  * @parse_prop.index: For properties holding a list of phandles, this is the
  *		      index into the list
+ * @optional: Describes whether a supplier is mandatory or not
  *
  * Returns:
  * parse_prop() return values are
@@ -1344,7 +1345,6 @@ static const struct supplier_bindings of_supplier_bindings[] = {
 
 /**
  * of_link_property - Create device links to suppliers listed in a property
- * @dev: Consumer device
  * @con_np: The consumer device tree node which contains the property
  * @prop_name: Name of property to be parsed
  *
-- 
2.27.0

