Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E85631FD31
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 17:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbhBSQgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 11:36:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbhBSQgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 11:36:43 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A07EC061756
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 08:36:01 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id v6so23167278ljh.9
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 08:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EXIT32tLXPwUb21u4mi4aAdEHXnyWJcrALpWe1VrK5o=;
        b=CCrLuJsYBB7uHeb55emYj7Kz3+dmHcwNZiHJfAl8Bb/uD4xia1ZC6ln0cpUA8wlsas
         gMhmQCo2goQRRNBnZQudaYfxPMmRofQJkj13m6rH2xJEHPWCg3pfocPkf3McnEFQzk15
         95KAxd/1XzKq84xIco2FvlI0joHGnfw2Vt8uJFBIF9ugcrMKHx1REqriNxdf8Ou3BNp0
         k2/xN8QwptNXIw78vQ9oZ6MvIP8H/F/F22++L2QXNvoB/ShQTeM10tBuX8ADXuqsngH5
         rVRUSAUlk0zScJ2NlsFn96FHcba1z8IUO0DxAiiKgkvJyB64pkc4YFIMYFXAKBuvO1pV
         GYdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EXIT32tLXPwUb21u4mi4aAdEHXnyWJcrALpWe1VrK5o=;
        b=clV9ON/u4XuMxOaENZOYTAr84e8IWUQjDo3xrYKGFIf0ojrS2TUEwC/IJefKK6nYma
         +ISOEm5JxVS0UT4X2vczRJiAsCSS2bbjU5OE5McgshiYXIgHnIq60HFPcthSfx1KmF/2
         rwdqsHflbH/cwPia+7T4ngk1caTR6LiJz/FLn3n71FUaa2BNoLHOpeTqaAB6l2jHzqZO
         qAK9zs11VVKTJZiB3qDnPWbet1neyDh1Vq5pLfO2G16g9mXNJKNcT7+GGzZvYDU5yVJc
         AlyC9x9/wxLo6m7oV3taueG5W/fCn0p1MLIfbIMxgKI0tpwoOMB2XeMCXJQZ6/qOmQMy
         RaMg==
X-Gm-Message-State: AOAM531sAjmRTf8BhlYZf+5nty2d2Pw0HfhzRpzOUlauPruOrDKmZB2I
        ljlrMl8pdomnWwJCGAPJDmI=
X-Google-Smtp-Source: ABdhPJye+d5iqus2nTT771b8U6TZ5EbEBRTnLB9ypg0pdJ/HHbLN/e4zU8e9NcUs9tXpBHU0fUAnnA==
X-Received: by 2002:a05:651c:21a:: with SMTP id y26mr6128936ljn.323.1613752559577;
        Fri, 19 Feb 2021 08:35:59 -0800 (PST)
Received: from msi.localdomain (vmpool.ut.mephi.ru. [85.143.112.90])
        by smtp.gmail.com with ESMTPSA id g4sm968107lfu.283.2021.02.19.08.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 08:35:59 -0800 (PST)
From:   Nikolay Kyx <knv418@gmail.com>
To:     gregkh@linuxfoundation.org, sergiu.cuciurean@analog.com
Cc:     Nikolay Kyx <knv418@gmail.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/02] staging: kpc2000: code style: fix alignment issues
Date:   Fri, 19 Feb 2021 19:34:11 +0300
Message-Id: <20210219163411.24873-1-knv418@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <YC92OIgh6HTEexu4@kroah.com>
References: <YC92OIgh6HTEexu4@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following checkpatch.pl check:

CHECK: Alignment should match open parenthesis

in files kpc2000_i2c.c kpc2000_spi.c

Signed-off-by: Nikolay Kyx <knv418@gmail.com>
---

Additionally some style warnings remain valid here and could be fixed by
another patch.

v2: Edited changelog, as suggested by Greg KH <gregkh@linuxfoundation.org>
v3: Splitted patch in two parts, as suggested by Greg KH <gregkh@linuxfoundation.org>

 drivers/staging/kpc2000/kpc2000_i2c.c | 2 +-
 drivers/staging/kpc2000/kpc2000_spi.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000_i2c.c b/drivers/staging/kpc2000/kpc2000_i2c.c
index 25bb5c97dd21..3f1f833d3b51 100644
--- a/drivers/staging/kpc2000/kpc2000_i2c.c
+++ b/drivers/staging/kpc2000/kpc2000_i2c.c
@@ -269,7 +269,7 @@ static int i801_block_transaction_by_block(struct kpc_i2c *priv,
 	}
 
 	status = i801_transaction(priv,
-			I801_BLOCK_DATA | ENABLE_INT9 | I801_PEC_EN * hwpec);
+				  I801_BLOCK_DATA | ENABLE_INT9 | I801_PEC_EN * hwpec);
 	if (status)
 		return status;
 
diff --git a/drivers/staging/kpc2000/kpc2000_spi.c b/drivers/staging/kpc2000/kpc2000_spi.c
index 44017d523da5..16ca18b8aa15 100644
--- a/drivers/staging/kpc2000/kpc2000_spi.c
+++ b/drivers/staging/kpc2000/kpc2000_spi.c
@@ -465,7 +465,7 @@ kp_spi_probe(struct platform_device *pldev)
 	}
 
 	kpspi->base = devm_ioremap(&pldev->dev, r->start,
-					   resource_size(r));
+				   resource_size(r));
 
 	status = spi_register_master(master);
 	if (status < 0) {
-- 
2.30.1

