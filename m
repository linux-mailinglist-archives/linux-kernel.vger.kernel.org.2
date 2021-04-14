Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE8B35F5AB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 16:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233316AbhDNNzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 09:55:51 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:44694 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbhDNNzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 09:55:49 -0400
Received: by mail-oi1-f181.google.com with SMTP id e66so5361070oif.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 06:55:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ygW7Y65vTGdNrKvd3IqSOUFhu0nUjAAUwu38bD6lMsg=;
        b=eBtvr4fDRv4QLoyW7gzRdFfRnFHjn2cWtF02oX5QbOwQ11/wPtwyQZw1c79ZWekeFN
         a3GfMkrAs8xBOvQUwjWNr8AiL3HMGPiPHqXn82nHURRUjr/kFgpB/k40JU0eV708F88s
         VUkBH2PQsdro47/VdSl4lRXutKtiCnrQO3p8KXSWCyoSx68kgSubgmbylJL5m784cUdR
         pVYtQg4Ajs/KrFt9aBRpz5jREjhk5UM/QCozZZdYi45nHXM4u4kRl1h1LTWoOG7wlCx7
         wlfESMtBj9JcBVLrjSrXmKui5p79XIaYq0L+HjQBXmhP9B3tR1t+iojPtKrFdP8Nzc53
         Eoow==
X-Gm-Message-State: AOAM532UDjWONeSHg3xSNaggUdU+QWjjaxOrniT9qJCIvzNbiA6N+pm9
        f8WdI49+tc9LmEUneemUuYKae+hzxg==
X-Google-Smtp-Source: ABdhPJzYu8oC6yjlWl3YieIDUJ08MnRI14+kL1+dtSXuy8xm5ha1sTX5idQ4ykdZEwGdeqV8w0vRbg==
X-Received: by 2002:aca:df08:: with SMTP id w8mr2534923oig.126.1618408527949;
        Wed, 14 Apr 2021 06:55:27 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id y2sm3154007ooa.10.2021.04.14.06.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 06:55:27 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Aswath Govindraju <a-govindraju@ti.com>
Subject: [PATCH] phy: Allow a NULL phy name for devm_phy_get()
Date:   Wed, 14 Apr 2021 08:55:25 -0500
Message-Id: <20210414135525.3535787-1-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For a single PHY, there's no reason to have a phy-names entry in DT.
The DT specific get functions allow for this already, but devm_phy_get()
WARNs in this case. Other subsystems also don't warn in their get
functions. Let's drop the WARN for DT case in devm_phy_get().

Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
Note that I think the device_link_add later on is now redundant with 
fw_devlinks. If so, this can be simplified to just calling of_phy_get() 
for DT case.

 drivers/phy/phy-core.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index 71cb10826326..3e4971253ec1 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -667,16 +667,18 @@ struct phy *phy_get(struct device *dev, const char *string)
 	struct phy *phy;
 	struct device_link *link;
 
-	if (string == NULL) {
-		dev_WARN(dev, "missing string\n");
-		return ERR_PTR(-EINVAL);
-	}
-
 	if (dev->of_node) {
-		index = of_property_match_string(dev->of_node, "phy-names",
-			string);
+		if (string)
+			index = of_property_match_string(dev->of_node, "phy-names",
+				string);
+		else
+			index = 0;
 		phy = _of_phy_get(dev->of_node, index);
 	} else {
+		if (string == NULL) {
+			dev_WARN(dev, "missing string\n");
+			return ERR_PTR(-EINVAL);
+		}
 		phy = phy_find(dev, string);
 	}
 	if (IS_ERR(phy))
-- 
2.27.0

