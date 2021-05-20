Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE3838AE33
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbhETMa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbhETMaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:30:22 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87408C0BC531
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 04:27:31 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id k15so11625217pgb.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 04:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EI+b+kMn2ARemJx1hhgk9qIJtq1SC0cuuSNzLXUaFPU=;
        b=wEs3r0ouOd/lAUnXDP4p7OBpP0bLz2MkWTm9RnzZlvb3k8SlaniCHZou/B6bXLJUou
         qKeY3M0zgjVrJpwjahTjwchGWalIFju0xzY56kl74TMu9iqGooHSCF5NA27x4uQvPOVP
         Tfa5XOlUtD4DY2Kkv2kh/jg3AAQ77lFb8hGMHZiNIpvg0+5mjzRT3QMrqirOLHPqqhMJ
         Af2FbuSoK+fg3oJBYTIRKB0J0q36889Mjh2SK76h9BBsk8e7ZH+kLVF7mcchgIwHk6NZ
         XzonvXOQmj+VYpv6zUhFXZlWwbd4bwSAIO416xqY+BrX8PVpjiTDbxJ0NV4W97uXXAVA
         0+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EI+b+kMn2ARemJx1hhgk9qIJtq1SC0cuuSNzLXUaFPU=;
        b=eLJT7QkQaa8WGwiG1YDCq55BszoAG/+i+3tMUr7oi+C92gFefv3GD83ZUPvI+40xPh
         pryqI3VXsrinvZhd9uTH97lwuDbnf3DuMAW6UoR6u4xCBAXYJrAvS/C8loBLYedofbMO
         AOEwg94B+MnmNrLYftaMKXDcax0zkkC+J/GRssuUbLxpNzg2dOSyYFR1aSi87Ah+lvo5
         bF6MuAKiH/nQGQcr4+CPDaiejmJ43ZyDfmcDCDQqai6IluIFiXLFu8r3S82YbtXlJlJt
         89yeBDzwiu7jr2SLJQUGyiYiajJgijLqMWXUQGOUmza62/vfdwiMcq25dxPaMM2d2VUw
         +rtA==
X-Gm-Message-State: AOAM530QXDdkPNj7OccR3km+XldZLulnmQHrQPWlWxmNAIwhDHcTRi+9
        N5n+7qkfyg2QBQHoOv7JMhz4yA==
X-Google-Smtp-Source: ABdhPJzi22tlm64GcJo2fMw+xKw/F1NYXPw6xHE6ogmaJWAYectx12vaeq1PQkxYmLRC26QlSy5QlA==
X-Received: by 2002:a63:df53:: with SMTP id h19mr4143142pgj.20.1621510050930;
        Thu, 20 May 2021 04:27:30 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id d3sm6232477pjw.35.2021.05.20.04.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 04:27:30 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vladimir Lypak <junak.pub@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: qcom_smd: Make pm8953_lnldo linear_ranges entries properly sorted
Date:   Thu, 20 May 2021 19:27:19 +0800
Message-Id: <20210520112719.1814396-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For better readability, make linear_ranges entries sort by selector.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/qcom_smd-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/qcom_smd-regulator.c b/drivers/regulator/qcom_smd-regulator.c
index 05df7b00e3b1..198fcc6551f6 100644
--- a/drivers/regulator/qcom_smd-regulator.c
+++ b/drivers/regulator/qcom_smd-regulator.c
@@ -449,8 +449,8 @@ static const struct regulator_desc pm8950_pldo = {
 
 static const struct regulator_desc pm8953_lnldo = {
 	.linear_ranges = (struct linear_range[]) {
-		REGULATOR_LINEAR_RANGE(1380000, 8, 15, 120000),
 		REGULATOR_LINEAR_RANGE(690000, 0, 7, 60000),
+		REGULATOR_LINEAR_RANGE(1380000, 8, 15, 120000),
 	},
 	.n_linear_ranges = 2,
 	.n_voltages = 16,
-- 
2.25.1

