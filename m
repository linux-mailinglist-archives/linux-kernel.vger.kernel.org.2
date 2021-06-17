Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5EDC3AAACC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 07:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhFQFUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 01:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbhFQFUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 01:20:06 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D80BC061226
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 22:17:54 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id t9so3962694pgn.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 22:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LHv1lTvf9/mvfXwwyWB3sDRCKdNlNOiyEsJvKG7acF0=;
        b=t0xflEJjzX0MQdo99lwhAaKswCGKauZQbzDW92uX1Av2/dpmdgkOEn5YiUy/sKR71s
         Dc207v+m5o/HA1PGain4ADtIHovqO06TmPGokCl5mXzOHIZrJDhdpmWothW6G9SMp1h+
         G064sbU5BDvTFdct86ayxbfMftW4y8iUcL/YempEnzeMTFkOqZbo2eJxpX/4TVRKWkJe
         MjZU85fmslE/yZyDnHASNpOG5msBaFaiD71NoESs1lUQ9vo2C1stQ4zgVTG0q8Pxfiqi
         Gnj75HSGuYC+CNSFx76S/yYvxuh6lCIRlKPyXvhWei/ZZGkjbXA1mgCPz/m6NP4FFcUj
         MbnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LHv1lTvf9/mvfXwwyWB3sDRCKdNlNOiyEsJvKG7acF0=;
        b=DHrL/jsYpYAhOyrbkCjftvBxm8dyHcJvnuwgZWefFjUfqunvFxblNFfYapA5pHfgv4
         iUAh3YIKeH9SYp9iwoDv8eqOYUeozCH/RX8JnkmmsNHaAG05jm1JAQNC2EnUJhZeFHCk
         ErOrgYMtdBjYjVIAgePR4OahgjtEMPWqSu9kaaW/cc/Fkp/3PN8qF2Xen0M3MPAOsYyk
         cVLCeNZuQm1ehxn7eNy3y2uMN9AiYpHM5Fq0WaREKJCwHki6Eg0MLLbj/ttvYkicSYdy
         3g0n5q0GJOSKKELAf/97LMGJ3d+Dj640l8akl916t0UvFZt9h0z11eJCHeOJaVAd+qmR
         7q7g==
X-Gm-Message-State: AOAM533t7RXxRpoVpQW9bZrtxy6CBZbnltwVaJ5Fla1KVoBOBAXXh+SF
        9c98zkPMMnsb8yG0lnhf6+pHgA==
X-Google-Smtp-Source: ABdhPJyxAj7RIWQcNW9auXz0etEUfZvinnisGcJ/Tv4GJBM04TUHBGoOUdRWTiM9D17mj5FeIvm1CA==
X-Received: by 2002:a62:b415:0:b029:2f4:829f:e483 with SMTP id h21-20020a62b4150000b02902f4829fe483mr3547045pfn.4.1623907073507;
        Wed, 16 Jun 2021 22:17:53 -0700 (PDT)
Received: from localhost.name ([122.177.46.2])
        by smtp.gmail.com with ESMTPSA id 188sm3900893pfz.146.2021.06.16.22.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 22:17:53 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, lgirdwood@gmail.com,
        Mark Brown <broonie@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH v3 4/5] regulator: qcom-rpmh: Add terminator at the end of pm7325x_vreg_data[] array
Date:   Thu, 17 Jun 2021 10:47:11 +0530
Message-Id: <20210617051712.345372-5-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210617051712.345372-1-bhupesh.sharma@linaro.org>
References: <20210617051712.345372-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing terminator(s) at the end of pm7325x_vreg_data[]
array instances.

Fixes: c4e5aa3dbee5 ("regulator: qcom-rpmh: Add PM7325/PMR735A regulator support")
Cc: Mark Brown <broonie@kernel.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 drivers/regulator/qcom-rpmh-regulator.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/regulator/qcom-rpmh-regulator.c b/drivers/regulator/qcom-rpmh-regulator.c
index 6a8b7ac67bbe..af41a517da99 100644
--- a/drivers/regulator/qcom-rpmh-regulator.c
+++ b/drivers/regulator/qcom-rpmh-regulator.c
@@ -1070,6 +1070,7 @@ static const struct rpmh_vreg_init_data pm7325_vreg_data[] = {
 	RPMH_VREG("ldo17",  "ldo%s17", &pmic5_pldo_lv,   "vdd-l11-l17-l18-l19"),
 	RPMH_VREG("ldo18",  "ldo%s18", &pmic5_pldo_lv,   "vdd-l11-l17-l18-l19"),
 	RPMH_VREG("ldo19",  "ldo%s19", &pmic5_pldo_lv,   "vdd-l11-l17-l18-l19"),
+	{}
 };
 
 static const struct rpmh_vreg_init_data pmr735a_vreg_data[] = {
@@ -1083,6 +1084,7 @@ static const struct rpmh_vreg_init_data pmr735a_vreg_data[] = {
 	RPMH_VREG("ldo5",   "ldo%s5",  &pmic5_nldo,      "vdd-l5-l6"),
 	RPMH_VREG("ldo6",   "ldo%s6",  &pmic5_nldo,      "vdd-l5-l6"),
 	RPMH_VREG("ldo7",   "ldo%s7",  &pmic5_pldo,      "vdd-l7-bob"),
+	{}
 };
 
 static int rpmh_regulator_probe(struct platform_device *pdev)
-- 
2.31.1

