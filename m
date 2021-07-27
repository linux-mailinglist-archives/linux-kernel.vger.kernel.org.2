Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1534C3D7F25
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 22:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbhG0UV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 16:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231980AbhG0UU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 16:20:26 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CCBC06179C
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 13:20:24 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id f18so23863324lfu.10
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 13:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nvC4be67S2hWmOAqpL0RQZJnOtBBOz8i5k3BFovEr8E=;
        b=TZiGViw063SCv+BkE5QIu7B1fC35B25RgVA+O01OE/gLyIdjZEobY2lBgSrEh+dGe3
         g74N04pUX+Sep56PeAJMGHp4ADoFjj5iXf7MOPa/N5HOFz73rEH4gh3TU1st24wMqYRP
         AxBPDgCnNrVg8tphtxXpYpO1KTJxWICh3yColj1TMimGY/ws4hs+xkW4X03QouW6R1v8
         GoeftC2RyoMipFZ6Aoqjqp0Zw7Y9PbFgOD0qWlGJotsGPlTK4F+YeS0Stv8p23nMdwLf
         3+YS9ySMU45JfNjfyxk0/+DrNlE8LvJXretcix6rVkUSQd7LiPNPKW5dPNwvTAVRrWPN
         5p4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nvC4be67S2hWmOAqpL0RQZJnOtBBOz8i5k3BFovEr8E=;
        b=XASKT7lt7NoMbfmdvSsCqBBC0Iy8RvRCRiZrTO0Blm2Wg5/j3fcBNCZtohpvsv0Ce/
         GcqXJDRByG+3KdNymvfap5Ci5/rUkDZLdDFcLlQlqHe+5OWeow68jOPRk/vWW22m9bJU
         cq5iKVdY8CQCvAI6dbpxw1nn4Hkb6RO+zhqNCqZNzPiOOFxkNNRSu98Y9tdweC4g9hL3
         +0wpuYAPEclJ8TBM11rR3ZofPfUMszIhn4v7wLGcx2xgGrJgVKsgtMT9Cs63zYg5xkZg
         4rC6dRVfOyqIDFwsgE2RjUs8NtLIDBibAcwGoKhWanm2Q/lWeg1iybDJjVTdxQZC4G5M
         qaMA==
X-Gm-Message-State: AOAM532oXgndTMLb8r8DS/jI4bJIvylJRbKM1lOlHev9wEv4crhUmyXK
        RhsmAZq+IBxLgqRmszol3s45qQ==
X-Google-Smtp-Source: ABdhPJyucdxgoer/nXODmqByCWP2M9wwYCuy3JweYjsTTcfW1c9pFHcw8q3GeHZPX3rx/POvze1U8A==
X-Received: by 2002:ac2:5d4a:: with SMTP id w10mr11295514lfd.529.1627417222819;
        Tue, 27 Jul 2021 13:20:22 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id i11sm376502lfe.215.2021.07.27.13.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 13:20:22 -0700 (PDT)
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
Subject: [PATCH v6 7/8] clk: qcom: dispcc-sm8250: stop using mmcx regulator
Date:   Tue, 27 Jul 2021 23:20:03 +0300
Message-Id: <20210727202004.712665-8-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727202004.712665-1-dmitry.baryshkov@linaro.org>
References: <20210727202004.712665-1-dmitry.baryshkov@linaro.org>
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
2.30.2

