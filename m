Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD2B3BE643
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 12:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbhGGKTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 06:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbhGGKTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 06:19:12 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A94C061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 03:16:32 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id f20so1694461pfa.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 03:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=bxwXK1JhMvhfFziMuDkIm/6Pgkc4I48pl3/wmyiO1HU=;
        b=Gt8bBMua7rTtklZ0VRRcAK7pOHejG8Bpg+Oe5uY6SdU/RH0+NjDYJVqyJ44BhtF+EK
         ZYL8qcelgHipZ6vgcH6Ilhrsq+40vixie3+Tai8xjV+b1nqtXr4gd59SgwQiSqP0JzEG
         hMHHW6SUzhufYFj5djbDQICOsxl2UOHlYGR0CIFDSyo6pwSpiySDehudOK7elCpHNVoO
         wHjXLbrwu5EcM2bd83Mtt7h8K7mYOTapcH5yKc73R2qR2uXw/NPdaDqhFV4FRIUER97r
         8Kz8wZ6BNxyroNsa4xP7gMM3SYO7kqSib6pkA/isgvFEt2s5CPsSeL3jSlXS/XVpjjL6
         OshQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=bxwXK1JhMvhfFziMuDkIm/6Pgkc4I48pl3/wmyiO1HU=;
        b=OFP4zOdJpvkNWJH3iiKSdaBHFVxHESJA2VLl2e9L6FoN1NRBz5XtNZYxBz5K4YDJdA
         7r3wlQDISSQO1ehPT7YyrA3+zLcdtbeShOXLAI5oQSbD+f3oTMdmdUrz1ZX9Z3rebB1t
         qqNVnZI2oLn/uzUkKEKmvlomC+NbMeT1tSBN2NyLMq5B0pPeZioc+9t2WQtLv8MSJvPG
         xBppAd/hhOJnFlRSTpIJbX6iiX9rTboQzYmbmLY3P2TLcPefsqISQ7L08ZZupk1GIqq3
         /Uk7QxFY72uJ7mE27GWYWKBSWKHJaur37cAit3vWENQ3dZPJds2yBYlxBqPfbCeeBYoo
         K5+A==
X-Gm-Message-State: AOAM530S2KI5OUfMn9h9CEqLNGCD8iTqti6HW4k46MXCn0EH3vQQDOz0
        RBvL0MKSB2k2PH+cZENo5kI=
X-Google-Smtp-Source: ABdhPJzX956HYYtupTL0hgHz+y3/uEBIxul319wDbl1MOUOejCkkbZnvxcJXzJX6srnd1YGEvKedEA==
X-Received: by 2002:a05:6a00:1508:b029:30a:2b2:b2ea with SMTP id q8-20020a056a001508b029030a02b2b2eamr25206318pfu.30.1625652991997;
        Wed, 07 Jul 2021 03:16:31 -0700 (PDT)
Received: from pn10-Veriton-X4610 ([49.216.102.134])
        by smtp.gmail.com with ESMTPSA id 21sm17612139pfh.103.2021.07.07.03.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 03:16:31 -0700 (PDT)
From:   Steam Lin <lstfazz@gmail.com>
X-Google-Original-From: Steam Lin <Stlin2@winbond.com>
Received: by pn10-Veriton-X4610 (Postfix, from userid 0)
        id D01AED21670; Wed,  7 Jul 2021 18:16:28 +0800 (CST)
Date:   Wed, 7 Jul 2021 18:16:28 +0800
To:     tudor.ambarus@microchip.com, michael@walle.cc, p.yadav@ti.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd:spi-nor:Update Winbond SPI NOR Flash device ID
Message-ID: <20210707101628.GA27472@pn10-Veriton-X4610>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to update Winbond SPI NOR device
ID information.
Add new 3.3V and 1.8V device in the ID table.

Signed-off-by: Steam Lin <Stlin2@winbond.com>
---
 drivers/mtd/spi-nor/winbond.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
index 9a81c67a60c6..01aa49954793 100644
--- a/drivers/mtd/spi-nor/winbond.c
+++ b/drivers/mtd/spi-nor/winbond.c
@@ -102,6 +102,20 @@ static const struct flash_info winbond_parts[] = {
 			    SECT_4K | SPI_NOR_QUAD_READ | SPI_NOR_DUAL_READ) },
 	{ "w25q512jvq", INFO(0xef4020, 0, 64 * 1024, 1024,
 			     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+	{ "w25h512jvm", INFO(0xef9020, 0, 64 * 1024, 1024,
+			     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+	{ "w25q01jvq", INFO(0xef4021, 0, 64 * 1024, 2048,
+			     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+	{ "w25q02jvq", INFO(0xef4022, 0, 64 * 1024, 4096,
+			     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+	{ "w25h01jvm", INFO(0xef9021, 0, 64 * 1024, 2048,
+			     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+	{ "w25h02jvm", INFO(0xef9022, 0, 64 * 1024, 4096,
+			     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+	{ "w25q512nwq", INFO(0xef6020, 0, 64 * 1024, 1024,
+			     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+	{ "w25q512nwm", INFO(0xef8020, 0, 64 * 1024, 1024,
+			     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 };
 
 /**
-- 
2.17.1

