Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3443C2872
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 19:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbhGIRfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 13:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbhGIRez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 13:34:55 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68134C0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 10:32:11 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id t17so24780763lfq.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 10:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OW6r9Ztak14Z94NLN85hpavnPWferFff+9qy6SUKk4g=;
        b=FrxLNPysWTbK6msNrS77oo1V4NLdNkri1hMORbbVvbWnWUfTditLVD1NZEyi+EIkhe
         Ytl9GL9s7p+GxeHZSa0K1KVSHbHt7Db+9PZoaOBAiMDhKNzGPF7vIz4gxe0bV3Ijw0fu
         KO1XVn5897fkEBOsj2zwZJvWih3RQDHTsVQgcr9nkNrpxaiWUBPlLL/DvWhDF9Lj/zad
         p1+qpPBsUSq6yG1B9o1K7uNG+flJ7Bl5oK8vUla4zQnjwj/A3nKVXsVHFuy6X8xNFf2C
         PKQldZcDzARyowiHBxpuxrTx2Vsr3ZnfqA/S3Wlh2aEHPN/3VRBjC+KyVGaNIBfaJJDm
         iodA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OW6r9Ztak14Z94NLN85hpavnPWferFff+9qy6SUKk4g=;
        b=PLBT6HoofZlOxokBPRcoOJiwnuzUkf7zsG/u4i35ILt+OZvwyhAxxqYNGyxJOsQ7xp
         RpJ8Q9fS2XsxYjR4eePEj9MNUe7CWt7oAULt2t1rV+tNZpf5mhUNaPVk7DqTudc+Rcnv
         +B7N2WhSxwRn/ump+iu+urJP0lBcYOrAZJFh/3161fepeodE9x8rW/+naFixmRMRW8az
         UK2YidETHIxn278A6l4T+9CEinGXAfVrf5vYAKmYwmyO6pGIANQmJSEh765rYNR7ITXa
         bZ5+ass7GWYXTugc9nyQ3XCbMz0m+BCX27DH66hiTcWiqjLDiT4GRtAr3hwwL2+QgKWj
         UcPw==
X-Gm-Message-State: AOAM533iZ5Cqa9GPVXKd8LMxzC88w+V/bYYPl7TM7+kv8iezRqp3lo48
        2NXINasyjra/xhC+oJd/HWJT5Q==
X-Google-Smtp-Source: ABdhPJxUjTJVOzCEta2wUHL7FVm04+6VVBlwN0yiMRnKs+nVtnq3uEoz/4a6MO5w5EjHJcZlqo9D2g==
X-Received: by 2002:ac2:48a9:: with SMTP id u9mr9304635lfg.277.1625851929692;
        Fri, 09 Jul 2021 10:32:09 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id b14sm511129lfb.132.2021.07.09.10.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 10:32:09 -0700 (PDT)
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
Subject: [PATCH v3 7/7] clk: qcom: videocc-sm8250: stop using mmcx regulator
Date:   Fri,  9 Jul 2021 20:32:02 +0300
Message-Id: <20210709173202.667820-8-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210709173202.667820-1-dmitry.baryshkov@linaro.org>
References: <20210709173202.667820-1-dmitry.baryshkov@linaro.org>
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

