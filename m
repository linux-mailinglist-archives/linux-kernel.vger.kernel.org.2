Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4305137B09B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 23:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhEKVO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 17:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbhEKVOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 17:14:52 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B9BC061760
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 14:13:44 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id m13so511131qtk.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 14:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=93zdvhwZsyDxQSgKsZscVzL0a1RBBJ3f9LN13h1qJDY=;
        b=OjrBdZbpK569VNjXzA0I5uC0X03hgRHU/VwJi5Qb9oEUM41lGlxTKdAFn2oNO81Lmt
         a05j7CoFUU0yPzCqfdeAIC8DfgZQmLkMhKH2z8bW+chSJbx9i7He4Jyr3Xw1QmJf46j6
         EOUqhQYp5xzAVPdZXxi4wscSdFrfdgXTORDWsaWJ79H9eNlKyP6h7h2ATs2JKJD1TmJq
         UI3/FdgSzVjEDtzSXj8tZQlHI7hLtDWA8qznv1vnYdpAzdn0EI5oJxp0v077toXC7rXN
         NPOfSap6XF8jwcHbQivBJvNE64UbY/w9hL+MOfvIk6lTsg8cHdAQ4cmy7ZJ+Ysd7eOVP
         haSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=93zdvhwZsyDxQSgKsZscVzL0a1RBBJ3f9LN13h1qJDY=;
        b=YX3/b7BuCfAsj7NA6hlxJWgqWW0/y/2XF5UhFoqfYJYt3Enii6c8N7foolFJqrlEWw
         saZwj+Re7+Rrr7ecCNoaA/ZIkeN7wiheUMzClGZGt1QWJ59XqYpOQ4jo3hhtSI05+Kg1
         Pps2Wkua2LhrLCEeUHSxRQ5LeRbVTQAHFyJLNV5dkxzEaqou9mgHDp0YPkvvHK7jIz8F
         L0NmIGYSzl4j8Ts8C4d6ZXwJlsxwWtA564sVB8DFZxEoWbqlOlXuCd6uYREZb6Kj7ob0
         TIX/X7gDSXpy/VI+KZ9qGDkeHwX7I8tj1K1IhGvrssWxryOJJMYpH3KqPDCeCjz1d64M
         enbg==
X-Gm-Message-State: AOAM531tQ4kq4j3M3Nf8qHeOi6jAuyB4sgIIoec7qb0rlhr1CoxkTa5H
        TuNS0rSzG8SxZMvk0vK2s9c=
X-Google-Smtp-Source: ABdhPJzPJ1m2pkLVDnpacNZY9q38jXsSCK1pgtoY+6dVBMFUiA2QtAle7CVDH3EwSmRUvD4OmuTTyg==
X-Received: by 2002:ac8:794a:: with SMTP id r10mr30556864qtt.269.1620767623572;
        Tue, 11 May 2021 14:13:43 -0700 (PDT)
Received: from master-laptop.sparksnet ([2601:153:980:85b1:f9ba:6614:640b:eee1])
        by smtp.gmail.com with ESMTPSA id g64sm14780392qkf.41.2021.05.11.14.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 14:13:43 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Ezequiel Garcia <ezequiel@collabora.com>,
        linux-kernel@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>
Subject: [PATCH 2/3] regulator: fan53555: only bind tcs4525 to correct chip id
Date:   Tue, 11 May 2021 17:13:34 -0400
Message-Id: <20210511211335.2935163-3-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210511211335.2935163-1-pgwipeout@gmail.com>
References: <20210511211335.2935163-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tcs4525 regulator has a chip id of <12>.
Only allow the driver to bind to the correct chip id for safety, in
accordance with the other supported devices.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 drivers/regulator/fan53555.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/regulator/fan53555.c b/drivers/regulator/fan53555.c
index 26f06f685b1b..16f28f9df6a1 100644
--- a/drivers/regulator/fan53555.c
+++ b/drivers/regulator/fan53555.c
@@ -89,6 +89,10 @@ enum {
 	FAN53555_CHIP_ID_08 = 8,
 };
 
+enum {
+	TCS4525_CHIP_ID_12 = 12,
+};
+
 /* IC mask revision */
 enum {
 	FAN53555_CHIP_REV_00 = 0x3,
@@ -368,14 +372,21 @@ static int fan53555_voltages_setup_silergy(struct fan53555_device_info *di)
 
 static int fan53555_voltages_setup_tcs(struct fan53555_device_info *di)
 {
-	di->slew_reg = TCS4525_TIME;
-	di->slew_mask = TCS_SLEW_MASK;
-	di->slew_shift = TCS_SLEW_MASK;
+	switch (di->chip_id) {
+	case TCS4525_CHIP_ID_12:
+		di->slew_reg = TCS4525_TIME;
+		di->slew_mask = TCS_SLEW_MASK;
+		di->slew_shift = TCS_SLEW_MASK;
 
-	/* Init voltage range and step */
-	di->vsel_min = 600000;
-	di->vsel_step = 6250;
-	di->vsel_count = FAN53526_NVOLTAGES;
+		/* Init voltage range and step */
+		di->vsel_min = 600000;
+		di->vsel_step = 6250;
+		di->vsel_count = FAN53526_NVOLTAGES;
+		break;
+	default:
+		dev_err(di->dev, "Chip ID %d not supported!\n", di->chip_id);
+		return -EINVAL;
+	}
 
 	return 0;
 }
-- 
2.25.1

