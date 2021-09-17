Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A301440F4C2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 11:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240099AbhIQJ1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 05:27:50 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:48692
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240126AbhIQJXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 05:23:10 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BC0DA40293
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 09:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631870492;
        bh=UKlAzsdkGy5Ivo7U8LqMCGMJPYyzm2idKi8StxjfYyY=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=R+Pia2VCSZ6nVJfvuTDyaGg6x4w0+FIG87PqfG27HEzG6/p0fTw4xKfAtH7HnJSdf
         LUKasLMs3QoEKohAfzcJJxBaDVnPJTu4Q6Iilz+sqw5Myi9xPR2Mv2aVd0LmmOrEET
         yBRFqm/3I5e5F6t1eZSpNAIPOdQAheK+McusGq+vLMAA826xb0cTufQ8ko2fAg6esd
         qhRiBqM1y/QXC/z0orOY6row/LzpqIxZ5YunKqe+4y/nBurfs6t4a2j0dr+utHFwAu
         4SwcUL1GAx4nRFy6drMOaa7nDRGkhKAkNz/ATNitwiL7K80T72lumX4AEDnfLq6+eR
         AwHVFx6AgDfLw==
Received: by mail-wm1-f69.google.com with SMTP id g18-20020a1c4e12000000b002fa970d2d8dso1624855wmh.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 02:21:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UKlAzsdkGy5Ivo7U8LqMCGMJPYyzm2idKi8StxjfYyY=;
        b=8QymHfPiSG/rJDBaJPxnEOUJMEsRD2U7T6Ydg3PHuTVJPt/BThdTty28/TRBTpXENf
         1ESNiUuMS5zO0SbaKB6Cqjql0ydgZ13QA8/PfI+XXRaDiyw/ISebePeurMZMI33553v2
         onGG4G174dVhmW2zS4o4cH1xl/jO/909m8iQWBF29SUX+leZcd1266rbM4r9zMrBYVBM
         uiDjCUKAlh43Av12muD5k8CQuE8EaK5AbYo9COlSiwR/ZcNJxkP400TG96SfdPPxlFqu
         50+yf+tAYNAy3IPbDjPZmLZMVysVJt8onBtmzpRVQUnWjx4C5VNwrKdxFoNVEHI/SAhR
         ZZlQ==
X-Gm-Message-State: AOAM533EqafIPT25VxQXx+1c3yeHCO8LQuGTYA0jRhe4G7nl8Fq+8Ltn
        9H0etI7UY8+g9GFyI8377EHXEou60H51DCEimCfKkOAuDmtJSaKXnpYk655ArHQSp8F3PnqRlBR
        bwKfNdO6lcKzwaMmyAYvKGG3X7zv9VohHmvt3Ui2KdQ==
X-Received: by 2002:a7b:c5d9:: with SMTP id n25mr14401831wmk.120.1631870492300;
        Fri, 17 Sep 2021 02:21:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxvrZ0a3+0hizOcHHHoNzf7uUykimEKLTwGtpiSFv+u0RBZBQt8E/GTu0Xp+bUAKXnJWE810w==
X-Received: by 2002:a7b:c5d9:: with SMTP id n25mr14401813wmk.120.1631870492165;
        Fri, 17 Sep 2021 02:21:32 -0700 (PDT)
Received: from localhost.localdomain (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id c17sm7516772wrn.54.2021.09.17.02.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 02:21:31 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH] net: freescale: drop unneeded MODULE_ALIAS
Date:   Fri, 17 Sep 2021 11:20:58 +0200
Message-Id: <20210917092058.19420-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MODULE_DEVICE_TABLE already creates proper alias for platform
driver.  Having another MODULE_ALIAS causes the alias to be duplicated.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 80bd5c629fa0..ec87b370bba1 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -4176,5 +4176,4 @@ static struct platform_driver fec_driver = {
 
 module_platform_driver(fec_driver);
 
-MODULE_ALIAS("platform:"DRIVER_NAME);
 MODULE_LICENSE("GPL");
-- 
2.30.2

