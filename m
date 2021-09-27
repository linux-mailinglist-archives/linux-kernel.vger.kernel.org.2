Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7A4418E78
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 06:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbhI0Euw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 00:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232643AbhI0Eut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 00:50:49 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD95C061575
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 21:49:12 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id j15so9478449plh.7
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 21:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yqut9De+8qKtl1UwHb70hm3Lp+Eib/4T+4ZznburE20=;
        b=B+jaGLcWqs5eaW1Zz7HJ5ZpRIcABigLjJ8jgI3gc+6UyUZjhZznJvDGZwWows5qK7f
         cY/lLDnR9u0gryCmklGfZBYrI7DA0WpJeIrw8jHh+0et3FA5mJ8LC31xZR7ioYrI/NUq
         tJ6umUpk+UlGiqx5W3/We8pZNrxG49sAft3lpk83nZXxMtBnyjML+dBv0529ys2RMu8Q
         kKOgczBrg52oLdBTPR4HkyjZQ+UVbbc+mqikypJ9EBAn9wsipLagu2FmLMOU33KKOFr0
         jOZRMvpfhgLTnkcII6Fo+jOEGRFt+8Sua16G5fhS2ehhza9fmiYA6YdAoI/3a0lpSUuG
         OKPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yqut9De+8qKtl1UwHb70hm3Lp+Eib/4T+4ZznburE20=;
        b=Ksb9fv/EuBpttZiU1dlT6PA0ePDqxJhCH1o1ervS9cR/4G74HC+2ER99rsF2kznaEz
         dvt9s4gPzE8lA+KK3uV72AB8DP3wW18Zcrguwjyjbr1js9mhLqdwyEKmze5iQtMd6nDd
         H3gE93JnjylZspk6Ty0aeJBOmaHylyuRSgXrFIQ5kzmrJhipygIL4L3jZEtGc640ZwKG
         nBH8NNwxCo9k1LDNMA0RbRK4scBbCgljaoir6ZAwK4E2cP9rn+wIXHX9SXJTjEyf+Ppr
         v3KNysU40xgzbxCsEmjpHEvmUiE1uEKyt2JkQlB/H9pshVxjYXNcgEsVO6sZwVMhxP/8
         O3MA==
X-Gm-Message-State: AOAM533qOxPDf2btI/jgAfYbivCCxth4ZzrriP1QQCPEBKFNLnpsMLIR
        2S0f1vbR0sOGWoU1fUzY4bOicA==
X-Google-Smtp-Source: ABdhPJzMdnW6OyUR+AHbSPpIu8fhtS0rEKQu96QW1RDDYE24xE1zJyIXGuqw/N9ORjpMtMCsdJWKkg==
X-Received: by 2002:a17:902:d34d:b0:13e:25e6:f732 with SMTP id l13-20020a170902d34d00b0013e25e6f732mr4337542plk.58.1632718151608;
        Sun, 26 Sep 2021 21:49:11 -0700 (PDT)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id o8sm14550651pjh.19.2021.09.26.21.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 21:49:11 -0700 (PDT)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Manu Gautam <mgautam@codeaurora.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Jami Kettunen <jamipkettunen@gmail.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 2/3] phy: qcom-qusb2: Add missing vdd supply
Date:   Mon, 27 Sep 2021 12:48:23 +0800
Message-Id: <20210927044824.30246-3-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210927044824.30246-1-shawn.guo@linaro.org>
References: <20210927044824.30246-1-shawn.guo@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per downstream kernel, beside vdda-pll and vdda-phy-dpdm, vdd is also a
required supply for QUSB2 PHY digital circuit operation.  The driver
works right now likely because firmware already sets it up.  Add it for
correctness and completeness.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qusb2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qusb2.c b/drivers/phy/qualcomm/phy-qcom-qusb2.c
index ae063a8b3e28..7a8e4333babe 100644
--- a/drivers/phy/qualcomm/phy-qcom-qusb2.c
+++ b/drivers/phy/qualcomm/phy-qcom-qusb2.c
@@ -371,7 +371,7 @@ static const struct qusb2_phy_cfg sm6115_phy_cfg = {
 };
 
 static const char * const qusb2_phy_vreg_names[] = {
-	"vdda-pll", "vdda-phy-dpdm",
+	"vdd", "vdda-pll", "vdda-phy-dpdm",
 };
 
 #define QUSB2_NUM_VREGS		ARRAY_SIZE(qusb2_phy_vreg_names)
-- 
2.17.1

