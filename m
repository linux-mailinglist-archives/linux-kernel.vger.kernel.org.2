Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9373C1E6F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 06:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbhGIEfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 00:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbhGIEe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 00:34:29 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3F7C0613DE
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 21:31:45 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id f13so20507855lfh.6
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 21:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f0ldkE5j34OXHAqh3I/xyyl0k1n40wAos/+0qzuAEic=;
        b=evja71V+pcmqd6EmSv+Kg5ZvqKs56bvDZjR9SCjtxVgotJ6idANj1ATscxqed8yhrH
         BqZTpJzJV8b2/mRGTTUw/C87V0Ub/9ljyKAib/5HmOck6HhDX9xbtcYfIDoh6B/YRcFO
         FvHhKQEyAUsy4q66QaZtOlUhXFfULRgLI0Yh1LDLF19WJqfLFoD0DGuokdd5v0YC1Yw6
         nACS2JKBe1KaPMWI2WkDogCGf5h7LS/kMaTVUidb/nitQziDHKrtzOHhImfuus0axEJE
         ViuhFR3ovCswl+VA/6QiXst+hy99HD96ktL4Qv7YVQa/qw+Dof8NNthKI1nTf9NqFV3+
         XJTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f0ldkE5j34OXHAqh3I/xyyl0k1n40wAos/+0qzuAEic=;
        b=jfisOmwvyLk5+sTDwyMltf5KY8xVedpuQKDytNGnrZNMyLnI03VM9dgsfhrvZc/lK1
         aobTWKClDltqTnEDBahiD9sEKzenIXXThIFQYw+K8GhCG1XoiLoRU+YXxeHoSqDBTn4M
         wVDEzlNDcwIxfJU3eU7DQvwDKg+AD452OU6D+Ik17FoctYebqEl0VnU1F4p7S3Q4bq8A
         60DmACz6iAuIXN5pvsOaGMWVhy6YnS+ovSSkjdwmLaGdvEKh52tGKLKJi6FS18AuH51Z
         Owe9v9rQgrIP9HJXU9bW8+vvnpD7sHWTd4uYLMH7con3GsCXv5fAeONeEHHfYau9ctGn
         d4FQ==
X-Gm-Message-State: AOAM530AtXZlj1KLG2CRbN0Ggfpi9WW8wZ3kgNRHDdnKUqgw3DDgOBOD
        W+r4LghlKr4Oz6HxUHO3h8xyEA==
X-Google-Smtp-Source: ABdhPJwZptgyRZPC0nRqYzgnhWBWhgKSY6kj6YkrVEHm0vPEIBEUMmZjkoNbraIyVlKA+ynzcecnJg==
X-Received: by 2002:a19:408c:: with SMTP id n134mr26254126lfa.329.1625805103973;
        Thu, 08 Jul 2021 21:31:43 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id h1sm13028lft.174.2021.07.08.21.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 21:31:43 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v2 6/7] clk: qcom: dispcc-sm8250: stop using mmcx regulator
Date:   Fri,  9 Jul 2021 07:31:35 +0300
Message-Id: <20210709043136.533205-7-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210709043136.533205-1-dmitry.baryshkov@linaro.org>
References: <20210709043136.533205-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now as the common qcom clock controller code has been taught about power
domains, stop mentioning mmcx supply as a way to power up the clock
controller's gdsc.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/clk/qcom/dispcc-sm8250.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/qcom/dispcc-sm8250.c b/drivers/clk/qcom/dispcc-sm8250.c
index de09cd5c209f..dfbfe64b12f6 100644
--- a/drivers/clk/qcom/dispcc-sm8250.c
+++ b/drivers/clk/qcom/dispcc-sm8250.c
@@ -955,7 +955,6 @@ static struct gdsc mdss_gdsc = {
 	},
 	.pwrsts = PWRSTS_OFF_ON,
 	.flags = HW_CTRL,
-	.supply = "mmcx",
 };
 
 static struct clk_regmap *disp_cc_sm8250_clocks[] = {
-- 
2.30.2

