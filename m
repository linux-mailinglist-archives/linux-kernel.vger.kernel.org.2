Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 292DC35A039
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 15:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233806AbhDINo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 09:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbhDINoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 09:44:25 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F036C061760
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 06:44:12 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id k25so5959905iob.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 06:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dKNxnFnDqht8/+oHY0ADhH/7JS7Dn6qjf7CJC2LmBq8=;
        b=gsMQK52zs364Cj0XsjgrJO84M/sRi65VAzzWLdQYxlKcNZQAAZzcsyT7B9UpP+QkZX
         0vWxuEK34aPUWCH9i+LGFn39xiP7OC22Io2heYmepQ1aojosF+k3cpmZrUkrooxEyDv9
         OjDzY2Ellot5CcX8xk6cQMTPDvChGr9+CGfjLNtTbD5P40w7DltUHp6Qo8OUkFXVWs5i
         bW1Ybh3odHg1uBDC8NQohJSLbZR1SYL731R9y1PR85Ae0OLKQ3x/zyoiakt1sKjCEL/5
         Mfsxa4e7vqKcN8euT/lMCt/PRer/bGJrI3EdH47UoRsMXD1MOov6vlYYEWWTaBLqF4EF
         HaPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dKNxnFnDqht8/+oHY0ADhH/7JS7Dn6qjf7CJC2LmBq8=;
        b=TB0jjx6WNvzWlLuXIzxyqAJ2m4Yb3KExf8OSNjw3bV/Q8mjBwjjdMi+21W/YAYJomp
         oseOSQuTAafMqVB0+HZYvNZ9bl6qhhObpqmwdaePpo9lLZ96LCicUSvV5S/jiCX1f1xY
         xyBSuHEcXrPcQaq/E5m3MW5GDY5Jh1vVluJ2IKNt4MdODEUymD8LCrosu4pQeH0wA/Qf
         E9aFYBKEWZUpZYZy9QL5EGYilc8u24LNSAfiOriolx/yr7mrMJyeJ5LOSu025hc22jKa
         gdIl6xcWlTFS4CEuyQWTmCzvLlOPmJuDYgdqRHQh30x+JSB5FcQM1etYQAJCUukpAidg
         RwjA==
X-Gm-Message-State: AOAM532oVQAL07JbJZ2EH2mBJSD8P56/mfbMOxt4FXIm9y5JQoRdwb2O
        YTqtX7YtLI4/txkEayPp7gtjMQ==
X-Google-Smtp-Source: ABdhPJypk5ROJa4u/Up63hr16bgFgFFvx1vaDxfvQRO75vqG85ZSYxWW31XgYUSQ3HMnu6+40JP1Cw==
X-Received: by 2002:a5e:de0d:: with SMTP id e13mr11446604iok.208.1617975851998;
        Fri, 09 Apr 2021 06:44:11 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id e6sm1303691iom.2.2021.04.09.06.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 06:44:11 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     bjorn.andersson@linaro.org, agross@kernel.org, sboyd@kernel.org,
        mturquette@baylibre.com, manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: qcom: rpmh: add support for SDX55 rpmh IPA clock
Date:   Fri,  9 Apr 2021 08:44:07 -0500
Message-Id: <20210409134407.841137-1-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IPA core clock is required for SDX55.  Define it.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/clk/qcom/clk-rpmh.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
index c623ce9004063..552d1cbfea4c0 100644
--- a/drivers/clk/qcom/clk-rpmh.c
+++ b/drivers/clk/qcom/clk-rpmh.c
@@ -380,6 +380,7 @@ static const struct clk_rpmh_desc clk_rpmh_sdm845 = {
 DEFINE_CLK_RPMH_VRM(sdx55, rf_clk1, rf_clk1_ao, "rfclkd1", 1);
 DEFINE_CLK_RPMH_VRM(sdx55, rf_clk2, rf_clk2_ao, "rfclkd2", 1);
 DEFINE_CLK_RPMH_BCM(sdx55, qpic_clk, "QP0");
+DEFINE_CLK_RPMH_BCM(sdx55, ipa, "IP0");
 
 static struct clk_hw *sdx55_rpmh_clocks[] = {
 	[RPMH_CXO_CLK]		= &sdm845_bi_tcxo.hw,
@@ -389,6 +390,7 @@ static struct clk_hw *sdx55_rpmh_clocks[] = {
 	[RPMH_RF_CLK2]		= &sdx55_rf_clk2.hw,
 	[RPMH_RF_CLK2_A]	= &sdx55_rf_clk2_ao.hw,
 	[RPMH_QPIC_CLK]		= &sdx55_qpic_clk.hw,
+	[RPMH_IPA_CLK]		= &sdx55_ipa.hw,
 };
 
 static const struct clk_rpmh_desc clk_rpmh_sdx55 = {
-- 
2.27.0

