Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61B6B3A2E6B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 16:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbhFJOkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 10:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbhFJOkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 10:40:46 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BACBC061574
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 07:38:36 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id md2-20020a17090b23c2b029016de4440381so3963753pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 07:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=OK46pHpOVUybV/KZ7Bt0/6twU6Juk2lFFYoymsWHjFU=;
        b=mqn8i2X5UjF3efV1fcihguqArksnqikAXUozAMs915tW/2TRQPANEdHlX72O+4OeVL
         X91iD7my4fhkBOm7T7mYutAvUEhu+2qKOKr7P13wut0zz6B8012e+6yMX/xaITqcvuwD
         WbK4nnnoNG6sRY/YsXXxnlG0gtsEXPxNzXJVLGN0dztwa/dTQ8jDUiEFWsCoDiNnvIWJ
         Pq27jB7yfLHTGg6jSxP7syTCoaGuQHmq07WHbvY5jGWV/GlINgpklt26ho6Fr1RRdw9I
         wLTxRGji8JB6lREuvAPEKzTxliiG9/ZfBK92NbA/J0m6JpwZA/m1QF7avwCuYxNEY4Xm
         rOwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OK46pHpOVUybV/KZ7Bt0/6twU6Juk2lFFYoymsWHjFU=;
        b=sJWOPBwTJwx2FfH+bGRguNwBH9YeZMCcf+WYhd39wA0ECUQWjSmckqaZjI10dWg/RD
         Q9GSxbnStp9OnHcgtPxCruNC2+6p1rUVK4VVVbLyfqKDk0zc+CanYfyZkvsaO8bXQIjj
         xPDwebOeMK6irRJCAuftNlYHR+qcED2hCEFJ7g4ySPv24YuaAzp35OTiwbirQHkRgdRM
         MCk5O0MhPyXup2mGjK0d247a+99GFMYPS8J0nfsBxT5TDeWQK7prvjUzZAMExNRaxtmA
         Lewi14TRU1ScFunZuRbSCL0+Tm9Vwh3Lk/c0MAM/Jr952g9gqRMT7LfbhyxbpxlGGRxh
         PplQ==
X-Gm-Message-State: AOAM531Y3SEIF9YozPaBusxreQEY9GUgobr0QUTnMOD27jOjLa40Aqpi
        X3EXZ39mysSF1sSPaKg+bCI=
X-Google-Smtp-Source: ABdhPJxZffbd8uclwb0dPtIQo728xidTXFks9EpawsMixanY5NR9TQDc4Foh7F6h5DwAz0PCEDrGnQ==
X-Received: by 2002:a17:90a:a40a:: with SMTP id y10mr3619826pjp.151.1623335916065;
        Thu, 10 Jun 2021 07:38:36 -0700 (PDT)
Received: from localhost.localdomain (1-171-3-218.dynamic-ip.hinet.net. [1.171.3.218])
        by smtp.gmail.com with ESMTPSA id g204sm2693864pfb.107.2021.06.10.07.38.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jun 2021 07:38:35 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, cy_huang@richtek.com
Subject: [PATCH] regulator: rt6160: Remove dummy line and add module description
Date:   Thu, 10 Jun 2021 22:38:30 +0800
Message-Id: <1623335910-5385-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Remove dummy line and add module description.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 drivers/regulator/rt6160-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/rt6160-regulator.c b/drivers/regulator/rt6160-regulator.c
index 4588ae0..1d18e4d 100644
--- a/drivers/regulator/rt6160-regulator.c
+++ b/drivers/regulator/rt6160-regulator.c
@@ -77,7 +77,6 @@ static int rt6160_disable(struct regulator_dev *rdev)
 	gpiod_set_value_cansleep(priv->enable_gpio, 0);
 
 	return 0;
-
 }
 
 static int rt6160_is_enabled(struct regulator_dev *rdev)
@@ -328,5 +327,6 @@ static struct i2c_driver rt6160_driver = {
 };
 module_i2c_driver(rt6160_driver);
 
+MODULE_DESCRIPTION("Richtek RT6160 voltage regulator driver");
 MODULE_AUTHOR("ChiYuan Huang <cy_huang@richtek.com>");
 MODULE_LICENSE("GPL v2");
-- 
2.7.4

