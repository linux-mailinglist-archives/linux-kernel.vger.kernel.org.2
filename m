Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2110E3FACE4
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 17:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235793AbhH2PtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 11:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235709AbhH2PtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 11:49:03 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59994C0613D9
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 08:48:07 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id f2so21299791ljn.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 08:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4wYSAh/xvV+vEiBG5k8GPtuGmF+0aSivWDvc36iPGZQ=;
        b=oFewvCdk4g9bOv+QIjNC4zmNCCVpJ4x6cB+yCEq8i+MCSbhoAxNogz25a12Fa2ern7
         vSmqyT1gBDB8GsA1RXGMnoRls+STihl6OB+WdLz3pPPWXqvE02fx29faNqHZOAtRaihG
         aBzsLXRbMY+MKe1b7JYbV9xQF5V6xZPcTPLtpOjC263R9wFwAX9ZLl+iG3eemjAkGeS8
         fm5qziQqNdfLWxMMihIO1uxn2q8zcXRy+aPkUkKSfHyTZUHIt+L2UOMA0v0qZVPLSkQI
         nq3KCRtTjwKfw3PiNR8gDEPbnOMbSMnhsvsM4Pk4ctsiidrjjgjdiW/9/kzeyXOOWiE3
         naqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4wYSAh/xvV+vEiBG5k8GPtuGmF+0aSivWDvc36iPGZQ=;
        b=poD4HGQd7Jyk4y6+IX7rXaVhS2bdQkWnNariFunRr7L6nzvVi5aSfJPDYzSdU6MVpv
         xztYroby7PePKAoTNaXjoQHwjMx4ja0bYTdw1/rnPg1Uifuh/8cipjT0PNCl8FedJaEf
         4uiu6ywtqhlG7FAi5LWutJKqjijOfiUbOAGdW2xP73Lx8RVIGSqGKoero62ZN9Wumpg8
         sH3mW0xz0gAe+oXRgj4My/p6rUwU9R4wRc5bhvPj8+muq9GDT6oGHJHztF7cidLg5YdC
         k29a7Fjsk71ct3JqiDwwkC7zE9RkBozR6ly0SZF75MzODTQY4mS+mg+0VDvr3ThG1+jZ
         hgNA==
X-Gm-Message-State: AOAM531A3fNr3pSQizNLd4vhXuGhAJt++O2dryuZnOp8r+NBWzeKh8HW
        DGSU7ibCMTQwB+akKec0jb0RfA==
X-Google-Smtp-Source: ABdhPJxL8R3J3cKmcpKHszSldYyRqXI7vwDa9xFMUFMmsis2+4cgSK1YMVCfeLbNvBbhX3+2FDYC2Q==
X-Received: by 2002:a05:651c:2c6:: with SMTP id f6mr16922455ljo.7.1630252085602;
        Sun, 29 Aug 2021 08:48:05 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id y5sm1481243ljd.38.2021.08.29.08.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 08:48:05 -0700 (PDT)
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
Subject: [PATCH v7 8/8] clk: qcom: videocc-sm8250: stop using mmcx regulator
Date:   Sun, 29 Aug 2021 18:47:57 +0300
Message-Id: <20210829154757.784699-9-dmitry.baryshkov@linaro.org>
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
controller's gdscs.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/clk/qcom/videocc-sm8250.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/clk/qcom/videocc-sm8250.c b/drivers/clk/qcom/videocc-sm8250.c
index 8617454e4a77..f28f2cb051d7 100644
--- a/drivers/clk/qcom/videocc-sm8250.c
+++ b/drivers/clk/qcom/videocc-sm8250.c
@@ -277,7 +277,6 @@ static struct gdsc mvs0c_gdsc = {
 	},
 	.flags = 0,
 	.pwrsts = PWRSTS_OFF_ON,
-	.supply = "mmcx",
 };
 
 static struct gdsc mvs1c_gdsc = {
@@ -287,7 +286,6 @@ static struct gdsc mvs1c_gdsc = {
 	},
 	.flags = 0,
 	.pwrsts = PWRSTS_OFF_ON,
-	.supply = "mmcx",
 };
 
 static struct gdsc mvs0_gdsc = {
@@ -297,7 +295,6 @@ static struct gdsc mvs0_gdsc = {
 	},
 	.flags = HW_CTRL,
 	.pwrsts = PWRSTS_OFF_ON,
-	.supply = "mmcx",
 };
 
 static struct gdsc mvs1_gdsc = {
@@ -307,7 +304,6 @@ static struct gdsc mvs1_gdsc = {
 	},
 	.flags = HW_CTRL,
 	.pwrsts = PWRSTS_OFF_ON,
-	.supply = "mmcx",
 };
 
 static struct clk_regmap *video_cc_sm8250_clocks[] = {
-- 
2.33.0

