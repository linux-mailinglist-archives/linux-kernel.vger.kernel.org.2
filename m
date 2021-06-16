Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 844653A8F90
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 05:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbhFPDrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 23:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbhFPDrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 23:47:19 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41FEC061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 20:45:12 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id n12so818892pgs.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 20:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qZAMt39F+7byqkAIexvy69WT9Fvb342b3olR3zb2aF8=;
        b=16YWK9v/Ls1KOn+ohJLHjWuqcSlboDWnz57yF1ddlc179tKZjh4xG6Yrypm3XJxqNO
         Zh5zR3VMSbzBqlZwzDmfpFEUEJeh3oyd7Rmex855LpzdWhs8hVEC2B1HTyZucXwbz2ty
         bQ/DwyfkGaoxXVwfinqQDk+AgO0X4FxUd5hbCYdJfCQF/qa+1I166X86hdasuOg7Cx+E
         UDvNDmZolR5IbN2KezpH/QH4sfYIm+719jJ/wHsug01TzOTqXIR+pO13IrB+bAC56PW/
         ZijD1ZLW64yWk4ynuewyZ2OKQTmG5CVNZFniJaLM964JgcwjkG331HehZxabFj9N/7Sd
         zJRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qZAMt39F+7byqkAIexvy69WT9Fvb342b3olR3zb2aF8=;
        b=Eytwb+H1iHZvVA0NtGDfPOB6ww8sc1NsQ3xHZax6RrUPzmdkAzun+Z4BHa7uDFMct5
         K3eNawUxWJwMKPCyvqOFyO6ymapJEGdsOsV/Qzee4SKTYm20RCg4R4pgNxkswJ7k/53k
         9Ay/L39losWcITa353fjD15SUX4t+Et9SJaNC+GkDhQtbnexZg1dGe+GOwLx88bUokqL
         ho5MpjbGUskb22xdJbI+ufe1FnwEIxm50WF4peHDGi29fcpr2jTW3P2mQdYpPdL9J1aK
         jha57Cqg5a26hqEvPFzFyP+P0H32dAq5Ay/i3w415KmpTBjn+Jb1YW7mx1+XnmwXJord
         JMew==
X-Gm-Message-State: AOAM53326uQNQ2s/m65RHGlc/gt0+ALOmBs+e9LkWGxetdOoT8cMmUkj
        EQ6Ezz/lYPHum7+mgLdvpbVCbw==
X-Google-Smtp-Source: ABdhPJzQzAE2IF9ag625rfgdmhWpWU+9A6Dgrq8w0PB7peyKVDu7BauY86pCbDGWVDNTlQw7UitfsA==
X-Received: by 2002:aa7:8bd6:0:b029:2ec:7dc9:77e3 with SMTP id s22-20020aa78bd60000b02902ec7dc977e3mr7578756pfd.62.1623815112412;
        Tue, 15 Jun 2021 20:45:12 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id s4sm528925pjn.31.2021.06.15.20.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 20:45:12 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Alistair Francis <alistair@alistair23.me>,
        Lars Ivar Miljeteig <lars.ivar.miljeteig@remarkable.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 3/3] regulator: sy7636a: Use rdev_get_drvdata at proper place
Date:   Wed, 16 Jun 2021 11:44:58 +0800
Message-Id: <20210616034458.3499522-3-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210616034458.3499522-1-axel.lin@ingics.com>
References: <20210616034458.3499522-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the context with *rdev, use rdev_get_drvdata() is more intuitive.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/sy7636a-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/sy7636a-regulator.c b/drivers/regulator/sy7636a-regulator.c
index c71c0a007d95..e021ae08cbaa 100644
--- a/drivers/regulator/sy7636a-regulator.c
+++ b/drivers/regulator/sy7636a-regulator.c
@@ -35,7 +35,7 @@ static int sy7636a_get_vcom_voltage_op(struct regulator_dev *rdev)
 
 static int sy7636a_get_status(struct regulator_dev *rdev)
 {
-	struct sy7636a *sy7636a = dev_get_drvdata(rdev->dev.parent);
+	struct sy7636a *sy7636a = rdev_get_drvdata(rdev);
 	int ret = 0;
 
 	ret = gpiod_get_value_cansleep(sy7636a->pgood_gpio);
-- 
2.25.1

