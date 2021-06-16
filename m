Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4FCE3A9D1E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 16:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbhFPONl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 10:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233868AbhFPONe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 10:13:34 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A21FC0617AF
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 07:11:27 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id o3so2870941wri.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 07:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xsn7+Lsp9NGdCiqtkjavVEDgvQSXhZBR2aAMSk2h6M4=;
        b=AnHj7RoSOlzMjAE3O1GUyGBfuS688F5iiC4eV01XSE1Gy+uC5pLxY8uv3b7JlDvLSZ
         ugznEp0TSBKX3aL0tZ71/34ec/JcffIxcCQxJlvvKrwvt5+Ufq++uTbyfGah9gNUlSlL
         WT4YNvtfnwLpUlVyLVlPiLgiW/fAhjHcN4P6v3NqQUa3ymWa0h+j1H0l4dFoGl4vkiwF
         /pIIbUR0H7c3OHOjdBRLNgD4JAnL/QlTNC3d+s3azQNrRY8TDsvBJMoj21oNwsheu/RG
         l6tw3OiFHk1bIrhWohwSEiCTELJRSOyqOF31MshLuE04PNlqf2gI7MdCa+Qw/WfWFphz
         VC8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xsn7+Lsp9NGdCiqtkjavVEDgvQSXhZBR2aAMSk2h6M4=;
        b=FB2gjJdfLNQV7IMwfieGuFwQOZ+1k4fUl8bqSGkHl+iFro6MNYQGyJd6AU8n1uL4pH
         HlUqbVsLjpUjIxm4v3MBfKhU9jDyQJZZ4orp6unIM0ZtnhQZIpBYNGYRefLGvXgWn10V
         vT3mwVsb0bOKxGk0DtCPdSR3pM6Smr9ey2FYjJTLSHnkcwbqaF6GYubu6K78VR61ENK7
         aThxREfOVpTurVfd82fiGdwO5nLqJtq94MMZMD4iZSA+3tbDhW/ir6GiD6d5eoXWR9t+
         Q2loVbxvcSBdHuhRVYlmb5GnNK3n4cKF6YiGs6EU427ds6fDGwWkmXPUSY5yfi5S/oFH
         5O/Q==
X-Gm-Message-State: AOAM532QyRo/qmi6RxVQvI7BgyexRrSbW8EzXJLuD2S27vzETV93Klcg
        Z4tK2K2+9anZrBVd2SKejdQ6Dg==
X-Google-Smtp-Source: ABdhPJzeKOr/2wJKsYjkuqvXZQfV/09Ppyl5Kn6BkkkCEh+gpB2lRge69iJyjFP1rzu8mBE/Wz+UwA==
X-Received: by 2002:a5d:4f8f:: with SMTP id d15mr5576503wru.85.1623852686174;
        Wed, 16 Jun 2021 07:11:26 -0700 (PDT)
Received: from xps7590.fritz.box ([2a02:2454:3e5:b700:9df7:76e5:7e94:bf1e])
        by smtp.gmail.com with ESMTPSA id g83sm1968375wma.10.2021.06.16.07.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 07:11:25 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        jonathan@marek.ca, tdas@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vinod.koul@linaro.org>
Cc:     Robert Foss <robert.foss@linaro.org>
Subject: [RFC v1 04/11] clk: qcom: clk-alpha-pll: Add configuration support for LUCID 5LPE
Date:   Wed, 16 Jun 2021 16:11:00 +0200
Message-Id: <20210616141107.291430-5-robert.foss@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210616141107.291430-1-robert.foss@linaro.org>
References: <20210616141107.291430-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ported from the downstream driver. Used on SM8350 for
DISPCC & VIDEOCC.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
---
 drivers/clk/qcom/clk-alpha-pll.c | 3 +++
 drivers/clk/qcom/clk-alpha-pll.h | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index 01090852ea76..71040d53d7d8 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -115,6 +115,9 @@ const u8 clk_alpha_pll_regs[][PLL_OFF_MAX_REGS] = {
 		[PLL_OFF_STATUS] = 0x30,
 		[PLL_OFF_OPMODE] = 0x38,
 		[PLL_OFF_ALPHA_VAL] = 0x40,
+		[PLL_OFF_SSC_DELTA_ALPHA] = 0x48,
+		[PLL_OFF_SSC_NUM_STEPS] = 0x4c,
+		[PLL_OFF_SSC_UPDATE_RATE] = 0x50,
 	},
 	[CLK_ALPHA_PLL_TYPE_AGERA] =  {
 		[PLL_OFF_L_VAL] = 0x04,
diff --git a/drivers/clk/qcom/clk-alpha-pll.h b/drivers/clk/qcom/clk-alpha-pll.h
index 6943e933be0f..9eb4589b6a02 100644
--- a/drivers/clk/qcom/clk-alpha-pll.h
+++ b/drivers/clk/qcom/clk-alpha-pll.h
@@ -37,6 +37,9 @@ enum {
 	PLL_OFF_OPMODE,
 	PLL_OFF_FRAC,
 	PLL_OFF_CAL_VAL,
+	PLL_OFF_SSC_DELTA_ALPHA,
+	PLL_OFF_SSC_NUM_STEPS,
+	PLL_OFF_SSC_UPDATE_RATE,
 	PLL_OFF_MAX_REGS
 };
 
@@ -158,6 +161,8 @@ void clk_agera_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
 				const struct alpha_pll_config *config);
 #define clk_lucid_pll_configure(pll, regmap, config) \
 	clk_trion_pll_configure(pll, regmap, config)
+#define clk_lucid_5lpe_pll_configure(pll, regmap, config) \
+	clk_trion_pll_configure(pll, regmap, config)
 
 
 
-- 
2.30.2

