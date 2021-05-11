Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB3A37B09A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 23:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhEKVO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 17:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbhEKVOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 17:14:52 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CA1C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 14:13:43 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id f29so8027553qka.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 14:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MIxnRK41Dgin4k+YEmUeZP4hcWluFOzQ6jiu6YLQGXo=;
        b=hPBzHd0PAN1kHhgfMk3w9N/mFcR0Ucuk5lQRISA2OeXDXSjj5KNfQx+ZQqypxm3Ygh
         Zdaq1cvdWKOhWJT+jl7t12YLh42scADTtEcAhflIp6Zrsm8Eru2aEfV06ep3VFvkSVv7
         JLlk8OuvppcQ21BZLlcCffF9/YE5GHZx1jMie5I/859XOtbRluvSyJUfSkIwRj11w7qp
         EbufvORqmLYNjpw1cfc1/XiyFi1tAVXbkq5EFmtTb1ru6SB9kcJkZamQB6fIBGJb20f3
         q5mbd/w42CImwCHS//cG4KYxr1XtW6SAH2TKHscrAkrU9PmfBXaas8lRjBWa9uPtjyvX
         /Dsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MIxnRK41Dgin4k+YEmUeZP4hcWluFOzQ6jiu6YLQGXo=;
        b=RqnaayZXSGrGds2NjJEfapGdX19d8KZD6mFs0VkXq6IocEn1d5DolewcKQHSUCE1Jv
         64Kt0zFNYIgOHW4yxmJtxivM3s+WcBpkmp604MdFSszpOL+QqHNMg4lXZmffT7LMRCGI
         n/wld77+2lthoFKcBT1NI/vvnzl79f3WZKD7XwdTQSmpzY5eA4FHZqKu4TC5JQe83I7H
         DBRhLbd/dft6OvqjwCHjxweToxqF138ya0if+t+4Hjl4PQWlGfEek7ZJUtYQx5TlVOWE
         hu/IH4rwaZOulfO7U04A81Z8j88OC66D+C0XibVAaYT732swjKHgMCXqYaHHzS6t6LQK
         ZFNA==
X-Gm-Message-State: AOAM531cPfhsPnaXjvKvH5Uf6lc0Qp3I5+UvvHwPcoOGb3cCXiaOwHNs
        M0hSPxHS5JuRnN5m/dLP1BNiz10Gv0GZfg==
X-Google-Smtp-Source: ABdhPJxzBTmfrlh6QgTAlodB1O9HSHlGdWG9yawn0/jQBiedyKexwztdbdSyC8LVv+lE04Dv8PxMHQ==
X-Received: by 2002:a37:ae44:: with SMTP id x65mr30033599qke.9.1620767623042;
        Tue, 11 May 2021 14:13:43 -0700 (PDT)
Received: from master-laptop.sparksnet ([2601:153:980:85b1:f9ba:6614:640b:eee1])
        by smtp.gmail.com with ESMTPSA id g64sm14780392qkf.41.2021.05.11.14.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 14:13:42 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Ezequiel Garcia <ezequiel@collabora.com>,
        linux-kernel@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>
Subject: [PATCH 1/3] regulator: fan53555: fix TCS4525 voltage calulation
Date:   Tue, 11 May 2021 17:13:33 -0400
Message-Id: <20210511211335.2935163-2-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210511211335.2935163-1-pgwipeout@gmail.com>
References: <20210511211335.2935163-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TCS4525 has 128 voltage steps. With the calculation set to 127 the
most significant bit is disregarded which leads to a miscalculation of
the voltage by about 200mv.

Fix the calculation to end deadlock on the rk3566-quartz64 which uses
this as the cpu regulator.

Fixes: 914df8faa7d6 ("regulator: fan53555: Add TCS4525 DCDC support")
Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 drivers/regulator/fan53555.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/regulator/fan53555.c b/drivers/regulator/fan53555.c
index f3918f03aaf3..26f06f685b1b 100644
--- a/drivers/regulator/fan53555.c
+++ b/drivers/regulator/fan53555.c
@@ -55,7 +55,6 @@
 
 #define FAN53555_NVOLTAGES	64	/* Numbers of voltages */
 #define FAN53526_NVOLTAGES	128
-#define TCS4525_NVOLTAGES	127	/* Numbers of voltages */
 
 #define TCS_VSEL_NSEL_MASK	0x7f
 #define TCS_VSEL0_MODE		(1 << 7)
@@ -376,7 +375,7 @@ static int fan53555_voltages_setup_tcs(struct fan53555_device_info *di)
 	/* Init voltage range and step */
 	di->vsel_min = 600000;
 	di->vsel_step = 6250;
-	di->vsel_count = TCS4525_NVOLTAGES;
+	di->vsel_count = FAN53526_NVOLTAGES;
 
 	return 0;
 }
-- 
2.25.1

