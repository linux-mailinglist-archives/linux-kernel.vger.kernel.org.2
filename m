Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0DD3CC89D
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jul 2021 12:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbhGRKw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 06:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233108AbhGRKwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 06:52:14 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745B8C0613DC
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 03:49:15 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id u13so24241784lfs.11
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 03:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ClSRhnm8pHzVjF/xtq0qJLqRvgNXebRM90lbbmZW9cA=;
        b=KX9NZ39PZr3mzqRFuQGX6fZfO1ugSx3NK9JYFRfGFK98HMgMqbTUuKXR335d3B6sJ1
         WOjzSr19/6d1pEGtkD+RyumWSLsucsSlIJAPGpJAZ8h53nxpmSN3/whvfgwOGAHuxWYV
         drOPB9gQn84VbCYN26r68X4u5UyvD57BIfaiWwLnQ4qdOblhRG/fhiLbwAUFW6kWGcEu
         pYELuXRI0WU5VeoylywgD7t8k90s5fDvxEUXnXdITyv+eipNpalYvlnV8BBS1UCZzqKo
         UZExonrhn405UU/00a2bygJI3xRtUDEjxo+LIW40vZJY3nOjTuy7Mk11CsV5OmVZAHZ/
         1E9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ClSRhnm8pHzVjF/xtq0qJLqRvgNXebRM90lbbmZW9cA=;
        b=mXQLiwapJ0kWQr9XUVgNZC4ssutj5ro42gS+bpDBv0IldMhvYkgb3NR6vWahKgUVl8
         LrYtZCLg0lsJmfxqHjyuPY0vjA1pZMVm7pYRzkwDnu/iCtFhkRGrJYo+ZaQ9x+SdbQON
         uefAC06JTwWUe8H9E/GDLpTqA4gCl2jfbn4sgiS+ZEFAP+6obhfVeZxsGhAO+nblqgAu
         3nTKpVuksjUq2dLm5QrVzB29WzBBtkbWSf1S/L5DMOLFLsGTBpGuSA0JP409O9IQWkeJ
         0cTtAqHB9F3AaBiB9Wmg6mZw/o8v0noGBmwzXrA1wCWXoOOnyi8R/HB7NGVX2+lFjcbf
         Bbcw==
X-Gm-Message-State: AOAM5310VGnMSbbpDh2odjvcT3m8Cu+zVFMQCGk6rPM2p0ScF4XzV571
        y6KqI60S8n3yM/926dBZCaya5w==
X-Google-Smtp-Source: ABdhPJx1nUHvtHI+Szd9OpnGL0SHvSlOkH5RYYrLmZSbHWRm7YfcckMRcsRtWHOGXi7xPp63caORxQ==
X-Received: by 2002:a19:6f4b:: with SMTP id n11mr14536042lfk.337.1626605353889;
        Sun, 18 Jul 2021 03:49:13 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id y22sm1039528lfh.154.2021.07.18.03.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jul 2021 03:49:13 -0700 (PDT)
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
Subject: [PATCH v5 8/9] clk: qcom: dispcc-sm8250: stop using mmcx regulator
Date:   Sun, 18 Jul 2021 13:49:00 +0300
Message-Id: <20210718104901.454843-9-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210718104901.454843-1-dmitry.baryshkov@linaro.org>
References: <20210718104901.454843-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now as the common qcom clock controller code has been taught about power
domains, stop mentioning mmcx supply as a way to power up the clock
controller's gdsc.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/clk/qcom/dispcc-sm8250.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/qcom/dispcc-sm8250.c b/drivers/clk/qcom/dispcc-sm8250.c
index 0625fea6d7ba..372d3a8f38cf 100644
--- a/drivers/clk/qcom/dispcc-sm8250.c
+++ b/drivers/clk/qcom/dispcc-sm8250.c
@@ -1129,7 +1129,6 @@ static struct gdsc mdss_gdsc = {
 	},
 	.pwrsts = PWRSTS_OFF_ON,
 	.flags = HW_CTRL,
-	.supply = "mmcx",
 };
 
 static struct clk_regmap *disp_cc_sm8250_clocks[] = {
-- 
2.30.2

