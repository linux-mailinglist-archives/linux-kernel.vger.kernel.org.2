Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4E4382262
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 02:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbhEQAuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 20:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhEQAuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 20:50:00 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E78C061573
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 17:48:43 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id n3so2204213plf.7
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 17:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NSt7O8bnKmxbpckytJ9xYpOHq3IVlLQN9JCR4IWeCE0=;
        b=cmMqbMkzmPxvwwuR/PihvB9lAhVhdc58ML4YpsSCqvr/aYpLcHHeK9CBsQNGfjcTJg
         Vjey8xI21mrXqzuFfrhlUtmH2KA9aDb1lOHT6XoPgo8pgbNagjfqDsLQ4ukUN/hKSjyM
         tXFCJ1E5BRC0xf2YJJZRbS8p2Ms/bn1XxPMYsU2LjzfmbFDIL22+h/rbTQxPLZvw7t31
         szNGCUue8E596SUDzd1bSLfZiTBlpNjP5LXWa6IQeEjoMhEsIGa3QbxYx/2+qghNY2Eu
         ZR0G8USlAjVmXozC9vYWTW4EQLsOTyVoXnlTPj07E6J8zRfOqIOCbGKSj0lVCdHvkxMx
         xzdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NSt7O8bnKmxbpckytJ9xYpOHq3IVlLQN9JCR4IWeCE0=;
        b=JG17Z4uXe0ecC0DmbEYJkIR4mSiE9RPP5JY9IYAJLV+NkZSAGAGJhGlfaAW4z1Nn5a
         xt74uBOq3MIj2ZPXxJRFsO1syNYH3BsryAyv198lc7XSyvGvD36BAiMWKT/GhzbGT9V1
         eHROxt8VY9WaYs1C7Izk56KqDCx0+FGEk66o/uK5QgkFhC2o8t4JUHY2/Bp8dmk0bF0l
         BHFwSISl+JPmbc6Jby8zoEFXcVDUTUtaYPsDNGxvU4Y3eUll2mCm4QgEodgjl6QnIJgF
         WOdp5UoTVGERTyQD0aPStbQt0c3QjfkPdvvOGBJ/cs8z2is4VJWDmpGs9fxoGJW3mA9Y
         itDg==
X-Gm-Message-State: AOAM533vbsOi3CkEHmhF15Yal+/Ih48P2guCfWCGwdu2Ff5CEME6hWrn
        um/xgmTkodlr+xj5/rQ3ZPvtlg==
X-Google-Smtp-Source: ABdhPJy0oVtNwn2BGhEjzllqYVcj83iH65AHxqI6iplmwdw2DLRzI7nxr6DFqdj6AhxN9guZpilMgQ==
X-Received: by 2002:a17:903:1243:b029:ed:8298:7628 with SMTP id u3-20020a1709031243b02900ed82987628mr57182412plh.11.1621212523447;
        Sun, 16 May 2021 17:48:43 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id d8sm8184640pfl.156.2021.05.16.17.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 17:48:43 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Christoph Fritz <chf.fritz@googlemail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/2] regulator: fan53880: Convert to use .probe_new
Date:   Mon, 17 May 2021 08:48:31 +0800
Message-Id: <20210517004831.1016177-2-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517004831.1016177-1-axel.lin@ingics.com>
References: <20210517004831.1016177-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new .probe_new for fan53880.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/fan53880.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/fan53880.c b/drivers/regulator/fan53880.c
index e26a1420c6c5..d7a1bdded8d0 100644
--- a/drivers/regulator/fan53880.c
+++ b/drivers/regulator/fan53880.c
@@ -114,8 +114,7 @@ static const struct regmap_config fan53880_regmap = {
 	.max_register = FAN53880_ENABLE_BOOST,
 };
 
-static int fan53880_i2c_probe(struct i2c_client *i2c,
-			     const struct i2c_device_id *id)
+static int fan53880_i2c_probe(struct i2c_client *i2c)
 {
 	struct regulator_config config = { };
 	struct regulator_dev *rdev;
@@ -177,7 +176,7 @@ static struct i2c_driver fan53880_regulator_driver = {
 		.name = "fan53880",
 		.of_match_table	= of_match_ptr(fan53880_dt_ids),
 	},
-	.probe = fan53880_i2c_probe,
+	.probe_new = fan53880_i2c_probe,
 	.id_table = fan53880_i2c_id,
 };
 module_i2c_driver(fan53880_regulator_driver);
-- 
2.25.1

