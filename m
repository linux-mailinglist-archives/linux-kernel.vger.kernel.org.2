Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3EB399E20
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 11:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhFCJxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 05:53:01 -0400
Received: from mail-pg1-f174.google.com ([209.85.215.174]:37735 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbhFCJxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 05:53:00 -0400
Received: by mail-pg1-f174.google.com with SMTP id t9so4720429pgn.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 02:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k94usgXa6GClLbJt1Mq5SUGlAvC85kxew1BESlY3ZIQ=;
        b=aM1D5TltwyXFGp+goF4UEPmGGv4wTw3PVJuLDCUfEM3Hk5wgN/fwQteO/x4toI/APg
         0hmYNMaH8Xo1k5YqPcguJgaeq2tHs7JUqRRuGH025fiV8nmlhg4kdQcCwhKh5ZBgJm+u
         anU2uYwT73pUni596NIi2UDz6WX7nlr+/GfprkJfqgw8Q9ITJL3C4aK7nlJ/Hk5Q8tLP
         GyOnpwJiy2dhnNS1cyUPuU2RzK0NfODsZb50qS/9gshq/0rOwMOLyi895uLVVkimemjL
         OMFDkjPzLD3u93QFnco/kxvLx9WOIiZGc/T4bTHuSvoFlKF7lJGo32On3cFtPdvxY0B/
         XyAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k94usgXa6GClLbJt1Mq5SUGlAvC85kxew1BESlY3ZIQ=;
        b=aI/5FewcQGBpzsiOyU2nhj4KwmulMlNMhrO5dBYDsCNncbHcQJyfyaZd3FAC32tyyR
         0iOboo/KB80l9tGvFbXLTDmwqw8la3pZkPi9HS8VdK/71ZEY0v5XuR0QJMJLKd46RpBD
         FXGhjR0dGinUbnuogxD0B6wDAP2GagsFcEYshQw35kylQX4octqvFskfHdw4q5nE/jaG
         ga9kkLCQ/jDL3J94mpJsUTLsqo5KXqgOZx7aSFIqDIUscNJm6XH8GAZqyiBE8gJ1zIze
         iHoBZprSIG4IHfwI9/GdMn9QOkxZW8oEZSS/YslkUNRx3rWa7eoI10cgDOR41UdB5Ifk
         JlmQ==
X-Gm-Message-State: AOAM533jN1aQce+NxfB3NZ3G8WnXt1/lu0jJS7uZKPDNtBQjXPktuS/7
        6iPX6siWH7U+8swjGuLF5lVvDVQnGsKv3il8
X-Google-Smtp-Source: ABdhPJwuskZG29/Bhl0gqq9u2qjB6iyKLWhZA/s/MzQbT99HVvZ0n7T9F+pO0W3iLomxsYWqENu8jw==
X-Received: by 2002:a63:ba18:: with SMTP id k24mr6163796pgf.65.1622713804165;
        Thu, 03 Jun 2021 02:50:04 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id b20sm2055194pgm.30.2021.06.03.02.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 02:50:03 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     ChiYuan Huang <cy_huang@richtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: rt4801: Fix NULL pointer dereference if priv->enable_gpios is NULL
Date:   Thu,  3 Jun 2021 17:49:44 +0800
Message-Id: <20210603094944.1114156-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_gpiod_get_array_optional may return NULL if no GPIO was assigned.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/rt4801-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/rt4801-regulator.c b/drivers/regulator/rt4801-regulator.c
index 2055a9cb13ba..7a87788d3f09 100644
--- a/drivers/regulator/rt4801-regulator.c
+++ b/drivers/regulator/rt4801-regulator.c
@@ -66,7 +66,7 @@ static int rt4801_enable(struct regulator_dev *rdev)
 	struct gpio_descs *gpios = priv->enable_gpios;
 	int id = rdev_get_id(rdev), ret;
 
-	if (gpios->ndescs <= id) {
+	if (!gpios || gpios->ndescs <= id) {
 		dev_warn(&rdev->dev, "no dedicated gpio can control\n");
 		goto bypass_gpio;
 	}
@@ -88,7 +88,7 @@ static int rt4801_disable(struct regulator_dev *rdev)
 	struct gpio_descs *gpios = priv->enable_gpios;
 	int id = rdev_get_id(rdev);
 
-	if (gpios->ndescs <= id) {
+	if (!gpios || gpios->ndescs <= id) {
 		dev_warn(&rdev->dev, "no dedicated gpio can control\n");
 		goto bypass_gpio;
 	}
-- 
2.25.1

