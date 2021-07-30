Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3A43DB8A7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 14:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238747AbhG3Mcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 08:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbhG3Mcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 08:32:31 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499B9C061765
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 05:32:26 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id m10-20020a17090a34cab0290176b52c60ddso14044663pjf.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 05:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Kb9IraGhKwT6RidXp81kh1OsSb2GCIJGYr2MMl3GBxw=;
        b=FIcaN8Ma217s/gfnNCB119R8rmPs3MPcodijs1LdpV4RP41X+EJjVHjbwIo1DZTxEa
         3SshSYx3Lmn8w6QgWlOqkZ29/ybFjFFR/oH7cD04rIZo9VyCoA/6WlUrXk6PbAYoOlfQ
         ahrDWJam/Lr+Q7K6NYQRrR3GSmlN8ULhYzcaMu1NNqXow5R10fzI5LS6W9dYFRE2x46B
         syGqwgUiyfY5Jvpibz37QhG/i1dEWwW1d6g1BsL6MXlJUo/GNCibhVu8XnR2eqrt3uGr
         k3q/t9Xb/yZvlnKQMYg5vZ/hG9rk9HkT5GDGjWIKmJYakPqgglGf2Tih0UoFDqDIgV35
         iptA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Kb9IraGhKwT6RidXp81kh1OsSb2GCIJGYr2MMl3GBxw=;
        b=b0TIs9QMseywUAlbG/qfGCXDdBhQGkaAPCfy+ZyiPPwWPunbP8bIOlPK+UbU6VkbUe
         WZNjn6Xig6guspTJbLrCaB+W3cdF4iqajDKX/A9SJD0KIF4qLciGgNrnQBupo6eXg3aF
         s1IsoV1tMQhmRQcU/quMlU6WPlfuxdnQ42KKw7BEnZYU2Z4tTciLmzKME0L25YTaGeyE
         1ox04n4voM2TwZxNAsBdBBgkt4abk2LD7SQspAOsmjv5w3kkxtDoDnup/64qxZ3TfbTq
         Ghg5e6jXTPokGYjPlrWJZB9g+AnGoDecHqgaFsG7FI2LTZQ2fp/eeG6vMONOw8C5tGIS
         j1jw==
X-Gm-Message-State: AOAM531axEU3qlYhbyEBgpJbZp9bdJmgvFBFLzua4dfUOKG+DskHB1Vw
        9BCV9cQUHsz/lcgr8zlLjoc=
X-Google-Smtp-Source: ABdhPJzfhZu6I5Qoeys6G0mWIc8uNa+0GOjbpuSjusekptnfXP9Pxq4hP5Vws4/mrzwYznFvQ9vowA==
X-Received: by 2002:a05:6a00:7d7:b029:32c:b12a:d65d with SMTP id n23-20020a056a0007d7b029032cb12ad65dmr2653107pfu.44.1627648345661;
        Fri, 30 Jul 2021 05:32:25 -0700 (PDT)
Received: from localhost.localdomain (1-171-0-100.dynamic-ip.hinet.net. [1.171.0.100])
        by smtp.gmail.com with ESMTPSA id k8sm2791798pgr.91.2021.07.30.05.32.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Jul 2021 05:32:24 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        cy_huang@richtek.com
Subject: [PATCH] regulator: rtq2134: Fix coding style
Date:   Fri, 30 Jul 2021 20:32:06 +0800
Message-Id: <1627648326-5026-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Add empty space and put constant number to the right side for 'if' judgement.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 drivers/regulator/rtq2134-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/rtq2134-regulator.c b/drivers/regulator/rtq2134-regulator.c
index e09419c..f21e3f8 100644
--- a/drivers/regulator/rtq2134-regulator.c
+++ b/drivers/regulator/rtq2134-regulator.c
@@ -311,7 +311,7 @@ static const struct rtq2134_regulator_desc rtq2134_regulator_descs[] = {
 
 static bool rtq2134_is_accissible_reg(struct device *dev, unsigned int reg)
 {
-	if (RTQ2134_REG_IO_CHIPNAME <= reg && reg <= RTQ2134_REG_BUCK3_SLEWCTRL)
+	if (reg >= RTQ2134_REG_IO_CHIPNAME && reg <= RTQ2134_REG_BUCK3_SLEWCTRL)
 		return true;
 	return false;
 }
@@ -329,7 +329,7 @@ static int rtq2134_probe(struct i2c_client *i2c)
 {
 	struct regmap *regmap;
 	struct regulator_dev *rdev;
-	struct regulator_config regulator_cfg= {};
+	struct regulator_config regulator_cfg = {};
 	int i;
 
 	regmap = devm_regmap_init_i2c(i2c, &rtq2134_regmap_config);
-- 
2.7.4

