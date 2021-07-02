Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 875B43BA144
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 15:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbhGBNdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 09:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbhGBNdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 09:33:50 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E69C061762
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 06:31:18 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id m9-20020a05600c3b09b02901f246b43bbeso6394806wms.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 06:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=/PCl/PleBZTsH8zunBgGuzFmk4Ca8Tvt5r3eo4Zy03A=;
        b=Zvx4trx0T5UUwwZc7zAID+VpfV4MTSM07xo4EQdejZ85cTy0hG2qt+Hd3JshkaF+zs
         n4Ux9Ae59nC3Ibr2ZPEU7ncgILO2x6tgcFcSm5WB5QDV9r3HD95q6wrKZuB8X5tZEGNd
         RBJ5Xqt8uwSXkk7qiIkVW5eiGVXBeL3Jxnq/O62lWT5dUZPUpso9wmVH2ml7QNDxXfaL
         W9dZLEX89MyLBJtAZgaJ+C34ZelqExiLUzfHIVbcHnfJaWa+sBCEVhAQshWC38YVJTvl
         /dz2mrp8My/++kkWiqEU/Lj6xSku5vHRnNIe5+KCGV3D8VNawr/2RXkcIkZWEA9XuOv8
         bnCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=/PCl/PleBZTsH8zunBgGuzFmk4Ca8Tvt5r3eo4Zy03A=;
        b=RVz3caUJp/6YaFMaDljyeDAEwMfA0qbpsLLCuy6GJJlCXsMKxIO0CQS3cG4yxc5d5f
         AjAtJN/H+F3tc1j5hHOEZnhOcTBJjkkjco4bF4f9LQnMeI4A4BqRP/zUIt9CvrXLG2hN
         yZm3UJi0hUH5fu6GGcuSqGVuf1FqSoY1/PnesAT38we7OQtsqObVA8Sf5fkandLKn4Pq
         3a4TDTrj2HpDcYsIyxFnmwfindJDh3ZDPMjG+bT1ft5Fv4YvuHccL2zrpFmD5ut+J1v1
         5wZYL1bXKAONq+1b/anjmGvzI9TCoo6EGqzqHrZJ1k+po0gMSZaLmTv8VC64MYa8yLVa
         duOg==
X-Gm-Message-State: AOAM533tvt+wc+dIOvucPuAquLzqcJli9tGEXXoRueDIGrrNVOqMZgRr
        N5QFJvJ3TdymdSFTizqGr3KRPy4r+9NHvA==
X-Google-Smtp-Source: ABdhPJyR66t2BH5Bcr1W97j/O5McPmsjUNy5/8db3to3P3ejLL+VMeyjxmdIaUICbXIbVQROon85RQ==
X-Received: by 2002:a05:600c:1c2a:: with SMTP id j42mr16265842wms.173.1625232677015;
        Fri, 02 Jul 2021 06:31:17 -0700 (PDT)
Received: from pc ([196.235.73.129])
        by smtp.gmail.com with ESMTPSA id y20sm12422210wmi.31.2021.07.02.06.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 06:31:16 -0700 (PDT)
Date:   Fri, 2 Jul 2021 14:31:14 +0100
From:   Salah Triki <salah.triki@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dio: return -ENOMEM when kzalloc() fails
Message-ID: <20210702133114.GA314157@pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return -ENOMEM when kzalloc() fails in order to inform the caller of the
failure.

Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
 drivers/dio/dio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dio/dio.c b/drivers/dio/dio.c
index 193b40e7aec0..4c06c93c93d3 100644
--- a/drivers/dio/dio.c
+++ b/drivers/dio/dio.c
@@ -219,7 +219,7 @@ static int __init dio_init(void)
                 /* Found a board, allocate it an entry in the list */
 		dev = kzalloc(sizeof(struct dio_dev), GFP_KERNEL);
 		if (!dev)
-			return 0;
+			return -ENOMEM;
 
 		dev->bus = &dio_bus;
 		dev->dev.parent = &dio_bus.dev;
-- 
2.25.1

