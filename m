Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 244CA40A3F8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 04:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238100AbhINC5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 22:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238081AbhINC5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 22:57:21 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F527C061762
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 19:56:04 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id q68so11317385pga.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 19:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Dn3xckHSVXxqG47sII5jEqzc6vxhCTbWGe5zWY1u2no=;
        b=JAr+HdDLsqwG1b4VQlMVSfDoeeLd+Ze/oCZkN2jLWc+Mqp63OZoC7P4zLxauacTJIH
         6/lGImirLkQ659hQ+pfxFXLAQZz7LdubpUHB25KYMrUYPmgAijzlOxS0EFt5EOztXXFu
         JGKpjMHSajuBVQ8EKMTDy+zmdwTNAOQ8dyv0wAtxjNPgDMk7K0jxyJBscK1+ylxtj3RS
         3Dx9ksgKIbu1PT7R6E7lDvHg/O7KOEOHnCXUPufe8L9FzJp3c9/4CeQIOXJjlR/0pprZ
         szEZeqRPhHyPqJmfIju8BGVrFTCSn/kNHquDhnCJ44SZ719ErSeUOJWvfHeD5Hde7ByU
         gHRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Dn3xckHSVXxqG47sII5jEqzc6vxhCTbWGe5zWY1u2no=;
        b=DjrzlrWKIqhCo/7/ZHBsy45aaj+S6ZIfdY2cPOjS4HL009rjywFdhhvmu9NFHe4ND6
         Jazhlcdo3uGBNPsU688LhfRldupYd5LA+y/V0NiTCgk9QQftawxbQttdq40jm69wA5A6
         TQFU4gkDnbnpHxMYdBsMJuMnNKVCaDpDBgNoymjFx1EssmMiyAQULpRt0bch4sOpjMUR
         EGp9pQcxIhTA7vs3xP50xNmmZBnndCGXTzbak3FWUX5KK4E/pnmzwsAJBvgGTUhd6Bz1
         j+HFT1iIA2YvRJ3VDITjO8eDJv/lPWg+CfaEYlWVGFpzBMf5mP5qgKM0wu0JoqH/qhYM
         mrow==
X-Gm-Message-State: AOAM530I5vbdGFVX/9TPIscfi8qNzRM52gwpH1czpwPCluV/H3YOtI6P
        SVgrdC9O5F0QAYHL+wsr/KWkEQ==
X-Google-Smtp-Source: ABdhPJzd1G7t0NmUtr9LZzb6c6zGc7P1e8tXFIKnFC8JpVDcFGlLop1cDWW+lULZWvfmLrc5rvR33Q==
X-Received: by 2002:a05:6a00:22cd:b0:43c:9b41:e650 with SMTP id f13-20020a056a0022cd00b0043c9b41e650mr2553141pfj.60.1631588164108;
        Mon, 13 Sep 2021 19:56:04 -0700 (PDT)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id r13sm9622654pgl.90.2021.09.13.19.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 19:56:03 -0700 (PDT)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 1/3] clk: qcom: smd-rpm: Add rate hooks for clk_smd_rpm_branch_ops
Date:   Tue, 14 Sep 2021 10:55:52 +0800
Message-Id: <20210914025554.5686-2-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210914025554.5686-1-shawn.guo@linaro.org>
References: <20210914025554.5686-1-shawn.guo@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On QCM2290 platform, the clock xo_board runs at 38400000, while the
child clock bi_tcxo needs to run at 19200000.  That said,
clk_smd_rpm_branch_ops needs the capability of setting rate. Add rate
hooks into clk_smd_rpm_branch_ops to make it possible.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/clk/qcom/clk-smd-rpm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
index 66d7807ee38e..2380e45b6247 100644
--- a/drivers/clk/qcom/clk-smd-rpm.c
+++ b/drivers/clk/qcom/clk-smd-rpm.c
@@ -416,6 +416,9 @@ static const struct clk_ops clk_smd_rpm_ops = {
 static const struct clk_ops clk_smd_rpm_branch_ops = {
 	.prepare	= clk_smd_rpm_prepare,
 	.unprepare	= clk_smd_rpm_unprepare,
+	.set_rate	= clk_smd_rpm_set_rate,
+	.round_rate	= clk_smd_rpm_round_rate,
+	.recalc_rate	= clk_smd_rpm_recalc_rate,
 };
 
 DEFINE_CLK_SMD_RPM(msm8916, pcnoc_clk, pcnoc_a_clk, QCOM_SMD_RPM_BUS_CLK, 0);
-- 
2.17.1

