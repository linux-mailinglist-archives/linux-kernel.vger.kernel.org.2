Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A95B3D1444
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 18:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234762AbhGUPvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 11:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234468AbhGUPvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 11:51:35 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B979C061575
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 09:32:12 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 42-20020a9d012d0000b02904b98d90c82cso2598724otu.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 09:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kCvZTNdYEH5Jl0HEt5wKlYnbcTvyEMwjuHluFUKeb/Q=;
        b=zhiDbGZ6irvoE254nIOet2VI5q8lV53kzKCSBRKjE2mVYstBUUpyvyZZXh/jcXAcYX
         io8iGnJGSkAeYT1fQJz444piKJLTUOZP7u+JoZRTgqs07gd/zcKUqpf46/Td2NPZLVKE
         cgvXa87jvME/YWHIv9mNeqUmgN1o2xufonskalGe10mUfvKhy7J+O3SGH3pUQS1e+Vzb
         1A89MyAlAGx5GjTwaTaxQ3q/N63PUWjnb1Q/jDCG2zzhYrE8x7tm7/+CBP9p8QPuMEhk
         kWuiAqpKL962z4KNbpe+f74EzJBh8bntHd0RTdF1fpRDbQwF4UTGmPN0Rt0maoqvWH+S
         uOdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kCvZTNdYEH5Jl0HEt5wKlYnbcTvyEMwjuHluFUKeb/Q=;
        b=BD4bYrxSDkBTJyfESR+xOCx2DKMuyzaFNNpkXrJSQKXql7Fb4wF3D1ccPWds56QA2B
         1OMKAX5nkJjFpcI6/xdV5k5rm+gOP6Vd2g9ZSiRC7ly11kkLFWMNqPPZY+cOn0d6DxiN
         VwL3Kaf54xVfYDv8s7oIXcarbrAjvyndLrfU8QRuQJwlF5FMrgrMu4iR1J51xdt34PBJ
         /6ILSo3/Xw7ZBZ7RB618/MjbJPTZNm/pHL3TyCivat+mEpjTWqd4s6HyHANicitdbwNW
         D08HkrTPcuGtIhpJJvofCUYo8lzfos7JXaSQaT/Ae6eU9V01u01lz3gePK4x3u1nuhgH
         0c/A==
X-Gm-Message-State: AOAM5333X9hYBuGemBrJDMq09QWTnXKzUQoDxTlh8nogXFakQbkg3Xog
        TCruWIdNbZRHtMQ5UeFUx8BajQ==
X-Google-Smtp-Source: ABdhPJzQFnAl1SLEDOoYb4zVkDHREZjwyVNxQW5My6QwUomoZN8IcPzJYua9n15ZiiiW+Da8Mrxx9g==
X-Received: by 2002:a05:6830:2144:: with SMTP id r4mr25797300otd.19.1626885131603;
        Wed, 21 Jul 2021 09:32:11 -0700 (PDT)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id w19sm4682531ooj.39.2021.07.21.09.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 09:32:11 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: [PATCH] phy: qcom-qmp: Fix sc8180x PCIe definition
Date:   Wed, 21 Jul 2021 09:30:29 -0700
Message-Id: <20210721163029.2813497-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A copy paste error was snuck into the patch going upstream that made the
SC8180x PCIe PHY use the SM8250 serdes table, but while this works
there's some differences in the tables (and the SC8180x was left
dangling). So correct the SC8180x definition to use the SC8180x serdes
table.

Fixes: f839f14e24f2 ("phy: qcom-qmp: Add sc8180x PCIe support")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index b2ab20cd8ef5..cb2bf0590991 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -3519,7 +3519,7 @@ static const struct qmp_phy_cfg sc8180x_pciephy_cfg = {
 	.type = PHY_TYPE_PCIE,
 	.nlanes = 1,
 
-	.serdes_tbl		= sm8250_qmp_pcie_serdes_tbl,
+	.serdes_tbl		= sc8180x_qmp_pcie_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(sm8250_qmp_pcie_serdes_tbl),
 	.tx_tbl			= sc8180x_qmp_pcie_tx_tbl,
 	.tx_tbl_num		= ARRAY_SIZE(sc8180x_qmp_pcie_tx_tbl),
-- 
2.29.2

