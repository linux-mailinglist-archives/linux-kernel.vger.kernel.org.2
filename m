Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 116E1382261
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 02:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhEQAuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 20:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhEQAt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 20:49:58 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8F4C061573
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 17:48:42 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d78so2956046pfd.10
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 17:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DuP6sRjyGC3e0UIopJrcAwmrA1l8Nbdo8WnjXvrdh3M=;
        b=eBnTIOSJWJ3lTjKveZlNcBOF38IMb2Yn+AzTqWGixsFxJkb9dDkmilNpAi5O55YIWR
         Q4Rj0oY7CUDSEUxKP6f9gkfKk6neonBG0FbxMIRFBR7o3DzorQP3oj5Uh6nOp5Sf486J
         WaZfobbF4VKOHu2dmCyiQhABRBkf4wYkf5wNuZf2zhyb2p9c43ClrmxwRTIIZT3G39hZ
         0dbZ0/8zzaSCsQ0iXsC/1uA41WPjr0vE+Hn1NnSC1bbJ9puZmUhTceTVgZuLskzGDwmA
         dLo9zKr8K4lCkbUuBCCUR6RUBzAEUnSf9Q72t1noLBa9LhxgrDNTSSBPxYmBMc0oL7pi
         BfYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DuP6sRjyGC3e0UIopJrcAwmrA1l8Nbdo8WnjXvrdh3M=;
        b=gDDeaHI+Kp5Z5nHCt1hTa6PPVlEphPpfG3nUP9RevSiK7N0xgXnwawC6JfpzaimY6X
         YPhgBbXYwQX7+VTAF/nQPXBVONkZEGvsH4GI0XoE3XuT3nGCpT4lx8ODcWA7rD0cmWKj
         eMeRw+m3843ytn2FOlrID+yJSVpgoinWGaar23Sqy1S6aTLgJsQtJZfA8vwDUDJPqqgZ
         DDoVvjs1l+TxeSuDLHDgSyDZsaRNLMPyg8oah0uMBRt1eNMCUk5GSQ2kBFOcLQpzrBKl
         Aob7CRA0u/J5ZpuF26vUhNFmuDcg4wPLA9zMPo74RpIWR20W/e9YqA4tW7f8YDweVOcK
         T11A==
X-Gm-Message-State: AOAM530k/Q3pQW08yRei/8qHPyuoK9VcRO1D9P2+at2Yh2wtCCGiZUBY
        Fpk3fw+tyPXTRgwrh5ivsHA4y77QwxHhtUwY
X-Google-Smtp-Source: ABdhPJxuhejeN9/HTF8kDT8Qorgkf5EajEWc4PMinAdSCXxCYLsPoyNMWO/TJElMy3h7z/am298sIw==
X-Received: by 2002:a05:6a00:706:b029:272:19a2:7280 with SMTP id 6-20020a056a000706b029027219a27280mr56506226pfl.8.1621212521547;
        Sun, 16 May 2021 17:48:41 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id d8sm8184640pfl.156.2021.05.16.17.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 17:48:40 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Christoph Fritz <chf.fritz@googlemail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] regulator: fan53880: Fix missing n_voltages setting
Date:   Mon, 17 May 2021 08:48:30 +0800
Message-Id: <20210517004831.1016177-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: e6dea51e2d41 ("regulator: fan53880: Add initial support")
Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/fan53880.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/regulator/fan53880.c b/drivers/regulator/fan53880.c
index e83eb4fb1876..e26a1420c6c5 100644
--- a/drivers/regulator/fan53880.c
+++ b/drivers/regulator/fan53880.c
@@ -51,6 +51,7 @@ static const struct regulator_ops fan53880_ops = {
 		      REGULATOR_LINEAR_RANGE(800000, 0xf, 0x73, 25000),	\
 		},							\
 		.n_linear_ranges = 2,					\
+		.n_voltages = 0x74,					\
 		.vsel_reg =	   FAN53880_LDO ## _num ## VOUT,	\
 		.vsel_mask =	   0x7f,				\
 		.enable_reg =	   FAN53880_ENABLE,			\
@@ -76,6 +77,7 @@ static const struct regulator_desc fan53880_regulators[] = {
 		      REGULATOR_LINEAR_RANGE(600000, 0x1f, 0xf7, 12500),
 		},
 		.n_linear_ranges = 2,
+		.n_voltages = 0xf8,
 		.vsel_reg =	   FAN53880_BUCKVOUT,
 		.vsel_mask =	   0x7f,
 		.enable_reg =	   FAN53880_ENABLE,
@@ -95,6 +97,7 @@ static const struct regulator_desc fan53880_regulators[] = {
 		      REGULATOR_LINEAR_RANGE(3000000, 0x4, 0x70, 25000),
 		},
 		.n_linear_ranges = 2,
+		.n_voltages = 0x71,
 		.vsel_reg =	   FAN53880_BOOSTVOUT,
 		.vsel_mask =	   0x7f,
 		.enable_reg =	   FAN53880_ENABLE_BOOST,
-- 
2.25.1

