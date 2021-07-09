Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20FD73C1E72
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 06:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbhGIEfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 00:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbhGIEe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 00:34:29 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80174C06175F
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 21:31:46 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id u25so5917706ljj.11
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 21:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OW6r9Ztak14Z94NLN85hpavnPWferFff+9qy6SUKk4g=;
        b=UvGi1B+es3fCaDxmJpGeewLmLB8C2VxxdjqqEEtrzFv0O0YZAolKlF756ouyrJpI2/
         fY58oGEn7/X9Y0nAPmv0ScmYyuXiAwRTIXpbMMSsy3KmpFYPdYDg1hs/Xmv6cEngQ00W
         gDrrrmODv6Sg1V7A1keQiN0XEBDXoTVvhSdXjWAvgBpuEOwDF2XdumPevBMFw29rfxHS
         r3xkD6To+3liLwf4z+QeiiT/BX8mVtxJyeZ2BdpS6cOgLwozikH84JZ1KCpHwGlc+HkM
         E5RZgZz7GZHGYnGfg8jPZwzKoepOd9ankKqCplBpO6fTlLs7AzIrDIjbJJsEY7xQVP86
         SHBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OW6r9Ztak14Z94NLN85hpavnPWferFff+9qy6SUKk4g=;
        b=E9TaI+S6LreqgqLnSLR9ePRK2vdsAwh3Eeui3tYrPW8LqJNjUV9p32f896Gj07Bw1D
         /nxgQuL9PqOcQ0mUjCiQntrRlYZy4hDPZNR92VGp6NGxExoY6EDdNefjXJUtUXmPvItI
         AG/YazibtEpDTOX5kZzWeyw6JDTt3wbwL/wqpPGgCs1ksA6Zw3aRVXI8Nw+5VkHsg8gv
         E5UfLzm4tw4gwUb8gIUl5tqPHPRihQw5lSmQsHalKKqUgJ1pW/NNtAajGry70HjjMvVW
         f3IcVkPk0DrJ5r6WgauJd5QhSGJYoKEPWE8NBsA7PFcpmLNlF6RSWrss4lhHIjlkoSUX
         tjLQ==
X-Gm-Message-State: AOAM532uWzPT/Yf66b1x2gAzI9pg/4ap+K949C49CxTbp1kKfRXguoDI
        6ueamKCrmdXmFsogTpZ6vcHSNw==
X-Google-Smtp-Source: ABdhPJyY7ngGsTRiOotvZgAIDUFql0+KdrxnztkmsKdBzpgq9oLFTrwe/YXta5EHMcKPW9w4HgfmDA==
X-Received: by 2002:a2e:9b46:: with SMTP id o6mr21455694ljj.501.1625805104909;
        Thu, 08 Jul 2021 21:31:44 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id h1sm13028lft.174.2021.07.08.21.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 21:31:44 -0700 (PDT)
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
Subject: [RESEND PATCH v2 7/7] clk: qcom: videocc-sm8250: stop using mmcx regulator
Date:   Fri,  9 Jul 2021 07:31:36 +0300
Message-Id: <20210709043136.533205-8-dmitry.baryshkov@linaro.org>
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
controller's gdscs.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/clk/qcom/videocc-sm8250.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/clk/qcom/videocc-sm8250.c b/drivers/clk/qcom/videocc-sm8250.c
index 7b435a1c2c4b..eedef85d90e5 100644
--- a/drivers/clk/qcom/videocc-sm8250.c
+++ b/drivers/clk/qcom/videocc-sm8250.c
@@ -276,7 +276,6 @@ static struct gdsc mvs0c_gdsc = {
 	},
 	.flags = 0,
 	.pwrsts = PWRSTS_OFF_ON,
-	.supply = "mmcx",
 };
 
 static struct gdsc mvs1c_gdsc = {
@@ -286,7 +285,6 @@ static struct gdsc mvs1c_gdsc = {
 	},
 	.flags = 0,
 	.pwrsts = PWRSTS_OFF_ON,
-	.supply = "mmcx",
 };
 
 static struct gdsc mvs0_gdsc = {
@@ -296,7 +294,6 @@ static struct gdsc mvs0_gdsc = {
 	},
 	.flags = HW_CTRL,
 	.pwrsts = PWRSTS_OFF_ON,
-	.supply = "mmcx",
 };
 
 static struct gdsc mvs1_gdsc = {
@@ -306,7 +303,6 @@ static struct gdsc mvs1_gdsc = {
 	},
 	.flags = HW_CTRL,
 	.pwrsts = PWRSTS_OFF_ON,
-	.supply = "mmcx",
 };
 
 static struct clk_regmap *video_cc_sm8250_clocks[] = {
-- 
2.30.2

