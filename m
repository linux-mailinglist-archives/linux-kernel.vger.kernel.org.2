Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8CA3C2875
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 19:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbhGIRfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 13:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbhGIRez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 13:34:55 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C195DC0613F0
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 10:32:10 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id f13so24546955lfh.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 10:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f0ldkE5j34OXHAqh3I/xyyl0k1n40wAos/+0qzuAEic=;
        b=p4MDQnpFTSPgXtG+PXQEdPP352hDWz8Stp22Wi3WKR0YgREac2VUswu7zpo11zdGYv
         3wDME5GPeFyVyTQrojf/dXFG1VnKwqZMH0sjAc4gYyw3Ki6mFcc2hRYWCsN7pbehCvLF
         WeWPQakp3zuYRkwl2nvWkv/eHSQoyPfI5YYOxs3mrr9cC7uivbi1gXkQeznHKD2c64J8
         lhFq9LXoweEJ6mCr414URpxb2Jma4wnD6EN23Uk9s28aQtRrlvd45/yb2h8qWfLpsNu6
         TS3dF6Rlj3s6oUL6dfLHK1vlmEi6xxpLUDWLdvwf3PVVhzvujWuC0pELbaum+F3Eckf7
         8qeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f0ldkE5j34OXHAqh3I/xyyl0k1n40wAos/+0qzuAEic=;
        b=ngqEY/hFIDIumzTve7H3NjDVtOmcaHfi9vJkEv3fNUyLKh/IvoPnnvTAXMBg/V4JGW
         HAF7YKyfYSvDxQPjWnxOfyeYNjiinuep74iejGq5vjcj4ArUzz5d3xDADZDAIUmlgeZi
         2e0JAM8VcUk7cdmVZMbIupe+cUGWU7qapNixAlDYh0lIEElBy3k8SQKEWDDWslDN9Wgp
         zrnpBu+tqCPgLwudhkoA+Ozq6N4pb0DlUN9ZHfOtLZExjTq9fQ9gLrseS61HOBywPol6
         IpYn1BS4jGbtVE6QgbxDyDQFroEGkn44gpBdOEepDjPn4oscFWgrsRohsnUxR6KQOvPY
         t3aA==
X-Gm-Message-State: AOAM5333rBbaRRyhmIr46NVOoYiJQ/YK3fJTSRQVFUvI8GXQchlsKIXC
        5iraC3GmNLl1UN1MNjDVfHCT0g==
X-Google-Smtp-Source: ABdhPJyYcFjllrZgWkk/43fifMH9cKfl6MIk9xpfXGxacTUBWTBdQzl+TE1JYq3wBpVe+KVSBNhXoQ==
X-Received: by 2002:a05:6512:238c:: with SMTP id c12mr30865872lfv.317.1625851928920;
        Fri, 09 Jul 2021 10:32:08 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id b14sm511129lfb.132.2021.07.09.10.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 10:32:08 -0700 (PDT)
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
Subject: [PATCH v3 6/7] clk: qcom: dispcc-sm8250: stop using mmcx regulator
Date:   Fri,  9 Jul 2021 20:32:01 +0300
Message-Id: <20210709173202.667820-7-dmitry.baryshkov@linaro.org>
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

