Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A61A53BA620
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jul 2021 00:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbhGBWyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 18:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbhGBWyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 18:54:36 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF34C0613DB;
        Fri,  2 Jul 2021 15:52:03 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id bg14so18604336ejb.9;
        Fri, 02 Jul 2021 15:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CUXIdV7IyIYLsaimkDpH07CvQJHcqNP5b8K6Nj4IrE4=;
        b=FCo1WJAAgMsJncjryBYDadhLVfBG08rP33YJnoPHG90FhHsz357vFHnIzBo1nLcjNR
         lH0eZWtHZtimnegirn9Y0rXLi4kQ4+xX+KulK73EWQ3DBEz6rl0SvUfd/V/Rh1lQSN1F
         Zb1MhTGoDljyVuvLlqIGvIm6af09vb1ongwRsIfrxnANCuMYJl/QupK1i36K+JgERmzf
         cl/JJUQ7WblSFFRaxZr0hYpoMIYyTzDQ/ozQGqO3W375dYqJxbsbVIaURxsPvNHjBplK
         WtGTwcVRwErEGHG2B2GL08fqqlW+IOBQd4lJIa3sk107tUmbgopKw+mC/oyf0OVmlXq5
         pqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CUXIdV7IyIYLsaimkDpH07CvQJHcqNP5b8K6Nj4IrE4=;
        b=f8us1ZWvu5GfkA9o46RKDDQtec5GQCYHqx0Qy2WHDRnRmr9jM1uO1eiZ587eVm949m
         nD8d6JacbjqsJ5ttVVrCQN7voIInH2Kgs7hGXBCQnFEXOWFbGcK/9NvuVVptsHvdH8Ak
         si2q5tFlk2HGFjmg+mgAgqCGqDv719agofrEoqD4xS+bKqWGP/xRPBA7vmE0mAlPPrw/
         L9z9CnfVpqhDfJ66Cfr1vRyKj5mENUdHg4sjmM8U39O2UsjiIwAOUo45Ax+4aVhgQBJR
         6HJYApmqGPrahu60qnJmj+2iPbdtWJCwV1Sml6UTwOIpPSaXZ+0XpHkorGdfNjh8XQx8
         HYBA==
X-Gm-Message-State: AOAM530P8SYKK5PIjlszj9LRbIn9hJ1W7+PmXVFh2/G/1ecVL/pkmI3K
        lapGxYEnxMDi+OppsdJsDT4YZRFxOA4=
X-Google-Smtp-Source: ABdhPJzx45XAEdaPMlRXfsxl9nOpf+kJ9KYEYm3S8JI9izdhcVTWhCQMQwzh//FMvriJE+pnPJYJZw==
X-Received: by 2002:a17:906:4fc7:: with SMTP id i7mr2113939ejw.46.1625266321918;
        Fri, 02 Jul 2021 15:52:01 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-117-063-046.95.117.pool.telefonica.de. [95.117.63.46])
        by smtp.googlemail.com with ESMTPSA id r17sm1866964edt.33.2021.07.02.15.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 15:52:01 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-clk@vger.kernel.org, sboyd@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v1 4/6] clk: stm32f4: Switch to clk_divider.determine_rate
Date:   Sat,  3 Jul 2021 00:51:43 +0200
Message-Id: <20210702225145.2643303-5-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210702225145.2643303-1-martin.blumenstingl@googlemail.com>
References: <20210702225145.2643303-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

.determine_rate is meant to replace .round_rate in CCF in the future.
Switch over to .determine_rate now that clk_divider_ops has gained
support for that.

Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-stm32@st-md-mailman.stormreply.com
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/clk-stm32f4.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk-stm32f4.c b/drivers/clk/clk-stm32f4.c
index 18117ce5ff85..22267fb3e92e 100644
--- a/drivers/clk/clk-stm32f4.c
+++ b/drivers/clk/clk-stm32f4.c
@@ -709,10 +709,10 @@ static unsigned long stm32f4_pll_div_recalc_rate(struct clk_hw *hw,
 	return clk_divider_ops.recalc_rate(hw, parent_rate);
 }
 
-static long stm32f4_pll_div_round_rate(struct clk_hw *hw, unsigned long rate,
-				unsigned long *prate)
+static int stm32f4_pll_div_determine_rate(struct clk_hw *hw,
+					  struct clk_rate_request *req)
 {
-	return clk_divider_ops.round_rate(hw, rate, prate);
+	return clk_divider_ops.determine_rate(hw, req);
 }
 
 static int stm32f4_pll_div_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -738,7 +738,7 @@ static int stm32f4_pll_div_set_rate(struct clk_hw *hw, unsigned long rate,
 
 static const struct clk_ops stm32f4_pll_div_ops = {
 	.recalc_rate = stm32f4_pll_div_recalc_rate,
-	.round_rate = stm32f4_pll_div_round_rate,
+	.determine_rate = stm32f4_pll_div_determine_rate,
 	.set_rate = stm32f4_pll_div_set_rate,
 };
 
-- 
2.32.0

