Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80FF1312B4D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 08:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhBHHz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 02:55:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbhBHHz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 02:55:27 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4EB4C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  7 Feb 2021 23:54:45 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d13so7393408plg.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 23:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wS78z2DGzZxHA2vV2iZc+QYltD449KPzaCG39iIKaiw=;
        b=OkRR34sqJBhvubTylHIh6sfTyq+rOJmudymq3iITTzzuwTfAcOqOHA3QA6UfoiyoGV
         xHz431jIXhJzaRIC+/j433ndm1OwxSd0anzS+hh5sneJ6EoD/P7HwwmjX1DMCSLff6H3
         yP75OQjOm7LhfRV0JzXPFtcuyGXs/BDEoP7NMALtLoAKt47Sax7Cixp9HYE09pW2hMaz
         MijZR1HJiObHxT8q0KpBFLeNXZunjdCqDoGQoiHLlpau/vUQxt5S5qvvK6Ei1oBk0kck
         CZwDMZtojYJqZKAEDMPX73lgyNbYn0vk9XdoOIRrFs3/ria3UrQrUw71mvSWAC1V0nU8
         Z0Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wS78z2DGzZxHA2vV2iZc+QYltD449KPzaCG39iIKaiw=;
        b=cMmHkM5Tia5vRkq2Gvx3dzdYuLs+4zsnRJxEyJZupvwOgJ8DCDZNjBH8HhZYSnhAU2
         TA/Bpanlykw2Z8NZayXG7OGwBJONJSBKNN1Tm1Bz2+BU0k5r2kRzUZtVqOukpYSq2DhC
         sY9/jqiZ+qiiFfxygPLn5UwFctj+NgqlxK/55T6hxn6drZByUVe4HUR519Hf6mwOdVuK
         eXHgwDhRwjV65m0jQZy4QPSVX/PG+gqdkBbVdn1dPy8nuB6pmyQnk/7k6KknH0KPzSR3
         pCHP+3bYdximpyA9EYFzkedAUVlKA0bkBmJ1C5e8CZI4F5JUGeMK+cyX0iEfXqd1S7nH
         FP0A==
X-Gm-Message-State: AOAM531spZEuApyUb4T9QxaLIMAJaNY9UXRqLlhTeG2UAyhTwt29Xgyk
        hBcwuH3dRpVYWLq0utTmR3M=
X-Google-Smtp-Source: ABdhPJzaSEUP15ABwV/65132kurRfLzuYpf1pIoVwXe7KXDzHN2cJK9ECwD4cIJsOIPhwzVXnMVRuQ==
X-Received: by 2002:a17:90a:4297:: with SMTP id p23mr10594796pjg.213.1612770885436;
        Sun, 07 Feb 2021 23:54:45 -0800 (PST)
Received: from an990131127 (42-72-181-6.emome-ip.hinet.net. [42.72.181.6])
        by smtp.gmail.com with ESMTPSA id b24sm15106613pjp.12.2021.02.07.23.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 23:54:44 -0800 (PST)
From:   Shuhao Mai <shuhao.mai.1990@gmail.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Shuhao Mai <shuhao.mai.1990@gmail.com>
Subject: [PATCH v2] mtd: spi-nor: winbond: Add support for w25q512jvq
Date:   Mon,  8 Feb 2021 15:53:03 +0800
Message-Id: <20210208075303.4200-1-shuhao.mai.1990@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201111014556.6579-1-shuhao.mai.1990@gmail.com>
References: <20201111014556.6579-1-shuhao.mai.1990@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for w25q512jvq. This is of the same series chip with
w25q256jv, which is already supported, but with size doubled and
different JEDEC ID.

Tested on Intel whitley platform with dd from/to the flash for
read/write respectly, and flash_erase for erasing the flash.

Signed-off-by: Shuhao Mai <shuhao.mai.1990@gmail.com>
---
 drivers/mtd/spi-nor/winbond.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
index e5dfa786f190..b1d307fcdf9c 100644
--- a/drivers/mtd/spi-nor/winbond.c
+++ b/drivers/mtd/spi-nor/winbond.c
@@ -97,6 +97,8 @@ static const struct flash_info winbond_parts[] = {
 			     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ "w25m512jv", INFO(0xef7119, 0, 64 * 1024, 1024,
 			    SECT_4K | SPI_NOR_QUAD_READ | SPI_NOR_DUAL_READ) },
+	{ "w25q512jvq", INFO(0xef4020, 0, 64 * 1024, 1024,
+			     SECT_4K | SPI_NOR_QUAD_READ | SPI_NOR_DUAL_READ) },
 };
 
 /**
-- 
2.20.1

