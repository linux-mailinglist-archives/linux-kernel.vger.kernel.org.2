Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C921239DEC4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 16:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbhFGObj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 10:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbhFGObi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 10:31:38 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C26C061766
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 07:29:32 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id m7so278577pfa.10
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 07:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2Pba5c3qBWuP5ixb0o+BLKBe4W9i5RTdJbbTlXq98AQ=;
        b=r9xcjPseVYXffrQD9JzOq7slcl8oklnyU7p2+OcBqtcG1X0uuOOcxwbeD9mGzKqvJd
         hohpvFhTAUo/XZrO97cC+kqyJRpmXahVAQP9tJFINNu2gpgZc50hfvWFtxhPIu8lai0s
         nViXi7ygUpbnB7/aMRWtYYqbQe7pjU1U87qIOvf/IUjxwyGIRnemNqpnVr2jPvdxEJxe
         GURiV8wolmqHLIdMeM8OITMiDg6oJo0Zkyv5P1ZOzf4y0yh7HwekLMoOHwyuEDdFyJvT
         o9dJjxQQKHCug2Pe4aoXo+b5WbWJd5CiikGQpO2Wl6M8Cpc0qb4Va8eoK738+VAUkLJN
         SeAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2Pba5c3qBWuP5ixb0o+BLKBe4W9i5RTdJbbTlXq98AQ=;
        b=eI0o8dOm1FBJxiev7K7kbcZ7JBHPmGwjeY+nghdR56C+z04q2EgwOLA8A0RXwlkGIy
         /D+iLrnlrWcO9xG9ijqs6hghsTYka9IpbXfhBm8QNwXzMvp+pDGSlfft/xsCj+PPapN0
         kTnuZcWoG9dJor5bv41o3GRNX0X+dChMhDakX6G45wU6dbm20Pr0inUOPnA+V3MbOtSW
         1ilm7cYj5AMDguBx6hKGiYrHDXjG3h7d+aNW2oVC+VixT2bhgSaRa7zejXAde4q5+fwE
         qmrDbuAR/brpqTCo7XtOiFw/Dn0LdpMW9jAsexbgaDjFNMQUIN2gNQGE7nrZHRp41cng
         oZPQ==
X-Gm-Message-State: AOAM5323OYb8OWkl5fxBjy3B6VnRS5NA3xqmEZIL1+faMysFEVGhQXaL
        jsBREizmtqPXJ9DJSstkrZpQOw==
X-Google-Smtp-Source: ABdhPJz/olsJOaqLcN0ek29kE0yjaeaOSno0ReYP1GXpV6MDZkQK5PlC1ahBGNqkXCeFZRxS6y7qrQ==
X-Received: by 2002:a65:5288:: with SMTP id y8mr17940823pgp.31.1623076171527;
        Mon, 07 Jun 2021 07:29:31 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id l201sm8389104pfd.183.2021.06.07.07.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 07:29:30 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Christoph Fritz <chf.fritz@googlemail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: fan53880: Fix vsel_mask setting for FAN53880_BUCK
Date:   Mon,  7 Jun 2021 22:29:07 +0800
Message-Id: <20210607142907.1599905-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the datasheet:
REGISTER DETAILS − 0x02 BUCK, BUCK_OUT is BIT0 ~ BIT7.

So vsel_mask for FAN53880_BUCK should be 0xFF.

Fixes: e6dea51e2d41 ("regulator: fan53880: Add initial support")
Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/fan53880.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/fan53880.c b/drivers/regulator/fan53880.c
index f3268b4d5066..8f25930d2769 100644
--- a/drivers/regulator/fan53880.c
+++ b/drivers/regulator/fan53880.c
@@ -79,7 +79,7 @@ static const struct regulator_desc fan53880_regulators[] = {
 		.n_linear_ranges = 2,
 		.n_voltages =	   0xf8,
 		.vsel_reg =	   FAN53880_BUCKVOUT,
-		.vsel_mask =	   0x7f,
+		.vsel_mask =	   0xff,
 		.enable_reg =	   FAN53880_ENABLE,
 		.enable_mask =	   0x10,
 		.enable_time =	   480,
-- 
2.25.1

