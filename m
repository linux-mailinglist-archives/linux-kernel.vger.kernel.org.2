Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2188839180A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 14:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234743AbhEZMzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 08:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234880AbhEZMwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 08:52:54 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB550C06138F
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 05:50:35 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id b15-20020a17090a550fb029015dad75163dso298788pji.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 05:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GnXwfLtw2Q1TBwGGy8pHIDq6LASt4EwjW66rshDycSk=;
        b=kimfbq85kHcukjerh8dyAAFcWdmfcMRDJ3aFjvSJqWM1mUmrI3BJ4A8MDSwScZT4Gs
         H2KGVrmWAfL+WsDp/oA6lWPR+C42XL+wEBc4/39f5IBKP53gzTYMCBidG/VD4+v95ujg
         1tns9xss+CvDl4B7kGvOM6bhmCkNifhySYRGhOnRbtBdS7Ao18jI/nXiwWtOj5V6V6aP
         0/HTys1Izs9Mz2A/+Yw/AZSDDczCpnu8ay+2/HF8Nr/QiYF7zQL3tR26g6zFVBGNZCJr
         P3v6i0joLZHkQiv/qwJnVuQL+nkvsWYiyjLM8IsM76xGKSjCGM7CucrrWIgevT7ba4H1
         tN7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GnXwfLtw2Q1TBwGGy8pHIDq6LASt4EwjW66rshDycSk=;
        b=H/AG+R7Oua+u5ieQw4PG4615z5raHJLyN52lbfnw7QDQf6EVUYoXn4/c3ekBwudA9A
         nzThb5jGrRiVhrcvfA76shMQK1Kvn2QpbMhx3LHluNCKMfd0PnMRzEJ4nX9dFATXwHOU
         eoXpuvYnM9YKp2WQhswnmbo43I2KW91S5MRaZCgnSr3837Sdwd7LHpUjQccB6vUCBWWM
         Hvk5Dd2TVNIcsCFlViC0aDFqL/pZbJk9+I8riksDeMvYLRpkMGmic824o3XmEpAC30Kr
         oycaXoHm9k0Pzcrqyy7DaRX9EINjKehl8JyoSKJVhN1HKxHYdFxOecZelERV1RXEWwhw
         tjDg==
X-Gm-Message-State: AOAM533ZRN9qPOwqYoUODsX2xfFo5IroJPY3hbsIF6Lrg9LpuSSpsUFe
        ly3NFbspF5hJ2OrW/4Cj5RGXBg==
X-Google-Smtp-Source: ABdhPJwsRY5+LYkbQRoTzXbyYgi/4arnPZPf8rdar6E0jxcy/2g2jliDUPG1OgIpgPdU5oNtzviC1w==
X-Received: by 2002:a17:902:b109:b029:ef:1ee:9d02 with SMTP id q9-20020a170902b109b02900ef01ee9d02mr35921846plr.85.1622033435312;
        Wed, 26 May 2021 05:50:35 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id m1sm16579659pfb.14.2021.05.26.05.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 05:50:34 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     "Andrei . Stefanescu @ microchip . com" 
        <Andrei.Stefanescu@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] regulator: mcp16502: Convert to use .probe_new
Date:   Wed, 26 May 2021 20:50:25 +0800
Message-Id: <20210526125026.82549-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new .probe_new for mcp16502.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/mcp16502.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/mcp16502.c b/drivers/regulator/mcp16502.c
index 88c6bd5b6c78..ac1b129e33d9 100644
--- a/drivers/regulator/mcp16502.c
+++ b/drivers/regulator/mcp16502.c
@@ -522,8 +522,7 @@ static const struct regmap_config mcp16502_regmap_config = {
 	.wr_table	= &mcp16502_yes_reg_table,
 };
 
-static int mcp16502_probe(struct i2c_client *client,
-			  const struct i2c_device_id *id)
+static int mcp16502_probe(struct i2c_client *client)
 {
 	struct regulator_config config = { };
 	struct regulator_dev *rdev;
@@ -606,7 +605,7 @@ static const struct i2c_device_id mcp16502_i2c_id[] = {
 MODULE_DEVICE_TABLE(i2c, mcp16502_i2c_id);
 
 static struct i2c_driver mcp16502_drv = {
-	.probe		= mcp16502_probe,
+	.probe_new	= mcp16502_probe,
 	.driver		= {
 		.name	= "mcp16502-regulator",
 		.of_match_table	= of_match_ptr(mcp16502_ids),
-- 
2.25.1

