Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B96913570B2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 17:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353713AbhDGPpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 11:45:02 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46159 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234273AbhDGPpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 11:45:01 -0400
Received: from mail-wr1-f70.google.com ([209.85.221.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lUAMN-0008Jr-AK
        for linux-kernel@vger.kernel.org; Wed, 07 Apr 2021 15:44:51 +0000
Received: by mail-wr1-f70.google.com with SMTP id o11so11950517wrc.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 08:44:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9EX0oJuIPTlyrUHwCW2RoQVN/W0NPpMkkUa4pAX++3M=;
        b=rS8ledVG9d8DUzXgaSSsSrPcPa+mzP5gt4DYVX9cx47aoojXDEJZne4VEwHh9IOln3
         5L9SwAG+ZvndShYsiyES1rYq5OXLzHgmqchUkzNcTRil9hM24dCj26ZzbN3LKO97IITL
         nWsxVrTyJplqswuZ5gsqbf4sA5Pn163SxaDF2t2//YBsl7O1boeKpRtKYpsUaVY+IhT/
         3PIKi7WrXvAqB/KiPblRRxsveoNQLL1p3o2WwS8zJzIHIkhJCtnMFY5DSK8W4Isqme6U
         Kv4UWsakJ/1VS7/8jfanJ9AJpUMLdtAPua/FQxO9trbxaSiKxnpzAC+dOHMX8ioctUH/
         UU8g==
X-Gm-Message-State: AOAM530/SnNSpePXMHbk+kcWQdjejysa5V1PN8ahONXzi2820wmGLW42
        z5Atz5vyseqWMArYKpzGjBCXvUrFYfvDQVhBKvaM4GPJbnFQdeXbt/vCmDbjquveEFZ7PubGuL3
        qYVbvfHHW9fASk9lOlfLSUGOEDngbV4rY6L1XognOwA==
X-Received: by 2002:a05:600c:2204:: with SMTP id z4mr3823530wml.31.1617810290750;
        Wed, 07 Apr 2021 08:44:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx7xb9h76f7b9Tp3JA2d38ti9Ye5g/SZvmbRjglwnvmdKmGySLplxEx4QXb1fRjd7imYs7p+g==
X-Received: by 2002:a05:600c:2204:: with SMTP id z4mr3823522wml.31.1617810290655;
        Wed, 07 Apr 2021 08:44:50 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id w3sm8644492wmi.9.2021.04.07.08.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 08:44:50 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] memory: atmel-sdramc: check of_device_get_match_data() return value
Date:   Wed,  7 Apr 2021 17:44:47 +0200
Message-Id: <20210407154447.70540-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the driver is probed, the of_device_get_match_data() should not
return NULL, however for sanity check its return value.

Addresses-Coverity: Dereference null return value
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/memory/atmel-sdramc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/memory/atmel-sdramc.c b/drivers/memory/atmel-sdramc.c
index 9c49d00c2a96..e09b2617f63d 100644
--- a/drivers/memory/atmel-sdramc.c
+++ b/drivers/memory/atmel-sdramc.c
@@ -45,6 +45,8 @@ static int atmel_ramc_probe(struct platform_device *pdev)
 	struct clk *clk;
 
 	caps = of_device_get_match_data(&pdev->dev);
+	if (!caps)
+		return -EINVAL;
 
 	if (caps->has_ddrck) {
 		clk = devm_clk_get(&pdev->dev, "ddrck");
-- 
2.25.1

