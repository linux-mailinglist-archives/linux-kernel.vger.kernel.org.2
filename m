Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81F523FACE2
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 17:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235704AbhH2PtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 11:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235564AbhH2Ps7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 11:48:59 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE35C06175F
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 08:48:06 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id d16so21258032ljq.4
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 08:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lzeU0XBdc+zW8wh83RkBlEjdf1NC4IsbDq14TpwvvIY=;
        b=Ag67y5ZpFJF9p8jT9/32es6sbKsdRbyjxY6xMl+DVef4i+VHsmJw80MUFZXTpPtDzI
         C/jPC6tN5MldUDrQitWnOcaykhPE/KBvoF6XDmXx28rmgEXcy5ZRi8ovwGtqR9AonWap
         Skmc7ldfTE/G1brjou0eWttnasmXsNABj0Dnc457xgSXTdUk19MK10PjnfYMmK8tOxn2
         hfYB6ximbfWH4KdSvtuykLzNFhBMf06UpE+QP9FqqmYkNmbBNncVTGRgL/6UXuNIgjlE
         Q15LHTviUuGnzXixdOwc3Xb8f6fmHt+A3Yh7XAsMWbMKE04JNfCXp8gFraxUlxDSanq/
         w5ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lzeU0XBdc+zW8wh83RkBlEjdf1NC4IsbDq14TpwvvIY=;
        b=fk/UYlBIRH8OMNJaFab7meEBPq83cydfP6F+DoUrrUmaMmk7E8Y4zOMzj+9bR1YY3i
         Ga90o5mnD2aDHDPli44zMo9+TdAzxIsNEcT0LvHJzDLaoVvi5aO1FjqsFGi9KZPoWkJh
         WdIshvR24YIhMT0cXTOH+Gk59lBJfeRBt/5Vx6jmE9GXkJV04tQAZinf07yYL6yozN7b
         DMNiStG6N8XJevnP/vk8uKnlvkBqkMVLZzR8//QGpxLvkOxQrghi2JI3iE/pMWbZphpE
         Vl7Sz007at8clLgHuLBOYZ4OxsUdJi/r85ApuUmrZZ1uHxZNKgHyi4/BMP2U46MqjlXN
         QD5w==
X-Gm-Message-State: AOAM532Y3j8ZkGa7/XWrqtLUclVDdrCs7l65gPRq0+zh51FcWONUFRZF
        eDjdAazh/Ec+7b4rXzC7NRWxcw==
X-Google-Smtp-Source: ABdhPJwvec1rcbKJVTI33jPDHb38xE04JgYCoHJRLIChOYMC/jiYEUHu9GnwNG4ssQIjUcOlgwu0Eg==
X-Received: by 2002:a2e:8403:: with SMTP id z3mr17397142ljg.298.1630252084908;
        Sun, 29 Aug 2021 08:48:04 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id y5sm1481243ljd.38.2021.08.29.08.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 08:48:04 -0700 (PDT)
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
Subject: [PATCH v7 7/8] clk: qcom: dispcc-sm8250: stop using mmcx regulator
Date:   Sun, 29 Aug 2021 18:47:56 +0300
Message-Id: <20210829154757.784699-8-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210829154757.784699-1-dmitry.baryshkov@linaro.org>
References: <20210829154757.784699-1-dmitry.baryshkov@linaro.org>
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
index 108dd1249b6a..cf0bb12eb6e1 100644
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
2.33.0

